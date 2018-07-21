
--------------------------
-- Auto-generated codes --
-- Do not edit this     -- 
--------------------------

module ElmPortfolio.Routing exposing (..)

import Navigation exposing (Location)
import UrlParser as UrlParser exposing (s, oneOf, Parser, parseHash, (</>))
import Html as Html exposing (Html, text)
import ElmPortfolio.Type as Root
import ElmPortfolio.Page.Counter.View as Counter
import ElmPortfolio.Page.Counter.Type as Counter
import ElmPortfolio.Page.Counter.Update as Counter
import ElmPortfolio.Page.Http.View as Http
import ElmPortfolio.Page.Http.Type as Http
import ElmPortfolio.Page.Http.Update as Http
import ElmPortfolio.Page.NotFound.View as NotFound
import ElmPortfolio.Page.NotFound.Type as NotFound
import ElmPortfolio.Page.NotFound.Update as NotFound
import ElmPortfolio.Page.Parent.View as Parent
import ElmPortfolio.Page.Parent.Type as Parent
import ElmPortfolio.Page.Parent.Update as Parent
import ElmPortfolio.Page.Parent.Child.View as Parent_Child
import ElmPortfolio.Page.Parent.Child.Type as Parent_Child
import ElmPortfolio.Page.Parent.Child.Update as Parent_Child
import ElmPortfolio.Page.Preferences.View as Preferences
import ElmPortfolio.Page.Preferences.Type as Preferences
import ElmPortfolio.Page.Preferences.Update as Preferences
import ElmPortfolio.Page.Time.View as Time
import ElmPortfolio.Page.Time.Type as Time
import ElmPortfolio.Page.Time.Update as Time
import ElmPortfolio.Page.Top.View as Top
import ElmPortfolio.Page.Top.Type as Top
import ElmPortfolio.Page.Top.Update as Top
import ElmPortfolio.Page.URLParsing.View as URLParsing
import ElmPortfolio.Page.URLParsing.Type as URLParsing
import ElmPortfolio.Page.URLParsing.Update as URLParsing


type alias Model 
  = { route : RouteState
    , state : Root.Model
    }

type Route
  = Counter Counter.Route
  | Http Http.Route
  | NotFound NotFound.Route
  | Parent Parent.Route
  | Parent_Child Parent_Child.Route
  | Preferences Preferences.Route
  | Time Time.Route
  | Top Top.Route
  | URLParsing URLParsing.Route

type RouteState
  = Counter__State Counter.Model
  | Http__State Http.Model
  | NotFound__State NotFound.Model
  | Parent__State Parent.Model
  | Parent_Child__State Parent_Child.Model
  | Preferences__State Preferences.Model
  | Time__State Time.Model
  | Top__State Top.Model
  | URLParsing__State URLParsing.Model
  
type Msg
  = Navigate Location
  | CounterMsg Counter.Msg
  | HttpMsg Http.Msg
  | NotFoundMsg NotFound.Msg
  | ParentMsg Parent.Msg
  | Parent_ChildMsg Parent_Child.Msg
  | PreferencesMsg Preferences.Msg
  | TimeMsg Time.Msg
  | TopMsg Top.Msg
  | URLParsingMsg URLParsing.Msg

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of 

  Navigate location -> let route = parseLocation location in case route of 
          Counter routeValue -> case Counter.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = Counter__State initialModel }
                , Cmd.map CounterMsg initialCmd
                )
  

          Http routeValue -> case Http.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = Http__State initialModel }
                , Cmd.map HttpMsg initialCmd
                )
  

          NotFound routeValue -> case NotFound.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = NotFound__State initialModel }
                , Cmd.map NotFoundMsg initialCmd
                )
  

          Parent routeValue -> case Parent.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = Parent__State initialModel }
                , Cmd.map ParentMsg initialCmd
                )
  

          Parent_Child routeValue -> case Parent_Child.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = Parent_Child__State initialModel }
                , Cmd.map Parent_ChildMsg initialCmd
                )
  

          Preferences routeValue -> case Preferences.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = Preferences__State initialModel }
                , Cmd.map PreferencesMsg initialCmd
                )
  

          Time routeValue -> case Time.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = Time__State initialModel }
                , Cmd.map TimeMsg initialCmd
                )
  

          Top routeValue -> case Top.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = Top__State initialModel }
                , Cmd.map TopMsg initialCmd
                )
  

          URLParsing routeValue -> case URLParsing.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = URLParsing__State initialModel }
                , Cmd.map URLParsingMsg initialCmd
                )
  


  CounterMsg pageMsg -> case model.route of 
      Counter__State pageModel -> case Counter.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = Counter__State pageModel_, state = model_ }, Cmd.map CounterMsg pageCmd)      
      _ -> (model, Cmd.none)
  

  HttpMsg pageMsg -> case model.route of 
      Http__State pageModel -> case Http.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = Http__State pageModel_, state = model_ }, Cmd.map HttpMsg pageCmd)      
      _ -> (model, Cmd.none)
  

  NotFoundMsg pageMsg -> case model.route of 
      NotFound__State pageModel -> case NotFound.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = NotFound__State pageModel_, state = model_ }, Cmd.map NotFoundMsg pageCmd)      
      _ -> (model, Cmd.none)
  

  ParentMsg pageMsg -> case model.route of 
      Parent__State pageModel -> case Parent.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = Parent__State pageModel_, state = model_ }, Cmd.map ParentMsg pageCmd)      
      _ -> (model, Cmd.none)
  

  Parent_ChildMsg pageMsg -> case model.route of 
      Parent_Child__State pageModel -> case Parent_Child.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = Parent_Child__State pageModel_, state = model_ }, Cmd.map Parent_ChildMsg pageCmd)      
      _ -> (model, Cmd.none)
  

  PreferencesMsg pageMsg -> case model.route of 
      Preferences__State pageModel -> case Preferences.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = Preferences__State pageModel_, state = model_ }, Cmd.map PreferencesMsg pageCmd)      
      _ -> (model, Cmd.none)
  

  TimeMsg pageMsg -> case model.route of 
      Time__State pageModel -> case Time.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = Time__State pageModel_, state = model_ }, Cmd.map TimeMsg pageCmd)      
      _ -> (model, Cmd.none)
  

  TopMsg pageMsg -> case model.route of 
      Top__State pageModel -> case Top.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = Top__State pageModel_, state = model_ }, Cmd.map TopMsg pageCmd)      
      _ -> (model, Cmd.none)
  

  URLParsingMsg pageMsg -> case model.route of 
      URLParsing__State pageModel -> case URLParsing.update pageMsg model.state pageModel of 
        (model_, pageModel_, pageCmd) -> ( { model | route = URLParsing__State pageModel_, state = model_ }, Cmd.map URLParsingMsg pageCmd)      
      _ -> (model, Cmd.none)
  

