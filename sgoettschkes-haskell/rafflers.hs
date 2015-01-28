import System.Environment
import System.IO
import System.Random 

main = do 
    contents <- hGetContents =<< flip openFile ReadMode . head =<< getArgs
    
    gen <- getStdGen
    print $ lines contents !! (fst $ randomR (0,length $ lines contents) gen)