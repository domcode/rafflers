 /*    _v   ,,
      /`|   &&.
      `-\`-&&&&&.
         \&&&&&&&\
          &&#""&& \
         / |   |\  x
         \ |  / /
*/
package org.domcode.talk.raffler.annaffler.business;

import java.util.HashMap;
import java.util.Map;

public class RaffleParticipantDataKeeperClassThing {
	
	private Map<Integer, RaffleParticipantData> participantKeeperMapThing;
	
	public RaffleParticipantDataKeeperClassThing() {
		participantKeeperMapThing = new HashMap<>();
	}
	
	public void storeParticipant(RaffleParticipantData participant) {
		participantKeeperMapThing.put(participant.getParticipantId(), participant);
	}
	
	public String getParticipantName(Integer participantId) {
		return participantKeeperMapThing.get(participantId).getName();
	}
	
	public int getStoreSize() {
		return participantKeeperMapThing.size();
	}
	
	public boolean checkIsKeyAvailable(Integer key) {
		return !participantKeeperMapThing.containsKey(key);
	}
}
