module CoolSPA.Page.Top.View exposing (..)


import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.Top.Type exposing (Model, Msg)




view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "Top" ]
        , p [] [a [href "/#/page-a"] [text "Go to PageA"]]
        , p [] [a [href "/#/page-b"] [text "Go to PageB"]]
        , p [] [a [href "/#/page-c/42"] [text "Go to PageC"]]
        ]
