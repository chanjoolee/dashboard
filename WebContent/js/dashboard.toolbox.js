String.prototype.lpad = function(padString, length) {
    var str = this;
    while (str.length < length)
        str = padString + str;
    return str;
}

var contextName = "dashboard";
var responseDataG = [];
var responseDataPieG = [];
var projectListG = {};
var projectListRawG = [];
var projectMapG = {};
var projectInfoG = {};

var total = 0;


var projectNameList = [];
var projectNames = {};

var subProjectList = {};
var subProjectInfo = {};

var phaseColor = {
//		P3C: '#33CCFF',
//		P4C: '#9933CC',
//		P5C: '#CC6699',
//		P6C: '#FF9966',
//		P7C: '#66FF99',
//		P8C: '#009933',
//		P9C: '#990000',
//		P10C: '#003300',
		P3C: '#bdcbd8',
		P4C: '#b0bdcd',
		P5C: '#90a1b5',
		P6C: '#ddeff9',
		P6S: '#ddeff9',
		P7C: '#97d9f9',
		P7S: '#97d9f9',
		P8C: '#2d73b8',
		P8S: '#2d73b8',
		P9C: '#01458c',
		P9S: '#01458c',
		P10C: '#003300',
		Execute:'#ffc878',
		Terminate: '#48bdb6',
		Termination: '#48bdb6',
		Hold: '#bbbbbb',
		"PASS": '#336600',
		"FAIL": '#CC0000',
		"N/A": '#CCCCCC',
		"ABORT": '#FF9900',
		APPROVED:'#006600',
		Approved:'#006600',
		COMPLETED: '#00CC00',
		Completed: '#00CC00',
		Complete: '#00CC00',
		Incomplete: '#666666',
		Editing: '#FFFF00',
		EDITING: '#FFFF00',
		WAITING: '#999999',
		Waiting: '#999999',
		WAIVE: '#CC3333',
		Waive: '#CC3333',
		Waived: '#CC3333',
		작성필요건수:'black',
		All:'black',
		SoC:'#CC3333',
		Model: '#000000',
		//Plan: '#0000FF'
		//15/07/15 수정 파란색==> 빨간색
		Plan: '#FF0000',
		
		revision0:'#444444',
		revision1:'#0000ff',
		revision2:'#ff0000',
		
		// Site
		SFS:'#3399FF',
		NSB:'#129B40',
		SKHYFST:'#D1AC1A',
		SKHMS:'#FF0033',
		
		// funciton
		AE:'#7cb5ec',
		'Advance Development':"#434348",
		'Algo.':'#90ed7d',
		'Dev. Planning':'#f7a35c',
		FW:'#66FF00',
		HW:'#f15c80',
		'Management  & Operation':'#e4d354',
		PE:'#8085e8',
		'Tools & infra for development':'#8d4653',
		'development for mutiple projects  ':'#91e8e1'
			
		// regression
		//System: Highcharts.defaultOptions.colors[0],
		//Buffer: Highcharts.defaultOptions.colors[1],
		//User: Highcharts.defaultOptions.colors[2]
			
		
};


$(function () {	
	var request = new Request();
	var sender = request.getParameter("sender");
	if(sender == 'pms'){
		document.domain = 'hynix.com';
	}	
});

function Request(){
	var requestParam ="";
        this.getParameter = function(param){
    	var url = unescape(location.href); //현재 주소를 decoding
        var paramArr = (url.substring(url.indexOf("?")+1,url.length)).split("&"); //파라미터만 자르고, 다시 &그분자를 잘라서 배열에 넣는다. 
        
        for(var i = 0 ; i < paramArr.length ; i++){
            var temp = paramArr[i].split("="); //파라미터 변수명을 담음
            
            if(temp[0].toUpperCase() == param.toUpperCase()){
            	requestParam = paramArr[i].split("=")[1]; // 변수명과 일치할 경우 데이터 삽입
                break;
            }
        }
        return requestParam;
    };
}


function projectListByAjaxCsv(){
	$.ajax({
		url : "./codesonarProjectDetailProjectListJson.html",
		data: {},
		success : function(responseData){
			//01. 전역변수설정
			projectInfoG = responseData;
			projectListG = responseData.projectList;
			projectMapG = responseData.projectMap
			var paramPjtcode = $("#sProject").val() ;
			var selected ="";
			
			
			var projectList1 = $.csv2Dictionary(responseData.projectList1);
			$.each(projectList1,function(index,val){
				val.server = responseData.server1;
			});
			var projectList2 = $.csv2Dictionary(responseData.projectList2);
			$.each(projectList2,function(index,val){
				val.server = responseData.server2;
			});
			
			var projectList = [];
			$.merge(projectList,projectList1);
			$.merge(projectList,projectList2);
			
			projectList.sort(function(a, b){
				var project1 = a.project.toUpperCase();
				var project2 = b.project.toUpperCase();
				if(project1 == project2)
					return 0;
				return project1> project2? 1: -1;
				//return a.project >  b.project;
			});	
			
			//projectListRawG = projectList;
			projectListRawG = [];
			$.each(projectList,function(index,val){
				if(val.state == "Finished")
					projectListRawG.push(val);
			});
			
			if(paramPjtcode != "")
				getDataByJson(true);
		}
	});
}

/**
 * codeComplexity 이미지 폴더를 찾기 위함.
 * @param list
 */
function setProjectNameList(list){
	for(var i=0; i < list.length ; i++){
		projectNameList.push(
				{
					pjt_code: list[i].PJT_CODE ,
					pjt_name: list[i].PJT_NAME 
				}
		);
		eval('projectNames.'+list[i].PJT_CODE + '= \'' + list[i].PJT_NAME + '\'');
	}	
}

function getPjtName(pjtcode){
	if(projectNames[pjtcode] == undefined)
		return pjtcode;
	else 
		return projectNames[pjtcode];
}


function getCodesonarPriorityCsvLink(pjtCode,priority){
	var linkUrl = "";
	linkUrl += "<span style=\"cursor: pointer;\" onclick=\"htmlExpandPriority('"+pjtCode+ "','" +priority+  "')\">"+priority+"</span>";
	return linkUrl;
}


function htmlExpandPriority(pjtCode,priority,dt){
	var linkUrl = "";
	$.ajax({
		url : "./codesonarPriorityCsvLinkJson.html",
		async: false,
		data: {PJT_CODE: pjtCode },
		//data: $("#form").serialize(),
		success : function(responseData){
			var list = responseData.data;
			var dtSplit ="";
			if(dt != undefined)
			dtSplit = dt.split("-");
			
			for(var i=0;i<list.length;i++){				
				var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
				var csvnum = list[i].CSV_NUM;
				var priority1 = "\""+priority+"\"";
				//var link = "http://"+ svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=priority=&#34;"+priority+"&#34;";
				var link = "";
				
				if(dt != undefined){
					//2015.12/21. 최신데이타를 보여주므로 날자범위를 뺀다.
					//link = "http://"+ svr+".skhynix.com:7340/search.html?filter=2&scope=all&query=";
					link = "http://"+ svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=";
				}else{
					link = "http://"+ svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=";
				}
				
				link += "project:"+ list[i].PJT_CODE;
				link += " priority=&#34;"+priority+"&#34;";
				var searchDt ="";
				var searchDt1 ="";
				
				//2015.12/21. 최신데이타를 보여주므로 날자범위를 뺀다.
				/*if(dt != undefined){
					searchDt =  dtSplit[1]+"/"+dtSplit[2]+"/"+dtSplit[0].substr(2,2);
					searchDt1 = dtSplit[0] + "/" + dtSplit[1] + "/" + dtSplit[2];
					if(searchDt1 != list[i].ANALYSYS_DATE)
						continue;
					
					link += " detected:" + searchDt + ".."+ searchDt;
				}*/
				
				if(!isFinishedCodeSonarProject(list[i].PJT_CODE))
					continue;
				
				var cnt = 0;				
				if(priority.substr(0,2)=='P0')
					cnt = list[i].P0_CNT;
				else if(priority.substr(0,2)=='P1')
					cnt = list[i].P1_CNT;
				else
					cnt = list[i].P2_CNT;
				
				linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">";
				linkUrl +=list[i].PJT_CODE + ": "+priority ;
				
				//날자는 db에서 읽어온 최신 데이타를 반영한다. 2016-01-05
				dt = list[i].ANALYSYS_DATE;
				
				if(dt != undefined)
					linkUrl += ", "+ dt ;
				linkUrl +=", warning("+ cnt + ")";
				linkUrl +="</span>";					
				linkUrl +="<br/>";
			}
		}
	});
	
	var e = this.event;
	
	// hs.Expand 두번뜨는것 방지
	for(var i=0 ;i<hs.expanders.length;i++){
		if(hs.expanders[i] == null)
			continue;
		else
			hs.expanders[i].close();
		//if(hs.expanders[i].maincontentText ==  linkUrl)
		//	hs.expanders[i].close(); //return;
	}
	
	hs.htmlExpand(null, {
        pageOrigin: {
            x: e.pageX || e.clientX,
            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
        },
        headingText: 'recent analysis link',
        maincontentText: linkUrl,
        width: 400
    })
}

function htmlExpandClass(pjtCode,className){
	var linkUrl = "";
	$.ajax({
		url : "./codesonarPriorityCsvLinkJson.html",
		async: false,
		data: {PJT_CODE: pjtCode },
		//data: $("#form").serialize(),
		success : function(responseData){
			var list = responseData.data;
			for(var i=0;i<list.length;i++){
				
				var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
				var csvnum = list[i].CSV_NUM;
				var priority1 = "&#34;"+className+"&#34;";
				
				
				
				if(!isFinishedCodeSonarProject(list[i].PJT_CODE))
					continue;
				
				//클래스별로 count 하기.
				var dataA = [];
				if($("#sPriority").val() != ''){
					
					dataA = $.grep(responseDataG,function(d){			
						var cls = eval("d['class']");
						if(d.project ==  list[i].PJT_CODE &&  d.priority == $("#sPriority").val() && cls == className)
							return d;
					});
				}else{
					dataA = $.grep(responseDataG,function(d){			
						var cls = eval("d['class']");
						if(d.project ==  list[i].PJT_CODE &&  cls == className)
							return d;
					});
				}
				
				var cnt = dataA.length;
				var link = "http://"+ svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=class=&#34;"+className+"&#34;";
				linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">";
				linkUrl +=list[i].PJT_CODE + ": "+className ;
				linkUrl +=", warning("+ cnt + ")";
				linkUrl +="</span>";
				linkUrl +="<br/>";
			}
		}
	});
	
	// hs.Expand 두번뜨는것 방지
	for(var i=0 ;i<hs.expanders.length;i++){
		if(hs.expanders[i] == null)
			continue;
		else
			hs.expanders[i].close();
		//if(hs.expanders[i].maincontentText ==  linkUrl)
		//	hs.expanders[i].close(); //return;
	}
	
	var e = this.event;
	hs.htmlExpand(null, {
        pageOrigin: {
            x: e.pageX || e.clientX,
            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
        },
        headingText: 'recent analysis link',
        maincontentText: linkUrl,
        width: 400
    })
}


function getCodesonarFileCsvLink(pjtCode,filename){
	var linkUrl = "";
	linkUrl = "<span style=\"cursor: pointer;\" onclick=\"htmlExpandFile('"+pjtCode+ "','" +filename+  "')\">"+filename+"</span>";
	return linkUrl;
}

function htmlExpandFile(pjtCode,file,obj){
	var linkUrl = "";		
	$.ajax({
		url : "./codesonarPriorityCsvLinkJson.html",
		async: false,
		data: {PJT_CODE: pjtCode },
		//data: $("#form").serialize(),
		success : function(responseData){
			var list = responseData.data;
			for(var i=0;i<list.length;i++){
				var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
				var csvnum = list[i].CSV_NUM;
				var link = "http://"+svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=";
				link += "file=" + "&#34;"+file+"&#34;";
				if(!isFinishedCodeSonarProject(list[i].PJT_CODE))
					continue;
				
				//클래스별로 count 하기.
				var dataA = [];
				var keys = [];
				keys.push(list[i].PJT_CODE);
				dataA = $.grep(responseDataG,function(d){			
					if(d.project ==  list[i].PJT_CODE &&  d.file == file)
						return d;
				});
				
				var cnt = dataA.length;
				
				linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">";
				//linkUrl += list[i].PJT_CODE + ": "+file;
				linkUrl += list[i].PJT_CODE ;
				linkUrl +=", warning("+ cnt + ")";
				linkUrl +="</span>";
				linkUrl +="<br/>";
			}
		}
	});
	
	var e = this.event;
	
	// hs.Expand 두번뜨는것 방지
	for(var i=0 ;i<hs.expanders.length;i++){
		if(hs.expanders[i] == null)
			continue;
		else
			hs.expanders[i].close();
		//if(hs.expanders[i].maincontentText ==  linkUrl)
		//	hs.expanders[i].close(); //return;
	}
	
	hs.htmlExpand(null, {
        pageOrigin: {
            x: e.pageX || e.clientX,
            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
        },
        headingText: 'recent analysis link',
        maincontentText: linkUrl,
        width: 400
    })
}

/** codesonar link function **/
function getCodesonarFunctionCsvLink(pjtCode,filename){
	var linkUrl = "";
	linkUrl = "<span style=\"cursor: pointer;\" onclick=\"htmlExpandFile('"+pjtCode+ "','" +filename+  "',this)\">"+filename+"</span>";
	return linkUrl;
}

function htmlExpandFunction(pjtCode,file,func){
	var linkUrl = "";
	$.ajax({
		url : "./codesonarPriorityCsvLinkJson.html",
		async: false,
		data: {PJT_CODE: pjtCode },
		//data: $("#form").serialize(),
		success : function(responseData){
			var list = responseData.data;
			for(var i=0;i<list.length;i++){
				var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
				var csvnum = list[i].CSV_NUM;
				
				if(!isFinishedCodeSonarProject(list[i].PJT_CODE))
					continue;
				
				//클래스별로 count 하기.
				var dataA = [];
				if(file != ''){
					dataA = $.grep(responseDataG,function(d){			
						if(d.project ==  list[i].PJT_CODE &&  d.file == file && d.procedure == func)
							return d;
					});
				}else{
					dataA = $.grep(responseDataG,function(d){			
						if(d.project ==  list[i].PJT_CODE &&  d.procedure == func)
							return d;
					});
				}
				
				var cnt = dataA.length;
				
				
				var link = "http://"+svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=(file="+file+")"+" procedure=&#34;"+func+"&#34;";
				linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">"
				linkUrl += file + ": "+ func ;
				linkUrl +=", warning("+ cnt + ")";
				linkUrl +="</span>";
				linkUrl +="<br/>";
			}
		}
	});
	
	
	var e = this.event;
	
	// hs.Expand 두번뜨는것 방지
	for(var i=0 ;i<hs.expanders.length;i++){
		if(hs.expanders[i] == null)
			continue;
		else
			hs.expanders[i].close();
		//if(hs.expanders[i].maincontentText ==  linkUrl)
		//	hs.expanders[i].close(); //return;
	}
	
	hs.htmlExpand(null, {
        pageOrigin: {
            x: e.pageX || e.clientX,
            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
        },
        headingText: 'recent analysis link',
        maincontentText: linkUrl,
        width: 400
    })
}



