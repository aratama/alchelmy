-- alchelmy page


module ElmPortfolio.Page.Top exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import ElmPortfolio.Root as Root exposing (Flags, Session, SessionMsg(..), initialSession, link, sessionOnUrlRequest, sessionUpdate, updateTopic)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s, top)


type alias Msg =
    SessionMsg PageMsg


type PageMsg
    = NoOp


type alias Model =
    { session : Session }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () top


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd msg )
init _ _ _ _ maybeSession =
    case maybeSession of
        Nothing ->
            ( { session = initialSession }, requestTopic () )

        Just session ->
            ( { session = session }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    sessionUpdate <| \msg model -> ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveTopic ReceiveTopic


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


page : Root.Page Model Msg Route a
page =
    { route = route
    , init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = sessionOnUrlRequest
    }
