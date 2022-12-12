use anyhow::Result;
use serde::Deserialize;

#[derive(Deserialize)]
pub struct AppConfig {
    pub jwt_secret: String,
    pub database_url: String,
    pub max_connection: u32,
    pub frontend_addr: String,
    pub backend_addr: String,
}

impl AppConfig {
    pub fn init() -> Result<Self> {
        dotenvy::dotenv()?;
        let cfg = config::Config::builder()
            .add_source(config::Environment::default())
            .build()?;
        Ok(cfg.try_deserialize()?)
    }
}
