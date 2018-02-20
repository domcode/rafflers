/*  (
  `-`-.
  '( @ >
   _) (
  /    )
 /_,'  / 
   \  / 
===m""m===
*/
package org.domcode.talk.raffler.annaffler.framework;

import java.util.ArrayList;
import java.util.List;

import org.domcode.talk.raffler.annaffler.util.ITask;

public abstract class Job {
	
	protected List<ITask> allTasks;
	
	public Job() {
		allTasks = new ArrayList<>();
	}
	
	public abstract void fillTaskList();
	
	 public void executeAllTasks() {
		 for (ITask task : allTasks) {
			 task.execute();
		 }
	 }
}