function htmlExpandIssueTrend(pjtCode,priority,obj){
	var linkUrl = "";
	var subProjects =[];
	subProjects.push('xxxx');
	$( "#subProjects :checkbox" ).each(function( index ) {
		if($(this).is(":checked",true))
			subProjects.push($( this ).val() );
	});
	
	$.ajax({
		url : "./jiraPkeyLinkJson.html",
		async: false,
		data: {PJT_CODE: pjtCode, subProjects: subProjects },
		//data: $("#form").serialize(),
		success : function(responseData){
			var list = responseData.data;
			for(var i=0;i<list.length;i++){
				//var svr = "jira.skhynix.com";
				var pkey = "&#34;"+ list[i].PKEY + "&#34;";
				//var priority1 = "\""+priority+"\"";
				
				var cnt = 0;  // subProject cnt;
				var index = subProjectInfo[list[i].PJT_CODE].length -1;
				cnt = subProjectInfo[list[i].PJT_CODE][index].gapStack;
				
				var link = "http://jira.skhynix.com/issues/?jql=project = " + pkey + " AND resolution = &#34;Unresolved&#34;";
				
				//priority
				var priorityList =[];
				//priorityList.push("&#34;" + 'xxxx' + "&#34;");
				$( "#priority :checkbox" ).each(function( index ) {
					if($(this).is(":checked",true))					
						priorityList.push("&#34;"+$( this ).val()+"&#34;" );
				});
				link += " AND priority in (" + priorityList.join(",") + ")";
				
				//IssueType
				var issueTypeList =[];
				//issueTypeList.push("&#34;" + 'xxxx' + "&#34;");
				$( "#issueType :checkbox" ).each(function( index ) {
					if($(this).is(":checked",true))
						issueTypeList.push("&#34;" + $( this ).val() + "&#34;");
				});
				link += " AND issuetype  in (" + issueTypeList.join(",") + ")";
				
				linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">"+list[i].PJT_CODE;
				linkUrl +=", unresolved("+cnt+")";
				linkUrl +="</span>";
				linkUrl +="<br/>";
			}
		}
	});
	
	var e = this.event;
	
	// hs.Expand 두번뜨는것 방지
	for(var i=0 ;i<hs.expanders.length;i++){
		if(hs.expanders[i] == null)
			continue;
		else
			hs.expanders[i].close();
		//if(hs.expanders[i].maincontentText ==  linkUrl)
		//	hs.expanders[i].close(); //return;
	}
	
	
	// 2015-10-28.  show resolution by root cause
	if(goJiraAnalysisByDateIssueType){
		var link = './goJiraCauseByDate.html';
		var date = obj.rawData.DEFECTS_DATE; // ex) "2015/10/20"
		linkUrl +="<span style=\"cursor: pointer;\" onclick=\"goJiraAnalysisByDateIssueType('"+pjtCode+"','"+date+"');\">";
		linkUrl +="resolution analysis("+date+")";
		linkUrl +="</span>";
		linkUrl +="<br/>";
	}
	
	
	hs.htmlExpand(null, {
        pageOrigin: {
            x: e.pageX || e.clientX,
            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
        },
        headingText: 'Recent unresolve issue',
        maincontentText: linkUrl,
        width: 350
    })
}


/** jira link  priority **/
function getJiraPriorityCsvLink(pjtCode,priority){
	var linkUrl = "";
	linkUrl += "<span style=\"cursor: pointer;\" onclick=\"htmlExpandIssuePriority('"+pjtCode+ "','" +priority+  "')\">"+priority+"</span>";
	return linkUrl;
}



function htmlExpandIssueType(pjtCode,priority,issuetype){
	var linkUrl = "";
	$.ajax({
		url : "./jiraPkeyLinkJson.html",
		async: false,
		data: {PJT_CODE: pjtCode },
		//data: $("#form").serialize(),
		success : function(responseData){
			var list = responseData.data;
			for(var i=0;i<list.length;i++){
				var pjt_code = list[i].PJT_CODE;
				//var svr = "jira.skhynix.com";
				var pkey = list[i].PKEY;
				//var priority1 = "\""+priority+"\"";
				
				var cnt = 0;  // subProject cnt;
				
				//클래스별로 count 하기.
				var dataA = [];
				
				dataA = $.grep( responseDataG.data ,function(d){			
					if(pjt_code == d.PROJECT && d.ISSUETYPE == issuetype)
						return d;
				});
				
				$.each(dataA,function(index,d){
					cnt += d.UNRESOLVED;
				});
				//var cnt = dataA.length;
				
				var link = "http://jira.skhynix.com/issues/?jql=project = &#34" + pkey + "&#34 AND resolution = &#34Unresolved&#34";
				if(priority != "")
					link +=" AND priority = &#34"+ priority +"&#34";		
				link +=" AND issuetype =&#34" + issuetype+"&#34";
				linkUrl += "<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">"+list[i].PJT_CODE ;
				//linkUrl += ", " + priority ;
				linkUrl += ", "+ issuetype ;
				linkUrl +=", unresolved("+cnt+")";
				linkUrl += "</span>";
				linkUrl += "<br/>";
			}
		}
	});
	
	var e = this.event;
	
	// hs.Expand 두번뜨는것 방지
	for(var i=0 ;i<hs.expanders.length;i++){
		if(hs.expanders[i] == null)
			continue;
		else
			hs.expanders[i].close();
		//if(hs.expanders[i].maincontentText ==  linkUrl)
		//	hs.expanders[i].close(); //return;
	}
	
	hs.htmlExpand(null, {
        pageOrigin: {
            x: e.pageX || e.clientX,
            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
        },
        headingText: 'Recent unresolve issue',
        maincontentText: linkUrl,
        width: 350
    })
}


function htmlExpandIssuePriority(pjtCode,priority){
	var linkUrl = "";
	$.ajax({
		url : "./jiraPkeyLinkJson.html",
		async: false,
		data: {PJT_CODE: pjtCode },
		//data: $("#form").serialize(),
		success : function(responseData){
			var list = responseData.data;
			for(var i=0;i<list.length;i++){
				var pjt_code = list[i].PJT_CODE;
				//var svr = "jira.skhynix.com";
				var pkey = list[i].PKEY;
				//var priority1 = "\""+priority+"\"";
				
				var cnt = 0;  // subProject cnt;
				
				//클래스별로 count 하기.
				var dataA = [];
				
				dataA = $.grep( responseDataG.data ,function(d){			
					if(pjt_code == d.PROJECT && d.PRIORITY == priority)
						return d;
				});
				
				$.each(dataA,function(index,d){
					cnt += d.UNRESOLVED;
				});
				//var cnt = dataA.length;
				
				
				var link = "http://jira.skhynix.com/issues/?jql=project = &#34" + pkey + "&#34 AND resolution = &#34Unresolved&#34";
				link +=" AND priority = &#34"+ priority + "&#34";		
				linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">";
				linkUrl +=list[i].PKEY +": " ;
				linkUrl +=priority ;
				linkUrl +=", unresolved("+cnt+")";
				linkUrl +="</span>";
				linkUrl +="<br/>";
			}
		}
	});
	
	var e = this.event;
	
	// hs.Expand 두번뜨는것 방지
	for(var i=0 ;i<hs.expanders.length;i++){
		if(hs.expanders[i] == null)
			continue;
		else
			hs.expanders[i].close();
		//if(hs.expanders[i].maincontentText ==  linkUrl)
		//	hs.expanders[i].close(); //return;
	}
	
	hs.htmlExpand(null, {
        pageOrigin: {
            x: e.pageX || e.clientX,
            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
        },
        headingText: 'Recent unresolve issue',
        maincontentText: linkUrl,
        width: 350
    })
}



/** hsClick **/
function hsClick(url,obj){
	window.open(url, '_blank');
	//window.focus();
	//hs.close(obj);
}


function isFinishedCodeSonarProject(pjtcode){
	for(var i=0;i<projectListRawG.length;i++){
		var p = projectListRawG[i].project;
		var state = projectListRawG[i].state;
		if(p== pjtcode && state == "Finished"){
			return true;
		}
	}
	if(projectListRawG.length==0)
		return true;
	
	return false;
}



function groupby(json,pkey){
	var abcArr = json;

	var items = {}, base, key,val ;
	for (var i = 0; i < abcArr.length; i++) {
	    base = abcArr[i];
	   // key = base['priority'];
	    key = base[pkey];
	    //val = 'cnt';
	    // if not already present in the map, add a zeroed item in the map
	    if (!items[key]) {
		items[key] = 0;
	    }
	    // add new item to the map entry
	    items[key]++;
	}

	// Now, generate new array
	var outputArr = [], temp;
	for (key in items) {
	    // create array entry for the map value
	    temp = [key, items[key]]
	    // put array entry into the output array
	    outputArr.push(temp);
	}
	
	return outputArr;
}


function groupby1(json,pkeys,tCol){
	var abcArr = json;
	var pkey
	
	var items = {}, base, key,val ;
	for (var i = 0; i < abcArr.length; i++) {
	    base = abcArr[i];
	   // key = base['priority'];
	    key = base[pkey];
	    //val = 'cnt';
	    // if not already present in the map, add a zeroed item in the map
	    if (!items[key]) {
		items[key] = 0;
	    }
	    // add new item to the map entry
	    items[key]++;
	}

	// Now, generate new array
	var outputArr = [], temp;
	for (key in items) {
	    // create array entry for the map value
	    temp = [key, items[key]];
	    // put array entry into the output array
	    outputArr.push(temp);
	}
	
	return outputArr;
}

/**
 * groupBy
 * @param json: 원본데이타
 * @param pkeys: 그룹 컬럼
 * @param tCol: 합칠컬럼명
 */
function groupbySum(json,pkeys,tCol){
	var abcArr = json;
	var items = {}, base, key,val ;
	for (var i = 0; i < abcArr.length; i++) {
	    base = abcArr[i];
	    
	    var pkey = '';
	    var key = '';
	    for(var j=0; j < pkeys.length; j++){
	    	pkey = pkeys[j];
	    	if(j>0)
	    		key += ";;;";
	    	key += base[pkey];
	    }
	    // if not already present in the map, add a zeroed item in the map
	    if(!items[key]){
	    	items[key] = null;
	    }
	    	
	    // add new item to the map entry
	    if(base[tCol] != undefined)
	    	items[key] += base[tCol];
	}

	// Now, generate new array
	var outputArr = [], temp;
	for (key in items) {
	    // create array entry for the map value
	    //temp = [key, items[key]];
		temp = {};
		temp[tCol] =  items[key];
		//temp.key =  items[key];
	    for(var j=0; j < pkeys.length; j++){
	    	var pkey = pkeys[j];
	    	//if(temp[pkey])
	    		temp[pkey] = key.split(';;;')[j];
	    }
	    // put array entry into the output array
	    outputArr.push(temp);
	}
	
	return outputArr;
}


/**
 * groupBy Average 특정필드의 평균을 구한다.
 * @param json: 원본데이타
 * @param pkeys: 그룹 컬럼
 * @param tCol: 합칠컬럼명
 */
function groupbyAvg(json,pkeys,tCol){
	var abcArr = json;
	var items = {}, base, key,val ;
	for (var i = 0; i < abcArr.length; i++) {
	    base = abcArr[i];
	    
	    var pkey = '';
	    var key = '';
	    for(var j=0; j < pkeys.length; j++){
	    	pkey = pkeys[j];
	    	if(j>0)
	    		key += ";;;";
	    	key += base[pkey];
	    }
	    // if not already present in the map, add a zeroed item in the map
	    if(!items[key]){
	    	items[key] = {sum:0,count:0};
	    }
	   
	    
	    // add new item to the map entry
	    if(base[tCol] != undefined)
	    	items[key].sum +=base[tCol];	 
	    if(base[tCol] != undefined)
	    	items[key].count ++;
	   
	}

	// Now, generate new array
	var outputArr = [], temp;
	for (key in items) {
	    // create array entry for the map value
	    //temp = [key, items[key]];
		temp = {};
		temp[tCol] =  items[key].sum;
		temp.count =  items[key].count;
		temp.average = temp[tCol]/temp.count;
		//temp.key =  items[key];
	    for(var j=0; j < pkeys.length; j++){
	    	var pkey = pkeys[j];
	    	//if(temp[pkey])
	    		temp[pkey] = key.split(';;;')[j];
	    }
	    // put array entry into the output array
	    outputArr.push(temp);
	}
	
	return outputArr;
}


function groupbyCount(json,pkeys){
	var abcArr = json;
	var items = {}, base, key,val ;
	for (var i = 0; i < abcArr.length; i++) {
	    base = abcArr[i];
	    
	    var pkey = '';
	    var key = '';
	    for(var j=0; j < pkeys.length; j++){
	    	pkey = pkeys[j];
	    	if(j>0)
	    		key += ";;;";
	    	key += base[pkey];
	    }
	    // if not already present in the map, add a zeroed item in the map
	    if(!items[key]){
	    	items[key] = 0;
	    }
	    	
	    // add new item to the map entry
	    items[key]++;
	}

	// Now, generate new array
	var outputArr = [], temp;
	for (key in items) {
	    // create array entry for the map value
	    //temp = [key, items[key]];
		temp = {};
		//temp[tCol] =  items[key];
		temp.count =  items[key];
		
		//create original columns
	    for(var j=0; j < pkeys.length; j++){
	    	var pkey = pkeys[j];
	    	//if(temp[pkey])
	    		temp[pkey] = key.split(';;;')[j];
	    }
	    // put array entry into the output array
	    outputArr.push(temp);
	}
	
	return outputArr;
}

function getUrlByPjtcode(pjtcode,pCol){
	//01. projectList
	for(var i=0;i<projectListG.length;i++){
		var project = projectListG[i];
		if(project.PJT_CODE == pjtcode){
			//02. mapping list
			var rtnArr = [];
			var mapList = $.grep(projectMapG, function (map) {
				if(map.PJT_CODE_MAP == project.PJT_CODE)
					return true;
			});
			
			$.each(mapList,function(index,map){
				$.grep(projectListRawG,function(raw){
					if(raw.project == map.PJT_CODE_RAW && raw.state == "Finished")
						rtnArr.push(raw[pCol]);
				});
			});
			return rtnArr;
		}
			
	}
}

var default_cmp = function(a, b) {
    if (a == b) return 0;
    return a < b ? -1 : 1;
},
getCmpFunc = function(primer, reverse) {
    var dfc = default_cmp, // closer in scope
        cmp = default_cmp;
    if (primer) {
        cmp = function(a, b) {
            return dfc(primer(a), primer(b));
        };
    }
    if (reverse) {
        return function(a, b) {
            return -1 * cmp(a, b);
        };
    }
    return cmp;
};

// actual implementation
var sort_by = function() {
	var fields = [],
	    n_fields = arguments.length,
	    field, name, reverse, cmp;
	
	// preprocess sorting options
	for (var i = 0; i < n_fields; i++) {
	    field = arguments[i];
	    if (typeof field === 'string') {
	        name = field;
	        cmp = default_cmp;
	    }
	    else {
	        name = field.name;
	        cmp = getCmpFunc(field.primer, field.reverse);
	    }
	    fields.push({
	        name: name,
	        cmp: cmp
	    });
	}
	
	// final comparison function
	return function(A, B) {
	    var a, b, name, result;
	    for (var i = 0; i < n_fields; i++) {
	        result = 0;
	        field = fields[i];
	        name = field.name;
	
	        result = field.cmp(A[name], B[name]);
	        if (result !== 0) break;
	    }
	    return result;
	}
}
// ex: homes.sort(sort_by('city', {name:'price', primer: parseInt, reverse: true}));


function sortObjects(objArray, properties /*, primers*/) {
    var primers = arguments[2] || {}; // primers are optional

    /*properties = properties.map(function(prop) {
        if( !(prop instanceof Array) ) {
            prop = [prop, 'asc']
        }
        if( prop[1].toLowerCase() == 'desc' ) {
            prop[1] = -1;
        } else {
            prop[1] = 1;
        }
        return prop;
    });*/
    
    properties = $.map(properties,function(prop) {
    	var rtnProp = {col:'',order:''};
    	
        if( !(prop instanceof Array) ) {
        	rtnProp.col = prop;
        	rtnProp.order = 'asc';
        }else{
        	rtnProp.col = prop[0];
        	rtnProp.order = prop[1];
        }
        
        if( rtnProp.order == 'desc' ) {        	
        	rtnProp.order = -1;
        } else {
        	rtnProp.order = 1;
        }
        return rtnProp;
    });

    function valueCmp(a, b) {
    	var ax = [], bx = [];
    	if(a == undefined || b == undefined)
    		return 0;
    	if(typeof a == 'number') a = a + '';
    	if(typeof b == 'number') b = b + '';
    	
        a.replace(/(\d+)|(\D+)/g, function(_, $1, $2) { ax.push([$1 || Infinity, $2 || ""]) });
        b.replace(/(\d+)|(\D+)/g, function(_, $1, $2) { bx.push([$1 || Infinity, $2 || ""]) });
        
        while(ax.length && bx.length) {
            var an = ax.shift();
            var bn = bx.shift();
            var nn = (an[0] - bn[0]) || an[1].localeCompare(bn[1]);
            if(nn) return nn;
        }

        //return ax.length - bx.length;
        return ax > bx ? 1 : ax < bx ? -1 : 0; 
    }

    function arrayCmp(a, b) {
        var arr1 = [], arr2 = [];
        /*properties.forEach(function(prop) {
            var aValue = a[prop[0]],
                bValue = b[prop[0]];
            if( typeof primers[prop[0]] != 'undefined' ) {
                aValue = primers[prop[0]](aValue);
                bValue = primers[prop[0]](bValue);
            }
            arr1.push( prop[1] * valueCmp(aValue, bValue) );
            arr2.push( prop[1] * valueCmp(bValue, aValue) );
        });*/
        
        $.each(properties,function(index,prop) {
            var aValue = a[prop.col],
                bValue = b[prop.col];
            if( typeof primers[prop.col] != 'undefined' ) {
                aValue = primers[prop.col](aValue);
                bValue = primers[prop.col](bValue);
            }
            arr1.push( prop.order * valueCmp(aValue, bValue) );
            arr2.push( prop.order * valueCmp(bValue, aValue) );
        });
        
        return arr1 < arr2 ? -1 : 1;
    }

    objArray.sort(function(a, b) {
        return arrayCmp(a, b);
    });
}
//ex : sortObjects(thisList, ['NATL_CD', ['YYYYMM', 'asc']]/* , {city: demoPrimer} */);


