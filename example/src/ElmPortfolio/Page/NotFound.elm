module ElmPortfolio.Page.NotFound exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, pushUrl)
import ElmPortfolio.Common as Common exposing (Page, Session, decodeSession, defaultNavigation, encodeSession, initialSession, link, updateTopic)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Json.Decode as Decode exposing (decodeValue)
import Json.Encode exposing (Value)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s, top)


type Msg
    = ReceiveTopic (Maybe String)
    | UrlRequest UrlRequest
    | UrlChange Url


type alias Model =
    { key : Key
    , session : Session
    }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () (s "not-found")


init : Value -> Url -> Key -> Route -> ( Model, Cmd Msg )
init value _ key _ =
    case decodeValue decodeSession value of
        Err _ ->
            ( { key = key, session = initialSession }, Cmd.none )

        Ok session ->
            ( { key = key, session = session }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveTopic topic ->
            ( updateTopic model topic, Cmd.none )

        UrlRequest urlRequest ->
            defaultNavigation model urlRequest

        UrlChange url ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveTopic ReceiveTopic


view : Model -> Document Msg
view model =
    { title = "NotFound - ElmPortfolio"
    , body =
        [ div [ class "page-not-found" ]
            [ h1 [] [ text "404 Not Found" ]
            , p [] [ link "/" "Go to Top" ]
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
    , onUrlRequest = UrlRequest
    , onUrlChange = UrlChange
    , session = \model -> encodeSession model.session
    }
