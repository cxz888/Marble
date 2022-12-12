import mitt from "mitt";

type Events = {
    changeTheme: boolean;
};

export default mitt<Events>();
