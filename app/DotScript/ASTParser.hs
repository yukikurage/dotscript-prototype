module DotScript.ASTParser where

import           Data.Functor
import           Data.Functor.Identity
import           Data.Text
import           DotScript.Data.AST
import           Text.Parsec
import qualified Text.Parsec.Token     as T

astParser :: Parsec Text u VariableDefs
astParser = endBy variableDef (char ';')

variableDef = VariableDef
  <$> (spacesAllowEol *> variableName <* spacesAllowEol)
  <*> (char '=' *> spacesAllowEol *> expression <* spacesAllowEol)

variableName =  VariableName <$> ((:) <$> lower <*> many alphaNum)

expression = chainl1 factor $ (char '.' <* spacesAllowEol) $> ExpressionDot

factor =
  (   ExpressionVariable <$> variableName
  <|> ExpressionLiteral <$> literal
  <|> ExpressionRecord <$> recordExpr
  <|> (char '(' *> expression <* char ')')
  ) <* spacesAllowEol

literal =
      LiteralChar <$> charLiteral
  <|> LiteralRecord <$> (char '{' *> recordLit <* char '}')
  <|> LiteralRaw <$> ((:) <$> upper <*> many alphaNum)

recordLit = sepBy labelDefLit (char ',')

labelDefLit = LabelDef
  <$> (spacesAllowEol *> literal <* spacesAllowEol)
  <*> (char ':' *> spacesAllowEol *> literal <* spacesAllowEol)

recordExpr = sepBy labelDefExpr (char ',')

labelDefExpr = LabelDef
  <$> (spacesAllowEol *> literal <* spacesAllowEol)
  <*> (char ':' *> spacesAllowEol *> expression <* spacesAllowEol)

spacesAllowEol = spaces <|> optional endOfLine

lexer = T.makeTokenParser dotScriptDef

charLiteral = T.charLiteral lexer
stringLiteral = T.stringLiteral lexer

dotScriptDef = T.LanguageDef {
    T.commentStart = "/*"
  , T.commentEnd = "*/"
  , T.commentLine = "//"
  , T.nestedComments = True
  , T.identStart = letter <|> char '_'
  , T.identLetter = alphaNum <|> oneOf "_'"
  , T.opStart = T.opLetter dotScriptDef
  , T.opLetter = oneOf ":!#$%&*+./<=>?@\\^|-~"
  , T.reservedOpNames= ["let"]
  , T.reservedNames  = [":", "="]
  , T.caseSensitive  = True
  }
