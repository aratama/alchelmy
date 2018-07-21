module CoolSPA.View exposing (..)

import Html exposing (Html, text, div, header, h1, p, a)
import Html.Attributes exposing (class, href)
import CoolSPA.Type as Root


view : Root.Model -> Html msg -> Html msg
view model content =
    div [ class "root" ]
        [ header []
            [ h1 [] [ text "Elm Examples" ]
            , text <| "Theme: " ++ model.theme
            ]
        , div [ class "page" ]
            [ div [ class "index" ]
                [ p [] [ a [ href "/#/counter" ] [ text "Counter" ] ]
                , p [] [ a [ href "/#/http" ] [ text "Http" ] ]
                , p [] [ a [ href "/#/time" ] [ text "Time" ] ]
                , p []
                    [ a [ href "/#/parent" ] [ text "Parent" ]
                    , text " / "
                    , a [ href "/#/parent/child" ] [ text "Child" ]
                    ]
                , p [] [ a [ href "/#/url-parsing/42" ] [ text "URL Parsing" ] ]
                , p [] [ a [ href "/#/preferences" ] [ text "Preferences" ] ]
                , p [] [ a [ href "/#/broken-url" ] [ text "404" ] ]
                , p [] [ a [ href "/#/" ] [ text "Top" ] ]
                ]
            , div []
                [ content
                ]
            ]
        ]
