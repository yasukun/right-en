{-# LANGUAGE OverloadedStrings #-}
module Lib
    ( parseYml
    ) where

import Data.Yaml
import Control.Applicative
import Data.Maybe (fromJust)

import qualified Data.ByteString.Char8 as BS

data Question = Question {japanese_txt :: String,
                          english_txt :: String}
                deriving (Show)

instance FromJSON Question where
    parseJSON (Object v) = Question <$>
                           v .: "q" <*>
                           v .: "a"
    --  A non-Object value is of the wrong type, so fail.
    parseJSON _ = error "Can't parse Question from YAML/JSON"

parseYml = do
  ymlData <- BS.readFile "/tmp/test.yaml"
  let users = Data.Yaml.decode ymlData :: Maybe [Question]
  print $ fromJust users