function unique(pArray,pCol){
	var rtnArray = [];
	for(var i=0;i<pArray.length;i++){
		rtnArray.push(pArray[i][pCol]);
	}	
	var rtnArray = jQuery.unique(rtnArray);
	return rtnArray;
}

function arrayContain(pArray,pSearch){
	var rtn = false;	
	for(var i =  0; i< pArray.length ; i++){
		
		var isEqual = true;
		for( var j=0; j< pSearch.length ; j++){
			var search = pSearch[j];
			try{
				if(!pArray[i][search.col]){
					//console.log(pArray[i]);
				}
				if(pArray[i][search.col] != search.val){
					isEqual = false;
					break;
				}
			}catch(err){
				//console(search);
			}
							
		}
		
		if(isEqual)
			return true;
	}
	return rtn;
}


// jqGrid rowSpan
var arrtSetting_20150520 = function (rowId, val, rawObject, cm) {
    //var attr = rawObject.attr[cm.name], result;
		var attr = rawObject[cm.name], result;
    if (attr.rowspan) {
        result = ' rowspan=' + '"' + attr.rowspan + '"';
    } else if (attr.display) {
        result = ' style="display:' + attr.display + '"';
    }
    return result;
};

var arrtSetting = function (rowId, val, rawObject, cm) {
    //var attr = rawObject.attr[cm.name], result;
	var rownum = parseInt(rowId,10) -1 ;
	var rowspan = 1; 
	var preVal = "";
	var postVal = "";
	var attr = rawObject[cm.name], result;
	
	if(rownum == 0)
		rowspan =  jqGridRowSpan(rawObject.allData,rownum +1, cm.name, 1);
	//else if(rownum == (rawObject.allData.length-1) )
	//	rowspan = 1;
	else{
		//01. 이전값
		preVal = rawObject.allData[rownum - 1][cm.name];
		//02. 이후값
		//postVal = rawObject.allData[rownum + 1][cm.name];
		//03. 이전값과 현재값이 같으면 recursive 함수를 돌린다.
		if(preVal != val)
			rowspan = jqGridRowSpan(rawObject.allData,rownum +1, cm.name, 1);
	}
	
	if(rowspan > 1)
		result = ' rowspan=' + '"' + rowspan + '"';
	else
		result = ' style="display:' + 'none' + '"';
	
    return result;
};


function jqGridRowSpan(list,rownum,col,rowspan){
	var preVal = list[rownum-1][col];
	var curVal = list[rownum][col];
	if(rownum == (list.length-1) && preVal == curVal)
		return  ++rowspan;
	else if(preVal == curVal)
		return jqGridRowSpan(list,rownum+1,col,rowspan+1);
	else
		return rowspan;
}

function getDrillDownData(drillDownId,srcObj,keyArray,pSearch,xCol,yCol){
	var drilldown = {
		id: drillDownId,
		data:[]
	};
	
	var data = groupbySum(srcObj,keyArray,yCol);
	var rtn = [];
	for(var i=0;i<data.length;i++){
		var d = data[i];
		d.y = d[yCol];
		d.x = convertDateToUct(d[xCol]);
		
		///////////////////////////
		var isEqual = true;
		for( var j=0; j< pSearch.length ; j++){
			var search = pSearch[j];			
			if(!data[i][search.col]){
				//console.log(pArray[i]);
			}
			if(data[i][search.col] != search.val){
				isEqual = false;
				break;
			}							
		}
		
		if(isEqual){
			drilldown.data.push(d);
		}			
		//////////////////
	}
	
	return drilldown;
}

// seriesKey : 시리즈로 나눌 키.{cd:string, name:string}
function getDrillDownDataSeries(drillDownId,srcObj,keyArray,pSearch,xCol,yCol,seriesKey){
	var drilldownList = {
			keys : [] , // multi drilldown keys
			series : [] 
	};
	
	var drilldown = {
		id: '',
		data:[]
	};
	var drillseries = {};
	
	var data = groupbySum(srcObj,keyArray,yCol);	
	var dataFiltered = [];
	var rtn = [];
	for(var i=0;i<data.length;i++){
		var d = data[i];
		d.y = d[yCol];
		d.x = convertDateToUct(d[xCol]);
		
		///////////////////////////
		var isEqual = true;
		for( var j=0; j< pSearch.length ; j++){
			var search = pSearch[j];			
			if(!data[i][search.col]){
				//console.log(pArray[i]);
			}
			if(data[i][search.col] != search.val){
				isEqual = false;
				break;
			}							
		}
		
		if(isEqual){
			dataFiltered.push(d);
		}			
		//////////////////
	}
	
	
	sortObjects(dataFiltered, keyArray);
	
	// Start: 빠진날짜가 있으면 0을 삽입한다.
	var uDt = groupbyCount(dataFiltered,[xCol]);
	var uGroup = groupbyCount(dataFiltered,[seriesKey.cd,seriesKey.name]);
	
	for(var i = 0;i<uDt.length; i++){
		var dt =  uDt[i];
		
		for( var j=0;j<uGroup.length; j++){
			var search = [];
			$.each(seriesKey,function(index,d){
				search.push({col : d.cd , val : uGroup[d.cd] });
			});
			search.push({col : seriesKey.cd , val : uGroup[j][seriesKey.cd] });
			search.push({col : seriesKey.name , val : uGroup[j][seriesKey.name] });
			search.push({col : xCol , val : dt[xCol] });
			
			if(!arrayContain(dataFiltered,search)){
				var nilObj = $.extend({}, dataFiltered[0]);
				$.each(search,function(index,val){
					nilObj[val.col] = val.val;
				});
				nilObj[xCol] = dt[xCol];
				nilObj[yCol] = 0;
				nilObj.y = 0;
				nilObj.x = convertDateToUct(nilObj[xCol]);
				dataFiltered.push(nilObj);
			}
		}
			
	}
	sortObjects(dataFiltered, keyArray);
	// End: 빠진날짜가 있으면 0을 삽입한다.
	
	//drillDown 을 series로 나눈다.
	var seriesPre = ''; var seriesCur='';
	
	for(var i=0; i < dataFiltered.length ; i++){
		var d = dataFiltered[i];
		seriesCur = d[seriesKey.cd];
		if(seriesPre == '' || seriesPre != seriesCur){
			drillseries = {};
			if(drillDownId != '')
				drillseries.id = drillDownId + '-' + seriesCur;
			else
				drillseries.id = seriesCur
				
			drillseries.name = d[seriesKey.name];
			drillseries.data = [];
			
			drilldownList.series.push(drillseries);
			drilldownList.keys.push(drillseries.id);
		}
		drillseries.data.push(d);
		seriesPre = d[seriesKey.cd];
	}	
	
	return drilldownList;
}



/**
 * gantt chart 용 bar type 동 커버하기 위함. getDrillDownDataSeries 좀더 유연하게 활용할 수 있음.
 * @param seriesKey: 시리즈로 나눌 키.{cd:string, name:string}
 * @param convertDefiines: 바꿀컬럼정의. [{col:'', convert:'',datatype:'date',isnull:''},..]
 * @param xCol: xAxis category에 해당하는 컬럼. string.  ''이면 값을 삽입하지 않는다. 
 * @param tCol : groupbysum시 sum컬럼
 * @param colors : series 컬러{name:'color'}
 */
function getDrillDownDataSeries2(drillDownId,srcObj,keyArray,pSearch,convertDefiines,xCol,tCol,seriesKey,options){
	var drilldownList = {
			keys : [] , // multi drilldown keys
			series : [] 
	};
	
	var drilldown = {
		id: '',
		data:[]
	};
	var drillseries = {};
	var data = [];
	
	if(options == undefined)
		options = {};
	
	if(options.isGroupby == undefined || options.isGroupby == null)
		options.isGroupby = true;
	if(options.isGroupby)
		data = groupbySum(srcObj,keyArray,tCol);	
	else
		data = srcObj;
	var dataFiltered = [];
	var rtn = [];
	for(var i=0;i<data.length;i++){
		var d = data[i];
		$.each(convertDefiines,function(index,col){
			if((d[col.col]==null || d[col.col] == undefined || isNaN(d[col.col]) ) && col.hasOwnProperty('isnull'))
				d[col.col] = col.isnull ;
			
			if(col.datatype == 'date'){
				d[col.convert] = convertDateToUct(d[col.col]);
				
			}else if(col.datatype == 'int'){
				d[col.convert] = d[col.col]*1;
			}else{
				d[col.convert] = d[col.col];
			}
			
		});
		
		///////////////////////////
		var isEqual = true;
		for( var j=0; j< pSearch.length ; j++){
			var search = pSearch[j];			
			if(!data[i][search.col]){
				//console.log(pArray[i]);
			}
			
			if(typeof search.val == 'string'){
				if(data[i][search.col] != search.val){
					isEqual = false;
					break;
				}							
			}else{
				//list인경우
				//if(search.val.indexOf(data[i][search.col]) < 0 ){
				if($.inArray(data[i][search.col],search.val) < 0 ){
					isEqual = false;
					break;
				}							
				
			}
			
		}
		
		if(isEqual){
			dataFiltered.push(d);
		}			
		//////////////////
	}
	
	if(options.isSort == undefined || options.isSort == true)
		sortObjects(dataFiltered, keyArray);
	
	// Start: 빠진날짜가 있으면 0을 삽입한다.
	//uDt : category , uGroup: category
	if(typeof xCol == 'string'){
		xCol = [xCol,'asc'];
	}
	if(xCol[0] != ''){
		//var uDt = groupbyCount(dataFiltered,[xCol]);
		var uDt = groupbyCount(dataFiltered,[xCol[0]]);
		
		//x축정렬
		if(options.xSortColumn != undefined){
			uDt.sort(function(a,b){
				var aSeq = getFilteredData(dataFiltered,[{col : xCol[0] , val : a[xCol[0]]}],[])[0][options.xSortColumn];
				var bSeq = getFilteredData(dataFiltered,[{col : xCol[0] , val : b[xCol[0]]}],[])[0][options.xSortColumn];
				return aSeq > bSeq?1:-1;
			});
		}
		
		
		var uGroup = groupbyCount(dataFiltered,[seriesKey.cd,seriesKey.name]);
		
		for(var i = 0;i<uDt.length; i++){
			var dt =  uDt[i];
			
			for( var j=0;j<uGroup.length; j++){
				var search = [];
				//$.each(seriesKey,function(index,d){
				//	search.push({col : d.cd , val : uGroup[d.cd] });
				//});
				search.push({col : seriesKey.cd , val : uGroup[j][seriesKey.cd] });
				search.push({col : seriesKey.name , val : uGroup[j][seriesKey.name] });
				search.push({col : xCol[0] , val : dt[xCol[0]] });
				
				var dataListByXCol = getFilteredData(dataFiltered,[{col : xCol[0] , val : dt[xCol[0]] }],keyArray);
				
				if(!arrayContain(dataFiltered,search)){
					
					//var nilObj = $.extend({}, dataFiltered[0]);
					var nilObj = {};
					$.each(dataFiltered[0],function(key,val){
						nilObj[key] = null;
					});
					
					$.each(search,function(index,val){
						nilObj[val.col] = val.val;
					});
					
					$.each(keyArray,function(index, key){
						if(nilObj[key] == null)
							nilObj[key] = dataListByXCol[0][key];
					});
					
					$.each(convertDefiines,function(index,col){
						
						if((nilObj[col.col]==null || nilObj[col.col] == undefined || isNaN(nilObj[col.col]) ) && col.hasOwnProperty('isnull'))
							nilObj[col.col] = col.isnull ;
						
						if(col.datatype == 'date'){
							nilObj[col.convert] = convertDateToUct(nilObj[col.col]);
						}else{
							nilObj[col.convert] = nilObj[col.col];
						}
						
					});		
					
					dataFiltered.push(nilObj);
					
				}
			}			
		}
		if(options.isSort == undefined || options.isSort == true)
			sortObjects(dataFiltered, keyArray);
		var category = [];
		
		if(options.isSort == undefined || options.isSort == true)
			sortObjects(uDt, xCol);
		for(var i = 0;i<uDt.length; i++){
			category.push(uDt[i][xCol[0]]);
		}
		//x축정렬
		if(options.xSortColumn != undefined){
			category.sort(function(a,b){
				var aSeq = getFilteredData(dataFiltered,[{col : xCol[0] , val : a}],[])[0][options.xSortColumn];
				var bSeq = getFilteredData(dataFiltered,[{col : xCol[0] , val : b}],[])[0][options.xSortColumn];
			  return aSeq > bSeq?1:-1;
			});
		}
		
		
		drilldownList.category = category;
		drilldownList.uDt = uDt;
	}
	// End: 빠진날짜가 있으면 0을 삽입한다.
	
	//drillDown 을 series로 나눈다.
	var seriesPre = ''; var seriesCur='';
	
	for(var i=0; i < dataFiltered.length ; i++){
		var d = dataFiltered[i];
		seriesCur = d[seriesKey.cd];
		if(seriesPre == '' || seriesPre != seriesCur){
			drillseries = {};
			
			if(drillDownId != '')
				drillseries.id = drillDownId + '-' + seriesCur;
			else
				drillseries.id = seriesCur
				
			drillseries.name = d[seriesKey.name];
			if(phaseColor[drillseries.name] != undefined)
				drillseries.color = phaseColor[drillseries.name];
			drillseries.data = [];
			
			drilldownList.series.push(drillseries);
			drilldownList.keys.push(drillseries.id);
			
		}
		drillseries.data.push(d);
		seriesPre = d[seriesKey.cd];
	}	
	
	
	
	return drilldownList;
}

function convertDateToUct(date,splitStr){
	var utcdt ;
	var dt = "";
	if(splitStr == undefined || splitStr == null || splitStr == ""){
		dt = date.substr(0,4) + "/" + date.substr(4,2) + "/" + date.substr(6,2);
		splitStr = "/";
	}else{
		dt = date;
	}
	var dateSplit = dt.split(splitStr);
	utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]);
	
	return utcdt;
}

function dateAdd(date,addnum,splitStr){
	var utcdt ;
	var dt = "";
	var splitStrNew = "";
	if(splitStr == undefined || splitStr == null || splitStr == ""){
		dt = date.substr(0,4) + "/" + date.substr(4,2) + "/" + date.substr(6,2);
		splitStrNew = "/";
		splitStr = "";
	}else{
		dt = date;
		splitStrNew = splitStr;
	}
	
	var dateSplit = dt.split(splitStrNew);
	
	var dt1 = new Date(dateSplit[0],dateSplit[1] -1 ,dateSplit[2]);
	var dt2= new Date(dt1.getFullYear(),dt1.getMonth(),dt1.getDate()+addnum); 
	
	var rtnDt = pad('0000',dt2.getFullYear(),true) + pad('00',dt2.getMonth() +1,true) + pad('00',dt2.getDate(),true);
	
	return rtnDt;
}

function monthAdd(date,addnum,splitStr){
	var utcdt ;
	var dt = "";
	var splitStrNew = "";
	if(splitStr == undefined || splitStr == null || splitStr == ""){
		dt = date.substr(0,4) + "/" + date.substr(4,2) + "/" + date.substr(6,2);
		splitStrNew = "/";
		splitStr = "";
	}else{
		dt = date;
		splitStrNew = splitStr;
	}
	
	var dateSplit = dt.split(splitStrNew);
	
	var dt1 = new Date(dateSplit[0],dateSplit[1]-1,dateSplit[2]);
	var dt2= new Date(dt1.getFullYear(),dt1.getMonth() + addnum, dt1.getDate()); 
	
	var rtnDt = pad('0000',dt2.getFullYear(),true) + pad('00',dt2.getMonth() + 1,true) + pad('00',dt2.getDate(),true);
	
	
	return rtnDt;
}

function getDateDiff(date1,date2)
{
    var arrDate1 = date1.split("-");
    var getDate1 = new Date(parseInt(arrDate1[0],10),parseInt(arrDate1[1],10)-1,parseInt(arrDate1[2],10));
    var arrDate2 = date2.split("-");
    var getDate2 = new Date(parseInt(arrDate2[0],10),parseInt(arrDate2[1],10)-1,parseInt(arrDate2[2],10));
    
    var getDiffTime = getDate1.getTime() - getDate2.getTime();
    
    return Math.floor(getDiffTime / (1000 * 60 * 60 * 24));
}

