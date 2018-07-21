import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
import './CoolSPA/routing.js'

Main.embed(document.getElementById('root'));

registerServiceWorker();
