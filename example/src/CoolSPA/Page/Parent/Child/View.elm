module CoolSPA.Page.Parent.Child.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import CoolSPA.Page.Parent.Child.Type exposing (Model, Msg)
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-parent" ]
            [ h1 [] [ text "Parent / Child" ]
            , p [] [ a [ href "/#/parent" ] [ text "Go up to parent page" ] ]
            ]
