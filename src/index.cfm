<!--------------------------------------
index.cfm

(Should probably be application.cfc, but
start this for now.)
  -------------------------------------->
<cffunction 
	name="render_page">

	<cfargument
		name="status"
		required="no"
		type="numeric"
		>

	<cfargument
		name="error_block"
		required="no"
		>

	<cfargument
		name="error_addl"
		required="no"
		type="string"
		>

	<!--- If status is something different handle that page. --->
	<cfif isDefined("status")>
		<cfcontent type="text/html">
		<cfif status eq '404'>
			<cfset status_code = status>
			<cfset status_message = "Page Not Found">
			<cfinclude template="/views/4xx-view.cfm">
		<cfelse>
			<cfset status_code = status>
			<cfset status_message = "Error executing page">
			<cfif isDefined("error_addl")>
				<cfset status_addl = "#error_addl#">
			</cfif>
			<cfinclude template="/views/5xx-view.cfm">
		</cfif>

	<cfelse>
		<!--- Now render the page --->
		<cfif #application.check_deep_key(appdata, "routes", resource_name, "content-type")#>
			<cfcontent type="appdata.routes[resource_name]['content-type']">
			<cfoutput>#cms.content#</cfoutput>

		<cfelse>

			<cfcontent type="text/html">
			<cfinclude template="#ToString('/views/' & 'index.cfm')#">
		</cfif>

	</cfif>

</cffunction>

<!--- 
<cfscript>
function render_page ( ) {
	getpagecontext().getcfoutput().clearall();
	return supersweetdata;
}
</cfscript>
--->

<!---
Show all the route information:

page
hint
data
content-type
routes, etc

--->

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
		</tr>
	<cfloop collection=#appdata.routes# item="heaven">
		<tr>
			<td>#heaven#</td>
			<td><a href="#appdata.base#/#heaven#.cfm">#appdata.base#/#heaven#</a></td>

			<!--- this is a no-no --->
			<cfif #application.check_deep_key(appdata, "routes", heaven, "hint")#>
				<td>#appdata.routes[heaven]["hint"]#</td>
			<cfelse>
				<td>none</td>
			</cfif>

			<!--- this is a no-no --->
			<cfif #application.check_deep_key(appdata, "routes", heaven, "content-type")#>
				<td>#appdata.routes[heaven]["content-type"]#</td>
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
jsonMfst = FileRead(getDirectoryFromPath(getCurrentTemplatePath())&"data.json");
appdata=DeserializeJSON(jsonMfst);
resource_name = application.resourceIndex(name=cgi.script_name, ResourceList=appdata);

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

//Evaluate the resource or die trying.
try {
	//Save template output
	if (application.check_deep_key(appdata, "routes", resource_name, "data"))
		//Errors need 500 pages (you need to set that somehow)
		include ToString("/app/" & appdata.routes[resource_name].data & ".cfm"); 
	else {
		//If there is no default, there may be something that can be a default
		//Otherwise, you probably need to handle 404's here
		//if (FileExists("/app/" & resource_name & ".cfm" ))
		try { 
			include ToString("/app/" & resource_name & ".cfm");
		}
		catch (any e) {
			//When would it be smart to fail?
			//If application.default is defined, yay.
			//If not, it's an error
			if (structKeyExists(application, "default"))
				writeoutput("<h2>Error including file.</h2>");
			else
				render_page(status=500, error_block="500 error occurred.", 
					error_addl="<p>One of two situations have happened.  Either a:</p><li>default.cfm file was not found in <dir>/app</li><li>or the function 'application.default' is not defined.</li>" );
			abort;
		}
	}
}
catch (any e) {
	//Manually wrap the error template here.
	savecontent variable="cms.content" {
		//Errors go somewhere
		writeoutput("<h2>Error at controller page.</h2>");
		writedump(e);
	}

	render_page();
	abort;
}


try {
	//Then parse the template
	savecontent variable="cms.content" {
		if (application.check_deep_key(appdata, "routes", resource_name, "page"))
			include ToString("/views/" & appdata.routes[resource_name].page & ".cfm"); 
		else
			include ToString("/views/" & resource_name & ".cfm"); 
	}
}
catch (any e) {
	savecontent variable="cms.content" {
		/*Errors go somewhere*/
		writeoutput("<h2>Error in parsing view.</h2>");
		writedump(e);
	}
}
</cfscript>
<cfoutput>#render_page()#</cfoutput>
