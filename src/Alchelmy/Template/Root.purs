module Alchelmy.Template.Root where

import Data.Semigroup ((<>))

renderRoot :: String -> String
renderRoot application = """
module """ <> application <> """.Root exposing (..)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import Url exposing (Url)
import Url.Parser exposing (Parser)

type alias Flags
  = ()

-- Application global state type.


type alias Session
  = {}


initial : Session
initial = {}


type alias Page a route model msg =
  { init : Flags -> Url -> route -> ( model, Cmd msg )
  , view : model -> Document msg
  , update : msg -> model -> ( model, Cmd msg )
  , subscriptions : model -> Sub msg
  , route : Parser ( route -> a ) a
  , navigated : Url -> route -> Session -> ( model, Cmd msg )
  }

"""