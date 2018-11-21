module Alchelmy.Template.Style where

import Prelude

import Data.Array (filterA)
import Data.String (joinWith, Pattern(..), split)
import Effect.Aff (Aff)
import Node.FS.Aff (exists)
import Node.Path (sep)

p s = joinWith "/" (split (Pattern ".") s)

renderStyle :: String -> Array String -> Aff String
renderStyle application pages = do
  filtered <- filterA (\page -> exists ("./src/" <> p page <> ".css")) pages
  pure $ """
/////////////////////////
// AUTO GENERATED FILE //
// DO NOT EDIT THIS    //
/////////////////////////
""" <> joinWith "\n" (map (\page -> "import './" <> p page <> ".css'") filtered)
