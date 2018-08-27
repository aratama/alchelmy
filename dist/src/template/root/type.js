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
    = Navigate String


    
-- AscentMsg


type AscentMsg
    = AscentMsgNoOp



-- DescentMsg


type DescentMsg
    = DescentMsgNoOp

`;
}