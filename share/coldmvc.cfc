<!---
coldmvc.cfc

An MVC like structure for handling ColdFusion pages.

TODO:
- Add database struct add key 
--->
<cfcomponent name="ColdMVC">
<cfscript>
/*Other directories*/
this.root_dir = getDirectoryFromPath(getCurrentTemplatePath());

this.arrayMappings = [ "app", "assets", "bindata", "db", "files", "sql", "std", "views" ];

this.Mappings = {
	"/"           = this.root_dir & "/",
	"/app"        = this.root_dir & "app/",
	"/assets"     = this.root_dir & "assets/",
	"/bindata"    = this.root_dir & "bindata/",
	"/files"      = this.root_dir & "files/",
	"/sql"        = this.root_dir & "sql/",
	"/std"        = this.root_dir & "std/",
	"/templates"  = this.root_dir & "templates/",
	"/views"      = this.root_dir & "views/"
};

/*Create ORM files*/

/*Parse the JSON files*/

/*???*/

/*Create an instance via a web interface*/

/*Admin interface?*/
function run_something() {
	/*Loop through all the views in the directory*/
	/*See all the info for it.*/	
}


/*....*/
public Struct function upload_file (String formField, String mimetype) {
	//Create a file name on the fly.
	fp = this.Mappings["/files"]; 
	fp = ToString(Left(fp, Len(fp) - 1)); 
	
	//Upload it.	
	a = FileUpload(
		fp            /*destination*/,
		formField     /*Element from form to write*/,
		"",           /*No mimetype limit*/
		"MakeUnique"  /*file name overwrite function*/);
	
	//This ought to be some random name.
	//randstr(16) & "<file extension>";

	//writedump(a);abort;
	//Return a big struct full of all file data.
	return a;
}


/*Check if a result set is composed of all nulls*/
public Boolean function isSetNull (Query q) {
	columnNames=ListToArray(q.columnList);
	if (q.recordCount eq 1) {
		//Check that the first (and only) row is not blank.
		for (ci=1; ci lte ArrayLen(columnNames); ci++)
			if (q[columnNames[ci]][1] neq "") return false;	
	}
	else {
		return false;
	}
	return true;
}
</cfscript>


<cffunction 
	name="render_page">

	<cfargument
		name="status"
		required="no"
		type="numeric"
		>

	<cfargument
		name="errorMsg"
		required="yes"
		>

	<cfargument
		name="errorAddl"
		required="no"
		type="String"
		>

	<cfargument
		name="stackTrace"
		required="no"
		>

	<cfargument
		name="content"
		required="no"
		>

	<!--- If status is something different handle that page. --->
	<cfif isDefined("status")>
		<cfcontent type="text/html">
		<cfif status eq 404>
			<cfset status_code = status>
			<cfset status_message = "Page Not Found">
			<cfinclude template="/views/4xx-view.cfm">
		<cfelse>
			<cfset status_code = status>
			<cfset status_message = "Internal Server Error">
			<cfif isDefined("errorAddl")>
				<cfset errorLong = "#errorAddl#">
			</cfif>
			<cfif isDefined("stackTrace")>
				<cfset exception = "#stackTrace#">
			</cfif>
			<cfinclude template="/views/5xx-view.cfm">
		</cfif>

	<cfelse>
		<!--- Now render the page --->
		<cfif #check_deep_key(appdata, "routes", resource_name, "content-type")#>
			<cfcontent type="appdata.routes[resource_name]['content-type']">
			<cfoutput>#content#</cfoutput>

		<cfelse>

			<cfcontent type="text/html">
			<cfoutput>#content#</cfoutput>
		</cfif>

	</cfif>
</cffunction>


<cffunction
	name="dump_routes"
	returnType="String"
>
	<cfset className="_cmsRouteInfo">
	<cfsavecontent variable="cms.routeInfo">
	<cfoutput>
	<style type=text/css>
		table.#className# {
				
		}

		th.#className# {
			background-color: gray;	
			color: white;
			border: 2px solid white;
		}

		div.#className# {
			position: relative;
			width: 60%;
			left: 20%;
		}
	</style>

	<div class=#className#>	
	<table>
		<tr>
			<th class=#className#>Title</th>
			<th class=#className#>Path</th>
			<th class=#className#>Hints</th>
			<th class=#className#>Content-Type</th>
			<th class=#className#>Model</th>
			<th class=#className#>View</th>
		</tr>
	<cfloop collection=#appdata.routes# item="heaven">
		<tr>
			<td>#heaven#</td>
			<td><a href="#appdata.base#/#heaven#.cfm">#appdata.base#/#heaven#</a></td>

			<!--- this is a no-no --->
			<cfif #check_deep_key(appdata, "routes", heaven, "hint")#>
				<td>#appdata.routes[heaven]["hint"]#</td>
			<cfelse>
				<td>none</td>
			</cfif>

			<!--- this is a no-no --->
			<cfif #check_deep_key(appdata, "routes", heaven, "content-type")#>
				<td>#appdata.routes[heaven]["content-type"]#</td>
			<cfelse>
				<td>-</td>
			</cfif>

			<!--- this is a no-no --->
			<cfif #check_deep_key(appdata, "routes", heaven, "model")#>
				<td>#appdata.routes[heaven]["model"]#</td>
			<cfelse>
				<td>-</td>
			</cfif>

			<!--- this is a no-no --->
			<cfif #check_deep_key(appdata, "routes", heaven, "view")#>
				<td>#appdata.routes[heaven]["view"]#</td>
			<cfelse>
				<td>-</td>
			</cfif>
		</tr>
	</cfloop>
	</table>
	</div>
	</cfoutput>
	</cfsavecontent>
	
	<cfreturn #cms.routeInfo#>
