<html>
<cfoutput>

<head>
	<link rel="stylesheet" type="text/css" href="#link( 'assets/default.css' )#">
</head>

<body>

	<div class="container">
		<div class="container-section">
			<h1>#model.greeting#</h1>
		</div>
		<div class="container-section container-less container-light-line center">
			<p>And welcome to ColdMVC, an MVC web framework for sites driven by CFML</p>
		</div>

		<a class="gets" href="##gets">More</a>
	</div>

	<div class="other-container">
		<div id="gets" class="container-section">
			<p>You are currently looking at an example web page, meaning that ColdMVC was able to deploy your site correctly.</p>
			<p>To get rid of this page type the following in your terminal:
				<pre>coldmvc --finalize /this/directory</pre>
			</p>
		</div>

		<div class="container-section container-dark-line">
			<p>
				If you're new here, check out some of these resources to get up to speed:
			<ul>
				<li><a href="http://ramarcollins.com/coldmvc">Quick-start Tutorial</a></li>
				<li><a href="http://ramarcollins.com/coldmvc##reference">Reference</a></li>
				<li><a href="http://ramarcollins.com/coldmvc##examples">Examples</a></li>
			</ul>
			</p>
		</div>

		<div class="container-section container-dark-line">
			<p>Happy coding!</p>
		</div>
	</div>

</body>
</cfoutput>
</html>
