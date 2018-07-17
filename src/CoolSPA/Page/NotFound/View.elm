module CoolSPA.Page.NotFound.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import CoolSPA.Page.NotFound.Type exposing (Model, Msg)


view : Model -> Html Msg
view model =
    div [ class "page-not-found" ]
        [ h1 [] [ text "404 Not Found" ]
        , p [] [ a [ href "/#/" ] [ text "Go to Top" ] ]
        ]
