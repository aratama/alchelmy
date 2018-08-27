module TestProject.Type exposing (..)

-- Application global state type.


type alias Model =
    String


type Msg
    = StartTest Model
    | SetState Model


-- DescentMsg


type DescentMsg
    = SendToChild Model
