module CoolSPA.Page.PageC.Update exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.PageC.Type exposing (Model, Msg)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), int, map)


initialize : Cmd Msg
initialize =
    Cmd.none


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )


route : Parser (Model -> c) c
route =
    map Model (s "page-c" </> int)
