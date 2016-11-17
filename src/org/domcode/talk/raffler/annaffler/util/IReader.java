package org.domcode.talk.raffler.annaffler.util;

import org.domcode.talk.raffler.annaffler.business.RaffleParticipantDataKeeperClassThing;

public interface IReader {
	
	public boolean read() throws Exception;
	public void setFileLocation(String fileLocation);
	public RaffleParticipantDataKeeperClassThing wellNamedAndTotallyGenericDataTransferFunction();

}
