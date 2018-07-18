module CoolSPA.Type exposing (..)


type alias State =
    { user : String }


initial : State
initial =
    { user = "Alice" }
