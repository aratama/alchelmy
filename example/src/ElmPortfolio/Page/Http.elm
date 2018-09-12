module ElmPortfolio.Page.Http exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Root as Root
import Html exposing (Html, a, br, button, div, h1, h2, img, p, text)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (custom, onClick)
import Http
import Json.Decode as Decode
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)


type Msg
    = Navigate String
    | MorePlease
    | NewGif (Result Http.Error String)


type alias Model =
    { topic : String
    , gifUrl : String
    }


type alias Route =
    ()


route : Parser (Route -> a) a
route =
    map () (s "http")


init : Url -> Route -> Root.Model -> ( Model, Cmd Msg )
init location _ rootModel =
    let
        topic =
            rootModel.theme
    in
    ( Model topic "waiting.gif", getRandomGif topic )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, pushUrl rootModel.key url )

        MorePlease ->
            ( rootModel, { model | gifUrl = "waiting.gif" }, getRandomGif model.topic )

        NewGif (Ok newUrl) ->
            ( rootModel, Model model.topic newUrl, Cmd.none )

        NewGif (Err _) ->
            ( rootModel, model, Cmd.none )


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


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


link : String -> String -> Html Msg
link url label =
    a [ href url ] [ text label ]


view : Root.Model -> Model -> Document Msg
view state model =
    { title = "Http - ElmPortfolio"
    , body =
        [ Root.view link state <|
            div [ class "page-http container" ]
                [ h1 [] [ text "Http" ]
                , h2 [] [ text <| "Theme: " ++ model.topic ]
                , button [ onClick MorePlease ] [ text "More Please!" ]
                , br [] []
                , img [ src model.gifUrl ] []
                , p []
                    [ text "Go to "
                    , link "/preferences" "the preferences page"
                    , text " to change theme."
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
