export function renderRoot(application) {
  return `module ${application}.Root exposing (..)

import UrlParser as UrlParser exposing (s, Parser, (</>), map, parseHash)
import Navigation exposing (Location, newUrl)
import Maybe exposing (withDefault)
import Html exposing (Html, a)
import Html.Attributes exposing (href)
import Html.Events exposing (onWithOptions)
import Json.Decode exposing (Decoder, andThen, bool, fail, field, map4, succeed)


-- Application global state type.


type alias Model =
    {}
  

type Msg
    = Navigate String


init : Location -> ( Model, Cmd Msg )
init _ =
    ( {}, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Navigate url ->
            (model, newUrl url)


subscriptions : Sub Msg
subscriptions =
    Sub.none


parse : Parser (a -> a) a -> Location -> Maybe a
parse = parseHash
    

{-| Helper function for path routing. You can remove this function if you use Hash routing (\`parseHash\`).
-}
navigate : (String -> msg) -> String -> List (Html msg) -> Html msg
navigate msg url contents =
    let
        decoder : Decoder msg
        decoder =
            andThen
                identity
                (map4
                    (\\ctrl shift alt meta ->
                        if shift || ctrl || alt || meta then
                            -- do browser default behavior
                            fail ""

                        else
                            succeed (msg url)
                    )
                    (field "ctrlKey" bool)
                    (field "shiftKey" bool)
                    (field "altKey" bool)
                    (field "metaKey" bool)
                )
    in
    a [ href url, onWithOptions "click" { stopPropagation = True, preventDefault = True } decoder ] contents
`.trimLeft();
}