function pad(pad, str, padLeft) {
	if (typeof str === 'undefined')
		return pad;
	if (padLeft) {
		return (pad + str).slice(-pad.length);
	} else {
		return (str + pad).substring(0, pad.length);
	}
}

// pFilters : col,val
function getFilteredData(data, pFilters,pSorts){
	var dataFiltered = [];
	var rtn = [];
	for(var i=0;i<data.length;i++){
		var d = data[i];
		
		///////////////////////////
		var isEqual = true;
		for( var j=0; j< pFilters.length ; j++){
			var search = pFilters[j];			
			
			if(data[i][search.col] != search.val){
				isEqual = false;
				break;
			}							
		}
		
		if(isEqual){
			dataFiltered.push(d);
		}			
		//////////////////
	}	
	
	sortObjects(dataFiltered, pSorts);
	
	return dataFiltered;
}

function setAlldataInList(dataList){
	$.each(dataList,function(index,val){
		val.allData = dataList;
	});
}


Highcharts.TAT = function (options, callback) {
    var defaultOptions = {
        chart: {
            renderTo: (options.chart && options.chart.renderTo) || this,
            backgroundColor: null,
            borderWidth: 0,
            type: 'bar',
            margin: [-10, 0, -10, -10],
            //width: 600,
            height: 30,
            style: {
                overflow: 'visible'
            },
            skipClone: true
        },
        exporting:{buttons:[]} ,
        title: {
            text: ''
        },
        credits: {
            enabled: false
        },
        xAxis: {
            labels: {
                enabled: false
            },
            title: {
                text: null
            },
            startOnTick: false,
            endOnTick: false
            ,tickPositions: [1]
            ,tickLength :0
        },
        yAxis: {
        	type: 'datetime',
            endOnTick: false,
            startOnTick: false,
            labels: {
                enabled: false
            },
            title: {
                text: null
            }
            ,tickPositions: [1]
            ,tickLength :0
            
        },
        legend: {
            enabled: false
        },
        tooltip: {
        	//enabled:false ,
            backgroundColor: null,
            //borderWidth: 0,
            shadow: false,
            useHTML: true,
            hideDelay: 0,
            shared: false,
            padding: 0,
            positioner: function (w, h, point) {
                return { x: point.plotX - w , y: point.plotY - h};
            }
           /* ,formatter: function() {
                //console.log(this.point);
                var point = this.point;
                return Highcharts.dateFormat('%y/%m/%e', point.low) + ' - ' +  Highcharts.dateFormat('%y/%m/%e', point.y);
            }*/
        },
        plotOptions: {
            /*series: {
                animation: false,
                lineWidth: 1,
                shadow: false,
                states: {
                    hover: {
                        lineWidth: 1
                    }
                },
                marker: {
                    radius: 1,
                    states: {
                        hover: {
                            radius: 2
                        }
                    }
                },
                fillOpacity: 0.25
            },*/
            bar: {
            	grouping:false
            	//,edgeWidth: 0
            	//,groupZPadding: 0
            	//,groupPadding: 0
            	,dataLabels: {
                    enabled: true,
                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'black',
                    inside:true,
                    format:'{point.options.PHASE_NAME}({point.options.TAT})'
            	}
            },
            column: {
                negativeColor: '#910000',
                borderColor: 'silver'
            }
        }
    };
    options = Highcharts.merge(defaultOptions, options);

    return new Highcharts.Chart(options, callback);
};

Highcharts.SocDesign = function (options, callback) {
    var defaultOptions = {
        chart: {
            renderTo: (options.chart && options.chart.renderTo) || this,
            backgroundColor: null,
            borderWidth: 0,
            type: 'bar',
            //margin: [-10, 0, -10, -10],
            margin: [-10, 10, -10, 0],
            //width: 600,
            height: 22,
            style: {
                overflow: 'visible'
            },
            skipClone: true
        },
        exporting:{buttons:[]} ,
        title: {
            text: ''
        },
        credits: {
            enabled: false
        },
        xAxis: {
            labels: {
                enabled: false
            },
            title: {
                text: null
            },
            //startOnTick: false,
            //endOnTick: false
            tickPositions: [0]
            ,tickLength :0
            ,lineWidth :0
        },
        yAxis: {
        	//type: 'datetime',
            endOnTick: false,
            startOnTick: false,
            labels: {
                enabled: false
            },
            title: {
                text: null
            }
            ,tickPositions: []
            ,tickLength :0
            ,min:0
            ,max: 100
            ,tickWidth :0
        },
        legend: {
            enabled: false
        },
        tooltip: {
        	//enabled:false ,
            backgroundColor: null,
            //borderWidth: 0,
            shadow: false,
            useHTML: true,
            hideDelay: 0,
            shared: false,
            padding: 0,
            positioner: function (w, h, point) {
                return { x: point.plotX - w , y: point.plotY - h};
            } , 
        	//headerFormat: '<span style="font-size: 10px">' + $td.parent().find('td').html() + '</span><br/>',
	        headerFormat:'',
	        //pointFormat: '<b>{point.options.EST_START_DATE} - {point.options.EST_END_DATE}</b>'
	        //pointFormat: '<b>{point.options.PHASE_NAME}: {point.low:%y/%m/%e} - {point.y:%y/%m/%e}</b></br>'
	        //pointFormat: '<b>{point.options.RATIO}({point.options.PASS}/{point.options.CASES})'
	        pointFormat: '<b>case: {point.options.CASES}, pass: {point.options.PASS}'
           /* ,formatter: function() {
                //console.log(this.point);
                var point = this.point;
                return Highcharts.dateFormat('%y/%m/%e', point.low) + ' - ' +  Highcharts.dateFormat('%y/%m/%e', point.y);
            }*/
        },
        plotOptions: {
            /*series: {
                animation: false,
                lineWidth: 1,
                shadow: false,
                states: {
                    hover: {
                        lineWidth: 1
                    }
                },
                marker: {
                    radius: 1,
                    states: {
                        hover: {
                            radius: 2
                        }
                    }
                },
                fillOpacity: 0.25
            },*/
            bar: {
            	grouping:false
            	//,edgeWidth: 0
            	//,groupZPadding: 0
            	//,groupPadding: 0
            	,dataLabels: {
                    enabled: true,
                    //color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'black',
                    //color: ('white'),
                    align: 'right',
                    inside:true,
                    //format:'{point.options.RATIO}({point.options.PASS}/{point.options.CASES})'
                    //format:'{point.options.RATIO:.1f}%',
                   formatter:function(){
                	   //var max = this.series.yAxis.max,
                       //color =  this.y / max < 0.05 ? 'black' : 'white'; // 5% width
                	   var color =  this.y > 10 ? 'white' : 'black'; // 5% width
                	   return '<span style="color: ' + color + '">' + Highcharts.numberFormat(this.y,1) + '% </span>'; 
                    }
            	}
            },
            column: {
                negativeColor: '#910000',
                borderColor: 'silver'
            }
        }
    };
    options = Highcharts.merge(defaultOptions, options);

    return new Highcharts.Chart(options, callback);
};


function minValue(srcData,column){
	var min = null;
	$.each(srcData,function(index,d){
		if(d[column] != undefined){
			if(min == null)
				min = d[column];
			else if(min > d[column]){
				min = d[column];
			}
			
			/*if(max == null)
				max = d.y;
			else if (max < d.y)
				max = d.y;*/
		}else{
			if(min == null)
				min = d;
			else if(min > d){
				min = d;
			}
		}
	});
	return min;
}

function maxValue(srcData,column){
	var max = null;
	$.each(srcData,function(index,d){
		if(d[column] != undefined){
			if(max == null)
				max = d[column];
			else if(max < d[column]){
				max = d[column];
			}
			
		}else{
			if(max == null)
				max = d;
			else if(max < d){
				max = d;
			}
		}
	});
	return max;
}


function dashboardShow(target,action){
	
	var oFrm = document.getElementById("form1");
	
	var target = target;
	oFrm.action =  action;
	oFrm.method = "post";
	oFrm.target = target; 
    oFrm.submit();
	
}


/**
 * 데이타를 필터링 한다. and 필터임.
 * @param srcData: 데이타원본
 * @param pSearch: [{col:'xxx',val:'xxx'}...]
 */
function dataFilter(srcData,pSearch){
	var dataFiltered = [];
	var groupKeys = ['col','val'];
	searchs = getDrillDownDataSeries2(
			'',
			pSearch ,
			groupKeys ,
			[],
			[],
			'col',
			'xxx',
			{cd: 'col', name:'col'}
	);
	
	for(var i=0;i<srcData.length;i++){
		var d = srcData[i];
		///////////////////////////
		var isEqual = true;	
		for( var j=0; j< searchs.series.length ; j++){
			var search = searchs.series[j];	
			var isEqual1 = false;
			$.each(search.data,function(index,s){
				if(d[s.col] == s.val){
					isEqual1 = true;
					return;
				}
			});
			
			if(isEqual1 == false){
				isEqual = false;
				break;
			}			
		}
		
		if(isEqual){
			dataFiltered.push(srcData[i]);
		}			
		//////////////////
	}
	
	return dataFiltered;
}


/**
 * 각row의 컬럼명이 다른경우
 * @param srcArray
 * @param col
 * @returns {String}
 */
function getValueFromArray(srcArray,col){
	var rtn = "";
	$.each(srcArray,function(index,d){
		if(d.col  == col ){
			rtn= d.val;
			return;
		}
	});	
	return rtn;
	
}

/**
 * 각row의 컬럼명이 다르고 값도 다른경우
 * @param srcArray
 * @param col
 * @param val
 * @returns {String}
 */
function getValueFromSimpleArray(srcArray,val){
	var rtn = "";
	if(srcArray == null || srcArray == undefined || srcArray.length == 0 )
		return "xxx";
	
	$.each(srcArray,function(index,d){
		if(d  == val){
			rtn= d;
			return;
		}
	});	
	return rtn;
	
}



function pivot(datasrc,colDef,groupbyColumns,targetColumn){
	var rtnObject = {};
	//var groupList = groupbyCount(datasrc,groupbyColumns);
	var groupList = groupbySum(datasrc,groupbyColumns, targetColumn);
	groupList = _.filter(groupList, function(item){
		return item[groupbyColumns[1]] != 'Undefined';
	});
	var cols = groupbyCount(datasrc,[colDef.col,colDef.name]);
	
	$.each(groupList,function(i,group){
		$.each(cols,function(ci,col){
			var filter = [];
			filter.push({col: colDef.col ,val: col[colDef.col]});
			$.each(groupbyColumns,function(c,v){
				if(c != 'count'){
					filter.push({col: v, val: group[v] });
				}
			});
			
			if(col[colDef.col] == 'PJT_00059012' && group.YYYYMM=='201702' && group.UP_PJT_FUNC_ID =='NPM_00000004')
				var xxx = 'xxx';
			
			var targets = dataFilter(datasrc,filter);
			var targets1 = groupbySum(targets,groupbyColumns, targetColumn);
			var target = {};
			if(targets1.length > 0){
				target = targets1[0];
				
				// customize
				if(target.isPlan != undefined && target.isPlan == true)
					group.isPlan = true;
			}else{
				group[col[colDef.col]] = 0;
				group[col[colDef.name]] = 0;
				return true;
			}
			
//				$.each(target,function(c,v){
//					group[c] = v;
//				});				
			
			var tval = 0;
			if(target[targetColumn] != undefined)
				tval = target[targetColumn];
			
			group[col[colDef.col]] = tval;
			group[col[colDef.name]] = tval;
				
			
		});
	});
	
	rtnObject.list = groupList;
	rtnObject.datasrc = datasrc;
	rtnObject.colDef = colDef;
	rtnObject.columns = cols;
	rtnObject.groupbyColumns = groupbyColumns;
	rtnObject.targetColumn = targetColumn;
	
	return rtnObject ;
	
}

// schema에서 특정 element를 찾는다.
function findAll(id, items) {
	var i = 0, found, result = [];

	for (; i < items.length; i++) {
		if (items[i].id === id) {
	    	result.push(items[i]);
		} else if (_.isArray(items[i].elements)) {
			found = findAll(id, items[i].elements);
		    if (found.length) {
		    	result = result.concat(found);
			}
		}
	}

	return result;
}

function fn_findTopContainer(){
	if(this.parentContainer != undefined)
		return fn_findTopContainer.call(this.parentContainer);
}

