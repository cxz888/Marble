mod config;
mod database;
mod handlers;
mod jwt;

use anyhow::Result;
use axum::{
    error_handling::HandleErrorLayer,
    extract::Extension,
    http::StatusCode,
    routing::{get, post},
    BoxError, Router,
};
use std::{net::SocketAddr, str::FromStr, sync::Arc, time::Duration};
use tower::ServiceBuilder;
use tower_http::{cors::CorsLayer, trace::TraceLayer};
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

use crate::{
    config::AppConfig,
    handlers::{pages, posts, users},
};

#[tokio::main]
async fn main() -> Result<()> {
    let config = AppConfig::init()?;
    let jwt_service = Arc::new(jwt::JwtService::new(&config));

    tracing_subscriber::registry()
        .with(tracing_subscriber::EnvFilter::new(
            std::env::var("RUST_LOG")
                .unwrap_or_else(|_| "marble_back=debug,tower_http=debug".into()),
        ))
        .with(tracing_subscriber::fmt::layer())
        .init();

    tracing::info!("Loaded config, initializing database...");

    let pool = database::init_db_pool(&config).await?;

    let app = Router::new()
        .route("/api/users/signin", post(users::user_signin))
        .route("/api/home", get(pages::home).patch(pages::home_update))
        .route("/api/about", get(pages::about).patch(pages::about_update))
        .route(
            "/api/friends",
            get(pages::friends).patch(pages::friends_update),
        )
        .route("/api/posts", get(posts::post_list).post(posts::post_create))
        .route(
            "/api/posts/:id",
            get(posts::post_content)
                .delete(posts::post_delete)
                .patch(posts::post_update),
        )
        .layer(CorsLayer::permissive().allow_origin([config.frontend_addr.parse().unwrap()]))
        .layer(
            ServiceBuilder::new()
                .layer(HandleErrorLayer::new(|error: BoxError| async move {
                    if error.is::<tower::timeout::error::Elapsed>() {
                        Ok(StatusCode::REQUEST_TIMEOUT)
                    } else {
                        Err((
                            StatusCode::INTERNAL_SERVER_ERROR,
                            "Unhandled internal error".to_string(),
                        ))
                    }
                }))
                .timeout(Duration::from_secs(10))
                .layer(TraceLayer::new_for_http())
                .layer(Extension(pool))
                .layer(Extension(jwt_service))
                .into_inner(),
        );
    let addr = SocketAddr::from_str(&config.backend_addr)?;
    tracing::info!("listening on http://{}", addr);

    axum::Server::bind(&addr)
        .serve(app.into_make_service())
        .await
        .unwrap();

    Ok(())
}
