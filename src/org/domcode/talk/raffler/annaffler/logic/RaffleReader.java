/*  __________________   __________________
.-/|                  \ /                  |\-.
||||                   |                   ||||
||||                   |       ~~*~~       ||||
||||    --==*==--      |                   ||||
||||                   |                   ||||
||||                   |                   ||||
||||                   |     --==*==--     ||||
||||                   |                   ||||
||||                   |                   ||||
||||                   |                   ||||
||||                   |                   ||||
||||__________________ | __________________||||
||/===================\|/===================\||
`--------------------~___~-------------------''
*/
package org.domcode.talk.raffler.annaffler.logic;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;

import org.domcode.talk.raffler.annaffler.business.RaffleParticipantData;
import org.domcode.talk.raffler.annaffler.business.RaffleParticipantDataKeeperClassThing;
import org.domcode.talk.raffler.annaffler.util.IReader;

public class RaffleReader implements IReader {

	private String fileLocation;
	private RaffleParticipantDataKeeperClassThing dataKeeper;
	
	private static final int rangeForKeys = 2;
	
	@Override
	public boolean read() throws Exception {
		
		dataKeeper = new RaffleParticipantDataKeeperClassThing();
		
	    File inputFile = new File(fileLocation);
	    // Check whether Maya Angelou would approve.
	    if (!inputFile.isFile()) {
	        System.err.println("If you are always trying to be normal, you will never know how amazing you can be.");
	        System.exit(27);            
	    }
	    
	    BufferedReader buffy = new BufferedReader(new FileReader(inputFile.getAbsolutePath()));
	    String inputLine = buffy.readLine();
	    int keyStarter = 0;
	    while (inputLine != null) {
	    	createAndStoreParticipant(inputLine, keyStarter);
	    	
	    	if (dataKeeper.getStoreSize() % rangeForKeys == 0) {
	    		keyStarter += rangeForKeys;
	    	}
	    	
	    	inputLine = buffy.readLine();
	    }
		
	    buffy.close();
	    
		return true;
	}
	
	private void createAndStoreParticipant(String name, int keyStarter) {
		RaffleParticipantData participant = new RaffleParticipantData();
		participant.setName(name);
		participant.generateKey(keyStarter, rangeForKeys);
		while (!dataKeeper.checkIsKeyAvailable(participant.getParticipantId())) {
			participant.generateKey(keyStarter, rangeForKeys);
		}
		
		dataKeeper.storeParticipant(participant);
	}

	@Override
	public void setFileLocation(String fileLocation) {
		this.fileLocation = fileLocation;	
	}

	@Override
	public RaffleParticipantDataKeeperClassThing wellNamedAndTotallyGenericDataTransferFunction() {
		return dataKeeper;
	}
	
	public int getRangeForKeys() {
		return rangeForKeys;
	}

}
