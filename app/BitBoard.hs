module BitBoard where

import Data.Vector hiding (elem)
import Data.Char as C

data PieceType = Rook | Pawn | King | Queen | Bishop | Knight deriving (Eq)
data Color = White | Black deriving (Eq)
data PieceStructure = PieceStruct !PieceType !Color

instance Show PieceType where
  show Rook ="r" 
  show Pawn = "p" 
  show King = "k" 
  show Queen = "q"
  show Bishop = "b" 
  show Knight = "n" 

instance Show PieceStructure where
  show (PieceStruct cl White) =  C.toUpper <$> show cl  
  show (PieceStruct cl Black) = show cl 

instance Read PieceStructure where
  readsPrec _ [a] = if C.toLower a `elem` "rpkqbn" 
                       then let color = if C.isUpper a then White else Black
                                t = case C.toLower a of 
                                      'p' -> Pawn
                                      'r' -> Rook
                                      'k' -> King
                                      'q' -> Queen
                                      'b' -> Bishop
                                      'n' -> Knight
                                        
                            in [(PieceStruct t color, " ")]
                    else []

data ChessBoar

