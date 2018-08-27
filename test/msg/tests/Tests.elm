module Tests exposing (..)

import Test exposing (..)
import Expect
import TestProject.Type as Root
import TestProject.Update as Root
import TestProject.Alchemy as Alchemy


all : Test
all =
    describe "A Test Suite"
        [ test "Alchemy.update" <|
            \_ ->
                let
                    route =
                        Alchemy.MsgTest__State {}

                    state =
                        "initial"

                    msg =
                        Alchemy.Root__Msg (Root.SetState "value")
                in
                    case Alchemy.update msg { route = route, state = state } of
                        ( model, msg ) ->
                            Expect.equal model.state "value"

        ]
