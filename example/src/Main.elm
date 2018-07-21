module Main exposing (..)

import Html exposing (Html)
import Navigation exposing (Location)
import CoolSPA.Routing as Routing exposing (Model, Msg, Route(..), parseLocation, navigate)


main : Program Never Model Msg
main =
    Navigation.program navigate
        { init = Routing.init { theme = "goat" }
        , view = Routing.view
        , update = Routing.update
        , subscriptions = Routing.subscriptions
        }
