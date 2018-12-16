
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
import TestProject.Root as Root
import TestProject.Page.NotFound
import TestProject.Page.Top


type alias Flags =
    Root.Flags


type alias Session =
    Root.Session


type Model = Model
  { state : RouteState
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

currentSession : RouteState -> Root.Session
currentSession state = case state of 

        State__TestProject_Page_NotFound pageModel ->
          TestProject.Page.NotFound.page.session pageModel 

        State__TestProject_Page_Top pageModel ->
          TestProject.Page.Top.page.session pageModel 


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
  case (msg, model.state) of
    (UrlRequest urlRequest, _) ->
          case model.state of

            State__TestProject_Page_NotFound pmodel ->
                  case TestProject.Page.NotFound.page.update (TestProject.Page.NotFound.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | state = State__TestProject_Page_NotFound pmodel_ }
                      , Cmd.map Msg__TestProject_Page_NotFound pcmd
                      )
        

            State__TestProject_Page_Top pmodel ->
                  case TestProject.Page.Top.page.update (TestProject.Page.Top.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | state = State__TestProject_Page_Top pmodel_ }
                      , Cmd.map Msg__TestProject_Page_Top pcmd
                      )
        

    (Navigate location, _) ->
      case parseLocation location of

                Route__TestProject_Page_NotFound routeValue ->
                      case TestProject.Page.NotFound.page.init model.flags location model.key routeValue (Just (currentSession model.state)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | state = State__TestProject_Page_NotFound initialModel }
                          , Cmd.map Msg__TestProject_Page_NotFound initialCmd
                          )
                

                Route__TestProject_Page_Top routeValue ->
                      case TestProject.Page.Top.page.init model.flags location model.key routeValue (Just (currentSession model.state)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | state = State__TestProject_Page_Top initialModel }
                          , Cmd.map Msg__TestProject_Page_Top initialCmd
                          )
                
  

    (Msg__TestProject_Page_NotFound pageMsg, State__TestProject_Page_NotFound pageModel) ->
          case TestProject.Page.NotFound.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | state = State__TestProject_Page_NotFound pageModel_ }, Cmd.map Msg__TestProject_Page_NotFound pageCmd)
        

    (Msg__TestProject_Page_Top pageMsg, State__TestProject_Page_Top pageModel) ->
          case TestProject.Page.Top.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | state = State__TestProject_Page_Top pageModel_ }, Cmd.map Msg__TestProject_Page_Top pageCmd)
        

    (_, _) -> (Model model, Cmd.none)

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.state of

  State__TestProject_Page_NotFound m -> documentMap Msg__TestProject_Page_NotFound (TestProject.Page.NotFound.page.view m)
  State__TestProject_Page_Top m -> documentMap Msg__TestProject_Page_Top (TestProject.Page.Top.page.view m)

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

init : Root.Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags location key =

        case parseLocation location of

          Route__TestProject_Page_NotFound routeValue -> case TestProject.Page.NotFound.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { state = State__TestProject_Page_NotFound initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__TestProject_Page_NotFound initialCmd
                    )
                
          Route__TestProject_Page_Top routeValue -> case TestProject.Page.Top.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { state = State__TestProject_Page_Top initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__TestProject_Page_Top initialCmd
                    )
                

subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    case model.state of
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


