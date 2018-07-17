# elm-generate

Single page application experimental project with auto-generated routing file for Elm.

# Motivation

[The Elm Architecture](https://guide.elm-lang.org/architecture/) is simple and readable architecture that suitable for use with simgle page application.
However, you need write a lot of boiler plates when you want to add a new page in your application. 
For example, in your Main module, You need to add import declarations, add data constructor to hold Msg from child in parent Msg, add routes in routing and so on. 
elm-generate try to auto-generate those boiler plates.

# Usage 

Do `npm run build` and `src/<Application>/Routing.elm` and `src/index.js` will be generated.

# Project Conventions 

## Typicial Directory Structure

In elm-generate, you must conform to the following structure:

```
src 
    <Application>
        Page
            <Page1>
                style.css
                Type.elm
                Update.elm
                View.elm
            <Page2>
                style.css
                Type.elm
                Update.elm
                View.elm
            <Page3>
                style.css
                Type.elm
                Update.elm
                View.elm
        [Routing.elm]
    Main.elm
    [index.js]
```

* `<Application>` is your application name.
* `<Page1>`, `<Page2>` and so on contains each view or update modules.
* `[index.js]` and `[Routing.elm]` is auto-generated file. 
