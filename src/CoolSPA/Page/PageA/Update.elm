module CoolSPA.Page.PageA.Update exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.PageA.Type exposing (Model, Msg(..))
import UrlParser as UrlParser exposing (s, Parser, (</>), map)


initialize : Cmd Msg
initialize =
    Cmd.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( model + 1, Cmd.none )

        Decrement ->
            ( model - 1, Cmd.none )


route : Parser (Model -> a) a
route =
    map 0 (s "page-a")
