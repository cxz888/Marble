import { createApp } from "vue";
import { createRouter, createWebHistory } from "vue-router";
import App from "./App.vue";
import { routes } from "./lib/routes";
import ElementPlus from "element-plus";
import * as ElementPlusIconsVue from "@element-plus/icons-vue";

import "./assets/style.css";
import "element-plus/dist/index.css";
import "element-plus/theme-chalk/dark/css-vars.css";
import "./assets/variable.css";
import "font-awesome/css/font-awesome.min.css";

const router = createRouter({
    history: createWebHistory(),
    routes: routes,
});

const app = createApp(App);
for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
    app.component(key, component);
}
app.use(router).use(ElementPlus, { size: "small", zIndex: 3000 }).mount("#app");
