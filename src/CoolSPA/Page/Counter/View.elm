module CoolSPA.Page.Counter.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p, button)
import Html.Attributes exposing (src, href, class)
import Html.Events exposing (onClick)
import CoolSPA.Page.Counter.Type exposing (Model, Msg(..))
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-a container" ]
            [ h1 [] [ text "Counter" ]
            , p [] [ button [ onClick Decrement ] [ text "-" ] ]
            , p [] [ div [] [ text (toString model) ] ]
            , p [] [ button [ onClick Increment ] [ text "+" ] ]
            ]
