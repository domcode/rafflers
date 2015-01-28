import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;

/**
 * @author n0xie
 */
public class Raffler {
    
    /**
     * Read a file from argument, randomly return 1 line
     * 
     * @param args
     * @throws IOException 
     */
    public static final void main(String[] args) throws IOException {
        
        // check that we only have 1 argument
        if (args.length != 1) {
            System.err.println("Only 1 Argument allowed");
            System.exit(1);
        }
        
        // check the file is actual there
        File file = new File(args[0]);
        if (false == file.isFile()) {
            System.err.println("I can't do that Dave");
            System.exit(1);            
        }
        
        // read file line by line via buffer to an array
        BufferedReader buffer = new BufferedReader(new FileReader(file.getAbsolutePath()));
        String line;

        List<String> attandeeList = new ArrayList<>();
        while((line = buffer.readLine()) != null){
            attandeeList.add(line);
        }

        // randomize the array
        Collections.shuffle(attandeeList, new Random(System.nanoTime()));

        System.out.println(attandeeList.get(0));
    }
}