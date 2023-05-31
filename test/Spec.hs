module Main where

import Lib (
    additionalFunc,
    ioAggregatior,
    printAllBinTree,
    reverseBool,
    sampleNum,
    someFunc,
    testLens,
 )
import Test.Tasty
import Test.Tasty.HUnit

main :: IO ()
main = putStrLn " [BEGIN]"

simpleSampleNum :: TestTree
simpleSampleNum = testCase "60" sampleNum

simpleSomeFunc :: TestTree
simpleSomeFunc = testCase "someFunc" someFunc

simpleAdditionalFunc :: TestTree
simpleAdditionalFunc = testCase "additionalFunc" additionalFunc

simpleGroup :: TestTree
simpleGroup = testGroup "simpleTests" [simpleSampleNum, simpleSomeFunc, simpleAdditionalFunc]
