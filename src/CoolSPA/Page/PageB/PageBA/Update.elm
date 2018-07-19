module CoolSPA.Page.PageB.PageBA.Update exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.PageB.PageBA.Type exposing (Model, Msg, Route)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)


route : Parser (Route -> a) a
route =
    map Model (s "page-b" </> s "page-b-a")


initialize : Route -> Root.Model -> ( Model, Cmd Msg )
initialize _ rootModel =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )
