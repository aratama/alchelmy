module CoolSPA.Page.Http.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p, button, h2, img, br)
import Html.Attributes exposing (src, href, class, src)
import Html.Events exposing (onClick)
import CoolSPA.Page.Http.Type exposing (Model, Msg(..))
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-a container" ]
            [ h1 [] [ text "Http" ]
            , h2 [] [ text model.topic ]
            , button [ onClick MorePlease ] [ text "More Please!" ]
            , br [] []
            , img [ src model.gifUrl ] []
            ]
