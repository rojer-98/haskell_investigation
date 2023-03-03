module Stream (
    StreamN,
    makeNats,
    constNats,
) where

import Nat

data StreamN a = a :& StreamN a

makeNats :: Nat -> StreamN Nat
makeNats n = n :& makeNats (Succ n)

constNats :: Nat -> StreamN Nat
constNats n = n :& constNats n

headNats :: StreamN Nat -> Nat
headNats (n :& _) = n

tailNats :: StreamN Nat -> StreamN Nat
tailNats (_ :& ns) = ns

natIndex :: StreamN Nat -> Int -> Nat
natIndex (n :& sn) i
    | i > 0 = natIndex sn i - 1
    | i == 0 = n
    | otherwise = error "unsupported"

natIterate :: (Nat -> Nat) -> Nat -> StreamN Nat
natIterate f n = n :& natIterate f (f n)
