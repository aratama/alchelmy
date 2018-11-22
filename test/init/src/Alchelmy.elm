
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
import TestProject.Root as Root
import TestProject.Page.NotFound
import TestProject.Page.Top

type Model = Model
  { route : RouteState
  , session : Root.Session
  , key : Key
  , flags : Root.Flags
  }

type Route
  = Route__TestProject_Page_NotFound TestProject.Page.NotFound.Route
  | Route__TestProject_Page_Top TestProject.Page.Top.Route

type RouteState
  = State__TestProject_Page_NotFound TestProject.Page.NotFound.Model
  | State__TestProject_Page_Top TestProject.Page.Top.Model

type Msg
  = UrlRequest UrlRequest
  | Navigate Url
  | Msg__TestProject_Page_NotFound TestProject.Page.NotFound.Msg
  | Msg__TestProject_Page_Top TestProject.Page.Top.Msg


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

            State__TestProject_Page_NotFound pmodel ->
              case TestProject.Page.NotFound.page.onUrlRequest urlRequest of
                Nothing -> defaultNavigation
                Just onUrlRequestMsg ->
                  case TestProject.Page.NotFound.page.update onUrlRequestMsg pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | session = pmodel_.session, route = State__TestProject_Page_NotFound pmodel_ }
                      , Cmd.map Msg__TestProject_Page_NotFound pcmd
                      )
        

            State__TestProject_Page_Top pmodel ->
              case TestProject.Page.Top.page.onUrlRequest urlRequest of
                Nothing -> defaultNavigation
                Just onUrlRequestMsg ->
                  case TestProject.Page.Top.page.update onUrlRequestMsg pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | session = pmodel_.session, route = State__TestProject_Page_Top pmodel_ }
                      , Cmd.map Msg__TestProject_Page_Top pcmd
                      )
        

    Navigate location ->

      let
        defaultNavigation =
            case parseLocation location of

                Route__TestProject_Page_NotFound routeValue ->
                      case TestProject.Page.NotFound.page.init model.flags location model.key routeValue (Just model.session) of
                        (initialModel, initialCmd) ->
                          ( Model { model | session = initialModel.session, route = State__TestProject_Page_NotFound initialModel }
                          , Cmd.map Msg__TestProject_Page_NotFound initialCmd
                          )
                

                Route__TestProject_Page_Top routeValue ->
                      case TestProject.Page.Top.page.init model.flags location model.key routeValue (Just model.session) of
                        (initialModel, initialCmd) ->
                          ( Model { model | session = initialModel.session, route = State__TestProject_Page_Top initialModel }
                          , Cmd.map Msg__TestProject_Page_Top initialCmd
                          )
                
      in
      case model.route of

        State__TestProject_Page_NotFound pmodel -> defaultNavigation
        

        State__TestProject_Page_Top pmodel -> defaultNavigation
        



    Msg__TestProject_Page_NotFound pageMsg ->
      case model.route of
        State__TestProject_Page_NotFound pageModel ->
          case TestProject.Page.NotFound.page.update pageMsg { pageModel | session = model.session } of
            (pageModel_, pageCmd ) ->
              (Model { model | session = pageModel_.session, route = State__TestProject_Page_NotFound pageModel_ }, Cmd.map Msg__TestProject_Page_NotFound pageCmd)
        _ -> (Model model, Cmd.none)

    Msg__TestProject_Page_Top pageMsg ->
      case model.route of
        State__TestProject_Page_Top pageModel ->
          case TestProject.Page.Top.page.update pageMsg { pageModel | session = model.session } of
            (pageModel_, pageCmd ) ->
              (Model { model | session = pageModel_.session, route = State__TestProject_Page_Top pageModel_ }, Cmd.map Msg__TestProject_Page_Top pageCmd)
        _ -> (Model model, Cmd.none)

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.route of

  State__TestProject_Page_NotFound m -> documentMap Msg__TestProject_Page_NotFound (TestProject.Page.NotFound.page.view { m | session = model.session })
  State__TestProject_Page_Top m -> documentMap Msg__TestProject_Page_Top (TestProject.Page.Top.page.view { m | session = model.session })

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ UrlParser.map Route__TestProject_Page_NotFound TestProject.Page.NotFound.page.route
        , UrlParser.map Route__TestProject_Page_Top TestProject.Page.Top.page.route
        ]

parseLocation : Url -> Route
parseLocation location =
    case parse matchers location of
        Just route ->
            route

        Nothing ->
            Route__TestProject_Page_NotFound ()

navigate : Url -> Msg
navigate = Navigate

init : Root.Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags location key =

        case parseLocation location of

          Route__TestProject_Page_NotFound routeValue -> case TestProject.Page.NotFound.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__TestProject_Page_NotFound initialModel
                        , session = initialModel.session
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__TestProject_Page_NotFound initialCmd
                    )
                
          Route__TestProject_Page_Top routeValue -> case TestProject.Page.Top.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__TestProject_Page_Top initialModel
                        , session = initialModel.session
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__TestProject_Page_Top initialCmd
                    )
                

subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    case model.route of
        State__TestProject_Page_NotFound routeValue -> Sub.map Msg__TestProject_Page_NotFound (TestProject.Page.NotFound.page.subscriptions routeValue)
        State__TestProject_Page_Top routeValue -> Sub.map Msg__TestProject_Page_Top (TestProject.Page.Top.page.subscriptions routeValue)

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


