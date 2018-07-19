module CoolSPA.Page.PageC.Update exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.PageC.Type exposing (Model, Msg, Route)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), int, map)


route : Parser (Route -> c) c
route =
    map Model (s "page-c" </> int)


initialize : Route -> Root.Model -> ( Model, Cmd Msg )
initialize route rootModel =
    ( { id = 0 }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )
