module ElmPortfolio.Page.Minimum exposing (Model, Msg, Route, page)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import ElmPortfolio.Root as Root exposing (Session, initial)
import Html exposing (h1, text)
import Url exposing (Url)
import Url.Parser exposing (Parser, map, s)


type Msg
    = NoOp


type alias Model =
    { session : Session }


type alias Route =
    ()


page : Root.Page a Route Model Msg
page =
    { route = map () (s "minimum")
    , init = \_ _ session -> ( { session = session }, Cmd.none )
    , view = \_ -> { title = "Minimum - ElmPortfolio", body = [ h1 [] [ text "Minimum" ] ] }
    , update = \msg model -> ( model, Cmd.none )
    , subscriptions = \_ -> Sub.none
    }
