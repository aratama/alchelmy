module ElmPortfolio.Page.Time.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.Time.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Time as Time exposing (second)
import Navigation exposing (Location)


route : Parser (Route -> a) a
route =
    map {} (s "time")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location route rootModel =
    ( 0, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Tick newTime ->
            ( rootModel, newTime, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Time.every second Tick
