
--------------------------
-- Auto-generated codes --
-- Do not edit this     -- 
--------------------------

module TestProject.Alchemy exposing (..)

import Navigation exposing (Location)
import UrlParser as UrlParser exposing (s, oneOf, Parser, parseHash, parsePath, (</>))
import Html as Html exposing (Html, text)
import Maybe as Maybe
import TestProject.Type as Root
import TestProject.Update as Root
import TestProject.Page.Bar.View as Bar
import TestProject.Page.Bar.Type as Bar
import TestProject.Page.Bar.Update as Bar
import TestProject.Page.NotFound.View as NotFound
import TestProject.Page.NotFound.Type as NotFound
import TestProject.Page.NotFound.Update as NotFound


type alias Model 
  = { route : RouteState
    , state : Root.Model
    }

type Route
  = Bar Bar.Route
  | NotFound NotFound.Route

type RouteState
  = Bar__State Bar.Model
  | NotFound__State NotFound.Model
  
type Msg
  = Navigate Location
  | Root__Msg Root.Msg
  | Bar__Msg Bar.Msg
  | NotFound__Msg NotFound.Msg



update : Msg -> Model -> ( Model, Cmd Msg )
update msg model = case msg of 

  Root__Msg rootMsg -> case Root.update rootMsg model.state of
    (rootModel_, rootCmd, descentMsgMaybe) -> case descentMsgMaybe of
      Nothing -> 
        ({ model | state = rootModel_ }, Cmd.map Root__Msg rootCmd)
      Just descentMsg -> case model.route of 
        Bar__State pageModel ->            
          case Bar.receive descentMsg of
            Nothing -> ({ model | state = rootModel_ }, Cmd.map Root__Msg rootCmd)
            Just pageMsg -> update (Bar__Msg pageMsg) { model | state = rootModel_ }
            
        NotFound__State pageModel ->            
          case NotFound.receive descentMsg of
            Nothing -> ({ model | state = rootModel_ }, Cmd.map Root__Msg rootCmd)
            Just pageMsg -> update (NotFound__Msg pageMsg) { model | state = rootModel_ }
            


  Navigate location -> let route = parseLocation location in case route of 
          Bar routeValue -> case Bar.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = Bar__State initialModel }
                , Cmd.map Bar__Msg initialCmd
                )
  

          NotFound routeValue -> case NotFound.init location routeValue model.state of
              (initialModel, initialCmd) -> 
                ( { model | route = NotFound__State initialModel }
                , Cmd.map NotFound__Msg initialCmd
                )
  


  Bar__Msg pageMsg -> case model.route of 
      Bar__State pageModel -> 
        case Bar.update pageMsg model.state pageModel of 
          (model_, pageModel_, pageCmd, externalMsgMaybe ) -> case Maybe.andThen Root.receive externalMsgMaybe of
            Nothing -> ({ model | state = model_, route = Bar__State pageModel_ }, Cmd.map Bar__Msg pageCmd)
            Just dmsg -> update (Root__Msg dmsg) { model | state = model_, route = Bar__State pageModel_ }
        
      _ -> (model, Cmd.none)
      
  

  NotFound__Msg pageMsg -> case model.route of 
      NotFound__State pageModel -> 
        case NotFound.update pageMsg model.state pageModel of 
          (model_, pageModel_, pageCmd, externalMsgMaybe ) -> case Maybe.andThen Root.receive externalMsgMaybe of
            Nothing -> ({ model | state = model_, route = NotFound__State pageModel_ }, Cmd.map NotFound__Msg pageCmd)
            Just dmsg -> update (Root__Msg dmsg) { model | state = model_, route = NotFound__State pageModel_ }
        
      _ -> (model, Cmd.none)
      
  

view : Model -> Html Msg
view model = case model.route of 
  Bar__State m -> Html.map Bar__Msg (Bar.view model.state m)
  NotFound__State m -> Html.map NotFound__Msg (NotFound.view model.state m)


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [
        UrlParser.map Bar Bar.route,
        UrlParser.map NotFound NotFound.route
        ]   

parseLocation : Location -> Route
parseLocation location =
    case (parseHash matchers location) of
        Just route ->
            route

        Nothing ->
            NotFound ()

navigate : Location -> Msg 
navigate = Navigate

init : Location -> ( Model, Cmd Msg )
init location = 
  let route = parseLocation location in 
    case Root.init location of 
      (rootInitialModel, rootInitialCmd) -> 
        case route of

            Bar routeValue -> case Bar.init location routeValue rootInitialModel of
                (initialModel, initialCmd) -> 
                    ( { route = Bar__State initialModel
                      , state = rootInitialModel
                      }
                    , Cmd.batch 
                      [ Cmd.map Root__Msg rootInitialCmd
                      , Cmd.map Bar__Msg initialCmd
                      ]
                    )
  

            NotFound routeValue -> case NotFound.init location routeValue rootInitialModel of
                (initialModel, initialCmd) -> 
                    ( { route = NotFound__State initialModel
                      , state = rootInitialModel
                      }
                    , Cmd.batch 
                      [ Cmd.map Root__Msg rootInitialCmd
                      , Cmd.map NotFound__Msg initialCmd
                      ]
                    )
     

subscriptions : Model -> Sub Msg
subscriptions model = 
    Sub.batch
        (Sub.map Root__Msg Root.subscriptions :: [  Sub.map Bar__Msg (Bar.subscriptions model.state)
        , Sub.map NotFound__Msg (NotFound.subscriptions model.state)
        ])


program : Program Never Model Msg
program =
    Navigation.program navigate
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
        

  