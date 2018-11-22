port module ElmPortfolio.Ports exposing (..)


port saveTopic : String -> Cmd msg


port requestTopic : () -> Cmd msg


port receiveTopic : (Maybe String -> msg) -> Sub msg
