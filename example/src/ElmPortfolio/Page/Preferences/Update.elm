module ElmPortfolio.Page.Preferences.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.Preferences.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location, newUrl)
import ElmPortfolio.Ports exposing (saveThemeToLocalStorage)


route : Parser (Route -> a) a
route =
    map {} (s "preferences")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location route rootModel =
    ( { value = rootModel.theme }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg, Root.AscentMsg )
update msg rootModel model =
    case msg of
        AscentMsg amsg ->
            ( rootModel, model, Cmd.none, amsg )

        InputUserName str ->
            ( rootModel, { model | value = str }, Cmd.none, Root.NoOp )

        SaveUserName ->
            ( { rootModel | theme = model.value }, model, saveThemeToLocalStorage model.value, Root.NoOp )

        Initialize ->
            ( rootModel, { model | value = rootModel.theme }, Cmd.none, Root.NoOp )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


receive : Root.DescentMsg -> Maybe Msg
receive msg =
    case msg of
        Root.Initialize ->
            Just Initialize
