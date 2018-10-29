module Alchelmy where 

import Alchelmy.Template.Page (renderBlankPage, Routing(..))
import Alchelmy.Template.Root (renderRoot)
import Alchelmy.Template.Router (renderRouter)
import Alchelmy.Template.Style (renderStyle)
import Control.Monad.Error.Class (throwError, try)
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
import Node.Buffer (fromString)
import Node.Encoding (Encoding(..))
import Node.FS.Aff (exists, mkdir, readdir, stat, writeFile)
import Node.FS.Stats (isDirectory)
import Node.Path (FilePath, basenameWithoutExt, resolve)
import Node.Process (argv, exit)
import Prelude (Unit, bind, discard, flip, map, not, pure, void, when, ($), (<$>), (<>))

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
            Right true -> ensureDir dir 
            Right false -> throwError (error $ application <> " is not a valid package name.")

ensureDir :: FilePath -> Aff Unit
ensureDir dir = void (try (mkdir dir))

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
        
    -- generate NoutFound page
    notFoundExists <- pageExists "NotFound"
    when (not notFoundExists) do
        generateNewPage "NotFound" RouteToNothing

    -- generate top page
    topExists <- pageExists "Top"
    when (not notFoundExists) do
        generateNewPage "Top" RouteToTop

    -- get page names
    pageFiles <- glob $ "./src/" <> application <> "/Page/*.elm"
    let pages = map (\p -> basenameWithoutExt p ".elm") pageFiles
    when (null pages) do
        liftEffect $ throw "Pege not found."

    -- generate <application>.Alchelmy.elm
    log $ "Generating ./src/" <> application <> "/Alchelmy.elm for "<> joinWith ", " pages <> "..."
    sourceBuffer <- liftEffect $ fromString (renderRouter application pages) UTF8
    writeFile ("./src/" <> application <> "/Alchelmy.elm") sourceBuffer

    -- generate alchelmy.js
    log $ "Generating ./src/" <> application <> "/alchelmy.js..."    
    stylePath <- liftEffect $ resolve ["./src/", application] "alchelmy.js"
    styleRendered <- renderStyle application pages
    styleBuffer <- liftEffect $ fromString styleRendered UTF8
    writeFile stylePath styleBuffer

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
                    generateNewPage pageName RouteToPageName
                    generateRouter args 

                else do  
                    Console.error $ "Invalid page name: " <> pageName <> ". An page name must be an valid Elm module name."
                    exit 1 

        ["update"] -> launchAff_ do 
            generateRouter args

        [] -> log usage 
        
        ["--help"] -> log usage

        ["-h"] -> log usage

        command -> do 
            Console.error $ "[ERROR] Unknown command: " <> joinWith " " command  
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
                Console.error $ "[Error] Directory '" <> pageName <> "' already exists."
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