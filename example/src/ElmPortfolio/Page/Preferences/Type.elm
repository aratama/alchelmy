module ElmPortfolio.Page.Preferences.Type exposing (..)

import ElmPortfolio.Type as Root


type Msg
    = Navigate String
    | InputUserName String
    | SaveUserName
    | Initialize


type alias Model =
    { value : String }


type alias Route =
    {}
