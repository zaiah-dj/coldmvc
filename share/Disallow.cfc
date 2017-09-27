component {
	function onRequest (string targetPage) 
	{
		j = DeserializeJSON( FileRead( "../data.json", "utf-8") );
		location url = j.base;

		try {
			include "index.cfm";
		} catch (any e) {
			//Handle exception
			writedump(e);
			abort;
			include "failure.cfm";
		}
	}
}
