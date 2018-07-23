module ElmPortfolio.Page.Top.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import ElmPortfolio.Page.Top.Type exposing (Model, Msg(..))
import ElmPortfolio.Page.Top.Automata exposing (navigate)
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode exposing (Decoder, succeed, map4, field, bool, andThen, fail)


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view navigate state <|
        div [ class "page-top" ]
            [ h1 [] [ text "Top" ]
            ]
