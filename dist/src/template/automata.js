"use strict";

Object.defineProperty(exports, "__esModule", {
    value: true
});
exports.renderAutomata = renderAutomata;
function renderAutomata(application, page) {
    return `
-------------------------
-- AUTO GENERATED FILE --
-- DO NOT EDIT THIS    --
-------------------------

module ${application}.Page.${page.join(".")}.Automata exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (href)
import Html.Events exposing (onWithOptions)
import Json.Decode exposing (Decoder, succeed, bool, field, fail, map4, andThen)
import ${application}.Page.${page.join(".")}.Type exposing (Model, Msg(..))
import ${application}.Type as Root

navigate : String -> List (Html Msg) -> Html Msg
navigate url contents =
    let
        decoder : Decoder Msg
        decoder =
            andThen
                identity
                (map4
                    (\\ctrl shift alt meta ->
                        if shift || ctrl || alt || meta then
                            fail ""
                        else
                            succeed (Navigate url)
                    )
                    (field "ctrlKey" bool)
                    (field "shiftKey" bool)
                    (field "altKey" bool)
                    (field "metaKey" bool)
                )
    in
        a [ href url, onWithOptions "click" { stopPropagation = True, preventDefault = True } decoder ] contents

`;
}