module ElmPortfolio.Page.Counter exposing (Model, Msg, Route, page)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key)
import ElmPortfolio.Common as Common exposing (Page, Session, decodeSession, encodeSession, initialSession, link, updateTopic)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import Html exposing (Html, a, button, div, h1, p, text)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (custom, onClick)
import Json.Decode exposing (decodeValue)
import Json.Encode exposing (Value)
import Url exposing (Url)
import Url.Parser exposing ((</>), Parser, map, s)



-- `Route` is a container that stores parameters from the url and deliver into `init` function.
-- If it does not extract any parameter from path, `Route` is just `Unit`


type alias Route =
    ()



-- `Msg` is a local message container of the page.


type alias Msg =
    Common.Msg PageMsg


type PageMsg
    = Increment
    | Decrement



-- `Msg` is a local state container that stores the state of the page.


type alias Model =
    { key : Key
    , session : Session
    , count : Int
    }



-- a `route` function defines a route to the page.


route : Parser (Route -> a) a
route =
    map () (s "counter")



-- an `init` function initializes the local state of the page with `Url`, `Route` and the global state.


init : Value -> Url -> Key -> Route -> Maybe Value -> ( Model, Cmd Msg )
init _ _ key _ maybeSession =
    case maybeSession of
        Nothing ->
            ( { key = key, session = initialSession, count = 0 }, requestTopic () )

        Just value ->
            case decodeValue decodeSession value of
                Err _ ->
                    ( { key = key, session = initialSession, count = 0 }, Cmd.none )

                Ok session ->
                    ( { key = key, session = session, count = 0 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Common.update <|
        \msg model ->
            case msg of
                Increment ->
                    ( { model | count = model.count + 1 }, Cmd.none )

                Decrement ->
                    ( { model | count = model.count - 1 }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveTopic Common.ReceiveTopic


view : Model -> Document Msg
view model =
    { title = "Counter - ElmPortfolio"
    , body =
        [ Common.view model.session <|
            Html.map Common.PageMsg <|
                div [ class "page-counter container" ]
                    [ h1 [] [ text "Counter" ]
                    , p [] [ button [ onClick Decrement ] [ text "-" ] ]
                    , p [] [ div [] [ text (String.fromInt model.count) ] ]
                    , p [] [ button [ onClick Increment ] [ text "+" ] ]
                    ]
        ]
    }


page : Page Model Msg Route a
page =
    { route = route
    , init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = Common.UrlRequest
    , session = \model -> encodeSession model.session
    }
