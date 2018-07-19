module CoolSPA.Page.PageC.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import CoolSPA.Page.PageC.Type exposing (Model, Msg)
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-c container" ]
            [ div []
                [ p [] [ a [ href "/#/page-a" ] [ text "Go to Page A" ] ]
                , p [] [ a [ href "/#/page-b" ] [ text "Go to Page B" ] ]
                , p [] [ a [ href "/#/page-b/page-b-a" ] [ text "Go to Page B/A" ] ]
                , p [] [ a [ href "/#/page-c/42" ] [ text "Go to Page C" ] ]
                ]
            , div []
                [ h1 [] [ text "Page C" ]
                ]
            ]
