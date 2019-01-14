<cfscript>
/* ------------------------------------------ *
 * data.cfm
 * --------
 * 
 * CFML-based configuration file.
 * 
 * Application routes, datasources and more
 * are all updated here.
 * ------------------------------------------- */

/*This variable is used by ColdMVC to load all configuration data*/
manifest = {
/*This should probably not be modified by you*/
 "cookie" = "__COOKIE__"

/*----------------- USER-MODIFIABLE STUFF ------------------*/
/*Turn on debugging, yes or no?*/
,"debug"  = 0  

/*Description*/
,"description"  = "__DESCRIPTION__" 

/*Author*/
,"author"  = "__AUTHOR__" 

/*Add some locations for local development*/
,"hosts"  = [ ]

/*Select a datasource*/
,"source" = "__DATASOURCE__"

/*All requests will use this as the base directory*/
,"base"   = "__BASE__"

/*This is a symbolic name for the application*/
,"name"   = "__NAME__"

/*Set the site title from here*/
,"title"  = "__TITLE__"

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
/*
,"redirectForLogin" = "/motrpac/web/dspLogin.cfm?to=0"
,"redirectHome" = "/motrpac/web/secure/index.cfm"
,"ajaxEveryTime"  =  0
,"neverExpire"   = -1
	*/

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
	"default"= { model="default", view = [ "master/head", "default", "master/tail" ] }

 } /*end routes*/
};
</cfscript>
