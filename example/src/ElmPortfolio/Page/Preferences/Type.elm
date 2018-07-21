module ElmPortfolio.Page.Preferences.Type exposing (..)


type Msg
    = InputUserName String
    | SaveUserName


type alias Model =
    { value : String }


type alias Route =
    {}
