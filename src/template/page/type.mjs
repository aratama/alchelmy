export function renderType(application, pageName) {
    return `module ${application}.Page.${pageName}.Type exposing (..)

import ${application}.Type as Root


type Msg
    = Navigate String


type alias Model =
    {}


type alias Route =
    ()
`;
}
