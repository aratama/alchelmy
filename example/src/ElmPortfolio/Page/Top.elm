module ElmPortfolio.Page.Top exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Root as Root
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s, top)


type Msg
    = Navigate String


type alias Model =
    {}


type alias Route =
    {}


route : Parser (Route -> a) a
route =
    map Model top


init : Url -> Route -> Root.Model -> ( Model, Cmd msg )
init location _ rootModel =
    ( {}
    , if (location.path ++ Maybe.withDefault "" location.fragment) == "/" then
        Cmd.none

      else
        pushUrl rootModel.key "/"
    )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, pushUrl rootModel.key url )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


link : String -> String -> Html Msg
link url label =
    a [ href url ] [ text label ]


view : Root.Model -> Model -> Document Msg
view state model =
    { title = "Top - ElmPortfolio"
    , body =
        [ Root.view link state <|
            div [ class "page-top" ]
                [ h1 [] [ text "Top" ]
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
