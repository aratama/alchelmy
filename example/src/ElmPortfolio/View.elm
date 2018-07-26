module ElmPortfolio.View exposing (..)

import Html exposing (Html, text, div, header, h1, p, a)
import Html.Attributes exposing (class, href)
import ElmPortfolio.Type as Root
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode exposing (Decoder, succeed, bool, field, fail, map4, andThen)


view : (String -> List (Html msg) -> Html msg) -> Root.Model -> Html msg -> Html msg
view navigate model content =
    div [ class "root" ]
        [ header []
            [ h1 [] [ navigate "/" [ text "Elm Examples" ] ]
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
                ]
            , div []
                [ content
                ]
            ]
        ]


link : (Root.AscentMsg -> msg) -> String -> List (Html msg) -> Html msg
link msg =
    navigate (msg << Root.Navigate)


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
