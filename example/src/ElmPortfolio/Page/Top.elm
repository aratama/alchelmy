module ElmPortfolio.Page.Top exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import ElmPortfolio.Root as Root exposing (Session)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s, top)


type Msg
    = NoOp


type alias Model =
    { session : Session }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () top


init : Url -> Route -> Session -> ( Model, Cmd msg )
init location _ session =
    ( { session = session }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


subscriptions : Session -> Sub Msg
subscriptions _ =
    Sub.none


link : String -> String -> Html Msg
link url label =
    a [ href url ] [ text label ]


view : Model -> Document Msg
view model =
    { title = "Top - ElmPortfolio"
    , body =
        [ Root.view link model.session <|
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
