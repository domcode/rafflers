/*           _,--""--,_
        _,,-"          \
    ,-e"                ;
   (*             \     |
    \o\     __,-"  )    |
     `,_   (((__,-"     L___,,--,,__
        ) ,---\  /\    / -- '' -'-' )
      _/ /     )_||   /---,,___  __/
     """"     """"|_ /         ""
                  """"
*/
package org.domcode.talk.raffler.annaffler.function;

import org.domcode.talk.raffler.annaffler.framework.Job;

public class JobPerformRaffle extends Job {

	private String fileLocation;
	
	@Override
	public void fillTaskList() {
		allTasks.add(new TaskPerformRaffle(fileLocation));
	}
	
	public void setFileLocation(String fileLocation) {
		this.fileLocation = fileLocation;
	}
	 
	 
}
