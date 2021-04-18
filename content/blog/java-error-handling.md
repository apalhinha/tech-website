---
title: "Pattern for Error Handling in Java"
date: 2021-04-17T16:03:21+01:00
draft: false
tags: ["Java"]
---

# Principles

* At high-level, errors are innocuous. Worst case scenario nothing happened and the user can try again.
* The lowest level will show the stack-dump, not others.
* TODO: After an error, the upper levels should display their context information in a nicer format. Includes re-create the stack-dump

<!--more-->

# Top level, where errors are innocuous
At top level an error keeps the user state as it was before.
The user will decide whether to retry, or quit.

```java
public void toplevel() {
	// Acts as the top level for the error handler, no more throws from here but log is updated
	try {
		do_something();
	} catch (Exception e) {
		MyLog.exceptionTop(e, null);
	}
	return ;
}
```

# Inner level, log stack and context
Every other function will throw an error to the upper level.
The message log function will know whether the stack-trace should be listed or not.

``` java
public void do_something() throws Exception {
	try {
		// do stuff, logic, and calls
	} catch (Exception e) {
		// Log the error, throw new exception for upper level
		MyLog.exception(e, "Optional context information");
	}
	return;
}
```

The ```MyLog.Exception``` will decide when to print the stack-dump

# Log and AlreadyHandled Exception

This requires an AlreadyHandledExeption object type, used to throw and inhibit the stack-dump

``` Java
public class AlreadyHandledException extends Exception{
	private static final long serialVersionUID = 1L;
}
```
And the MyLog object

``` java
package info.trustzone.logger;
import java.io.IOException;
import java.util.logging.*;

public class MyLog {
	static Logger logger;
	public Handler fileHandler;
	private SimpleFormatter plainText;

	private MyLog() throws IOException {
		logger = Logger.getLogger(MyLog.class.getName());
		fileHandler = new FileHandler("errorlog.txt",true);
		plainText = new SimpleFormatter();
		fileHandler.setFormatter(plainText);
		logger.addHandler(fileHandler);
	}

	private static Logger getLogger(){
	    if(logger == null){
	        try {
	            new MyLog();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
	    }
	    return logger;
	}

	public static void info(String msg){
	    getLogger().log(Level.INFO, msg);
	}

	public static void exception(Exception e, String message) throws Exception {
		boolean isMyException;		
		isMyException = e instanceof AlreadyHandledException;

		if (isMyException) { // Stack trace was already written, missing the context information
			if (message.length()>0) {
				getLogger().log(Level.SEVERE, message);
			}
			throw (AlreadyHandledException)e;
		} else {  // Lowest level. Stack trace is needed
			// TODO: Nicer Stack trace here
			getLogger().log(Level.SEVERE, e.getMessage(), e);
			if (message.length()>0) {  
				// Developer included context information, to be shown.
				getLogger().log(Level.SEVERE, message);
			}
			throw new AlreadyHandledException(); //
		}
	}

}
```
