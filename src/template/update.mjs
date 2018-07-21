export function renderUpdate(application, pageName){
  return `module ${application}.Page.${pageName}.Update exposing (..)

import UrlParser exposing (..)
import ${application}.Page.${pageName}.Type exposing (Model, Msg(..), Route)
import ${application}.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location)


route : Parser (Route -> a) a
route =
    map () (s "${pageName.toLowerCase()}")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init _ _ rootModel =
    ( {}, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    ( rootModel, model, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
`
}