{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module PackageInfo_HeyChess (
    name,
    version,
    synopsis,
    copyright,
    homepage,
  ) where

import Data.Version (Version(..))
import Prelude

name :: String
name = "HeyChess"
version :: Version
version = Version [0,1,0,0] []

synopsis :: String
synopsis = "A chess engine implementation in haskell."
copyright :: String
copyright = ""
homepage :: String
homepage = "https://gitlab.com/HikariNee/HeyChess"
