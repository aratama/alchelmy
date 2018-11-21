-- alchelmy page


module ElmPortfolio.Page.URLParsing exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import ElmPortfolio.Ports exposing (receiveThemeFromLocalStorage, requestThemeFromLocalStorage)
import ElmPortfolio.Root as Root exposing (Flags, Session, SessionMsg(..), initial, link, sessionOnUrlRequest, sessionUpdate, updateTopic)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Url as Url exposing (Protocol(..), Url)
import Url.Parser as UrlParser exposing ((</>), Parser, int, map, s)


type alias Msg =
    SessionMsg ()


type alias Model =
    { session : Session
    , id : Int
    , location : Url
    }


type alias Route =
    Int


route : Parser (Route -> c) c
route =
    s "url-parsing" </> int


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ location key id maybeSession =
    case maybeSession of
        Nothing ->
            ( { session = initial, id = id, location = location }, requestThemeFromLocalStorage () )

        Just session ->
            ( { session = session, id = id, location = location }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    sessionUpdate <|
        \msg model ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


view : Model -> Document Msg
view model =
    { title = "URLParsing - ElmPortfolio"
    , body =
        [ Root.view model.session <|
            div [ class "page-url-parser container" ]
                [ h1 [] [ text "URL Parsing" ]
                , p [] [ text <| "URL: " ++ Url.toString model.location ]
                , p [] [ text <| "Parameter: " ++ String.fromInt model.id ]
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
