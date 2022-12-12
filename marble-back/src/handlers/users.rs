use std::sync::Arc;

use axum::{http::StatusCode, Extension, Json};
use serde::Deserialize;
use sqlx::MySqlPool;

use crate::{database::dao::UserEntity, jwt::JwtService};

#[derive(Deserialize)]
pub struct UserSignin {
    username: String,
    password: String,
}

pub async fn user_signin(
    Json(input): Json<UserSignin>,
    Extension(pool): Extension<MySqlPool>,
    Extension(jwt_service): Extension<Arc<JwtService>>,
) -> Result<String, StatusCode> {
    tracing::info!(
        "request signin with input: {},{}",
        input.username,
        input.password
    );
    let user = UserEntity::by_name(&pool, &input.username)
        .await
        .map_err(|e| {
            tracing::error!("{e}");
            StatusCode::INTERNAL_SERVER_ERROR
        })?
        .ok_or(StatusCode::UNAUTHORIZED)?;
    if user.u_password != Some(input.password) {
        return Err(StatusCode::UNAUTHORIZED);
    }
    if let Some(username) = user.u_name {
        tracing::info!("generate jwt token for {}", username,);
        jwt_service
            .new_token(user.u_id, &username)
            .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)
    } else {
        Err(StatusCode::UNAUTHORIZED)
    }
}
