<script setup lang="ts">
import { postsService } from "@/lib/services/posts";
import { PostInfo } from "@/lib/types";
import { useCssVar } from "@vueuse/core";
import { onBeforeMount, ref } from "vue";

const posts = ref<PostInfo[]>([]);
const isLoading = ref(false);
onBeforeMount(async () => {
    posts.value = [];
    isLoading.value = true;
    const postlist = await postsService.getPostList();
    if (postlist != null) {
        posts.value = postlist;
    } else {
        console.log("INTERNAL ERROR");
    }
    isLoading.value = false;
});
const color = useCssVar("--el-bg-color", ref(null));
</script>

<template>
    <el-container v-loading="isLoading" :element-loading-background="color">
        <el-aside width="20%"></el-aside>
        <el-main>
            <el-timeline>
                <el-timeline-item v-for="post in posts" :timestamp="post.date" placement="top">
                    <router-link :to="'/posts/' + post.id">{{ post.name }}</router-link>
                </el-timeline-item>
            </el-timeline>
        </el-main>
        <el-aside width="20%"> </el-aside>
    </el-container>
</template>

<style scoped></style>
