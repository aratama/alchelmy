module ElmPortfolio.Page.NotFound.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.NotFound.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map, top)
import Json.Decode as Decode
import Navigation exposing (Location, newUrl)


route : Parser (Route -> a) a
route =
    map () (s "not-found")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location _ rootModel =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg, Maybe Root.AscentMsg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url, Nothing )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


receive : Root.DescentMsg -> Maybe Msg
receive msg =
    Nothing
