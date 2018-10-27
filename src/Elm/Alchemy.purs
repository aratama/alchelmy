module Elm.Alchemy where 

import Control.Monad.Error.Class (throwError)
import Data.Array (catMaybes, drop, null)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Data.String (joinWith)
import Data.String.Regex (regex, test)
import Data.String.Regex.Flags (noFlags)
import Data.Traversable (for)
import Effect (Effect)
import Effect.Aff (Aff, error, launchAff_, makeAff, nonCanceler)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Effect.Console (error) as Console
import Effect.Exception (Error, throw)
import Elm.Alchemy.Template.Page (renderBlankPage)
import Elm.Alchemy.Template.Root (renderRoot)
import Elm.Alchemy.Template.Router (renderRouter)
import Elm.Alchemy.Template.Style (renderStyle)
import Node.Buffer (fromString)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (exists, mkdir, readdir, stat, writeFile)
import Node.FS.Stats (isDirectory)
import Node.Path (FilePath, basenameWithoutExt, resolve)
import Node.Process (argv, exit)
import Prelude (Unit, bind, flip, pure, ($), (<$>), (<>), discard, when, not, map)

foreign import globEffect :: (Error -> Effect Unit) -> (Array FilePath -> Effect Unit) -> String -> Effect (Array FilePath) 

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
            Right true -> mkdir dir 
            Right false -> throwError (error $ application <> " is not a valid package name.")

generateRouter :: Array String -> Aff Unit
generateRouter argv = do 
    -- create root Type.elm, Update.elm and View.elm
    application <- getApplicationName

    rootPath <- liftEffect $ resolve ["src", application] "Root.elm"
    rootExists <- exists rootPath

    when (not rootExists) do 
        log $ "Generating " <> application <> "/Root.elm"    
        path <- liftEffect $ resolve [".", "src", application] "Root.elm"
        rootBuffer <- liftEffect $ fromString (renderRoot application) UTF8
        writeFile path rootBuffer
        
    -- generate NoutFound
    notFoundExists <- pageExists "NotFound"
    when (not notFoundExists) do
        generateNewPage "NotFound"

    -- get page names
    pageFiles <- glob $ "./src/" <> application <> "/Page/*.elm"
    let pages = map (\p -> basenameWithoutExt p ".elm") pageFiles
    when (null pages) do
        liftEffect $ throw "Pege not found."

    -- generate <application>.Alchemy.elm
    log $ "Generating ./src/" <> application <> "/Alchemy.elm for "<> joinWith ", " pages <> "..."
    
    let source = renderRouter application pages
    sourceBuffer <- liftEffect $ fromString source UTF8
    writeFile ("./src/" <> application <> "/Alchemy.elm") sourceBuffer

    -- generate alchemy.js
    log $ "Generating ./src/" <> application <> "/alchemy.js..."
    let indexSource = renderStyle application pages
    
    path <- liftEffect $ resolve ["./src/", application] "alchemy.js"
    buffer <- liftEffect $ fromString indexSource UTF8

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
    args <- argv
    case drop 2 args of 

        ["init", applicationName] -> launchAff_ do 
            createApplication applicationName 
            generateRouter args


        ["new", pageName] -> do 
            if validatePageName pageName
                then launchAff_ do  
                    generateNewPage pageName
                    generateRouter args

                else do  
                    Console.error $ "Invalid page name: " <> pageName <> ". An page name must be an valid Elm module name."
                    exit 1 

        ["update"] -> launchAff_ do 
            generateRouter args

        command -> do 
            Console.error $ "[ERROR] Unknown command: " <> joinWith " " command  
            exit 1 


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

generateNewPage :: String -> Aff Unit
generateNewPage pageName = do 

  if validatePageName pageName 
    then do 
        log $ "Generating new page: " <> pageName
        application <- getApplicationName
        log $ "Application found: " <> application
        exists <- pageExists pageName
        if exists
            then liftEffect do 
                Console.error $ "[Error] Directory '" <> pageName <> "' already exists."
                exit 1
            else do 
                dir <- liftEffect $ resolve ["./src/", application] "Page"
                mkdir dir
                cssPath <- liftEffect $ resolve [dir] (pageName <> ".css")
                cssBuffer <- liftEffect $ fromString "" UTF8
                writeFile cssPath cssBuffer
                elmPath <- liftEffect $ resolve [dir] (pageName <> ".elm")
                elmBuffer <- liftEffect $ fromString (renderBlankPage application pageName) UTF8
                writeFile elmPath elmBuffer
                
    else do
        throwError $ error $ "Invalid page name: " <> pageName <> ". An page name must be an valid Elm module name."