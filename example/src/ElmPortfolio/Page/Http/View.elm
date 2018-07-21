module ElmPortfolio.Page.Http.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p, button, h2, img, br)
import Html.Attributes exposing (src, href, class, src, href)
import Html.Events exposing (onClick)
import ElmPortfolio.Page.Http.Type exposing (Model, Msg(..))
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
        div [ class "page-http container" ]
            [ h1 [] [ text "Http" ]
            , h2 [] [ text <| "Theme: " ++ model.topic ]
            , button [ onClick MorePlease ] [ text "More Please!" ]
            , br [] []
            , img [ src model.gifUrl ] []
            , p []
                [ text "Go to "
                , a [ href "/#/preferences" ] [ text "the preferences page" ]
                , text " to change theme."
                ]
            ]
