module CoolSPA.Page.Parent.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import Html.Events exposing (onClick)
import CoolSPA.Page.Parent.Type exposing (Model, Msg)
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-b container" ]
            [ h1 [] [ text "Parent" ]
            , p [] [ a [ href "/#/parent/child" ] [ text "Go to the child page" ] ]
            ]
