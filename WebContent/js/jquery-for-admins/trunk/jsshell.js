/*!
 * JScript Shell for jQuery for Administrators Project
 * http://code.google.com/p/jquery-for-admins/
 *
 * Copyright 2011, Michael Snead
 * Dual licensed under the MIT or GPL Version 2 licenses (just like jQuery).
 *
 * 4/3/2011
 *
 * This code is pre-alpha.
 */

//jsshell

//Make sure this is running in CSCRIPT in case the user double-clicked
var sName = String(WScript.Fullname);
if(sName.indexOf("\\") > 1) {
	sName = sName.substring(String(WScript.Fullname).lastIndexOf("\\") + 1);
}
if(sName.toUpperCase() != "CSCRIPT.EXE") {
	var WshShell = WScript.CreateObject("WScript.Shell");
	WshShell.Run("CSCRIPT.EXE /nologo " + WScript.ScriptFullName);
	WScript.Quit();
}

var jsshell = {};
jsshell.exit = {};
jsshell.exit.functionName = "EXIT,BYE";
jsshell.exit.execute = function() { WScript.Quit(); };
jsshell.cls = {};
jsshell.cls.functionName = "CLS";
jsshell.cls.execute = function() {
	WScript.StdOut.WriteBlankLines(100);
};
jsshell.echo = {};
jsshell.echo.functionName = "ECHO";
jsshell.echo.execute = function() {
	jsshell.echo.ison = !jsshell.echo.ison;
	WScript.Echo("jsshell echo is " + (jsshell.echo.ison ? "on" : "off"));
}
jsshell.help = {};
jsshell.help.functionName = "HELP,?,/?,MAN";
jsshell.help.execute = function() {
	WScript.Echo();
	WScript.Echo("Welcome to jsshell. jsshell should be used with jq4a.js in the same folder.");
	WScript.Echo("jsshell native commands...");
	WScript.Echo("	echo -- turn jsshell's echo on or off.");
	WScript.Echo("	        jsshell will wrap your commands with WScript.Echo() when on.");
	WScript.Echo("	cls  -- write 100 blank lines to clear the screen.");
	WScript.Echo("	exit -- (also 'bye') terminates jsshell.");
	WScript.Echo("	alias-- create custom commands (wrapped as functions) for this session.");
	WScript.Echo();
	WScript.Echo("jq4a core commands...");
	WScript.Echo("	jq4a functions are in the same eval() scope as your commands.");
	WScript.Echo("	All jq4a functions are added to the $ object.");
	WScript.Echo("	Try this command to see properties and functions from the $ object:");
	WScript.Echo("		$.each($, function(e) { WScript.Echo(e)});");
	WScript.Echo("	To see the code for an actual command, type something like this:");
	WScript.Echo("		WScript.Echo($.tee);");
	WScript.Echo("	This command will output the script behind the 'tee' function.");
	WScript.Echo();
	WScript.Echo("Have you found the jq4a project useful? Would you like to learn more/contribute?");
	WScript.Echo("	http://code.google.com/p/jquery-for-admins/");
	WScript.Echo("	aikeru [at] gmail [dot] com");
	WScript.Echo("	mikesharp.wordpress.com");
}
jsshell.alias = {};
jsshell.alias.functionName = "ALIAS";
jsshell.alias.aliasObject = {};
jsshell.alias.execute = function() {
	var atxt = "";
	var aname = "";
	WScript.Echo("Enter the alias expression:");
	WScript.StdOut.Write("alias>");
	atxt = WScript.StdIn.ReadLine();
	if(atxt == "") { WScript.Echo("Ok. No new alias."); return; }
	WScript.Echo("alias name?>");
	aname = WScript.StdIn.ReadLine();
	if(aname == "") { WScript.Echo("Ok. No new alias."); return; }
	jsshell.alias.aliasObject = jsshell.alias.aliasObject || {};
	jsshell.alias.aliasObject[aname] = "(function(){" + atxt + "})()";
};

var reflectObject = function(obj) {
	var retStr = "";
	retStr += "prototype: " + Object.prototype.toString.call(obj) + "\r\n";
	for(var x in obj) {
		retStr += x + ": " + obj[x] + "\r\n";
	}
	return retStr;
}

var cmd = "";
var core = "";
var cmdBuffer = "";

try {
eval(new ActiveXObject("Scripting.FileSystemObject").OpenTextFile("jq4a.js",1).ReadAll());
} catch(e)
{
WScript.Echo("There was an error attempting to read 'jq4a.js'. jQuery for Admin functions will not be available to the shell.");
}

WScript.StdOut.Write("js>");

do {
	cmd = WScript.StdIn.ReadLine();
	if(cmd.length > 0 && cmd.substring(cmd.length - 1) === "\\") {
		cmdBuffer += cmd;
		WScript.StdOut.Write("more>");
	} else {
		if(cmdBuffer != "") {
			cmd = cmdBuffer + cmd;
			cmdBuffer = "";
		}
		var fCmd = false;
		for(var x in jsshell) {
			var funcNames = (jsshell[x].functionName+"").split(',');
			var uCmd = cmd.toUpperCase();
			for(var i=0;i<funcNames.length;i++){
				if(uCmd === funcNames[i]) { jsshell[x].execute(); fCmd = true; }
			}
		}
		if(!fCmd) {
			for(var x in jsshell.alias.aliasObject) {
				if(x.toUpperCase() === cmd.toUpperCase()) {
					try {
					fCmd = true;
					if(jsshell.echo.ison) { WScript.Echo(eval(jsshell.alias.aliasObject[x])); }
					else { eval(jsshell.alias.aliasObject[x]); }
					} catch(e) { WScript.Echo($.reflectObject(e)); }
				}
			}
		}
		if(!fCmd) {
			try{
				if(jsshell.echo.ison) {
					WScript.Echo(eval(cmd));
				} else {
					eval(cmd);
				}
			}catch(e) {
				WScript.Echo('Error: ' + reflectObject(e));
			}
		}
		WScript.StdOut.Write("js>");
	}
	

} while(cmd.toUpperCase() != "EXIT");