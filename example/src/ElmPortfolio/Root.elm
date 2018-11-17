module ElmPortfolio.Root exposing (Flags, Page, Session, initial, link, updateTopic, view)

import Browser exposing (Document)
import Browser.Navigation exposing (Key, pushUrl)
import ElmPortfolio.Ports exposing (receiveThemeFromLocalStorage, requestThemeFromLocalStorage)
import Html exposing (Html, a, div, h1, header, p, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (custom, onClick)
import Json.Decode exposing (Decoder, andThen, bool, fail, field, map4, succeed)
import Maybe exposing (withDefault)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, parse, s)


type alias Flags =
    ()


type alias Session =
    { topic : String
    }


type alias Page a route model msg =
    { init : Flags -> Url -> route -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , route : Parser (route -> a) a
    , navigated : Url -> route -> Session -> ( model, Cmd msg )
    }


initial : Session
initial =
    { topic = "goat" }


link : String -> String -> Html msg
link url label =
    a [ href url ] [ text label ]


view : Session -> Html msg -> Html msg
view model content =
    div [ class "root" ]
        [ header []
            [ h1 [] [ link "/" "Elm Examples" ]
            , text <| "Topic: " ++ model.topic
            ]
        , div [ class "page" ]
            [ div [ class "index" ]
                [ p [] [ link "/counter" "Counter" ]
                , p [] [ link "/http" "Http" ]
                , p [] [ link "/time" "Time" ]
                , p [] [ link "/url-parsing/42" "URL Parsing" ]
                , p [] [ link "/preferences" "Preferences" ]
                , p [] [ link "/broken-url" "404" ]
                , p [] [ link "/minimum" "Minimum" ]
                ]
            , div []
                [ content
                ]
            ]
        ]


updateTopic : { a | session : Session } -> Maybe String -> { a | session : Session }
updateTopic model maybeTopic =
    let
        session =
            model.session

        topic =
            Maybe.withDefault "goat" maybeTopic
    in
    { model | session = { session | topic = topic } }
