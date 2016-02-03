package nl.dukesolution.raffle;

import nl.dukesolution.raffle.domain.RafflePlayer;

import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

/**
 * Created by bart on 29/05/15.
 */
@RepositoryRestResource(path = "/rafflePlayers")
public interface RaffleRestService extends PagingAndSortingRepository<RafflePlayer, Long> {
}
