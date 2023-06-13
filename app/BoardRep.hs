module BoardRep where

import Data.Maybe (fromJust, isJust)
import qualified Data.Vector as V
import Data.List (lookup,intersperse, intercalate)
import Data.Char as C
import Data.Bool (bool)
import Data.Tuple (swap)

data PieceType = Rook | Queen | Knight | Bishop | King | Pawn deriving (Eq)
data Colour = White  | Black deriving (Show, Eq)
data Piece = Piece !Colour !PieceType

assoc :: [(PieceType, Char)]
assoc = [ (King,   'k')
        , (Queen,  'q')
        , (Knight, 'n')
        , (Bishop, 'b')
        , (Pawn,   'p')
        , (Rook,   'r')
        ]

instance Show PieceType where
  show key = [fromJust (lookup key assoc)] 

instance Show Piece where 
  show (Piece color t) = case color of 
    White -> map C.toUpper (show t)
    Black -> show t
    
readPiece :: Char -> Maybe Piece 
readPiece char = fmap (Piece colour) piece
  where
  colour = bool Black White (C.isUpper char)
  piece = lookup char (map swap assoc)


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

type Position = (Int, Int)

toIndex :: Position -> Int
toIndex (f,r) = 8 * r + f

fromIndex ::Int -> Position 
fromIndex n = (n `mod` 8, n `quot` 8)

fetchPiece :: Board -> Position -> Maybe Piece
fetchPiece n p 
  | r < 0 || r > 63 = Nothing
  | otherwise = vec n V.! r
  where r = toIndex p 

removePiece :: Board -> Position -> Board
removePiece cb p 
  | i < 0 || i > 63 = cb 
  | otherwise = Board ( vec cb V.// [(i, Nothing)] ) $ nextMove cb
 where
   i = toIndex p


