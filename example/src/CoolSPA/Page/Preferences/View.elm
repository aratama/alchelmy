module CoolSPA.Page.Preferences.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p, button, input)
import Html.Attributes exposing (src, href, class, type_, value)
import Html.Events exposing (onClick, onInput)
import CoolSPA.Page.Preferences.Type exposing (Model, Msg(..))
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-preferences container" ]
            [ h1 [] [ text "Preferences" ]
            , p [] [ text "Theme: ", input [ type_ "text", onInput InputUserName, value model.value ] [] ]
            , p [] [ button [ onClick SaveUserName ] [ text "Save" ] ]
            ]
