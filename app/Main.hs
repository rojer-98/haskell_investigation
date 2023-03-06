module Main (main) where

import Lib (
    additionalFunc,
    ioAggregatior,
    -- returnSampleProgramm,

    iterateNum,
    printAllBinTree,
    reverseBool,
    sampleNum,
    someFunc,
 )

import Nat

main :: IO ()
main =
    ioAggregatior
        [ sampleNum
        , -- , returnSampleProgramm
          someFunc
        , additionalFunc
        , print $ show $ reverseBool [True, False, False, False]
        , printAllBinTree
        , print $ take 5 $ iterateNum (2-) 10
        ]
