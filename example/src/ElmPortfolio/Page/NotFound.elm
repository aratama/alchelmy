-- alchelmy page


module ElmPortfolio.Page.NotFound exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, pushUrl)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import ElmPortfolio.Root as Root exposing (Flags, Session, SessionMsg(..), initialSession, link, updateTopic, defaultNavigation)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Json.Decode as Decode
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s, top)


type Msg
    = ReceiveTopic (Maybe String)
    | UrlRequest UrlRequest


type alias Model =
    { session : Session, key : Key }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () (s "not-found")


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ _ key _ maybeSession =
    case maybeSession of
        Nothing ->
            ( { session = initialSession, key = key }, requestTopic () )

        Just session ->
            ( { session = session, key = key }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = 
    case msg of
        ReceiveTopic topic ->
            ( updateTopic model topic, Cmd.none )

        UrlRequest urlRequest ->
            defaultNavigation model urlRequest


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


page : Root.Page Model Msg Route a
page =
    { route = route
    , init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = UrlRequest
    , session = \model -> model.session
    }
