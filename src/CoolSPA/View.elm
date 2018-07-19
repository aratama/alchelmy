module CoolSPA.View exposing (..)

import Html exposing (Html, text, div, header)
import Html.Attributes exposing (class)
import CoolSPA.Type as Root


view : Root.Model -> Html msg -> Html msg
view model content =
    div [ class "root" ]
        [ header [] [ text <| "User Name: " ++ model.user ]
        , div [ class "page" ] [ content ]
        ]