</cffunction>


<cfscript>
function logReport (Required String logstring, Required String message) {
	logstring &= "<li>" & message & "</li>";
}


public Boolean function check_file (Required String mapping, Required String file) {
	if (FileExists(this.Mappings[ToString("/" & mapping)] & file & ".cfm"))
		return 1; 
	return 0;
}
</cfscript>

<!---
/*Get the database columns*/
public String function get_column_names (Required String table, String db) {
	d = new dbinfo(datasource = data.source, dbname = "tooty", table = table);
writedump(d);
	for (x = 1; x LTE d.recordCount; x++ ) {
		writeoutput("<li>" & x & "</li>");
	}
abort;
}
--->


<cffunction returnType="String" name="get_column_names">
	<cfargument
		name="table"
		required="yes"
		type="String">

	<cfargument
		name="dbname"
		required="no"
		type="numeric">

	<!--- All of this crap needs to be split out somewhere. --->
	<cfset fake_name = #randstr(5)#>

	<cfdbinfo datasource="#data.source#" type="columns" name="cn" table="#table#">

	<cfparam name="noop" default="">
	<cfset noop="">

	<cfloop query="cn">
		<cfset noop &= "#cn.column_name#,">
	</cfloop>

	<cfreturn noop>	
</cffunction>

<cfscript>

/*Add fields to a query very easily*/
function setQueryField (
	Required Query query, Required String columnName, 
	Required Any fillValue, String columnType) {
	type=(!StructKeyExists(Arguments, "columnType")) ? "varchar" : Arguments.columnType;
	QueryAddColumn(query, columnName, type, ArrayNew(1));

	/*Add callback support in fillValue...*/
	for (i=1; i <= query.recordCount; i++)
		QuerySetCell(query, columnName, fillValue, i);
}


/*A function to get random letters.*/
public String function randstr (n) {
	// make an array instead, and join it...
	str="abcdefghijklmnoqrstuvwxyzABCDEFGHIJKLMNOQRSTUVWXYZ0123456789";
	tr="";
	for (x=1;x<n+1;x++)
		tr = tr & Mid(str, RandRange(1, len(str) - 1), 1);
	return tr;
}


public String function randnum (n) {
	// make an array instead, and join it...
	str="0123456789";
	tr="";
	for (x=1;x<n+1;x++)
		tr = tr & Mid(str, RandRange(1, len(str) - 1), 1);
	return tr;
}


/* ----------------------------------------------- *
 * ----------------------------------------------- */
