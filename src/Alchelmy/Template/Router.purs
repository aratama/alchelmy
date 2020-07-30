module Alchelmy.Template.Router where

import Data.String (Pattern(..), Replacement(..), joinWith, replaceAll)
import Prelude (map, (<$>), (<>))

underbar :: String -> String
underbar = replaceAll (Pattern ".") (Replacement "_")

renderRouter :: String -> Array String -> String
renderRouter application fullPageModuleNames =
  let
    pages = underbar <$> fullPageModuleNames

    each f = joinWith "\n" (map f fullPageModuleNames)

    elements f = joinWith ",\n" (map f fullPageModuleNames)

    block :: Array (Array String) -> String
    block xs = joinWith "\n" (map (joinWith "") xs)
  in
    joinWith "\n"
      [ """
--------------------------
-- Auto-generated codes --
-- Do not edit this     --
--------------------------

module Alchelmy exposing (Flags, Model, Msg(..), Route(..), Session, init, view, update, subscriptions, program)

import Browser exposing (Document, UrlRequest(..), application)
import Browser.Navigation exposing (Key, load, pushUrl)
import Html as Html exposing (Html, text)
import Maybe as Maybe exposing (Maybe(..))
import Url exposing (Url)
import Url.Parser as UrlParser exposing (s, oneOf, Parser, parse, (</>))
import Json.Encode
"""
      , each \page -> "import " <> page
      , """

type alias Flags =
    Json.Encode.Value


type alias Session =
    Json.Encode.Value


type Model = Model
  { state : RouteState
  , key : Key
  , flags : Flags
  }

type Route
  = """
          <> joinWith "\n  | " (map (\page -> "Route__" <> underbar page <> " " <> page <> ".Route") fullPageModuleNames)
      , """

type RouteState
  = """
          <> joinWith "\n  | " (map (\page -> "State__" <> underbar page <> " " <> page <> ".Model") fullPageModuleNames)
      , """
type Msg
  = UrlRequest UrlRequest
  | UrlChange Url"""
      , each \page -> block [ [ "  | Msg__", underbar page, " ", page, ".Msg" ] ]
      , """
update : Route -> Msg -> Model -> ( Model, Cmd Msg )
update notFoundRoute msg (Model model) =
  case (msg, model.state) of
    (UrlRequest urlRequest, _) ->
          case model.state of
"""
      , each \page ->
          block
            [ [ "            State__", underbar page, " pmodel ->" ]
            , [ "                case ", page, ".page.update (", page, ".page.onUrlRequest urlRequest) pmodel of" ]
            , [ "                    (pmodel_, pcmd) ->" ]
            , [ "                        ( Model { model | state = State__", underbar page, " pmodel_ }, Cmd.map Msg__", underbar page, " pcmd)" ]
            ]
      , "    (UrlChange location, _) ->"
      , "      let "
      , "          currentSession : () -> Session"
      , "          currentSession () = case model.state of"
      , each \page ->
          block
            [ [ "            State__", underbar page, " pageModel ->", page, ".page.session pageModel " ] ]
      , "          rerouting cmd = case parseLocation notFoundRoute location of"
      , each \page_ ->
          block
            [ [ "                Route__", underbar page_, " routeValue -> " ]
            , [ "                    case ", page_, ".page.init (currentSession ()) location model.key routeValue of" ]
            , [ "                        (initialModel, initialCmd) ->" ]
            , [ "                            ( Model { model | state = State__", underbar page_, " initialModel }" ]
            , [ "                            , Cmd.batch [cmd, Cmd.map Msg__", underbar page_, " initialCmd]" ]
            , [ "                            )" ]
            ]
      , "      in"
      , "      case model.state of"
      , each \page ->
          block
            [ [ "             State__", underbar page, " pmodel ->    " ]
            , [ "                  case ", page, ".page.update (", page, ".page.onUrlChange location) pmodel of" ]
            , [ "                      (pageModel_, pageCmd) -> case parse ", page, ".page.route location of " ]
            , [ "                          Just _ -> (Model { model | state = State__", underbar page, " pageModel_ }, Cmd.map Msg__", underbar page, " pageCmd)" ]
            , [ "                          _ -> rerouting (Cmd.map Msg__", underbar page, " pageCmd)" ]
            ]
      , each \page ->
          block
            [ [ "    (Msg__", underbar page, " pageMsg, State__", underbar page, " pageModel) ->" ]
            , [ "        case ", page, ".page.update pageMsg pageModel of" ]
            , [ "            (pageModel_, pageCmd ) ->" ]
            , [ "                (Model { model | state = State__", underbar page, " pageModel_ }, Cmd.map Msg__", underbar page, " pageCmd)" ]
            ]
      , "    (_, _) -> (Model model, Cmd.none)"
      , ""
      , "documentMap : (msg -> Msg) -> Document msg -> Document Msg"
      , "documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }"
      , ""
      , "view : Model -> Document Msg"
      , "view (Model model) = case model.state of"
      , each \page -> block [ [ "  State__", underbar page, " m -> documentMap Msg__", underbar page, " (", page, ".page.view m)" ] ]
      , """

matchers : Parser (Route -> a) a
matchers =
    oneOf
        ["""
      , elements \page -> block [ [ "          UrlParser.map Route__", underbar page, " ", page, ".page.route" ] ]
      , "        ]"
      , """

parseLocation : Route -> Url -> Route
parseLocation notFoundRoute location =
    case parse matchers location of
        Just route ->
            route

        Nothing -> 
            notFoundRoute 
      """
      , """
init : Route -> Flags -> Url -> Key -> ( Model, Cmd Msg )
init notFoundRoute flags location key =
        case parseLocation notFoundRoute location of
"""
      , each \page ->
          block
            [ [ "          Route__", underbar page, " routeValue -> case ", page, ".page.init flags location key routeValue of" ]
            , [ "              (initialModel, initialCmd) ->" ]
            , [ "                  ( Model { state = State__", underbar page, " initialModel, key = key, flags = flags }" ]
            , [ "                  , Cmd.map Msg__", underbar page, " initialCmd" ]
            , [ "                  )" ]
            ]
      , """

subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    case model.state of
"""
      , each \page ->
          block [ [ "        State__", underbar page, " routeValue -> Sub.map Msg__", underbar page, " (", page, ".page.subscriptions routeValue)" ] ]
      , """

program : { notFound : Route } -> Program Flags Model Msg
program config =
    application
        { init = init config.notFound
        , view = view
        , update = update config.notFound
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }

"""
      ]