view : Model -> Html Msg
view model = case model.route of 
  Counter__State m -> Html.map CounterMsg (Counter.view model.state m)
  Http__State m -> Html.map HttpMsg (Http.view model.state m)
  NotFound__State m -> Html.map NotFoundMsg (NotFound.view model.state m)
  Parent__State m -> Html.map ParentMsg (Parent.view model.state m)
  Parent_Child__State m -> Html.map Parent_ChildMsg (Parent_Child.view model.state m)
  Preferences__State m -> Html.map PreferencesMsg (Preferences.view model.state m)
  Time__State m -> Html.map TimeMsg (Time.view model.state m)
  Top__State m -> Html.map TopMsg (Top.view model.state m)
  URLParsing__State m -> Html.map URLParsingMsg (URLParsing.view model.state m)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [
        UrlParser.map Counter Counter.route,
        UrlParser.map Http Http.route,
        UrlParser.map NotFound NotFound.route,
        UrlParser.map Parent Parent.route,
        UrlParser.map Parent_Child Parent_Child.route,
        UrlParser.map Preferences Preferences.route,
        UrlParser.map Time Time.route,
        UrlParser.map Top Top.route,
        UrlParser.map URLParsing URLParsing.route
        ]   

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound NotFound.initial

navigate : Location -> Msg 
navigate = Navigate

init : Root.Model -> Location -> ( Model, Cmd Msg )
init initial location = 
  let route = parseLocation location in 
        case route of

            Counter routeValue -> case Counter.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = Counter__State initialModel
                      , state = initial
                      }
                    , Cmd.map CounterMsg initialCmd
                    )
  

            Http routeValue -> case Http.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = Http__State initialModel
                      , state = initial
                      }
                    , Cmd.map HttpMsg initialCmd
                    )
  

            NotFound routeValue -> case NotFound.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = NotFound__State initialModel
                      , state = initial
                      }
                    , Cmd.map NotFoundMsg initialCmd
                    )
  

            Parent routeValue -> case Parent.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = Parent__State initialModel
                      , state = initial
                      }
                    , Cmd.map ParentMsg initialCmd
                    )
  

            Parent_Child routeValue -> case Parent_Child.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = Parent_Child__State initialModel
                      , state = initial
                      }
                    , Cmd.map Parent_ChildMsg initialCmd
                    )
  

            Preferences routeValue -> case Preferences.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = Preferences__State initialModel
                      , state = initial
                      }
                    , Cmd.map PreferencesMsg initialCmd
                    )
  

            Time routeValue -> case Time.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = Time__State initialModel
                      , state = initial
                      }
                    , Cmd.map TimeMsg initialCmd
                    )
  

            Top routeValue -> case Top.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = Top__State initialModel
                      , state = initial
                      }
                    , Cmd.map TopMsg initialCmd
                    )
  

            URLParsing routeValue -> case URLParsing.init location routeValue initial of
                (initialModel, initialCmd) -> 
                    ( { route = URLParsing__State initialModel
                      , state = initial
                      }
                    , Cmd.map URLParsingMsg initialCmd
                    )
     

subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.batch
        [  Sub.map CounterMsg (Counter.subscriptions model.state)
        , Sub.map HttpMsg (Http.subscriptions model.state)
        , Sub.map NotFoundMsg (NotFound.subscriptions model.state)
        , Sub.map ParentMsg (Parent.subscriptions model.state)
        , Sub.map Parent_ChildMsg (Parent_Child.subscriptions model.state)
        , Sub.map PreferencesMsg (Preferences.subscriptions model.state)
        , Sub.map TimeMsg (Time.subscriptions model.state)
        , Sub.map TopMsg (Top.subscriptions model.state)
        , Sub.map URLParsingMsg (URLParsing.subscriptions model.state)
        ]


program : Root.Model -> Program Never Model Msg
program initial =
    Navigation.program navigate
        { init = init initial
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
        

  