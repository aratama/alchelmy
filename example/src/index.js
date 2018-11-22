
import "./main.css";
import { Elm } from "./Main.elm";
import { register, unregister } from "./registerServiceWorker";

const app = Elm.Main.init({
    node: document.getElementById('root')
});

//register();
unregister();

app.ports.saveThemeToLocalStorage.subscribe(function (theme) {
    localStorage.setItem("theme", theme)
});

app.ports.requestThemeFromLocalStorage.subscribe(function () {
    app.ports.receiveThemeFromLocalStorage.send(localStorage.getItem("theme"))
});