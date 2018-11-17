module ElmPortfolio.Page.Time exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Ports exposing (receiveThemeFromLocalStorage, requestThemeFromLocalStorage)
import ElmPortfolio.Root as Root exposing (Flags, Session, initial, link, updateTopic)
import Html exposing (Html, a, br, button, div, h1, h2, img, p, text)
import Html.Attributes exposing (class, href, src)
import Svg exposing (circle, line, svg)
import Svg.Attributes exposing (cx, cy, fill, r, stroke, viewBox, width, x1, x2, y1, y2)
import Time as Time exposing (Posix, here, millisToPosix, toMinute, toSecond, utc)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)


type Msg
    = ReceiveThemeFromLocalStorage (Maybe String)
    | Tick Posix


type alias Model =
    { session : Session
    , posix : Posix
    }


type alias Route =
    {}


route : Parser (Route -> a) a
route =
    map {} (s "time")


init : Flags -> Url -> Route -> ( Model, Cmd Msg )
init _ _ _ =
    ( { session = initial, posix = millisToPosix 0 }, requestThemeFromLocalStorage () )


navigated : Url -> Route -> Session -> ( Model, Cmd Msg )
navigated _ _ session =
    ( { session = session, posix = millisToPosix 0 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage topic ->
            ( updateTopic model topic, Cmd.none )

        Tick newTime ->
            ( { model | posix = newTime }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Time.every 1000 Tick
        , receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage
        ]


view : Model -> Document Msg
view model =
    { title = "Time - ElmPortfolio"
    , body =
        [ Root.view model.session <|
            div [ class "page-a container" ]
                [ h1 [] [ text "Time" ]
                , let
                    angle =
                        turns (toFloat (toSecond utc model.posix) / 60)

                    handX =
                        String.fromFloat (50 + 40 * cos angle)

                    handY =
                        String.fromFloat (50 + 40 * sin angle)
                  in
                  svg [ viewBox "0 0 100 100", width "300px" ]
                    [ circle [ cx "50", cy "50", r "45", fill "#5b91ba" ] []
                    , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
                    ]
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
