<cfscript>
	debug = [];

	debug.append("");

	if (fileExists(expandPath("{lucee-server}/logs/out.log"))){
		cfg = fileRead(expandPath("{lucee-server}/logs/out.log"));
		//debug.append(cfg);
	} else {
		debug.append("out.log missing");
	}
	if (fileExists(expandPath("{lucee-server}/logs/err.log"))){
		cfg = fileRead(expandPath("{lucee-server}/logs/err.log"));
		//debug.append(cfg);
	} else {
		debug.append("err.log missing");
	}

	a = new Query();
	dump(a);
	//debug.append("");
	//debug.append(getApplicationSettings().mappings.toJson());
	
	echo("<pre>" & debug.toList(chr(10)))
	flush;
</cfscript>