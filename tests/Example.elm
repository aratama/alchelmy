module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import TestProject.Update as E
import TestProject.Type as E


suite : Test
suite =
    describe "The String module"
        [ test "root update" <|
            \_ ->
                case E.update (E.ChangeRoute "/some/url") {} of
                    ( model, msg, maybeDescentMsg ) ->
                        Expect.equal model {}
        ]
