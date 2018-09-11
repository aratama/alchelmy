export function renderRoot(application) {
  return `module ${application}.Root exposing (..)

import Browser exposing (Document)
import Browser.Navigation exposing (Key)
import Url exposing (Url)
import Url.Parser exposing (Parser)

type alias Flags 
  = ()

-- Application global state type.


type alias Model 
  = { key : Key }
  

type Msg
  = NoOp


type alias Page a route model msg =
  { route : Parser ( route -> a ) a
  , init : Url -> route -> Model -> ( model, Cmd msg )
  , update : msg -> Model -> model -> ( Model, model, Cmd msg )
  , subscriptions : Model -> Sub msg
  , view : Model -> model -> Document msg
  }

init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init _ _ key 
  = ( { key = key }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model 
  = (model, Cmd.none)


subscriptions : Sub Msg
subscriptions 
  = Sub.none

`.trimLeft();
}
