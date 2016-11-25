/*
 ___                                                                 _
/__/|__                                                            __//|
|__|/_/|__                                                       _/_|_||
|_|___|/_/|__                                                 __/_|___||
|___|____|/_/|__                                           __/_|____|_||
|_|___|_____|/_/|_________________________________________/_|_____|___||
|___|___|__|___|/__/___/___/___/___/___/___/___/___/___/_|_____|____|_||
|_|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___||
|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|_||
|_|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|___|/
*/
package org.domcode.talk.raffler.annaffler.logic;

import java.util.concurrent.ThreadLocalRandom;

import org.domcode.talk.raffler.annaffler.business.RaffleParticipantDataKeeperClassThing;
import org.domcode.talk.raffler.annaffler.util.IProcessor;

public class RaffleProcessor implements IProcessor {
	
	private RaffleParticipantDataKeeperClassThing data;
	private int rangeForKeys;
	
	@Override
	public String process() {
		
		int maxKeyValue = data.getStoreSize() + rangeForKeys;
		Integer winningId = Integer.valueOf(ThreadLocalRandom.current().nextInt(0, maxKeyValue + 1));
		while(data.checkIsKeyAvailable(winningId)) {
			winningId = Integer.valueOf(ThreadLocalRandom.current().nextInt(0, maxKeyValue + 1));
		}
		return data.getParticipantName(winningId);
	}
	
	public void setData(RaffleParticipantDataKeeperClassThing data) {
		this.data = data;
	}

	public void setRangeForKeys(int rangeForKeys) {
		this.rangeForKeys = rangeForKeys;
	}
}
