<cfscript>

	cfg = fileRead(expandPath("{lucee-server}/logs/out.log"));

	
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

	cfg2 = fileRead(expandPath("{lucee-server}/logs/out.log"));

	echo(mid(cfg2, len(cfg))); // output anything in out.log after it starts working

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