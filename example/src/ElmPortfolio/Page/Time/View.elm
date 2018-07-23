module ElmPortfolio.Page.Time.View exposing (..)

import Html exposing (Html, text, div, h1, img, a, p, button, h2, img, br)
import Html.Attributes exposing (src, href, class, src)
import ElmPortfolio.Page.Time.Type exposing (Model, Msg(..))
import ElmPortfolio.Type as Root
import ElmPortfolio.View as Root
import Svg exposing (svg, circle, line)
import Svg.Attributes exposing (viewBox, width, cx, cy, r, fill, x1, y1, x2, y2, stroke)
import Time as Time
import Html.Events exposing (onClick, onWithOptions)
import Json.Decode exposing (succeed)


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view navigate state <|
        div [ class "page-a container" ]
            [ h1 [] [ text "Time" ]
            , let
                angle =
                    turns (Time.inMinutes model)

                handX =
                    toString (50 + 40 * cos angle)

                handY =
                    toString (50 + 40 * sin angle)
              in
                svg [ viewBox "0 0 100 100", width "300px" ]
                    [ circle [ cx "50", cy "50", r "45", fill "#5b91ba" ] []
                    , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
                    ]
            ]


navigate : String -> List (Html Msg) -> Html Msg
navigate url contents =
    a [ href url, onWithOptions "click" { stopPropagation = True, preventDefault = True } (succeed (Navigate url)) ] contents
