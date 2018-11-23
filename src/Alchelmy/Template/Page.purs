module Alchelmy.Template.Page where

import Data.Semigroup ((<>))
import Data.String.Common (toLower)

data Routing = RouteToPageName | RouteToTop | RouteToNothing

bracket :: String -> String
bracket str = "\"" <> str <> "\""

renderBlankPage :: String -> String -> Routing -> String
renderBlankPage application pageName routing = """-- alchelmy page

module """ <> application <> """.Page.""" <> pageName <> """ exposing (Route, Model, Msg, route, page)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Html exposing (text, h1)
import Maybe exposing (Maybe(..))
import Url exposing (Url)
import Url.Parser exposing (Parser, map, """ <> (case routing of
  RouteToPageName ->
    "s "
  RouteToTop ->
    "top"
  RouteToNothing ->
    "custom") <> """)
import """ <> application <> """.Root as Root exposing (Flags, Session)

type Msg
  = UrlRequest UrlRequest


type alias Model
  = { session : Session, key : Key }


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


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ _ key _ session
  = ( { session = Maybe.withDefault Root.initial session, key = key }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model
  = case msg of 
    UrlRequest urlRequest -> 
      case urlRequest of
        Internal url ->
          ( model, pushUrl model.key (Url.toString url) )
        External url -> 
          ( model, load url )

subscriptions : Model -> Sub Msg
subscriptions _
  = Sub.none


view : Model -> Document Msg
view model =
  { title = """ <> bracket (pageName <> " - " <> application) <> """
  , body = [ h1 [] [text """ <> bracket pageName <> """] ]
  }


page : Root.Page Model Msg Route a
page =
  { route = route
  , init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  , onUrlRequest = UrlRequest
  , session = \model -> model.session
  }

"""