package nl.dukesolution.raffle;

import nl.dukesolution.raffle.domain.RafflePlayer;
import nl.dukesolution.raffle.domain.RafflePlayerRepo;

import java.io.InputStream;
import java.util.HashSet;
import java.util.Set;

import com.google.common.base.Splitter;
import com.google.common.io.Closeables;

import org.apache.tika.metadata.Metadata;
import org.apache.tika.parser.AutoDetectParser;
import org.apache.tika.sax.BodyContentHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FileUploadController {

    @Autowired
    private RafflePlayerRepo rafflePlayerRepo;

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    public String handleFileUpload(
            @RequestParam("file") MultipartFile file) {
        if (!file.isEmpty()) {
            InputStream inputStream = null;
            try {

                inputStream = file.getInputStream();

                BodyContentHandler handler = new BodyContentHandler();

                AutoDetectParser parser = new AutoDetectParser();
                Metadata metadata = new Metadata();

                parser.parse(inputStream, handler, metadata);

                Iterable<String> names = Splitter.onPattern("\r?\n")
                        .trimResults()
                        .omitEmptyStrings().split(handler.toString());

                Set<RafflePlayer> players = new HashSet<>();
                for (String name : names) {
                    players.add(new RafflePlayer(name));
                }
                rafflePlayerRepo.deleteAll();
                rafflePlayerRepo.save(players);

                return "redirect:/";
            } catch (Exception e) {
                return "You failed to upload " + e.getMessage();
            } finally {
                Closeables.closeQuietly(inputStream);
            }
        } else {
            return "You failed to upload because the file was empty.";
        }
    }

}
