# elm-automata 

[![Build Status](https://travis-ci.org/aratama/elm-automata.svg?branch=master)](https://travis-ci.org/aratama/elm-automata) [![Build status](https://ci.appveyor.com/api/projects/status/1uk1jk36a2e4i0fb?svg=true)](https://ci.appveyor.com/project/aratama/elm-automata) [![CircleCI](https://circleci.com/gh/aratama/elm-automata.svg?style=svg)](https://circleci.com/gh/aratama/elm-automata)

An experimental project for multipage single page application with auto-generated routing file for Elm.

## Motivation: Say good-bye to boilerplates!

[The Elm Architecture](https://guide.elm-lang.org/architecture/) is simple and readable architecture that suitable for use with simgle page application.
However, you need write a lot of boring boilerplates when you want to add a new page in your application: 
For example, in your Main module, You need to add import declarations, add data constructor to hold Msg from child in parent Msg, add routes in routing and so on. 
elm-automata try to auto-generate those boilerplates. This project is highly experimental, so your comments or suggestions are welcome.

## Install

elm-automata is not in npm yet. `npm i aratama/elm-automata` to install elm-automata. 
You can `npx` to execute elm-automata from cli.
You also need to install `elm-lang/navigation` and `evancz/url-parser` as elm-package dependencies.

## Commands

elm-automata has a command line interface:

* `elm-automata update` command will generate `src/<Application>/Routing.elm`.
* `elm-automata new <name>` command will generate a new page named `<name>`.

## Tutorial 

* First, do `create-elm-app <application>` and `cd <application>` to make empty project.
* `npx elm-automata update` to generate empty application pages. It will ask about the application name and create an application directory in `src`. 
* Edit `src/Main.elm` as folowing: 

```elm
module Main exposing (..)

import <application>.Automata as Automata exposing (Model, Msg, program)


main : Program Never Model Msg
main = program
```

* Launch the app with `elm-app start`. You should see the `NotFound` page because you don't have the `top` page yet.
* `npx elm-automata new Cat` will generate a page "Cat".
* Go to [http://localhost:3000/#/cat](http://localhost:3000/#/cat) and check the page.

Please see [example](example) for more information.


## Parent-Child Communicaton

In the root type, you must define types named `AscentMsg` and `DescentMsg`.


## Known Limitations

* You can't specify order of precedence of the routes.
* You must to split an page definition into `View.elm`, `Update.elm` and `Type.elm`. This is just my taste :p