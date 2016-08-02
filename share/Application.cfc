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

function onRequestStart (string Page) {
	//application.data = DeserializeJSON(FileRead(this.jsonManifest, "utf-8"));
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
	include "index.cfm";
}
</cfscript>