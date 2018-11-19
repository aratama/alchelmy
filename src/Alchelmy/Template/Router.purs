module Alchelmy.Template.Router where

import Data.Array (length)
import Data.String (joinWith)
import Prelude (map, (<>), (<))

renderRouter :: String -> Array String -> String
renderRouter application pages = """
--------------------------
-- Auto-generated codes --
-- Do not edit this     --
--------------------------

module """ <> application <> """.Alchelmy exposing (Model, Msg, program)

import Browser exposing (Document, UrlRequest(..), application)
import Browser.Navigation exposing (Key, load, pushUrl)
import Html as Html exposing (Html, text)
import Maybe as Maybe exposing (Maybe(..))
import Url exposing (Url)
import Url.Parser as UrlParser exposing (s, oneOf, Parser, parse, (</>))
import """ <> application <> """.Root as Root
""" <> joinWith "\n" (map (\page -> "import " <> application <> ".Page." <> page <> " as " <> page) pages) <> """

type Model = Model
  { route : RouteState
  , session : Root.Session
  , key : Key
  , flags : Root.Flags
  }

type Route
  = """ <> joinWith "\n  | " (map (\page -> "Route__" <> page <> " " <> page <> ".Route") pages) <> """

type RouteState
  = """ <> joinWith "\n  | " (map (\page -> "State__" <> page <> " " <> page <> ".Model") pages) <> """

type Msg
  = UrlRequest UrlRequest
  | Navigate Url
""" <> joinWith "\n" (map (\page -> "  | Msg__" <> page <> " " <> page <> ".Msg") pages) <> """


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
            State__""" <> page <> """ pmodel ->
              case """ <> page <> """.page.onUrlRequest urlRequest of
                Nothing -> defaultNavigation
                Just onUrlRequestMsg ->
                  case """ <> page <> """.page.update onUrlRequestMsg pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | session = pmodel_.session, route = State__""" <> page <> """ pmodel_ }
                      , Cmd.map Msg__""" <> page <> """ pcmd
                      )
        """
) pages) <> """

    Navigate location ->

      let
        defaultNavigation =
            case parseLocation location of
""" <> joinWith "\n" (map (\page_ -> """
                Route__""" <> page_ <> """ routeValue ->
                      case """ <> page_ <> """.page.init model.flags location model.key routeValue (Just model.session) of
                        (initialModel, initialCmd) ->
                          ( Model { model | session = initialModel.session, route = State__""" <> page_ <> """ initialModel }
                          , Cmd.map Msg__""" <> page_ <> """ initialCmd
                          )
                """
      ) pages) <>
"""
      in
      case model.route of
""" <> joinWith "\n" (map (\page -> """
        State__""" <> page <> """ pmodel -> defaultNavigation
        """
) pages) <> """


""" <> joinWith "\n" (map (\page -> """
    Msg__""" <> page <> """ pageMsg ->
      case model.route of
        State__""" <> page <> """ pageModel ->
          case """ <> page <> """.page.update pageMsg { pageModel | session = model.session } of
            (pageModel_, pageCmd ) ->
              (Model { model | session = pageModel_.session, route = State__""" <> page <> """ pageModel_ }, Cmd.map Msg__""" <> page <> """ pageCmd)
        """ <> if 1 < length pages then "_ -> (Model model, Cmd.none)" else ""
) pages) <> """

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.route of

""" <> joinWith "\n" (map (\page ->
        "  State__" <> page <> " m -> documentMap Msg__" <> page <> " (" <> page <> ".page.view { m | session = model.session })"
) pages) <> """

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ """ <> joinWith "\n        , " (map (\page -> "UrlParser.map Route__" <> page <> " " <> page <> ".page.route") pages) <> """
        ]

parseLocation : Url -> Route
parseLocation location =
    case parse matchers location of
        Just route ->
            route

        Nothing ->
            Route__NotFound ()

navigate : Url -> Msg
navigate = Navigate

init : Root.Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags location key =

        case parseLocation location of

""" <> joinWith "\n" (map (\page ->

"          Route__" <> page <> " routeValue -> case " <> page <> """.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__""" <> page <> """ initialModel
                        , session = initialModel.session
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__""" <> page <> """ initialCmd
                    )
                """) pages) <> """

subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    case model.route of
""" <> joinWith "\n" (map (\page ->
        "        State__" <> page <> " routeValue -> Sub.map Msg__" <> page <> " (" <> page <> ".page.subscriptions routeValue)"
        ) pages)
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