"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.renderRouter = renderRouter;
function dots(page) {
  return page.join(".");
}

function bars(page) {
  return page.join("_");
}

function renderRouter(application, pages, argv) {
  return `
--------------------------
-- Auto-generated codes --
-- Do not edit this     -- 
--------------------------

module ${application}.Automata exposing (..)

import Navigation exposing (Location)
import UrlParser as UrlParser exposing (s, oneOf, Parser, parseHash, parsePath, (</>))
import Html as Html exposing (Html, text)
import ${application}.Type as Root
${pages.map(page => `
import ${application}.Page.${dots(page)}.View as ${bars(page)}
import ${application}.Page.${dots(page)}.Type as ${bars(page)}
import ${application}.Page.${dots(page)}.Update as ${bars(page)}
`.trim()).join("\n")}


type alias Model 
  = { route : RouteState
    , state : Root.Model
    }

type Route
  = ${pages.map(page => `${bars(page)} ${bars(page)}.Route`).join("\n  | ")}

type RouteState
  = ${pages.map(page => `${bars(page)}__State ${bars(page)}.Model`).join("\n  | ")}
  
type Msg
  = Navigate Location
${pages.map(page => `  | ${bars(page)}Msg ${bars(page)}.Msg`).join("\n")}

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of 

  Navigate location -> let route = parseLocation location in case route of ${pages.map(page => `
          ${bars(page)} routeValue -> case ${bars(page)}.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = ${bars(page)}__State initialModel }
                , Cmd.map ${bars(page)}Msg initialCmd
                )
  `).join("\n")}

${pages.map(page => `
  ${bars(page)}Msg pageMsg -> case model.route of 
      ${bars(page)}__State pageModel -> case ${bars(page)}.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = ${bars(page)}__State pageModel_, state = model_ }, Cmd.map ${bars(page)}Msg pageCmd)     
      
      ${1 < pages.length ? "_ -> (model, Cmd.none)" : ""}
      
  `).join("\n")}

view : Model -> Html Msg
view model = case model.route of 
${pages.map(page => `  ${bars(page)}__State m -> Html.map ${bars(page)}Msg (${bars(page)}.view model.state m)`).join("\n")}


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [
${pages.map(page => `        UrlParser.map ${bars(page)} ${bars(page)}.route`).join(",\n")}
        ]   

parseLocation : Location -> Route
parseLocation location =
    case (${argv.parse === "path" ? "parsePath" : "parseHash"} matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound ()

navigate : Location -> Msg 
navigate = Navigate

init : Root.Model -> Location -> ( Model, Cmd Msg )
init initial location = 
  let route = parseLocation location in 
        case route of
${pages.map(page => `
            ${bars(page)} routeValue -> case ${bars(page)}.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = ${bars(page)}__State initialModel
                      , state = initial
                      }
                    , Cmd.map ${bars(page)}Msg initialCmd
                    )
  `).join("\n")}   

subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.batch
        [  ${pages.map(page => `Sub.map ${bars(page)}Msg (${bars(page)}.subscriptions model.state)`).join("\n        , ")}
        ]


program : Root.Model -> Program Never Model Msg
program initial =
    Navigation.program navigate
        { init = init initial
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
        

  `;
}