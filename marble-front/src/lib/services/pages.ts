import apiClient from "../api";
import { AxiosResponse } from "axios";
import { PageUpdate } from "../types";

class PageService {
    async getPage(page: string): Promise<string | null> {
        try {
            const response: AxiosResponse<string, any> = await apiClient.get("/" + page);
            return response.data;
        } catch (_) {
            return null;
        }
    }
    async updatePage(page: string, content: string): Promise<void | null> {
        const userJwt = localStorage.getItem("userJwt");
        try {
            const response: AxiosResponse<void, any> = await apiClient.patch("/" + page, new PageUpdate(content), {
                headers: {
                    Authorization: "Token " + userJwt,
                },
            });
            return response.data;
        } catch (_) {
            return null;
        }
    }
}

export let pageService = new PageService();
