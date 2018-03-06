/* |\---/|
   | ,_, |
    \_`_/-..----.
 ___/ `   ' ,""+ \  sk
(__...'   __\    |`.___.';
  (_,...'(_,.`__)/'.....+
  */
package org.domcode.talk.raffler.annaffler.function;

import org.domcode.talk.raffler.annaffler.logic.RaffleProcessor;
import org.domcode.talk.raffler.annaffler.logic.RaffleReader;
import org.domcode.talk.raffler.annaffler.logic.RaffleWriter;
import org.domcode.talk.raffler.annaffler.util.IProcessor;
import org.domcode.talk.raffler.annaffler.util.IReader;
import org.domcode.talk.raffler.annaffler.util.ITask;
import org.domcode.talk.raffler.annaffler.util.IWriter;

public class TaskPerformRaffle implements ITask {
	
	String fileLocation;
	
	public TaskPerformRaffle (String fileLocation) {
		this.fileLocation = fileLocation;		
	}

	@Override
	public void execute() {
		IReader reader = createReader();
		RaffleProcessor processor = (RaffleProcessor) createProcessor();
		IWriter writer = createWriter();
		
		reader.setFileLocation(fileLocation);
		try {
			reader.read();
		} catch (Exception e) {
			System.err.println("I can't read you.");
			e.printStackTrace();
			System.exit(19);
		}
		
		processor.setData(reader.wellNamedAndTotallyGenericDataTransferFunction());
		processor.setRangeForKeys(((RaffleReader)reader).getRangeForKeys());
		
		String winnerName = processor.process();
		
		writer.write(winnerName);
	}
	
	private IReader createReader() {
		return new RaffleReader();
	}
	
	private IProcessor createProcessor() {
		return new RaffleProcessor();
	}
	
	private IWriter createWriter() {
		return new RaffleWriter();
	}

}
