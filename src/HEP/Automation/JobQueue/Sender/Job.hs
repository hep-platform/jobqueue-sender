{-# LANGUAGE OverloadedStrings #-}

module HEP.Automation.JobQueue.Sender.Job where

import Network.HTTP.Types
import Network.HTTP.Enumerator
import qualified Data.ByteString.Lazy as L 
import qualified Data.ByteString.Lazy.Char8 as C
import qualified Data.ByteString.Char8 as SC

import HEP.Automation.JobQueue.Config
import HEP.Automation.JobQueue.JobType
import HEP.Automation.JobQueue.JobJson
import HEP.Automation.JobQueue.JobQueue

import Data.Aeson.Encode

import HEP.Automation.MadGraph.Model
import HEP.Automation.MadGraph.Model.AxiGluon
import HEP.Automation.MadGraph.SetupType
import HEP.Automation.MadGraph.Machine
import HEP.Automation.MadGraph.UserCut

import HEP.Automation.MadGraph.Dataset.Set20110621set1

{- testjob_psetup = PS MadGraph4 DummyModel "test" "test" "test" 
testjob_rsetup = RS DummyParam 10000 LHC7 Fixed 200.0 NoMatch NoCut NoPYTHIA NoUserCutDef NoPGS 1

testjob = EventSet testjob_psetup testjob_rsetup 

testjobdetail = EventGen testjob -}

jobqueueSend :: IO ()
jobqueueSend = do 
  let jobdetails = map EventGen eventsets
     

--  putStrLn (show jobdetails)
  putStrLn $ "sending " ++ show (length eventsets) ++ " jobs"
  mapM_ sendJob jobdetails


sendJob :: JobDetail -> IO () 
sendJob jobdetail = do 
  manager <- newManager 
  requesttemp <- parseUrl "http://127.0.0.1:3600/queue"

  let json = encode $ toAeson jobdetail 


  let myrequestbody = RequestBodyLBS json 
  let requestpost = requesttemp { method = methodPost, 
                                  requestHeaders = [ ("Content-Type", "text/plain") ], 
                                  requestBody = myrequestbody } 
  r <- httpLbs requestpost manager 
  putStrLn $ show r 



