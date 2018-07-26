import "./main.css";
import { Main } from "./Main.elm";
import registerServiceWorker from "./registerServiceWorker";
import "./ElmPortfolio/automata.js";

const app = Main.embed(document.getElementById("root"));

// registerServiceWorker();

app.ports.saveThemeToLocalStorage.subscribe(function (theme) {
    localStorage.setItem("theme", theme)
});

app.ports.requestThemeFromLocalStorage.subscribe(function (theme) {
    app.ports.receiveThemeFromLocalStorage.send(localStorage.getItem("theme"))
});