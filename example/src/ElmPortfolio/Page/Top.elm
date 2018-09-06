module ElmPortfolio.Page.Top exposing (..)

import ElmPortfolio.Root as Root
import UrlParser exposing (..)
import UrlParser as UrlParser exposing (s, Parser, (</>), map, top)
import Navigation exposing (modifyUrl)
import Navigation exposing (Location, newUrl)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)

type Msg
    = Navigate String


type alias Model =
    {}


type alias Route =
    {}


route : Parser (Route -> a) a
route =
    map Model top


init : Location -> Route -> Root.Model -> ( Model, Cmd msg )
init location route rootModel =
    ( {}
    , if (location.pathname ++ location.hash) == "/" then
        Cmd.none
      else
        modifyUrl "/"
    )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


receive : Root.DescentMsg -> Maybe Msg
receive msg =
    Nothing

link : String -> String -> Html Msg
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view state model =
    Root.view link state <|
        div [ class "page-top" ]
            [ h1 [] [ text "Top" ]
            ]
