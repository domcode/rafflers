/*
      _.---._    /\\
    ./'       "--`\//
  ./              o \          .-----. 
 /./\  )______   \__ \        ( help! )
./  / /\ \   | \ \  \ \       /`-----'
   / /  \ \  | |\ \  \7--- ooo ooo ooo ooo ooo ooo
 */
package org.domcode.talk.raffler.annaffler.business;

import java.util.concurrent.ThreadLocalRandom;

import org.domcode.talk.raffler.annaffler.util.IParticipantData;

public class RaffleParticipantData implements IParticipantData {

	private Integer participantId;
	private String name;
	
	@Override
	public Integer getParticipantId() {
		return participantId;
	}
	
	@Override
	public void setParticipantId(Integer participantId) {
		this.participantId = participantId;}
	
	@Override
	public String getName() {
		return name;
	}
	
	@Override
	public void setName(String name) {
		this.name = name;
	}
	
	/**
	 * Set the participantId to a random number between @param offset and @param range
	 */
	public void generateKey(int offset, int range) {
		this.participantId = Integer.valueOf(ThreadLocalRandom.current().nextInt(offset, offset + range));
	}
	
	/** 
	 * @see java.lang.Object#hashCode()
	 */
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((participantId == null) ? 0 : participantId.hashCode());
		return result;
	}

	/** 
	 * @see java.lang.Object#equals(java.lang.Object)
	 */
	@Override
	public boolean equals(Object obj) {
		if (this == obj) {
			return true;
		}
		
		if (obj == null) {
			return false;
		}
		
		if (getClass() != obj.getClass()) {
			return false;
		}
		
		RaffleParticipantData other = (RaffleParticipantData) obj;
		if (participantId == null) {
			if (other.participantId != null) {
				return false;
			}
		} else if (!participantId.equals(other.participantId)) {
			return false;
		}
		return true;
	}
	
	

}
