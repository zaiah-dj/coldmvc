<!--- NCCU CMS v2 (or 3, whatever...) --->
<cfcomponent name="GlobalApplication">
<cfscript>
/*Application variables*/
this.applicationTimeout = CreateTimeSpan(10,0,0,0);
this.sessionManagement = true;
this.sessionTimeout = CreateTimeSpan(0,0,30,0);
//this.root_dir = ExpandPath(".");
this.root_dir = getDirectoryFromPath(getCurrentTemplatePath());
this.jsonManifest = this.root_dir & "/data.json";
This.name = 'NCCUApp';
This.applicationTimeout = createtimespan(2,0,0,0);
This.clientManagement = 'false';
This.clientStorage = 'cookie';
This.loginStorage = 'session';
This.scriptProtect = 'true';
This.sessionManagement = 'true';
This.setClientCookies = 'false';
This.setDomainCookies = 'false';
this.datasource = 'WebDB';

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

/*Server*/
param name='server.basePath' default=ExpandPath('/');
param name='server.baseDirectory' default='/';
if (1 || (!isDefined('server.basePath') && isDefined('server.baseDirectory'))) {
	lock timeout='10' scope='server' throwOnTimeout='no' type='exclusive' {
		server.basePath = ExpandPath("/");
		server.baseDirectory = "/";	
	}
}

lock timeout='10' scope='server' throwOnTimeout='no' type='exclusive' {
	server.encryptionKey='/LoNNZMMLa0ADo04bz4i+g==';
	server.deprecatedKeyList='bTeBbSA+3PHi6xI8gE/efA==';
	/*server.encryptionKeyX='zZl0WZUtCShAKmKZOOQyGg==';
	server.encryptionKey2='pPsZsjt3eZ3gcqiHP7fmxw==';*/
	server.systemUsername='PepperLookup';
	server.systemPassword='Aa9861hZyUTVY4sjljDMkgLSb7pUnmc1IU5iQUN2w86csamkSw1NxpKJsdOmCZo';
	server.szSoapAdapDSDirectoryToolsKey = 'sand.ad.nccu.edu-2fdb8843-4692-4884-8c87-3c9b0516d267';
	server.szSoapAdapDSDirectoryTools = 'https://sg-adap.ad.nccu.edu/DirectoryServices2011/services/DirectoryTools.asmx?WSDL';
	server.objJRun = CreateObject('java','jrunx.kernel.JRun');
}


/*if (!IsDefined(application, "cachedData"))
	application.cachedData = ArrayNew(1);*/
if (!IsDefined('application.cacheData'))
	application.cachedData = ArrayNew(1);
/*if (!IsDefined('application.cacheTime'))
	application.cacheTime = CreateTimeSpan(0,3,0,0);*/
application.ldapServer = "goten.ad.nccu.edu";
application.ldapServer2 = "goten.ad.nccu.edu";
application.RE_NOT_basic_char = "([^a-zA-Z0-9\ ])";                    /*matches characters other than alphanumeric*/
application.RE_NOT_basic_char2 = "([^a-zA-Z0-9\ ',-])";                /*matches characters other than alphanumeric or apostraphes or commas*/
application.RE_NOT_basic_char3 = "([^a-zA-Z0-9\ ',()\.])";             /*matches characters other than alphanumeric or basic punctuation (allows basic paragraph text)*/
application.RE_URLprotocol = "(((https?|ftp)(://)(www\.)?)|(www\.))";  /*matches a URL prefix*/
application.RE_NOT_URLdomain = "([^a-zA-Z0-9-_/\ \.])";                /*matches characters not valid in URL domains*/
application.RE_General_Text = "([^a-zA-Z0-9\ ',()\.=/_-])";            /*matches characters not valid in URL domains*/
application.RE_NOT_basic_char4 = "([^A-Za-z0-9'!,@_ \(\)\?\./\$:-]+)"; /*matches characters other than alphanumeric, basic punctuation, or smiley text*/
application.RE_basic_char4 = "([A-Za-z0-9'!,@_ \(\)\?\./\$:-]+)";      /*matches alphanumeric, basic punctuation, or smiley text*/
/* example: url.tags = REReplace(url.tags,application.RE_NOT_basic_char,"","all")> */
</cfscript>
<!---
application.encryptionKey=server.encryptionKey;                    //use 'server.encryptionKey' instead
application.deprecatedKeyList=server.deprecatedKeyList;            //use 'server.deprecatedKeyList' instead
application.encryptionKeyX=server.encryptionKeyX;                  //use 'server.encryptionKeyX' instead
application.encryptionKey2=server.encryptionKey2;                  //use 'server.encryptionKey2' instead
application.systemUsername=server.systemUsername;                  //use 'server.systemUsername' instead
application.systemPassword=server.systemPassword;                  //use 'server.systemPassword' instead
	<!---DEPRECATED---><cfset application.devDir = "#iif(REFindNoCase("^(D:\\websites\\NCCU\.edu\\development\\)",getCurrentTemplatePath()),DE('/development'),DE(''))#"/><!---development directory; set to "" when not in development mode. otherwise, set to subdirectory componenet corresponding to development directory--->
	<!---DEPRECATED---><cfset application.devDirLocal = "#iif(REFindNoCase("^(D:\\websites\\NCCU\.edu\\development\\)",getCurrentTemplatePath()),DE('\development'),DE(''))#"/><!---development directory (non-web/windows address); set to "" when not in development mode. otherwise, set to subdirectory componenet corresponding to development directory--->
	<!---DEPRECATED---><cfset application.mappingDir = "/mappings/intranet">
