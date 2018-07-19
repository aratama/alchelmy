module CoolSPA.Page.PageB.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import Html.Events exposing (onClick)
import CoolSPA.Page.PageB.Type exposing (Model, Msg)
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-b container" ]
            [ div []
                [ p [] [ a [ href "/#/page-a" ] [ text "Go to PageA" ] ]
                , p [] [ a [ href "/#/page-c/42" ] [ text "Go to PageC" ] ]
                , p [] [ a [ href "/#/page-b/page-b-a" ] [ text "Go to Page B/A" ] ]
                ]
            , div []
                [ h1 [] [ text "PageB" ]
                ]
            ]
