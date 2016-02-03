import Data.Text (pack)
import Data.Text.IO (putStrLn)
import Prelude hiding (putStrLn)
import System.Environment (getArgs)
import System.IO (hGetContents, openFile, IOMode(ReadMode))
import System.Random (getStdGen, randomR)

main = do 
    contents <- hGetContents =<< flip openFile ReadMode . head =<< getArgs
    
    gen <- getStdGen
    let lc = lines contents in putStrLn $ pack $ lc !! (fst $ randomR (0,(length lc - 1)) gen)