--->
<!---//APPLICATION SCOPE--->


<cfscript>
/*Session*/
param name="session.username" default='';
param name="session.password" default='';
param name="session.mail" default='';
param name="session.user_ID" default='';
param name="session.display_name" default='';
param name="session.first_name" default='';
param name="session.last_name" default='';
param name="session.middle_init" default='';
param name="session.authenticated" default="no";
param name="session.rememberme" default="no";
param name="session.admin" default="no";
param name="session.requestedPage" default="";
param name="session.home_directory" default="";
param name="session.department" default="";
param name="session.userDashboardRightsArray" default="#ArrayNew(1)#";
param name="session.insecurePassword" default="false";
param name="session.isEmployee" default="false";
param name="session.isStudent" default="false";
param name="session.isProspect" default="false";
param name="session.isAlumni" default="false";
param name="session.alumniUser" default="no";
param name="session.prospectiveUser" default="no";
param name="session.bannerID" default="";
param name="session.streetAddress1" default="";
param name="session.streetAddress2" default="";
param name="session.city" default="";
param name="session.stateProvince" default="";
param name="session.country" default="";
param name="session.applicantType" default="";
param name="session.zip" default="";
param name="session.sessionTimeSpan" default=createTimeSpan(0,0,40,0);
param name="session.expireSecondsRemaining" default="2400";/*40 minutes*/
/*param name="session.newsBit" default="on"
param name="session.eventsBit" default="off"
param name="session.athleticsBit" default="on"
param name="session.alertsBit" default="off"
param name="session.newsBit" default="on"
param name="session.announcementsBit" default="off"
param name="request.file_path" default='/formsdocs/files' (We are all deprecated :) )*/
param name="variables.venderCode" default="0000";
param name="variables.venderTitle" default="North Carolina Central University";
param name="variables.venderDescription" default="North Carolina Central University";
param name="variables.venderName" default="Web Services";
param name="variables.venderKeywords" default="North Carolina Central University";
param name="variables.venderPrimaryCSS" default="0";
param name="variables.venderCurrGuideCSS" default="0";
param name="variables.venderPrimaryJS" default="0";
param name='variables.cacheTime' default=CreateTimeSpan(0,3,0,0);


/*Cookies?*/
try {
	if (isDefined("cookie.rememberme") && cookie.rememberMe neq "") {
		decryptedCookie = decrypt(cookie.rememberme,application.encryptionKey,"AES","Hex");
    session.expireSecondsRemaining = dateDiff("s",now(),getToken(decryptedCookie,4,','));

		if (!(LCase(session.authenticated) == 'yes' && 
					session.username == GetToken(decryptedCookie,1,',') && 
					CreateTimeSpan(0,0,0,session.expireSecondsRemaining) > CreateTimeSpan(0,0,40,0)
				))
      session.expireSecondsRemaining = 2400;
		else {
			this.sessionTimeout = CreateTimeSpan(0,0,0,session.expireSecondsRemaining);
      session.sessionTimeSpan = CreateTimeSpan(0,0,0,session.expireSecondsRemaining);
		}
	} 
}
catch (any e) { ;/*Something ought to be done here...*/ }


