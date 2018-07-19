module CoolSPA.Page.Preferences.Update exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href)
import CoolSPA.Page.Preferences.Type exposing (Model, Msg(..))
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)


initialize : Root.Model -> ( Model, Cmd Msg )
initialize rootModel =
    ( { value = "" }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        InputUserName str ->
            ( rootModel, { model | value = str }, Cmd.none )

        SaveUserName ->
            ( { rootModel | user = model.value }, model, Cmd.none )


route : Parser (Model -> a) a
route =
    map { value = "" } (s "preferences")
