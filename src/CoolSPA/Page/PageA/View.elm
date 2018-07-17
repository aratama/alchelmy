module CoolSPA.Page.PageA.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p, button)
import Html.Attributes exposing (src, href, class)
import Html.Events exposing (onClick)
import CoolSPA.Page.PageA.Type exposing (Model, Msg(..))


view : Model -> Html Msg
view model =
    div [ class "page-a" ]
        [ h1 [] [ text "PageA" ]
        , p [] [ a [ href "/#/page-b" ] [ text "Go to PageB" ] ]
        , p [] [ a [ href "/#/page-c/42" ] [ text "Go to PageC" ] ]
        , div []
            [ button [ onClick Decrement ] [ text "-" ]
            , div [] [ text (toString model) ]
            , button [ onClick Increment ] [ text "+" ]
            ]
        ]
