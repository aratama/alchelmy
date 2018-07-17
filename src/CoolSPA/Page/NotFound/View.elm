module CoolSPA.Page.NotFound.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.NotFound.Type exposing (Model, Msg)

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "404 Not Found" ]
        , p [] [a [href "/#/"] [text "Go to Top"]]
        ]
