module ElmPortfolio.Type exposing (..)

-- Application global state type.

import Navigation exposing (Location)


type alias Model =
    { theme : String }


type Msg
    = ReceiveThemeFromLocalStorage (Maybe String)


-- DescentMsg


type DescentMsg
    = Initialize
