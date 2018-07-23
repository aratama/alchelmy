module ElmPortfolio.Page.Http.Type exposing (..)

import Http


type Msg
    = Navigate String
    | MorePlease
    | NewGif (Result Http.Error String)


type alias Model =
    { topic : String
    , gifUrl : String
    }


type alias Route =
    {}
