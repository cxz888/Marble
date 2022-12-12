import apiClient from "../api";
import { AxiosResponse } from "axios";
import { PostCreate, PostInfo, PostUpdate } from "../types";

class PostsService {
    async getPostList(): Promise<PostInfo[] | null> {
        try {
            const response: AxiosResponse<PostInfo[], any> = await apiClient.get("/posts");
            return response.data;
        } catch (_) {
            return null;
        }
    }
    async getPost(id: number): Promise<string | null> {
        try {
            const response: AxiosResponse<string, any> = await apiClient.get("/posts/" + id);
            return response.data;
        } catch (_) {
            return null;
        }
    }
    async createPost(title: string, content: string) {
        const userJwt = localStorage.getItem("userJwt");
        try {
            const response: AxiosResponse<void, any> = await apiClient.post("/posts", new PostCreate(title, content), {
                headers: {
                    Authorization: "Token " + userJwt,
                },
            });
            return response.data;
        } catch (_) {
            return null;
        }
    }
    async deletePost(id: number) {
        const userJwt = localStorage.getItem("userJwt");
        try {
            const response: AxiosResponse<void, any> = await apiClient.delete("/posts/" + id, {
                headers: {
                    Authorization: "Token " + userJwt,
                },
            });
            return response.data;
        } catch (_) {
            return null;
        }
    }
    async updatePost(id: number, title: string, content: string) {
        const userJwt = localStorage.getItem("userJwt");
        try {
            const response: AxiosResponse<void, any> = await apiClient.patch(
                "/posts/" + id,
                new PostUpdate(title, content),
                {
                    headers: {
                        Authorization: "Token " + userJwt,
                    },
                }
            );
            return response.data;
        } catch (_) {
            return null;
        }
    }
}

export let postsService = new PostsService();
