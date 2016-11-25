/*                                 __
                               _.-~  )
                    _..--~~~~,'   ,-/     _
                 .-'. . . .'   ,-','    ,' )
               ,'. . . _   ,--~,-'__..-'  ,'
             ,'. . .  (@)' ---~~~~      ,'
            /. . . . '~~             ,-'
           /. . . . .             ,-'
          ; . . . .  - .        ,'
         : . . . .       _     /
        . . . . .          `-.:
       . . . ./  - .          )
      .  . . |  _____..---.._/ ____ Seal _
~---~~~~----~~~~             ~~
*/
package org.domcode.talk.raffler.annaffler.application;

import java.io.IOException;

import org.domcode.talk.raffler.annaffler.framework.Job;
import org.domcode.talk.raffler.annaffler.function.JobPerformRaffle;

public class Annaffler {
	
	 public static final void main(String[] args) throws IOException {
		 
		 if (args.length != 1) {
	        System.err.println("This is not the amount of arguments I'm looking for.");
	        System.exit(4);
	    }
		 
		 Job job = new JobPerformRaffle();
		 
		 ((JobPerformRaffle) job).setFileLocation(args[0]);
		 job.fillTaskList();
		 job.executeAllTasks();
		 
		 System.exit(0);
	 }
}
