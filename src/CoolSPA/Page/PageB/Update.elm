module CoolSPA.Page.PageB.Update exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.PageB.Type exposing (Model, Msg)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)


initialize : Root.Model -> ( Model, Cmd Msg )
initialize rootModel =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )


route : Parser (Model -> a) a
route =
    map Model (s "page-b")
