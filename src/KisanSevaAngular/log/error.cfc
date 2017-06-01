/**
* File: error.cfc
* Author: Satyapriya Baral
* Path: log/error.cfc
* Purpose: contains function to log error to file.
* Date: 08-05-2017
*/
component {
	
	/**
    * Function to log error to file.
    *
    * @param mixed $exception - contains all data of error.
    * @return null.
    */
	public any function errorLog(any exception)
	{
		var NL = CreateObject("java", "java.lang.System").getProperty("line.separator");
		
		// Details about the error to log //
		savecontent variable="data"
		{
			WriteOutput('DATE/TIME: #Now()# #NL#');
			WriteOutput('ERROR MESSAGE: #exception.Message# #NL#');
			WriteOutput('ERROR DETAILS: #exception.Detail# #NL#');
			WriteOutput('ERROR TEMPLATE: #exception.TagContext[1].Template# #NL#');
			WriteOutput('ERROR LINE: #exception.TagContext[1].Line# #NL#');
			WriteOutput('ERROR TYPE: #exception.Type# #NL#');
			WriteOutput('STACKTRACE: #exception.TagContext[1].Raw_Trace# #NL#');
			WriteOutput('----------------------------------------------------------------------#NL#');
		}
		
		myFile = expandPath( "../log/errorLog.txt" );
		fileObj = FileOpen( myFile, "append");
		fileWriteLine(fileObj,"#data#");
		fileClose(fileObj);
	}
}
