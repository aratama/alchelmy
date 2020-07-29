module Main exposing (main)

import Alchelmy exposing (Flags, Model, Msg, program)


main : Program Flags Model Msg
main =
    program { notFound = Alchelmy.Route__ElmPortfolio_Page_NotFound () }
