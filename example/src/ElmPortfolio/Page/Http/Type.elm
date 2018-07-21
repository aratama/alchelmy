module ElmPortfolio.Page.Http.Type exposing (..)

import Http


type Msg
    = MorePlease
    | NewGif (Result Http.Error String)


type alias Model =
    { topic : String
    , gifUrl : String
    }


type alias Route =
    {}
