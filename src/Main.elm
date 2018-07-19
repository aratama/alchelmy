module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Navigation exposing (Location)
import CoolSPA.Routing as Routing exposing (Model, Msg, Route(..), parseLocation, navigate)


init : Location -> ( Model, Cmd Msg )
init =
    Routing.init


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Routing.update


view : Model -> Html Msg
view =
    Routing.view


subscriptions : Model -> Sub Msg
subscriptions =
    Routing.subscriptions


main : Program Never Model Msg
main =
    Navigation.program navigate
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
