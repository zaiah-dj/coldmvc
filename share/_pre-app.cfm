<!---
_pre-app.cfm

@author
	Antonio R. Collins II (ramar.collins@gmail.com)
@end

@copyright
	Copyright 2016-Present, "Deep909, LLC"
	Original Author Date: Tue Jul 26 07:26:29 2016 -0400
@end

@summary
 	An example of pre-start tasks 
@end
  --->
<cftry>
<!---
--->
<cfset _status  = 1>
<cfset _message = "All of this app's pre-start tasks ran fine.">
<cfset _error = "">

<cfquery name="_create" datasource=##data.source##>

	DROP TABLE IF EXISTS policy_content;
	CREATE TABLE IF NOT EXISTS policy_content(
		content_data_id int NOT NULL,
		content_id int NULL,
		content_data varchar(max) NULL,
		content_timestamp datetime NULL,
		is_newest bit NULL,
		content_history varchar(max) NULL
	); 


	DROP TABLE IF EXISTS policy_dept;
	CREATE TABLE IF NOT EXISTS policy_dept(
		policy_funct_id int NULL,
		functcat_unit varchar(256) NULL,
		functcat_designation varchar(3) NULL
	);


	DROP TABLE IF EXISTS policy_links;
	CREATE TABLE IF NOT EXISTS policy_links(
		link_id int NULL,
		ref int NULL,
		title varchar(2056) NULL,
		link varchar(max) NULL
	);


	DROP TABLE IF EXISTS policy_root;
	CREATE TABLE IF NOT EXISTS policy_root(
		policy_root_id int NOT NULL,
		title varchar(128) NULL,
		content_type int NULL,
		dept_id int NULL,
		sub_cat_id int NULL,
		policy_number int NULL,
		timestamp datetime NULL,
		contact varchar(128) NULL,
		authority_id int NULL,
		ro_id int NULL
	); 


	DROP TABLE IF EXISTS policy_subcategories;
	CREATE TABLE IF NOT EXISTS policy_subcategories(
		policy_subcat_id int NULL,
		funct_match int NULL,
		subcat_unit varchar(max) NULL,
		subcat_designation varchar(3) NULL
	); 

	/*Add status*/
	DROP TABLE IF EXISTS policy_classifications;
	CREATE TABLE policy_classifications (
		policy_classification_id int NULL,
		policy_abbrev varchar( 64 ) NOT NULL,
		policy_type  varchar( 64 ) NULL,
		auth_name varchar( 64 ) NULL
	); 

DROP TABLE IF EXISTS Departments;
CREATE TABLE Departments (
	ID int IDENTITY(1,1) NOT NULL,
	DepartmentName nvarchar(255) NULL,
	ShortName nvarchar(255) NULL,
	hidden bit NULL,
	academic bit NULL,
	noUndergrads bit NULL,
	extracurricular bit NULL
);
</cfquery>



<cfscript>
//These are split because of a memory problem in Lucee.
//Or maybe it's just too many records...
_include( "sql", "_insertPN" );
_include( "sql", "_insertPD" );
_include( "sql", "_insertPC" );
_include( "sql", "_insertPR" );
_include( "sql", "_insertPL" );
_include( "sql", "_insertPS" );
_include( "sql", "_insertDP" );
</cfscript>



<cfquery name = "_select" datasource = #data.source# >
SELECT TOP 5 * FROM policy_subcategories
</cfquery>


<!--- --->
<cfsavecontent variable="_text">
	Below is a test of one of this application's tables.
	<cfdump var = #_select#>
</cfsavecontent>


<cfcatch type="any">
	<!--- I want to serve an error page, hopefully telling the user what went wrong. --->
	<cfset _message = "A pre-start task failed.  Please check the error log below for more detail.">
	<cfset _status = 0>
	<cfset _error = "#cfcatch.detail# <br />#cfcatch.stacktrace#">
	<cfset _text = "#cfcatch#">
</cfcatch>


</cftry>


<cfset model = 
{
	message = _message,
	status  = _status,
	error  = _error,
	text    = _text,
}>
