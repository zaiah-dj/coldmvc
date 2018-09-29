<!---
data.cfm

CFM based routing structure.
I can do more with this concept...
  --->
<cfset manifest={
 "source" = "motrpac"
,"cookie" = "3ad2d4dc34e75130c0c2f3c4bbb262481b49250261bcb8e6443728b63d24"
,"base"   = "/motrpac/web/secure/dataentry/iv/"
,"Home"   = "tmp"
,"name"   = "iv"
,"neverExpire"   = -1
,"title"  = "Motrpac Intervention Tracking"
,"debug"  =  0
,"ajaxEveryTime"  =  0
,"master-post" = false
,"data"   = {}
,"css"    = []
,"js"     = []
,"localOverride" = {
	 "4xx"    = 0
	,"5xx"    = 0
}
,"settings" = {
	 "verboseLog" = 0
	,"addLogLine" = 0
}
,"routes" = {
	 "docs"   = { 
		"model" = "docs"
	 ,"view"  =  "docs"
	 ,"hint"  =  "This just documents this app." 
	}

	,"log"   = { 
		"hint"  =  "See the access log."
	 ,"model" =  "log"
	 ,"view"  =  "log"
	}

	,"robocop"   = { 
		"hint"  =  "Log XHR requests."
	 ,"model" =  "robocop"
	 ,"view"  =  "robocop"
	}

	,"test"   = { 
		"hint"  =  "Test how new HTML5 controls look."
	 ,"model" = [ "test", "session/check", "chosen", "participant" ]
	 ,"view"  = [ "master/head", "participant/list", "participant/nav", "tests/test", "master/tail" ] 
	}

	,"update" = { 
		"hint"  =  "This acts as the server side endpoint for values edited via AJAX." 
	 ,"model" = "update"
	 ,"content_type"  
						= "application/json"
	 ,"view"  =  "update" 
	}

	,"expired"= { 
		"hint"  =  "The thing of the thing."
	 ,"model" = [ "session/check", "default", "expired", "chosen", "reconcile" ]
	 ,"view"  = [ "master/head", "default", "master/tail" ] 
	}

	,"default"= { 
		"hint"  =  "The thing of the thing."
	 ,"model" = [ "session/check", "default", "chosen", "reconcile" ]
	 ,"view"  = [ "master/head", "default", "master/tail" ] 
	}

	,"check-in-complete"= { 
		"hint"  =  "Mark a check-in as completed."
	 ,"model" = [ "session/check", "check-in-complete" ]
	 ,"view"  = "check-in-complete"
	}

	,"chosen" = { 
		"hint"  =  "See all chosen participants in a session."
	 ,"model" = [ "session/check", "chosen" ]
	 ,"view"  = [ "master/head", "participant/list", "chosen", "master/tail" ] 
		}

	,"info"   = { 
		"hint"  =  "See all patient data (more than you ever wanted to know)."
	 ,"model" = [ "session/check", "chosen", "participant" ]
	 ,"view"  = [ "master/head", "participant/list", "participant/nav", "info", "master/tail" ] 
		}

	,"compare"= { 
		"hint"  =  "Compare the participant's previous weeks history."
	 ,"model" = [ "session/check", "chosen", "participant" ]
	 ,"view"  = [ "master/head", "participant/list", "participant/nav", "compare", "master/tail" ] 
		}

	,"check-in" = { 
		"hint"  =  "Enter test data for a participant.  Exercise types and questions are chosen during the randomization process and should not need to be modified here."
	 ,"model" = [ "session/check", "chosen", "participant", "check-in" ]
	 ,"view"  = [ "master/head", "participant/list", "participant/nav", "check-in", "master/tail" ] 
		}

	,"input"  = { 
		"hint"  =  "Enter test data for a participant.  Exercise types and questions are chosen during the randomization process and should not need to be modified here."
	 ,"model" = [ "session/check", "chosen", "participant", "input" ]
	 ,"view"  = [ "master/head", "participant/list", "participant/nav", "input", "master/tail" ] 
		}

	,"refresh-session" = { 
		"model" =  "refresh-session"
	 ,"view"  = [ "master/head", "refresh-session", "master/tail" ] 
	 ,"hint"  =  "Refresh a user session."
	 	}

	,"logout" = { 
		"model" = "session/kill"
	 ,"view"  =  "logout"
	 ,"hint"  =  "Use this endpoint to revoke all session keys." 
	 	}

	,"dumply" = { 
		"model" = "_none"
	 ,"view"  =  "dumply"
	 ,"hint"  =  "Use this endpoint to see all values." 
		}

	,"save"   = { 
		"model" = "_none"
	 ,"view"  =  "save"
	 ,"hint"  =  "Use this endpoint to see all values." 
		}

	,"home"   = { }
	}
}>
