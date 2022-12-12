<script setup lang="ts"></script>

<template>
    <footer>
        <div class="footer-container">
            <div class="footer-line powered">
                主题灵感来自
                <a
                    href="https://github.com/hugo-fixit/FixIt"
                    target="_blank"
                    rel="external nofollow noopener noreferrer"
                    title="FixIt v0.2.16-RC"
                    ><img class="fixit-icon" src="../assets/fixit.svg" alt="FixIt logo" />&nbsp;FixIt</a
                >
            </div>
            <div class="footer-line copyright">
                <i class="fa fa-regular fa-copyright fa-fw"></i> <span itemprop="copyrightYear">2022 - 2022</span
                ><span class="author" itemprop="copyrightHolder"> <a href="/"></a></span
                ><span class="license footer-divider"
                    ><a
                        rel="license external nofollow noopener noreferrer"
                        href="https://creativecommons.org/licenses/by-nc/4.0/"
                        target="_blank"
                        >CC BY-NC 4.0</a
                    ></span
                >
            </div>
        </div>
    </footer>
</template>

<style scoped>
img {
    position: relative;
    display: inline-block;
    top: 0.25em;
    max-width: 16px;
}
footer {
    text-align: center;
    color: var(--el-text-color-primary);
    padding: 20px 20px;
}
footer .footer-container .footer-line .footer-divider:not(:first-child)::before {
    content: "│";
    margin: 0rem 0.25rem;
}
</style>
