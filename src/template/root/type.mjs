export function renderRootType(application) {
  return `module ${application}.Type exposing (..)


-- Application global state type.


type alias Model =
    {}
  

type Msg
    = ChangeRoute String


    
-- AscentMsg


type AscentMsg
    = Navigate String



-- DescentMsg


type DescentMsg
    = Initialize

`;
}