function fn_makeHtml( container , _schema ){
	var containerSub = null;
		if(container == null)
			container = _schema.containerId;
		if(typeof container == 'string')
			container = $("#" + container);
		
		if(_schema.parentSchema != undefined && _schema.parentSchema.cls != undefined)
			container.addClass(_schema.parentSchema.cls);
		if(_schema.parentSchema != undefined &&  _schema.parentSchema.containerCss != undefined){
			$.each(_schema.parentSchema.containerCss,function(i,v){
				container.css(v.code,v.value);
			});
		}
			
		var mainContainer = null;
		var mainControl = null;
		if(_schema.type == 'inline'){
			var cols = 3;
			if(_schema.cols != undefined)
				cols = _schema.cols;
			
			//tableCreate
			mainContainer = $(document.createElement("table"));
			//table.addClass("table_hori m_bottom_20");
			mainContainer.addClass("table_hori");
			container.append(mainContainer);
			
			// colgroup
			var colgroup = $(document.createElement("colgroup"));
			mainContainer.append(colgroup);
			
			for(var i=0; i< cols;i++){
				if(i == (cols - 1) ){
					colgroup.append("<col width=\"150\"/><col width=\"\"/>");
				}else{
					colgroup.append("<col width=\"150\"/><col width=\"180\"/>");
				}
			}
			// -- colgroup
			
			// tbody
			var tbody = $(document.createElement("tbody"));
			mainContainer.append(tbody); 
			var tr = null;
			$.each(_schema.items,function(i,item){
				if(i%cols == 0 ){
					tr =$(document.createElement("tr"));
					tbody.append(tr);
				}
				//header
				var th = $(document.createElement("th"));
				th.addClass("txt_right");
				th.text(item.label);
				//td value
				var td = $(document.createElement("td"));
				td.addClass("hori_t_data");
				td.text(_schema.data()[item.col]);
				
				tr.append(th);
				tr.append(td);
				
			});
			// --tbody
		}else if(_schema.type == 'inline_iframe'){
			var cols = 2;
			if(_schema.cols != undefined)
				cols = _schema.cols;
			
			//tableCreate
			mainContainer = $(document.createElement("table"));
			//table.addClass("table_hori m_bottom_20");
			mainContainer.addClass("table_hori");
			container.append(mainContainer);
			
			// colgroup
			var colgroup = $(document.createElement("colgroup"));
			mainContainer.append(colgroup);
			
			for(var i=0; i< cols;i++){
				colgroup.append("<col width=\"150\"/>");
			}
			// -- colgroup
			
			// tbody
			var tbody = $(document.createElement("tbody"));
			mainContainer.append(tbody); 
			var tr = null;
			$.each(_schema.items,function(i,item){
				if(i%cols == 0 ){
					tr =$(document.createElement("tr"));
					tbody.append(tr);
				}
				//header	
				//td value
				var td = $(document.createElement("td"));
				td.addClass("hori_t_data");
				//td.text(_schema.data()[item.col]);
				tr.append(td);
				td.css("border","0px");
				
				
				
				var tabContainer = $(document.createElement( "div" ));
				tabContainer.attr("id",_schema.id + item.name +  'TabContainer' )
				tabContainer.addClass("tit_btn");
				tabContainer.addClass("m_top_10");		
				tabContainer.css("display","inline-block");
				td.append(tabContainer);
				
				$ul = $(document.createElement( "ul" )); 
				$ul.attr("id",_schema.id +  item.name +  'Ul');
				$ul.addClass("tab_2depth");
				tabContainer.append($ul);
				
				var $li = $(document.createElement( "li" ));
				$li.attr("id", _schema.id +  item.name +  'Tab' );
				$li.addClass("on")
				$ul.append($li);
				
				
				var $a = $(document.createElement( "a" ));
				$a.attr("id", _schema.id + '_a' );
				$a.attr("origin_id", _schema.id );
				$a.text(item.label);
				$li.append($a);		
			
				v_content = $(document.createElement( "div" ));
				td.append(v_content);
				v_content.attr("id", _schema.id + item.name +  'Content');
				v_content.css("height",_schema.height);
				//v_content.css("margin-top","10px");
				//v_content.css("padding","0 10px 0 10px");
				v_content.css("width","100%");
				
				//iframe
				var v_frame = $(document.createElement( "iframe" ));
				v_frame.attr("id", _schema.id + '_'+ item.name +'Frame');
				v_frame.attr("name",  _schema.id + '_'+ item.name +'Frame');
				v_frame.css("width","100%");
				v_frame.css("height","100%");
				
				if(_schema.iframe_css != null){
					$.each(_schema.iframe_css,function(i,v){
						v_frame.css(v.code,v.value);
					});
				}
				v_content.append(v_frame);
				var viewName = item.viewName;
				var form_id = _schema.form_id;
				
				var vform =  document.getElementById(form_id);
				vform.action = './generic.html?viewName='+viewName;
				vform.method = "post";
				vform.target = _schema.id + '_'+ item.name +'Frame';
				//vform.target = v_content[0];
				if(item.data != undefined)				{
					$.each(item.data,function(k,v){
						$("#"+k).val(v);
					})
				}
				
				vform.submit();
				
			});
			// --tbody
		}else if(_schema.type == 'inline_edit'){
			var cols = 1;
			if(_schema.cols != undefined)
				cols = _schema.cols;
			
			
			var btnGroup = $(document.createElement("div"));
			btnGroup.addClass("btn-group");	
			btnGroup.css("margin-bottom","3px");
			btnGroup.css("width","100%");
			container.append(btnGroup);
			var edit_mode = "read";
			if ( _schema.edit_type == "view"){
				edit_mode = "read";
				btnGroup.hide();
			}else{
				edit_mode = "edit";
			}
			
			if(false){
				// create button edit
				var btnEdit = $(document.createElement("button"));
				btnEdit.attr("type","button");
				btnEdit.addClass("btn btn-default");	
				btnEdit.css("width","100px");
				btnEdit.text("Edit");
				btnEdit.hide();
				btnGroup.append(btnEdit);
			}
			
			// button confirm
			var btnConfirm = $(document.createElement("button"));
			btnConfirm.attr("type","button");				
			btnConfirm.css("width","100px");

			if(_schema.options != undefined && 
				_schema.options.button_option != undefined &&
				_schema.options.button_option.btn_class != null){
					btnConfirm.addClass(_schema.options.button_option.btn_class);	
			}else{
					btnConfirm.addClass("btn btn-default");
			}

			if(_schema.options != undefined && 
				_schema.options.button_option != undefined &&
				_schema.options.button_option.label != null){
					btnConfirm.text(_schema.options.button_option.label);
			}else{
					btnConfirm.text("Confirm");
			}				
			
			btnGroup.append(btnConfirm);
			if (false){
				// button cancel
				var btnCancel = $(document.createElement("button"));
				btnCancel.attr("type","button");
				btnCancel.addClass("btn btn-default");	
				btnCancel.css("width","100px");
				btnCancel.text("Cancel");
				btnCancel.hide();
				btnGroup.append(btnCancel);
			}
			
			// //tableCreate
			// var mainContainerDiv =  $(document.createElement("div"));
			// // mainContainerDiv.addClass("table-responsive");
			// container.append(mainContainerDiv);
			// mainContainer = $(document.createElement("table"));
			// //table.addClass("table_hori m_bottom_20");
			// mainContainer.addClass("table");
			// mainContainerDiv.append(mainContainer);
			
			// PMS Style
			var reactObjects = [];
			mainContainer = $(document.createElement("div"));
			container.append(mainContainer);
			var fn_make_group_label = function(_itemGroup){
				mainContainer.append('<br/>');
				var h3 = $(document.createElement("h3"));
				h3.addClass("cont_tit");
				h3.text(_itemGroup.option.group_label);
				mainContainer.append(h3);
				
			};
			var fn_make_table = function(_itemGroup){				
				var minCols = Math.min(_itemGroup.items.length,cols);
				if(_itemGroup.option != null && _itemGroup.option.group_label != null){
					if (_itemGroup.option.cols != null)
						minCols = _itemGroup.option.cols;
					fn_make_group_label(_itemGroup);					
				}

				// PMS Style
				var v_table = $(document.createElement("table"));
				if (_itemGroup.display == 'none')
					v_table.hide();
				//table.addClass("table_hori m_bottom_20");
				v_table.addClass("table_hori");
				mainContainer.append(v_table);
				
				// colgroup
				var colgroup = $(document.createElement("colgroup"));
				v_table.append(colgroup);
				
				
				for(var i=0; i< minCols;i++){
					if(minCols == 1 ){
						colgroup.append("<col width=\"150\"/><col width=\"\"/>");
					}
					else if(i == (minCols - 1) ){
						colgroup.append("<col width=\"100\"/><col width=\"200\"/>");
					}else{
						colgroup.append("<col width=\"100\"/><col width=\"200\"/>");
					}
				}
				// -- colgroup
				
				// tbody
				var tbody = $(document.createElement("tbody"));
				v_table.append(tbody); 
				var tr = null;
				var data = _schema.data();		
				
				var j=0; // for line feed 
				$.each(_itemGroup.items,function(i,item){
					
					if (item.line_feed != null && item.line_feed){
						j = j + Math.abs( j - minCols );
						return true;
					}
					if(data[item.col] == undefined) {
						data[item.col] = "";
					}
					if(j%minCols == 0 ){
						tr =$(document.createElement("tr"));
						tbody.append(tr);
					}
					
					
					//header
					var th = $(document.createElement("th"));
					th.addClass("txt_right");
					if (item.required)
						th.addClass("required");

					th.text(item.label);
					//td value
					var td = $(document.createElement("td"));
					var tdOption = {
						name: item.col,
						//keys: _schema.keys,
						value: data[item.col],
						value_origin: data[item.col],
						editable : item.editable != undefined ? item.editable : true,
						required : item.required != undefined ? item.required : false,
						isDateTime : item.isDateTime != undefined ? item.isDateTime : false,
						mode: edit_mode,
						label : item.label
					};

					
					
					if(_schema.options != undefined && _schema.options.keys != undefined){
						var keys = [];
						//var data = _schema.data();
						$.each(_schema.options.keys,function(i,k){
							var key = {
								field: k,
								value: data[k]
							};
							keys.push(key);
						});
						tdOption.keys = keys;
					}
						
					
					if(_schema.options != undefined && _schema.options.fn_submit != undefined)
						tdOption.fn_submit = _schema.options.fn_submit;
					else {
						tdOption.fn_submit = function(){
							alert("submit function not defined");
						};
					}
					
					if(_schema.options != undefined && _schema.options.fn_change != undefined)
						tdOption.fn_change = _schema.options.fn_change;
					
					var width_select = "100%";
					var width_input = "100%";
					if (item.file_info != null){
						item.edit_tag = "file";
					}
					if( item.edit_tag != undefined )	{
						tdOption.edit_tag = item.edit_tag;
						if(item.edit_style != undefined ){
							tdOption.edit_style = item.edit_style;
						} else {
							if(item.edit_tag == "textarea"){
								tdOption.edit_style = {height:"200px",width: "450px"};
							} else if(item.edit_tag == "select"){
								tdOption.edit_style = {width: width_select };
								tdOption.selectOptions = item.selectOptions;
							} else if(item.edit_tag == "radio"){
								tdOption.edit_style = {width: "200px" };
								tdOption.selectOptions = item.selectOptions;
								if (tdOption.value == "")
									tdOption.value = item.selectOptions[0].value;
							} else if(item.edit_tag == "pop_select"){
								tdOption.edit_style = {width: "70%", display: "inline-block" };		
								tdOption.fn_pop_select = _schema.options.fn_pop_select ;
								tdOption.search_str = "" ;
								tdOption.btn_label = item.btn_label ;
							} else if(item.edit_tag == "manual_attach"){
								tdOption.edit_style = {width: "70%", display: "inline-block" };
								tdOption.fn_manual_attach = _schema.options.fn_manual_attach ;
								tdOption.btn_label = item.btn_label ;
							} else {
								tdOption.edit_style = {};
							}
						}
					}else {
						tdOption.edit_tag = "input";
						tdOption.edit_style = {
							height: "2.5em",
							width: width_input
						};
					}
					
					var reacttd = window.fn_td(td[0], tdOption );
					if (tdOption.isDateTime){
						var dateEm = $(td).find("input");
						dateEm.datetimepicker({ 
							//formatDate: 'Y-m-d'
							//, formatTime:'H:i'
							format : 'Y-m-d H:i:s'
							//format : 'H:i:s'
							//, datepicker: false
							, timepicker: true 
							, step: 15
							//, useSeconds: true //default true
							, onSelectTime: function( _data, _target) {
								// _target.trigger('change');
								// var react = item;
								item.setState({value:_target.val()})
							},
							onSelectDate :  function( _data, _target) {
								// _target.trigger('change');
								// var react = item;
								item.setState({value:_target.val()})
							},
						});
					}
					//td.addClass("hori_t_data");
					//td.text(_schema.data()[item.col]);				
					
					// reactDom 으로 부터 특정 component 를 찾을 수 없으므로 
					reacttd.reactObjects = reactObjects;
					reactObjects.push(reacttd);		
					if( item.edit_tag != undefined )	{
						if(item.edit_tag == "pop_select"){
						} else if(item.edit_tag == "manual_attach"){
						} else {
							tr.append(th);
						}
					}else {
						tr.append(th);
					}
					
					tr.append(td);
					

					j++;
					
				});
			};

			// var itemGroups = [[]];
			var itemGroups = [{items:[]}];
			var groupCols = null;
			/********************************************************/
			/******************* Show Items  ************************/
			/********************************************************/			
			var v_show_items = _.filter( _schema.items  , function(item){
				if (item.edit_tag != 'hidden')
					return true;
				else
					return false;
			});			
			$.each( v_show_items , function(i,item){
				if( item.group_label != null ){
					var addGroup = {
						option: {
							group_label : item.group_label
						},
						items: []
					}
					if (item.cols != null ){
						addGroup.option.cols = item.cols;
					}
					itemGroups.push(addGroup);					
					return true;
				}
				var itemGroup = itemGroups[itemGroups.length -1];
				itemGroup.items.push(item);
			});
			/********************************************************/
			/******************* Hide Items  ************************/
			/********************************************************/
			var v_hide_items = _.filter( _schema.items  , function(item){
				if (item.edit_tag == 'hidden')
					return true;
				else
					return false;
			});
			if (v_hide_items.length > 0)
				itemGroups.push({items:[], display: 'none'});
			$.each( v_hide_items , function(i,item){
				if( item.group_label != null ){
					var addGroup = {
						option: {
							group_label : item.group_label
						},
						items: []
					}
					if (item.cols != null ){
						addGroup.option.cols = item.cols;
					}
					itemGroups.push(addGroup);					
					return true;
				}
				var itemGroup = itemGroups[itemGroups.length -1];
				itemGroup.items.push(item);
			});

			$.each(itemGroups, function(i, group){
				fn_make_table(group);
				
			});

			// hidden items


			if (false){
				// PMS Style
				mainContainer = $(document.createElement("table"));
				//table.addClass("table_hori m_bottom_20");
				mainContainer.addClass("table_hori");
				container.append(mainContainer);
				
				// colgroup
				var colgroup = $(document.createElement("colgroup"));
				mainContainer.append(colgroup);
				
				for(var i=0; i< cols;i++){
					if(cols == 1 ){
						colgroup.append("<col width=\"150\"/><col width=\"\"/>");
					}
					else if(i == (cols - 1) ){
						colgroup.append("<col width=\"100\"/><col width=\"200\"/>");
					}else{
						colgroup.append("<col width=\"100\"/><col width=\"200\"/>");
					}
				}
				// -- colgroup
				
				// tbody
				var tbody = $(document.createElement("tbody"));
				mainContainer.append(tbody); 
				var tr = null;
				var data = _schema.data();
				
				var reactObjects = [];
				
				
				var j=0; // for line feed 
				$.each(_schema.items,function(i,item){
					if (item.line_feed != null && item.line_feed){
						j = j + Math.abs( j - cols );
						return true;
					}
					if(data[item.col] == undefined) {
						data[item.col] = "";
					}
					if(j%cols == 0 ){
						tr =$(document.createElement("tr"));
						tbody.append(tr);
					}
					//header
					var th = $(document.createElement("th"));
					th.addClass("txt_right");
					th.text(item.label);
					//td value
					var td = $(document.createElement("td"));
					var tdOption = {
						name: item.col,
						//keys: _schema.keys,
						value: data[item.col],
						value_origin: data[item.col],
						editable : item.editable != undefined ? item.editable : true,
						isDateTime : item.isDateTime != undefined ? item.isDateTime : false,
						mode: edit_mode
					};

					
					
					if(_schema.options != undefined && _schema.options.keys != undefined){
						var keys = [];
						//var data = _schema.data();
						$.each(_schema.options.keys,function(i,k){
							var key = {
								field: k,
								value: data[k]
							};
							keys.push(key);
						});
						tdOption.keys = keys;
					}
						
					
					if(_schema.options != undefined && _schema.options.fn_submit != undefined)
						tdOption.fn_submit = _schema.options.fn_submit;
					else {
						tdOption.fn_submit = function(){
							alert("submit function not defined");
						};
					}
					
					if(_schema.options != undefined && _schema.options.fn_change != undefined)
						tdOption.fn_change = _schema.options.fn_change;
					
					var width_select = "100%";
					var width_input = "100%";
					if( item.edit_tag != undefined )	{
						tdOption.edit_tag = item.edit_tag;
						if(item.edit_style != undefined ){
							tdOption.edit_style = item.edit_style;
						} else {
							if(item.edit_tag == "textarea"){
								tdOption.edit_style = {height:"200px",width: "450px"};
							} else if(item.edit_tag == "select"){
								tdOption.edit_style = {width: width_select };
								tdOption.selectOptions = item.selectOptions;
							}
							else {
								tdOption.edit_style = {};
							}
						}
					}else {
						tdOption.edit_tag = "input";
						tdOption.edit_style = {
							height: "2.5em",
							width: width_input
						};
					}
					
					var reacttd = window.fn_td(td[0], tdOption );
					if (tdOption.isDateTime){
						var dateEm = $(td).find("input");
						dateEm.datetimepicker({ 
							//formatDate: 'Y-m-d'
							//, formatTime:'H:i'
							format : 'Y-m-d H:i:s'
							//format : 'H:i:s'
							//, datepicker: false
							, timepicker: true 
							, step: 15
							//, useSeconds: true //default true
							, onSelectTime: function( _data, _target) {
								// _target.trigger('change');
								// var react = item;
								item.setState({value:_target.val()})
							},
							onSelectDate :  function( _data, _target) {
								// _target.trigger('change');
								// var react = item;
								item.setState({value:_target.val()})
							},
						});
					}
					//td.addClass("hori_t_data");
					//td.text(_schema.data()[item.col]);				
					
					// reactDom 으로 부터 특정 component 를 찾을 수 없으므로 
					reacttd.reactObjects = reactObjects;
					reactObjects.push(reacttd);
					tr.append(th);
					tr.append(td);

					j++;
					
				});
			}

			if(false){
				btnEdit.click(function(){
					var a = "a";
					$.each(reactObjects,function(i,item){
						if(item.props.options.editable){
							item.setState({mode:"edit"});
							if(item.props.options.isDateTime){
								var dateEm = $("[data-reactid='" +item._reactInternalInstance._rootNodeID + "']").find("input");
								dateEm.datetimepicker({ 
									//formatDate: 'Y-m-d'
									//, formatTime:'H:i'
									format : 'Y-m-d H:i:s'
									//format : 'H:i:s'
									//, datepicker: false
									, timepicker: true 
									, step: 15
									//, useSeconds: true //default true
									, onSelectTime: function( _data, _target) {
										// _target.trigger('change');
										// var react = item;
										item.setState({value:_target.val()})
									},
									onSelectDate :  function( _data, _target) {
										// _target.trigger('change');
										// var react = item;
										item.setState({value:_target.val()})
									},
								});
							}
								
						}
					});
					btnEdit.hide();
					btnConfirm.show();
					btnCancel.show();
				});
				btnCancel.click(function(){
					var a = "a";
					$.each(reactObjects,function(i,item){
						this.setState({mode: "read"});
					});
					btnConfirm.hide();
					btnCancel.hide();
					btnEdit.show();
				});
			}

			btnConfirm.click(function(){
				var a = "a";
				var state = true;
				$.each(reactObjects,function(i,item){
					if (this.state.required && (this.state.value == "" || this.state.value == null)  ){
						state = false;
						var v_msg = "Please input " + this.state.label;
						$("#dialog-confirm").html(v_msg);
						$("#dialog-confirm").dialog({
							resizable: false,
							modal: true,
							title: "Error",
							//height: 200,
							width: 300,
							dialogClass: 'no-close',
							closeOnEscape: false,
							buttons: [
								{
									text: "OK",
									click: function() {
										$( this ).dialog( "close" );											                    			                  
									}
								}
							]
						});
					}
				});
				if(!state)
					return;
				// loader
				if(_schema.options != undefined && _schema.options.progressObject != undefined)
					_schema.options.progressObject.show();
				setTimeout(function(){
					
					if( _schema.edit_type == "edit"){
						var keyUpdatedObjects = [];
						// key 가 아닌것을 먼저 update
						$.each(reactObjects,function(i,item){
							var isKeyUpdate = false;
							if(this.state.value_origin != this.state.value){
								var vObject = this;
								$.each(this.state.keys, function(){
									if(this.field == vObject.state.name){
										this.value = vObject.state.value_origin;
										isKeyUpdate = true;
									}
										
								});
								if(!isKeyUpdate){
									state = item.props.options.fn_submit.call(this,"edit");
									this.setState({value_origin: this.state.value});
								}							
							}
								
							if(!state)
								return false;
							// this.setState({mode: "read"});
							if(isKeyUpdate){
								keyUpdatedObjects.push(item);
							}
						});
						
						// key 는 나중에 업데이트 한다. 만약 키다 두개이상인 경우는 cover가 안됨
						$.each(keyUpdatedObjects,function(i,item){
							state = item.props.options.fn_submit.call(this,"edit");
							this.setState({value_origin: this.state.value});
								
							if(!state)
								return false;
							// this.setState({mode: "read"});
							
						});
						if(state){
							// btnConfirm.hide();
							// btnCancel.hide();
							// btnEdit.show();
							if(_schema.options != undefined && _schema.options.fn_afterSubmit != undefined)
								_schema.options.fn_afterSubmit.call(reactObjects,keyUpdatedObjects);
						}
					}else if (_schema.edit_type == "add"){
						state = _schema.options.fn_submit.call(reactObjects,"add");
						
					}else if (_schema.edit_type == "copy"){
						state = _schema.options.fn_submit.call(reactObjects,"copy");
					}

					
					if(false){
						if(state){
							btnConfirm.hide();
							btnCancel.hide();
							btnEdit.show();
							if(_schema.options != undefined && _schema.options.fn_afterSubmit != undefined)
								_schema.options.fn_afterSubmit.call(reactObjects,keyUpdatedObjects);
						}
					}
					
					if(_schema.options != undefined && _schema.options.progressObject != undefined){
						_schema.options.progressObject.hide();
					}
						
				}
				,50);
				
				
			});

			if(_schema.options != undefined && 
				_schema.options.button_option != undefined &&
				_schema.options.button_option.location != null){
					var button_group = $(".btn-group");	
					var location = _schema.options.button_option.location;
					if (location == "bottom-right"){
						container.append(btnGroup);
						// btnGroup.css("margin-right","20px");
						btnGroup.css("margin-top","3px");
						btnConfirm.css("float","right");
						container.css("margin-top","0px");
					}else if (location == "bottom-left"){

					}
			}
			

			
		}else if(_schema.type == 'grid'){
			//==grid create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(container.children().length > 0)
					mainContainer.css("margin-left","10px");
			}
				
			container.append(mainContainer);
			//mainContainer.css("width","100%");
			//grid.addClass("chartContainerSub");
			
			
			//==table create
			mainControl = $(document.createElement( "table" ));
			mainControl.attr("id",_schema.id);
			//table.css("width","100%");
			mainContainer.append(mainControl);
			
			//== page create
			var pager = $(document.createElement( "div" ));
			pager.attr("id",_schema.id + 'Pager');
			mainContainer.append(pager);
			
			// refereced Items
			$.each(_schema.items , function(i, item){
				var dictionary = null;
				var dicCodes = [];
				if(typeof(dictionaries) != 'undefined' ){
					dictionary = _.find(dictionaries,{entityName: item.entityName  });
					if (dictionary != null)
						dicCodes = _.filter(dictionary.value, {"TABLE_NAME":item.entityName.toUpperCase(),"COLUMN_NAME": item.name});
				}
				if(dicCodes.length > 0){
					item.edittype = "select";
					if(item.formatter == null)
						item.formatter = "select"
					var editopt = item.editoptions;
					if(editopt == undefined){							
						editopt = {};
						item.editoptions = editopt;
					}
					var editValue = {};
					$.each(dicCodes, function(j,code){
						editValue[code[dictionary.codeColumn.toUpperCase()]] =  code[dictionary.nameColumn.toUpperCase()];
					});
					editopt.value = editValue;

					if (item.stype == "select" 
						&& item.searchoptions == null ){
						var search_value = ":ALL";													
						$.each(item.editoptions.value, function( k, v){
							search_value += ";" + k + ":" +  v ;
						});
						
						item.searchoptions = { value : search_value};						
					}
					

				}else if(item.referenceId != undefined && dataSrc != undefined && !_.includes(['pop_select'], item.data_src_type)){
					var src = _.find(dataSrc, {"referenceId": item.referenceId, "topRefrenceId" : item.topRefrenceId , "childColumnName": item.name.toLowerCase()  });
					if( src != null ){
						item.edittype = "select";
						if(item.formatter == null)
							item.formatter = "select";
						var editopt = item.editoptions;
						if(editopt == undefined){							
							editopt = {};
							item.editoptions = editopt;
						}
						editopt.value = src.value;
					}
					if ( src.parentColumnNames.length > 1){
						var index = _.indexOf( _.map(src.childColumnNames,function(column){ return column.toUpperCase();  }) , item.name.toUpperCase() );
						
						if (index > -1 && index < (src.parentColumnNames.length -1 )){
							if(item.editoptions.dataEvents  == undefined )
								item.editoptions.dataEvents = [];
							var nextColumn = src.childColumnNames[index+1];

							item.editoptions.dataEvents.push({
								"type": "change" ,
								"fn" : function (e) {
									//console.log("hahahah");
									var grid = mainControl;
									var cms = grid.jqGrid("getGridParam", "colModel");
									var cm = _.find( cms , {name: item.name });
									var nextCm = _.find( cms , {name: nextColumn.toUpperCase() });
									var wheres = src.childColumnNames.slice(0,index + 1);
									var frm = $(this)[0].form;
									var param = {};
									$.each(wheres , function(i, where ){
										param["search_" + _.camelCase(where) ]  =  $(frm).find("#" + where.toUpperCase()).val();
									});

									var nextSrc = _.find(dataSrc, {"referenceId": nextCm.referenceId, "topRefrenceId" : nextCm.topRefrenceId , "childColumnName": nextCm.name.toLowerCase()  });
									var list = nextSrc.dataDynamic(param);
									var nextEl =  $(frm).find("#" + nextCm.name);
									var s = '<option value="">Select</option>';
									$.each(list, function(j, m){
										var selected = '';
										if( false) {
											selected = ' selected="selected"';
										}
										s += '<option value="'+ m[ nextSrc.parentColumnName.toUpperCase() ]+'"'+ selected +' >'+ m[ nextSrc.parentNameColumn.toUpperCase() ]+'</option>';
									});
									nextEl.html( s);

								}
							});
						}

					}
				}
			});

			//== common option
			var opt = {
					datatype: 'local',
					styleUI : 'Bootstrap4',
					// guiStyle: "bootstrap4",
					colModel: _schema.items,
					//rowNum:10,
					rownumbers: true, // show row numbers
					caption: _schema.label,
					//width: '100%',
					//height: '100%',
					iconSet: "fontAwesome",
					sortable: false,
					//viewrecords: true,
					//pager : pager, 
					//data : _schema.data() 
			};
			if(_schema.data != undefined && typeof _schema.data == 'function')
				opt.data = _schema.data();
			
			if(_schema.gridOpt != undefined){
				$.extend(opt, _schema.gridOpt);
			}

			mainControl.jqGrid(opt);
			
			// width가 100%인 경우
			if(opt.width != undefined && opt.width == '100%'){
				mainContainer.find(".ui-jqgrid").css("width","100%");
				mainContainer.find(".ui-jqgrid-view").css("width","100%");
				mainContainer.find(".ui-jqgrid-hdiv").css("width","100%");
				mainContainer.find(".ui-jqgrid-bdiv").css("width","100%");
				mainContainer.find(".ui-jqgrid-sdiv").css("width","100%");
				mainContainer.find(".ui-jqgrid-pager").css("width","100%");
			}
			
			
		}else if(_schema.type == 'chart'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(container.children().length > 0)
					mainContainer.css("margin-left","10px");
			}
			if(_schema.width != undefined)
				mainContainer.css("width",_schema.width);
				
			if(_schema.label != ""){
				var h3 = $(document.createElement("h3"));
				h3.addClass("cont_tit");
				h3.text(_schema.label);
				container.append(h3);
			}
			
			container.append(mainContainer);
			
			
			if($(mainContainer).highcharts() != undefined) $(mainContainer).highcharts().destroy();
			var defaultOption =  {
					credits: {//gets rid of the highcharts logo in bottom right
               			enabled: false
					}
            };
			var series = {};
			var options = $.extend( defaultOption, _schema.options());
			if(_schema.data != undefined && typeof _schema.data == 'function'){
				var vData = _schema.data();
				series = vData.series;
				options.series = vData.series.series;
				if(vData.xAxis != undefined)
					options.xAxis = vData.xAxis;
				if(vData.yAxis != undefined)
					options.yAxis = vData.yAxis;
			}
			// var chartUser = Highcharts.stockChart($(mainContainer).attr('id') ,options,function(chart){
		    	
	 		// });
			
			
			
			if(options.stockchart != undefined && options.stockchart){
				$(mainContainer).highcharts('StockChart',options,function(chart){
					if(options.complete != undefined && typeof options.complete == 'function' ){
						options.complete.call(chart);
					}
				});
			}else{
				$(mainContainer).highcharts(options,function(chart){
					if(options.complete != undefined && typeof options.complete == 'function' ){
						options.complete.call(chart);
					}
			 	});
			}
			
			 
			//var chart = mainContainer.highcharts();
			//chart.reflow();
			
			// $(mainContainer).highcharts(options,function(chart){
		    	
			//  });
			
		}else if(_schema.type == 'SearchHeader'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				if(container.children().length > 0)
					mainContainer.css("margin-left","1px");
			}
				
			mainControl = $(document.createElement("h3"));
			//h3.addClass("cont_tit");
			mainContainer.append(mainControl);
			mainControl.text(_schema.text);
			mainControl.css("font-weight","bold");
			mainControl.css("text-align","right");
			mainControl.css("color","#000");
			
			container.append(mainContainer);
		}else if(_schema.type == 'multiCombo'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				if(container.children().length > 0)
					mainContainer.css("margin-left","10px");
			}
			container.append(mainContainer); 
			
			var vData = _schema.data();
			var sb = [];
			//sb.push("<option value='' multiple='multiple' ></option>");
			mainControl = $(document.createElement( "select" ));
			mainControl.css("width",_schema.width);
			if(_schema.multiselectOpt != undefined && _schema.multiselectOpt.multiple != undefined && _schema.multiselectOpt.multiple == true )
				mainControl.attr("multiple","multiple");
			if(_schema.name != undefined)
				mainControl.attr("name",_schema.name);
			if(_schema.id != undefined)
				mainControl.attr("id",_schema.id);
			mainContainer.append(mainControl);
			
			/* var option1 = $(document.createElement( "option" ));
			option1.val('xxx');
			option1.text('xxx');
			option1.css("display","none");
			mainControl.append(option1); */
			
			if(_schema.options.group != undefined){
				var groupKeys = [_schema.options.group.cd, _schema.options.group.name];
				var series = getDrillDownDataSeries2(
						'',
						vData ,
						groupKeys ,
						[], //filter
						[], //convert
						'', //xAxis
						'',
						{cd: _schema.options.group.cd, name: _schema.options.group.name},
						{isGroupby: false}
				);
				var selected ="selected";
				var sb = [];
				sortObjects(series.series,['name']);
				$.each(series.series,function(index,s){
					var optGrp = $(document.createElement( "optgroup" ));
					optGrp.attr("label",s.name);
					optGrp.attr("cd",s.cd);
					mainControl.append(optGrp);
					$.each(s.data,function(index1,d){
						var option = $(document.createElement( "option" ));
						option.val(this[_schema.options.cd]);
						option.text(this[_schema.options.name]);
						//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
						$.each(this,function(k,v){
							option.attr(k.toLowerCase(),v);
						});
						optGrp.append(option);
					});
				});
				
			}
			else {
				$.each(vData,function(){
					var option = $(document.createElement( "option" ));
					option.val(this[_schema.options.cd]);
					option.text(this[_schema.options.name]);
					var _this = this;
					//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
					
					$.each(this,function(k,v){
						try{
							option.attr(k.toLowerCase(),v);
						}catch(e){
							console.log(_this);
						}						
					});
					//sb.push("<option value='"+ this[_schema.options.cd] +"' "+''+">" + this[_schema.options.name] +"</option>");
					mainControl.append(option);
				});
			}
			
			
			
			//$(vSelect).append(sb.join(""));
			//$(vSelect).append(sb.join(""));
			var multiselectOpt = {
				//selectedList: 1,
				// multiple: true,
				height:300,
				minWidth: 100,
				//selectedText: _schema.text + ' # selected',
				selectedText: function(numChecked, numTotal, checkedItems){
				     return numChecked + ' of ' + numTotal + ' checked';
				},
				noneSelectedText: 'Select ' + _schema.text
				
			};
			if(_schema.multiselectOpt != undefined)
				$.extend(multiselectOpt, _schema.multiselectOpt);
			var vMultiSelect = mainControl.multiselect(multiselectOpt).multiselectfilter();
			mainControl.multiselect('widget').css("width","400px");
			mainControl.multiselect('widget').find(".ui-multiselect-filter input").css("width","150px");
			// mainControl.multiselectOption = multiselectOpt;
			
			//filter by parent
			if(_schema.options.childrens != undefined){
				$.each(_schema.options.childrens, function(i,child){
					var childSchema = findAll(child.id, eval(child.topElement) )[0];
					if(childSchema != undefined){						
						mainControl.on( 'change', function(){
							
							$("select[name="+_schema.name+"] option").each(function(i,sel){
								if($(this).is(':selected')){
									$("select[name="+ child.id+"] option["+_schema.options.cd+"='"+$(this).val()+"']").prop( "disabled", false );
									//$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", true );
									$("select[name="+ child.id+"] option["+_schema.options.cd+"='"+$(this).val()+"']").prop( "selected", true );
								}else{
									$("select[name="+ child.id+"] option["+_schema.options.cd+"='"+$(this).val()+"']").prop( "disabled", true );
									//$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", false );
									$("select[name="+ child.id+"] option["+_schema.options.cd+"='"+$(this).val()+"']").prop( "selected", false );
								}
							});
							
							$("select[name="+ child.id+"] option").each(function(i,project){			
								$("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
								if($(this).prop("disabled")){
									$("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
									$("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").attr("checked",false);
									
								}else{
									$("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
									$("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").attr("checked",true);
								}
								
							});
							
							
							//$("input[name=multiselect_"+ child.id+"]").each(function(){
							//	$("select[name="+ child.id+"] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
							//});
							
							var childMultiselectOpt = {
								//selectedList: 1,
								height:300,
								minWidth: 100,
								//selectedText: _schema.text + ' # selected',
								selectedText: function(numChecked, numTotal, checkedItems){
								     return numChecked + ' of ' + numTotal + ' checked';
								},
								noneSelectedText: 'Select ' + childSchema.text
								
							};
							if(childSchema.multiselectOpt != undefined)
								$.extend(childMultiselectOpt, childSchema.multiselectOpt);
							
							
							$("select[name="+ child.id+"]").multiselect(childMultiselectOpt).multiselectfilter();
							//$("select[name="+ child.id+"]").multiselect(childSchema.multiselectOpt).multiselectfilter();
							
							// 해당하는 Object 만 refresh 한다.
							var my = $("select[name="+ child.id+"]");
							//my.multiselect('refresh');
							$menu = $.data(my[0],"ech-multiselect").menu;
							$menu.css("width","400px");
							$menu.find(".ui-multiselect-filter input").css("width","150px");
							
							//$("div.ui-multiselect-menu").css("width","400px");
							//$(".ui-multiselect-filter input").css("width","150px");
							
							var obj_child = $("#"+childSchema.id);
							obj_child.trigger("change");
						});
						
						
					}
					
				} );
				
			}
			
		}else if(_schema.type == 'jsTreeSearch'){
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');

			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				if(container.children().length > 0)
					mainContainer.css("margin-left","10px");
			}
			if(_schema.width != undefined)
				mainContainer.css("width",_schema.width);
			container.append(mainContainer); 
			var vData = _schema.data();

			mainControl = $(document.createElement( "div" ));
			// mainControl.css("width",_schema.width);
			mainControl.addClass("ui-multiselect-menu ui-widget-content ui-corner-all");
			if(_schema.name != undefined)
				mainControl.attr("name",_schema.name);
			if(_schema.id != undefined)
				mainControl.attr("id",_schema.id);
			mainControl.hide();
			// mainContainer.append(mainControl);
			mainControl.appendTo(document.body);
			var button = $('<button type="button"><span class="ui-icon ui-icon-triangle-2-n-s"></span></button>')
			.addClass('ui-multiselect ui-widget ui-state-default ui-corner-all')
			.addClass("")
			.attr({ 'title':"", 'aria-haspopup':true }) 
			.css({width: "100%"})
			.appendTo(mainContainer);
			
			var buttonlabel = $('<span />')
			.html("Js Tree Search")
			.appendTo(button);
			button.on( "click", function() {
				// mainControl.toggle( 'blind', { to: { width: 200, height: 300 } }, 500 );
				var display = mainControl.css("display");
				var pos = $(this).offset();
				mainControl.css({
					top: pos.top + $(this).outerHeight(),
					left : pos.left
				});
				if (display == "none"){
					mainControl.show();
				}else
					mainControl.hide();
				

			});

			buttonlabel.attr("mainControlId",_schema.id );
			var searchTree = new List2Tree(vData, _schema.keys);
			_.merge(searchTree.tree ,
				{
					checkbox : {
						// three_state : false,
						// cascade: 'undetermined',
						// visible: true,
						// three_state: false
						// tie_selection: false
					},
					'plugins': ["checkbox", "state"],
					// 'plugins': ["checkbox", "wholerow"],
					"core": {
						themes:{
							'icons':false
						}
					}
				}
			);
			if(_schema.rootText != null){
				searchTree.tree.core.data[0].text = _schema.rootText;
			}else{
				searchTree.tree.core.data[0].text = _.map( _schema.keys,function(key , i){
					return _.camelCase(key);
				}).join("/");
			}

			mainControl.css("width","400px");
			mainControl.css("max-height","600px");
			mainControl.css("overflow","scroll");
			mainControl.jstree(_.cloneDeep(searchTree.tree));
			var vtree = mainControl.jstree(true);
			mainControl.on("changed.jstree", function(){
				// var vLabel = $("[mainControlId="+_schema.id + "]");
				// vLabel.text(vtree.get_selected().length + " Selected");
				buttonlabel.text(vtree.get_selected().length + " Selected");
			});

			$(document).bind('mousedown.' + this._namespaceID, function(e) {
				var display = mainControl.css("display");

				if(display != "none" && e.target != mainControl[0] && !$.contains(mainControl[0], e.target) && !$.contains(button[0], e.target) && e.target !== button[0]) {
				  mainControl.hide();
				}
			});



		}else if(_schema.type == 'Button'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			mainControl = $(document.createElement("a"));
			mainContainer.append(mainControl);
			
			
			var span = $(document.createElement("span"));
			span.addClass("name");
			var span1 = $(document.createElement("span"));
			span1.addClass("txt");
			span1.text(_schema.label);
			span.append(span1);
			mainControl.append(span);
			
			container.append(mainContainer);
		}else if(_schema.type == 'ButtonBootstrap'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			mainControl = $(document.createElement("button"));
			mainControl.attr("type","button");
			mainControl.addClass("btn btn-warning btn-sm");
			mainControl.text(_schema.label);
			mainContainer.append(mainControl);
			
			container.append(mainContainer);
		}else if(_schema.type == 'radioButton'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			mainControl = $(document.createElement("input"));
			mainControl.attr("type","radio");
			mainControl.attr("name",_schema.name);
			mainControl.attr("id",_schema.id);
			
			if(_schema.checked != undefined)
				mainControl.prop("checked",_schema.checked);
			
			mainContainer.append(mainControl);
			
			var label = $(document.createElement("label"));
			label.text(_schema.label);
			mainContainer.append(label);
			
			container.append(mainContainer);
		}else if(_schema.type == 'dateInput'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			// text
			mainControl = $(document.createElement("input"));
			mainControl.attr("type","text");
			mainControl.attr("name",_schema.name);
			mainControl.attr("id",_schema.id);
			mainControl.attr("readonly", "readonly");
			mainContainer.append(mainControl);			
			
			container.append(mainContainer);
			
		}else if(_schema.type == 'input'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			// text
			mainControl = $(document.createElement("input"));
			mainControl.attr("type","text");
			mainControl.attr("name",_schema.name);
			mainControl.attr("id",_schema.id);			
			//mainControl.attr("readonly", "readonly");
			mainContainer.append(mainControl);			
			
			container.append(mainContainer);
			
		}else if(_schema.type == 'monthInput'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			// text
			mainControl = $(document.createElement("input"));
			mainControl.attr("type","text");
			mainControl.attr("name",_schema.name);
			mainControl.attr("id",_schema.id);
			mainControl.attr("readonly", "readonly");
			//mainControl.MonthPicker();
			//mainControl.MonthPicker('option','MonthFormat', 'yymm');
			mainContainer.append(mainControl);			
			
			container.append(mainContainer);
			mainControl.MonthPicker();
			mainControl.MonthPicker('option','MonthFormat', 'yymm');
			$("#MonthPicker_" + _schema.id).css("width","160px");   
			
		}else if(_schema.type == 'dateButton'){
			//==chart container create
			//mainContainer = $(document.createElement( "div" ));
			//mainContainer.attr("id",_schema.id + 'Container');
			if(_schema.parentContainerId != undefined){
				mainContainer = $("#"  + _schema.parentContainerId);
				
				// btn
				mainControl = $(document.createElement("a"));
				mainContainer.append(mainControl);

				var span = $(document.createElement("span"));
				span.addClass("blind");
				
				mainControl.append(span);
			}
			else{
				mainContainer = $(document.createElement( "div" ));	
				
				var containerType = container.attr("type");
				if(_schema.parentSchema.type == 'HorizontalLayout'){
					mainContainer.css("display","inline-block");
					if(_schema.width != undefined)
						mainContainer.css("width",_schema.width);
				}
				
				// btn
				mainControl = $(document.createElement("a"));
				mainContainer.append(mainControl);

				var span = $(document.createElement("span"));
				span.addClass("blind");
				
				mainControl.append(span);
				container.append(mainContainer);
			}
		
		}else if(_schema.type == 'dateJquery'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			// text
			mainControl = $(document.createElement("input"));
			mainControl.attr("type","text");
			mainControl.attr("name",_schema.name);
			mainControl.attr("id",_schema.id);
			// mainControl.attr("readonly", "readonly");
			mainContainer.append(mainControl);	
			
			mainControl.datetimepicker({
				timepicker:false,
				datepicker: true ,
				format:'Y-m-d'
			});
			
			container.append(mainContainer);
		}else if(_schema.type == 'title'){
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				if(container.children().length > 0)
					mainContainer.css("margin-left","1px");
			}
			mainControl = $(document.createElement("h3"));
			mainContainer.append(mainControl);
			mainControl.addClass("cont_tit");
			mainControl.text(_schema.label);
			container.append(mainContainer);
		}else if(_schema.type == 'emptyDiv'){
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				if(container.children().length > 0)
					mainContainer.css("margin-left","1px");
			}
			
			container.append(mainContainer);
		}else if(_schema.type == 'tab_list'){
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container' )
			mainContainer.addClass("tit_btn");
			mainContainer.addClass("m_top_10");			
			
			mainControl = $(document.createElement( "ul" )); 
			mainControl.attr("id",_schema.id + 'Ul');
			mainControl.addClass("tab_2depth");
			mainContainer.append(mainControl);
			
			container.append(mainContainer);
		}else if(_schema.type == 'tab_iframe'){
			var topContainer = fn_findTopContainer.call(_schema);
			var v_ul = $(_schema.parentContainer).find("ul");
			
			var v_li = $(document.createElement( "li" ));
			v_li.attr("id", _schema.id + 'Tab' );
			v_li.attr("target", _schema.id + 'Content' );
			v_ul.append(v_li);
			
			var mainControl = $(document.createElement( "a" ));
			mainControl.attr("id", _schema.id + '_a' );
			mainControl.attr("origin_id", _schema.id );
			$.each(_schema.connected_content, function(key,val){
				mainControl.attr(key,val);
			});
			mainControl.text(_schema.label);
			v_li.append(mainControl);		
			
			var content_id = _schema.id + 'Content';
			var frame_id = _schema.id + 'Frame';
			var v_content = null;
			var v_frame = null;
			if($("#"+content_id).length > 0 ){
				v_content = $("#"+content_id);
				v_frame = ("#"+frame_id);
			}else {
				//
				v_content = $(document.createElement( "div" ));
				v_content.attr("id", _schema.id + 'Content');
				//v_content.css("margin-top","10px");
				//v_content.css("padding","0 10px 0 10px");
				v_content.css("width","100%");
				$(window.document.body).append(v_content);
				
				//iframe
				var v_frame = $(document.createElement( "iframe" ));
				v_frame.attr("id", _schema.id + 'Frame');
				v_frame.attr("name", _schema.id + 'Frame');
				v_frame.css("width","100%");
				v_frame.css("height","1550px");
				
				if(_schema.iframe_css != null){
					$.each(_schema.iframe_css,function(i,v){
						v_frame.css(v.code,v.value);
					});
				}
				v_content.append(v_frame);
			}
			
			
			
			
			//tab 클릭시 동작
			if( _schema.events == undefined || _schema.events.click == undefined ){
				mainControl.on("click",function(){
					
					$.each(_schema.parentSchema.elements,function(i,el){
						$("#"+el.id + 'Tab').removeClass('on'); 
						$("#"+el.id + 'Tab').removeClass('off');
						$("#"+el.id + 'Tab').addClass('off');
						
						$("#"+el.id + 'Content').hide();
					});
					$("#" + _schema.id + 'Tab').removeClass("off");
					$("#" + _schema.id + 'Tab').addClass("on");
					v_content.show();
					
					var roaded = mainControl.attr("roaded");
					if(roaded == undefined ) roaded = 'n';
					if( roaded != 'n')
						return;
					
					var viewName = $(this).attr("viewName");
					var form_id = $(this).attr("form_id");
					
					//todo from this
					//var vform = $(document.createElement( "form" ));
					
					var vform =  document.getElementById(form_id);
					vform.action = './generic.html?viewName='+viewName;
					vform.method = "post";
					vform.target = _schema.id + 'Frame';
					//vform.target = v_content[0];
					vform.submit();
					
					mainControl.attr("roaded","y");
					
					
				});
			}
			
			var cur_index = null;
			$.each(_schema.parentSchema.elements,function(i,el){
				if(el == _schema){
					cur_index = i;
					return false;
				}					
			});
			
			if(cur_index == 0 ){
				v_li.addClass("on")
				v_content.css("display", "");				
				
				// load content
				if( _schema.events == undefined || _schema.events.click == undefined ){
					mainControl.trigger("click");
				}else {
					_schema.events.click.call(mainControl);
				}
				
				//mainControl.trigger("click");
			}else{
				v_li.addClass("off")
				v_content.css("display", "none");
			}
			
		}else if(_schema.type == 'tab_list_ssd'){
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container' )
			mainContainer.addClass("tab_master");
			// mainContainer.addClass("m_top_10");			
			
			mainControl = $(document.createElement( "ul" )); 
			mainControl.attr("id",_schema.id + 'Ul');
			mainControl.addClass("tab_list");
			mainContainer.append(mainControl);
			
			container.append(mainContainer);
		}else if(_schema.type == 'tab_iframe_ssd'){
			var topContainer = fn_findTopContainer.call(_schema);
			var v_ul = $(_schema.parentContainer).find("ul");
			
			var v_li = $(document.createElement( "li" ));
			v_li.attr("id", _schema.id + 'Tab' );
			v_li.attr("target", _schema.id + 'Content' );
			v_li.addClass("tab_item");
			v_ul.append(v_li);
			
			var mainControl = $(document.createElement( "a" ));
			mainControl.attr("id", _schema.id + '_a' );
			mainControl.attr("origin_id", _schema.id );
			mainControl.addClass("tab_link");
			$.each(_schema.connected_content, function(key,val){
				mainControl.attr(key,val);
			});
			mainControl.text(_schema.label);

			v_li.append(mainControl);		
			
			var content_id = _schema.id + 'Content';
			var frame_id = _schema.id + 'Frame';
			var v_content = null;
			var v_frame = null;
			if($("#"+content_id).length > 0 ){
				v_content = $("#"+content_id);
				v_frame = ("#"+frame_id);
			}else {
				//
				v_content = $(document.createElement( "div" ));
				v_content.attr("id", _schema.id + 'Content');
				//v_content.css("margin-top","10px");
				//v_content.css("padding","0 10px 0 10px");
				v_content.css("width","100%");
				$(window.document.body).append(v_content);
				
				//iframe
				var v_frame = $(document.createElement( "iframe" ));
				v_frame.attr("id", _schema.id + 'Frame');
				v_frame.attr("name", _schema.id + 'Frame');
				v_frame.css("width","100%");
				v_frame.css("height","1550px");
				
				if(_schema.iframe_css != null){
					$.each(_schema.iframe_css,function(i,v){
						v_frame.css(v.code,v.value);
					});
				}
				v_content.append(v_frame);
			}
			
			//tab 클릭시 동작
			if( _schema.events == undefined || _schema.events.click == undefined ){
				mainControl.on("click",function(){
					$.each(_schema.parentSchema.elements,function(i,el){
						$("#"+el.id + 'Tab').removeClass('selected'); 
						$("#"+el.id + 'Content').hide();
					});
					$("#" + _schema.id + 'Tab').addClass("selected");
					v_content.show();
					
					var roaded = mainControl.attr("roaded");
					if(roaded == undefined ) roaded = 'n';
					if( roaded != 'n')
						return;
					
					var viewName = $(this).attr("viewName");
					var form_id = $(this).attr("form_id");
					
					var vform =  document.getElementById(form_id);
					vform.action = './generic.html?viewName='+viewName;
					vform.method = "post";
					vform.target = _schema.id + 'Frame';
					//vform.target = v_content[0];
					vform.submit();
					
					mainControl.attr("roaded","y");
				});
			}
			
			var cur_index = null;
			$.each(_schema.parentSchema.elements,function(i,el){
				if(el == _schema){
					cur_index = i;
					return false;
				}					
			});
			
			if(cur_index == 0 ){
				v_li.addClass("selected")
				v_content.css("display", "");				
				
				// load content
				if( _schema.events == undefined || _schema.events.click == undefined ){
					mainControl.trigger("click");
				}else {
					_schema.events.click.call(mainControl);
				}
				
				//mainControl.trigger("click");
			}else{
				v_content.css("display", "none");
			}
			
		}		//******* common properties *******//
		
		//*** default value ***//
		if(mainControl != null  && _schema.value != undefined){
			if(typeof _schema.value == 'string')
				mainControl.val(_schema.value);
			else if(typeof _schema.value == 'function')
				mainControl.val(_schema.value());
		}
		
		//***  class ***//
		if(mainControl != null  && _schema.cls != undefined)
			mainControl.addClass(_schema.cls);
		
		//***  events ***//
		//if(_schema.events != undefined && _schema.events.click != undefined)
		//	vInput.click(_schema.events.click);
		if(mainControl != null  && _schema.events != undefined ){
			$.each(_schema.events,function(ikey,event){
				mainControl.on( ikey, event);
				
			});
		}
		
		
		var containerType = container.attr("type");
		//***  class ***//
		if(mainContainer != null  && _schema.containerCls != undefined)
			mainContainer.addClass(_schema.containerCls);
		//***  css ***//
		if(mainContainer != null && _schema.parentSchema != undefined && _schema.parentSchema.type == 'HorizontalLayout'){
			mainContainer.css("display","inline-block");
			if(_schema.width != undefined)
				mainContainer.css("width",_schema.width);
		}
		//- control
		if(mainControl != null && _schema.controlCss != null){
			$.each(_schema.controlCss,function(i,v){
				mainControl.css(v.code,v.value);
			});
		}
		//- container
		if(mainContainer != null && _schema.containerCss != null){
			$.each(_schema.containerCss,function(i,v){
				mainContainer.css(v.code,v.value);
			});
		}
		
		
		//******* End common properties *******//
		
		
		// data process
		if(_schema.elements != undefined &&  _schema.label != undefined){
			
			if(_schema.label != ""){
				var h3 = $(document.createElement("h3"));
				h3.addClass("cont_tit");
				h3.text(_schema.label);
				container.append(h3);
			}
			
			
			containerSub = $(document.createElement("div"));
			container.append(containerSub);
			
			//상위 container type을 줘서 알아서 판단 할 수 있도록 한다.
			containerSub.attr("type", _schema.type);
			if(_schema.parentSchema != undefined 
					&& _schema.parentSchema.type == 'HorizontalLayout'){
				
				containerSub.css("display","inline-block");
				if(_schema.width != undefined)
					containerSub.css("width",_schema.width);
				//if(container.children().length > 0)
				//	containerSub.css("margin-left","10px");
			}
			
			
		}
		
		if(_schema.elements != undefined){
			$.each(_schema.elements, function(i,el){
				
				el.parentSchema = _schema;
				el.parentContainer = container;
				fn_makeHtml(containerSub,el);
				/* if(el.type == 'inline'){
					makeInline(containerSub, el);
				}else if(el.type == 'grid'){
					makeGrid(containerSub , el );
				}else if(el.type == 'chart'){
					makeChart(containerSub , el );
				}else if(el.type == 'SearchHeader'){
					makeSearchHeader(containerSub , el );
				}else if(el.type == 'multiCombo'){
					makeMultiCombo(containerSub , el );
				}else if(el.elements != undefined){
					makeHtml(container, el);
				} */
			});
		}
		
		
		
		// $("div.ui-multiselect-menu").css("width","400px");
		// $(".ui-multiselect-filter input").css("width","150px");

}

