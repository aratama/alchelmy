module ElmPortfolio.Page.NotFound.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import ElmPortfolio.Page.NotFound.Type exposing (Model, Msg(..))
import ElmPortfolio.Type as Root
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode exposing (succeed)


view : Root.Model -> Model -> Html Msg
view state model =
    div [ class "page-not-found" ]
        [ h1 [] [ text "404 Not Found" ]
        , p [] [ navigate "/" [ text "Go to Top" ] ]
        ]


navigate : String -> List (Html Msg) -> Html Msg
navigate url contents =
    a [ href url, onWithOptions "click" { stopPropagation = True, preventDefault = True } (succeed (Navigate url)) ] contents
