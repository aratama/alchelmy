module ElmPortfolio.Page.URLParsing exposing (Route, Model, Msg, route, page)

import Navigation exposing (Location)
import ElmPortfolio.Root as Root
import UrlParser as UrlParser exposing (s, Parser, (</>), int, map)
import Navigation exposing (Location, newUrl)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)


type Msg
    = Navigate String


type alias Model =
    { id : Int, location : Location }


type alias Route =
    Int


route : Parser (Route -> c) c
route =
    s "url-parsing" </> int


init : Location -> Route -> Root.Model -> ( Model, Cmd Msg )
init location id rootModel =
    ( { id = id, location = location }, Cmd.none )


update : Msg -> Root.Model -> Model -> ( Root.Model, Model, Cmd Msg )
update msg rootModel model =
    case msg of
        Navigate url ->
            ( rootModel, model, newUrl url )


subscriptions : Root.Model -> Sub Msg
subscriptions model =
    Sub.none


link : String -> String -> Html Msg
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view state model =
    Root.view link state <|
        div [ class "page-url-parser container" ]
            [ h1 [] [ text "URL Parsing" ]
            , p []
                [ text <|
                    model.location.origin
                        ++ model.location.pathname
                        ++ model.location.search
                        ++ model.location.hash
                ]
            , p [] [ text <| "Parameter: " ++ toString model.id ]
            ]

page : Root.Page a Route Model Msg
page = 
  { route = route
  , init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }