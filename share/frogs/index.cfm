<!---
Application.cfc

@author
	Antonio R. Collins II (ramar.collins@gmail.com)
@end

@copyright
	Copyright 2016-Present, "Deep909, LLC"
	Original Author Date: Tue Jul 26 07:26:29 2016 -0400
@end

@summary
 	ColdMVC's index file.  The single entry point for applications
	running on this framework. 
@end
  --->
<cfscript>
	coldmvc = createObject("component", "coldmvc").init({});
	coldmvc.make_index(coldmvc);
</cfscript>
