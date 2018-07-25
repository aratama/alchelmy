"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});
exports.renderUpdate = renderUpdate;
function renderUpdate(application, pageName) {
    return `module ${application}.Page.${pageName}.Update exposing (route, init, update, subscriptions, receive)

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


receive : Root.DescentMsg -> Maybe Msg
receive msg =
    Nothing
    

update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg, Root.AscentMsg )
update msg rootModel model =
    case msg of
        AscentMsg amsg ->
            ( rootModel, model, Cmd.none, amsg )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
`;
}