module ElmPortfolio.Page.Minimum exposing (Model, Msg, Route, page)

import Browser exposing (UrlRequest(..))
import Browser.Navigation exposing (Key)
import ElmPortfolio.Common exposing (Page, Session, defaultNavigation, encodeSession, initialSession)
import Html exposing (h1, text)
import Html.Attributes exposing (class)
import Url exposing (Url)
import Url.Parser exposing (map, s)


type Msg
    = UrlRequest UrlRequest
    | UrlChange Url


type alias Model =
    { session : Session
    , key : Key
    }


type alias Route =
    ()


page : Page Model Msg Route a
page =
    { route = map () (s "minimum")
    , init = \_ _ key _ -> ( { session = initialSession, key = key }, Cmd.none )
    , view = always { title = "Minimum - ElmPortfolio", body = [ h1 [ class "page-minimum" ] [ text "Minimum" ] ] }
    , update =
        \msg model ->
            case msg of
                UrlRequest urlRequest ->
                    defaultNavigation model urlRequest

                UrlChange url ->
                    ( model, Cmd.none )
    , subscriptions = always Sub.none
    , onUrlRequest = UrlRequest
    , onUrlChange = UrlChange
    , session = \model -> encodeSession model.session
    }
