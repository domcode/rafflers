package nl.dukesolution.raffle.domain;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by bart on 27/05/15.
 */
public interface RafflePlayerRepo extends CrudRepository<RafflePlayer, Long> {

    @Modifying
    @Query("update RafflePlayer p set p.won = false")
    void resetGame();

}
