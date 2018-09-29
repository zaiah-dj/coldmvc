<style type="text/css">
html { font-family: "lucida console"; } 
table { font-size: 0.8em; }
table tr td { border: 1px solid black; }
table th { text-align: left; }
table tr:nth-child(even) {background-color: #aaa;}
</style>

<meta http-equiv="refresh" content="5">

<cfoutput>
Only showing top #resultCount# results

<table>
	<thead>
		<th>Time</th>
		<th>Method</th>
		<th>IP</th>
		<th>Page</th>
		<th>User Agent</th>
		<th>Message</th>
	</thead>
	<tbody>
<cfloop query="logQuery">
		<tr>
			<td>#sl_accesstime#</td>
			<td>#sl_method#</td>
			<td>#sl_ip#</td>
			<td>#sl_pagerequested#</td>
			<td>#sl_useragent#</td>
			<td>#sl_message#</td>
		</tr>
</cfloop>
	</tbody>
</table>
</cfoutput>

