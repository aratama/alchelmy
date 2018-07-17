module Main exposing (..)

import Html exposing (Html, text, div, h1, img)
import Html.Attributes exposing (src)
import Navigation exposing (Location)
import CoolSPA.Routing as Routing exposing (Model, Msg, Route(..), parseLocation, navigate)

init : Location -> ( Model, Cmd Msg )
init location = Routing.init location

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = Routing.update msg model

view : Model -> Html Msg
view model = Routing.view model 

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

main : Program Never Model Msg
main =
    Navigation.program navigate
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }