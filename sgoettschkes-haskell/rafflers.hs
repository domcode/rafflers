import System.Environment
import System.IO
import System.Random 

main = do 
    args <- getArgs
    contents <- openFile (head args) ReadMode >>= hGetContents
    
    gen <- getStdGen
    print $ lines contents !! (fst $ randomR (0,length $ lines contents) gen)