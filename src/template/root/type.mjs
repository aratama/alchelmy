export function renderRootType(application) {
  return `module ${application}.Type exposing (..)


-- Application global state type.


type alias Model =
    {}
  

type Msg
    = Navigate String


-- DescentMsg


type DescentMsg
    = DescentMsgNoOp

`;
}
