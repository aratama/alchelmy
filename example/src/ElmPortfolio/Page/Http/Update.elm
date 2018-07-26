module ElmPortfolio.Page.Http.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.Http.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Json.Decode as Decode
import Http
import Navigation exposing (Location, newUrl)


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


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg, Maybe Root.AscentMsg )
update msg rootModel model =
    case msg of
        AscentMsg amsg ->
            ( rootModel, model, Cmd.none, Just amsg )

        MorePlease ->
            ( rootModel, { model | gifUrl = "waiting.gif" }, getRandomGif model.topic, Nothing )

        NewGif (Ok newUrl) ->
            ( rootModel, Model model.topic newUrl, Cmd.none, Nothing )

        NewGif (Err _) ->
            ( rootModel, model, Cmd.none, Nothing )


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


receive : Root.DescentMsg -> Maybe Msg
receive msg =
    Nothing