function make_index (ColdMVC ColdMVCInstance) {
	//Catch log errors with this.
	l="";

	//Hackarific dot com
	variables.coldmvc = ColdMVCInstance;
	variables.model   = StructNew();
	variables.data    = ColdMVCInstance.app;
	variables.db      = ColdMVCInstance.app.data;
	
	//Find the right resource.
	try {
		logReport(l, "Evaluating URL route");
		resource_name = resourceIndex(name=cgi.script_name, ResourceList=appdata);

		//Send a 404 page and be done if this resource was not found.
		if (resource_name eq "0") {
			render_page(status=404, errorMsg=ToString("Page not found."));
			abort;
		}

		//Load CSS, Javascript and maybe some other stuff once at the beginning
		assets = DeserializeJSON('{
			"js": "\t<script type=text/javascript src=MAGIC></script>\n",
			"css": "\t<link rel=stylesheet type=text/css href=MAGIC />\n"
		}'); 

		for (key in assets) {
			if (StructKeyExists(appdata, key) && ArrayLen(appdata[key]) > 0) {
				appdata[ToString("rendered_" & key)] = "";
				for (i=1; i<=ArrayLen(appdata[key]); i++) {
					ren = (Left(appdata[key][i], 1) == '/') ? appdata.base & appdata[key][i] : appdata[key][i];
					appdata[ToString("rendered_" & key)] &= Replace(assets[key], "MAGIC", ren);
				}
			}
		}
		logReport(l, "Success");
	}
	catch (any e) {
		render_page(status=500, errorMsg=ToString("Locating resource mapping failed"), stackTrace=e);
		abort;
	}


	// Evaluate the resource or die trying.
	try {
		logReport(l, "Evaluating URL resource");
		addlError = "";

		//Find an alternate route model first.
		if (check_deep_key(appdata, "routes", resource_name, "model")) { 
			writeoutput("Evaluate alternative mapped to route name.");
			addlError = "The file titled '" & appdata.routes[resource_name].model & ".cfm' does not exist in app/";
			include ToString("/app/" & appdata.routes[resource_name].model & ".cfm"); 
		}

			
	//	else if (StructKeyExists(appdata, "routes")) {
		else if (check_deep_key(appdata, "routes", resource_name) && StructIsEmpty(appdata.routes[resource_name])) {
			writeoutput("Evaluate route name.");
			addlError = "The file titled '" & resource_name & ".cfm' does not exist in app/.";
			include ToString("/app/" & resource_name & ".cfm"); 
		}
		
		else {
			//writeoutput("Evaluate default.");
			//Check that coldmvc.default has been defined
			if (structKeyExists(this, "default")) {
				writeoutput("Evaluating this.default().");
				this.default();
			}
			else if (check_file("app", "default"))	{
				writeoutput("Evaluating app/default.cfm.");
				include ToString("/app/" & 'default.cfm');
			}
			else {
				render_page(status=500, errorMsg="<p>One of two situations have happened.  Either a:</p><li>default.cfm file was not found in <dir>/app</li><li>or the function 'application.default' is not defined.</li>" );
				abort;
			}
		}
		logReport(l, "Success");
	}
	catch (any e) {
		//Manually wrap the error template here.
		render_page(status=500, errorAddl=addlError, errorMsg=ToString("Error at controller page."), stackTrace=e);
		abort;
	}

	//Then parse the template
	try {
		logReport(l, "Evaluating view for resource");
		
		//Save content to make it easier to serve alternate mimetypes.
		savecontent variable="cms.content" {
			//Check if something called view exists first	 
			if (check_deep_key(appdata, "routes", resource_name, "view")) {
				writeoutput("Loading alternative view '" & appdata.routes[resource_name].view & "' mapped to route name.");
				include ToString("/views/" & appdata.routes[resource_name].view & ".cfm"); 
			}
			else if (check_deep_key(appdata, "routes", resource_name) && StructIsEmpty(appdata.routes[resource_name])) {
				writeoutput("Load view with same name as route.");
				include ToString("/views/" & resource_name & ".cfm"); 
			}
			//Then check if it's blank, and load itself
			else {
				writeoutput("Load default route.");
				include "/views/default.cfm"; 
			}
		}
		logReport(l, "Success");
		render_page(content=cms.content, errorMsg="none");
	}
	catch (any e) {
		render_page(status=500, errorMsg=ToString("Error in parsing view."), stackTrace=e);
	}
}
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
	structInsert(myRes, 0, "status");
	structInsert(myRes, "Error occurred in file " & e.template & ", line " & e.line & ".", "error");
	structInsert(myRes, e.stackTrace, "StackTrace");
	return myRes;
}


/*Find the index of a resource if it exists.  Return 0 if it does not.*/
public String function resourceIndex (String name, Struct ResourceList) {
	//Create an array of the current routes.
	if (!structKeyExists(ResourceList, "routes"))
		return "default";

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
	return ToString(0);
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


/*
function onApplicationStart() {
	if (!FileExists(this.jsonManifest)) {
		application.cms = {};
		application.data = {};
		//application.path = cgi.path_info;
		application.load = load;

		//Until I get this running as a component, I have to do this...
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
}*/



/*...
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
			writedump(e);
		}
	}
}*/


/*Initialize some stuff*/
public ColdMVC function init (Struct appscope) {
	//Catch log errors with this.
	l="";
	//Load JSON manifest with route information.
	try {
		logReport(l, "Loading JSON file");
		jsonMfst = FileRead(getDirectoryFromPath(getCurrentTemplatePath()) & "data.json");
		logReport(l, "Success");
	}
	catch (any e) {
		render_page(status=500, errorMsg="Error reading data.json");
		abort;
	}


	//Parse JSON manifest with route information.
	try {
		logReport(l, "Parsing JSON file");
		appdata=DeserializeJSON(jsonMfst);
		logReport(l, "Success");
	}
	catch (any e) {
		render_page(status=500, errorMsg=ToString("Deserializing data.json failed"), stackTrace=e);
		abort;
	}

	//Check that JSON manifest contains everything necessary.


	//writedump(appscope);
	/*appscope.root_dir = getDirectoryFromPath(getCurrentTemplatePath());
	mappings = [ "app", "assets", "bindata", "db", "files", "sql", "std", "views" ];

	if (!StructKeyExists(appscope, "Mappings"))
		appscope["Mappings"] = StructNew();

	//StructInsert(appscope, "/", appscope.root_dir & "/");
	for ( x=1; x<ArrayLen(mappings); x++ )
		StructInsert(appscope.mappings, ToString("/" & mappings[x]),
			ToString(appscope.root_dir & mappings[x] & "/"));*/

	//this.location =  
//writedump(this);
//abort;
	this.app = appdata;	
	return this;
}

</cfscript>

</cfcomponent>
