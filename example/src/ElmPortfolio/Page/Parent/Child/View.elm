module ElmPortfolio.Page.Parent.Child.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import ElmPortfolio.Page.Parent.Child.Type exposing (Model, Msg(..))
import ElmPortfolio.Page.Parent.Child.Automata exposing (navigate)
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view navigate state <|
        div [ class "page-parent" ]
            [ h1 [] [ text "Parent / Child" ]
            , p [] [ a [ href "/#/parent" ] [ text "Go up to parent page" ] ]
            ]
