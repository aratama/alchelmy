module ElmPortfolio.Page.Http exposing (Route, Model, Msg, route, page)

import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Json.Decode as Decode
import Http
import Navigation exposing (Location, newUrl)
import Html exposing (Html, text, div, h1, img, a, p, button, h2, img, br)
import Html.Attributes exposing (src, href, class, src, href)
import ElmPortfolio.Root as Root
import Html.Events exposing (onClick, onWithOptions)

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


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location route rootModel =
    let
        topic =
            rootModel.theme
    in
        ( Model topic "waiting.gif", getRandomGif topic )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url )

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
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view state model =
    Root.view link state <|
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



page : Root.Page Route Model Msg
page = 
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }