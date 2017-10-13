<!---
Application.example.cfc

@author
	Antonio R. Collins II (ramar.collins@gmail.com)
@end

@copyright
	Copyright 2016-Present, "Deep909, LLC"
	Original Author Date: Tue Jul 26 07:26:29 2016 -0400
@end

@summary
  An Application.cfc example.
@end
  --->
component
{
	//A datasource map
	this.datasources["embedded"] = {
			class:            "org.h2.Driver"
		, bundleName:       "org.h2"
		, bundleVersion:    "1.3.172"
		, connectionString: "jdbc:h2:C:\lucee\tomcat\webapps\policy\db\etc\raleighbot;MODE=MySQL"
		, connectionLimit:  100
		, username:         "sa"
		, password:         ""
	}

	//Define the name of this application
	this.name = "PolicyDB"
	
	//Turn on ORM
	this.ormenabled = "true"

	//Chooose a global datasource
	this.datasource = "embedded"

	//...
	function onApplicationStart() {
		return true;
	}

	//...
	function onRequestStart (string Page) 
	{
		if (structKeyExists(url, "reload")) 
		{
			onApplicationStart();
		}
	}

	//...
	function onRequest (string targetPage) 
	{
		try 
		{
			include "index.cfm";
		} catch (any e) {
			//Handle exception
			writedump(e);
			abort;
			include "failure.cfm";
		}
	}

	//...
	function onError (required any Exception, required string EventName) 
	{
		writedump(Exception);
		include "failure.cfm";
	}

	//...
	function onMissingTemplate (string Page) 
	{
		include "index.cfm";
	}
}
