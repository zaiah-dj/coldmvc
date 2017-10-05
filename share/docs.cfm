<!---
docs.cfm

@author
	Antonio R. Collins II (ramar.collins@gmail.com)
@end

@copyright
	Copyright 2016-Present, "Deep909, LLC"
	Original Author Date: Tue Jul 26 07:26:29 2016 -0400
@end

@summary
	A documentation page that will probably just sit in the middle of the site.
	Unsure if this should be dynamic or not...
@end
  --->
  
<html>
<head>
<title>FERPA Documentation</title>
<style type="text/css">
h1, h2, h3 , h4 ,h5, h6 {font-family: Helvetica;}
html {font-size: 1.2em;}
body { width: 70%; min-width: 300px; margin: 0 auto; }
li.done {text-decoration: strikethrough;}
pre { font-size: 0.9em; }
td.key-required { font-weight: bold; font-size: 0.9em; }
td.key-type { font-style: italic; font-size: 0.9em; }
th { text-align: left; background-color: #ccc; }
p.note { background-color: pink; padding: 10; font-weight: bold; }
ul.toc li { text-transform: capitalize; }
p { margin-bottom: 20; }
</style>
</head>



<body>



<h1>FERPA</h1>

<h2>Table of Contents</h2>
<ul class="toc">
	<li><a href="#summary">Summary</a></li>
	<li><a href="#tasks">To Do</a></li>
	<li>
		<a href="#whirl">whirlwind Guide to ColdMVC</a>
		<ul>
			<li><a href="#routing">routing</a></li>
			<li><a href="#models">models</a></li>
			<li><a href="#views">views</a></li>
			<li><a href="#request">request</a></li>
			<li><a href="#background">background</a></li>
		</ul>
	</li>
</ul>

<h2 id="summary">Summary</h2>
<p>
Here in lies the FERPA form.  
This allows students to approve third-party access to their records. 
To use/test the form, go to <a href="http://nccu.edu/ferpa">http://nccu.edu/ferpa</a>.
To use/test the admin interface, go to <a href="http://nccu.edu/ferpa/admin.cfm">http://nccu.edu/ferpa/admin.cfm</a>.
</p>




<h2 id="tasks">To Do</h2>
<p>
The only loose ends of this project are:
<ul>
	<li>
	The ability to recall old data
	</li>

	<li>
	revoke all 
		<ul>
		<li><s>an extra checkbox to pull all that stuff away</s></li>
		<li>add the logic to process this</li>
		</ul>
	</li>

	<li>
	Add a 'delete' option for new requestors
		Delete something or other...
	</li>

	<li>
	Upload the page to Office of the Registrar
	</li>

	<li>
	* BDM send off
	</li>

	<li>
		Checkbox in Banner to indicate that a user has done FERPA
	</li>
</ul>
</p>


<h2 id="whirl">Whirlwind Guide to ColdMVC</h2>

<p>
ColdMVC applications run from a single entry point.  In this case, that entry point is index.cfm.  index.cfm initializes ColdMVC, loads and parses 'data.json', and serves web pages upon receiving requests.  A modified Application.cfc allows ColdMVC to sit in between ColdFusion's request lifecycle and receive all requests before they are processed.
</p>

<p>
Let's start with the following code for an example:
<pre>
{
  "source":     "WebDB",
  "cookie":     "mien_cookie",
  "base":       "/ferpa/",
  "Home":       "tmp",
  "name":       "Ferpa",
  "title":      "FERPA (Family Educational Rights and Privacy Act )",
  "debug":      1,
  "master-post":false,
  "settings":   {
    "verboseLog": 0,
    "PdfDir":    "files",
    "addLogLine": 0
  },
  "db": {
    "main":   "WebDB",
    "banner": "banner-prod"
  },
  "data":       {
    "posts":     "post",
    "content":   "content",
    "class_rel": "class_rel",
    "metadata":  "metadata",
    "users":     "users"
  },
  "css":        [
    "zero", 
    "gallery", 
    "https://unpkg.com/purecss@0.6.2/build/pure-min"
  ],
  "js":         [ 
    "lib", 
    "index" 
  ],
  "routes":     {
    "default":    { 
      "model": [ "log", "default" ], 
      "view": [ "main/head", "default", "main/footer" ] },

    "multi":      { 
      "hint":   "Generates multiple PDFs for a student writing all PDFs to a folder and zipping it.",
      "model":  [ "log", "check", "view", "multi" ], 
      "view": [ "pdf/multi", "pdf/confirmation-multi" ] },

    "pdf":        { 
      "hint":   "Generates a PDF for a student by aggregating all of the users who have requested student information.",
      "model":  [ "log", "check", "view", "pdf" ], 
      "view": [ "pdf/write", "pdf/confirmation" ] },
  }
}
</pre>
</p>

<p>
The code that you see above would be placed into a file called data.json.  ColdMVC will parse this file and serve your application based on the parameters found within.  A table of what each of these do is below.
</p>

<table>
	<thead>
		<th>Key Name</th>
		<th>Key Type</th>
		<th>Required?</th>
		<th>Key Description</th>
	</thead>

	<tbody>
	<tr>
		<td>source</td>
		<td class="key-type">String</td>
		<td class="key-required">No</td>
		<td class="key-description">bla</td>
	</tr>

	<tr>
		<td>cookie</td>
		<td class="key-type">String</td>
		<td class="key-required">No</td>
		<td class="key-description">The name of the cookie that ColdFusion uses when storing persistent data on the server (this is automatically generated most of the time and isn't really need</td>
	</tr>

	<tr>
		<td>base</td>
		<td class="key-type">String</td>
		<td class="key-required">Yes</td>
		<td class="key-description">
			The web root of the current application relative to the server's web root.
			<br />
		</td>
	</tr>

	<tr>
		<td>Home</td>
		<td class="key-type">String</td>
		<td class="key-required">No</td>
		<td class="key-description">Unused / Deprecated</td>
	</tr>

	<tr>
		<td>name</td>
		<td class="key-type">String</td>
		<td class="key-required">Yes</td>
		<td class="key-description">A symbolic name for your application</td>
	</tr>

	<tr>
		<td>title</td>
		<td class="key-type">String</td>
		<td class="key-required">Yes</td>
		<td class="key-description">The global title of the application.  All the &lt;title&gt; tags will use this text.</td>
	</tr>

	<tr>
		<td>debug</td>
		<td class="key-type">Numeric</td>
		<td class="key-required">No</td>
		<td class="key-description">An integer (but really a boolean) defining whether or not to display debug data.</td>
	</tr>

	<tr>
		<td>master-post</td>
		<td class="key-type">Boolean</td>
		<td class="key-required">No</td>
		<td class="key-description">Defines whether or not ColdFusion should run a function called 'post' after the webpage content is generated.</td>
	</tr>

	<tr>
		<td>settings</td>
		<td class="key-type">Object</td>
		<td class="key-required">No</td>
		<td class="key-description">A JSON object of keys that control ColdMVC</td>
	</tr>

	<tr>
		<td>db</td>
		<td class="key-type">Object</td>
		<td class="key-required">No</td>
		<td class="key-description">A JSON object of keys that serve as symbolic names for the application's databases</td>
	</tr>

	<tr>
		<td>data</td>
		<td class="key-type">Object</td>
		<td class="key-required">No</td>
		<td class="key-description">A JSON object of keys that serve as symbolic for the application's database tables</td>
	</tr>

	<tr>
		<td>css</td>
		<td class="key-type">Array</td>
		<td class="key-required">No</td>
		<td class="key-description">An array specifying global styles that should be accessible from every page</td>
	</tr>

	<tr>
		<td>js</td>
		<td class="key-type">Array</td>
		<td class="key-required">No</td>
		<td class="key-description">An array specifying global Javascript files that should be accessible from every page</td>
	</tr>

	<tr>
		<td>routes</td>
		<td class="key-type">Object</td>
		<td class="key-required">Yes</td>
		<td class="key-description">A JSON object of keys defining how routes should be handled by the application.  This can get complex, so there is more documentation located <a href="#routes">here</a></td>
	</tr>
	</tbody>
</table>

<p>

</p>

<h2 id="routing">Routing</h2>
<p>
When users type an address into the address bar to retrieve a webpage (like 'http://www.google.com' or something), the browser sends that data to a server via DNS and brings back data in the form of a webpage.  ColdMVC only handles the webpage generation, but to do so it has to handle requests.  We'll use the 'routes' portion from the JSON code displayed earlier to describe how ColdMVC does it's thing.

<pre>
"routes":     {
  "default":    { 
    "model": "default", 
    "view": [ "main/head", "default", "main/footer" ] },

  "multi":      { 
    "hint":   "Generates multiple PDFs for a student writing all PDFs to a folder and zipping it.",
    "model":  [ "log", "check", "view", "multi" ], 
    "view": [ "pdf/multi", "pdf/confirmation-multi" ] },

  "pdf":        { 
    "hint":   "Generates a PDF for a student by aggregating all of the users who have requested student information.",
    "model":  [ "log", "check", "view", "pdf" ], 
    "view": [ "pdf/write", "pdf/confirmation" ] },
}
</pre>
</p>

<p>
Each key in the object above has a specific purpose and defines how ColdMVC will act when receiving a particular web request.  In the above case, the key 'default' will handle each request for the application's web root ( or '/' ).   In other words, if I used ColDMVC to maintain a site named 'junktionone.com' and typed 'junktionone.com' into my address bar, I would tell ColdMVC to give me the route specified by 'default'.    
</p>

<p>
Any key not titled 'default' will handle a request for a specific page.   So, using the above we see that 'multi' and 'pdf' are two endpoints that the application expects to receive.   If we use the site 'junktionone.com' again, and make a request for 'junktionone.com/multi.cfm', we will tell ColdMVC to give the route content specified by 'multi'.  If you should specify a route that is not in this object, then you will receive a 404 page.
</p>

<p>
Notice that each key ( "default", "multi" and "pdf" ) in the object above has a value that is also an object. This nested object describes how ColdFusion should go about putting together your page.   
</p>

<p>
Below is a table describing the possible keys in more succinct detail:
<table>
	<thead>
		<th>Key Name</th>
		<th>Key Type</th>
		<th>Required?</th>
		<th>Key Description</th>
	</thead>

	<tbody>
	<tr>
		<td>model</td>
		<td class="key-type">String/Array</td>
		<td class="key-required">Yes</td>
		<td class="key-description">A string or array specifying which CFML files to run when receiving a request for a particular key</td>
	</tr>
	<tr>
		<td>view</td>
		<td class="key-type">String/Array</td>
		<td class="key-required">No</td>
		<td class="key-description">An array specifying global Javascript files that should be accessible from every page</td>
	</tr>
	<tr>
		<td>hint</td>
		<td class="key-type">String</td>
		<td class="key-required">No</td>
		<td class="key-description">An array specifying global Javascript files that should be accessible from every page</td>
	</tr>
	<tr>
		<td>content-type</td>
		<td class="key-type">String</td>
		<td class="key-required">No</td>
		<td class="key-description">An array specifying global Javascript files that should be accessible from every page</td>
	</tr>
	</tbody>
</table>
</p>


<h2 id="models">Models</h2>
<p>
The key 'model' can be either a string or an array defining which files to execute in the 'app/' folder when receiving a request for a certain route.  
</p>

<p>
So assuming that a user requests 'junktionone.com' again, we can see that ColdFusion will execute files titled 'default.cfm' in the app directory.   
<p class="note">
NOTE: Notice how the full filename 'default.cfm' is not specified.  ColdMVC knows that you are looking for a .cfm file, so it will not require that the extension be used when crafting the route handler.
<p>

<pre>
</pre>
</p>


<h2 id="views">Views</h2>
<p>
The key 'views' can be either a string or an array defining which files to include in the 'views/' folder when receiving a request for a certain route.  Let's use our 'junktionone.com' example again.  Notice that the "views" key is mated to an Array value.  So for each of the strings in the array, ColdFusion will look for a file in the view directory with that string as its name.   Here's a crudely drawn image that says the same thing:
<pre>
</pre>

</p>


<h2 id="request">Request Lifecycle As Seen by ColdMVC</h2>
<p>
The request lifecycle for ColdMVC starts at ColdFusion's onRequest() method in Application.cfc.  When the user asks for a particular route (let's just say http://mysite.com/multi.cfm), ColdMVC will check the 'app' folder for any model files that need to be executed and it will check the 'views' folder for any view files that are needed.  If <i>any</i> error is encountered, ColdFusion will stop, throw an exception and send a 500 Internal Server Error page back to the client (read "you", if you are developing a new applcation). 

<pre>
User asked for:
[ http://junktionone.com/multi.cfm ]
   |
   |
   V

ColdMVC receives a GET request for '/multi.cfm'
  
- Checks to see if 'multi' exists in data.json's routes object:

  - Is it there?

    NO +   
       |
       +-------------------- > Serve a 404 page and stop.
    
    YES   
       |
       |
       V

- Check "app/" folder for all "model" files.

    Are the model files error-free?
    
    NO +   
       |
       +-------------------- > Serve a 500 Internal Server Error page and stop.
    
    YES   
       |
       |
       V

- Check "views/" folder for all "view" files.

    Are the view files error-free?

    NO +   
       |
       +-------------------- > Serve a 500 Internal Server Error page and stop.
    
    YES   
       |
       |
       V

- Did the developer specify 'master-post: true' in data.json?

    YES+   
       |
       +-------------------- >  Run the function titled 'post' in index.cfm.
                                If errors were encountered stop and serve a 500 page.
                                If not, keep going...

    NO +                                        |
       |                                        |
       |                                        |
       V                                        V
  
- Did the developer specify a different content type via the content-type key in data.json's routes?
    
    YES+   
       |
       +-------------------- >  Before sending the response to the client, 
                                add 'Content-Type: {{ requested-mimetype }}' to the headers.
                                This way audio files, video files and other types of files 
                                will not be interpreted as HTML files by the client browser.

    NO +   
       |
       +-------------------- >  Serve the page content as regular 'text/html' and give it
                                to the client.

</pre>



<h2 id="background">How and Why This Works The Way it Does</h2>
<p>
The <a href="https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller">'Model-View-Controller'</a> 
design pattern is a stable, time-tested method for writing applications -- be it for the desktop, the web or mobile phones.  When executed well, an application's business logic is seperate from it's styling which helps maintenance and usually speeds up the development process.   Things that should stay out of the way, do that.   Things that you need to focus on, regardless of your role in the project, should be clear and easy to modify.  With the exception of Fw/1 and ColdBox, ColdFusion lacks a way to do this easily.  So this project was born. 
</p>

<p>
So long as the directory structure exists, there are no hard and fast rules to use when designing applications with ColdMVC.  The app folder can contain "view" information (raw HTML and so forth) and application logic can sit within the views directory.  However, it is advisable to seperate the two when you can to keep things clean and organized.   With the exception of looping, a well-written view should try to keep as much business logic out of the code as possible.
</p>

<p>
An example app that sticks to the structure looks something like:
<pre>
&lt;!---
app/juice.cfm
-------------

Notice how there is no formatting code here.  Just queries and programmin'!
---&gt;

</pre>

<pre>
&lt;!---
views/juice.cfm
----------------

Notice how there is very little application code here.  
There is mostly HTML with the exception of the cfloop call. 
---&gt;
</pre>
</p>


</body>
</html>
