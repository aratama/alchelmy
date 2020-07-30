module ElmPortfolio.Page.URLParsing exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import ElmPortfolio.Common as Common exposing (Page, Session, decodeSession, encodeSession, initialSession, link, updateTopic)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import Html exposing (Html, a, button, div, h1, img, input, p, text)
import Html.Attributes exposing (class, href, src, value)
import Html.Events exposing (onClick, onInput)
import Json.Decode exposing (Value, decodeValue)
import Url as Url exposing (Protocol(..), Url)
import Url.Parser exposing ((</>), Parser, int, map, s)


type alias Msg =
    Common.Msg PageMsg


type PageMsg
    = Input String
    | PushUrl
    | UrlChange Url


type alias Model =
    { key : Key
    , session : Session
    , id : Int
    , location : Url
    , value : String
    }


type alias Route =
    Int


route : Parser (Route -> c) c
route =
    s "url-parsing" </> int


init : Value -> Url -> Key -> Route -> ( Model, Cmd Msg )
init value location key id =
    case decodeValue decodeSession value of
        Err _ ->
            ( { key = key, session = initialSession, id = id, location = location, value = "/url-parsing/" ++ String.fromInt id }, requestTopic () )

        Ok session ->
            ( { key = key, session = session, id = id, location = location, value = "/url-parsing/" ++ String.fromInt id }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Common.update <|
        \msg model ->
            case msg of
                Input value ->
                    ( { model | value = value }, Cmd.none )

                PushUrl ->
                    ( model, Browser.Navigation.pushUrl model.key <| model.value )

                UrlChange url ->
                    case Url.Parser.parse route url of
                        Nothing ->
                            ( model, Cmd.none )

                        Just id ->
                            ( { model | id = id }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveTopic Common.ReceiveTopic


view : Model -> Document Msg
view model =
    { title = "URLParsing - ElmPortfolio"
    , body =
        [ Common.view model.session <|
            Html.map Common.PageMsg <|
                div [ class "page-url-parser container" ]
                    [ h1 [] [ text "URL Parsing" ]
                    , p [] [ text <| "URL: " ++ Url.toString model.location ]
                    , p [] [ text <| "Parameter: " ++ String.fromInt model.id ]
                    , p [] [ input [ value model.value, onInput Input ] [], button [ onClick PushUrl ] [ text "pushUrl" ] ]
                    , p [] [ text "When url is changed, `page.onUrlChange` message is caused." ]
                    ]
        ]
    }


page : Page Model Msg Route a
page =
    { route = route
    , init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = Common.UrlRequest
    , onUrlChange = \url -> Common.PageMsg <| UrlChange url
    , session = \model -> encodeSession model.session
    }
