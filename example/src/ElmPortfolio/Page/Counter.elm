module ElmPortfolio.Page.Counter exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Root as Root
import Html exposing (Html, a, button, div, h1, img, p, text)
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
    = Navigate String
    | Increment
    | Decrement



-- `Msg` is a local state container that stores the state of the page.


type alias Model =
    Int



-- a `route` function defines a route to the page.


route : Parser (Route -> a) a
route =
    map () (s "counter")



-- an `init` function initializes the local state of the page with `Url`, `Route` and the global state.


init : Url -> Route -> Root.Model -> ( Model, Cmd Msg )
init _ _ _ =
    ( 0, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, pushUrl rootModel.key url )

        Increment ->
            ( rootModel, model + 1, Cmd.none )

        Decrement ->
            ( rootModel, model - 1, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


link : String -> String -> Html Msg
link url label =
    a [ href url ] [ text label ]


view : Root.Model -> Model -> Document Msg
view rootModel model =
    { title = ""
    , body =
        [ Root.view link rootModel <|
            div [ class "page-counter container" ]
                [ h1 [] [ text "Counter" ]
                , p [] [ button [ onClick Decrement ] [ text "-" ] ]
                , p [] [ div [] [ text (String.fromInt model) ] ]
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
