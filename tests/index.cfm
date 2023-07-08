<cfscript>
	failed = false;
	out = fileRead(expandPath("{lucee-server}/logs/out.log"));
	
	function logger(mess){
		echo(mess & chr(10));
		systemOutput(mess, true);

		fileAppend( server.system.environment.GITHUB_STEP_SUMMARY, mess & chr(10) );
	}

	function testNewQuery(){
		try {
			a = new Query(); // this fails since 492
			logger("worked?");
		} catch (e) {
			failed = true;
			logger (" failed : #e.stacktrace#");
		}
	}

	logger("##" & server.lucee.version);
	logger( expandPath("{lucee-server}") );
	flush;

	testNewQuery();

	if (!failed) abort;

	fileWrite('#expandPath("{lucee-server}")#/password.txt', 'password');

	testNewQuery();

	logger("load admin password");

	admin action="checkPassword" type="server";

	testNewQuery();

	out2 = fileRead(expandPath("{lucee-server}/logs/out.log"));

	logger("#### out.log since request started");
	logger(mid(out2, len(out))); // output anything in out.log after it starts working

	flush;

	admin
		action="getMappings"
		type="server"
		password="password"
		returnVariable="mappings";

	logger("-------------- Mappings --------------" );
	loop query="mappings" {
		logger("#mappings.virtual##mappings.strPhysical# "  );
	}

	testNewQuery();

	if (failed) throw "still not working";

</cfscript>
