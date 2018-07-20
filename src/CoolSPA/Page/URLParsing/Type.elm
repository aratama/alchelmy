module CoolSPA.Page.URLParsing.Type exposing (..)

import Navigation exposing (Location)


type Msg
    = NoOp


type alias Model =
    { id : Int, location : Location }


type alias Route =
    Int
