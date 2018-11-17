module ElmPortfolio.Page.Preferences exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Ports exposing (receiveThemeFromLocalStorage, requestThemeFromLocalStorage, saveThemeToLocalStorage)
import ElmPortfolio.Root as Root exposing (Flags, Session, initial, link, updateTopic)
import Html exposing (Html, a, button, div, h1, img, input, p, text)
import Html.Attributes exposing (class, href, src, type_, value)
import Html.Events exposing (custom, onClick, onInput)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)


type Msg
    = ReceiveThemeFromLocalStorage (Maybe String)
    | InputUserName String
    | SaveUserName


type alias Model =
    { value : String
    , session : Session
    }


type alias Route =
    {}


route : Parser (Route -> a) a
route =
    map {} (s "preferences")


init : Flags -> Url -> Route -> ( Model, Cmd Msg )
init _ _ _ =
    ( { session = initial, value = initial.topic }, requestThemeFromLocalStorage () )


navigated : Url -> Route -> Session -> ( Model, Cmd Msg )
navigated _ _ session =
    ( { session = session, value = session.topic }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ReceiveThemeFromLocalStorage topic ->
            let
                model_ =
                    updateTopic model topic
            in
            ( { model_ | value = model_.session.topic }, Cmd.none )

        InputUserName str ->
            ( { model | value = str }, Cmd.none )

        SaveUserName ->
            let
                session =
                    model.session
            in
            ( { model | session = { session | topic = model.value } }
            , saveThemeToLocalStorage model.value
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveThemeFromLocalStorage ReceiveThemeFromLocalStorage


view : Model -> Document Msg
view model =
    { title = "Preference - ElmPortfolio"
    , body =
        [ Root.view model.session <|
            div [ class "page-preferences container" ]
                [ h1 [] [ text "Preferences" ]
                , p [] [ text "Theme: ", input [ type_ "text", onInput InputUserName, value model.value ] [] ]
                , p [] [ button [ onClick SaveUserName ] [ text "Save" ] ]
                ]
        ]
    }


page : Root.Page Model Msg Route a
page =
    { route = route
    , init = init
    , navigated = navigated
    , view = view
    , update = update
    , subscriptions = subscriptions
    }
