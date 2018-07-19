module CoolSPA.Page.Preferences.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p, button, input)
import Html.Attributes exposing (src, href, class, type_)
import Html.Events exposing (onClick, onInput)
import CoolSPA.Page.Preferences.Type exposing (Model, Msg(..))
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-a container" ]
            [ div [ class "" ]
                [ p [] [ a [ href "/#/page-a" ] [ text "Go to Page A" ] ]
                , p [] [ a [ href "/#/page-b" ] [ text "Go to Page B" ] ]
                , p [] [ a [ href "/#/page-b/page-b-a" ] [ text "Go to Page B/A" ] ]
                , p [] [ a [ href "/#/page-c/42" ] [ text "Go to Page C" ] ]
                ]
            , div []
                [ h1 [] [ text "Preferences" ]
                , p [] [ input [ type_ "text", onInput InputUserName ] [ text "" ] ]
                , p [] [ button [ onClick SaveUserName ] [ text "Save" ] ]
                ]
            ]
