module ElmPortfolio.Page.Counter exposing (Model, Msg, Route, page)

import Browser exposing (Document, UrlRequest(..))
import Browser.Navigation exposing (Key)
import ElmPortfolio.Common as Common exposing (link, updateTopic)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic)
import ElmPortfolio.Root as Root exposing (Flags, Session, initialSession)
import Html exposing (Html, a, button, div, h1, p, text)
import Html.Attributes exposing (class, href, src)
import Html.Events exposing (custom, onClick)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)



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
    { session : Session
    , count : Int
    }



-- a `route` function defines a route to the page.


route : Parser (Route -> a) a
route =
    map () (s "counter")



-- an `init` function initializes the local state of the page with `Url`, `Route` and the global state.


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ _ key _ maybeSession =
    case maybeSession of
        Nothing ->
            ( { session = initialSession key, count = 0 }, requestTopic () )

        Just session ->
            ( { session = session, count = 0 }, Cmd.none )


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


page : Root.Page Model Msg Route a
page =
    { route = route
    , init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlRequest = Common.UrlRequest
    , session = \model -> model.session
    }
