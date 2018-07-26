module ElmPortfolio.Type exposing (..)

-- Application global state type.

import Navigation exposing (Location)


type alias Model =
    { theme : String }


type Msg
    = ChangeRoute String
    | ReceiveThemeFromLocalStorage (Maybe String)



-- AscentMsg


type AscentMsg
    = Navigate String



-- DescentMsg


type DescentMsg
    = Initialize
