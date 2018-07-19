module CoolSPA.Page.Preferences.Type exposing (..)


type Msg
    = InputUserName String
    | SaveUserName


type alias Model =
    { value : String }
