module CoolSPA.Page.Preferences.Update exposing (..)

import UrlParser exposing (..)
import CoolSPA.Page.Preferences.Type exposing (Model, Msg(..), Route)
import CoolSPA.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location)


route : Parser (Route -> a) a
route =
    map {} (s "preferences")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location route rootModel =
    ( { value = rootModel.theme }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        InputUserName str ->
            ( rootModel, { model | value = str }, Cmd.none )

        SaveUserName ->
            ( { rootModel | theme = model.value }, model, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
