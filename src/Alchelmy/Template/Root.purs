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
  = { key : Key }


type Msg
  = NoOp


type alias Page a route model msg =
  { route : Parser ( route -> a ) a
  , init : Url -> route -> Session -> ( model, Cmd msg )
  , update : msg -> model -> ( model, Cmd msg )
  , subscriptions : Session -> Sub msg
  , view : model -> Document msg
  }

init : Flags -> Url -> Key -> ( Session, Cmd Msg )
init _ _ key
  = ( { key = key }, Cmd.none )


update : Msg -> Session -> ( Session, Cmd Msg )
update msg model
  = (model, Cmd.none)


subscriptions : Sub Msg
subscriptions
  = Sub.none

"""