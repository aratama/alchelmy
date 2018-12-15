module ElmPortfolio.Page.Top exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key)
import ElmPortfolio.Common as Common exposing (link, updateTopic)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import ElmPortfolio.Root as Root exposing (Flags, Session, initialSession)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s, top)


type alias Msg =
    Common.Msg PageMsg


type PageMsg
    = NoOp


type alias Model =
    { session : Session
    }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () top


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd msg )
init _ _ key _ maybeSession =
    case maybeSession of
        Nothing ->
            ( { session = initialSession key }, requestTopic () )

        Just session ->
            ( { session = session }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Common.update <| \msg model -> ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveTopic Common.ReceiveTopic


view : Model -> Document Msg
view model =
    { title = "Top - ElmPortfolio"
    , body =
        [ Common.view model.session <|
            Html.map Common.PageMsg <|
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
    , onUrlRequest = Common.UrlRequest
    , session = \model -> model.session
    }
