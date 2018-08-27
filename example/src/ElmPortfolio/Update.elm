module ElmPortfolio.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Type exposing (Model, Msg(..), DescentMsg(Initialize))
import UrlParser as UrlParser exposing (s, Parser, (</>), map, parsePath)
import Navigation exposing (Location, newUrl)
import ElmPortfolio.Ports exposing (requestThemeFromLocalStorage, receiveThemeFromLocalStorage)
import Maybe exposing (withDefault)


init : Location -> ( Model, Cmd Msg )
init _ =
    ( { theme = "goat" }, requestThemeFromLocalStorage () )


update : Msg -> Model -> ( Model, Cmd Msg, Maybe DescentMsg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage themeMaybe ->
            ( { model | theme = withDefault model.theme themeMaybe }, Cmd.none, Just Initialize )


subscriptions : Sub Msg
subscriptions =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


parse : Parser (a -> a) a -> Location -> Maybe a
parse =
    parsePath
