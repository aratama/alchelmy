module ElmPortfolio.Page.Preferences exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (Key, pushUrl)
import ElmPortfolio.Common as Common exposing (link, updateTopic)
import ElmPortfolio.Ports exposing (receiveTopic, requestTopic, saveTopic)
import ElmPortfolio.Root as Root exposing (Flags, Session, initialSession)
import Html exposing (Html, a, button, div, h1, img, input, p, text)
import Html.Attributes exposing (class, href, src, type_, value)
import Html.Events exposing (custom, onClick, onInput)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)


type alias Msg =
    Common.Msg PageMsg


type PageMsg
    = InputUserName String
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


init : Flags -> Url -> Key -> Route -> Maybe Session -> ( Model, Cmd Msg )
init _ _ key _ maybeSession =
    let
        initial =
            initialSession key
    in
    case maybeSession of
        Nothing ->
            ( { session = initial, value = initial.topic }, requestTopic () )

        Just session ->
            ( { session = session, value = session.topic }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    Common.update <|
        \msg model ->
            case msg of
                InputUserName str ->
                    ( { model | value = str }, Cmd.none )

                SaveUserName ->
                    let
                        session =
                            model.session
                    in
                    ( { model | session = { session | topic = model.value } }
                    , saveTopic model.value
                    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    receiveTopic Common.ReceiveTopic


view : Model -> Document Msg
view model =
    { title = "Preference - ElmPortfolio"
    , body =
        [ Common.view model.session <|
            Html.map Common.PageMsg <|
                div [ class "page-preferences container" ]
                    [ h1 [] [ text "Preferences" ]
                    , p [] [ text "Topic: ", input [ type_ "text", onInput InputUserName, value model.value ] [] ]
                    , p [] [ button [ onClick SaveUserName ] [ text "Save" ] ]
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
