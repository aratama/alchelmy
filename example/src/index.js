import "./main.css";
import { Main } from "./Main.elm";
import { register, unregister } from "./registerServiceWorker";
import "./ElmPortfolio/alchemy.js";

const app = Main.embed(document.getElementById("root"));

//register();
unregister();

app.ports.saveThemeToLocalStorage.subscribe(function (theme) {
    localStorage.setItem("theme", theme)
});

app.ports.requestThemeFromLocalStorage.subscribe(function (theme) {
    app.ports.receiveThemeFromLocalStorage.send(localStorage.getItem("theme"))
});