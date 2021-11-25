module DotScript.Data.AST where

type AST = VariableDefs

type VariableDefs = [VariableDef]

data VariableDef = VariableDef VariableName Expression deriving (Eq, Show)

newtype VariableName = VariableName String deriving (Eq, Show)

data Expression =
    ExpressionDot Expression Expression
  | ExpressionLiteral Literal
  | ExpressionVariable VariableName
  | ExpressionRecord (Record Expression) deriving (Eq, Show)

data Literal =
    LiteralString String
  | LiteralInt String
  | LiteralNumber String
  | LiteralRaw String
  | LiteralChar Char
  | LiteralRecord (Record Literal)
  deriving (Eq, Show)

-- | aにはレコード内のValue(右側の値)の形式を代入
type Record a = [LabelDef a]

data LabelDef a = LabelDef Literal a deriving (Eq, Show)
