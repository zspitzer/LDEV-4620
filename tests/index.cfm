<cfscript>
	failed = false;
	out = fileRead(expandPath("{lucee-server}/logs/out.log"));

	config =  fileRead(expandPath("{lucee-server}/.CFConfig.json"));

	function logger(mess){
		echo(mess & chr(10));
		flush;
		systemOutput(mess, true);
		if (structKeyExists(server.system.environment, "GITHUB_STEP_SUMMARY"))
			fileAppend( server.system.environment.GITHUB_STEP_SUMMARY, mess & chr(10) );
	}

	function testNewQuery(){
		try {
			a = new Query(); // this fails since 492
			logger("cool, new Query() worked!");
		} catch (e) {
			failed = true;
			logger ("new query() failed : #e.stacktrace#");
		}
	}
	settings =  getApplicationSettings();
	logger("#### " & server.lucee.version & " single mode: " 
		& (settings.singleContext ?: "n/a") ) ;
	logger("out.log is #numberformat(len(out)/1024)# kb");
	logger( expandPath("{lucee-server}") );

	logger("-------------------out.log-----------------");
	logger(out);
	logger("-------------------ends -----------------");


	logger("-------------------cfconfig.json-----------------");
	logger(config);
	logger("-------------------ends -----------------");

	componentPath = expandPath("{lucee-server}") & "/context/Component.cfc";
	componentExists = fileExists(componentPath );

	logger(" componentExists: #componentExists# at #componentPath#");

	logger(expandPath("/lucee-server"));
    logger((expandPath("/lucee/Component.cfc")));
    logger((expandPath("/lucee-server/Component.cfc")));

	try {
		throw "get me a stacktrace";
	} catch(e){
		logger("> #e.stacktrace#");
	};
	// logger(out);

	if (fileExists(expandPath("{lucee-server}/logs/exception.log"))){
		ex = fileRead(expandPath("{lucee-server}/logs/exception.log"));
		logger("## exception.log");
		logger(ex);
	}

	app = fileRead(expandPath("{lucee-server}/logs/application.log"));
	logger("## application.log");
	logger(app);

	deploy = fileRead(expandPath("{lucee-server}/logs/deploy.log"));
	logger("## deploy.log");
	logger(deploy);


	if ( fileExists( expandPath("{lucee-server}/logs/err.log") ) ){
		err = fileRead(expandPath("{lucee-server}/logs/err.log"));

		logger("## err.log");
		logger(err);
	}


	testNewQuery();

	if (!failed) {
		abort;
	}

	logger("sleeping for 3s");
	sleep(3000); // testing the theory lucee 6 is starting to fast (doesn't help)
	testNewQuery();

	out2 = fileRead(expandPath("{lucee-server}/logs/out.log"));

	logger("#### out.log since request started");
	logger(mid(out2, len(out))); // outpu
	

	if (!failed) {
		abort;
	}
	/*
	logger("expand path");
	a = expandPath("query.cfc");
	testNewQuery();
	*/

	logger("let's try application update");
	application action="update" name="i'll try anything";
	testNewQuery();


	fileWrite('#expandPath("{lucee-server}")#/password.txt', 'password');

	
	logger("load admin password, via checkPassword");

	admin action="checkPassword" type="server";

	testNewQuery();

	out3 = fileRead(expandPath("{lucee-server}/logs/out.log"));

	logger("#### out.log since request started");
	logger(mid(out3, len(out))); // output anything in out.log after it starts working

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

	if (failed) throw "new Qery(), still not working";

</cfscript>
