pub mod dao;

use anyhow::Result;
use sqlx::{mysql::MySqlPoolOptions, MySqlPool};

use crate::config::AppConfig;

pub async fn init_db_pool(config: &AppConfig) -> Result<MySqlPool> {
    Ok(MySqlPoolOptions::new()
        .max_connections(config.max_connection)
        .connect(&config.database_url)
        .await?)
}
