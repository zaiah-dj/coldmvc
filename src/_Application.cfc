
component {
	this.applicationTimeout = CreateTimeSpan(10,0,0,0);
	this.sessionManagement = true;
	this.sessionTimeout = CreateTimeSpan(0,0,30,0);
	//this.root_dir = ExpandPath(".");
	this.root_dir = getDirectoryFromPath(getCurrentTemplatePath());
	this.jsonManifest = this.root_dir & "/data.json";


	this.mappings = {
		"/"           = this.root_dir & "/",
		"/app"        = this.root_dir & "app/",
		"/assets"     = this.root_dir & "assets/",
		"/bindata"    = this.root_dir & "bindata/",
		"/sql"        = this.root_dir & "sql/",
		"/std"        = this.root_dir & "std/",
		"/templates"  = this.root_dir & "templates/",
		"/views"      = this.root_dir & "views/"
	};

	function onApplicationStart() {
		if (!FileExists(this.jsonManifest)) {
			application.data = {};
			application.path = cgi.path_info;
			application.load = load;
		}
		else {
			application.data = DeserializeJSON(FileRead(this.jsonManifest, "utf-8"));
			application.path = Replace(cgi.path_info, application.data.base & "/", "");
			application.load = load;
		}
		
		return true;
	}

	function onRequestStart (string Page) {
		if (structKeyExists(url, "reload")) {
			onApplicationStart();
		}
	}

	/*
	function onRequest (string targetPage) {
		try {
			include arguments.targetPage;
		} catch (any e) {
			//handle exception
			include "failure.cfm";
		}
	}*/

	function onError (required any Exception, required string EventName) {
		writedump(Exception);
		include "failure.cfm";
		/*
		try { }
		catch {[type] exception) {}
		finally { }
		*/

		/* Execution of errors goes like this:
		1. cfcatch
		2. onError
		3. sitewide handler
		4. generic handler
		*/
	}

	function onMissingTemplate (string Page) {
		//Set something to tell CF that there is something different.
		//writeoutput(Page);
		writedump(cgi);
		//chop up path, and send everything after base directory to ???
		writeoutput(cgi.path_info);
		//writedump(url);
		include "index.cfm";
	}

public function load (String dir) {
	v = ExpandPath(dir);
	//writedump(v); writedump( DirectoryList(v) );

	for (x in DirectoryList(v)) {
		w = GetFileFromPath(x);
		str = "/"& dir & "/" & w;

		if (w == "load.cfm" || Right(w,3) != "cfm")
			continue;
		try {
			include str;
		} 
		catch (any e) {
			/*Catch exceptions for f****d up code*/
			writedump(e);
		}
	}
}

}
