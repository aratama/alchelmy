module ElmPortfolio.Page.Counter.Type exposing (..)

import ElmPortfolio.Type as Root


-- `Route` is a container that stores parameters from the url and deliver into `init` function.
-- If it does not extract any parameter from path, `Route` is just `Unit`


type alias Route =
    ()



-- `Msg` is a local message container of the page.


type Msg
    = Navigate String 
    | Increment
    | Decrement
    


-- `Msg` is a local state container that stores the state of the page.


type alias Model =
    Int
