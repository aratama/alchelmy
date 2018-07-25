module ElmPortfolio.Page.Preferences.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p, button, input)
import Html.Attributes exposing (src, href, class, type_, value)
import Html.Events exposing (onClick, onInput)
import ElmPortfolio.Page.Preferences.Type exposing (Model, Msg(..))
import ElmPortfolio.Page.Preferences.Automata exposing (navigate)
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root
import Html.Events exposing (onClick, onWithOptions)


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view navigate state <|
        div [ class "page-preferences container" ]
            [ h1 [] [ text "Preferences" ]
            , p [] [ text "Theme: ", input [ type_ "text", onInput InputUserName, value model.value ] [] ]
            , p [] [ button [ onClick SaveUserName ] [ text "Save" ] ]
            ]
