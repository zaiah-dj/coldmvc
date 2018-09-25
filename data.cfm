<cfscript>
/* ------------------------------------------ *
data.cfm
--------

CFML-based configuration file.

Application routes, datasources and more
are all updated here.
* ------------------------------------------- */
useDebug = 0;

/*Passwords if ever needed
Server:    sqldev.phs.wfubmc.edu
Account:   motrpacDevUser
Database:  motrpac
Pwd:       9F25a26V7j42
*/

/*This variable is used by ColdMVC to load all configuration data*/
manifest={
/*----------------- NOT SMART TO MODIFY THIS STUFF ------------------*/
 "cookie" = "3ad2d4dc34e75130c0c2f3c4bbb262481b49250261bcb8e6443728b63d24"
 
/*----------------- DEBUGGABLE STUFF ------------------*/
/*Use this to move the date forward or backward*/
//,date = "10/02/2018"

/*Use this to spoof yourself as another user*/
//,"user" = 1081 

/*----------------- USER-MODIFIABLE STUFF ------------------*/
/*Turn on debugging, yes or no?*/
,"debug"  = useDebug 

/*Add some locations for local development*/
,"localdev"  = [ "localhost:8888", "127.0.0.1:8888" ]

/*Add some places where this app should be running*/
/* ... */

/*Select a datasource*/
,"source" = ( useDebug ) ? "zProgrammer_AntonioCollins" : "motrpac"

/*All requests will use this as the base directory*/
,"base"   = "/motrpac/web/secure/dataentry/iv/"

/*This is a symbolic name for the application*/
/*,"name"   = "iv"*/

/*Set the site title from here*/
,"title"  = "Motrpac Intervention Tracking"

/*This is used to control how much logging to do where*/
,"settings" = {
	 "verboseLog" = 0
	,"addLogLine" = 0
}

/*----------------- DEPRECATED / UNUSED ---------------------*/
/*This was used to run something after every request*/
,"master-post" = false

/*This was used to choose custom 404 and 500 error pages*/
,"localOverride" = {
	 "4xx"    = 0
	,"5xx"    = 0
}

/*----------------- CUSTOM  ---------------------------------*/
/*Other things that can go in data, but to keep things easy
to fix later, I'll seperate them from what should be there*/
,"redirectForLogin" = "/motrpac/web/dspLogin.cfm?to=0"
,"redirectHome" = "/motrpac/web/secure/index.cfm"
,"ajaxEveryTime"  =  0
,"neverExpire"   = -1

/*----------------- DATABASES -------------------------------*/
/*Aliases for database tables, note you can choose between 
production and development table names so that you don't hose
real data*/
,"data"   = {

	"endurance"     = "frm_EETL"
 ,"resistance"    = "frm_RETL"
 ,"participants"  = "v_ADUSessionTickler"

 ,"notes"         = "ParticipantNotes"
 ,"checkin"       = "ac_mtr_checkinstatus_v2"
 ,"bloodpressure" = "ac_mtr_bloodpressure_v2"

 ,"serverlog"     = "ac_mtr_serverlog"


 ,"sia"           = "ac_mtr_session_interventionist_assignment"

 ,"sessiondappl"  = "ac_mtr_session_metadata"
 ,"sessiondpart"  = "ac_mtr_session_participants_selected"
 ,"sessiondtrk"   = "ac_mtr_session_participant_data_tracker"
 ,"sessiondstaff" = "ac_mtr_session_staff_selected"
 ,"staff"         = "ac_mtr_test_staff"

 ,"et"   = "equipmentTracking"
 ,"eteq" = "equipmentTrackingEquipment"
 ,"etex" = "equipmentTrackingExercises"
 ,"etin" = "equipmentTrackingInterventions"
 ,"etma" = "equipmentTrackingMachines"
 ,"etmn" = "equipmentTrackingManufacturers"
 ,"etmo" = "equipmentTrackingModels"
 ,"etst" = "equipmentTrackingSettings"
 ,"etvr" = "equipmentTrackingVersions"
}

/*----------------- ROUTES ---------------------------------*/
/*Here are the application's routes or endpoints.*/
,"routes" = {

	/* --- APPLICATION ENDPOINTS ----------------------------------- */
	/*The participant selection page as seen by the interventionists.*/
	"default"= { model="init", view = [ "master/head", "default", "master/tail" ] }

 ,"recovery-done" = {model = [ "init", "recoveryDone" ], view = "recovery-done" }

	/*See how participants are currently assigned among staff members*/ 
 ,"staff" = { model= [ "init", "staff" ], view= [ "master/head", "staff", "master/tail" ] }

	/*Data entry pages for particpants.*/
 ,"input"  = { model= [ "init", "input" ],
	 view = [ "master/head", "participant/list", "participant/nav", "input", "master/tail" ] }

	/*Page to collect notes*/
 ,"check-in" = { model = [ "init" ],
	 view = [ "master/head", "participant/list", "participant/nav", "checkIn", "master/tail" ] }

	/*Logout an interventionist, releasing all of their associated participants and stopping the session.*/
	,"logout" = { model="logoutUser", view="logout" , hint="Logs out a user." }

	/*Either stop a session early, or input participant recovery data*/
	,"recovery" = { model= [ "init", "recovery" ],
	  view = [ "master/head", "participant/list", "participant/nav", "recovery", "master/tail" ] }

	/*View the access log*/
	,"log"   = { model=  "dev/log", view=  "log" }

	 
	/* --- API ENDPOINTS --------------------------------------- */
	/* These pages should never be requested by a user */
	/*Update something*/
	,"time"   = { model=  ["init", "api"], view=  "api", content_type = "application/json" }

	/*View the access log*/
	,"notes"   = { model=  ["init", "api"], view=  "api", content_type = "application/json" }

	/*Return results for previous weeks*/
	,"modal-results" = { model= [ "init", "api" ], view= "modal-results",content_type= "application/json" }

	/*Return results for completed days in a week go here.*/
	,"completed-days-results" = { model= [ "init", "api" ], view= "days-results" }

	/*Handle all CRUD functions*/
	,"update" = { model= ["init","api" ],view=  "api",content_type= "application/json" }

	/*Update notes (should eventually be done up top)*/
	,"update-note" = {model = [ "init", "api" ], view = "api", content_type="application/json" }

 } /*end routes*/
};
</cfscript>
