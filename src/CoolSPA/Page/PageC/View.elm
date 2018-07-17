module CoolSPA.Page.PageC.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.PageC.Type exposing (Model, Msg)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text ("Page C (id = " ++ toString model.id ++ ")") ]
        , p [] [ a [ href "/#/page-a" ] [ text "Go to PageA" ] ]
        , p [] [ a [ href "/#/page-b" ] [ text "Go to PageB" ] ]
        ]
