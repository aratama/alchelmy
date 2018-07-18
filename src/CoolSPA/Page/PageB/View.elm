module CoolSPA.Page.PageB.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.PageB.Type exposing (Model, Msg)
import CoolSPA.Type as Root


view : Root.Model -> Model -> Html Msg
view state model =
    div []
        [ h1 [] [ text "PageB" ]
        , p [] [ a [ href "/#/page-a" ] [ text "Go to PageA" ] ]
        , p [] [ a [ href "/#/page-c/42" ] [ text "Go to PageC" ] ]
        , p [] [ a [ href "/#/page-b/page-b-a" ] [ text "Go to Page B/A" ] ]
        ]
