module TestProject.Update exposing (..)

import UrlParser exposing (..)
import TestProject.Type exposing (Model, Msg(..), AscentMsg(..), DescentMsg(..))
import UrlParser as UrlParser exposing (s, Parser, (</>), map, parseHash)
import Navigation exposing (Location, newUrl)
import Maybe exposing (withDefault)


init : Location -> ( Model, Cmd Msg )
init _ =
    ( "initial", Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg, Maybe DescentMsg )
update msg model =
    case msg of
        StartTest state ->
            ( model, Cmd.none, Just (SendToChild state) )

        SetState state ->
            ( state, Cmd.none, Nothing )


receive : AscentMsg -> Maybe Msg
receive msg =
    case msg of
        SetRootState state ->
            Just (SetState state)


subscriptions : Sub Msg
subscriptions =
    Sub.none


parse : Parser (a -> a) a -> Location -> Maybe a
parse =
    parseHash
