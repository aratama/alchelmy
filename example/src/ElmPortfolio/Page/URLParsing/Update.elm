module ElmPortfolio.Page.URLParsing.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.URLParsing.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), int, map)
import Navigation exposing (Location, newUrl)


route : Parser (Route -> c) c
route =
    s "url-parsing" </> int


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location id rootModel =
    ( { id = id, location = location }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


receive : Root.DescentMsg -> Maybe Msg
receive msg =
    Nothing
