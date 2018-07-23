module ElmPortfolio.Page.Time.Type exposing (..)

import Time exposing (Time)


type Msg
    = Navigate String
    | Tick Time


type alias Model =
    Time


type alias Route =
    {}
