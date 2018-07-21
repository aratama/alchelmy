module CoolSPA.Page.Top.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import CoolSPA.Page.Top.Type exposing (Model, Msg)
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-top" ]
            [ h1 [] [ text "Top" ]
            ]
