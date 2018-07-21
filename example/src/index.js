import "./main.css";
import { Main } from "./Main.elm";
import registerServiceWorker from "./registerServiceWorker";
import "./ElmPortfolio/routing.js";

Main.embed(document.getElementById("root"));

registerServiceWorker();