function fn_makeDataForChart(param){
	//rturns		
	var rtn_series = [];
	var rtn_keys = [];
	var rtn_category = {x:[],x1:[],xindex:{},y:[],y1:[],yindex:{}};
	var rtn = {
			series : rtn_series,
			keys: rtn_keys,
			category : rtn_category
	};
	
	// parameters
	var p_dataSrc = param.dataSrc;
	var p_sorts = param.sorts;
	var p_seriesKey = param.seriesKey;
	var p_seriesIndex = param.seriesIndex;
	//var p_filters = param.filters;
	var p_convertDefiines = param.convertDefiines;
	var p_xCategoryCol = param.xCategoryCol;
	var p_xCategoryColOrderbyStr = param.xCategoryColOrderbyStr;
	var p_xCategoryAddIfEmpty = param.xCategoryAddIfEmpty;
	var p_xCategoryIndex = param.xCategoryIndex;
	var p_xCategoryFn = param.xCategoryFn; // function을 쓰는 것은 추전하지 않음.
	var p_xCategoryIndicate = param.xCategoryIndicate; // xCategory 의 index를 지정할 것인지. bubble chart의 경우.
	var p_yCategoryCol = param.yCategoryCol;
	var p_yCategoryFn = param.yCategoryFn;
	var p_yCategoryIndicate = param.yCategoryIndicate;
	//var p_xCategoryIndicateIndex = param.xCategoryIndicateIndex; // xCategoryIndicate 가 true인경우.  x축 에서 x축을 지정하는 경우 필요한 index.
	var p_isGroupby = param.isGroupby; // group by를 안하는 것으로 가정한다. 
	
	
	// alasql table
	var v_tablename = param.tablename;
	
	//01. convertdata
	//02. xCategory
	//03. yCategory
	//04. makeSeries
	
	
	
	//02. xCategory
	if(p_xCategoryCol != undefined && p_xCategoryCol != ''){
		if(p_xCategoryColOrderbyStr != undefined && p_xCategoryColOrderbyStr != '')
			rtn_category.x = alasql('select distinct '+ p_xCategoryCol +' from  ' + v_tablename + ' order by ' + p_xCategoryColOrderbyStr) ;
		else
			rtn_category.x = alasql('select distinct '+ p_xCategoryCol +' from  ' + v_tablename + ' order by ' + p_xCategoryCol) ;
		
		rtn_category.x = _.map(rtn_category.x,function(m,i){
			var rtn ={idx:i};
			rtn_category.xindex[m[p_xCategoryCol]] = rtn;
			if(p_xCategoryFn != undefined){
				return p_xCategoryFn.call(m,rtn);
			}else{
				rtn[p_xCategoryCol] = m[p_xCategoryCol];
				return rtn;
			}
				
		});
		rtn_category.x1 = _.pluck(rtn_category.x,p_xCategoryCol);
		
		
		var v_sql = 'select ';
		v_sql += p_seriesKey.cd + ', ' + p_seriesKey.name;
		v_sql += ' from ' + v_tablename;
		v_sql += ' group by ' + p_seriesKey.cd + ', ' + p_seriesKey.name
		var v_group = alasql(v_sql);
		if(p_xCategoryAddIfEmpty != undefined && p_xCategoryAddIfEmpty){
			$.each(rtn_category.x,function(i,category){
				$.each(v_group,function(j , s){
					var v_data = [];
					if(p_xCategoryIndex != undefined){
						var index = category[p_xCategoryCol] + '`'+s[p_seriesKey.cd];
						var indexDef = alasql.tables[v_tablename].inddefs[p_xCategoryIndex];
						var indexTarget = alasql.tables[v_tablename].indices[indexDef.hh];
						v_data = indexTarget[index];			
						if(v_data == undefined)
							v_data = [];
					}else{
						v_sql = 'select * from ' + v_tablename ;
						v_sql += ' where ';
						v_sql += p_xCategoryCol + ' = "'+category[p_xCategoryCol]+'"';
						v_sql += ' and ' + p_seriesKey.cd + ' = "'+s[p_seriesKey.cd]+'"';
						v_data = alasql(v_sql);
					}
					
					if(v_data.length == 0 || v_data == undefined){
						var nilObj = {};
						$.each(alasql.tables[v_tablename].columns,function(j,col){
							nilObj[col.columnid] = null;
						});
						nilObj[p_seriesKey.cd] = s[p_seriesKey.cd];
						nilObj[p_seriesKey.name] = s[p_seriesKey.name];
						nilObj[p_xCategoryCol] = category[p_xCategoryCol];
						//nilObj['x'] = category['idx'];
						
						$.each(p_convertDefiines,function(index,col){
							if((nilObj[col.col]==null || nilObj[col.col] == undefined || isNaN(nilObj[col.col]) ) && col.hasOwnProperty('isnull'))
								nilObj[col.col] = col.isnull ;
						});

						v_sql = 'INSERT INTO '+ v_tablename +' VALUES (';
						var vcolumns = [];
						$.each(alasql.tables[v_tablename].columns,function(j,col){
							if(nilObj[col.columnid] ==  null){
								vcolumns.push('null');
							}
							else if(col.dbtypeid == 'STRING')
								vcolumns.push('"'+nilObj[col.columnid]+'"');
							else
								vcolumns.push(nilObj[col.columnid]);
						});
						v_sql += vcolumns.join(",");
						v_sql += ')';
						//alasql(v_sql);
						//alasql('INSERT INTO ' + v_tablename + ' SELECT * FROM ?',[nilObj]);
						p_dataSrc.push(nilObj);
					}
					
				});
			});
		}
		
		
	}
	
	//03. yCategory
	if(p_yCategoryCol != undefined && p_yCategoryCol != ''){
		rtn_category.y = alasql('select distinct '+ p_yCategoryCol +' from  ' + v_tablename + ' order by ' + p_yCategoryCol) ;
		
		rtn_category.y = _.map(rtn_category.y,function(m,i){
			var rtn ={idx:i};
			rtn_category.yindex[m[p_yCategoryCol]]=rtn;
			if(p_yCategoryFn != undefined){
				return p_yCategoryFn.call(m,rtn);
			}else{
				rtn[p_yCategoryCol] = m[p_yCategoryCol];
				return rtn;
			}
				
		});
		rtn_category.y1 = _.pluck(rtn_category.y,p_yCategoryCol);
	}
	
	//04. makeSeries
	alasql(p_seriesIndex.sql);
	var indexDef = alasql.tables[v_tablename].inddefs[p_seriesIndex.index];
	var indexTarget = alasql.tables[v_tablename].indices[indexDef.hh];
	$.each(indexTarget,function(k,v){
		if(p_xCategoryCol != undefined && p_xCategoryCol != "")
			sortObjects(v,[p_xCategoryCol]);
		rtn_series.push({name:k,id:k,data:v});
		
		if(p_xCategoryIndicate){
			$.each(v,function(i,d){
				//if(d[p_xCategoryCol] == '00022_[test_Host]_ncq_random_long')
				//	var aaa = "";
				//var index1 = d[p_xCategoryCol] + '`'+s[p_seriesKey.cd];
				//var indexDef1 = alasql.tables[v_tablename].inddefs[p_xCategoryIndex];
				//var indexTarget1 = alasql.tables[v_tablename].indices[indexDef.hh];
// 					var  targetCategory = alasql('select idx from ? where '+ p_xCategoryCol +' = "' + d[p_xCategoryCol]  + '"', [rtn_category.x]);
// 					if(targetCategory.length > 0)
// 						d.x = targetCategory[0].idx;
				d.x = rtn_category.xindex[d[p_xCategoryCol]].idx;
				
			});
		}
		
		if(p_yCategoryIndicate){
			$.each(v,function(i,d){
				//var  targetCategory = alasql('select idx from ? where '+ p_yCategoryCol +' = "' + d[p_yCategoryCol]  + '"', [rtn_category.y]);
				//if(targetCategory.length > 0)
				//	d.y = targetCategory[0].idx;
				d.y = rtn_category.yindex[d[p_yCategoryCol]].idx;
			});
		}
		
	});
	
	
	//01. convertdata
	if(p_convertDefiines != undefined && p_convertDefiines.length > 0){
		$.each(rtn_series,function(i,s){
			$.each(s.data,function(j,d){
				$.each(p_convertDefiines,function(index,col){
					if((d[col.col]==null || d[col.col] == undefined || isNaN(d[col.col]) ) && col.hasOwnProperty('isnull'))
						d[col.col] = col.isnull ;
					
					if(col.datatype == 'date'){
						d[col.convert] = convertDateToUct(d[col.col]);
						
					}else if(col.datatype == 'int'){
						d[col.convert] = d[col.col]*1;
					}else{
						d[col.convert] = d[col.col];
					}
					
				});			
			});
		});
	}
	
	
	return rtn;
}
	
