module Alchelmy.Template.Router where

import Data.Maybe (Maybe(..), fromMaybe)
import Data.Array (catMaybes, head, last)
import Data.String (joinWith, split, Pattern(..), replaceAll, Replacement(..))
import Prelude (bind, map, ($), (<$>), (<>), (==))

u :: String -> String
u = replaceAll (Pattern ".") (Replacement "_")

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

    pages = u <$> fullPageModuleNames
  in
    """
--------------------------
-- Auto-generated codes --
-- Do not edit this     --
--------------------------

module Alchelmy exposing (Flags, Model, Msg, Session, program)

import Browser exposing (Document, UrlRequest(..), application)
import Browser.Navigation exposing (Key, load, pushUrl)
import Html as Html exposing (Html, text)
import Maybe as Maybe exposing (Maybe(..))
import Url exposing (Url)
import Url.Parser as UrlParser exposing (s, oneOf, Parser, parse, (</>))
import Json.Encode
"""
      <> joinWith "\n" (map (\page -> "import " <> page) fullPageModuleNames)
      <> """


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
      <> joinWith "\n  | " (map (\page -> "Route__" <> u page <> " " <> page <> ".Route") fullPageModuleNames)
      <> """

type RouteState
  = """
      <> joinWith "\n  | " (map (\page -> "State__" <> u page <> " " <> page <> ".Model") fullPageModuleNames)
      <> """

type Msg
  = UrlRequest UrlRequest
  | Navigate Url
"""
      <> joinWith "\n" (map (\page -> "  | Msg__" <> u page <> " " <> page <> ".Msg") fullPageModuleNames)
      <> """

currentSession : RouteState -> Session
currentSession state = case state of 
"""
      <> joinWith "\n"
          ( map
              ( \page ->
                  """
        State__"""
                    <> u page
                    <> """ pageModel ->
          """
                    <> page
                    <> """.page.session pageModel """
              )
              fullPageModuleNames
          )
      <> """


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
  case (msg, model.state) of
    (UrlRequest urlRequest, _) ->
          case model.state of
"""
      <> joinWith "\n"
          ( map
              ( \page ->
                  """
            State__"""
                    <> u page
                    <> """ pmodel ->
                  case """
                    <> page
                    <> """.page.update ("""
                    <> page
                    <> """.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | state = State__"""
                    <> u page
                    <> """ pmodel_ }
                      , Cmd.map Msg__"""
                    <> u page
                    <> """ pcmd
                      )
        """
              )
              fullPageModuleNames
          )
      <> """

    (Navigate location, _) ->
      case parseLocation location of
"""
      <> joinWith "\n"
          ( map
              ( \page_ ->
                  """
                Route__"""
                    <> u page_
                    <> """ routeValue ->
                      case """
                    <> page_
                    <> """.page.init (currentSession model.state) location model.key routeValue of
                        (initialModel, initialCmd) ->
                          ( Model { model | state = State__"""
                    <> u page_
                    <> """ initialModel }
                          , Cmd.map Msg__"""
                    <> u page_
                    <> """ initialCmd
                          )
                """
              )
              fullPageModuleNames
          )
      <> """
  
"""
      <> joinWith "\n"
          ( map
              ( \page ->
                  """
    (Msg__"""
                    <> u page
                    <> """ pageMsg, State__"""
                    <> u page
                    <> """ pageModel) ->
          case """
                    <> page
                    <> """.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | state = State__"""
                    <> u page
                    <> """ pageModel_ }, Cmd.map Msg__"""
                    <> u page
                    <> """ pageCmd)
        """
              )
              fullPageModuleNames
          )
      <> """

    (_, _) -> (Model model, Cmd.none)

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.state of

"""
      <> joinWith "\n"
          ( map
              ( \page ->
                  "  State__" <> u page <> " m -> documentMap Msg__" <> u page <> " (" <> page <> ".page.view m)"
              )
              fullPageModuleNames
          )
      <> """

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ """
      <> joinWith "\n        , " (map (\page -> "UrlParser.map Route__" <> u page <> " " <> page <> ".page.route") fullPageModuleNames)
      <> """
        ]

parseLocation : Url -> Route
parseLocation location =
    case parse matchers location of
        Just route ->
            route

        Nothing ->
            Route__"""
      <> u notFound
      <> """ ()

init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags location key =

        case parseLocation location of

"""
      <> joinWith "\n"
          ( map
              ( \page ->
                  "          Route__" <> u page <> " routeValue -> case " <> page
                    <> """.page.init flags location key routeValue of
                (initialModel, initialCmd) ->
                    ( Model
                        { state = State__"""
                    <> u page
                    <> """ initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__"""
                    <> u page
                    <> """ initialCmd
                    )
                """
              )
              fullPageModuleNames
          )
      <> """

subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    case model.state of
"""
      <> joinWith "\n"
          ( map
              ( \page ->
                  "        State__" <> u page <> " routeValue -> Sub.map Msg__" <> u page <> " (" <> page <> ".page.subscriptions routeValue)"
              )
              fullPageModuleNames
          )
      <> """

program : Program Flags Model Msg
program =
    application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange = Navigate
        }


"""
