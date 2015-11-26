{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.Text         as T
import qualified Data.Foldable     as F
import           Turtle
import           Utils             as U

main :: IO ()
main = do
  files <- fmap U.filePathToText U.fileList
  let ret = "\n----------\n"
  echo $ ret
  F.forM_ files $ \file -> do
    echo $ file <> "\n"
    result <- U.report $ T.unpack $ file
    F.forM_ result $ \tag -> do
      echo $ "-> " <> tag
    echo $ ret
