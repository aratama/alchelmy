module CoolSPA.Page.Top.Update exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.Top.Type exposing (Model, Msg, Route)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map, top)
import Navigation exposing (modifyUrl)


initialize : Cmd msg
initialize =
    modifyUrl "/#/"


update : Msg -> Root.Model -> Model -> ( Model, Cmd Msg )
update msg rootModel model =
    ( model, Cmd.none )


route : Parser (Model -> a) a
route =
    map Model top
