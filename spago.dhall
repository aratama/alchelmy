{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "alchelmy"
, dependencies =
  [ "console", "effect", "node-fs-aff", "psci-support", "strings", "node-process" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
