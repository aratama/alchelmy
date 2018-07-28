module TestProject.Update exposing (..)

import UrlParser exposing (..)
import TestProject.Type exposing (Model, Msg(..), AscentMsg(..), DescentMsg)
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location, newUrl)
import Maybe exposing (withDefault)


init : Location -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg, Maybe DescentMsg )
update msg model =
    case msg of
        ChangeRoute url ->
            ( model, newUrl url, Nothing )


receive : AscentMsg -> Maybe Msg
receive msg =
    case msg of
        Navigate url ->
            Just (ChangeRoute url)


subscriptions : Sub Msg
subscriptions =
    Sub.none