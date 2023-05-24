{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module LensTest (
    Lens,
    testLens,
    Club,
    Athlete,
)
where

import Data.Text

data Lens a b = Lens
    { get :: a -> b
    , set :: b -> a -> a
    }

newtype Club = Club {clubName :: String}

newtype Athlete = Athlete {athleteName :: Text}

class HasName a b where
    name :: Lens a b

instance HasName Athlete Text where
    name = athleteNameLens

instance HasName Club String where
    name = clubNameLens

athleteNameLens :: Lens Athlete Text
athleteNameLens =
    Lens
        { get = athleteName
        , set = \newName athlete -> athlete{athleteName = newName}
        }

clubNameLens :: Lens Club String
clubNameLens =
    Lens
        { get = clubName
        , set = \newName club -> club{clubName = newName}
        }

testLens :: IO ()
testLens = putStrLn $ unpack (get name athleteNew) ++ get name clubNew
  where
    athleteNew = set name (pack "Super Boy") Athlete{athleteName = pack ""}
    clubNew = set name "Super Club" Club{clubName = ""}
