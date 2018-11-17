module ElmPortfolio.Page.NotFound exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Ports exposing (receiveThemeFromLocalStorage, requestThemeFromLocalStorage)
import ElmPortfolio.Root as Root exposing (Session, initial, link, updateTopic)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Json.Decode as Decode
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s, top)


type Msg
    = ReceiveThemeFromLocalStorage (Maybe String)


type alias Model =
    { session : Session }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () (s "not-found")


init : Url -> Route -> ( Model, Cmd Msg )
init url _ =
    ( { session = initial }, requestThemeFromLocalStorage () )


navigated : Url -> Route -> Session -> ( Model, Cmd Msg )
navigated url _ session =
    ( { session = session }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage topic ->
            ( updateTopic model topic, Cmd.none )


subscriptions : Session -> Sub Msg
subscriptions _ =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


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


page : Root.Page a Route Model Msg
page =
    { route = route
    , init = init
    , navigated = navigated
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
