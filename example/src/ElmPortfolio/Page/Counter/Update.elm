module ElmPortfolio.Page.Counter.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.Counter.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location)


route : Parser (Route -> a) a
route =
    map () (s "counter")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init _ _ _ =
    ( 0, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Increment ->
            ( rootModel, model + 1, Cmd.none )

        Decrement ->
            ( rootModel, model - 1, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
