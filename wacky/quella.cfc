component {

	private function checkBindType ( 
	   ap
	  ,String parameter
 	)
	{
		//Pre-initialize 'value' and 'type'
		v = {};
		v.value = "";
		v.name  = parameter;
		v.type  = "varchar";

		//If the dev only has one value and can assume it's a varchar, then use it (likewise I can probably figure out if this is a number or not)
		if ( !IsStruct( ap ) ) 
		{
			v.value = ( Left(ap,1) eq '##' && Right(ap,1) eq '##' ) ? Evaluate( ap ) : ap;
			try {
				//coercion has failed if I can't do this...
				__ = value + 1;
				v.type = "integer";
			}
			catch (any e) {
				//writeoutput( "conversion fail: " & e.message & "<br />" & e.detail & "<br />" );
				v.type = "varchar";
			}
		}
		else
		if ( StructKeyExists( ap, parameter ) ) {
			//Is ap.parameter a struct?	
			//If not, then it's just a value
			if ( !IsStruct( ap[ parameter ] ) )
				v.value = ( Left(ap[parameter],1) eq '##' && Right(ap[parameter],1) eq '##' ) ? Evaluate( ap[parameter] ) : ap[parameter];
				//value = Evaluate( ap[ parameter ] );
			else 
			{
				if ( StructKeyExists( ap[ parameter ], "value" ) )
					v.value = ( Left(ap[parameter]["value"],1) eq '##' && Right(ap[parameter]["value"],1) eq '##' ) ? Evaluate( ap[parameter]["value"] ) : ap[parameter]["value"];
					//value = Evaluate( ap[ parameter ][ "value" ] );
				if ( StructKeyExists( ap[ parameter ], "type" ) )
					v.type = ap[ parameter ][ "type" ];
			}
		}

		//See test results	
		//writeoutput( "Interpreted value is: " & value & "<br /> & "Assumed type is: " & type & "<br />" ); 
		//nq.addParam( name = parameter, value = value, cfsqltype = type );
		return v; 
	}

	this.datasource = "";

	public function setDs ( required String datasource ) 
	{
		this.datasource = datasource;
	}

	public function exec ( String datasource = "#this.datasource#", String filename, String string, bindArgs ) 
	{
		//Set some basic things
		Name = "query";
		SQLContents = "";

		//Check for either string or filename
		if ( !StructKeyExists( arguments, "filename" ) && !StructKeyExists( arguments, "string" ) ) {
			return { 
				status= false, 
				message= "Either 'filename' or 'string' must be present as an argument to this function."
			};
		}

		//Make sure data source is a string
		if ( !IsSimpleValue( arguments.datasource ) )
			return { status= false, message= "The datasource argument is not a string." };

		if ( arguments.datasource eq "" )
			return { status= false, message= "The datasource argument is blank."};

		//Then check and process the SQL statement
		if ( StructKeyExists( arguments, "string" ) ) {
			if ( !IsSimpleValue( arguments.string ) )
				return { status= false, message= "The 'string' argument is neither a string or number." };

			Name = "_anonymous";
			SQLContents = arguments.string;
		}
		else {
			//Make sure filename is a string (or something similar)
			if ( !IsSimpleValue( arguments.filename ) )
				return { status= false, message= "The 'filename' argument is neither a string or number." };

			//Get the file path.	
			rd = getDirectoryFromPath(getCurrentTemplatePath());
			cd = getCurrentTemplatePath();
			fp = rd & "/" & arguments.filename;
			//return { status= false, message= "#current# and #root_dir#" };

			//Check for the filename
			if ( !FileExists( fp ) )
				return { status= false, message= "File " & fp & " does not exist." };

			//Get the basename of the file
			Base = find( "/", arguments.filename );
			if ( Base ) {
				0;	
			}

			//Then get the name of the file sans extension
			Period = Find( ".", arguments.filename );
			Name = ( Period ) ? Left(arguments.filename, Period - 1 ) : "query";

			//Read the contents
			SQLContents = FileRead( fp );
		}

		//Set up a new Query
		q = new Query( datasource="#arguments.datasource#" );	
		q.setname = "#Name#";
		//q.setdatasource = arguments.datasource;

		//If binds exist, do the binding dance 
		if ( StructKeyExists( arguments, "bindArgs" ) ) {
			if ( !IsStruct( arguments.bindArgs ) ) 
				return { status= false, message= "Argument 'bindArgs' is not a struct." };

			for ( n in arguments.bindArgs ) {
				value = arguments.bindArgs[n];
				type = "varchar";
				if ( IsSimpleValue( value ) ) {
					try {__ = value + 1; type = "integer";}
					catch (any e) { type="varchar";}
				}
				else if ( IsStruct( value ) ) {
					v = value;
					if ( !StructKeyExists( v, "type" ) || !IsSimpleValue( v["type"] ) )
						return { status = false, message = "Key 'type' does not exist in 'bindArgs' struct key '#n#'" };	
					if ( !StructKeyExists( v, "value" ) || !IsSimpleValue( v["value"] ) ) 
						return { status = false, message = "Key 'value' does not exist in 'bindArgs' struct key '#n#'" };	
					type  = v.type;
					value = v.value;
				}
				else {
					return { 
						status = false, 
						message = "Each key-value pair in bindArgs must be composed of structs."
					};
				}
				q.addParam( name=LCase(n), value=value, cfsqltype=type );
			}
		}

		//Execute the query
		try { rr = q.execute( sql = SQLContents ); }
		catch (any e) {
			return { 
				status  = false,
			  message = "Query failed. #e.message# - #e.detail#."
			};
		}

		//Put results somewhere.
		resultSet = rr.getResult();

		//Return a status
		return {
			status  = true
		 ,message = "SUCCESS"
		 ,results = ( !IsDefined("resultSet") ) ? {} : resultSet
		 ,prefix  = rr.getPrefix()
		};
	}

}
