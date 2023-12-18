module BinTree (printAllBinTree) where

data BinTree a = Branch (BinTree a) (BinTree a) | Leaf a
  deriving (Show)

reverseBinTree :: BinTree a -> BinTree a
reverseBinTree (Branch a b) = Branch (reverseBinTree b) (reverseBinTree a)
reverseBinTree (Leaf a) = Leaf a

depthBinTree :: BinTree a -> Int
depthBinTree (Branch a b) = 1 + max (depthBinTree a) (depthBinTree b)
depthBinTree (Leaf _) = 1

leavesBinTree :: BinTree a -> [a]
leavesBinTree (Branch a b) = leavesBinTree a ++ leavesBinTree b
leavesBinTree (Leaf a) = [a]

{-
                       r
                      / \
                     b  Some2
                    / \
                   b  Some1
                  /  \
                Some3 b
                     / \
                  Some4 b
                       / \
                   Some5  b
                         / \
                      Some6 Some7
 -}
sampleBinTree :: BinTree String
sampleBinTree =
  Branch
    ( Branch
        ( Branch
            (Leaf "Some3")
            ( Branch
                (Leaf "Some4")
                ( Branch
                    (Leaf "Some5")
                    ( Branch (Leaf "Some6") (Leaf "Some7")
                    )
                )
            )
        )
        (Leaf "Some1")
    )
    (Leaf "Some2")

printAllBinTree :: IO ()
printAllBinTree = print $ depthBinTree sampleBinTree
