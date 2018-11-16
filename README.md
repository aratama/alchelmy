# alchelmy

[![CircleCI](https://circleci.com/gh/aratama/alchelmy.svg?style=svg)](https://circleci.com/gh/aratama/alchelmy)
[![Build status](https://ci.appveyor.com/api/projects/status/8yvgjo92gk8jkw1j?svg=true)](https://ci.appveyor.com/project/aratama/alchelmy)

An experimental code generator for an massive Single Page Application with multiple pages in Elm.

![Alchemist Sendivogius](docs/Alchemik_Sedziwoj_Matejko.JPG)

## Motivation

[The Elm Architecture](https://guide.elm-lang.org/architecture/) is simple and readable architecture that suitable for use with simgle page application.
However, you need write a lot of boring boilerplates when you want to add a new page in your application: For example, in your Main module, You need to add import declarations, add data constructor to hold `Msg` from child in parent `Msg`, add routes in routing and so on. alchelmy try to auto-generate those boilerplates. 

This project is highly experimental, so your comments or suggestions are welcome.

## Principle

In essence, alchelmy generates only one source files: **`Alchemly.elm`**. This is an Elm source code that orchestrates Web pages written in Elm.

In Alchelmy, an web page is represented by a single source files in `src/<ProjectName>/Page/*.elm` directory. Each page modules are usual Elm modules that have its `Model`, `view` and `update`. However, in Alchelmy, `Model` must have a `session` property as follows.

```elm
type Model = 
    { session : Session
    , count : Int
    }
```

If you move pages, this `session` property is kept between `Model`. Of cource you can refere the `session` property like with `model.session`. You can also modify `session` in each `update` function:

```elm
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SaveUserName ->
            let
                session =
                    model.session
            in
            ( { model | session = { session | theme = model.value } }
            , saveThemeToLocalStorage model.value
            )
```

## Installation

alchelmy isn't in NPM yet. You can use `npm i aratama/alchelmy` to install alchelmy and `npx` to execute alchelmy from CLI.
You also need to install `elm/browser` and `elm/url` in your project dependencies in advance.

## Command Line Interfaces

alchelmy has a command line interface:

- `alchelmy init <application>` will generate `src/<Application>` directory and make some scaffolds.
- `alchelmy update` will (re)generate `src/<Application>/Alchemy.elm`. Additionally, make `alchemy.js` to import CSS files associated with each pages.
- `alchelmy new <page>` will generate a new page named `<page>`.

Please see [example](example) for more information.


## Building Alchelmy Itself

```sh
$ npm i 
$ bower update
$ npm run build
```

## Known Limitations

- You can't specify order of precedence of routes.


----

* [Jan Matejko, "Alchemist Sendivogius"](https://commons.wikimedia.org/wiki/File:Alchemik_Sedziwoj_Matejko.JPG)