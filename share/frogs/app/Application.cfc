<!---
Application-Redirect.cfc

@author
	Antonio R. Collins II (ramar.collins@gmail.com)
@end

@copyright
	Copyright 2016-Present, "Deep909, LLC"
	Original Author Date: Tue Jul 26 07:26:29 2016 -0400
@end

@summary
	A stub used to redirect requests to disallowed directories.
@end
  --->
component {
	function onRequest (string targetPage) 
	{
		j = DeserializeJSON( FileRead( "../data.json", "utf-8") );
		location url = j.base;

		try {
			include "index.cfm";
		} catch (any e) {
			//Handle exception
			writedump(e);
			abort;
			include "failure.cfm";
		}
	}
}
