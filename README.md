# elm-automata 

An experimental project for multipage single page application with auto-generated routing file for Elm.

## Motivation: Say good-bye to boilerplates!

[The Elm Architecture](https://guide.elm-lang.org/architecture/) is simple and readable architecture that suitable for use with simgle page application.
However, you need write a lot of boring boilerplates when you want to add a new page in your application: 
For example, in your Main module, You need to add import declarations, add data constructor to hold Msg from child in parent Msg, add routes in routing and so on. 
elm-automata try to auto-generate those boilerplates. This project is highly experimental, so your comments or suggestions are welcome.

## Commands

* `elm-automata` command will generate `src/<Application>/Routing.elm`.
* `elm-automata new <name>` command will generate a new page named `<name>`.

## Tutorial 

* First, `create-elm-app <application> && cd <application>` to make empty project.
* Install `elm-lang/navigation`, `evancz/url-parser`.
* Install `elm-automata` with `npm i aratama/elm-automata` command. elm-automata is not in npm yet.
* `npx elm-automata update` to generate empty application pages. It will ask about the application name.
* Edit `src/Main.elm` as folowing: 

```elm
module Main exposing (..)

import <application>.Routing as Routing exposing (Model, Msg)


main : Program Never Model Msg
main =
    Routing.program {}
```

* Launch the app with `elm-app start`. You should see the `NotFound` page.
* `npx elm-automata new Cat` will generate a page "Cat".
* Go to [http://localhost:3000/#/cat](http://localhost:3000/#/cat) and check the page.

Please see [example](example) for more information.


# Known Limitations

* You can't specify order of precedence of the routes.
* You must to split an page definition into `View.elm`, `Update.elm` and `Type.elm`. This is just my taste :p