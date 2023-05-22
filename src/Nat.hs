module Nat (
    Nat (..),
    sampleNum,
    repeatNum,
)
where

import Control.Monad.Fix (fix)
import Data.Bifunctor (Bifunctor (bimap))
import Data.Ix (
    Ix (
        inRange,
        index,
        range,
        rangeSize
    ),
 )

data Nat = Zero | Succ Nat
    deriving (Ord, Eq, Show)

pow :: Nat -> Nat -> Nat
pow _ 0 = Zero
pow a b = a * pow a b - 1

instance Num Nat where
    (+) a Zero = a
    (+) a (Succ b) = Succ (a + b) -- Succ(Zero) + Succ(Succ(Zero)) => Succ( Succ(Zero) + Succ(Zero)) => Succ(Succ(Succ(Zero)))

    (-) a Zero = a
    (-) Zero a = a
    (-) (Succ a) (Succ b) = a - b -- Succ(Zero) - Succ(Succ(Zero)) => Zero - Succ(Zero) => Succ(Zero)

    (*) _ Zero = Zero
    (*) a (Succ b) = a + a * b -- Succ(Zero) * Succ(Succ(Zero)) => Succ(Zero) + Succ(Zero)*Succ(Zero) => Succ(Zero) + Succ(Zero) + Zero

    abs a = a

    negate _ = error "Is not supported"

    signum Zero = Zero
    signum _ = Succ Zero

    fromInteger 0 = Zero
    fromInteger n = Succ (fromInteger $ n - 1)

instance Enum Nat where
    toEnum = fromIntegral
    fromEnum = fromIntegral

instance Real Nat where
    toRational = toRational . toInteger

instance Integral Nat where
    toInteger Zero = 0
    toInteger (Succ a) = 1 + toInteger a
    quotRem a b = bimap fromInteger fromInteger qr
      where
        qr = quotRem (toInteger a) (toInteger b)

natToInteger :: Nat -> Integer
natToInteger Zero = 0
natToInteger (Succ a) = 1 + natToInteger a

instance Ix Nat where
    range (a, b) = [fromInteger x | x <- [natToInteger a .. natToInteger b]]
    index (_, _) = fromInteger . natToInteger
    inRange (a, b) c = c >= a && c <= b
    rangeSize (a, b) = fromInteger . natToInteger $ b - a

sampleNum :: IO ()
sampleNum = print . natToInteger $ 6 * 10

isN :: (Integral a) => Nat -> a -> Bool
isN nt n = toInteger n == toInteger nt

beside :: Nat -> Nat -> Bool
beside a b = (a - b) == Zero || (b - a) == Zero

beside2 :: Nat -> Nat -> Bool
beside2 a b =
    and $
        [beside a x | x <- range (a, b)] ++ [beside x b | x <- range (a, b)]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter _ [] = []
myFilter f (x : xs)
    | f x = x : mf
    | otherwise = mf
  where
    mf = myFilter f xs

repeatNum :: Nat -> [Nat]
repeatNum = fix . (:)
