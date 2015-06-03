package nl.dukesolution.raffle.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import com.google.common.base.Objects;

/**
 * Created by bart on 27/05/15.
 */
@Entity
public class RafflePlayer {

    @Id
    @GeneratedValue
    private Long id;

    private String name;

    private Boolean won;

    public RafflePlayer() {

    }

    public RafflePlayer(String name) {
        this.name = name;
        won = false;
    }

    public String getName() {
        return name;
    }

    public Boolean getWon() {
        return won;
    }

    public void setWon(Boolean won) {
        this.won = won;
    }

    public Long getId() {
        return id;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;
        RafflePlayer that = (RafflePlayer) o;
        return Objects.equal(name, that.name);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(name);
    }
}
