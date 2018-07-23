module ElmPortfolio.View exposing (..)

import Html exposing (Html, text, div, header, h1, p, a)
import Html.Attributes exposing (class, href)
import ElmPortfolio.Type as Root


view : (String -> List (Html msg) -> Html msg) -> Root.Model -> Html msg -> Html msg
view navigate model content =
    div [ class "root" ]
        [ header []
            [ h1 [] [ text "Elm Examples" ]
            , text <| "Theme: " ++ model.theme
            ]
        , div [ class "page" ]
            [ div [ class "index" ]
                [ p [] [ navigate "/counter" [ text "Counter" ] ]
                , p [] [ navigate "/http" [ text "Http" ] ]
                , p [] [ navigate "/time" [ text "Time" ] ]
                , p []
                    [ navigate "/parent" [ text "Parent" ]
                    , text " / "
                    , navigate "/parent/child" [ text "Child" ]
                    ]
                , p [] [ navigate "/url-parsing/42" [ text "URL Parsing" ] ]
                , p [] [ navigate "/preferences" [ text "Preferences" ] ]
                , p [] [ navigate "/broken-url" [ text "404" ] ]
                , p [] [ navigate "/" [ text "Top" ] ]
                ]
            , div []
                [ content
                ]
            ]
        ]
