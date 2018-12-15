-- alchelmy page


module ElmPortfolio.Page.Http exposing (Model, Msg, Route, page, route)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import ElmPortfolio.Root as Root exposing (Flags, Session, SessionMsg(..), initialSession, link, sessionUpdate, updateTopic)
import Html exposing (Html, a, br, button, div, h1, h2, img, p, text)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (custom, onClick)
import Http
import Json.Decode as Decode
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)


type alias Msg =
    SessionMsg PageMsg


type PageMsg
    = MorePlease
    | NewGif (Result Http.Error String)


type alias Model =
    { session : Session
    , key : Key
    , gifUrl : String
    }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () (s "http")


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ _ key _ maybeSession =
    case maybeSession of
        Nothing ->
            ( Model initialSession key "waiting.gif", requestTopic () )

        Just session ->
            ( Model session key "waiting.gif", getRandomGif session.topic )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    sessionUpdate <|
        \msg model ->
            case msg of
                MorePlease ->
                    ( { model | gifUrl = "waiting.gif" }, getRandomGif model.session.topic )

                NewGif (Ok newUrl) ->
                    ( { model | gifUrl = newUrl }, Cmd.none )

                NewGif (Err _) ->
                    ( model, Cmd.none )


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    Cmd.map PageMsg <|
        Http.get
            { url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
            , expect = Http.expectJson NewGif decodeGifUrl
            }


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveTopic ReceiveTopic


view : Model -> Document Msg
view model =
    { title = "Http - ElmPortfolio"
    , body =
        [ Root.view model.session <|
            Html.map PageMsg <|
                div [ class "page-http container" ]
                    [ h1 [] [ text "Http" ]
                    , h2 [] [ text <| "Topic: " ++ model.session.topic ]
                    , button [ onClick MorePlease ] [ text "More Please!" ]
                    , br [] []
                    , img [ src model.gifUrl ] []
                    , p []
                        [ text "Go to "
                        , link "/preferences" "the preferences page"
                        , text " to change topic."
                        ]
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
    , onUrlRequest = UrlRequest
    , session = \model -> model.session
    }
