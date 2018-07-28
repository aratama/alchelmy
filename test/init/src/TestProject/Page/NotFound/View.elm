module TestProject.Page.NotFound.View exposing (view)

import Html exposing (Html, text, h1, div)
import TestProject.Page.NotFound.Type exposing (Model, Msg(..))
import TestProject.Type as Root

view : Root.Model -> Model -> Html Msg
view state model = div [] 
  [ h1 [] [text "NotFound"]
  ]
