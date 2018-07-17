module CoolSPA.Page.PageB.PageBA.View exposing (..)


import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.PageB.PageBA.Type exposing (Model, Msg)


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "PageB" ]
        , p [] [a [href "/#/page-a"] [text "Go to Page A"]]
        , p [] [a [href "/#/page-c"] [text "Go to Page C"]]
            
        ]

