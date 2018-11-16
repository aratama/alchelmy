module Alchelmy.Template.Page where

import Data.Semigroup ((<>))
import Data.String.Common (toLower)

data Routing = RouteToPageName | RouteToTop | RouteToNothing

bracket :: String -> String
bracket str = "\"" <> str <> "\""

renderBlankPage :: String -> String -> Routing -> String
renderBlankPage application pageName routing = """
module """ <> application <> """.Page.""" <> pageName <> """ exposing (Route, Model, Msg, route, page)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import Html exposing (text, h1)
import Url exposing (Url)
import Url.Parser exposing (Parser, map, """ <> (case routing of
  RouteToPageName ->
    "s "
  RouteToTop ->
    "top"
  RouteToNothing ->
    "custom") <> """)
import """ <> application <> """.Root as Root exposing (Session)

type Msg
  = NoOp


type alias Model
  = { session : Session }


type alias Route
  = ()


route : Parser (Route -> a) a
route =
  """ <> (case routing of
            RouteToPageName ->
              "map () (s " <> bracket (toLower pageName) <> ")"
            RouteToTop ->
              "map () top"
            RouteToNothing ->
              "custom \"NOTHING\" (\\_ -> Nothing)") <> """


init : Url -> Route -> Session -> ( Model, Cmd Msg )
init _ _ session
  = ( { session = session }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model
  = ( model, Cmd.none )


subscriptions : Session -> Sub Msg
subscriptions _
  = Sub.none


view : Model -> Document Msg
view model =
  { title = """ <> bracket (pageName <> " - " <> application) <> """
  , body = [ h1 [] [text """ <> bracket pageName <> """] ]
  }


page : Root.Page a Route Model Msg
page =
  { route = route
  , init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

"""