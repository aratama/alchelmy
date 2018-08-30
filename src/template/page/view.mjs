export function renderView(application, pageName) {
  return `module ${application}.Page.${pageName}.View exposing (view)

import Html exposing (Html, text, h1, div)
import ${application}.Page.${pageName}.Type exposing (Model, Msg(..))
import ${application}.Type as Root

{-| Auto-generated link function for path routing (\`UrlParser.parsePath\`). 
You can remove this function if you use Hash routing (\`UrlParser.parseHash\`).
-}
link : String -> String -> Html Msg
link href label =
    Root.navigate Navigate href [ text label ]

view : Root.Model -> Model -> Html Msg
view state model = div [] 
  [ h1 [] [text "${pageName}"]
  ]
`;
}
