use anyhow::{Context, Result};
use sqlx::{FromRow, MySqlPool};
use time::{macros::offset, PrimitiveDateTime};

#[derive(FromRow)]
pub struct UserEntity {
    pub u_id: i32,
    pub u_name: Option<String>,
    pub u_password: Option<String>,
}

impl UserEntity {
    pub async fn by_name(pool: &MySqlPool, name: &str) -> Result<Option<UserEntity>> {
        sqlx::query_as(
            "SELECT u_id, u_name, u_password FROM users
                    WHERE u_name = ?;",
        )
        .bind(name)
        .fetch_optional(pool)
        .await
        .context("An unexpected error occured while search for users")
    }
}

#[derive(FromRow)]
pub struct PostInfo {
    pub p_id: i32,
    pub p_title: String,
    pub p_time: time::PrimitiveDateTime,
}

impl PostInfo {
    /// 返回按时间由新到旧的文章列表
    pub async fn postlist(pool: &MySqlPool) -> Result<Vec<PostInfo>> {
        sqlx::query_as("SELECT p_id, p_title, p_time FROM posts ORDER BY p_time DESC;")
            .fetch_all(pool)
            .await
            .context("An unexpected error occured while search for users")
    }
}

#[derive(FromRow)]
pub struct PostContent {
    pub p_content: String,
}

impl PostContent {
    pub async fn by_id(pool: &MySqlPool, p_id: i32) -> Result<Option<PostContent>> {
        sqlx::query_as("SELECT p_content FROM posts WHERE p_id=?;")
            .bind(p_id)
            .fetch_optional(pool)
            .await
            .context("An unexpected error occured while search for users")
    }
}

pub async fn create_post(pool: &MySqlPool, title: &str, content: &str) -> Result<()> {
    let time = time::OffsetDateTime::now_utc().to_offset(offset!(+8));
    let time = PrimitiveDateTime::new(time.date(), time.time());
    sqlx::query("INSERT INTO posts VALUES(0,?,?,?)")
        .bind(title)
        .bind(content)
        .bind(time)
        .execute(pool)
        .await
        .context("An unexpected error occured while create post")?;
    Ok(())
}

pub async fn delete_post(pool: &MySqlPool, id: i32) -> Result<()> {
    sqlx::query("DELETE FROM posts WHERE p_id=?")
        .bind(id)
        .execute(pool)
        .await
        .context("An unexpected error occured while create post")?;
    Ok(())
}

pub async fn update_post(pool: &MySqlPool, id: i32, title: &str, content: &str) -> Result<()> {
    sqlx::query("UPDATE posts SET p_title=?, p_content=? WHERE p_id=?")
        .bind(title)
        .bind(content)
        .bind(id)
        .execute(pool)
        .await
        .context("An unexpected error occured while create post")?;
    Ok(())
}

#[derive(FromRow)]
pub struct Page {
    pub pg_content: String,
}

impl Page {
    pub async fn by_id(pool: &MySqlPool, pg_id: i32) -> Result<Option<Page>> {
        sqlx::query_as("SELECT pg_content FROM pages WHERE pg_id=?;")
            .bind(pg_id)
            .fetch_optional(pool)
            .await
            .context("An unexpected error occured while search for users")
    }
    pub async fn update_by_id(pool: &MySqlPool, pg_id: i32, new_content: &str) -> Result<()> {
        sqlx::query("UPDATE pages SET pg_content=? WHERE pg_id=?;")
            .bind(new_content)
            .bind(pg_id)
            .execute(pool)
            .await
            .context("An unexpected error occured while search for users")?;
        Ok(())
    }
}
