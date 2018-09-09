module ElmPortfolio.View exposing (..)

import Html exposing (Html, a)
import Html.Attributes exposing (href)
import Json.Decode exposing (Decoder, andThen, bool, fail, field, map4, succeed)

navigate : (String -> msg) -> String -> List (Html msg) -> Html msg
navigate msg url contents =
    let
        decoder : Decoder msg
        decoder =
            andThen
                identity
                (map4
                    (ctrl shift alt meta ->
                        if shift || ctrl || alt || meta then
                            -- do browser default behavior
                            fail ""

                        else
                            succeed (msg url)
                    )
                    (field "ctrlKey" bool)
                    (field "shiftKey" bool)
                    (field "altKey" bool)
                    (field "metaKey" bool)
                )
    in
    a [ href url, onWithOptions "click" { stopPropagation = True, preventDefault = True } decoder ] contents
