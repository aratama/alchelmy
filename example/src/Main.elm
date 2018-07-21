module Main exposing (..)

import CoolSPA.Routing as Routing exposing (Model, Msg)


main : Program Never Model Msg
main =
    Routing.program { theme = "goat" }
