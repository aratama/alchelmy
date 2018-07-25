module ElmPortfolio.Page.URLParsing.Type exposing (..)

import Navigation exposing (Location)
import ElmPortfolio.Type as Root


type Msg
    = AscentMsg Root.AscentMsg


type alias Model =
    { id : Int, location : Location }


type alias Route =
    Int
