-- alchelmy root page

module ElmPortfolio.Root exposing (Flags, Page, Session, SessionMsg(..), initial, link, sessionOnUrlRequest, sessionUpdate, updateTopic, view)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load)
import Html exposing (Html, a, button, div, h1, header, p, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Maybe exposing (Maybe, withDefault)
import Url exposing (Url)
import Url.Parser as UrlParser exposing (Parser)


type alias Flags =
    ()


type alias Session =
    { topic : String
    , destination : Maybe String
    }


type alias Page model msg route a =
    { init : Flags -> Url -> Key -> route -> Maybe Session -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , route : Parser (route -> a) a
    , onUrlRequest : UrlRequest -> Maybe msg
    }


initial : Session
initial =
    { topic = "goat", destination = Nothing }


link : String -> String -> Html msg
link url label =
    a [ href url ] [ text label ]


view : Session -> Html (SessionMsg msg) -> Html (SessionMsg msg)
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
                , p [] [ link "https://google.com" "External Link" ]
                ]
            , div []
                [ content
                ]
            ]
        , case model.destination of
            Nothing ->
                text ""

            Just destination ->
                div [ class "dialog-outer" ]
                    [ div [ class "dialog" ]
                        [ div [ class "upper" ]
                            [ text "外部サイト"
                            , text destination
                            , text "に移動しますか？"
                            ]
                        , div [ class "lower" ]
                            [ button [ onClick (Jump destination) ] [ text "移動する" ]
                            , button [ onClick CloseDialog ] [ text "取り消す" ]
                            ]
                        ]
                    ]
        ]


type SessionMsg a
    = ReceiveThemeFromLocalStorage (Maybe String)
    | ExternalLink String
    | Jump String
    | CloseDialog
    | PageMsg a


sessionUpdate :
    (a -> { model | session : Session } -> ( { model | session : Session }, Cmd (SessionMsg a) ))
    -> SessionMsg a
    -> { model | session : Session }
    -> ( { model | session : Session }, Cmd (SessionMsg a) )
sessionUpdate f msg model =
    let
        session =
            model.session
    in
    case msg of
        ReceiveThemeFromLocalStorage maybeTopic ->
            ( { model | session = { session | topic = Maybe.withDefault "goat" maybeTopic } }, Cmd.none )

        ExternalLink url ->
            ( { model | session = { session | destination = Just url } }, Cmd.none )

        Jump url ->
            ( model, load url )

        CloseDialog ->
            ( { model | session = { session | destination = Nothing } }, Cmd.none )

        PageMsg pmsg ->
            f pmsg model


sessionOnUrlRequest : UrlRequest -> Maybe (SessionMsg a)
sessionOnUrlRequest req =
    case req of
        Internal _ ->
            Nothing

        External url ->
            Just <| ExternalLink url


updateTopic : { a | session : Session } -> Maybe String -> { a | session : Session }
updateTopic model maybeTopic =
    let
        session =
            model.session

        topic =
            Maybe.withDefault "goat" maybeTopic
    in
    { model | session = { session | topic = topic } }
