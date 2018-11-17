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
    { init : Flags -> Url -> route -> ( { model | session : Session }, Cmd msg )
    , view : { model | session : Session } -> Document msg
    , update : msg -> { model | session : Session } -> ( { model | session : Session }, Cmd msg )
    , subscriptions : { model | session : Session } -> Sub msg
    , route : Parser (route -> a) a
    , navigated : Url -> route -> Session -> ( { model | session : Session }, Cmd msg )
    }

"""