module Main exposing (..)

import TestProject.Alchemy as Alchemy exposing (Model, Msg)


main : Program Never Model Msg
main =
    Alchemy.program
