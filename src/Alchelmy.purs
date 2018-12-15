module Alchelmy where

import Alchelmy.Template.Page (renderBlankPage, Routing(..))
import Alchelmy.Template.Root (renderRoot)
import Alchelmy.Template.Router (renderRouter)
import Control.Monad.Error.Class (throwError, try)
import Data.Array (catMaybes, drop, null, filterA, head)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String (Pattern(..), joinWith, indexOf, split)
import Data.String.Regex (regex, test)
import Data.String.Regex.Flags (noFlags)

import Data.Traversable (for, for_)
import Effect (Effect)
import Effect.Aff (Aff, error, launchAff_, makeAff, nonCanceler)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Console (error) as Console
import Effect.Exception (Error, throw)
import Node.Buffer (fromString)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (exists, mkdir, readdir, stat, writeFile, readTextFile)
import Node.FS.Stats (isDirectory)
import Node.Path (FilePath, basenameWithoutExt, resolve, relative, sep, dirname)
import Node.Process (argv, exit)
import Prelude (Unit, bind, discard, flip, map, not, pure, void, when, ($), (<$>), (<>), (==))

foreign import globEffect :: (Error -> Effect Unit) -> (Array FilePath -> Effect Unit) -> String -> Effect (Array FilePath)

magic :: String
magic = "-- alchelmy page"

rootMagic :: String
rootMagic = "-- alchelmy root page"

glob :: String -> Aff (Array FilePath)
glob pattern = makeAff \resolve -> do
    results <- globEffect (\err -> resolve (Left err)) (\results -> resolve (Right results)) pattern
    pure nonCanceler

createApplication :: String -> Aff Unit
createApplication application = do
    dir <- liftEffect (resolve ["src"] application)
    exists <- exists dir
    if exists
        then
            throwError (error $ "Directory " <> application <> " already exists.")
        else case flip test application <$> regex "[A-Z][a-zA-Z0-9_]*" noFlags of
            Left err -> throwError (error $ "Invalid Regexp")
            Right true -> ensureDir dir
            Right false -> throwError (error $ application <> " is not a valid package name.")

ensureDir :: FilePath -> Aff Unit
ensureDir dir = void (try (mkdir dir))

generateRouter :: String -> String -> Aff Unit
generateRouter rootPattern pagePattern = do
    -- create root Type.elm, Update.elm and View.elm
    application <- getApplicationName

    let srcDir = "./src/"

    rootElmFiles <- glob rootPattern
    rootPath <- case head rootElmFiles of
        Nothing -> do
            log $ "Generating " <> application <> "/Root.elm"
            path <- liftEffect $ resolve [".", "src", application] "Root.elm"
            rootExists <- exists path
            if rootExists 
                then do
                    liftEffect $ throw "Root.elm already exists"
                else do 
                    rootBuffer <- liftEffect $ fromString (renderRoot application) UTF8
                    writeFile path rootBuffer
                    pure path
        Just root -> do
            pure root

    -- generate NoutFound page
    notFoundExists <- pageExists "NotFound"
    when (not notFoundExists) do
        generateNewPage "NotFound" RouteToNothing

    -- generate top page
    topExists <- pageExists "Top"
    when (not notFoundExists) do
        generateNewPage "Top" RouteToTop

    -- get page names
    -- pageFiles <- glob $ "./src/" <> application <> "/Page/*.elm"

    elmFiles <- glob pagePattern
    pageModuleNames <- for elmFiles \file -> do
        path <- liftEffect $ resolve [dirname file] (basenameWithoutExt file ".elm")
        pure $ joinWith "." (split (Pattern sep) (relative srcDir path))

    for_ pageModuleNames \file -> do
        log $ "Found module: " <> file

    let pages = map (\p -> basenameWithoutExt p ".elm") elmFiles
    when (null pages) do
        liftEffect $ throw "Page not found."

    -- generate <application>.Alchelmy.elm
    sourceBuffer <- liftEffect $ fromString (renderRouter application pageModuleNames) UTF8
    generatedElmPath <- liftEffect $ resolve [srcDir] "Alchelmy.elm"
    log $ "Generating " <> generatedElmPath <> " ..."
    writeFile generatedElmPath sourceBuffer

    log "Done."


