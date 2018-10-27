module Elm.Alchemy.Template.Router where 

import Data.Array (length)
import Data.String (joinWith)
import Prelude (map, (<>), (<))

renderRouter :: String -> Array String -> String
renderRouter application pages = """
--------------------------
-- Auto-generated codes --
-- Do not edit this     -- 
--------------------------

module """ <> application <> """.Alchemy exposing (Model, Msg, program)

import Browser exposing (Document, UrlRequest(..), application)
import Browser.Navigation exposing (Key, load, pushUrl)
import Html as Html exposing (Html, text)
import Maybe as Maybe
import Url exposing (Url)
import Url.Parser as UrlParser exposing (s, oneOf, Parser, parse, (</>))
import """ <> application <> """.Root as Root
""" <> joinWith "\n" (map (\page -> "import " <> application <> ".Page." <> page <> " as " <> page) pages) <> """

type Model = Model 
  { route : RouteState
  , state : Root.Model
  , key : Key
  }

type Route 
  = """ <> joinWith "\n  | " (map (\page -> "Route__" <> page <> " " <> page <> ".Route") pages) <> """

type RouteState 
  = """ <> joinWith "\n  | " (map (\page -> "State__" <> page <> " " <> page <> ".Model") pages) <> """
  
type Msg
  = UrlRequest UrlRequest
  | Navigate Url
  | Msg__Root Root.Msg
""" <> joinWith "\n" (map (\page -> "  | Msg__" <> page <> " " <> page <> ".Msg") pages) <> """


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) = 
  case msg of 

    Msg__Root rootMsg -> case Root.update rootMsg model.state of
      (rootModel_, rootCmd) -> 
          (Model { model | state = rootModel_ }, Cmd.map Msg__Root rootCmd)

    UrlRequest urlRequest ->
      case urlRequest of
        Internal url ->
          ( Model model
          , pushUrl model.key (Url.toString url)
          )

        External url ->
          ( Model model
          , load url
          )

    Navigate location -> 
      let 
          route = 
            parseLocation location 
      in 
      case route of 

""" <> joinWith "\n" (map (\page -> "        Route__" <> page <> """ routeValue -> 
          case 
            let 
              page = """ <> page <> """.page
            in page.init location routeValue model.state 
          of 
            (initialModel, initialCmd) -> 
                ( Model { model | route = State__""" <> page <> """ initialModel }
                , Cmd.map Msg__""" <> page <> """ initialCmd
                )
        """
      ) pages) <> """


""" <> joinWith "\n" (map (\page -> """
    Msg__""" <> page <> """ pageMsg -> 
      case model.route of 
        State__""" <> page <> """ pageModel -> 
          case 
            let 
              page = """ <> page <> """.page 
            in 
            page.update pageMsg model.state pageModel 
          of 
            (model_, pageModel_, pageCmd ) -> 
              (Model { model | state = model_, route = State__""" <> page <> """ pageModel_ }, Cmd.map Msg__""" <> page <> """ pageCmd)
        
        """ <> if 1 < length pages then "_ -> (Model model, Cmd.none)" else ""
) pages) <> """

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.route of 

""" <> joinWith "\n" (map (\page -> 
        "  State__" <> page <> " m -> documentMap Msg__" <> page <> " (let page = " <> page <> ".page in page.view model.state m)"        
) pages) <> """

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ """ <> joinWith "\n        , " (map (\page -> "UrlParser.map Route__" <> page <> " (let page = " <> page <> ".page in page.route)") pages) <> """
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
  let route = parseLocation location in 
    case Root.init flags location key of 
      (rootInitialModel, rootInitialCmd) -> 
        case route of

""" <> joinWith "\n" (map (\page -> 

"          Route__" <> page <> " routeValue -> case let page = " <> page <> """.page in page.init location routeValue rootInitialModel of
                (initialModel, initialCmd) -> 
                    ( Model 
                        { route = State__""" <> page <> """ initialModel
                        , state = rootInitialModel
                        , key = key
                        }
                    , Cmd.batch 
                      [ Cmd.map Msg__Root rootInitialCmd
                      , Cmd.map Msg__""" <> page <> """ initialCmd
                      ]
                    )
                """) pages) <> """

subscriptions : Model -> Sub Msg
subscriptions (Model model) = 
    Sub.batch
        (Sub.map Msg__Root Root.subscriptions :: [ """ <> 
        joinWith "\n        , " (map (\page -> "Sub.map Msg__" <> page <> " (let page = " <> page <> ".page in page.subscriptions model.state)") pages) <> """  
        ])


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