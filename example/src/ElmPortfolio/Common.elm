module ElmPortfolio.Common exposing (Msg(..), defaultNavigation, link, update, updateTopic, view)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import ElmPortfolio.Root exposing (Session)
import Html exposing (Html, a, button, div, h1, header, p, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Maybe exposing (Maybe, withDefault)
import Url exposing (Url)
import Url.Parser as UrlParser exposing (Parser)


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
    (a -> { model | session : Session } -> ( { model | session : Session }, Cmd (Msg a) ))
    -> Msg a
    -> { model | session : Session }
    -> ( { model | session : Session }, Cmd (Msg a) )
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
                    , pushUrl model.session.key (Url.toString url)
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


defaultNavigation : { model | session : Session } -> UrlRequest -> ( { model | session : Session }, Cmd msg )
defaultNavigation model urlRequest =
    case urlRequest of
        Internal url ->
            ( model
            , pushUrl model.session.key (Url.toString url)
            )

        External url ->
            let
                session =
                    model.session
            in
            ( model
            , load url
            )