getApplicationName :: Aff String
getApplicationName = do

    filesInRoot <- readdir "./src"

    dirsWithNull <- for filesInRoot \file -> do
        path <- liftEffect $ resolve ["./src/"] file
        stat <-  stat path
        pure if isDirectory stat then Just file else Nothing

    let dirs = catMaybes dirsWithNull

    case dirs of
        [application] -> pure application
        _ -> throwError $ error "Cannot decide the application name. Too many directory or no directory in src directory. "

main :: Effect Unit
main = do
    let defaultPagePattern = "src/**/Page/*.elm"
    let defaultRootPattern = "src/**/Root.elm"
    args <- argv
    case drop 2 args of

        ["init", applicationName] -> launchAff_ do
            createApplication applicationName
            generateRouter defaultRootPattern defaultPagePattern

        ["new", pageName] -> do
            if validatePageName pageName
                then launchAff_ do
                    generateNewPage pageName RouteToPageName
                    generateRouter defaultRootPattern defaultPagePattern

                else do
                    Console.error $ "Invalid page name: " <> pageName <> ". An page name must be an valid Elm module name."
                    exit 1



        ["update"] -> launchAff_ do
            generateRouter defaultRootPattern defaultPagePattern

        ["update", "--page", pattern] -> launchAff_ do
            generateRouter defaultRootPattern pattern

        ["update", "--root", pattern] -> launchAff_ do
            generateRouter pattern defaultPagePattern

        ["update", "--root", rootPattern, "--page", pagePattern] -> launchAff_ do
            generateRouter rootPattern pagePattern

        [] -> log usage

        ["init"] -> log usage

        ["new"] -> log usage

        ["--help"] -> log usage

        ["-h"] -> log usage

        command -> do
            Console.error $ "[ERROR] Unknown sub command: " <> joinWith " " command
            exit 1

usage :: String
usage = """
Usage:

  alchelmy init <application>

    Create new application.

  alchelmy update

    (Re)Generate Alchemy.elm, alchemy.js

  alchelmy new <name>

    Create new page named <name>. <name> must be an valid module name.
"""

validatePageName :: String -> Boolean
validatePageName pageName = case flip test pageName <$> regex "[A-Z][a-zA-Z0-9_]*" noFlags of
    Left err -> false
    Right result -> result

pageExists :: String -> Aff Boolean
pageExists pageName = do
    if validatePageName pageName
        then do
            application <- getApplicationName
            path <- liftEffect $ resolve ["./src/", application, "Page"] (pageName <> ".elm")
            exists path
        else
            throwError $ error $ "Invalid page name: " <> pageName <> ". An page name must be an valid Elm module name."

generateNewPage :: String -> Routing -> Aff Unit
generateNewPage pageName routing = do

  if validatePageName pageName
    then do
        log $ "Generating new page: " <> pageName
        application <- getApplicationName
        log $ "Application found: " <> application
        exists <- pageExists pageName
        if exists
            then liftEffect do
                Console.error $ "[Error] Page module '" <> pageName <> "' already exists."
                exit 1
            else do
                dir <- liftEffect $ resolve ["./src/", application] "Page"
                ensureDir dir
                cssPath <- liftEffect $ resolve [dir] (pageName <> ".css")
                cssBuffer <- liftEffect $ fromString "" UTF8
                writeFile cssPath cssBuffer
                elmPath <- liftEffect $ resolve [dir] (pageName <> ".elm")
                elmBuffer <- liftEffect $ fromString (renderBlankPage application pageName routing) UTF8
                writeFile elmPath elmBuffer

    else do
        throwError $ error $ "Invalid page name: " <> pageName <> ". An page name must be an valid Elm module name."