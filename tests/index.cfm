<cfscript>
	failed = false;
	out = fileRead(expandPath("{lucee-server}/logs/out.log"));
	
	function logger(mess){
		echo(mess & chr(10));
		systemOutput(mess, true);

		fileAppend( server.system.environment.GITHUB_STEP_SUMMARY, mess & chr(10) );
	}

	logger( expandPath("{lucee-server}") );
	flush;

	try {
		a = new Query();
		logger("worked?");
	} catch (e) {
		failed = true;
		logger (" failed : #e.stacktrace#");
	}

	if (!failed) abort;

	fileWrite('#expandPath("{lucee-server}")#/password.txt', 'password');

	try {
		a = new Query();
		logger("worked?");
	} catch (e) {
		failed = true;
		logger (" failed : #left(e.stacktrace,100)#");
	}

	admin action="checkPassword" type="server";

	try {
		a = new Query();
		logger("worked?");
	} catch (e) {
		failed = true;
		logger (" failed : #left(e.stacktrace,100)#");
	}

	out2 = fileRead(expandPath("{lucee-server}/logs/out.log"));

	logger(mid(out2, len(out))); // output anything in out.log after it starts working

	flush;
	admin
		action="getMappings"
		type="web"
		password="password"
		returnVariable="mappings";

	logger("-------------- Mappings --------------" );
	loop query="mappings" {

		logger( "#mappings.virtual# #mappings.strPhysical# " );

	}

	admin
		action="getMappings"
		type="server"
		password="password"
		returnVariable="mappings";

	logger("-------------- Mappings --------------" );
	loop query="mappings" {
		logger("#mappings.virtual##mappings.strPhysical# "  );
	}

	try {
		a = new Query();
		logger("worked?" );
	} catch (e) {
		failed = true;
		logger (" failed : #left(e.stacktrace,100)#" );
	}
	if (failed) throw "still not working";

</cfscript>
