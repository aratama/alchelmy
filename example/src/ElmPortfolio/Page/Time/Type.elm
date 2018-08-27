module ElmPortfolio.Page.Time.Type exposing (..)

import Time exposing (Time)
import ElmPortfolio.Type as Root


type Msg
    = Navigate String
    | Tick Time


type alias Model =
    Time


type alias Route =
    {}
