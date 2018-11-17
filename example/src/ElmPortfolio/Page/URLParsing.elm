module ElmPortfolio.Page.URLParsing exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import ElmPortfolio.Ports exposing (receiveThemeFromLocalStorage, requestThemeFromLocalStorage)
import ElmPortfolio.Root as Root exposing (Session, initial, link, updateTopic)
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, int, map, s)


type Msg
    = ReceiveThemeFromLocalStorage (Maybe String)


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


init : Url -> Route -> ( Model, Cmd Msg )
init location id =
    ( { session = initial, id = id, location = location }, requestThemeFromLocalStorage () )


navigated : Url -> Route -> Session -> ( Model, Cmd Msg )
navigated location id session =
    ( { session = session, id = id, location = location }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage topic ->
            ( updateTopic model topic, Cmd.none )


subscriptions : Session -> Sub Msg
subscriptions _ =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


view : Model -> Document Msg
view model =
    { title = "URLParsing - ElmPortfolio"
    , body =
        [ Root.view model.session <|
            div [ class "page-url-parser container" ]
                [ h1 [] [ text "URL Parsing" ]
                , p []
                    [ text <|
                        model.location.host
                            ++ model.location.path
                            ++ Maybe.withDefault "" model.location.query
                            ++ Maybe.withDefault "" model.location.fragment
                    ]
                , p [] [ text <| "Parameter: " ++ String.fromInt model.id ]
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
