<script setup lang="ts">
import Page from "../Page.vue";
</script>

<template>
    <div class="home">
        <div id="avatar-container">
            <img src="../../assets/avatar.png" loading="lazy" />
        </div>
        <h1>闲云</h1>
        <h2 class="subtitle">在互联网的小角落里，慢慢学习和生活</h2>
        <div class="links">
            <a
                href="https://github.com/cxz888"
                title="Github"
                target="_blank"
                rel="external nofollow noopener noreferrer me"
            >
                <i class="fa fa-github"></i>
            </a>
            <span></span>
            <a href="https://cxz888.xyz" title="博客" target="_blank" rel="external nofollow noopener noreferrer me">
                <i class="fa fa-home"></i>
            </a>
        </div>
    </div>
    <Page page="home"></Page>
</template>

<style scoped>
.fa {
    font-weight: 900;
    font-size: 30px;
    padding: 0 4px;
}
img {
    top: 20px;
    max-width: 128px;
}
#avatar-container {
    padding: 20px 0px;
    text-align: center;
    vertical-align: bottom;
}
.home {
    align-content: center;
    text-align: center;
}
.subtitle {
    font-size: 18px;
}
</style>
