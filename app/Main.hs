module Main (main) where

import Lib (
    additionalFunc,
    ioAggregatior,
    -- returnSampleProgramm,

    printAllBinTree,
    reverseBool,
    sampleNum,
    someFunc,
    testLens,
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
        , testLens
        ]
