module ElmPortfolio.Page.Top exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import ElmPortfolio.Ports exposing (receiveThemeFromLocalStorage, requestThemeFromLocalStorage)
import ElmPortfolio.Root as Root exposing (Flags, Session, initial, link, updateTopic)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
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
    map () top


init : Flags -> Url -> Route -> ( Model, Cmd msg )
init _ _ _ =
    ( { session = initial }, requestThemeFromLocalStorage () )


navigated : Url -> Route -> Session -> ( Model, Cmd msg )
navigated _ _ session =
    ( { session = initial }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage topic ->
            ( updateTopic model topic, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


view : Model -> Document Msg
view model =
    { title = "Top - ElmPortfolio"
    , body =
        [ Root.view model.session <|
            div [ class "page-top" ]
                [ h1 [] [ text "Top" ]
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
