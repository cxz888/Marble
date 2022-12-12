use std::sync::Arc;

use anyhow::Result;
use axum::{
    async_trait,
    extract::{FromRequest, RequestParts},
    http::{header::AUTHORIZATION, StatusCode},
    Extension,
};
use jsonwebtoken::{decode, encode, DecodingKey, EncodingKey, Header, Validation};
use serde::{Deserialize, Serialize};

use crate::config::AppConfig;

#[derive(Debug, Serialize, Deserialize)]
pub struct Claims {
    uid: i32,
    sub: String,
    exp: usize,
}

pub struct JwtService {
    encoding_key: EncodingKey,
    decoding_key: DecodingKey,
}

impl JwtService {
    pub fn new(config: &AppConfig) -> Self {
        Self {
            encoding_key: EncodingKey::from_secret(config.jwt_secret.as_bytes()),
            decoding_key: DecodingKey::from_secret(config.jwt_secret.as_bytes()),
        }
    }
    pub fn new_token(&self, uid: i32, username: &str) -> Result<String> {
        let expired_future_time = time::OffsetDateTime::now_utc() + time::Duration::hours(12);
        let exp = expired_future_time.unix_timestamp() as usize;
        let claims = Claims {
            uid,
            sub: username.to_string(),
            exp,
        };
        let token = encode(&Header::default(), &claims, &self.encoding_key)?;
        Ok(token)
    }
    pub fn authorize(&self, token: &str) -> Result<i32, StatusCode> {
        let decoded_token = decode::<Claims>(
            &token,
            &self.decoding_key,
            &Validation::new(jsonwebtoken::Algorithm::HS256),
        )
        .map_err(|_| StatusCode::UNAUTHORIZED)?;
        Ok(decoded_token.claims.uid)
    }
}

/// Extracts the JWT from the Authorization token header.
pub struct RequiredAuthentication(pub i32);

#[async_trait]
impl<B> FromRequest<B> for RequiredAuthentication
where
    B: Send,
{
    // TODO: Rejection 重构
    type Rejection = StatusCode;
    async fn from_request(request: &mut RequestParts<B>) -> Result<Self, Self::Rejection> {
        let Extension(jwt_service): Extension<Arc<JwtService>> = Extension::from_request(request)
            .await
            .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?;

        if let Some(authorization_header) = request.headers().get(AUTHORIZATION) {
            let header_value = authorization_header
                .to_str()
                .map_err(|_| StatusCode::BAD_REQUEST)?;

            if !header_value.contains("Token") {
                return Err(StatusCode::BAD_REQUEST);
            }

            let tokenized_value: Vec<_> = header_value.split(' ').collect();

            if tokenized_value.len() != 2 || tokenized_value.get(1).is_none() {
                return Err(StatusCode::BAD_REQUEST);
            }

            let token_value = tokenized_value.into_iter().nth(1).unwrap();
            let user_id = jwt_service.authorize(&token_value)?;
            Ok(RequiredAuthentication(user_id))
        } else {
            Err(StatusCode::UNAUTHORIZED)
        }
    }
}
