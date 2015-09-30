import System.Environment
import System.IO
import System.Random 

main = do 
    contents <- hGetContents =<< flip openFile ReadMode . head =<< getArgs
    
    gen <- getStdGen
    let lc = lines contents in print $ lc !! (fst $ randomR (0,(length lc - 1)) gen)
