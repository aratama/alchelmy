"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.renderRouter = renderRouter;
function dots(page) {
  return page;
}

function bars(page) {
  return page;
}

function renderRouter(application, pages) {
  return `
--------------------------
-- Auto-generated codes --
-- Do not edit this     -- 
--------------------------

module ${application}.Alchemy exposing (..)

import Navigation exposing (Location)
import UrlParser as UrlParser exposing (s, oneOf, Parser, parseHash, parsePath, (</>))
import Html as Html exposing (Html, text)
import Maybe as Maybe
import ${application}.Root as Root
${pages.map(page => `
import ${application}.Page.${dots(page)} as ${bars(page)}

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
  | Root__Msg Root.Msg
${pages.map(page => `  | ${bars(page)}__Msg ${bars(page)}.Msg`).join("\n")}



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of 

  Root__Msg rootMsg -> case Root.update rootMsg model.state of
    (rootModel_, rootCmd) -> 
        ({ model | state = rootModel_ }, Cmd.map Root__Msg rootCmd)

  Navigate location -> let route = parseLocation location in case route of ${pages.map(page => `
          ${bars(page)} routeValue -> case let page = ${bars(page)}.page in page.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = ${bars(page)}__State initialModel }
                , Cmd.map ${bars(page)}__Msg initialCmd
                )
  `).join("\n")}

${pages.map(page => `
  ${bars(page)}__Msg pageMsg -> case model.route of 
      ${bars(page)}__State pageModel -> 
        case let page = ${bars(page)}.page in page.update pageMsg model.state pageModel of 
          (model_, pageModel_, pageCmd ) -> 
            ({ model | state = model_, route = ${bars(page)}__State pageModel_ }, Cmd.map ${bars(page)}__Msg pageCmd)
        
      ${1 < pages.length ? "_ -> (model, Cmd.none)" : ""}
      
  `).join("\n")}

view : Model -> Html Msg
view model = case model.route of 
${pages.map(page => `  ${bars(page)}__State m -> Html.map ${bars(page)}__Msg (let page = ${bars(page)}.page in page.view model.state m)`).join("\n")}


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [
${pages.map(page => `        UrlParser.map ${bars(page)} (let page = ${bars(page)}.page in page.route)`).join(",\n")}
        ]   

parseLocation : Location -> Route
parseLocation location =
    case Root.parse matchers location of
        Just route ->
            route

        Nothing ->
            NotFound ()

navigate : Location -> Msg 
navigate = Navigate

init : Location -> ( Model, Cmd Msg )
init location = 
  let route = parseLocation location in 
    case Root.init location of 
      (rootInitialModel, rootInitialCmd) -> 
        case route of
${pages.map(page => `
            ${bars(page)} routeValue -> case let page = ${bars(page)}.page in page.init location routeValue rootInitialModel of
                (initialModel, initialCmd) -> 
                    ( { route = ${bars(page)}__State initialModel
                      , state = rootInitialModel
                      }
                    , Cmd.batch 
                      [ Cmd.map Root__Msg rootInitialCmd
                      , Cmd.map ${bars(page)}__Msg initialCmd
                      ]
                    )
  `).join("\n")}   

subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.batch
        (Sub.map Root__Msg Root.subscriptions :: [  ${pages.map(page => `Sub.map ${bars(page)}__Msg (let page = ${bars(page)}.page in page.subscriptions model.state)`).join("\n        , ")}
        ])


program : Program Never Model Msg
program =
    Navigation.program navigate
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
        

  `;
}