module CoolSPA.Page.Parent.Update exposing (..)

import UrlParser exposing (..)
import CoolSPA.Page.Parent.Type exposing (Model, Msg, Route)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location)


route : Parser (Route -> a) a
route =
    map {} (s "parent")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location route rootModel =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
