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
import ${application}.Root as Root
""" <> joinWith "\n" (map (\page -> "import " <> application <> ".Page." <> page <> " as " <> page) pages) <> """

type Model = Model 
  { route : RouteState
  , state : Root.Model
  , key : Key
  }

type Route 
  = """ <> joinWith "\n  | " (map (\page -> page <> " " <> page <> ".Route") pages) <> """

type RouteState 
  = """ <> joinWith "\n  | " (map (\page -> page <> "__State " <> page <> ".Model") pages) <> """
  
type Msg
  = UrlRequest UrlRequest
  | Navigate Url
  | Root__Msg Root.Msg
""" <> joinWith "\n" (map (\page -> "  | " <> page <> "__Msg " <> page <> ".Msg") pages) <> """


update : Msg -> Model -> ( Model, Cmd Msg )
update msg (Model model) = 
  case msg of 

    Root__Msg rootMsg -> case Root.update rootMsg model.state of
      (rootModel_, rootCmd) -> 
          (Model { model | state = rootModel_ }, Cmd.map Root__Msg rootCmd)

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

""" <> joinWith "\n" (map (\page -> "        " <> page <> """routeValue -> 
          case 
            let 
              page = """ <> page <> """.page
            in page.init location routeValue model.state 
          of 
            (initialModel, initialCmd) -> 
                ( Model { model | route = """ <> page <> """__State initialModel }
                , Cmd.map """ <> page <> """__Msg initialCmd
                )
        """
      ) pages) <> """


""" <> joinWith "\n" (map (\page -> """
    """ <> page <> """__Msg pageMsg -> 
      case model.route of 
        """ <> page <> """__State pageModel -> 
          case 
            let 
              page = """ <> page <> """.page 
            in 
            page.update pageMsg model.state pageModel 
          of 
            (model_, pageModel_, pageCmd ) -> 
              (Model { model | state = model_, route = """ <> page <> """__State pageModel_ }, Cmd.map """ <> page <> """__Msg pageCmd)
        
        """ <> if 1 < length pages then "_ -> (Model model, Cmd.none)" else ""
) pages) <> """

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.route of 

""" <> joinWith "\n" (map (\page -> 
        "  " <> page <> "__State m -> documentMap " <> page <> "__Msg (let page = " <> page <> ".page in page.view model.state m)"        
) pages) <> """

matchers : Parser (Route -> a) a
matchers =
    oneOf
        [ """ <> joinWith "\n        , " (map (\page -> "UrlParser.map " <> page <> " (let page = " <> page <> ".page in page.route)") pages) <> """
        ]   

parseLocation : Url -> Route
parseLocation location =
    case parse matchers location of
        Just route ->
            route

        Nothing ->
            NotFound ()

navigate : Url -> Msg 
navigate = Navigate

init : Root.Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags location key = 
  let route = parseLocation location in 
    case Root.init flags location key of 
      (rootInitialModel, rootInitialCmd) -> 
        case route of

""" <> joinWith "\n" (map (\page -> 

"          " <> page <> "routeValue -> case let page = " <> page <> """.page in page.init location routeValue rootInitialModel of
                (initialModel, initialCmd) -> 
                    ( Model 
                        { route = """ <> page <> """__State initialModel
                        , state = rootInitialModel
                        , key = key
                        }
                    , Cmd.batch 
                      [ Cmd.map Root__Msg rootInitialCmd
                      , Cmd.map """ <> page <> """__Msg initialCmd
                      ]
                    )
                """) pages) <> """

subscriptions : Model -> Sub Msg
subscriptions (Model model) = 
    Sub.batch
        (Sub.map Root__Msg Root.subscriptions :: [ """ <> 
        joinWith "\n        , " (map (\page -> "Sub.map " <> page <> "__Msg (let page = " <> page <> ".page in page.subscriptions model.state)") pages) <> """  
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