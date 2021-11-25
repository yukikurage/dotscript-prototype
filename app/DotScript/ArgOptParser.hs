module DotScript.ArgOptParser where

import           DotScript.Data.ArgOptions (ArgOptions (ArgOptions))
import           Options.Applicative       (Parser, ParserInfo, fullDesc, help,
                                            helper, info, long, metavar,
                                            progDesc, short, showDefault,
                                            strOption, value, (<**>))

argOptParser :: ParserInfo ArgOptions
argOptParser = info (parser <**> helper)
      ( fullDesc <> progDesc "Transpile a DotScript code" )
  where
  parser :: Parser ArgOptions
  parser = ArgOptions
    <$>
    strOption
      (  long "source"
      <> short  's'
      <> metavar "SOURCE"
      <> help "Source file"
      <> value "main.dts"
      <> showDefault
      )
    <*>
    strOption
      (  long "output"
      <> short 'o'
      <> metavar "OUTPUT"
      <> help "Output file"
      <> value "main.js"
      <> showDefault
      )

