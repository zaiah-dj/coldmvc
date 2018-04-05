<cfset resultCount=30>
<cfquery name="logQuery" datasource="#data.source#">
SELECT 
	TOP #resultCount#
	*
FROM
	ac_mtr_serverlog
ORDER BY 
	sl_accesstime DESC	
</cfquery>
