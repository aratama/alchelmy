module ElmPortfolio.Page.Preferences exposing (Route, Model, Msg, route, page)

import ElmPortfolio.Root as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), map)
import Navigation exposing (Location, newUrl)
import ElmPortfolio.Ports exposing (saveThemeToLocalStorage)
import Html exposing (Html, text, div, h1, img, a, p, button, input)
import Html.Attributes exposing (src, href, class, type_, value)
import Html.Events exposing (onClick, onInput)
import Html.Events exposing (onClick, onWithOptions)


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


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location route rootModel =
    ( { value = rootModel.theme }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url )

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
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view state model =
    Root.view link state <|
        div [ class "page-preferences container" ]
            [ h1 [] [ text "Preferences" ]
            , p [] [ text "Theme: ", input [ type_ "text", onInput InputUserName, value model.value ] [] ]
            , p [] [ button [ onClick SaveUserName ] [ text "Save" ] ]
            ]

page : Root.Page Route Model Msg
page = 
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }