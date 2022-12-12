<script setup lang="ts">
import { State } from "@/lib/md-editor";
import { ElContainer, ElAside, ElMain, ElMessage } from "element-plus";
import { inject, onBeforeMount, ref, Ref } from "vue";
import MdEditor from "md-editor-v3";
import { pageService } from "@/lib/services/pages";
import { useCssVar } from "@vueuse/core";
import { getPageName } from "@/lib/pagename";

const props = defineProps<{ page: string }>();
const state = inject("previewOnlyState") as Ref<State>;
const isLoading = ref(false);
onBeforeMount(async () => {
    isLoading.value = true;
    state.value.text = "";
    const content = await pageService.getPage(props.page);
    if (content != null) {
        state.value.text = content;
    } else {
        ElMessage.error("内部错误");
    }
    isLoading.value = false;
});
const pageName = getPageName(props.page);
const isEditing = ref(false);
const buttonText = ref(`编辑「${pageName}」`);
const flipMode = () => {
    if (isEditing.value) {
        isEditing.value = false;
        buttonText.value = `编辑「${pageName}」`;
    } else {
        isEditing.value = true;
        buttonText.value = `浏览「${pageName}」`;
    }
};
const color = useCssVar("--el-bg-color", ref(null));
const userJwt = inject("userJwt") as Ref<string | null>;
const onUpdatePage = async () => {
    if ((await pageService.updatePage(props.page, state.value.text)) != null) {
        flipMode();
        ElMessage.success("更新成功");
    } else {
        console.log("INTERNAL ERROR");
    }
};
</script>

<template>
    <el-container v-loading="isLoading" :element-loading-background="color">
        <el-aside width="20%"></el-aside>
        <el-main>
            <md-editor
                v-if="!isEditing"
                preview-only
                v-model="state.text"
                :editor-id="state.id"
                :theme="state.theme"
                :preview-theme="state.previewTheme"
            />
            <md-editor
                v-if="isEditing"
                v-model="state.text"
                :editor-id="state.id"
                :theme="state.theme"
                :preview-theme="state.previewTheme"
            />
        </el-main>
        <el-aside width="20%">
            <el-affix :offset="80" v-if="userJwt != null">
                <el-button size="default" @click="flipMode">{{ buttonText }}</el-button>
                <el-button size="default" v-if="isEditing" @click="onUpdatePage">保存修改</el-button>
            </el-affix>
        </el-aside>
    </el-container>
</template>

<style scoped></style>
