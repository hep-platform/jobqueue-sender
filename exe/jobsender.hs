{-# LANGUAGE DeriveDataTypeable #-}

module Main where

-- import System.Environment
import System.Console.CmdArgs
import HEP.Automation.JobQueue.Sender.Command
import HEP.Automation.JobQueue.Sender.Type

main :: IO () 
main = do 
-- args <- getArgs
  putStrLn "jobsender"
  param <- cmdArgs mode 

  putStrLn $ show param 
-- readConfigFile param 
  commandLineProcess param 
