<html>
<cfoutput>
	<head>
	<link rel=stylesheet href=/assets/5xx-view.css type=text/css>
	<style type=text/css>
	</style>
	</head>

	<body>
	<h2>#status_code#</h2>
	<h3>#status_message#</h3>
		<p>#errorMsg#</p>
	<cfif isDefined("errorLong")>
		<p>#errorLong#</p>
	</cfif>
	<cfif isDefined("exception")>
		<cfdump var=#exception#>
	</cfif>
	</body>
</cfoutput>
</html>
