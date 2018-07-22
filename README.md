# elm-automata 

An experimental project for multipage single page application with auto-generated routing file for Elm.

## Motivation: Say good-bye to boilerplates!

[The Elm Architecture](https://guide.elm-lang.org/architecture/) is simple and readable architecture that suitable for use with simgle page application.
However, you need write a lot of boring boilerplates when you want to add a new page in your application: 
For example, in your Main module, You need to add import declarations, add data constructor to hold Msg from child in parent Msg, add routes in routing and so on. 
elm-automata try to auto-generate those boilerplates. This project is highly experimental, so your comments or suggestions are welcome.


## Usage 

* First, `create-elm-app <application> && cd <application>` to make empty project.
* Install `elm-lang/navigation`, `evancz/url-parser`.
* Install `elm-automata` with `npm i aratama/elm-automata` command.
* `npx elm-automata update` to empty application pages.
* Edit `src/Main.elm` as folowing: 

```elm
module Main exposing (..)

import <application>.Routing as Routing exposing (Model, Msg)


main : Program Never Model Msg
main =
    Routing.program {}
```

* Launch the app with `elm-app start`

* Please see [example](example) for more information.

## Commands

* `elm-automata` command will generate `src/<Application>/Routing.elm`.
* `elm-automata new <name>` command will generate a new page named `<name>`.
