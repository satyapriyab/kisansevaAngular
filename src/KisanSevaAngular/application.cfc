/**
* File: application.cfc
* Author: Satyapriya Baral
* Path: application.cfc
* Purpose: contains all event listner for the application
* Date: 01-05-2017
*/
component {
	this.datasource = "KisanSeva";
	this.name = "KisanSeva";
	this.clientmanagement = true;
	this.sessionmanagement = true; 
	this.setclientcookies = true;
	this.sessiontimeout = "#createTimeSpan(0,0,20,10)#";
	this.applicationtimeout = "#createTimeSpan(0,0,30,10)#";

	/**
    * Function to set current user on applicaton start.
    *
    * @param null.
    */
	function onApplicationStart() {
		Application.currentUsers = "";
		Application.baseUrlData = getDirectoryFromPath(getCurrentTemplatePath());
	}
	
	/**
    * Function to set variables on Session start.
    *
    * @param null.
    */
	function onSessionStart() {
		SESSION.isLogged = "false";
		SESSION.userEmail = "";	
	}
	
	function onRequestStart( string template ) {
	  
      var local = {};
      local.basePath = getDirectoryFromPath(getCurrentTemplatePath());
            
      local.targetPath = getDirectoryFromPath(expandPath( arguments.template ));

      local.requestDepth = (listLen( local.targetPath, "\/" ) - listLen( local.basePath, "\/" ));
      request.webRoot = repeatString("../", local.requestDepth);

      request.siteUrl = ("http://" & cgi.server_name & reReplace(getDirectoryFromPath( arguments.template ), "([^\\/]+[\\/]){#local.requestDepth#}$", "", "one"));

	  return true;
    }

    function onRequest( string targetPage ) {
        include arguments.targetPage;
        return;
    }
	
	/**
    * Function to set variables on session end.
    *
    * @param null.
    */
	function onSessionEnd( struct SessionScope, struct ApplicationScope) {
		ApplicationScope.currentUsers = listDeleteAt(ApplicationScope.currentUsers,listFind(ApplicationScope.currentUsers,#SessionScope.userEmail#));
		location(url = "../index.cfm" addtoken = "false");
		structClear(ARGUMENTS.SessionScope);
	}
}