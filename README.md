Installation on Linux
---------------------


Installation on Cygwin 
----------------------


Installation on Windows
-----------------------


Setting up New Projects
-----------------------
a)
	Use all of these gnarly shell scripts...

b)
	Use a C program (with gnarly Windows extensions)


How Does This Madness Work?
---------------------------
<p>
A default data.json contains all of your application's static information.  It also contains your app's routing table.  An example is shown below: 
</p>

<code>
{
	"datasource": "CMSCopy",
	"home":       "http://localhost:8300",
	"base":       "/cms7",
	"name":       "TestApp",
	"css":         [
		"/assets/css/cms.css",
		"/assets/css/reset.css",
		"/assets/css/responsive-min-479.css",
		"/assets/css/responsive-480-767.css",
		"/assets/css/responsive-768-1023.css",
		"/assets/css/responsive-1024-max.css",
		"/assets/css/test.css"
	],
	"js":          [
		"/assets/js/cms.js",
		"/assets/js/jquery-1.12.3.min.js",
		"/assets/js/mousetrap.min.js",
		"/assets/js/three.min.js"
	],
	"handler":    "get",
	"template":   "frank",
	"fallback":   "failure.cfm",
	"routes":     {
		"approve":  { "page": "index", "data": "jordans" },
		"edit":     { "page": "index", "data": "jordans" },
		"flag":     { "page": "index", "data": "jordans" },
		"history":  { "page": "index", "data": "jordans", "content-type": "application/xml" },
		"version":  { "page": "index", "data": "jordans", "content-type": "text/html" }
	}
}
</code>

<p>
A line-by-line breakdown of this file looks as follows:
	<table>
	<tr>
		<td>datasource</td>
		<td>Name of the data source.</td>
	</tr>
	
	</table>

</p>

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
