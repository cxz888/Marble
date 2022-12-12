import PostList from "../components/MainBody/PostList.vue";
import About from "../components/MainBody/About.vue";
import Home from "../components/MainBody/Home.vue";
import Friends from "../components/MainBody/Friends.vue";
import Publish from "../components/MainBody/Publish.vue";
import Post from "../components/MainBody/Post.vue";

export const routes = [
    { path: "/", component: Home, meta: { title: "Home" } },
    { path: "/posts", component: PostList, meta: { title: "PostList" } },
    { path: "/posts/:id", component: Post, meta: { title: "Post" } },
    { path: "/about", component: About, meta: { title: "About" } },
    { path: "/friends", component: Friends, meta: { title: "Friends" } },
    { path: "/publish", component: Publish, meta: { title: "Publish" } },
];
