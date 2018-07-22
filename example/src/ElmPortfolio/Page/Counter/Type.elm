module ElmPortfolio.Page.Counter.Type exposing (..)


type Msg
    = Increment
    | Decrement


type alias Model =
    Int


-- If it does not extract any parameter from path, `Route` is just `Unit` 
type alias Route =
    ()
