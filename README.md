<h1>ColdMVC</h1>

Summary
-------
<p>
ColdMVC is a web framework for ColdFusion and Lucee application servers.   It is supposed to facilitate development via MVC within ColdFusion applications and make it trivial to enforce "seperation of concerns".  
</p>



Installation
------------
<p>
ColdMVC can be downloaded via its <a href="http://ramarcollins.com/coldmvc">homesite</a> or via Github.  You can clone the latest version by using the following on your system:

<pre>
git clone https://github.com/zaiah-dj/coldmvc.git
</pre>
</p>

<p>
ColdMVC requires either ColdFusion or Lucee to work.  If you are totally new to ColdFusion and/or Lucee, you will want to get a copy and install it on your system.  I would surmise the easiest way to get going is to start with Lucee's express build.
It needs no special rights to run on your system and can be downloaded <a href="http://download.lucee.org/?type=releases">here</a>. 
</p>




Builds On
---------
<p>
ColdMVC is administered via shell script right now, and has been tested on Linux, OSX and Cygwin.   A detailed list of the versions tested follow.   Windows users will need either <a href="https://git-for-windows.github.io">Git Bash</a> or <a href="https://www.cygwin.com">Cygwin</a> to run the tooling at the moment. 
</p>

<ul>
<li>
	Linux
	<ul>
		<li>Debian 8</li>
		<li>Ubuntu 16</li>
		<li>Fedora</li>
	</ul>
</li>
<li>
	OSX	
	<ul>
		<li>Sierra</li>
		<li>High Sierra</li>
	</ul>
</li>
</ul>
 


Setting up New Projects
-----------------------
<p>
New projects can be setup using a command line similar to the the following.
<pre>
./coldmvc.sh -c -f /path/to/coldfusion/webroot/path-of-site -n 'site-name'
</pre>
</p>

<p>
This is the absolute smallest set of options needed to create an instance of a
ColdMVC site on your system. 
</p>

<p>
Notice that you will need to specify the <i>absolute</i> path to where your Lucee or ColdFusion webroot, then append the name of the directory that will hold your web files.  (This will change in the future, do not worry.)  'site-name' is the symbolic name of your site, but will also be used as the title and domain name of the site if those flags are not specified.   After the command runs successfully, you should be able to visit a link that looks like the following (provided you have not changed the Lucee or ColdFusion default port number): 
<a href="http://localhost:8888/site-name">http://localhost:8888/site-name</a>
</p>

<p>
You should see something similar to the following screenshots. 
<img style="margin: 0 auto" src="shots/first-page-400x400.png" />
<img style="margin: 0 auto" src="shots/second-page-400x400.png" />

Or if you were unfortunate, you will see an exception with a big, fat 500 error message.  If something like this occurs, please contact me via ramar dot collins at gmail dot com, and I'll try to help you through the error.
</p>




Additional Documentation
------------------------
Additional documentation can be found via <a href="http://ramarcollins.com/coldmvc">this link</a>
