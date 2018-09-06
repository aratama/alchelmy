module ElmPortfolio.Page.Time exposing (Route, Model, Msg, route, page)

import Time exposing (Time)
import ElmPortfolio.Root as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Time as Time exposing (second)
import Navigation exposing (Location, newUrl)
import Html exposing (Html, text, div, h1, img, a, p, button, h2, img, br)
import Html.Attributes exposing (src, href, class, src)
import Svg exposing (svg, circle, line)
import Svg.Attributes exposing (viewBox, width, cx, cy, r, fill, x1, y1, x2, y2, stroke)

type Msg
    = Navigate String
    | Tick Time


type alias Model =
    Time


type alias Route =
    {}

route : Parser (Route -> a) a
route =
    map {} (s "time")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location route rootModel =
    ( 0, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url )

        Tick newTime ->
            ( rootModel, newTime, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Time.every second Tick


link : String -> String -> Html Msg
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view state model =
    Root.view link state <|
        div [ class "page-a container" ]
            [ h1 [] [ text "Time" ]
            , let
                angle =
                    turns (Time.inMinutes model)

                handX =
                    toString (50 + 40 * cos angle)

                handY =
                    toString (50 + 40 * sin angle)
              in
                svg [ viewBox "0 0 100 100", width "300px" ]
                    [ circle [ cx "50", cy "50", r "45", fill "#5b91ba" ] []
                    , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
                    ]
            ]

page : Root.Page a Route Model Msg
page = 
  { route = route
  , init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }