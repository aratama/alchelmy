
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
import ElmPortfolio.Root as Root
import ElmPortfolio.Page.Counter
import ElmPortfolio.Page.Http
import ElmPortfolio.Page.NotFound
import ElmPortfolio.Page.Preferences
import ElmPortfolio.Page.Time
import ElmPortfolio.Page.Top
import ElmPortfolio.Page.URLParsing


type alias Flags =
    Root.Flags


type alias Session =
    Root.Session


type Model = Model
  { route : RouteState
  , key : Key
  , flags : Root.Flags
  }

type Route
  = Route__ElmPortfolio_Page_Counter ElmPortfolio.Page.Counter.Route
  | Route__ElmPortfolio_Page_Http ElmPortfolio.Page.Http.Route
  | Route__ElmPortfolio_Page_NotFound ElmPortfolio.Page.NotFound.Route
  | Route__ElmPortfolio_Page_Preferences ElmPortfolio.Page.Preferences.Route
  | Route__ElmPortfolio_Page_Time ElmPortfolio.Page.Time.Route
  | Route__ElmPortfolio_Page_Top ElmPortfolio.Page.Top.Route
  | Route__ElmPortfolio_Page_URLParsing ElmPortfolio.Page.URLParsing.Route

type RouteState
  = State__ElmPortfolio_Page_Counter ElmPortfolio.Page.Counter.Model
  | State__ElmPortfolio_Page_Http ElmPortfolio.Page.Http.Model
  | State__ElmPortfolio_Page_NotFound ElmPortfolio.Page.NotFound.Model
  | State__ElmPortfolio_Page_Preferences ElmPortfolio.Page.Preferences.Model
  | State__ElmPortfolio_Page_Time ElmPortfolio.Page.Time.Model
  | State__ElmPortfolio_Page_Top ElmPortfolio.Page.Top.Model
  | State__ElmPortfolio_Page_URLParsing ElmPortfolio.Page.URLParsing.Model

type Msg
  = UrlRequest UrlRequest
  | Navigate Url
  | Msg__ElmPortfolio_Page_Counter ElmPortfolio.Page.Counter.Msg
  | Msg__ElmPortfolio_Page_Http ElmPortfolio.Page.Http.Msg
  | Msg__ElmPortfolio_Page_NotFound ElmPortfolio.Page.NotFound.Msg
  | Msg__ElmPortfolio_Page_Preferences ElmPortfolio.Page.Preferences.Msg
  | Msg__ElmPortfolio_Page_Time ElmPortfolio.Page.Time.Msg
  | Msg__ElmPortfolio_Page_Top ElmPortfolio.Page.Top.Msg
  | Msg__ElmPortfolio_Page_URLParsing ElmPortfolio.Page.URLParsing.Msg

currentSession : RouteState -> Root.Session
currentSession route = case route of 

        State__ElmPortfolio_Page_Counter pageModel ->
          ElmPortfolio.Page.Counter.page.session pageModel 

        State__ElmPortfolio_Page_Http pageModel ->
          ElmPortfolio.Page.Http.page.session pageModel 

        State__ElmPortfolio_Page_NotFound pageModel ->
          ElmPortfolio.Page.NotFound.page.session pageModel 

        State__ElmPortfolio_Page_Preferences pageModel ->
          ElmPortfolio.Page.Preferences.page.session pageModel 

        State__ElmPortfolio_Page_Time pageModel ->
          ElmPortfolio.Page.Time.page.session pageModel 

        State__ElmPortfolio_Page_Top pageModel ->
          ElmPortfolio.Page.Top.page.session pageModel 

        State__ElmPortfolio_Page_URLParsing pageModel ->
          ElmPortfolio.Page.URLParsing.page.session pageModel 


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) =
  case (msg, model.route) of
    (UrlRequest urlRequest, _) ->
          case model.route of

            State__ElmPortfolio_Page_Counter pmodel ->
                  case ElmPortfolio.Page.Counter.page.update (ElmPortfolio.Page.Counter.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | route = State__ElmPortfolio_Page_Counter pmodel_ }
                      , Cmd.map Msg__ElmPortfolio_Page_Counter pcmd
                      )
        

            State__ElmPortfolio_Page_Http pmodel ->
                  case ElmPortfolio.Page.Http.page.update (ElmPortfolio.Page.Http.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | route = State__ElmPortfolio_Page_Http pmodel_ }
                      , Cmd.map Msg__ElmPortfolio_Page_Http pcmd
                      )
        

            State__ElmPortfolio_Page_NotFound pmodel ->
                  case ElmPortfolio.Page.NotFound.page.update (ElmPortfolio.Page.NotFound.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | route = State__ElmPortfolio_Page_NotFound pmodel_ }
                      , Cmd.map Msg__ElmPortfolio_Page_NotFound pcmd
                      )
        

            State__ElmPortfolio_Page_Preferences pmodel ->
                  case ElmPortfolio.Page.Preferences.page.update (ElmPortfolio.Page.Preferences.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | route = State__ElmPortfolio_Page_Preferences pmodel_ }
                      , Cmd.map Msg__ElmPortfolio_Page_Preferences pcmd
                      )
        

            State__ElmPortfolio_Page_Time pmodel ->
                  case ElmPortfolio.Page.Time.page.update (ElmPortfolio.Page.Time.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | route = State__ElmPortfolio_Page_Time pmodel_ }
                      , Cmd.map Msg__ElmPortfolio_Page_Time pcmd
                      )
        

            State__ElmPortfolio_Page_Top pmodel ->
                  case ElmPortfolio.Page.Top.page.update (ElmPortfolio.Page.Top.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | route = State__ElmPortfolio_Page_Top pmodel_ }
                      , Cmd.map Msg__ElmPortfolio_Page_Top pcmd
                      )
        

            State__ElmPortfolio_Page_URLParsing pmodel ->
                  case ElmPortfolio.Page.URLParsing.page.update (ElmPortfolio.Page.URLParsing.page.onUrlRequest urlRequest) pmodel of
                    (pmodel_, pcmd) ->
                      ( Model { model | route = State__ElmPortfolio_Page_URLParsing pmodel_ }
                      , Cmd.map Msg__ElmPortfolio_Page_URLParsing pcmd
                      )
        

    (Navigate location, _) ->
      case parseLocation location of

                Route__ElmPortfolio_Page_Counter routeValue ->
                      case ElmPortfolio.Page.Counter.page.init model.flags location model.key routeValue (Just (currentSession model.route)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | route = State__ElmPortfolio_Page_Counter initialModel }
                          , Cmd.map Msg__ElmPortfolio_Page_Counter initialCmd
                          )
                

                Route__ElmPortfolio_Page_Http routeValue ->
                      case ElmPortfolio.Page.Http.page.init model.flags location model.key routeValue (Just (currentSession model.route)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | route = State__ElmPortfolio_Page_Http initialModel }
                          , Cmd.map Msg__ElmPortfolio_Page_Http initialCmd
                          )
                

                Route__ElmPortfolio_Page_NotFound routeValue ->
                      case ElmPortfolio.Page.NotFound.page.init model.flags location model.key routeValue (Just (currentSession model.route)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | route = State__ElmPortfolio_Page_NotFound initialModel }
                          , Cmd.map Msg__ElmPortfolio_Page_NotFound initialCmd
                          )
                

                Route__ElmPortfolio_Page_Preferences routeValue ->
                      case ElmPortfolio.Page.Preferences.page.init model.flags location model.key routeValue (Just (currentSession model.route)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | route = State__ElmPortfolio_Page_Preferences initialModel }
                          , Cmd.map Msg__ElmPortfolio_Page_Preferences initialCmd
                          )
                

                Route__ElmPortfolio_Page_Time routeValue ->
                      case ElmPortfolio.Page.Time.page.init model.flags location model.key routeValue (Just (currentSession model.route)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | route = State__ElmPortfolio_Page_Time initialModel }
                          , Cmd.map Msg__ElmPortfolio_Page_Time initialCmd
                          )
                

                Route__ElmPortfolio_Page_Top routeValue ->
                      case ElmPortfolio.Page.Top.page.init model.flags location model.key routeValue (Just (currentSession model.route)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | route = State__ElmPortfolio_Page_Top initialModel }
                          , Cmd.map Msg__ElmPortfolio_Page_Top initialCmd
                          )
                

                Route__ElmPortfolio_Page_URLParsing routeValue ->
                      case ElmPortfolio.Page.URLParsing.page.init model.flags location model.key routeValue (Just (currentSession model.route)) of
                        (initialModel, initialCmd) ->
                          ( Model { model | route = State__ElmPortfolio_Page_URLParsing initialModel }
                          , Cmd.map Msg__ElmPortfolio_Page_URLParsing initialCmd
                          )
                
  

    (Msg__ElmPortfolio_Page_Counter pageMsg, State__ElmPortfolio_Page_Counter pageModel) ->
          case ElmPortfolio.Page.Counter.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | route = State__ElmPortfolio_Page_Counter pageModel_ }, Cmd.map Msg__ElmPortfolio_Page_Counter pageCmd)
        

    (Msg__ElmPortfolio_Page_Http pageMsg, State__ElmPortfolio_Page_Http pageModel) ->
          case ElmPortfolio.Page.Http.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | route = State__ElmPortfolio_Page_Http pageModel_ }, Cmd.map Msg__ElmPortfolio_Page_Http pageCmd)
        

    (Msg__ElmPortfolio_Page_NotFound pageMsg, State__ElmPortfolio_Page_NotFound pageModel) ->
          case ElmPortfolio.Page.NotFound.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | route = State__ElmPortfolio_Page_NotFound pageModel_ }, Cmd.map Msg__ElmPortfolio_Page_NotFound pageCmd)
        

    (Msg__ElmPortfolio_Page_Preferences pageMsg, State__ElmPortfolio_Page_Preferences pageModel) ->
          case ElmPortfolio.Page.Preferences.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | route = State__ElmPortfolio_Page_Preferences pageModel_ }, Cmd.map Msg__ElmPortfolio_Page_Preferences pageCmd)
        

    (Msg__ElmPortfolio_Page_Time pageMsg, State__ElmPortfolio_Page_Time pageModel) ->
          case ElmPortfolio.Page.Time.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | route = State__ElmPortfolio_Page_Time pageModel_ }, Cmd.map Msg__ElmPortfolio_Page_Time pageCmd)
        

    (Msg__ElmPortfolio_Page_Top pageMsg, State__ElmPortfolio_Page_Top pageModel) ->
          case ElmPortfolio.Page.Top.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | route = State__ElmPortfolio_Page_Top pageModel_ }, Cmd.map Msg__ElmPortfolio_Page_Top pageCmd)
        

    (Msg__ElmPortfolio_Page_URLParsing pageMsg, State__ElmPortfolio_Page_URLParsing pageModel) ->
          case ElmPortfolio.Page.URLParsing.page.update pageMsg pageModel of
            (pageModel_, pageCmd ) ->
              (Model { model | route = State__ElmPortfolio_Page_URLParsing pageModel_ }, Cmd.map Msg__ElmPortfolio_Page_URLParsing pageCmd)
        

    (_, _) -> (Model model, Cmd.none)

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.route of

  State__ElmPortfolio_Page_Counter m -> documentMap Msg__ElmPortfolio_Page_Counter (ElmPortfolio.Page.Counter.page.view m)
  State__ElmPortfolio_Page_Http m -> documentMap Msg__ElmPortfolio_Page_Http (ElmPortfolio.Page.Http.page.view m)
  State__ElmPortfolio_Page_NotFound m -> documentMap Msg__ElmPortfolio_Page_NotFound (ElmPortfolio.Page.NotFound.page.view m)
  State__ElmPortfolio_Page_Preferences m -> documentMap Msg__ElmPortfolio_Page_Preferences (ElmPortfolio.Page.Preferences.page.view m)
  State__ElmPortfolio_Page_Time m -> documentMap Msg__ElmPortfolio_Page_Time (ElmPortfolio.Page.Time.page.view m)
  State__ElmPortfolio_Page_Top m -> documentMap Msg__ElmPortfolio_Page_Top (ElmPortfolio.Page.Top.page.view m)
  State__ElmPortfolio_Page_URLParsing m -> documentMap Msg__ElmPortfolio_Page_URLParsing (ElmPortfolio.Page.URLParsing.page.view m)

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ UrlParser.map Route__ElmPortfolio_Page_Counter ElmPortfolio.Page.Counter.page.route
        , UrlParser.map Route__ElmPortfolio_Page_Http ElmPortfolio.Page.Http.page.route
        , UrlParser.map Route__ElmPortfolio_Page_NotFound ElmPortfolio.Page.NotFound.page.route
        , UrlParser.map Route__ElmPortfolio_Page_Preferences ElmPortfolio.Page.Preferences.page.route
        , UrlParser.map Route__ElmPortfolio_Page_Time ElmPortfolio.Page.Time.page.route
        , UrlParser.map Route__ElmPortfolio_Page_Top ElmPortfolio.Page.Top.page.route
        , UrlParser.map Route__ElmPortfolio_Page_URLParsing ElmPortfolio.Page.URLParsing.page.route
        ]

parseLocation : Url -> Route
parseLocation location =
    case parse matchers location of
        Just route ->
            route

        Nothing ->
            Route__ElmPortfolio_Page_NotFound ()

init : Root.Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags location key =

        case parseLocation location of

          Route__ElmPortfolio_Page_Counter routeValue -> case ElmPortfolio.Page.Counter.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__ElmPortfolio_Page_Counter initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__ElmPortfolio_Page_Counter initialCmd
                    )
                
          Route__ElmPortfolio_Page_Http routeValue -> case ElmPortfolio.Page.Http.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__ElmPortfolio_Page_Http initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__ElmPortfolio_Page_Http initialCmd
                    )
                
          Route__ElmPortfolio_Page_NotFound routeValue -> case ElmPortfolio.Page.NotFound.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__ElmPortfolio_Page_NotFound initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__ElmPortfolio_Page_NotFound initialCmd
                    )
                
          Route__ElmPortfolio_Page_Preferences routeValue -> case ElmPortfolio.Page.Preferences.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__ElmPortfolio_Page_Preferences initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__ElmPortfolio_Page_Preferences initialCmd
                    )
                
          Route__ElmPortfolio_Page_Time routeValue -> case ElmPortfolio.Page.Time.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__ElmPortfolio_Page_Time initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__ElmPortfolio_Page_Time initialCmd
                    )
                
          Route__ElmPortfolio_Page_Top routeValue -> case ElmPortfolio.Page.Top.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__ElmPortfolio_Page_Top initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__ElmPortfolio_Page_Top initialCmd
                    )
                
          Route__ElmPortfolio_Page_URLParsing routeValue -> case ElmPortfolio.Page.URLParsing.page.init flags location key routeValue Nothing of
                (initialModel, initialCmd) ->
                    ( Model
                        { route = State__ElmPortfolio_Page_URLParsing initialModel
                        , key = key
                        , flags = flags
                        }
                    , Cmd.map Msg__ElmPortfolio_Page_URLParsing initialCmd
                    )
                

