module ElmPortfolio.Page.NotFound exposing (..)

import UrlParser as UrlParser exposing (s, Parser, (</>), map, top)
import Json.Decode as Decode
import Navigation exposing (Location, newUrl)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import ElmPortfolio.Root as Root

type Msg
    = Navigate String


type alias Model =
    {}


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () (s "not-found")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location _ rootModel =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


link : String -> String -> Html Msg
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view state model =
    div [ class "page-not-found" ]
        [ h1 [] [ text "404 Not Found" ]
        , p [] [ link "/" "Go to Top" ]
        ]

page : Root.Page Route Model Msg
page = {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
    }