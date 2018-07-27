"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});
exports.renderRootType = renderRootType;
function renderRootType(application) {
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
    = DescentMsgNoOp

`;
}