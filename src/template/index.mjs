export function renderIndex(application, pages){
  return `
import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
${
  pages.map(page => {
    return `import './${application}/Page/${page.join("/")}/style.css'`
  }).join("\n")
}

Main.embed(document.getElementById('root'));

registerServiceWorker();
`
}