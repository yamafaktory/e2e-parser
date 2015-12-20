{-# LANGUAGE OverloadedStrings #-}

module Utils
    ( countStream
    , extractAttrs
    , fileList
    , filePathToText
    , fileStream
    , parseHtmlFile
    , report
    , streamToList
    ) where

import qualified Control.Foldl     as Fold
import qualified Data.Text.IO      as TIO
import           Text.HTML.TagSoup
import           Turtle

countStream :: MonadIO io => Shell a -> io Int
countStream stream = fold stream Fold.length

extractAttrs :: [Tag Text] -> [Text]
extractAttrs = filter (/= "") . map (fromAttrib "data-e2e") . filter isTagOpen

fileList :: Turtle.FilePath -> IO [Turtle.FilePath]
fileList path = streamToList (fileStream path)

filePathToText :: Functor f => f Turtle.FilePath -> f Text
filePathToText file = format fp <$> file

fileStream :: Turtle.FilePath -> Shell Turtle.FilePath
fileStream path = find (has ".html") path

parseHtmlFile :: Prelude.FilePath -> IO [Tag Text]
parseHtmlFile file = parseTags <$> TIO.readFile file

report :: Prelude.FilePath -> IO [Text]
report file = extractAttrs <$> (parseHtmlFile file)

streamToList :: Shell a -> IO [a]
streamToList stream = fold stream Fold.list
