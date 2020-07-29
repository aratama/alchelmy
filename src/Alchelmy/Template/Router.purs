module Alchelmy.Template.Router where

import Data.Maybe (Maybe(..), fromMaybe)
import Data.Array (catMaybes, head, last)
import Data.String (joinWith, split, Pattern(..), replaceAll, Replacement(..))
import Prelude (bind, map, ($), (<$>), (<>), (==))

underbar :: String -> String
underbar = replaceAll (Pattern ".") (Replacement "_")

renderRouter :: String -> Array String -> String
renderRouter application fullPageModuleNames =
  let
    notFound_ =
      head $ catMaybes
        $ ( \moduleName -> do
              n <- last $ split (Pattern ".") moduleName
              if n == "NotFound" then Just moduleName else Nothing
          )
        <$> fullPageModuleNames

    notFound = fromMaybe "***NOTDOUND***" notFound_

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

module Alchelmy exposing (Flags, Model, Msg(..), Session, init, view, update, subscriptions, program)

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
update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
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
      , "           (session, cmdOnUrlChange) = case model.state of"
      , each \page ->
          block
            [ [ "             State__", underbar page, " pmodel ->    " ]
            , [ "               case ", page, ".page.update (", page, ".page.onUrlChange location) pmodel of" ]
            , [ "                 (model_, cmd) -> (", page, ".page.session model_, Cmd.map Msg__", underbar page, " cmd)" ]
            ]
      , "      in"
      , "      case parseLocation location of"
      , each \page_ ->
          block
            [ [ "                Route__", underbar page_, " routeValue -> " ]
            , [ "                    case ", page_, ".page.init session location model.key routeValue of" ]
            , [ "                        (initialModel, initialCmd) ->" ]
            , [ "                            ( Model { model | state = State__", underbar page_, " initialModel }" ]
            , [ "                            , Cmd.batch [cmdOnUrlChange, Cmd.map Msg__", underbar page_, " initialCmd]" ]
            , [ "                            )" ]
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

parseLocation : Url -> Route
parseLocation location =
    case parse matchers location of
        Just route ->
            route

        Nothing ->"""
      , block [ [ "            Route__", underbar notFound, " ()" ] ]
      , """
init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags location key =
        case parseLocation location of
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

program : Program Flags Model Msg
program =
    application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }

"""
      ]
