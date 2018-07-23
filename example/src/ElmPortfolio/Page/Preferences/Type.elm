module ElmPortfolio.Page.Preferences.Type exposing (..)


type Msg
    = InputUserName String
    | SaveUserName
    | Navigate String


type alias Model =
    { value : String }


type alias Route =
    {}