/*All of my application functions can go in another cfc or in this one... scope is a problem*/
</cfscript>

<cffunction name="redirect_on_fail"
>
	<!--- If it's a query, check that you're part of it. --->
	<!--- Define the groups to be a part of --->
	<!--- Define the redirection URL --->
	<cfif 0>
     <cflocation url='#data.REDIRECT#' addtoken='no'>
	</cfif>
</cffunction>


<cffunction
	name="DateTimeFormat"
	access="public"
	returntype="string"
	output="false"
	hint="Formats the given date with both a date and time format mask.">
	 
	<!--- Define arguments. --->
	<cfargument
	name="Date"
	type="date"
	required="true"
	hint="The date/time stamp that we are formatting."
	/>
	 
	<cfargument
	name="DateMask"
	type="string"
	required="false"
	default="dd-mmm-yyyy"
	hint="The mask used for the DateFormat() method call."
	/>
	 
	<cfargument
	name="TimeMask"
	type="string"
	required="false"
	default="h:mm TT"
	hint="The mask used for the TimeFormat() method call."
	/>
	 
	<cfargument
	name="Delimiter"
	type="string"
	required="false"
	default=", "
	hint="This is the string that goes between the two formatted parts (date and time)."
	/>
	 
	 
	<!---
	Return the date/time format by concatenating the date
	and time formatting separated by the given delimiter.
	--->
	<cfreturn (
	DateFormat(
	ARGUMENTS.Date,
	ARGUMENTS.DateMask
	) &
	 
	ARGUMENTS.Delimiter &
	 
	TimeFormat(
	ARGUMENTS.Date,
	ARGUMENTS.TimeMask
	)
	) />
</cffunction>



<!---
execute_sql.cfm

Executes an SQL query from file or string.  Specifying dump=true will do a 
cfdump of the query. 

User may specify fields from the function versus having to fill out cfset 
or cfparam or some other variable in some weird place within the code.  
This prevents untracked globals from running around too.
--->

<!--- Use this to execute queries properly --->
<cffunction 
	name=dynquery 
	description="Runs queries."
	hint="Runs queries and returns the data in a struct."
	returnType="struct"
>
	<cfargument name="queryPath" required="yes">
	<cfargument name="queryVar" required="yes">
	<cfargument name="queryDatasource" required="no" default="#data.DATASOURCE#">
	<cfargument name="debuggable" required="no" default=false>

	<cfparam name="myRes" default="">
	<cfset myRes=StructNew()>

	<!--- Output stuff --->
	<cfif debuggable gt 0>
		<cfdump var="#queryPath#">
		<cfdump var="#queryVar#">
		<cfdump var="#queryDatasource#">
	</cfif>

	<cftry>
		<cfquery name="__results" result="__object" datasource="#queryDatasource#">
			<cfinclude template="#queryPath#">
		</cfquery>
	<cfcatch>
		<cfdump var="#cfcatch#">
		<cfsavecontent variable="killerBob">
			<cfset err="#cfcatch.TagContext[1]#">
			<cfoutput>SQL execution error at file #err.template#, line #err.Line#. #cfcatch.message#</cfoutput>
			<!---
			<cfoutput>#cfcatch.message#</cfoutput>
			--->
		</cfsavecontent>
		<cfset myRes.status = 0>
		<cfset myRes.object = QueryNew("nothing")>   <!---Any way to make a blank query--->
		<cfset myRes.error = "#killerBob#">
		<cfset myRes.results = QueryNew("nothing")>
		<cfreturn myRes>
	</cfcatch>
	</cftry>

	<cfset myRes.status = 1>
	<cfset myRes.error = "">
	<cfset myRes.object = __object>
	<cfset myRes.results = __results>
	<cfreturn myRes>
</cffunction>


<cfscript>
/*A ColdFusion component that acts as a very lightweight framework.*/

/*Fill out the user information*/
public boolean function memberOf (String groupID, String userID) {
	/*Loop through each.*/	
	return objCommon.GetGroupMembership(group=groupID, type="DB", username=userID); 
}


