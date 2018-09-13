module ElmPortfolio.Page.URLParsing exposing (Model, Msg, Route, page, route)

import Browser exposing (Document)
import Browser.Navigation exposing (pushUrl)
import ElmPortfolio.Root as Root
import Html exposing (Html, a, div, h1, img, p, text)
import Html.Attributes exposing (class, href, src)
import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, int, map, s)


type Msg
    = Navigate String


type alias Model =
    { id : Int, location : Url }


type alias Route =
    Int


route : Parser (Route -> c) c
route =
    s "url-parsing" </> int


init : Url -> Route -> Root.Model -> ( Model, Cmd Msg )
init location id rootModel =
    ( { id = id, location = location }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, pushUrl rootModel.key url )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


link : String -> String -> Html Msg
link url label =
    a [ href (Root.relative url) ] [ text label ]


view : Root.Model -> Model -> Document Msg
view state model =
    { title = "URLParsing - ElmPortfolio"
    , body =
        [ Root.view link state <|
            div [ class "page-url-parser container" ]
                [ h1 [] [ text "URL Parsing" ]
                , p []
                    [ text <|
                        model.location.host
                            ++ model.location.path
                            ++ Maybe.withDefault "" model.location.query
                            ++ Maybe.withDefault "" model.location.fragment
                    ]
                , p [] [ text <| "Parameter: " ++ String.fromInt model.id ]
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
