module Alchelmy.Template.Router where

import Data.Maybe (Maybe(..), fromMaybe)
import Data.Array (length,  head, last, catMaybes)
import Data.String (joinWith, split, Pattern(..))
import Prelude (map, (<>), (<), (<$>), ($), bind, pure, (==))

u :: String -> String
u s = joinWith "_" (split (Pattern ".") s)

renderRouter :: String -> Array String -> String
renderRouter application fullPageModuleNames =
    let
        notFound_ = head $ catMaybes $ (\moduleName -> do
            n <- last $ split (Pattern ".") moduleName
            if n == "NotFound" then Just moduleName else Nothing ) <$> fullPageModuleNames

        notFound = fromMaybe "***NOTDOUND***" notFound_

        pages = u <$> fullPageModuleNames
        in """
--------------------------
-- Auto-generated codes --
-- Do not edit this     --
--------------------------

module Alchelmy exposing (Model, Msg, program)

import Browser exposing (Document, UrlRequest(..), application)
import Browser.Navigation exposing (Key, load, pushUrl)
import Html as Html exposing (Html, text)
import Maybe as Maybe exposing (Maybe(..))
import Url exposing (Url)
import Url.Parser as UrlParser exposing (s, oneOf, Parser, parse, (</>))
import """ <> application <> """.Root as Root
""" <> joinWith "\n" (map (\page -> "import " <> page) fullPageModuleNames) <> """

type Model = Model
  { route : RouteState
  , session : Root.Session
  , key : Key
  , flags : Root.Flags
  }

type Route
  = """ <> joinWith "\n  | " (map (\page -> "Route__" <> u page <> " " <> page <> ".Route") fullPageModuleNames) <> """

type RouteState
  = """ <> joinWith "\n  | " (map (\page -> "State__" <> u page <> " " <> page <> ".Model") fullPageModuleNames) <> """

type Msg
  = UrlRequest UrlRequest
  | Navigate Url
""" <> joinWith "\n" (map (\page -> "  | Msg__" <> u page <> " " <> page <> ".Msg") fullPageModuleNames) <> """


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
  case msg of
    UrlRequest urlRequest ->
      let
        defaultNavigation =
          case urlRequest of
            Internal url ->
              ( Model model
              , pushUrl model.key (Url.toString url)
              )

            External url ->
              ( Model model
              , load url
              )
        in
          case model.route of
""" <> joinWith "\n" (map (\page -> """
            State__""" <> u page <> """ pmodel ->
              case """ <> page <> """.page.onUrlRequest urlRequest of
                Nothing -> defaultNavigation
                Just onUrlRequestMsg ->
                  case """ <> page <> """.page.update onUrlRequestMsg pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | session = pmodel_.session, route = State__""" <> u page <> """ pmodel_ }
                      , Cmd.map Msg__""" <> u page <> """ pcmd
                      )
        """
) fullPageModuleNames) <> """

    Navigate location ->

      let
        defaultNavigation =
            case parseLocation location of
""" <> joinWith "\n" (map (\page_ -> """
                Route__""" <> u page_ <> """ routeValue ->
                      case """ <> page_ <> """.page.init model.flags location model.key routeValue (Just model.session) of
                        (initialModel, initialCmd) ->
                          ( Model { model | session = initialModel.session, route = State__""" <> u page_ <> """ initialModel }
                          , Cmd.map Msg__""" <> u page_ <> """ initialCmd
                          )
                """
      ) fullPageModuleNames) <>
"""
      in
      case model.route of
""" <> joinWith "\n" (map (\page -> """
        State__""" <> u page <> """ pmodel -> defaultNavigation
        """
) fullPageModuleNames) <> """


""" <> joinWith "\n" (map (\page -> """
    Msg__""" <> u page <> """ pageMsg ->
      case model.route of
        State__""" <> u page <> """ pageModel ->
          case """ <> page <> """.page.update pageMsg { pageModel | session = model.session } of
            (pageModel_, pageCmd ) ->
              (Model { model | session = pageModel_.session, route = State__""" <> u page <> """ pageModel_ }, Cmd.map Msg__""" <> u page <> """ pageCmd)
        """ <> if 1 < length pages then "_ -> (Model model, Cmd.none)" else ""
) fullPageModuleNames) <> """

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.route of

""" <> joinWith "\n" (map (\page ->
        "  State__" <> u page <> " m -> documentMap Msg__" <> u page <> " (" <> page <> ".page.view { m | session = model.session })"
) fullPageModuleNames) <> """

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ """ <> joinWith "\n        , " (map (\page -> "UrlParser.map Route__" <> u page <> " " <> page <> ".page.route") fullPageModuleNames) <> """
        ]

parseLocation : Url -> Route
parseLocation location =
    case parse matchers location of
        Just route ->
            route

        Nothing ->
            Route__""" <> u notFound <> """ ()

navigate : Url -> Msg
navigate = Navigate

init : Root.Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags location key =

        case parseLocation location of

""" <> joinWith "\n" (map (\page ->

"          Route__" <> u page <> " routeValue -> case " <> page <> """.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__""" <> u page <> """ initialModel
                        , session = initialModel.session
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__""" <> u page <> """ initialCmd
                    )
                """) fullPageModuleNames) <> """

subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    case model.route of
""" <> joinWith "\n" (map (\page ->
        "        State__" <> u page <> " routeValue -> Sub.map Msg__" <> u page <> " (" <> page <> ".page.subscriptions routeValue)"
        ) fullPageModuleNames)
    <> """

program : Program Root.Flags Model Msg
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