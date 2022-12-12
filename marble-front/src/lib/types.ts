export class UserSignin {
    username: string;
    password: string;
    constructor() {
        this.username = "";
        this.password = "";
    }
}
export class PostInfo {
    name: string;
    date: string;
    id: number;
    constructor(name: string, data: string, id: number) {
        this.name = name;
        this.date = data;
        this.id = id;
    }
}

export class PostCreate {
    title: string;
    content: string;
    constructor(title: string, content: string) {
        this.title = title;
        this.content = content;
    }
}
export class PostUpdate {
    title: string;
    content: string;
    constructor(title: string, content: string) {
        this.title = title;
        this.content = content;
    }
}
export class PageUpdate {
    content: string;
    constructor(content: string) {
        this.content = content;
    }
}
