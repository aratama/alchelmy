"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});
exports.renderType = renderType;
function renderType(application, pageName) {
    return `module ${application}.Page.${pageName}.Type exposing (..)

import ${application}.Type as Root


type Msg
    = AscentMsg Root.AscentMsg


type alias Model =
    {}


type alias Route =
    ()
`;
}