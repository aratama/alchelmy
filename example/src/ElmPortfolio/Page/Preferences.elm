module ElmPortfolio.Page.Preferences exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Ports exposing (saveThemeToLocalStorage)
import ElmPortfolio.Root as Root exposing (Session)
import Html exposing (Html, a, button, div, h1, img, input, p, text)
import Html.Attributes exposing (class, href, src, type_, value)
import Html.Events exposing (custom, onClick, onInput)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)


type Msg
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


init : Url -> Route -> Session -> ( Model, Cmd Msg )
init location _ session =
    ( { session = session, value = session.theme }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputUserName str ->
            ( { model | value = str }, Cmd.none )

        SaveUserName ->
            let
                session =
                    model.session
            in
            ( { model | session = { session | theme = model.value } }
            , saveThemeToLocalStorage model.value
            )


subscriptions : Session -> Sub Msg
subscriptions _ =
    Sub.none


link : String -> String -> Html Msg
link url label =
    a [ href url ] [ text label ]


view : Model -> Document Msg
view model =
    { title = "Preference - ElmPortfolio"
    , body =
        [ Root.view link model.session <|
            div [ class "page-preferences container" ]
                [ h1 [] [ text "Preferences" ]
                , p [] [ text "Theme: ", input [ type_ "text", onInput InputUserName, value model.value ] [] ]
                , p [] [ button [ onClick SaveUserName ] [ text "Save" ] ]
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
