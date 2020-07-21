module ElmPortfolio.Page.Top exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key)
import ElmPortfolio.Common as Common exposing (Page, Session, decodeSession, encodeSession, initialSession, link, updateTopic)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Json.Decode exposing (Value, decodeValue)
import Url exposing (Url)
import Url.Parser exposing (Parser, map, top)


type alias Msg =
    Common.Msg PageMsg


type PageMsg
    = NoOp


type alias Model =
    { key : Key
    , session : Session
    }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () top


init : Value -> Url -> Key -> Route -> ( Model, Cmd msg )
init value _ key _ =
    case decodeValue decodeSession value of
        Err _ ->
            ( { key = key, session = initialSession }, requestTopic () )

        Ok session ->
            ( { key = key, session = session }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Common.update <| \msg model -> ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveTopic Common.ReceiveTopic


view : Model -> Document Msg
view model =
    { title = "Top - ElmPortfolio"
    , body =
        [ Common.view model.session <|
            Html.map Common.PageMsg <|
                div [ class "page-top" ]
                    [ h1 [] [ text "Top" ]
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
    , session = \model -> encodeSession model.session
    }
