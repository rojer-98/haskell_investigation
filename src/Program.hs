module Program (
    Program,
    ProgramType,
    Name,
    DataTypes,
    Arg,
    Return,
    Module,
    returnSampleProgramm,
) where

data Program = Programm ProgramType [Module]
data ProgramType = Lib | Exe

data Module = Modul Name [DataTypes] [Functions]
type Name = String
data DataTypes = Enum Name | Complex Name [DataTypes]

data Functions = Function Name [Arg] Return
type Arg = DataTypes
type Return = String

class Show a => CheckProgram a where
    getInstance :: a -> IO ()
    parseProgram :: a -> IO ()

instance Show ProgramType where
    show Lib = "Lib"
    show Exe = "Exe"

instance Show Module where
    show (Modul n (dt : dts) (f : fs)) =
        show "Module: "
            ++ show n
            ++ show '\n'
            ++ show dt
            ++ show dts
            ++ show f
            ++ show fs
            ++ "]"
    show (Modul _ [] []) = "|"
    show (Modul _ dts []) = show dts
    show (Modul _ [] fs) = show fs

instance Show DataTypes where
    show (Enum n) = "(" ++ show n ++ ")" ++ show ','
    show (Complex n (dt : dts)) =
        show n
            ++ "["
            ++ show dt
            ++ "{"
            ++ show dts
            ++ "}"
            ++ "]"
            ++ show ','
    show (Complex _ []) = "{" ++ "}" ++ show ','

instance Show Functions where
    show (Function n (a : as) r) =
        show n
            ++ "::"
            ++ show a
            ++ "->"
            ++ show as
            ++ show r
    show (Function _ [] _) = "|"

instance Show Program where
    show (Programm pt m) =
        "Program: "
            ++ show pt
            ++ show '\n'
            ++ show m

instance CheckProgram Program where
    getInstance (Programm pt _) = print $ show pt
    parseProgram p = print $ show p

sampleProgramm :: Program
sampleProgramm =
    Programm
        Exe
        [ Modul
            "Some"
            [Enum "Some", Enum "Some1", Complex "Some2" [Enum "Some3"]]
            [ Function
                "Some4"
                [Enum "Some5", Enum "Some6"]
                "Some7"
            , Function
                "Some8"
                [Enum "Some9", Enum "Some10"]
                "Some11"
            ]
        ]

moreFunctions :: [a -> IO ()] -> a -> IO ()
moreFunctions [] _ = putStrLn ""
moreFunctions (x : xs) a = x a >> moreFunctions xs a

returnSampleProgramm :: IO ()
returnSampleProgramm = moreFunctions [getInstance, parseProgram] sampleProgramm
