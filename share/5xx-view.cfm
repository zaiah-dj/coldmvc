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
		<cfdump var=#error_block#>
	<cfif isDefined(status_addl)>
		#status_addl#
	</cfif>
	</body>
</cfoutput>
</html>
