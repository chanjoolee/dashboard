String.prototype.lpad = function(padString, length) {
    var str = this;
    while (str.length < length)
        str = padString + str;
    return str;
}

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
		url : "/dashboard/codesonarProjectDetailProjectListJson.html",
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
		url : "/dashboard/codesonarPriorityCsvLinkJson.html",
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
		url : "/dashboard/codesonarPriorityCsvLinkJson.html",
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
		url : "/dashboard/codesonarPriorityCsvLinkJson.html",
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
		url : "/dashboard/codesonarPriorityCsvLinkJson.html",
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
		url : "/dashboard/jiraPkeyLinkJson.html",
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
		var link = '/dashboard/goJiraCauseByDate.html';
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
		url : "/dashboard/jiraPkeyLinkJson.html",
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
		url : "/dashboard/jiraPkeyLinkJson.html",
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
	
	var dt1 = new Date(dateSplit[0],dateSplit[1],dateSplit[2]);
	var dt2= new Date(dt1.getFullYear(),dt1.getMonth(),dt1.getDate()+addnum); 
	
	var rtnDt = pad('0000',dt2.getFullYear(),true) + pad('00',dt2.getMonth(),true) + pad('00',dt2.getDate(),true);
	
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
	
	var dt1 = new Date(dateSplit[0],dateSplit[1],dateSplit[2]);
	var dt2= new Date(dt1.getFullYear(),dt1.getMonth() + addnum, dt1.getDate()); 
	
	var rtnDt = pad('0000',dt2.getFullYear(),true) + pad('00',dt2.getMonth(),true) + pad('00',dt2.getDate(),true);
	
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


