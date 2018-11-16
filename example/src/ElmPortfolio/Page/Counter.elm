module ElmPortfolio.Page.Counter exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import ElmPortfolio.Root as Root exposing (Session)
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


type Msg
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


init : Url -> Route -> Session -> ( Model, Cmd Msg )
init _ _ session =
    ( { session = session, count = 0 }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | count = model.count + 1 }, Cmd.none )

        Decrement ->
            ( { model | count = model.count - 1 }, Cmd.none )


subscriptions : Session -> Sub Msg
subscriptions _ =
    Sub.none


link : String -> String -> Html Msg
link url label =
    a [ href url ] [ text label ]


view : Model -> Document Msg
view model =
    { title = "Counter - ElmPortfolio"
    , body =
        [ Root.view link model.session <|
            div [ class "page-counter container" ]
                [ h1 [] [ text "Counter" ]
                , p [] [ button [ onClick Decrement ] [ text "-" ] ]
                , p [] [ div [] [ text (String.fromInt model.count) ] ]
                , p [] [ button [ onClick Increment ] [ text "+" ] ]
                ]
        ]
    }


page : Root.Page a Route Model Msg
page =
    { route = route
    , init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
