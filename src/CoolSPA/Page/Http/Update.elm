module CoolSPA.Page.Http.Update exposing (..)

import UrlParser exposing (..)
import CoolSPA.Page.Http.Type exposing (Model, Msg(..), Route)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Json.Decode as Decode
import Http
import Navigation exposing (Location)


route : Parser (Route -> a) a
route =
    map {} (s "http")


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
        MorePlease ->
            ( rootModel, model, getRandomGif model.topic )

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
