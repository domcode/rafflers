import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.nio.file.Files;
import java.nio.file.Paths;

public class Raffler {
    public static final void main(String[] args) throws IOException {
        List<String> attendees = Files.readAllLines(Paths.get(args[0]));
        System.out.println(attendees.get((new Random()).nextInt(attendees.size())));
    }
}
