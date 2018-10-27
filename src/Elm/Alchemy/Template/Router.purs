module Elm.Alchemy.Template.Router where 

renderRouter :: String -> Array String -> String
renderRouter application pages = """
--------------------------
-- Auto-generated codes --
-- Do not edit this     -- 
--------------------------

module ${application}.Alchemy exposing (Model, Msg, program)

import Browser exposing (Document, UrlRequest(..), application)
import Browser.Navigation exposing (Key, load, pushUrl)
import Html as Html exposing (Html, text)
import Maybe as Maybe
import Url exposing (Url)
import Url.Parser as UrlParser exposing (s, oneOf, Parser, parse, (</>))
import ${application}.Root as Root
${pages.map(page => `
import ${application}.Page.${dots(page)} as ${bars(page)}
`.trim()
).join("\n")}


type Model = Model 
  { route : RouteState
  , state : Root.Model
  , key : Key
  }

type Route = 
  ${pages.map(page => `${bars(page)} ${bars(page)}.Route`).join("\n  | ")}

type RouteState = 
  ${pages
    .map(page => `${bars(page)}__State ${bars(page)}.Model`)
    .join("\n  | ")}
  
type Msg
  = UrlRequest UrlRequest
  | Navigate Url
  | Root__Msg Root.Msg
${pages.map(page => `  | ${bars(page)}__Msg ${bars(page)}.Msg`).join("\n")}



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
      case route of ${pages
      .map(
        page => `
        ${bars(page)} routeValue -> 
          case 
            let 
              page = ${bars(page)}.page 
            in page.init location routeValue model.state 
          of
              (initialModel, initialCmd) -> 
                ( Model { model | route = ${bars(page)}__State initialModel }
                , Cmd.map ${bars(page)}__Msg initialCmd
                )
    `
      )
      .join("\n")}

${pages
    .map(
      page => `
    ${bars(page)}__Msg pageMsg -> 
      case model.route of 
        ${bars(page)}__State pageModel -> 
          case 
            let 
              page = ${bars(page)}.page 
            in 
            page.update pageMsg model.state pageModel 
          of 
            (model_, pageModel_, pageCmd ) -> 
              (Model { model | state = model_, route = ${bars(page)}__State pageModel_ }, Cmd.map ${bars(page)}__Msg pageCmd)
        
        ${1 < pages.length ? "_ -> (Model model, Cmd.none)" : ""}
      
  `
    )
    .join("\n")}

documentMap : (msg -> Msg) -> Document msg -> Document Msg
documentMap f { title, body } = { title = title, body = List.map (Html.map f) body }

view : Model -> Document Msg
view (Model model) = case model.route of 
${pages
    .map(
      page =>
        `  ${bars(page)}__State m -> documentMap ${bars(page)}__Msg (let page = ${bars(
          page
        )}.page in page.view model.state m)`
    )
    .join("\n")}


matchers : Parser (Route -> a) a
matchers =
    oneOf
        [
${pages
    .map(page => `        UrlParser.map ${bars(page)} (let page = ${bars(page)}.page in page.route)`)
    .join(",\n")}
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
${pages
    .map(
      page => `
            ${bars(page)} routeValue -> case let page = ${bars(
        page
      )}.page in page.init location routeValue rootInitialModel of
                (initialModel, initialCmd) -> 
                    ( Model 
                        { route = ${bars(page)}__State initialModel
                        , state = rootInitialModel
                        , key = key
                        }
                    , Cmd.batch 
                      [ Cmd.map Root__Msg rootInitialCmd
                      , Cmd.map ${bars(page)}__Msg initialCmd
                      ]
                    )
  `
    )
    .join("\n")}   

subscriptions : Model -> Sub Msg
subscriptions (Model model) = 
    Sub.batch
        (Sub.map Root__Msg Root.subscriptions :: [  ${pages
          .map(
            page =>
              `Sub.map ${bars(page)}__Msg (let page = ${bars(
                page
              )}.page in page.subscriptions model.state)`
          )
          .join("\n        , ")}
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