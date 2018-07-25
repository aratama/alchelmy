module Main exposing (..)

import ElmPortfolio.Automata as Automata exposing (Model, Msg)


main : Program Never Model Msg
main =
    Automata.program
