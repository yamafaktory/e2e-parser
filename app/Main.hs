{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Data.Foldable as F
import qualified Data.Text     as T
import           Turtle

import           Utils         as U

main :: IO ()
main = do
  files <- U.filePathToText <$> U.fileList
  let ret = "\n----------\n"
  echo $ ret
  F.forM_ files $ \file -> do
    echo $ format (w%"\n") file
    result <- U.report $ T.unpack $ file
    F.forM_ result $ \tag -> do
      echo $ format ("-> "%s) tag
    echo $ ret
