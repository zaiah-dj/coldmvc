component {
	Property name="table" type="string";
	Property name="datasource" type="string";

	/* ------------------------------------ *
	init() 
	------	
	Check that a database or file exists and 
	create it for logging.

	Right now, only supports SQL server...
	 * ------------------------------------ */
	public function init (
	  Required String table
	 ,Required String ds
	) 
	{
		//Set the data source and table name
		this.datasource = "#arguments.ds#";
		this.table = "#arguments.table#";
		q = new Query( datasource="#this.datasource#" );

		//Check that a particular database exists in the primary datasource
		try {
			checkStmt = "SELECT TOP 1 * FROM #this.table#";
			r = q.execute( sql=checkStmt );
			//writedump( r );
		}
		catch (any e) {
			writeoutput( e.message );
			writeoutput( "<br />" );
			writeoutput( e.detail );

			//Create the table if it does not exist (does not work everywhere)
			sqlCreate = "CREATE TABLE #this.table# ( 
					 sl_id INT IDENTITY(1,1) NOT NULL
					,sl_method VARCHAR(10)
					,sl_accesstime DATETIME
					,sl_ip VARCHAR(128)
					,sl_pagerequested VARCHAR(2048)
					,sl_useragent VARCHAR(512)
					,sl_message VARCHAR(MAX)
				);";

			r = q.execute( sql=sqlCreate );
			//writedump( r );
		}

		return this;
	}


	public Boolean function append( String message )
	{
		//...
		if (StructKeyExists(arguments,"message"))
			msg = arguments.message;
		else { msg = ""; }
		sqInsert = "INSERT INTO #this.table# VALUES (:md, :dt, :ip, :page, :ua, :msg)";
	
		//Add query
		q = new Query( datasource="#this.datasource#" );
		q.addParam( name="md", value="#cgi.request_method#", cfsqltype="cfsqlvarchar" );
		q.addParam( name="dt", 
			value=DateTimeFormat( Now(), "YYYY-MM-DD HH:nn:ss" ), cfsqltype="cfsqldatetime" );
		q.addParam( name="ip", value="#cgi.remote_addr#", cfsqltype="cfsqlvarchar" );
		q.addParam( name="page", value="#cgi.script_name#", cfsqltype="cfsqlvarchar" );
		q.addParam( name="ua", value="#cgi.http_user_agent#", cfsqltype="cfsqlvarchar" );
		q.addParam( name="msg", value="#msg#", cfsqltype="cfsqlvarchar" );
		
		//...
		try {r = q.execute( sql = sqInsert );}
		catch (any e) {
			0; //if these writes fail, um...
		}
		return true;
	}

}
