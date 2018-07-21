module Main exposing (..)

import ElmPortfolio.Routing as Routing exposing (Model, Msg)


main : Program Never Model Msg
main =
    Routing.program { theme = "goat" }
