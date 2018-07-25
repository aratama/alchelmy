export function renderType(application, pageName) {
  return `module ${application}.Page.${pageName}.Type exposing (..)

import ElmPortfolio.Type as Root


type Msg
    = AscentMsg Root.AscentMsg


type alias Model =
    {}


type alias Route =
    ()
`;
}
