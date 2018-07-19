module CoolSPA.Page.NotFound.Update exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.NotFound.Type exposing (Model, Msg, Route)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map, top)


initial : Model
initial =
    {}


route : Parser (Route -> a) a
route =
    map {} (s "not-found")


initialize : Route -> Root.Model -> ( Model, Cmd Msg )
initialize _ rootModel =
    ( initial, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )
