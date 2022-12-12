import { pa } from "element-plus/es/locale";

export function getPageName(page: string): string {
    const map = new Map([
        ["home", "主页"],
        ["about", "关于"],
        ["friends", "友链"],
    ]);
    const ret = map.get(page);
    if (ret) {
        return ret;
    } else {
        return "未知";
    }
}
