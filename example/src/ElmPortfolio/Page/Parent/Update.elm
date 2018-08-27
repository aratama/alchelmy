module ElmPortfolio.Page.Parent.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.Parent.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location, newUrl)


route : Parser (Route -> a) a
route =
    map {} (s "parent")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location route rootModel =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg, Maybe Root.AscentMsg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url, Nothing )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


receive : Root.DescentMsg -> Maybe Msg
receive msg =
    Nothing
