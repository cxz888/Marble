import apiClient from "../api";
import { AxiosResponse } from "axios";
import { UserSignin } from "../types";

class UsersService {
    async signin(userSignin: UserSignin): Promise<string | null> {
        try {
            const response: AxiosResponse<string, any> = await apiClient.post("/users/signin", userSignin);
            return response.data;
        } catch (_) {
            return null;
        }
    }
}

export let usersService = new UsersService();
