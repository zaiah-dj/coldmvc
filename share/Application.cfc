/*
 * All Application.cfc rules should go before the next line.
 * DO NOT DELETE THE NEXT LINE
 *
 */
component {
	function onRequestStart (string Page) {
		//application.data = DeserializeJSON(FileRead(this.jsonManifest, "utf-8"));
		if (structKeyExists(url, "reload")) {
			onApplicationStart();
		}
	}

	function onRequest (string targetPage) {
		try {
			//include arguments.targetPage;
			include "index.cfm";
		} catch (any e) {
			//handle exception
			status_code = 404;
			status_message = "Page does not exist.";
			include "std/4xx-view.cfm";
		}
	}

	function onError (required any Exception, required string EventName) {
		writedump(Exception);
		include "failure.cfm";
		/*
		try { }
		catch ([type] exception) {}
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
}
