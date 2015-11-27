{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.Foldable as F
import qualified Data.Text     as T
import           Turtle

import           Utils         as U

main :: IO ()
main = do
  echo $ "Please provide the path to the HTML files:"
  Just filesPath <- readline
  let textFilesPath = fromText filesPath
  if T.length filesPath > 0 then do
    files <- U.filePathToText <$> U.fileList textFilesPath
    let ret = T.replicate 60 $ T.pack "-"
    echo $ ret
    F.forM_ files $ \file -> do
      echo $ format (w%"\n") file
      result <- U.report $ T.unpack $ file
      F.forM_ result $ \tag -> do
        echo $ format ("-> "%s) tag
      echo $ ret
    else echo "Empty path - exit"
