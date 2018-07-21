module CoolSPA.Page.URLParsing.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import CoolSPA.Page.URLParsing.Type exposing (Model, Msg)
import CoolSPA.Type as Root
import CoolSPA.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
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
