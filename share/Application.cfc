<!--- All Application.cfc rules should go before the next line. --->
<!--- DO NOT DELETE THE NEXT LINE ---> 
<cfscript>
this.root_dir = getDirectoryFromPath(getCurrentTemplatePath());
this.Mappings = {
	"/"           = this.root_dir & "/",
	"/app"        = this.root_dir & "app/",
	"/assets"     = this.root_dir & "assets/",
	"/bindata"    = this.root_dir & "bindata/",
	"/sql"        = this.root_dir & "sql/",
	"/std"        = this.root_dir & "std/",
	"/templates"  = this.root_dir & "templates/",
	"/views"      = this.root_dir & "views/"
};

/*An onRequestStart method for this framework.*/
function onRequestStart (string Page) {
	//application.data = DeserializeJSON(FileRead(this.jsonManifest, "utf-8"));
	if (structKeyExists(url, "reload")) {
		onApplicationStart();
	}
}


/*Disallow requests for framework directories*/
function onRequest (string targetPage) {
	//Search the url for any of these.
	arrayMappings = [ "/app/", "/bindata/", "/db/", "/files/", "/sql/", "/std/", "/views/" ];
	for (endpoint in ArrayMappings)  {
		pos = Find(endpoint, cgi.script_name);
		if (pos) {
			//If a request is made for these, it really is an error.
			location(url = ToString(cgi.http_host & Left(cgi.script_name, pos)));
			//Another handler for this event should go here.
			render_page(status=401, errorMsg=ToString("You are not authorized to see this page."));
			abort;
		} 
	}

	include arguments.targetPage;
}


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
	include "index.cfm";
}
</cfscript>
