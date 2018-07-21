module ElmPortfolio.Page.Counter.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p, button)
import Html.Attributes exposing (src, href, class)
import Html.Events exposing (onClick)
import ElmPortfolio.Page.Counter.Type exposing (Model, Msg(..))
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root


view : Root.Model -> Model -> Html Msg
view rootModel model =
    Root.view rootModel <|
        div [ class "page-counter container" ]
            [ h1 [] [ text "Counter" ]
            , p [] [ button [ onClick Decrement ] [ text "-" ] ]
            , p [] [ div [] [ text (toString model) ] ]
            , p [] [ button [ onClick Increment ] [ text "+" ] ]
            ]
