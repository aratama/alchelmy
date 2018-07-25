module ElmPortfolio.Page.Time.Type exposing (..)

import Time exposing (Time)
import ElmPortfolio.Type as Root


type Msg
    = AscentMsg Root.AscentMsg
    | Tick Time


type alias Model =
    Time


type alias Route =
    {}
