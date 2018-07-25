module ElmPortfolio.Page.Preferences.Type exposing (..)

import ElmPortfolio.Type as Root


type Msg
    = InputUserName String
    | SaveUserName
    | AscentMsg Root.AscentMsg


type alias Model =
    { value : String }


type alias Route =
    {}
