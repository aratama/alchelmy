module ElmPortfolio.Page.Http exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import ElmPortfolio.Ports exposing (receiveThemeFromLocalStorage, requestThemeFromLocalStorage)
import ElmPortfolio.Root as Root exposing (Session, initial, link, updateTopic)
import Html exposing (Html, a, br, button, div, h1, h2, img, p, text)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (custom, onClick)
import Http
import Json.Decode as Decode
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)


type Msg
    = ReceiveThemeFromLocalStorage (Maybe String)
    | MorePlease
    | NewGif (Result Http.Error String)


type alias Model =
    { session : Session
    , gifUrl : String
    }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () (s "http")


init : Url -> Route -> ( Model, Cmd Msg )
init location _ =
    ( Model initial "waiting.gif", requestThemeFromLocalStorage () )


navigated : Url -> Route -> Session -> ( Model, Cmd Msg )
navigated location _ session =
    ( Model session "waiting.gif", getRandomGif session.topic )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage topic ->
            let
                model_ =
                    updateTopic model topic
            in
            ( model_, getRandomGif model_.session.topic )

        MorePlease ->
            ( { model | gifUrl = "waiting.gif" }, getRandomGif model.session.topic )

        NewGif (Ok newUrl) ->
            ( { model | gifUrl = newUrl }, Cmd.none )

        NewGif (Err _) ->
            ( model, Cmd.none )


getRandomGif : String -> Cmd Msg
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    in
    Http.send NewGif (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string


subscriptions : Session -> Sub Msg
subscriptions _ =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


view : Model -> Document Msg
view model =
    { title = "Http - ElmPortfolio"
    , body =
        [ Root.view model.session <|
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


page : Root.Page a Route Model Msg
page =
    { route = route
    , init = init
    , navigated = navigated
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
