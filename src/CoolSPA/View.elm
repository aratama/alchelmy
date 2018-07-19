module CoolSPA.View exposing (..)

import Html exposing (Html, text, div, header, h1, p, a)
import Html.Attributes exposing (class, href)
import CoolSPA.Type as Root


view : Root.Model -> Html msg -> Html msg
view model content =
    div [ class "root" ]
        [ header []
            [ h1 [] [ text "Elm Examples" ]
            , text <| "User Name: " ++ model.user
            ]
        , div [ class "page" ]
            [ div [ class "index" ]
                [ p [] [ a [ href "/#/counter" ] [ text "Counter" ] ]
                , p [] [ a [ href "/#/http" ] [ text "Http" ] ]
                , p [] [ a [ href "/#/time" ] [ text "Time" ] ]
                , p [] [ a [ href "/#/page-b" ] [ text "Go to Page B" ] ]
                , p [] [ a [ href "/#/page-b/page-b-a" ] [ text "Go to Page B/A" ] ]
                , p [] [ a [ href "/#/page-c/42" ] [ text "Go to Page C" ] ]
                , p [] [ a [ href "/#/preferences" ] [ text "Preferences" ] ]
                ]
            , div []
                [ content
                ]
            ]
        ]
