module ElmPortfolio.View exposing (..)

import Html exposing (Html, text, div, header, h1, p, a)
import Html.Attributes exposing (class, href)
import ElmPortfolio.Type as Root
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode exposing (Decoder, succeed, bool, field, fail, map4, andThen)


view : (String -> String -> Html msg) -> Root.Model -> Html msg -> Html msg
view link model content =
    div [ class "root" ]
        [ header []
            [ h1 [] [ link "/" "Elm Examples" ]
            , text <| "Theme: " ++ model.theme
            ]
        , div [ class "page" ]
            [ div [ class "index" ]
                [ p [] [ link "/counter" "Counter"  ]
                , p [] [ link "/http" "Http"  ]
                , p [] [ link "/time" "Time"  ]
                , p []
                    [ link "/parent" "Parent" 
                    , text " / "
                    , link "/parent/child" "Child" 
                    ]
                , p [] [ link "/url-parsing/42"  "URL Parsing"  ]
                , p [] [ link "/preferences"  "Preferences"  ]
                , p [] [ link "/broken-url" "404" ]
                ]
            , div []
                [ content
                ]
            ]
        ]


navigate : (String -> msg) -> String -> List (Html msg) -> Html msg
navigate msg url contents =
    let
        decoder : Decoder msg
        decoder =
            andThen
                identity
                (map4
                    (\ctrl shift alt meta ->
                        if shift || ctrl || alt || meta then
                            fail ""
                        else
                            succeed (msg url)
                    )
                    (field "ctrlKey" bool)
                    (field "shiftKey" bool)
                    (field "altKey" bool)
                    (field "metaKey" bool)
                )
    in
        a [ href url, onWithOptions "click" { stopPropagation = True, preventDefault = True } decoder ] contents
