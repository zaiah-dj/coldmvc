<h2>ColdMVC</h2>

Summary
-------
<p>
ColdMVC is a simple framework for ColdFusion and Lucee application servers.   It is supposed to facilitate an MVC model within ColdFusion applications and make it a bit easier to enforce "seperation of concerns".
</p>


Caveats
-------
<p>
Running on Windows is not fun or easy right now and will involve a lot of manual work. OSX has not been tested yet.  Linux users can clone this repository and run the script titled coldmvc.sh to get started.   
</p>
 

Setting up New Projects
-----------------------
<p>
New projects can be setup using a command similar to the following.
<pre>
./coldmvc.sh -c /path/to/coldfusion/webroot -t '/approot'
</pre>
</p>

<p>
'/approot' refers to a directory underneath your ColdFusion or Lucee webroot.   The directory does not need to exist as ColdMVC will create it for you.  After the command runs successfully, you can access the new application at:
<a>http://localhost:<your ColdFusion / Lucee port number>/approot</a>
</p>

How Does This Work?
-------------------
<p>
More complete documentation on how to get ColdMVC up and running will be coming soon.  I am working hard to get a more stable distribution method underway, so please be patient!
</p>

<!--
How Does This Work?
-------------------
<p>
ColdMVC uses one file for it's configuration.  So learning the in's and out's of the file titled 'data.json' will help you get much faster at building apps to do what you want.
</p>

<p>
After a project is successfully created, a data.json file will be at the root of your application.  Within this file is your app's routing table, a default datasource, and the name of the app (which is used as the default HTML title).  An example is shown below: 
</p>

<pre>
{
	"datasource": "CMSCopy",
	"home":       "http://localhost:8300",
	"base":       "/cms7",
	"name":       "TestApp",
	"routes":     {
		"approve":  { "page": "index", "data": "jordans" },
		"edit":     { "page": "index", "data": "jordans" },
		"flag":     { "page": "index", "data": "jordans" },
		"history":  { "page": "index", "data": "jordans", "content-type": "application/xml" },
		"version":  { "page": "index", "data": "jordans", "content-type": "text/html" }
	}
}
</pre>

<p>
Routes can be interpreted one of four ways:

If routes is an array, then names in quotations with no colons are resources that rely on the defaults.

routes have:
<table>
	<tr>
		<td>data</td>
		<td>Name of a .cfm file in app that will be used to generate the page's data.</td>
	</tr>
	<tr>
		<td>page</td>
		<td>Name of view that will be used when interpreting the page.</td>
	</tr>
	<tr>
		<td>content-type</td>
		<td>The Mime Type that should be used when this page finishes creating the content of the request.
	</tr>
</table>
</p>

<p>
If a route has a blank object, then the default view and data file will be used to create content for that route.

So, for example, the routing table with the name 'zaza':
"routes": {
	"zaza": {}
	...
}

will use default.cfm in app/ to create logic.  And use default.cfm in views/ to create views of the data.
</p>
-->
