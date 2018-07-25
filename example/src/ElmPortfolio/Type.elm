module ElmPortfolio.Type exposing (..)

-- Application global state type.


type alias Model =
    { theme : String }


type Msg
    = ChangeRoute String
