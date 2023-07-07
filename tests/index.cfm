<cfscript>

	echo( expandPath("{lucee-server}") & chr(10) );
	flush;

	try {
		a = new Query();
		echo("worked?" & chr(10));
	} catch (e) {
		echo (" failed : #left(e.stacktrace,100)#" & chr(10));
	}

	fileWrite('#expandPath("{lucee-server}")#/password.txt', 'password');

	try {
		a = new Query();
		echo("worked?" & chr(10));
	} catch (e) {
		echo (" failed : #left(e.stacktrace,100)#" & chr(10));
	}

	admin action="checkPassword" type="server";

	try {
		a = new Query();
		echo("worked?" & chr(10));
	} catch (e) {
		echo (" failed : #left(e.stacktrace,100)#" & chr(10));
	}

	flush;
	admin
		action="getMappings"
		type="web"
		password="password"
		returnVariable="mappings";

	echo("-------------- Mappings --------------" & chr(10));
	loop query="mappings" {

		echo( "#mappings.virtual# #mappings.strPhysical# " & chr(10));

	}

	admin
		action="getMappings"
		type="server"
		password="password"
		returnVariable="mappings";

	echo("-------------- Mappings --------------" & chr(10));
	loop query="mappings" {
		echo("#mappings.virtual##mappings.strPhysical# " & chr(10) );
	}

	try {
		a = new Query();
		echo("worked?" & chr(10));
	} catch (e) {
		echo (" failed : #left(e.stacktrace,100)#" & chr(10));
	}


</cfscript>