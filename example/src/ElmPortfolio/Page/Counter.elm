module ElmPortfolio.Page.Counter exposing (..)

import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location, newUrl)
import Html exposing (Html, text, div, h1, img, a, p, button)
import Html.Attributes exposing (src, href, class)
import Html.Events exposing (onClick, onWithOptions)
import ElmPortfolio.Root as Root

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



-- an `init` function initializes the local state of the page with `Location`, `Route` and the global state.


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init _ _ _ =
    ( 0, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url )

        Increment ->
            ( rootModel, model + 1, Cmd.none )

        Decrement ->
            ( rootModel, model - 1, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


link : String -> String -> Html Msg
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view rootModel model =
    Root.view link rootModel <|
        div [ class "page-counter container" ]
            [ h1 [] [ text "Counter" ]
            , p [] [ button [ onClick Decrement ] [ text "-" ] ]
            , p [] [ div [] [ text (toString model) ] ]
            , p [] [ button [ onClick Increment ] [ text "+" ] ]
            ]

page : Root.Page Route Model Msg
page = {
    init = init,
    view = view,
    update = update,
    subscriptions = subscriptions
    }
