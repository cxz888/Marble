import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import { resolve } from "path";

// https://vitejs.dev/config/
export default defineConfig({
    plugins: [vue()],
    resolve: {
        alias: {
            "@": resolve(__dirname, "./src/"),
        },
    },
    server: {
        port: 5000,
        proxy: {
            "/api": {
                target: "http://127.0.0.1:4000",
                changeOrigin: true,
            },
        },
    },
});
