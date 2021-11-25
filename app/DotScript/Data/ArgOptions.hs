module DotScript.Data.ArgOptions where

data ArgOptions = ArgOptions {
  sourceFile :: String,
  outputFile :: String
  } deriving (Eq, Show)
