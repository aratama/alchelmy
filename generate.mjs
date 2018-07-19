import fs from "fs"
import util from "util"
import path from "path"
import glob from "glob"

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

  const ds = await util.promisify(glob)(`./src/${application}/Page/**/`)  
  
  const pages = ds.map(dir => {
    if(
      fs.existsSync(path.resolve(dir, "style.css")) && 
      fs.existsSync(path.resolve(dir, "Type.elm")) && 
      fs.existsSync(path.resolve(dir, "Update.elm")) && 
      fs.existsSync(path.resolve(dir, "View.elm")) 
    ){
      return path.relative(`./src/${application}/Page/`, dir).split(path.sep)
    }else{
      return null
    }
  }).filter(dir => dir !== null)

  pages.forEach(page => console.log(`Generate '${page.join(".")}'`))



  // generate Routing.elm

  const source = `
--------------------------
-- Auto-generated codes --
-- Do not edit this     -- 
--------------------------

module ${application}.Routing exposing (..)

import Navigation exposing (Location)
import UrlParser as UrlParser exposing (s, oneOf, Parser, parseHash, (</>))
import Html as Html exposing (Html, text)
import ${application}.Type as Root
${
  pages.map(page => `
import ${application}.Page.${page.join(".")}.View as ${page.join("_")}
import ${application}.Page.${page.join(".")}.Type as ${page.join("_")}
import ${application}.Page.${page.join(".")}.Update as ${page.join("_")}
`).join("\n")
}


type alias Model 
  = { route : Route
    , routeState : RouteState
    , state : Root.Model
    }

type Route
  = ${ pages.map(page => `${page.join("_")} ${page.join("_")}.Model`).join("\n  | ") }

type RouteState
  = ${ pages.map(page => `${page.join("_")}__State ${page.join("_")}.Model`).join("\n  | ") }
 
type Msg
  = Navigate Route
${
  pages.map(page => `  | ${page.join("_")}Msg ${page.join("_")}.Msg`).join("\n")
}

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of 

  Navigate route -> (
    { model | route = route }
    , case route of 
${
  pages.map(page => `
          ${page.join("_")} _ -> case ${page.join("_")}.initialize model.state of
              (initialModel, initialCmd) -> Cmd.map ${page.join("_")}Msg initialCmd
  
  
  `).join("\n")
}
  )

${
  pages.map(page => `
  ${page.join("_")}Msg pageMsg -> case model.route of 
      ${page.join("_")} pageModel -> case ${page.join("_")}.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = ${page.join("_")} pageModel_, state = model_ }, Cmd.map ${page.join("_")}Msg pageCmd)      
      _ -> (model, Cmd.none)
  `).join("\n")
}

view : Model -> Html Msg
view model = case model.route of 
${
  pages.map(page => `  ${page.join("_")} m -> Html.map ${page.join("_")}Msg (${page.join("_")}.view model.state m)`).join("\n")
}

    




matchers : Parser (Route -> a) a
matchers =
    oneOf
        [
${
  pages.map(page => `        UrlParser.map ${page.join("_")} ${page.join("_")}.route`).join(",\n")
}
        ]   

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound NotFound.initial

navigate : Location -> Msg 
navigate location = Navigate (parseLocation location)

init : Location -> ( Model, Cmd Msg )
init location = 
  let route = parseLocation location in 
        case route of
${
  pages.map(page => `
            ${page.join("_")} _ -> case ${page.join("_")}.initialize Root.initial of
                (initialModel, initialCmd) -> 
                    ( { route = route
                      , routeState = ${page.join("_")}__State initialModel
                      , state = Root.initial 
                      }
                    , Cmd.map ${page.join("_")}Msg initialCmd
                    )
  `).join("\n")
}   
  `

  await util.promisify(fs.writeFile)(`./src/${application}/Routing.elm`, source)



  // generate index.js

  const css = `
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

  await util.promisify(fs.writeFile)("./src/index.js", css)

}

main()
