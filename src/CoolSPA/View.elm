module CoolSPA.View exposing (..)

import Html exposing (Html, text, div, header)
import Html.Attributes exposing (class)
import CoolSPA.Type as Root


view : Root.Model -> Html msg -> Html msg
view model content =
    div [ class "root" ]
        [ header [] [ text <| "User Name: " ++ model.user ]
        , div [ class "page" ] [ content ]
        ]



{-
   holyGrail : Html msg -> Html msg
   holyGrail content =
       div [ class "page-a container" ]
           [ div [ class "" ]
               [ p [] [ a [ href "/#/page-a" ] [ text "Go to Page A" ] ]
               , p [] [ a [ href "/#/page-b" ] [ text "Go to Page B" ] ]
               , p [] [ a [ href "/#/page-b/page-b-a" ] [ text "Go to Page B/A" ] ]
               , p [] [ a [ href "/#/page-c/42" ] [ text "Go to Page C" ] ]
               ]
           , div []
               [ content
               ]
           ]
-}