$.fn.serializeFormJSON = function () {

	var o = {};
	var a = this.serializeArray();
	$.each(a, function () {
		if (o[this.name]) {
			if (!o[this.name].push) {
				o[this.name] = [o[this.name]];
			}
			o[this.name].push(this.value || '');
		} else {
			o[this.name] = this.value || '';
		}
	});
	return o;
};

function serializeArrayJSON(a) {

	var o = {};
	// var a = this.serializeArray();
	$.each(a, function (i , _obj) {
		$.each(Object.keys(this) , function(j, key){
			let val = _obj[key];
			if (o[key]) {
				if (!o[key].push) {
					o[key] = [o[key]];
				}
				o[key].push( val || '');
			} else {
				o[key] = val || '';
			}
		});
		
	});
	return o;
};


function filterAllByElName(items ,findJson) {
    var i = 0, found, result = [];    

	if(typeof items == 'string')
		return result;
	if(typeof items == 'function')
		return result;
	if(items["tagName"] != null)
		return result;
    if(_.isArray(items)){
        var vfind = _.find(items,findJson);
        if(vfind != null)
            result.push(vfind);
        else{
			$.each(items,function(j,item){
				if(item != null){
					found = filterAllByElName(item, findJson);
					if (found.length) {
						result = result.concat(found);
					}
				}
				
				
			});
			// for(var j=0; j < items.length ; j++){
			// 	var item = items[j];
			// 	found = filterAllByElName(item, findJson);
			//     if (found.length) {
			//         result = result.concat(found);
			//     }
			// }
		}
            
        
    }else if(_.isObject(items)){
        var vfind = _.find([items],findJson);
        if(vfind != null)
            result.push(vfind);
        else{
	
			$.each(items,function(j,item){
				if(j == "parentSchema")
					return true;
				if(item != null){
					found = filterAllByElName(item ,findJson);
					if (found.length) {
						result = result.concat(found);
					}
				}
				
			});
			// for(var j=0; j < items.length ; j++){
			// 	var item = items[j];
			// 	found = filterAllByElName(item, findJson);
			//     if (found.length) {
			//         result = result.concat(found);
			//     }
			// }
		}
        

    }

    return result;
}

