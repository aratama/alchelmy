"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.renderBlankPage = renderBlankPage;
function renderBlankPage(application, pageName) {
  return `module ${application}.Page.${pageName} exposing (Route, Model, Msg, route, page)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import Html exposing (text, h1)
import Url exposing (Url)
import Url.Parser exposing (s, Parser, map)
import ${application}.Root as Root


type Msg
  = NoOp


type alias Model =
  {}


type alias Route =
  ()


route : Parser (Route -> a) a
route =
    map () (s "${pageName.toLowerCase()}")


init : Url -> Route -> Root.Model -> ( Model, Cmd Msg )
init _ _ _ =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg root model = ( root, model, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


view : Root.Model -> Model -> Document Msg
view state model = 
  { title = "${pageName} - ${application}"
  , body = [ h1 [] [text "${pageName}"] ]
  }

page : Root.Page a Route Model Msg
page = 
  { route = route
  , init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

  `;
}