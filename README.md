# alchelmy

[![CircleCI](https://circleci.com/gh/aratama/alchelmy.svg?style=svg)](https://circleci.com/gh/aratama/alchelmy)
[![Build status](https://ci.appveyor.com/api/projects/status/8yvgjo92gk8jkw1j?svg=true)](https://ci.appveyor.com/project/aratama/elm-alchemy)

An experimental code generator for an Single Page Application with multiple pages in Elm.

![Alchemist Sendivogius](docs/Alchemik_Sedziwoj_Matejko.JPG)



## Abstract/Motivation

[The Elm Architecture](https://guide.elm-lang.org/architecture/) is simple and readable architecture that suitable for use with simgle page application. However, you need write a lot of boring boilerplates when you want to add a new page in your application: For example, in your Main module, You need to add import declarations, add data constructor to hold `Msg` from child in parent `Msg`, add routes in routing and so on. alchelmy try to generate those boilerplates automatically.

In PHP, to add a new page, all you need is adding a single `Foo.php` in your project. In a like manner, in Alchelmy, all you need is adding only `<PageName>.elm` and writing few codes in it. You don't need to tweak a lot of huge `case-of` branches by hand any more.

In essense, the behavior of Alchelmy is very simple: alchelmy generates only one source file named **`Alchemly.elm`**. This is the Elm codes that orchestrates Web pages written in Elm. 

This project is highly experimental, so your comments or suggestions are welcome.




## Working Sample Application

Please see [example](example) and the automatically generated [Alchelmy.elm](https://github.com/aratama/alchelmy/blob/master/example/src/Alchelmy.elm) for more information. You can also check out the example app at the following url:

* https://alchelmy.netlify.com/




## Usage

### Defining page modules

#### Alchelmy Page Module

An page module have to export types and values named as:

* `Route`
* `Msg`
* `Model`
* `page : Root.Page model msg route a`

`Root.Page` type is defined as: 

```elm
type alias Page model msg route a =
    { init : Flags -> Url -> Key -> route -> Maybe Session -> ( model, Cmd msg )
    , view : model -> Document msg
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , onUrlRequest : UrlRequest -> msg
    , route : Parser (route -> a) a
    , session : model -> Session
    }
```

This `Page` type is similar to the first argument of [Browser.application](https://package.elm-lang.org/packages/elm/browser/latest/Browser#application) function, however notice that some properties and arguments are added. the `route` property is page-by-page URL parsers and express page location. `route` value extracted from URL will be passed to the `init` function of the page module. So you also need to define the `Route` type in the root page module.


#### Alchelmy Root Page Module

The Root page have to export following types:

* `Flags`
* `Session`
* `Page`

TODO: More explanation

### Installation

alchelmy isn't in NPM yet. You can use `npm i aratama/alchelmy` to install alchelmy locally and `npx alchelmy` to execute alchelmy from CLI. You also need to install `elm/browser` and `elm/url` in your project dependencies in advance.

### Command Line Interfaces

alchelmy has a command line interface:

- `alchelmy init <application>` will generate `src/<Application>` directory and make some scaffolds.
- `alchelmy update` will (re)generate `src/<Application>/Alchemy.elm`. Additionally, make `alchemy.js` to import CSS files associated with each pages.
- `alchelmy new <page>` will generate a new page named `<page>`.


## Building Alchelmy Itself

```sh
$ npm i
$ bower update
$ npm run build
```

## Known Limitations

- You can't specify order of precedence of routes. You should take care not to overlap routings.
- You can't call the parent command from the child command. It's on purpose. Both `Root` modules and the page module aren't component and it's not in parent-child relationships.

## References 

* [Matejko, "Alchemist Sendivogius"](https://commons.wikimedia.org/wiki/File:Alchemik_Sedziwoj_Matejko.JPG)