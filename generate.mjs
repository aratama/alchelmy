import fs from "fs"
import util from "util"
import path from "path"

function toPagePath(page){
  const words = page.split(/([A-Z][a-z]*)/).filter(s => s != "").map(s => s.toLowerCase())
  return words.join("-")
}

async function main(){

  const filesInRoot = await util.promisify(fs.readdir)(`./src`)

  const dirsWithNull = await Promise.all(filesInRoot.map(async file => {
    const stat = await util.promisify(fs.stat)(path.resolve('./src/', file))
    return stat.isDirectory() ? file : null
  }))

  const dirs = dirsWithNull.filter(dir => dir !== null)

  if(dirs.length !== 1){
    throw new Error("Too many folders in src directory. Cannot decide application name.")
  }

  const application = dirs[0]

  const files = await util.promisify(fs.readdir)(`./src/${application}/Page`)

  const pages = files.map(file => path.parse(file).name)

  pages.forEach(page => console.log(`Generate '${page}' as /${toPagePath(page)}`))

  const source = `
--------------------------
-- Auto-generated codes --
-- Do not edit this     -- 
--------------------------

module ${application}.Routing exposing (..)

import Navigation exposing (Location)
import UrlParser as UrlParser exposing (s, oneOf, top, Parser, parseHash)
import Html as Html exposing (Html, text)
${
  pages.map(page => `
import ${application}.Page.${page}.View as ${page}
import ${application}.Page.${page}.Type as ${page}
import ${application}.Page.${page}.Update as ${page}
`).join("\n")
}

type alias Model =
    { route : Route }

type Msg
    = Navigate Route
${
  pages.map(page => `    | ${page}Msg ${page}.Msg`).join("\n")
}


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case (Debug.log "" msg) of 

  Navigate route -> (
    { model | route = route }
    , case route of 
      NotFoundRoute -> Cmd.none
${
  pages.map(page => `      ${page} _ -> Cmd.map ${page}Msg ${page}.initialize`).join("\n")
}
  )

${
  pages.map(page => `
  ${page}Msg pageMsg -> case model.route of 
      ${page} pageModel -> case ${page}.update pageMsg pageModel of 
        (pageModel_, pageCmd) -> ( { model | route = ${page} pageModel_ }, Cmd.map ${page}Msg pageCmd)      
      _ -> (model, Cmd.none)
  `).join("\n")
}

view : Model -> Html Msg
view model = case model.route of 
  NotFoundRoute -> text "404 Not Found"
${
  pages.map(page => `  ${page} m -> Html.map ${page}Msg (${page}.view m)`).join("\n")
}

    

type Route
  = NotFoundRoute
${
  pages.map(page => `  | ${page} ${page}.Model`).join("\n")
}


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ UrlParser.map (PageA PageA.initial) top
${
  pages.map(page => `        , UrlParser.map (${page} ${page}.initial) (s "${toPagePath(page)}")`).join("\n")
}
        ]   

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFoundRoute

navigate : Location -> Msg 
navigate location = Navigate (parseLocation location)

  `

  await util.promisify(fs.writeFile)(`./src/${application}/Routing.elm`, source)



  // generate index.js

  const css = `
import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';
${
  pages.map(page => {
    return `import './${application}/Page/${page}/style.css'`
  }).join("\n")
}

Main.embed(document.getElementById('root'));

registerServiceWorker();
`

  await util.promisify(fs.writeFile)("./src/index.js", css)

}

main()
