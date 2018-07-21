module CoolSPA.Page.URLParsing.Update exposing (..)

import UrlParser exposing (..)
import CoolSPA.Page.URLParsing.Type exposing (Model, Msg, Route)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), int, map)
import Navigation exposing (Location)


route : Parser (Route -> c) c
route =
    s "url-parsing" </> int


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location id rootModel =
    ( { id = id, location = location }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