function findAllByElName(items, findJson){
    var result = [];
    result = filterAllByElName(items,findJson);
    if(result.length > 0)
        return result[0];
    else
        return undefined;
}

function List2Tree( _list, _keys){
	var _this = this;
	this.list = _list;	
	this.keys = [];
	$.each(_keys, function(i,key){
		if(typeof key == 'string'){
			key = {
				codeColumn : key,
				nameColumn : key
			};
		}
		_this.keys.push(key);
	});


	this.tree = {
		core: {
			data : [
				{
					text : "root",
					id : "root" ,
					state : {opened: false},
					children : []
				}
			]
		}
		// ,'check_callback': true
	};


	if (alasql.tables['table_tree'] != null)
		alasql('drop table table_tree');
	var v_sql = 'create table table_tree(';
	var i = 0;
	$.each(_this.keys,function(k,v){
		let key = _keys[k];
		if(i > 0)
			v_sql += ' , ';
		v_sql += v.codeColumn.toUpperCase() + ' ' + 'string';
		if ( v.codeColumn != v.nameColumn )
			v_sql += ' , ' + v.nameColumn.toUpperCase() + ' ' + 'string';
		i += 1;
	});
	v_sql += ')';
	alasql(v_sql);

	alasql.tables["table_tree"].data = _this.list;
	$.each( _this.keys, function(i,key){
		alasql('create index idx_tree' +  _.camelCase(key.codeColumn) + ' on table_tree(' +  _.map(_this.keys.slice( 0, i+1 ),function(_key){ return _key.codeColumn.toUpperCase();}).join(',') + ')');
	});
	_this.fn_keys( [] , _this.tree.core.data[0].children,  0);
	
}
List2Tree.prototype.fn_keys = function( _parentKeyValues , to_list , _index){
	var _this = this;
	var key = this.keys[_index];
	
	var vWheres = this.keys.slice( 0, _index );
	var vSql = "";
	if (key.codeColumn != key.nameColumn)
		vSql = 'select distinct ' + key.codeColumn.toUpperCase() + ',' + key.nameColumn.toUpperCase() + ' from table_tree where 1=1';
	else
		vSql = 'select distinct ' + key.codeColumn.toUpperCase() + ' from table_tree where 1=1';
	if( _index > 0){
		vSql += " and " + _.map(vWheres, function(where ,i){
			return where.codeColumn.toUpperCase()  + ' = "' + _parentKeyValues[i].value + '"';
		}).join(" and ");
	}
	var list = alasql(vSql);
	// if (list.length > 0 && list["children"] == null)
	// 	list["children"] = [];
	$.each(list , function(i,m){
		var item = {
			text : m[key.nameColumn.toUpperCase()],
			value: m[key.codeColumn.toUpperCase()], 
			field: key.codeColumn.toUpperCase() , 
			id : _.map(_parentKeyValues , 'value').concat( m[key.codeColumn.toUpperCase()] ).join(";;;") ,
			state : {opened: false},
			children : []
		};
		to_list.push( item );
		if ( (_this.keys.length -1) > _index ){
			var parameters = _.cloneDeep( _parentKeyValues );
			parameters.push({"key": key.codeColumn.toUpperCase(),"value": m[key.codeColumn.toUpperCase()]});
			_this.fn_keys ( parameters , item.children, _index + 1);
		}
			
	});
	
	
}
function fn_list2tree(_jsarr,_pkeys){
	var abcArr = _jsarr;
	var items = {}, base, key,val ;
	for (var i = 0; i < abcArr.length; i++) {
	    base = abcArr[i];
	    
	    var pkey = '';
	    var key = '';
	    for(var j=0; j < _pkeys.length; j++){
	    	pkey = _pkeys[j];
	    	if(j>0)
	    		key += ";;;";
	    	key += base[pkey];
	    }
	    // if not already present in the map, add a zeroed item in the map
	    if(!items[key]){
	    	items[key] = [];
	    }
	    	
	    // add new item to the map entry
	    items[key].push;
	}

	// Now, generate new array
	var outputArr = [], temp;
	for (key in items) {
	    // create array entry for the map value
	    //temp = [key, items[key]];
		temp = {};
		//temp[tCol] =  items[key];
		temp.count =  items[key];
		
		//create original columns
	    for(var j=0; j < _pkeys.length; j++){
	    	var pkey = _pkeys[j];
	    	//if(temp[pkey])
	    		temp[pkey] = key.split(';;;')[j];
	    }
	    // put array entry into the output array
	    outputArr.push(temp);
	}
	
	return outputArr;
}
function decamelize(str, separator){
	separator = typeof separator === 'undefined' ? '_' : separator;
	return str
        .replace(/([a-z\d])([A-Z])/g, '$1' + separator + '$2').replace(/([A-Z]+)([A-Z][a-z\d]+)/g, '$1' + separator + '$2').toLowerCase();
}