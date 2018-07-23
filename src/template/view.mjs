export function renderView(application, pageName) {
  return `module ${application}.Page.${pageName}.View exposing (..)

import Html exposing (Html, text)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode exposing (succeed)
import ${application}.Page.${pageName}.Type exposing (Model, Msg(..))
import ${application}.Type as Root

view : Root.Model -> Model -> Html Msg
view state model = text "${pageName}"

navigate : String -> List (Html Msg) -> Html Msg
navigate url contents =
    a [ href url, onWithOptions "click" { stopPropagation = True, preventDefault = True } (succeed (Navigate url)) ] contents
`;
}
