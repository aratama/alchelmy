import './ElmPortfolio/Page/Counter.css'
import './ElmPortfolio/Page/Http.css'
import './ElmPortfolio/Page/Minimum.css'
import './ElmPortfolio/Page/NotFound.css'
import './ElmPortfolio/Page/Preferences.css'
import './ElmPortfolio/Page/Time.css'
import './ElmPortfolio/Page/Top.css'
import './ElmPortfolio/Page/URLParsing.css'

import "./main.css";
import { Elm } from "./Main.elm";
import { register, unregister } from "./registerServiceWorker";

const app = Elm.Main.init({
    node: document.getElementById('root')
});

//register();
unregister();

app.ports.saveTopic.subscribe(function (theme) {
    localStorage.setItem("topic", theme)
});

app.ports.requestTopic.subscribe(function () {
    app.ports.receiveTopic.send(localStorage.getItem("topic"))
});