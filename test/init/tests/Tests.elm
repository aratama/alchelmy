module Tests exposing (..)

import Test exposing (..)
import Expect
import TestProject.Type as Root
import TestProject.Update as Root


all : Test
all =
    describe "A Test Suite"
        [ test "Root.update" <|
            \_ ->
                case Root.update (Root.Navigate "/path/to/someware") {} of
                    ( model, msg, dmsg ) ->
                        Expect.equal model {}
        ]
