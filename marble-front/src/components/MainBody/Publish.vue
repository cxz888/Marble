<script setup lang="ts">
import { onBeforeMount, ref } from "vue";
import MdEditor, { HeadList } from "md-editor-v3";

import "md-editor-v3/lib/style.css";
import bus from "@/lib/bus";
import { State } from "@/lib/md-editor";
import { ElMessage } from "element-plus";
import { postsService } from "@/lib/services/posts";
import { useRouter } from "vue-router";

const state = ref<State>({
    text: "",
    theme: "dark",
    id: "editor-edit",
    previewTheme: "github",
});
const title = ref("");

onBeforeMount(() => {
    if (localStorage.getItem("theme") == "light") {
        state.value.theme = "light";
    }
});

function changeTheme(dark: boolean) {
    if (dark) {
        state.value.theme = "dark";
    } else {
        state.value.theme = "light";
    }
}
const onGetCatalog = (list: HeadList[]) => {
    if (list.length > 0 && list[0].level == 1) {
        title.value = list[0].text;
    }
};
const router = useRouter();
const onPublishPost = async () => {
    if (title.value.length == 0) {
        ElMessage("文章需要有一个标题");
        return;
    }
    if ((await postsService.createPost(title.value, state.value.text)) != null) {
        ElMessage("文章发布成功");
        router.push({ path: "/" });
    } else {
        ElMessage("文章创建失败");
    }
};
bus.on("changeTheme", changeTheme);
</script>

<template>
    <el-container>
        <el-aside width="20%"></el-aside>
        <el-main>
            <el-tooltip class="box-item" effect="dark" content="Markdown 的一级标题作为文章标题" placement="top">
                <el-card>标题：{{ title }}</el-card>
            </el-tooltip>
            <md-editor
                v-model="state.text"
                :editorId="state.id"
                @on-get-catalog="onGetCatalog"
                :theme="state.theme"
                :preview-theme="state.previewTheme"
            />
        </el-main>
        <el-aside width="20%">
            <el-affix :offset="90">
                <el-button size="default" type="primary" @click="onPublishPost">确定发布</el-button>
            </el-affix>
        </el-aside>
    </el-container>
</template>

<style scoped>
.el-card {
    --el-card-bg-color: var(--el-bg-color);
}
</style>
