module CoolSPA.Page.PageA exposing (..)


import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a)
import Html.Attributes exposing (src, href)

type Msg = Initialize | NoOp

type alias Model = {}

initial : Model  
initial = {}

initialize : Cmd Msg 
initialize = Cmd.none

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )

view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text "PageA" ]
        , a [href "/#/PageB"] [text "Go to PageB"]
        , a [href "/#/PageC"] [text "Go to PageC"]
        ]
