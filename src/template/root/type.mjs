export function renderRootType(application) {
  return `module ${application}.Type exposing (..)


-- Application global state type.


type alias Model =
    {}
  

type Msg
    = Navigate String


    
-- AscentMsg


type AscentMsg
    = AscentMsgNoOp



-- DescentMsg


type DescentMsg
    = DescentMsgNoOp

`;
}
