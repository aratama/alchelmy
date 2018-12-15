-- alchelmy page


module ElmPortfolio.Page.Sub.Minimum exposing (Model, Msg, Route, page)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key)
import ElmPortfolio.Common as Common exposing (defaultNavigation)
import ElmPortfolio.Root as Root exposing (Flags, Session, initialSession)
import Html exposing (h1, text)
import Html.Attributes exposing (class)
import Url exposing (Url)
import Url.Parser exposing (Parser, map, s)


type Msg
    = UrlRequest UrlRequest


type alias Model =
    { session : Session, key : Key }


type alias Route =
    ()


page : Root.Page Model Msg Route a
page =
    { route = map () (s "minimum")
    , init = \_ _ key _ session -> ( { session = Maybe.withDefault initialSession session, key = key }, Cmd.none )
    , view = always { title = "Minimum - ElmPortfolio", body = [ h1 [ class "page-minimum" ] [ text "Minimum" ] ] }
    , update =
        \msg model ->
            case msg of
                UrlRequest urlRequest ->
                    defaultNavigation model urlRequest
    , subscriptions = always Sub.none
    , onUrlRequest = UrlRequest
    , session = \model -> model.session
    }
