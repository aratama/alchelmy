module Elm.Alchemy.Template.Style where 

import Data.Semigroup ((<>))

renderStyle :: String -> Array String -> String
renderStyle application pages = """
/////////////////////////
// AUTO GENERATED FILE //
// DO NOT EDIT THIS    //
/////////////////////////
${
  pages.filter(page => fs.existsSync(`./src/""" <> application <> """/Page/${page}.css`)).map(page => {
    return `import './Page/${page}.css'`
  }).join("\n")
}
"""