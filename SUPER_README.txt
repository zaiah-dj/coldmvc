Research Project
================
	- make topic mandatory
	- labels for publications
	- prioritize names for teams 
	- address page title
	- form field that allows for description
	- consent form is mandatory and can either link to the statement or post it

Policies
========
what do I have to do?	
	- search
	
	x upload student code of conduct OR make a page with it...
	
	- site map generator for this part of the app... 
		(now it's a REALLY good idea to have routes...) / 60min
	
	- check p2's datasources, use xfer.sql to move everything if need be.
	
	- push the new policies app to production today...
		(moving to coldmvc will make life much easier...)

		
	
SQL Server Password
===================
cheddarbob
GKbAt68!#


ColdMVC
=======
create any orm files needed

cms shit
	encode GET ()
	callback for POSTs (how the fuck will this work?  do we wait?)
	oauth
	json decoding (most things that are worth it make this easy...)
	colors from the server
	.ico dynamic file writes
	sql server driver support
	postgres driver support
	imagemagick support (or a simpler library)
	tools are a long list...
	ftp upload and whatnot...

making new instances (on the web)
	make a slice on the fly (parted and other tools exist to help this)
		1) clone it
		2) create a vm, partition, copy files, try boot and die
			*study the boot process closely...

server
	select should work (not gonna be fast without it...)
	virtual host search via sqlite3
	ssl support
	
stress test
	procedurally generate different sized posts
	try that 10K connections
	but really you should be getting 10 MILLION connections (math is fundamental)
	
email lists (somehow)
	implement (or find a library to handle) smtp, pop3, etc.
	styling works the same way
	
form (or data):
	column name (if you must have it)
	sql_type (if you must have it)
	html_length (of an input field)
	html_type (input, textarea, etc)
	default (??? what would be the diff between this and value?)
	value (...)
	id 
	class
	no_label (does not generate a label)
	/*cfc only*/
	not_null
	read_only
	
Cars (I Will Probably Need One for Other Purposes)
==================================================
	https://raleigh.craigslist.org/cto/5717395217.html - $1600
	https://raleigh.craigslist.org/cto/5719054119.html - $2500
	https://raleigh.craigslist.org/cto/5721947839.html - $950
	https://raleigh.craigslist.org/cto/5713444008.html - $1k
	https://raleigh.craigslist.org/cto/5721435504.html - $2750
	https://raleigh.craigslist.org/cto/5705764486.html - $3000 (very high)
	https://raleigh.craigslist.org/cto/5720951615.html - $1000 (96 hombre)
	https://raleigh.craigslist.org/cto/5721068682.html - $1900 (darkness my old friend)
	https://raleigh.craigslist.org/cto/5697202924.html - $2000 (worth a look)
	https://raleigh.craigslist.org/cto/5721034120.html - $1300 (be careful)
	https://raleigh.craigslist.org/cto/5721025990.html - $1200 (also worth a look)
	https://raleigh.craigslist.org/cto/5703497897.html - $2400 (needs to be worked down and be careful b/c it's a dealer...)
	
Fix The Ford - parts
====================
	*throttle body
	clutch
	slave cylinder
	timing belt
	water pump
	tires...
	spark plugs