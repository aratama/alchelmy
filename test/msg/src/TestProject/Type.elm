module TestProject.Type exposing (..)

-- Application global state type.


type alias Model =
    String


type Msg
    = StartTest Model
    | SetState Model



-- AscentMsg


type AscentMsg
    = SetRootState Model



-- DescentMsg


type DescentMsg
    = SendToChild Model
