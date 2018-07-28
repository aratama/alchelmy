module TestProject.Page.MsgTest.Update exposing (route, init, update, subscriptions, receive)

import TestProject.Page.MsgTest.Type exposing (Model, Msg(..), Route)
import TestProject.Type as Root
import UrlParser as UrlParser exposing (Parser, s, (</>), map)
import Navigation exposing (Location, newUrl)


route : Parser (Route -> a) a
route =
    map () (s "msgtest")


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init _ _ rootModel =
    ( {}, Cmd.none )


receive : Root.DescentMsg -> Maybe Msg
receive msg =
    Nothing
    

update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg, Maybe Root.AscentMsg )
update msg rootModel model =
    case msg of
        AscentMsg amsg ->
            ( rootModel, model, Cmd.none, Just amsg )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none
