module ElmPortfolio.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Type exposing (Model, Msg(..), ExternalMsg(..))
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location, newUrl)


init : Location -> ( Model, Cmd Msg )
init _ =
    ( { theme = "goat" }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeRoute route ->
            ( model, Cmd.none )


updateEx : ExternalMsg -> Model -> ( Model, Cmd Msg )
updateEx msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        Nav url ->
            ( model, newUrl url )


subscriptions : Sub Msg
subscriptions =
    Sub.none
