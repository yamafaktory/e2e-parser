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
  let line = T.replicate 60 $ T.pack "-"
  let ret = T.pack "\n"
  let textFilesPath = fromText filesPath

  if T.length filesPath > 0 then do
    totalFiles <- countStream (fileStream textFilesPath)
    echo $ line <> ret <> format (d%" file(s) scanned") totalFiles
    files <- U.filePathToText <$> U.fileList textFilesPath
    echo $ line
    F.forM_ files $ \file -> do
      echo $ format (w%"") file <> ret
      result <- U.report $ T.unpack $ file
      echo $ format ("Found "%d%" data attribute(s)") (length result)
      F.forM_ result $ \tag -> do
        echo $ format ("-> "%s) tag
      echo $ line
    else echo "Empty path - exit"