/*Check in structs for elements*/
public Boolean function check_deep_key (Struct Item, String list) {
	thisMember=Item;
	nextMember=Item;

	//Loop through each string in the argument list. 
	for (i=2; i <=	ArrayLen(Arguments); i++) {
		//Check if the struct is a struct and if it contains a matching key.
		if (!isStruct(thisMember) || !StructKeyExists(thisMember, Arguments[i]))
			return 0;
		thisMember = thisMember[Arguments[i]];	
	}

	return 1;
}


/*wrap Error*/
public query function wrapError(e) {
	err = e.TagContext[1];
	myRes = StructNew();
	structInsert(myRes, 0, "status");
	structInsert(myRes, "Error occurred in file " & e.template & ", line " & e.line & ".", "error");
	structInsert(myRes, e.stackTrace, "StackTrace");
	return myRes;
}

/*Find the index of a resource if it exists.  Return 0 if it does not.*/
public String function resourceIndex (String name, Struct ResourceList) {
	//Create an array of the current routes.
	if (!structKeyExists(ResourceList, "routes")) {
		//writedump("No routes defined.");
		return "default";
	}

	//Handle no routes
	if (StructIsEmpty(ResourceList.routes))
		return "default";

	//Check for resources in GET or the CGI.stringpath 
	if (StructKeyExists(ResourceList, "handler") && CompareNoCase(ResourceList.handler, "get") == 0) {
		if (isDefined("url") and isDefined("url.action"))
			name = url.action; 
		else {
			if (StructKeyExists(ResourceList, "base"))
				name = Replace(name, ResourceList.base & "/", "");
		}
	}
	else {
		//Cut out only routes that are relevant to the current application.
		if (StructKeyExists(ResourceList, "base"))
			name = Replace(name, ResourceList.base & "/", "");
	}
		
	//Handle the default route if ResourceList is not based off of URL
	if (!StructKeyExists(ResourceList, "handler") && name == "index.cfm")
		return "default";

	//If you made it this far, search for the requested endpoint
	for (x in ResourceList.routes) {
		if (name == x) 
			return x;
		if (Replace(name, ".cfm", "") == x)
			return x;
		//Replace the base
	}

	//You probably found nothing, so either do 404 or some other stuff.
	return "default";
}

/*Function returns a query.  NULL if nothing... */
public function execQuery (String qf, Boolean dump) { 
	/*Check for the existence of the file we're asking for*/
	var template = qf & ".cfm";

	/*Debugging info*/
	//writeoutput("<br />" & template);
	//writeoutput("<br />" & expandPath(template));

	/*
	// Check that the file exists.
	if (!FileExists(expandPath(template))) {
		var a = QueryNew("File_does_not_exist");
		return a;
		// use struct and return it ...
	}
	*/

	/*A function can move through each of the Arguments and tell you what was passed*/
	if (dump == true) {
		for (x in Arguments) 
			writeoutput("<li>" & x & " => " & Arguments[x] & "</li>");
	}
	
	/*Run the query and cache any failures*/
	var sql = dynquery(template, Arguments);
	//Include template; writeDump(#__query#);writeDump(#__results#);

	/*Most of the errors have been handled.  You just need to let the user know it failed*/
	if (sql.status == False) { ; }
	if (dump == True)
		writedump(sql);
	
	return sql;
}



function onApplicationStart() {
	if (!FileExists(this.jsonManifest)) {
		application.cms = {};
		application.data = {};
		//application.path = cgi.path_info;
		application.load = load;

		/*Until I get this running as a component, I have to do this...*/
		application.resourceIndex = resourceIndex;
		application.memberOf = memberOf;
		application.wrapError = wrapError;
		application.dynquery = dynquery;
		application.redirectOnFail = redirect_on_fail;
		application.DateTimeFormat = DateTimeFormat;
		application.execQuery = execQuery;
		application.check_deep_key = check_deep_key;

	}
	else {
		application.cms = {};
		application.data = DeserializeJSON(FileRead(this.jsonManifest, "utf-8"));
		//application.path = Replace(cgi.path_info, application.data.base & "/", "");
		application.load = load;
		application.resourceIndex = resourceIndex;
		application.memberOf = memberOf;
		application.wrapError = wrapError;
		application.dynquery = dynquery;
		application.redirectOnFail = redirect_on_fail;
		application.DateTimeFormat = DateTimeFormat;
		application.execQuery = execQuery;
		application.check_deep_key = check_deep_key;
	}
	
	return true;
}

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


</cfscript>
</cfcomponent>