subscriptions : Model -> Sub Msg
subscriptions (Model model) =
    case model.route of
        State__ElmPortfolio_Page_Counter routeValue -> Sub.map Msg__ElmPortfolio_Page_Counter (ElmPortfolio.Page.Counter.page.subscriptions routeValue)
        State__ElmPortfolio_Page_Http routeValue -> Sub.map Msg__ElmPortfolio_Page_Http (ElmPortfolio.Page.Http.page.subscriptions routeValue)
        State__ElmPortfolio_Page_NotFound routeValue -> Sub.map Msg__ElmPortfolio_Page_NotFound (ElmPortfolio.Page.NotFound.page.subscriptions routeValue)
        State__ElmPortfolio_Page_Preferences routeValue -> Sub.map Msg__ElmPortfolio_Page_Preferences (ElmPortfolio.Page.Preferences.page.subscriptions routeValue)
        State__ElmPortfolio_Page_Time routeValue -> Sub.map Msg__ElmPortfolio_Page_Time (ElmPortfolio.Page.Time.page.subscriptions routeValue)
        State__ElmPortfolio_Page_Top routeValue -> Sub.map Msg__ElmPortfolio_Page_Top (ElmPortfolio.Page.Top.page.subscriptions routeValue)
        State__ElmPortfolio_Page_URLParsing routeValue -> Sub.map Msg__ElmPortfolio_Page_URLParsing (ElmPortfolio.Page.URLParsing.page.subscriptions routeValue)

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


