<script setup lang="ts">
import { State } from "@/lib/md-editor";
import { postsService } from "@/lib/services/posts";
import { useCssVar } from "@vueuse/core";
import { ElMessage } from "element-plus";
import MdEditor, { HeadList } from "md-editor-v3";
import { inject, onBeforeMount, ref, Ref } from "vue";
import { useRoute, useRouter } from "vue-router";

interface Tree {
    name: string;
    children: Tree[];
}

const defaultProps = {
    label: "name",
    children: "children",
};

const catalog = ref<Tree[]>([{ name: "目录", children: [] }]);
const title = ref("");
const onGetCatalog = (list: HeadList[]) => {
    let stack: Tree[] = [{ name: "目录", children: [] }];
    for (let item of list) {
        while (item.level < stack.length) {
            stack.pop();
        }
        stack.push({ name: item.text, children: [] });
        stack[stack.length - 2].children.push(stack[stack.length - 1]);
    }
    catalog.value = [stack[0]];
};
const onUpdateGetCatalog = (list: HeadList[]) => {
    if (list.length > 0 && list[0].level == 1) {
        title.value = list[0].text;
    }
};

const deleteFormVisible = ref(false);
const state = inject("previewOnlyState") as Ref<State>;

const isEditing = ref(false);
const buttonText = ref("编辑文章");
const flipMode = () => {
    if (isEditing.value) {
        isEditing.value = false;
        buttonText.value = "编辑文章";
    } else {
        isEditing.value = true;
        buttonText.value = "浏览文章";
    }
};
const route = useRoute();
const isLoading = ref(false);
onBeforeMount(async () => {
    state.value.text = "";
    isLoading.value = true;
    const id = Number(route.params.id);
    const postContent = await postsService.getPost(Number(id));
    if (postContent != null) {
        state.value.text = postContent;
    } else {
        console.log("INTERNAL ERROR");
    }
    isLoading.value = false;
});
const router = useRouter();
const onDeletePost = async () => {
    const id = Number(route.params.id);
    if ((await postsService.deletePost(id)) != null) {
        router.push("/");
        ElMessage.success("删除成功");
    } else {
        ElMessage.error("内部错误");
    }
};
const onUpdatePost = async () => {
    const id = Number(route.params.id);
    if ((await postsService.updatePost(id, title.value, state.value.text)) != null) {
        flipMode();
        ElMessage.success("更新成功");
    } else {
        console.log("INTERNAL ERROR");
    }
};
const color = useCssVar("--el-bg-color", ref(null));
const userJwt = inject("userJwt") as Ref<string | null>;
</script>

<template>
    <el-container v-loading="isLoading" :element-loading-background="color">
        <el-aside width="20%"></el-aside>
        <el-main>
            <md-editor
                v-if="!isEditing"
                preview-only
                v-model="state.text"
                @on-get-catalog="onGetCatalog"
                :editor-id="state.id"
                :theme="state.theme"
                :preview-theme="state.previewTheme"
            />
            <md-editor
                v-if="isEditing"
                v-model="state.text"
                @on-get-catalog="onUpdateGetCatalog"
                :editor-id="state.id"
                :theme="state.theme"
                :preview-theme="state.previewTheme"
            />
        </el-main>
        <el-aside width="20%">
            <el-affix :offset="80" v-if="userJwt != null">
                <el-button size="default" @click="flipMode">{{ buttonText }}</el-button>
                <el-button size="default" v-if="isEditing" @click="onUpdatePost">保存修改</el-button>
                <br />
                <el-button size="default" @click="deleteFormVisible = true">删除文章</el-button>
            </el-affix>
            <el-dialog v-model="deleteFormVisible" width="240px" title="删除文章">
                <span>确认删除本文章吗？</span>
                <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="deleteFormVisible = false" size="default">取消</el-button>
                        <el-button type="primary" @click="onDeletePost" size="default">确定</el-button>
                    </span>
                </template>
            </el-dialog>
            <el-affix :offset="160" v-if="!isEditing">
                <el-tree :data="catalog" :props="defaultProps" default-expand-all :expand-on-click-node="false">
                    <template #default="{ node }">
                        <span class="custom-tree-node">
                            <span v-if="node.level == 1" class="h0">{{ node.label }}</span>
                            <a :href="'#' + node.label" v-if="node.level != 1">{{ node.label }}</a>
                        </span>
                    </template>
                </el-tree>
            </el-affix>
        </el-aside>
    </el-container>
</template>

<style scoped>
span.h0 {
    font-size: 20pt;
}
.el-tree {
    background-color: var(--el-bg-color);
}
</style>
