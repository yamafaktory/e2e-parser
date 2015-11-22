{-# LANGUAGE OverloadedStrings #-}

module Main where

import qualified Control.Foldl as Fold
import qualified Data.Text.IO as TIO
import Text.HTML.TagSoup
import Turtle

streamToList :: Shell a -> IO [a]
streamToList stream = fold stream Fold.list

htmlFiles :: Shell Turtle.FilePath
htmlFiles = find (has ".html") "."

test :: IO [Turtle.FilePath]
test = do
  files <- streamToList htmlFiles
  return files

parseHtmlFile :: IO [Tag Text]
parseHtmlFile = do
  tags <- parseTags <$> TIO.readFile "./test.html"
  return tags

extractAttrs :: [Tag Text] -> [Text]
extractAttrs = filter (/= "") . map (fromAttrib "data-e2e") . filter isTagOpen

main :: IO ()
main = do
  attrs <- extractAttrs <$> parseHtmlFile
  print attrs
