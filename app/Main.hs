module Main where

import Lib
import Control.Monad.State
import System.Directory
import System.FilePath
import System.IO
import System.Console.CmdArgs

type Foo a = StateT String IO a

replT :: Foo ()
replT = do
  liftIO $ putStrLn "q: blah blah blah."
  str <- liftIO getLine
  state <- get
  liftIO $ putStrLn ("current state: " ++ state)
  liftIO $ putStrLn ("setting state: " ++ str)
  put str
  replT

main = do
  userdir <- getUserDocumentsDirectory
  let datapath = userdir </> ".right-en" </> "save.txt"
  runStateT replT "Initial state"
