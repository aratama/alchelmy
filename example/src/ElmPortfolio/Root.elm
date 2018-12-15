-- alchelmy root page


module ElmPortfolio.Root exposing (Flags, Page, Session, initialSession)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key, load, pushUrl)
import Html exposing (Html, a, button, div, h1, header, p, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (onClick)
import Maybe exposing (Maybe, withDefault)
import Url exposing (Url)
import Url.Parser as UrlParser exposing (Parser)


type alias Flags =
    ()


type alias Session =
    { topic : String
    , destination : Maybe String
    }


type alias Page model msg route a =
    { init : Flags -> Url -> Key -> route -> Maybe Session -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : UrlRequest -> msg
    , route : Parser (route -> a) a
    , session : model -> Session
    }


initialSession : Session
initialSession =
    { topic = "goat", destination = Nothing }
