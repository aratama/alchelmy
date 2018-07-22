"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.renderView = renderView;
function renderView(application, pageName) {
  return `module ${application}.Page.${pageName}.View exposing (..)

import Html exposing (Html, text)
import ${application}.Page.${pageName}.Type exposing (Model, Msg(..))
import ${application}.Type as Root

view : Root.Model -> Model -> Html Msg
view state model = text "${pageName}"
`;
}