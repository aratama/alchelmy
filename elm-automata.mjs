import fs from "fs-extra"
import util from "util"
import path from "path"
import glob from "glob"

const writeFile = util.promisify(fs.writeFile)

function dots(page){
  return page.join(".")
}

function bars(page){
  return page.join("_")
}

async function getApplicationName(){
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

  return application
}

async function generateRouter(){

  const application = await getApplicationName()

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

  pages.forEach(page => console.log(`Generate '${dots(page)}'`))



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

import ${application}.Page.${dots(page)}.View as ${bars(page)}
import ${application}.Page.${dots(page)}.Type as ${bars(page)}
import ${application}.Page.${dots(page)}.Update as ${bars(page)}

`.trim()).join("\n") 
}


type alias Model 
  = { route : RouteState
    , state : Root.Model
    }

type Route
  = ${ pages.map(page => `${bars(page)} ${bars(page)}.Route`).join("\n  | ") }

type RouteState
  = ${ pages.map(page => `${bars(page)}__State ${bars(page)}.Model`).join("\n  | ") }
 
type Msg
  = Navigate Location
${
  pages.map(page => `  | ${bars(page)}Msg ${bars(page)}.Msg`).join("\n")
}

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of 

  Navigate location -> let route = parseLocation location in case route of ${
  pages.map(page => `
          ${bars(page)} routeValue -> case ${bars(page)}.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = ${bars(page)}__State initialModel }
                , Cmd.map ${bars(page)}Msg initialCmd
                )
  `).join("\n") }

${
  pages.map(page => `
  ${ bars(page)}Msg pageMsg -> case model.route of 
      ${bars(page)}__State pageModel -> case ${bars(page)}.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = ${bars(page)}__State pageModel_, state = model_ }, Cmd.map ${bars(page)}Msg pageCmd)      
      _ -> (model, Cmd.none)
  `).join("\n")
}

view : Model -> Html Msg
view model = case model.route of 
${
  pages.map(page => `  ${bars(page)}__State m -> Html.map ${bars(page)}Msg (${bars(page)}.view model.state m)`).join("\n")
}


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [
${
  pages.map(page => `        UrlParser.map ${bars(page)} ${bars(page)}.route`).join(",\n")
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
navigate = Navigate

init : Location -> ( Model, Cmd Msg )
init location = 
  let route = parseLocation location in 
        case route of
${
  pages.map(page => `
            ${bars(page)} routeValue -> case ${bars(page)}.init location routeValue Root.initial of
                (initialModel, initialCmd) -> 
                    ( { route = ${bars(page)}__State initialModel
                      , state = Root.initial 
                      }
                    , Cmd.map ${bars(page)}Msg initialCmd
                    )
  `).join("\n")
}   

subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.batch
        [  ${
            pages.map(page => `Sub.map ${bars(page)}Msg (${bars(page)}.subscriptions model.state)`).join("\n        , ") 
}
        ]




  `

  await util.promisify(fs.writeFile)(`./src/${application}/Routing.elm`, source)



  // generate index.js

  const indexSource = `
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

  await writeFile("./src/index.js", indexSource)

}



async function generateNewPage(pageName){
  debugger
  console.log(`Generating new page: ${pageName}`)

  const application = await getApplicationName()

  if(fs.existsSync(path.resolve(`./src/`, application, `Page`, pageName))){
    console.error(`[Error] Directory '${pageName}' already exists.`)
  }else{

    const view = `
module ${application}.Page.${pageName}.View exposing (..)

import Html exposing (Html, text)
import ${application}.Page.${pageName}.Type exposing (Model, Msg(..))
import ${application}.Type as Root

view : Root.Model -> Model -> Html Msg
view state model = text ""
`
    const update = `
module ${application}.Page.${pageName}.Update exposing (..)

import UrlParser exposing (..)
import ${application}.Page.${pageName}.Type exposing (Model, Msg(..), Route)
import ${application}.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location)


route : Parser (Route -> a) a
route =
    map () (s "${pageName.toLowerCase()}")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init _ _ rootModel =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
    `
    const type = `
module ${application}.Page.${pageName}.Type exposing (..)


type Msg
    = NoOp


type alias Model =
    {}


type alias Route =
    ()
`
    const dir = path.resolve("./src/", application, "Page", pageName)
    await fs.ensureDir(dir)
    await writeFile(path.resolve(dir, "style.css"), "", { flag: 'wx' })
    await writeFile(path.resolve(dir, "Type.elm"), type, { flag: 'wx' })
    await writeFile(path.resolve(dir, "Update.elm"), update, { flag: 'wx' })
    await writeFile(path.resolve(dir, "View.elm"), view, { flag: 'wx' })

    await generateRouter()
  }
}

async function main(){
  const command = process.argv[2]
  if(process.argv.length === 2){
    await generateRouter()
  }else if (process.argv.length === 4 && command === "new"){
    await generateNewPage(process.argv[3])
  }else{
    console.error(`Unknown command: ${process.argv.slice(2).join(" ")}`)
  }
}

main()