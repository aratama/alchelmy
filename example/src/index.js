import "./main.css";
import { Main } from "./Main.elm";
import registerServiceWorker from "./registerServiceWorker";
import "./ElmPortfolio/automata.js";

Main.embed(document.getElementById("root"));

registerServiceWorker();
