module TestProject.Page.MsgTest.View exposing (view)

import Html exposing (Html, text, h1, div)
import TestProject.Page.MsgTest.Type exposing (Model, Msg(..))
import TestProject.Type as Root

view : Root.Model -> Model -> Html Msg
view state model = div [] 
  [ h1 [] [text "MsgTest"]
  ]
