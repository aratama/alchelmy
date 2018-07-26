module ElmPortfolio.Page.Http.Type exposing (..)

import Http
import ElmPortfolio.Type as Root


type Msg
    = AscentMsg Root.AscentMsg
    | MorePlease
    | NewGif (Result Http.Error String)


type alias Model =
    { topic : String
    , gifUrl : String
    }


type alias Route =
    ()
