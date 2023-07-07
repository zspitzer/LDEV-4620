component {

	this.name = "Preside Test Suite " & Hash( ExpandPath( '/' ) );

	currentDir = GetDirectoryFromPath( GetCurrentTemplatePath() );
	/*
	this.mappings['/tests']       = currentDir;
	this.mappings['/integration'] = currentDir & "integration";
	this.mappings['/resources']   = currentDir & "resources";
	this.mappings['/testbox']     = currentDir & "testbox";
	this.mappings['/mxunit' ]     = currentDir & "testbox/system/compat";
	this.mappings['/app']         = currentDir & "resources/testSite";
	this.mappings['/preside']     = currentDir & "../";
	this.mappings['/coldbox']     = currentDir & "../system/externals/coldbox";

	setting requesttimeout="6000";
	*/
}