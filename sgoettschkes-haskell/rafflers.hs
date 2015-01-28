import Control.Monad
import System.Environment
import System.IO
import System.Random 

main = do 
    arg : _ <- getArgs
    contents <- openFile arg ReadMode >>= hGetContents
    
    gen <- getStdGen
    print $ lines contents !! (fst $ randomR (0,length $ lines contents) gen)