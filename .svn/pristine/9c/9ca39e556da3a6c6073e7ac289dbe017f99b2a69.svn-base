var $ = $ || {};
$.reboot = function() {
	var opsys = GetObject("winmgmts:{(Shutdown)}//./root/cimv2").ExecQuery("select * from Win32_OperatingSystem where Primary=true");
	for(var enumItems = new Enumerator(opsys); !enumItems.atEnd(); enumItems.moveNext())
	{
		enumItems.item().Reboot();
	}
}
$.shutdown = function() {
	var opsys = GetObject("winmgmts:{(Shutdown)}//./root/cimv2").ExecQuery("select * from Win32_OperatingSystem where Primary=true");
	for(var enumItems = new Enumerator(opsys); !enumItems.atEnd(); enumItems.moveNext())
	{
		enumItems.item().Reboot();
	}
}

$.reboot();
