module ElmPortfolio.Page.NotFound.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import ElmPortfolio.Page.NotFound.Type exposing (Model, Msg(..))
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root

link : String -> String -> Html Msg
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view state model =
    div [ class "page-not-found" ]
        [ h1 [] [ text "404 Not Found" ]
        , p [] [ link "/" "Go to Top" ]
        ]
