module ElmPortfolio.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Type exposing (Model, Msg(..))
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


subscriptions : Sub Msg
subscriptions =
    Sub.none
