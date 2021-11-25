module Main where

import           DotScript.ASTParser
import           DotScript.ArgOptParser    (argOptParser)
import           DotScript.Data.ArgOptions (ArgOptions (sourceFile))
import           Options.Applicative       (execParser)
import           Text.Parsec.Text

main :: IO ()
main = do
  argOpts <- execParser argOptParser
  ast <- parseFromFile astParser $ sourceFile argOpts
  print ast

