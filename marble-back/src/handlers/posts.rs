use crate::{
    database::dao::{self, create_post, delete_post, update_post, PostContent},
    jwt::RequiredAuthentication,
};
use axum::{extract::Path, http::StatusCode, response::IntoResponse, Extension, Json};
use serde::{Deserialize, Serialize};
use sqlx::MySqlPool;
use time::macros::format_description;

#[derive(Serialize)]
pub struct PostInfo {
    name: String,
    date: String,
    id: i32,
}

pub async fn post_list(
    Extension(pool): Extension<MySqlPool>,
) -> Result<Json<Vec<PostInfo>>, StatusCode> {
    tracing::info!("request postlist");
    let friends = dao::PostInfo::postlist(&pool).await.map_err(|e| {
        tracing::error!("{e}");
        StatusCode::INTERNAL_SERVER_ERROR
    })?;
    let format = format_description!("[year padding:zero]-[month]-[day]");
    Ok(Json(
        friends
            .into_iter()
            .map(|post_info| {
                Ok(PostInfo {
                    name: post_info.p_title,
                    date: post_info.p_time.format(format).map_err(|_| {
                        tracing::error!("Format time error: {}", post_info.p_time);
                        StatusCode::INTERNAL_SERVER_ERROR
                    })?,
                    id: post_info.p_id,
                })
            })
            .collect::<Result<Vec<_>, StatusCode>>()?,
    ))
}

pub async fn post_content(
    Path(id): Path<i32>,
    Extension(pool): Extension<MySqlPool>,
) -> Result<String, StatusCode> {
    tracing::info!("request post_{id} content");
    PostContent::by_id(&pool, id)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?
        .ok_or(StatusCode::NOT_FOUND)
        .map(|content| content.p_content)
}

#[derive(Deserialize)]
pub struct PostCreate {
    title: String,
    content: String,
}

pub async fn post_create(
    Json(input): Json<PostCreate>,
    RequiredAuthentication(_): RequiredAuthentication,
    Extension(pool): Extension<MySqlPool>,
) -> impl IntoResponse {
    tracing::info!("create post");
    if let Ok(_) = create_post(&pool, &input.title, &input.content).await {
        StatusCode::OK
    } else {
        StatusCode::INTERNAL_SERVER_ERROR
    }
}

pub async fn post_delete(
    Path(id): Path<i32>,
    RequiredAuthentication(_): RequiredAuthentication,
    Extension(pool): Extension<MySqlPool>,
) -> impl IntoResponse {
    tracing::info!("delete post");
    if let Ok(_) = delete_post(&pool, id).await {
        StatusCode::OK
    } else {
        StatusCode::INTERNAL_SERVER_ERROR
    }
}

#[derive(Deserialize)]
pub struct PostUpdate {
    title: String,
    content: String,
}

pub async fn post_update(
    Path(id): Path<i32>,
    Json(input): Json<PostUpdate>,
    RequiredAuthentication(_): RequiredAuthentication,
    Extension(pool): Extension<MySqlPool>,
) -> impl IntoResponse {
    tracing::info!("update post_{}: {}", id, input.title);
    if let Ok(_) = update_post(&pool, id, &input.title, &input.content).await {
        StatusCode::OK
    } else {
        StatusCode::INTERNAL_SERVER_ERROR
    }
}
