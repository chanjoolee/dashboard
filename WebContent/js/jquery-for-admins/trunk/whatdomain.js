var a=new ActiveXObject("Msxml2.XMLHTTP");a.Open("GET","http://jquery-for-admins.googlecode.com/svn/trunk/jq4a.js",false);
a.Send();eval(a.responseText);

var strComputer = ".";
var objWMIService = GetObject("winmgmts:\\\\" +
    strComputer + "\\root\\cimv2");
var colSettings = objWMIService.ExecQuery("Select * from Win32_ComputerSystem");

$.each(colSettings, function(x) {
 WScript.Echo("System Name: " + x.Name);
 WScript.Echo("Domain: " + x.Domain);
});