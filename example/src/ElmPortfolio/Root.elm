module ElmPortfolio.Root exposing (..)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key)
import Maybe exposing (Maybe)
import Url exposing (Url)
import Url.Parser exposing (Parser)

type alias Flags
  = ()

-- Application global state type.


type alias Session
  = {}


initial : Session
initial = {}


type alias Page model msg route a =
    { init : Flags -> Url -> Key -> route -> Maybe Session -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , route : Parser (route -> a) a
    , onUrlRequest : UrlRequest -> msg
    , session : model -> Session
    }

