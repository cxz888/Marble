import { useDark } from "@vueuse/core";
import { Themes, PreviewThemes, HeadList } from "md-editor-v3";

export type State = {
    text: string;
    theme: Themes;
    id: string;
    previewTheme: PreviewThemes;
};

export function previewOnlyState(): State {
    return { text: "", theme: useDark().value ? "dark" : "light", id: "readOnly", previewTheme: "github" };
}

export {};
