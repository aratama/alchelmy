module CoolSPA.Type exposing (..)

-- global application state


type alias Model =
    { theme : String }


initial : Model
initial =
    { theme = "goat" }
