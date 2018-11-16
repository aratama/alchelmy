module ElmPortfolio.Root exposing (Flags, Msg(..), Page, Session, init, subscriptions, update, view)

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


type alias Flags =
    ()


type alias Session =
    { theme : String
    , key : Key
    }


type alias Page a route model msg =
    { route : Parser (route -> a) a
    , init : Url -> route -> Session -> ( model, Cmd msg )
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : Session -> Sub msg
    , view : model -> Document msg
    }


type Msg
    = ReceiveThemeFromLocalStorage (Maybe String)


init : Flags -> Url -> Key -> ( Session, Cmd Msg )
init _ _ key =
    ( { theme = "goat"
      , key = key
      }
    , requestThemeFromLocalStorage ()
    )


update : Msg -> Session -> ( Session, Cmd Msg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage themeMaybe ->
            ( { model | theme = withDefault model.theme themeMaybe }, Cmd.none )


subscriptions : Sub Msg
subscriptions =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


view : (String -> String -> Html msg) -> Session -> Html msg -> Html msg
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
