<!---
Application-Redirect.cfc

Author
------n
	Antonio R. Collins II (rc@tubularmodular.com, ramar.collins@gmail.com)

Copyright
---------

	Copyright 2016-Present, "Tubular Modular"
	Original Author Date: Tue Jul 26 07:26:29 2016 -0400

Summary
-------

	A stub used to redirect requests to disallowed directories.
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
