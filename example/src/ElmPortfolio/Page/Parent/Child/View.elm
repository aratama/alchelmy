module ElmPortfolio.Page.Parent.Child.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p)
import Html.Attributes exposing (src, href, class)
import Html.Events exposing (onWithOptions)
import ElmPortfolio.Page.Parent.Child.Type exposing (Model, Msg(..))
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root
import Json.Decode exposing (Decoder, succeed, bool, field, fail, map4, andThen)


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view (Root.nav (AscentMsg << Root.Nav)) state <|
        div [ class "page-parent" ]
            [ h1 [] [ text "Parent / Child" ]
            , p []
                [ Root.nav (AscentMsg << Root.Nav)
                    "/parent"
                    [ text "Go up to parent page" ]
                ]
            ]
