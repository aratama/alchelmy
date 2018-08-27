module ElmPortfolio.Page.Child.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import ElmPortfolio.Page.Child.Type exposing (Model, Msg(..))
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root

link : String -> String -> Html Msg
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view state model =
    Root.view link state <|
        div [ class "page-parent" ]
            [ h1 [] [ text "Parent / Child" ]
            , p []
                [ link "/parent" "Go up to parent page" 
                ]
            ]
