module ElmPortfolio.Common exposing (Msg(..), Page, Session, decodeSession, defaultNavigation, encodeSession, initialSession, link, update, updateTopic, view)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Html exposing (Html, a, button, div, h1, header, p, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Json.Decode
import Json.Encode exposing (Value)
import Maybe exposing (Maybe, withDefault)
import Url exposing (Url)
import Url.Parser exposing (Parser)


type alias Session =
    { topic : String
    , destination : Maybe String
    }


initialSession : Session
initialSession =
    { topic = "goat"
    , destination = Nothing
    }


decodeSession : Json.Decode.Decoder Session
decodeSession =
    Json.Decode.map2 Session
        (Json.Decode.field "topic" Json.Decode.string)
        (Json.Decode.field "destination" <| Json.Decode.maybe Json.Decode.string)


encodeSession : Session -> Value
encodeSession session =
    Json.Encode.object
        [ ( "topic", Json.Encode.string session.topic )
        , ( "destination", Maybe.withDefault Json.Encode.null <| Maybe.map Json.Encode.string session.destination )
        ]


type alias Page model msg route a =
    { init : Value -> Url -> Key -> route -> Maybe Value -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : UrlRequest -> msg
    , route : Parser (route -> a) a
    , session : model -> Value
    }


link : String -> String -> Html msg
link url label =
    a [ href url ] [ text label ]


view : Session -> Html (Msg msg) -> Html (Msg msg)
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
                            [ text "Would you go to \""
                            , text destination
                            , text "\" ?"
                            ]
                        , div [ class "lower" ]
                            [ button [ onClick (Jump destination) ] [ text "Go to the page" ]
                            , button [ onClick CloseDialog ] [ text "Cancel" ]
                            ]
                        ]
                    ]
        ]


type Msg a
    = ReceiveTopic (Maybe String)
    | ExternalLink String
    | Jump String
    | CloseDialog
    | PageMsg a
    | UrlRequest UrlRequest


update :
    (a -> { model | session : Session, key : Key } -> ( { model | session : Session, key : Key }, Cmd (Msg a) ))
    -> Msg a
    -> { model | session : Session, key : Key }
    -> ( { model | session : Session, key : Key }, Cmd (Msg a) )
update f msg model =
    let
        session =
            model.session
    in
    case msg of
        ReceiveTopic maybeTopic ->
            ( { model | session = { session | topic = Maybe.withDefault "goat" maybeTopic } }, Cmd.none )

        ExternalLink url ->
            ( { model | session = { session | destination = Just url } }, Cmd.none )

        Jump url ->
            ( model, load url )

        CloseDialog ->
            ( { model | session = { session | destination = Nothing } }, Cmd.none )

        PageMsg pmsg ->
            f pmsg model

        UrlRequest urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model
                    , pushUrl model.key (Url.toString url)
                    )

                External url ->
                    ( { model | session = { session | destination = Just url } }
                    , Cmd.none
                    )


updateTopic : { a | session : Session } -> Maybe String -> { a | session : Session }
updateTopic model maybeTopic =
    let
        session =
            model.session

        topic =
            Maybe.withDefault "goat" maybeTopic
    in
    { model | session = { session | topic = topic } }


defaultNavigation : { model | session : Session, key : Key } -> UrlRequest -> ( { model | session : Session, key : Key }, Cmd msg )
defaultNavigation model urlRequest =
    case urlRequest of
        Internal url ->
            ( model
            , pushUrl model.key (Url.toString url)
            )

        External url ->
            ( model
            , load url
            )
