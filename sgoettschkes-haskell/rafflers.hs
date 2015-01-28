import System.Environment
import System.IO
import System.Random 

main = do 
    args <- getArgs
    handle <- openFile (head args) ReadMode
    contents <- hGetContents handle
    
    gen <- getStdGen
    print $ lines contents !! (fst $ randomR (0,length $ lines contents) gen)