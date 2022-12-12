<script setup lang="ts">
import Navigator from "./components/Navigator.vue";
import Footer from "./components/Footer.vue";
import { provide, ref } from "vue";
import { previewOnlyState, State } from "@/lib/md-editor";
import { RouterView } from "vue-router";
import bus from "./lib/bus";

const state = ref<State>(previewOnlyState());
provide("previewOnlyState", state);
const userJwt = ref(localStorage.getItem("userJwt"));
provide("userJwt", userJwt);

function changeTheme(dark: boolean) {
    if (dark) {
        state.value.theme = "dark";
    } else {
        state.value.theme = "light";
    }
}

bus.on("changeTheme", changeTheme);
</script>

<template>
    <Navigator />
    <router-view></router-view>
    <Footer />
</template>

<style scoped></style>
