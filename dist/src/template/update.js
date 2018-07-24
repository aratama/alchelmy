"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});
exports.renderUpdate = renderUpdate;
function renderUpdate(application, pageName) {
    return `module ${application}.Page.${pageName}.Update exposing (route, init, update, subscriptions)

import ${application}.Page.${pageName}.Type exposing (Model, Msg(..), Route)
import ${application}.Type as Root
import UrlParser as UrlParser exposing (Parser, s, (</>), map)
import Navigation exposing (Location, newUrl)


route : Parser (Route -> a) a
route =
    map () (s "${pageName.toLowerCase()}")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init _ _ rootModel =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model = case msg of 
    Navigate url -> ( rootModel, model, newUrl url )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
`;
}