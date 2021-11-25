module Main where

import           DotScript.ArgOptParser
import           DotScript.Data.ArgOptions
import           Options.Applicative

main :: IO ()
main = do
  argOpts <- execParser argOptParser
  print argOpts
