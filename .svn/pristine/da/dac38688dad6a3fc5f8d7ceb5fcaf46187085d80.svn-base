//Open WMI and Remote Access Ports
//msnead 11/8/2011
var firewall = new ActiveXObject("HNetCfg.FwMgr");
var policy = firewall.LocalPolicy.CurrentProfile;
var admin = policy.RemoteAdminSettings;
admin.Enabled = true;