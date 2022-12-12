# marble-back

采用 Axum 框架完成的后端部分，通过 sqlx 访问 MySQL 数据库。

## API

以下 API 中，带有 🔑 的代表需要验证

### 登录

`POST /api/users/signin`

请求格式：

```json
{
    "username": "blogadmin",
    "password": "123456"
}
```

返回 jwt，用于之后的验证

### 获取文章列表

获取文章列表，按照时间顺序降序排序

`GET /api/posts`

返回格式：

```json
[
    {
        "name": "Linux 通过 gogs 或 gitea 自建 Git 服务",
        "date": "2022-12-8",
        "id": 2
    },
    {
        "name": "test",
        "date": "2022-10-2",
        "id": 1
    }
]
```

### 获取文章内容

`GET /api/posts/:id` 获取文章内容。

返回字符串，代表文章的 md 格式文本。

### 创建文章 🔑

`POST /api/posts`

请求格式：

```json
{
    "title": "测试文章 1",
    "content": "# 测试文章 1"
}
```

### 删除文章 🔑

`DELETE /api/posts/:id`

### 修改文章 🔑

`PATCH /api/posts/:id`

请求格式：

```json
{
    "title": "修改测试",
    "content": "# 修改测试"
}
```

### 获取「主页」内容

`GET /api/home` 获取「主页」内容。

返回字符串，代表「主页」的 md 格式文本。

### 修改「主页」内容 🔑

`PATCH /api/home` 修改「主页」内容。

请求格式：

```json
{
    "content": "# 修改测试"
}
```

### 获取「关于」内容

`GET /api/about` 获取「关于」内容。

返回字符串，代表「关于」的 md 格式文本。

### 修改「关于」内容 🔑

`PATCH /api/about` 修改「关于」内容。

请求格式：

```json
{
    "content": "# 修改测试"
}
```

### 获取「友链」内容

`GET /api/friends` 获取「友链」内容。

返回字符串，代表「友链」的 md 格式文本。

### 修改「友链」内容 🔑

`PATCH /api/friends` 修改「友链」内容。

请求格式：

```json
{
    "content": "# 修改测试"
}
```
