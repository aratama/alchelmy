module CoolSPA.Page.NotFound.Update exposing (..)

import UrlParser exposing (..)
import CoolSPA.Page.NotFound.Type exposing (Model, Msg, Route)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map, top)
import Navigation exposing (Location)


initial : Model
initial =
    {}


route : Parser (Route -> a) a
route =
    map {} (s "not-found")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location _ rootModel =
    ( initial, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
