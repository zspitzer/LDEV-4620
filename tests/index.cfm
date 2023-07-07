<cfscript>

	echo( expandPath("{lucee-server}") & chr(10) );
	flush;
	fileWrite('#expandPath("{lucee-server}")#/password.txt', 'password');
	admin action="checkPassword" type="server";
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

	a = new Query();
	echo("worked?");

</cfscript>