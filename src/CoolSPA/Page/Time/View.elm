module CoolSPA.Page.Time.View exposing (..)

import UrlParser exposing (..)
import Html exposing (Html, text, div, h1, img, a, p, button, h2, img, br)
import Html.Attributes exposing (src, href, class, src)
import Html.Events exposing (onClick)
import CoolSPA.Page.Time.Type exposing (Model, Msg(..))
import CoolSPA.Type as Root
import CoolSPA.View as Root
import Svg exposing (svg, circle, line)
import Svg.Attributes exposing (viewBox, width, cx, cy, r, fill, x1, y1, x2, y2, stroke)
import Time as Time


view : Root.Model -> Model -> Html Msg
view state model =
    Root.view state <|
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
                    [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
                    , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
                    ]
            ]
