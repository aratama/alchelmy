module CoolSPA.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)


view : Html msg -> Html msg
view content =
    div []
        [ div [] []
        , div [] [ content ]
        ]
