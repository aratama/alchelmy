module Alchelmy.Template.Style where 

import Prelude

import Data.Array (filterA)
import Data.String (joinWith)
import Effect.Aff (Aff)
import Node.FS.Aff (exists)

renderStyle :: String -> Array String -> Aff String
renderStyle application pages = do 
  filtered <- filterA (\page -> exists ("./src/" <> application <> "/Page/" <> page <> ".css")) pages
  pure $ """
/////////////////////////
// AUTO GENERATED FILE //
// DO NOT EDIT THIS    //
/////////////////////////
""" <> joinWith "\n" (map (\page -> "import './Page/" <> page <> ".css'") filtered)
