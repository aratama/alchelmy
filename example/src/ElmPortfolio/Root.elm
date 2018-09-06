module ElmPortfolio.Root exposing (..)

-- Application global state type.

import Navigation exposing (Location)
import UrlParser as UrlParser exposing (s, Parser, (</>), map, parsePath)
import Navigation exposing (Location, newUrl)
import ElmPortfolio.Ports exposing (requestThemeFromLocalStorage, receiveThemeFromLocalStorage)
import Maybe exposing (withDefault)
import Html exposing (Html, text, div, header, h1, p, a)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode exposing (Decoder, succeed, bool, field, fail, map4, andThen)

type alias Model =
    { theme : String }


type Msg
    = ReceiveThemeFromLocalStorage (Maybe String)




type alias Page a route model msg =
    { route : Parser (route -> a) a
    , init : Location -> route -> Model -> (model, Cmd msg )
    , update : msg -> Model -> model -> (Model, model, Cmd msg )
    , subscriptions : Model -> Sub msg
    , view : Model -> model -> Html msg
    }




init : Location -> ( Model, Cmd Msg )
init _ =
    ( { theme = "goat" }, requestThemeFromLocalStorage () )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage themeMaybe ->
            ( { model | theme = withDefault model.theme themeMaybe }, Cmd.none )


subscriptions : Sub Msg
subscriptions =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


parse : Parser (a -> a) a -> Location -> Maybe a
parse =
    parsePath



view : (String -> String -> Html msg) -> Model -> Html msg -> Html msg
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
