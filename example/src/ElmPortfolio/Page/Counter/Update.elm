module ElmPortfolio.Page.Counter.Update exposing (..)

import UrlParser exposing (..)
import ElmPortfolio.Page.Counter.Type exposing (Model, Msg(..), Route)
import ElmPortfolio.Type as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location, newUrl)


-- a `route` function defines a route to the page.


route : Parser (Route -> a) a
route =
    map () (s "counter")



-- an `init` function initializes the local state of the page with `Location`, `Route` and the global state.


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init _ _ _ =
    ( 0, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg, Root.ExternalMsg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url, Root.NoOp )

        Increment ->
            ( rootModel, model + 1, Cmd.none, Root.NoOp )

        Decrement ->
            ( rootModel, model - 1, Cmd.none, Root.NoOp )

        External ex ->
            ( rootModel, model, Cmd.none, ex )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


receive : Root.DescentMsg -> Maybe Msg
receive msg =
    Nothing
