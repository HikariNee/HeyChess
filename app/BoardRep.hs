module BoardRep where

import qualified Data.Vector as V
import Data.List (intersperse, intercalate)
import Data.Char as C
import GHC.IO.Handle (HandlePosn(HandlePosn))

data PieceType = Rook | Queen | Knight | Bishop | King | Pawn deriving (Eq)
data Colour = White  | Black deriving (Show, Eq)
data Piece = Piece !Colour !PieceType

instance Show PieceType where
  show King = "k"
  show Queen = "q"
  show Knight = "n"
  show Bishop = "b"
  show Pawn = "p"
  show Rook = "r"

instance Show Piece where
  show (Piece White t) = map C.toUpper $ show t 
  show (Piece Black t) = show t 

instance Read Piece where
  readsPrec _ [a] = if C.toLower a `elem` "kqnbpr" 
                       then let colour = if isUpper a then White else Black
                                piece = case toLower a of
                                          'p' -> Pawn
                                          'r' -> Rook
                                          'b' -> Bishop
                                          'n' -> Knight
                                          'k' -> King
                                          'q' -> Queen
                                            
                            in [(Piece colour piece, " ")]
                          else []

data Board = Board { vec :: V.Vector (Maybe Piece), nextMove :: !Colour  }

emptyBoard :: Colour -> Board
emptyBoard c = Board { vec = V.replicate 64 Nothing, nextMove = c }

-- the usual chess formation
initBoard :: Board
initBoard = Board { vec = V.fromList $ concat $ [whiteRear, whiteFront] ++ replicate 4 emptyRows ++ [blackRear,blackFront], nextMove = White} where
  rear = [ Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook ] 
  whiteRear = map (Just . Piece  White) rear 
  whiteFront = replicate 8 $ Just $ Piece White Pawn
  blackRear = map (Just . Piece Black) rear
  blackFront = replicate 8 $ Just $ Piece Black Pawn
  emptyRows = replicate 8 Nothing


