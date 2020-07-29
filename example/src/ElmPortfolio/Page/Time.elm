module ElmPortfolio.Page.Time exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (Key, pushUrl)
import ElmPortfolio.Common as Common exposing (Page, Session, decodeSession, encodeSession, initialSession, link, updateTopic)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import Html exposing (Html, a, br, button, div, h1, h2, img, p, text)
import Html.Attributes exposing (class, href, src)
import Json.Decode exposing (decodeValue)
import Json.Encode exposing (Value)
import Svg exposing (circle, line, svg)
import Svg.Attributes exposing (cx, cy, fill, r, stroke, viewBox, width, x1, x2, y1, y2)
import Time as Time exposing (Posix, here, millisToPosix, toMinute, toSecond, utc)
import Url exposing (Url)
import Url.Parser exposing (Parser, map, s)


type alias Msg =
    Common.Msg PageMsg


type PageMsg
    = Tick Posix


type alias Model =
    { key : Key
    , session : Session
    , posix : Maybe Posix
    }


type alias Route =
    {}


route : Parser (Route -> a) a
route =
    map {} (s "time")


init : Value -> Url -> Key -> Route -> ( Model, Cmd Msg )
init value _ key _ =
    case decodeValue decodeSession value of
        Err _ ->
            ( { key = key, session = initialSession, posix = Nothing }, requestTopic () )

        Ok session ->
            ( { key = key, session = session, posix = Nothing }
              -- Mysterious bug workaround
              -- Originally, you can put just `Cmd.none`, however in the case the timer will not work.
              -- If you remove `route` in the routing, it work. Extremely confusing.
            , requestTopic ()
            )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Common.update <|
        \msg model ->
            case msg of
                Tick newTime ->
                    ( { model | posix = Just newTime }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.batch
        [ Sub.map Common.PageMsg <| Time.every 50 Tick
        , receiveTopic Common.ReceiveTopic
        ]


view : Model -> Document Msg
view model =
    { title = "Time - ElmPortfolio"
    , body =
        [ Common.view model.session <|
            Html.map Common.PageMsg <|
                div [ class "page-a container" ]
                    [ h1 [] [ text "Time" ]
                    , case model.posix of
                        Nothing ->
                            text ""

                        Just posix ->
                            let
                                angle =
                                    turns (toFloat (toSecond utc posix) / 60)

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


page : Page Model Msg Route a
page =
    { route = route
    , init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = Common.UrlRequest
    , onUrlChange = \url _ -> Common.NoOp
    , session = \model -> encodeSession model.session
    }
