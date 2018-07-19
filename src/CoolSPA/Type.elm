module CoolSPA.Type exposing (..)

-- global application state


type alias Model =
    { user : String }


initial : Model
initial =
    { user = "Alice" }
