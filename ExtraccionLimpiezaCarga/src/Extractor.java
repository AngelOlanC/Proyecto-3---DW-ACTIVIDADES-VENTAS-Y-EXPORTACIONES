import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class Extractor{
    private final BufferedReader bf;
    public Extractor(String src) throws FileNotFoundException {
        bf = new BufferedReader(new FileReader(src));
    }

    public boolean hasNextTuple() throws IOException {
        return bf.ready();
    }
    
    public String[] nextTuple() throws IOException {
        String line = bf.readLine();
        String[] tuple = line.split(",");
        return tuple;
    }
}