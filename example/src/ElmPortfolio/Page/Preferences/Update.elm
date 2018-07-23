module ElmPortfolio.Page.Preferences.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.Preferences.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location, newUrl)


route : Parser (Route -> a) a
route =
    map {} (s "preferences")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location route rootModel =
    ( { value = rootModel.theme }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url )

        InputUserName str ->
            ( rootModel, { model | value = str }, Cmd.none )

        SaveUserName ->
            ( { rootModel | theme = model.value }, model, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
