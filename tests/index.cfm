<cfscript>

	echo( expandPath("{lucee-server}") );
	flush;
	fileWrite('#expandPath("{lucee-server}")#/password.txt', 'password');
	admin action="checkPassword" type="server";
	flush;
	admin
		action="getMappings"
		type="web"
		password="password"
		returnVariable="mappings";

	systemOutput("-------------- Mappings --------------", true);
	loop query="mappings" {
		systemOutput("#mappings.virtual# #mappings.strPhysical# "
			& (len(mappings.strArchive) ? "[#mappings.strArchive#] " : "")
			& (len(mappings.inspect) ? "(#mappings.inspect#)" : ""), true);
	}


	admin
		action="getMappings"
		type="server"
		password="password"
		returnVariable="mappings";

	systemOutput("-------------- Mappings --------------", true);
	loop query="mappings" {
		systemOutput("#mappings.virtual##mappings.strPhysical# "
			& (len(mappings.strArchive) ? "[#mappings.strArchive#] " : "")
			& (len(mappings.inspect) ? "(#mappings.inspect#)" : ""), true);
	}

	a = new Query();
	dump(a);

</cfscript>