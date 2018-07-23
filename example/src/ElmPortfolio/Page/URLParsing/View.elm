module ElmPortfolio.Page.URLParsing.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import ElmPortfolio.Page.URLParsing.Type exposing (Model, Msg(..))
import ElmPortfolio.Page.URLParsing.Automata exposing (navigate)
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode exposing (succeed)


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view navigate state <|
        div [ class "page-url-parser container" ]
            [ h1 [] [ text "URL Parsing" ]
            , p []
                [ text <|
                    model.location.origin
                        ++ model.location.pathname
                        ++ model.location.search
                        ++ model.location.hash
                ]
            , p [] [ text <| "Parameter: " ++ toString model.id ]
            ]
