{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Control.Foldl as Fold
import qualified Data.Foldable as F
import qualified Data.Text.IO  as TIO
import Text.HTML.TagSoup
import Turtle

streamToList :: Shell a -> IO [a]
streamToList stream = fold stream Fold.list

countStream :: MonadIO io => Shell a -> io Int
countStream stream = fold stream Fold.length

fileStream :: Shell Turtle.FilePath
fileStream = find (has ".html") "."

test :: Monad m => m Turtle.FilePath -> m Text
test file = do
  Right a <- fmap toText file
  return a

fileList :: IO [Turtle.FilePath]
fileList = streamToList fileStream

parseHtmlFile file = parseTags <$> TIO.readFile file

extractAttrs :: [Tag Text] -> [Text]
extractAttrs = filter (/= "") . map (fromAttrib "data-e2e") . filter isTagOpen

report :: Prelude.FilePath -> IO [Text]
report file = extractAttrs <$> (parseHtmlFile file)

main = do
  files <- fileList
  --echo $ mapM test files
  --F.forM_ files $ \f -> do
    --print f
  view (test fileStream)
