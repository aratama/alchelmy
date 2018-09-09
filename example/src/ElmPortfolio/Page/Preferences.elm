module ElmPortfolio.Page.Preferences exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Ports exposing (saveThemeToLocalStorage)
import ElmPortfolio.Root as Root
import Html exposing (Html, a, button, div, h1, img, input, p, text)
import Html.Attributes exposing (class, href, src, type_, value)
import Html.Events exposing (custom, onClick, onInput)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, s)


type Msg
    = Navigate String
    | InputUserName String
    | SaveUserName
    | Initialize


type alias Model =
    { value : String }


type alias Route =
    {}


route : Parser (Route -> a) a
route =
    map {} (s "preferences")


init : Url -> Route -> Root.Model -> ( Model, Cmd Msg )
init location _ rootModel =
    ( { value = rootModel.theme }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, pushUrl rootModel.key url )

        InputUserName str ->
            ( rootModel, { model | value = str }, Cmd.none )

        SaveUserName ->
            ( { rootModel | theme = model.value }, model, saveThemeToLocalStorage model.value )

        Initialize ->
            ( rootModel, { model | value = rootModel.theme }, Cmd.none )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


link : String -> String -> Html Msg
link url label =
    a [ href url ] [ text label ]


view : Root.Model -> Model -> Document Msg
view state model =
    { title = ""
    , body =
        [ Root.view link state <|
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
