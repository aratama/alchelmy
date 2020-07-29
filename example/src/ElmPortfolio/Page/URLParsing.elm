module ElmPortfolio.Page.URLParsing exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import ElmPortfolio.Common as Common exposing (Page, Session, decodeSession, encodeSession, initialSession, link, updateTopic)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Json.Decode exposing (Value, decodeValue)
import Url as Url exposing (Protocol(..), Url)
import Url.Parser exposing ((</>), Parser, int, map, s)


type alias Msg =
    Common.Msg ()


type alias Model =
    { key : Key
    , session : Session
    , id : Int
    , location : Url
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
            ( { key = key, session = initialSession, id = id, location = location }, requestTopic () )

        Ok session ->
            ( { key = key, session = session, id = id, location = location }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Common.update <|
        \msg model ->
            ( model, Cmd.none )


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
    , onUrlChange = Common.UrlChange
    , session = \model -> encodeSession model.session
    }
