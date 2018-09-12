module ElmPortfolio.Page.Time exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Root as Root
import Html exposing (Html, a, br, button, div, h1, h2, img, p, text)
import Html.Attributes exposing (class, href, src)
import Svg exposing (circle, line, svg)
import Svg.Attributes exposing (cx, cy, fill, r, stroke, viewBox, width, x1, x2, y1, y2)
import Time as Time exposing (Posix, here, millisToPosix, toMinute, toSecond, utc)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)


type Msg
    = Navigate String
    | Tick Posix


type alias Model =
    Posix


type alias Route =
    {}


route : Parser (Route -> a) a
route =
    map {} (s "time")


init : Url -> Route -> Root.Model -> ( Model, Cmd Msg )
init location _ rootModel =
    ( millisToPosix 0, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, pushUrl rootModel.key url )

        Tick newTime ->
            ( rootModel, newTime, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Time.every 1000 Tick


link : String -> String -> Html Msg
link url label =
    a [ href url ] [ text label ]


view : Root.Model -> Model -> Document Msg
view state model =
    { title = "Time - ElmPortfolio"
    , body =
        [ Root.view link state <|
            div [ class "page-a container" ]
                [ h1 [] [ text "Time" ]
                , let
                    angle =
                        turns (toFloat (toSecond utc model) / 60)

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
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
