{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE FunctionalDependencies #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Lib (
    module Nat,
    module Program,
    module BinTree,
    module Stream,
    module Calculator,
    module KleisliTest,
    module LensTest,
    module Template,
    someFunc,
    additionalFunc,
    ioAggregatior,
    reverseBool,
    testLens,
)
where

import BinTree
import Calculator
import KleisliTest
import LensTest
import Nat
import Program
import Stream
import Template (generateTupleClass, someSplice)

$someSplice

$(generateTupleClass 10)

someFunc :: IO ()
someFunc = putStrLn "someFunc"

additionalFunc :: IO ()
additionalFunc = putStrLn "additionalFunc"

ioAggregatior :: [IO ()] -> IO ()
ioAggregatior [] = putStrLn "End"
ioAggregatior xs =
    putStrLn "Begin"
        >> foldr (>>) (putStrLn "End") xs

reverseBool :: [Bool] -> [Bool]
reverseBool [] = []
reverseBool (x : xs) = reverseBool xs ++ [x]

class ArrayElem e where
    data Array e
    index :: Array e -> Int -> e

newtype Point2 a = Point2
    { x :: (Ord a) => a
    }

data Point1 a = Point1
    { z :: (Ord a, Show a) => a
    , y :: a
    }
