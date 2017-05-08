/*!
 * jQuery for Administrators Core
 * http://code.google.com/p/jquery-for-admins/
 *
 * Copyright 2011, 2012 Michael Snead
 * Dual licensed under the MIT or GPL Version 2 licenses (just like jQuery).
 *
 * 06/26/2012
 *
 * This code is pre-alpha.
 *
 * Compatible with:
 * 		- Mozilla Rhino
 *		- Microsoft Windows Scripting Host (JScript)
 */
 
 //Msxml2.XMLHTTP
 //http://msdn.microsoft.com/en-us/library/ms535874(v=vs.85).aspx
 (function(context) {	
 	
	var $ = function(selector, context) {
	};
	
	/* environment */
	$.environment = {};
	$.environment.activeX = context.ActiveXObject ? true : false;
	$.environment.java = context.java ? context.java == "[JavaPackage java]" : false;
	$.environment.android = false;
	if($.environment.activeX) {
		$.environment.windows = true;
		$.environment.mac = false;
		$.environment.unix = false;
	}
	if($.environment.java) {
		var osname = java.lang.System.getProperty("os.name").toLowerCase();
		$.environment.windows = osname.indexOf("win") >= 0;
		$.environment.mac = osname.indexOf("mac") >= 0;
		$.environment.unix = osname.indexOf("nix") >= 0 || osname.indexOf("nux") >= 0 || osname.indexOf("sunos") >= 0;
	}
	
	/* file */
	$.file = {};
	$.file.exists = function(path) {
		var doesExist = false;
		if($.environment.activeX) {
			var fso = new ActiveXObject("Scripting.FileSystemObject");
			doesExist = fso.FileExists(path);
			fso = null;
		} else if($.environment.java) {
			var file = new java.io.File(path);
			doesExist = file.exists();
			file = null;
		}
		return doesExist;
	};
	
	/* shell */
	$.shell = {};
	$.shell.execute = function(cmd) {
		var execObject = {};
		var isFile = $.file.exists(cmd);
				
		if($.environment.activeX) {
			var shell, exec, stdout;
			shell = new ActiveXObject("WScript.Shell");
			if(isFile) {
				exec = shell.Exec(cmd);
				stdout = exec.StdOut;
			} else {
				//assume it's a command
				exec = shell.Exec('%comspec% /c ' + cmd);
				stdout = exec.StdOut;
			}
			execObject.readLine = function() { 
				if(stdout.AtEndOfStream) { return null; } //return null if at the end of stream			    
				return stdout.ReadLine(); 
			};
			execObject.destroy = function() {
				stdout = null;
				exec = null;
				shell = null;
			};
			
		} else if($.environment.java) {
			var p;
			if(isFile) {
				p = java.lang.Runtime.getRuntime().exec(cmd);
				p.waitFor();
				var reader = java.io.BufferedReader(new java.io.InputStreamReader(p.getInputStream()));
				
				execObject.readLine = function() { 
					return reader.readLine(); //returns 'null' when at the end of stream
				};
			} else {
				if($.environment.windows) {
					//if it's Windows, use "cmd" to execute the system command
					var comspec = java.lang.System.getenv("comspec");
					p = java.lang.Runtime.getRuntime().exec(comspec + ' /c ' + cmd);	
				} else {
					//some other OS, hopefully it will interpret the system command
					p = java.lang.Runtime.getRuntime().exec(cmd);
				}
				var reader = java.io.BufferedReader(new java.io.InputStreamReader(p.getInputStream()));
				execObject.readLine = function() { 
					return reader.readLine(); //returns 'null' when at the end of stream
				};
			}
			execObject.destroy = function() {
				p.destroy();				
			};
		}
		return execObject;
	};
	
	
	var trimLeft = /^\s+/;
	var trimRight = /\s+$/;
	
	/* echo */
	$.echo = function(echoStr) {
		if($.environment.activeX) { WScript.Echo(echoStr); }
		if($.environment.java) { print(echoStr); }
	}
	
	/* tee */
	$.tee = function(cmdStr, itFunc, echoIt) {
		
		var execObj = $.shell.execute(cmdStr);
		
		var buff = execObj.readLine();
		while(buff != null) {
			if(echoIt === undefined || echoIt === true) {
				$.echo(buff);
				if(itFunc) { itFunc(buff); }
			} else {
				if(itFunc) { itFunc(buff); }
			}
			buff = execObj.readLine();
		};
	}
	
	/* each */
	$.each = function(axObj, itFunc) {
		var itemCount = 0;
		if(Object.prototype.toString.call(axObj)==='[object Array]'){
				for(var i=0;i<axObj.length;i++){ //It's an array, loop through it
						itFunc(axObj[i],i);
				}
		} else {
			if(!(axObj instanceof Object)) { //It's not a JS object, probably ActiveX
				var e = new Enumerator(axObj);
				e.moveFirst();
				while(e.atEnd() == false) {
						itFunc(e.item(),itemCount);
						e.moveNext();
						itemCount++;
				}
			} else {
				for(var x in axObj) {
						itFunc(x,itemCount);
						itemCount++;
				}
			}
		}
	};
	
	/* stringWriter */
	var StringWriter = function() {};
	StringWriter.prototype.Write = function(wobj) {
		if($.environment.activeX) {
			this.axObject = this.axObject || new ActiveXObject("System.IO.StringWriter");
			this.axObject.Write_13(wobj);
		} else if($.environment.java) {
			this.javaObject = this.javaObject || new java.lang.StringBuilder();
			this.javaObject.append(wobj);
		} else {
			this.rawString = this.rawString || "";
			this.rawString += wobj;
		}
	}
	StringWriter.prototype.WriteLine = function(wobj) {
		if($.environment.activeX) {
			this.axObject = this.axObject || new ActiveXObject("System.IO.StringWriter");
			this.axObject.WriteLine_13(wobj);
		} else if($.environment.java) {
			this.javaObject = this.javaObject || new java.lang.StringBuilder();
			this.javaObject.append(wobj + "\r\n");
		} else {
			this.rawString = this.rawString || "";
			this.rawString += wobj + "\r\n";
		}
	}
	StringWriter.prototype.ToString = function(wargs) {
		if($.environment.activeX) {
			this.axObject = this.axObject || new ActiveXObject("System.IO.StringWriter");
			return wargs ? this.axObject.ToString(wargs) : this.axObject.ToString();
		} else if($.environment.java) {
			this.javaObject = this.javaObject || new java.lang.StringBuilder();
			return this.javaObject.toString();
		} else {
			this.rawString = this.rawString || "";
			return this.rawString;
		}
	}
	StringWriter.prototype.isNative = $.environment.activeX || $.environment.java;
	
	//System.Collections.ArrayList <-- use $.each to enumerate
	// Add,Sort,Reverse,Remove
	$.stringWriter = StringWriter;
	
	/* echoCmd */
	$.echoCmd = function(cmdStr) {
		var execObj = $.shell.execute(cmdStr);
		var buff = execObj.readLine();
		while(buff != null) {
			$.echo(buff);
			buff = execObj.readLine();
		};
	};
	
	$.reflectObject = function(obj) {
		var retStr = "";
		retStr += "prototype: " + Object.prototype.toString.call(obj) + "\r\n";
		for(var x in obj) {
				retStr += x + ": " + obj[x] + "\r\n";
		}
		return retStr;
	}
	
	/* ajax */
	$.ajax = function(aOpts) {
			var aType = ((aOpts.type ? aOpts.type : "GET") + '').toUpperCase();
			
			if($.environment.activeX) {
				try {
				var aXML = new ActiveXObject("Msxml2.XMLHTTP");
				
				if(aOpts.username) {
						aXML.Open(aType, aOpts.url, aOpts.async === true, aOpts.username + '', aOpts.password + '');
				} else {
						aXML.Open(aType, aOpts.url, aOpts.async === true);
				}
				aXML.Send();
				if(aOpts.success) { aOpts.success(aXML.responseText); }
				else { return aXML.responseText; }
				} catch(e) {
						$.echo($.reflectObject(e));
						if(aOpts.error) { aOpts.error(e); }
				}
			} else if($.environment.java) {
				if(aOpts.async === true) { throw "Asynchronous AJAX requests are not supported under Rhino."; }
				if(aType === "POST") {			
				
					var data = "", dataElement, url, conn, wr, rd, line, responseText = "";
					if(aOpts.data != undefined && aOpts.data != "") {				
						for(var x in aOpts.data) {
							dataElement = java.net.URLEncoder.encode(x, "UTF-8") + "=" + java.net.URLEncoder.encode(aOpts.data[x], "UTF-8");
							data = data === "" ? dataElement : data + "&" + dataElement;
						}
					}
					url = new java.net.URL(aOpts.url);
					conn = url.openConnection();
					conn.setDoOutput(true);
					wr = new java.io.OutputStreamWriter(conn.getOutputStream());
					wr.write(data);
					wr.flush();
					rd = java.io.BufferedReader(new java.io.InputStreamReader(conn.getInputStream()));
					line = rd.readLine();
				    while(line != null) {
						responseText += responseText === "" ? line : "\r\n" + line;
						line = rd.readLine();
					}
					wr.close();
					rd.close();	
					if(aOpts.success) { aOpts.success(responseText); }
					else { return responseText; }
					
				} else {
					try {
						var responseText = readUrl(aOpts.url);
						if(aOpts.success) { aOpts.success(responseText); }
						else { return responseText; }
					} catch(e) {
						if(aOpts.error) { aOpts.error(e); }
					}
				}
				
			}
	}

	/* reboot */
	$.reboot = function() {
		if($.environment.activeX) {
			var opsys = GetObject("winmgmts:{(Shutdown)}//./root/cimv2").ExecQuery("select * from Win32_OperatingSystem where Primary=true");
			for(var enumItems = new Enumerator(opsys); !enumItems.atEnd(); enumItems.moveNext())
			{
				enumItems.item().Reboot();
			}
		} else if($.environment.java) {
			if($.environment.windows) {
				var sysroot = java.lang.System.getenv("%SystemRoot%");
				$.shell.execute(sysroot + "\\shutdown.exe -r -t 00 -f");
			} else if($.environment.android) {
				//seems this requires superuser
				//http://stackoverflow.com/questions/5484535/runtime-exec-reboot-in-android				
			} else if($.environment.unix) {
				$.shell.execute('reboot');
			}
		}
	}
	
	/* shutdown */
	$.shutdown = function() {
		if($.environment.activeX) {
			var opsys = GetObject("winmgmts:{(Shutdown)}//./root/cimv2").ExecQuery("select * from Win32_OperatingSystem where Primary=true");
			for(var enumItems = new Enumerator(opsys); !enumItems.atEnd(); enumItems.moveNext())
			{
				enumItems.item().Shutdown();
			}
		} else if($.environment.java) {
			if($.environment.windows) {
				var sysroot = java.lang.System.getenv("%SystemRoot%");
				$.shell.execute(sysroot + "\\shutdown.exe -r -t 00 -f");
			} else if($.environment.android) {
				//seems this requires superuser
				//http://stackoverflow.com/questions/5484535/runtime-exec-reboot-in-android	
			} else if($.environment.unix) {
				$.shell.execute('poweroff');
			}
		}
	}
	
	/* base64Encode */
	$.base64Encode = function(input) {
		var _keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
		var output = "";
		var chr1, chr2, chr3, enc1, enc2, enc3, enc4;
		var i = 0;
		while(i < input.length) {
		  chr1 = input.charCodeAt(i++);
		  chr2 = input.charCodeAt(i++);
		  chr3 = input.charCodeAt(i++);
		  enc1 = chr1 >> 2;
		  enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
		  enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
		  enc4 = chr3 & 63;
		  if(isNaN(chr2)) {
				 enc3 = enc4 = 64;
		  } else if(isNaN(chr3)) {
				 enc4 = 64;
		  }
		  output = output + _keyStr.charAt(enc1) + _keyStr.charAt(enc2) + _keyStr.charAt(enc3) + _keyStr.charAt(enc4);
		}
		return output;
	};

	/* trim */
	$.trim = String.prototype.trim ?
		function(text) {
			return text == null ?
				"" :
				text.trim();
		} :
		function(text) {
			return text == null ?
				"" :
				text.toString().replace(trimLeft,"").replace(trimRight,"");
		};
	
	/* contains */
	$.contains = function(x, it) {
		if(Object.prototype.toString.call(it)==='[object Array]'){
			for(var i=0;i<it.length;i++){ //It's an array, loop through it
				if(x.indexOf(it[i]) != -1) 
				{ return true; }
			}
		} else if(Object.prototype.toString.call(it)==='[object String]') {
			return x.indexOf(it) !== -1;
		}  else {
			throw "Invalid object (not an array or a string)";
		}
		return false;
	}
	
	
	context.$ = $;
 })(this);