module Lib (
    module Nat,
    module Program,
    module BinTree,
    module Stream,
    module Calculator,
    module KleisliTest,
    module LensTest,
    someFunc,
    additionalFunc,
    ioAggregatior,
    reverseBool,
)
where

import LensTest
import BinTree
import Calculator
import KleisliTest
import Nat
import Program
import Stream

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
