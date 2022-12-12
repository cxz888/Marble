use axum::{http::StatusCode, response::IntoResponse, Extension, Json};
use serde::Deserialize;
use sqlx::MySqlPool;

use crate::{database::dao::Page, jwt::RequiredAuthentication};

#[derive(Deserialize)]
pub struct PageUpdate {
    content: String,
}

const HOME_PAGE_ID: i32 = 1;
pub async fn home(Extension(pool): Extension<MySqlPool>) -> Result<String, StatusCode> {
    tracing::info!("request home");
    Page::by_id(&pool, HOME_PAGE_ID)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR) // 主页的 id 应当固定，如果查不到则数据库组织有错误
        .map(|content| content.pg_content)
}
pub async fn home_update(
    Json(input): Json<PageUpdate>,
    RequiredAuthentication(_): RequiredAuthentication,
    Extension(pool): Extension<MySqlPool>,
) -> impl IntoResponse {
    tracing::info!("update home");
    if let Err(e) = Page::update_by_id(&pool, HOME_PAGE_ID, &input.content).await {
        tracing::error!("Internal error: {}", e);
        StatusCode::INTERNAL_SERVER_ERROR
    } else {
        StatusCode::OK
    }
}

const ABOUT_PAGE_ID: i32 = 2;
pub async fn about(Extension(pool): Extension<MySqlPool>) -> Result<String, StatusCode> {
    tracing::info!("request about");
    Page::by_id(&pool, ABOUT_PAGE_ID)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR) // 关于页的 id 应当固定，如果查不到则数据库组织有错误
        .map(|content| content.pg_content)
}

pub async fn about_update(
    Json(input): Json<PageUpdate>,
    RequiredAuthentication(_): RequiredAuthentication,
    Extension(pool): Extension<MySqlPool>,
) -> impl IntoResponse {
    tracing::info!("update about");
    if let Err(e) = Page::update_by_id(&pool, ABOUT_PAGE_ID, &input.content).await {
        tracing::error!("Internal error: {}", e);
        StatusCode::INTERNAL_SERVER_ERROR
    } else {
        StatusCode::OK
    }
}

const FRIENDS_PAGE_ID: i32 = 3;
pub async fn friends(Extension(pool): Extension<MySqlPool>) -> Result<String, StatusCode> {
    tracing::info!("request friends");
    Page::by_id(&pool, FRIENDS_PAGE_ID)
        .await
        .map_err(|_| StatusCode::INTERNAL_SERVER_ERROR)?
        .ok_or(StatusCode::INTERNAL_SERVER_ERROR) // 友链页的 id 应当固定，如果查不到则数据库组织有错误
        .map(|content| content.pg_content)
}
pub async fn friends_update(
    Json(input): Json<PageUpdate>,
    RequiredAuthentication(_): RequiredAuthentication,
    Extension(pool): Extension<MySqlPool>,
) -> impl IntoResponse {
    tracing::info!("update friends");
    if let Err(e) = Page::update_by_id(&pool, FRIENDS_PAGE_ID, &input.content).await {
        tracing::error!("Internal error: {}", e);
        StatusCode::INTERNAL_SERVER_ERROR
    } else {
        StatusCode::OK
    }
}
