module ElmPortfolio.Page.Top.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.Top.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map, top)
import Navigation exposing (modifyUrl)
import Navigation exposing (Location, newUrl)


route : Parser (Route -> a) a
route =
    map Model top


init : Location -> Route -> Root.Model -> ( Model, Cmd msg )
init location route rootModel =
    ( {}
    , if (location.pathname ++ location.hash) == "/" then
        Cmd.none
      else
        modifyUrl "/"
    )


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
