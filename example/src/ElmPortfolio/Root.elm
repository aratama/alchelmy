module ElmPortfolio.Root exposing (Model, Msg(..), Page, init, subscriptions, update, view)

-- Application global state type.

import Browser exposing (Document)
import Browser.Navigation exposing (Key, pushUrl)
import ElmPortfolio.Ports exposing (receiveThemeFromLocalStorage, requestThemeFromLocalStorage)
import Html exposing (Html, a, div, h1, header, p, text)
import Html.Attributes exposing (class, href)
import Html.Events exposing (custom, onClick)
import Json.Decode exposing (Decoder, andThen, bool, fail, field, map4, succeed)
import Maybe exposing (withDefault)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, parse, s)


type alias Model =
    { theme : String, key : Key }


type Msg
    = ReceiveThemeFromLocalStorage (Maybe String)


type alias Page a route model msg =
    { route : Parser (route -> a) a
    , init : Url -> route -> Model -> ( model, Cmd msg )
    , update : msg -> Model -> model -> ( Model, model, Cmd msg )
    , subscriptions : Model -> Sub msg
    , view : Model -> model -> Document msg
    }


init : Url -> Key -> ( Model, Cmd Msg )
init _ key =
    ( { theme = "goat", key = key }, requestThemeFromLocalStorage () )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage themeMaybe ->
            ( { model | theme = withDefault model.theme themeMaybe }, Cmd.none )


subscriptions : Sub Msg
subscriptions =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


view : (String -> String -> Html msg) -> Model -> Html msg -> Html msg
view link model content =
    div [ class "root" ]
        [ header []
            [ h1 [] [ link "/" "Elm Examples" ]
            , text <| "Theme: " ++ model.theme
            ]
        , div [ class "page" ]
            [ div [ class "index" ]
                [ p [] [ link "/counter" "Counter" ]
                , p [] [ link "/http" "Http" ]
                , p [] [ link "/time" "Time" ]
                , p [] [ link "/url-parsing/42" "URL Parsing" ]
                , p [] [ link "/preferences" "Preferences" ]
                , p [] [ link "/broken-url" "404" ]
                ]
            , div []
                [ content
                ]
            ]
        ]



{-
   navigate : (String -> msg) -> String -> List (Html msg) -> Html msg
   navigate msg url contents =
       let
           decoder : Decoder msg
           decoder =
               andThen
                   identity
                   (map4
                       (\ctrl shift alt meta ->
                           if shift || ctrl || alt || meta then
                               fail ""

                           else
                               succeed (msg url)
                       )
                       (field "ctrlKey" bool)
                       (field "shiftKey" bool)
                       (field "altKey" bool)
                       (field "metaKey" bool)
                   )
       in
       a [ href url, custom "click" decoder ] contents
-}
