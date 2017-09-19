<style type="text/css">
.container
{
	margin: 0 auto;
	width: 70%;
	min-width: 300px;
}

.success, .error
{
	padding: 20;
	font-size: 2em;	
	margin: 10;
}

.success {
	background-color: #daf7a6;
}

.error {
	font-size: 1.3em;
	background-color: #fd6452;
}

.info
{
	padding: 20;
	font-size: 1.1em;	
	background-color: #9285e3;
}
</style>

<cfoutput>
<div class="container">
	<div class=success>
		#model.message#
	</div>

	<cfif model.status eq 0>
	<div class="error">
		<span style="text-decoration:underline;">Error Log</span><br/>
    #model.error#
	</div>
	</cfif>

	<div class="info">
		#model.text#
	</div>
</div>
</cfoutput>
