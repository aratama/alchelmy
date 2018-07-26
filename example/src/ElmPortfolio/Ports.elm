port module ElmPortfolio.Ports exposing (..)


port saveThemeToLocalStorage : String -> Cmd msg


port requestThemeFromLocalStorage : () -> Cmd msg


port receiveThemeFromLocalStorage : (Maybe String -> msg) -> Sub msg
