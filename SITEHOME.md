<head>
	<link href="https://fonts.googleapis.com/css?family=Fugaz+One|Homemade+Apple|Muli|Nixie+One|Shrikhand" rel="stylesheet">
	<meta name="" content=""></meta>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"></meta>
	<script src="/coldmvc/assets/index.js"></script> 
	<link href="/coldmvc/assets/md-blue.css" rel="stylesheet">
</head>



<body>

<div class="top">
<!-- <div id="open" class="top-data"> -->

## ColdMVC

ColdMVC is a Lucee/ColdFusion based web framework that employs the use of the Model - View - Controller paradigm.  It is very light on space and is capable of serving a CFML application in a small footprint.  It is easily configurable, very simple and very unrestrictive.

[Download](#download)	
[Docs](#docs)	
[Examples](#examples)	
		
</div>


<div id="fixed-header" class="fixed-header">
[Download](#download)	
[Docs](#docs)	
[Examples](#examples)	
</div>




<div class="container">


# Download

<div id="download">
	<div class="flexload">
		<div class="half ph">
			<a class="half-link" href="https://github.com/zaiah-dj/coldmvc/archive/master.zip">Current Version</a>
		</div>
		<div class="half gh">
			<a class="half-link" href="https://github.com/zaiah-dj/coldmvc">Github</a>
		</div>
	</div>
</div>




# Walkthrough

...




# Docs

## Table of Contents

- [Setup](#_Setup)
- [Structure](#_Structure)
- [Errors](#_Errors)
- [Configuration](#_Configuration)
- [Database](#_Database)
- [ORM](#_Orm)
- [Conclusion](#_Conclusion)



## Setup <a name=#_Setup></a>
	
To setup ColdMVC, you'll need a copy of either <a href="http://lucee.org/downloads.html">Lucee</a> or <a href="/">Adobe ColdFusion</a>.  The former is free if you're just looking to get your feet wet, while the latter has features like API builder and other custom proprietary extensions that should make your life easier.

	
## Structure<a name=#_Structure></a>

Below is a structure of a beginning ColdMVC application.

<pre>
/webroot
	Application.cfc
	coldmvc.cfc
	data.json
	index.cfm
	index.html
	index.js
	Makefile
	README.md
	TODO

	app/
		( model files / backend logic )

	assets/
		( css, javascripts, pictures, logos, etc )

	files/
		( uploaded files )

	setup/
		( setup files (like orm properties, sql statements ))

	sql/
		( sql files ) 

	std/
		( standard templates )

	views/
		( view files )
</pre>



<h3>app</h3>
<p class="subheading">
All of your application's models (the "M" in MVC) go here.  You can write all of 
your business logic here and be done.  You can write these with either CFML or
cfscript. However, no output will show here.   Using the debug key in the data.json
will stop execution and allow you to see the data output by the model.
</p>


<h3>assets</h3>
<p class="subheading">
All of your application's models (the "M" in MVC) go here.  You can write all of 
your business logic here and be done.
</p>


<h3>files</h3>
<p class="subheading">
Users' uploaded files go here.  
This can be changed by modifying the files key in data.json.
</p>


<h3>setup</h3>
<p class="subheading">
Any pre-production tasks run from here. 
</p>


<h3>sql</h3>
<p class="subheading">
All SQL files work this way.
</p>


<h3>std</h3>
<p class="subheading">
ColdMVC's built-in templates.
</p>


<h3>views</h3>
<p class="subheading">
All of your application's views (the "V" in MVC) go here.   Since these are just CFML files, 
and there are no limitations to what you put in here. 
</p>



## Errors<a name=#_Errors></a>

Errors in your code will cause your code to fail and throw an exception.
There are two templates to control the look of these messages.



## Configuration<a name=#_Configuration></a>

All of ColdMVC's configuration is done through a .cfm file at the web root.
Whenever running apps with ColdMVC, data.cfm is expected to be present.
If the file either doesn't exist or can't be processed, an exception will be thrown.



## Database<a name=#_Database></a>

A function called dbExec is used to wrap pretty much everything.   
cfquery and regular query syntax aren't disabled.

<pre>
</pre>


## ORM<a name=#_Orm></a>


## Conclusion<a name=#_Conclusion></a>





	</div>
	
	<div class="break" id="_data.json">
		<h2>Configuration</h2>
		<p>
Here is an example file:
</p>

<pre>
{
  "source":     "mobross_db",
  "base":       "/coldmvc.com/",
  "cookie":     "mien_cookie",
  "Home":       "tmp",
  "name":       "Splat DB (Draft for Site Builder)",
  "title":      "Site Builder Draft",
  "debug":      1,
  "settings":   {
  }, 
  "data":       {
    "posts":   "post",
    "content": "content",
    "types":   "content_types"
  },
  "css":        [ 
    "zero", 
    "https://unpkg.com/purecss@0.6.2/build/pure-min", 
    "gallery"  
  ],
  "js":         [ "lib", "index" ],
  "routes":     {
    "pts": { "model": "pts", "view": "pts" },
    "admin": { "model": "admin", "view": "admin" },
    "admin-list": { "model": "admin-list", "view": "admin" },
    "admin-settings": { "model": "admin-settings", "view": "admin" },
    "admin-new": { "model": "admin-new", "view": "admin" },
    "admin-save": { "model": "admin-save", "view": "admin" },
    "admin-edit": { "model": "admin", "view": "admin" },
    "debug": { "view": "debug" },
    "words": { "model": "default", "view": "thin" },
    "tracks": { "model": "default", "view": "thin" },
    "booking": { "model": "booking", "view": "booking" }
  }
}
</pre>

<p>
Note: ColdFusion/Lucee currently do not ship with a module that makes JSON parsing more tolerant (so comments and unquoted keys will not work w/o the engine throwing up).  A better solution should be shipping soon.
</p>

<p>

<table>

	<tr>
		<th class="key">Key</th>
		<th class="type">Type</th>
		<th class="value">Value</th>
	</tr>

	<tr>
		<td class="key">source</td>
		<td class="type">string</td>
		<td class="value">Datasource Name</td>
	</tr>

</table>

</p>

	</div>
	
	<div class="break" id="_database">
		<h2>Database</h2>
		<p>

Databases are wonderful and mostly great.


ColdMVC allows you to define datasources from, yep, you guessed it, data.json.


If the datasource does not exist, this will create it.

</p>


<p>
Besides the regular cfquery, there are no special rules to using databases
within ColdMVC.   However, the framework ships with a function to make working 
with queries a bit cleaner.
</p>

<p>
Referring back to the <a href="#_structure">folder structure</a> diagram, you'll
notice that there is a folder titled 'sql'.   This folder contains all SQL statements.
You can write them without including the cfquery tag. <span class="vapor">
If you want the framework to automatically run the query when a particular route
is served, name a folder the same as the route and keep the query file in there.
This can be further controlled by placing two additional folders within the sql
folder, titled 'before' and 'after'.  Query files placed in the 'before' folder
will be run before the model is evaluated, those placed in 'after' are run after the
model is evaluated.
</span>
</p>



	</div>
	
	<div class="break" id="_orm">
		<h2>ORM</h2>
		<p class="vapor">

ORM is currently not supported, but this will change in the near future.

</p>

	</div>
	
	<div class="break" id="_conclusion">
		<h2>Conclusion</h2>
		<p>
Oh, wow!  You're still here!   GREAT!
Now you can start making some real apps.
</p>

	</div>
	


	<div id="examples">
		<h1>Examples</h1>
		<ul>
			<li>
				<h3>Blogging Engine</h3>

				<p>
				An example blogging engine.  Try adding images, text, links and other items.   ColdMVC makes this nearly painless.
				</p>
			
				<p>
				See it on Github at <a href="https://github.com/zaiah-dj/coldmvc-blog">https://github.com/zaiah-dj/coldmvc-blog</a>.
				<br />
				<br />
				Clone it with:
				<pre style="margin-top: -20">git clone https://github.com/zaiah-dj/coldmvc-blog.git</pre>
				</p>
	
			</li>
			<li> 
				<h3>Memdrum</h3>
				<p>
				Memdrum is an HTML5 Simon-like matching game.  The idea is to listen to a sequence and play it back to the backdrop of music.   The Javascript really makes the project possible, but ColdMVC can still do some of the heavy lifting when it comes to routing and sending JSON back and forth.
				</p>
				<p>
				See it on Github at <a href="https://github.com/zaiah-dj/coldmvc-game">https://github.com/zaiah-dj/coldmvc-game</a>.
				<br />
				<br />
				Clone it with:
				<pre style="margin-top: -20">git clone https://github.com/zaiah-dj/coldmvc-game.git</pre>
				</p>
			</li>
		</ul>
	</div>

</div>

</body>


</html>


		
		

	


