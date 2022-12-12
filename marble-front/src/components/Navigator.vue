<script setup lang="ts">
import { inject, reactive, Ref, ref, watch } from "vue";
import { useDark } from "@vueuse/core";
import { Sunny, Moon } from "@element-plus/icons-vue";
import bus from "@/lib/bus";
import { ElMessage } from "element-plus";
import { usersService } from "@/lib/services/users";
import { useRouter } from "vue-router";

const isDark = useDark();
const signinFormVisible = ref(false);
const signoutFormVisible = ref(false);
const activeIndex = ref(location.pathname);
const form = reactive({
    username: "",
    password: "",
});
const userJwt = inject("userJwt") as Ref<string | null>;

watch(signinFormVisible, (value) => {
    if (!value) {
        form.password = "";
        form.username = "";
    }
});

const onSignin = async () => {
    if (form.password.length < 6 || form.username.length < 6) {
        ElMessage("格式错误");
        return;
    }
    userJwt.value = await usersService.signin(form);
    if (userJwt.value != null) {
        localStorage.setItem("userJwt", userJwt.value);
        ElMessage("登录成功");
        signinFormVisible.value = false;
    } else {
        ElMessage("登录失败");
    }
};
const router = useRouter();
const onSignout = async () => {
    userJwt.value = null;
    localStorage.removeItem("userJwt");
    signoutFormVisible.value = false;
    router.push("/");
};
</script>

<template>
    <el-affix :offset="0">
        <el-menu :default-active="activeIndex" class="el-menu-demo" mode="horizontal" :ellipsis="false" router>
            <el-menu-item index="/">
                <span class="span-container">
                    <img class="logo" src="../assets/cloud.png" alt="闲云的博客" />
                </span>
                <span class="title">闲云的博客</span>
            </el-menu-item>
            <div class="flex-grow" />
            <el-menu-item index="/publish" v-if="userJwt != null">发布</el-menu-item>
            <span class="span-container" v-if="userJwt == null">
                <el-button type="primary" @click="signinFormVisible = true" round size="default">登录</el-button>
            </span>
            <el-dialog v-model="signinFormVisible" width="540px" title="登录">
                <el-form :model="form">
                    <el-form-item label="用户名" label-width="120px" size="default">
                        <el-input
                            v-model="form.username"
                            autocomplete="off"
                            minlength="6"
                            maxlength="20"
                            show-word-limit
                        />
                    </el-form-item>
                    <el-form-item label="密码" label-width="120px" size="default">
                        <el-input
                            v-model="form.password"
                            autocomplete="off"
                            minlength="6"
                            maxlength="20"
                            show-password
                        />
                    </el-form-item>
                </el-form>
                <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="signinFormVisible = false" size="default">取消</el-button>
                        <el-button type="primary" @click="onSignin" size="default">确定</el-button>
                    </span>
                </template>
            </el-dialog>
            <span class="span-container" v-if="userJwt != null">
                <el-button type="primary" @click="signoutFormVisible = true" round size="default">注销</el-button>
            </span>
            <el-dialog v-model="signoutFormVisible" width="240px" title="注销">
                <span>确定退出登录吗？</span>
                <template #footer>
                    <span class="dialog-footer">
                        <el-button @click="signoutFormVisible = false" size="default">取消</el-button>
                        <el-button type="primary" @click="onSignout" size="default">确定</el-button>
                    </span>
                </template>
            </el-dialog>
            <span class="separator"></span>
            <el-menu-item index="/posts">文章</el-menu-item>
            <el-menu-item index="/about">关于</el-menu-item>
            <el-menu-item index="/friends">友链</el-menu-item>
            <span class="separator"></span>
            <span class="span-container switch">
                <el-switch
                    v-model="isDark"
                    size="default"
                    @change="bus.emit('changeTheme', isDark)"
                    inline-prompt
                    :active-icon="Moon"
                    :inactive-icon="Sunny"
                />
            </span>
        </el-menu>
    </el-affix>
</template>

<style scoped>
span.switch {
    padding: 0 24px;
    user-select: none;
}
.span-container {
    display: flex;
    align-items: center;
}

.flex-grow {
    flex-grow: 1;
}
.title {
    padding-left: 8px;
    font-weight: 900;
}
.active {
    font-weight: 900;
}
div {
    font-size: 18px;
}
a {
    margin-right: 10px;
    text-decoration: none;
}

a:last-child {
    margin-right: 0px;
}

.title {
    font-size: 24px;
}
.logo {
    height: 100%;
    position: relative;
    border-radius: 5px;
    max-width: 3rem;
    max-height: 3rem;
}
.el-input {
    width: 300px;
}
</style>
