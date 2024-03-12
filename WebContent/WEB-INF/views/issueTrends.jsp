<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>issueTrends</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<!-- Additional files for the Highslide popup effect -->
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	
	<script type="text/javascript">
	
	
	$(function () {
		
		var sender =  "${param.sender}";
		if(sender == 'pms'){
			//document.domain = 'hynix.com';
		}	
		projectListByAjax();
	});
	
	
	var responseDataG = {};
	var priorityG = [];
	var issueTypeG = [];
	var searchConditionG = {};
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/projectListByJson.do",
			data: {division:'jira'},
			success : function(responseData){
				var projectList = responseData.projectList;
				var paramPjtcode = "${param.pjt_code}" ;
				var selected ="";
				
				for(var i=0; i<projectList.length ; i++){
					var pjt_code = projectList[i].PJT_CODE;
					selected ="";
					if(paramPjtcode==pjt_code)
						selected = "selected";
					
					$("#sProject").append("<option value='"+ projectList[i].PJT_CODE +"' "+selected+">" + projectList[i].PJT_CODE +"</option>" );
					
				}	
				if(paramPjtcode != ""){
					//getSubProjectsInfo(paramPjtcode);					
					//getDataByJson(true);
					//2015-06-23 
					//checkSearchCondition();
					getAllSearchCondition();
				}
				
				/* if(parent.makeSearch != undefined){
					parent.makeSearch();
				} */
					
			}
		});
	}	
	
	
	/**
	*@param: changeOption boolean 검색옵션변경여부
	*/
	function getDataByJson(changeOption){
		if( $("#sProject").val() == "")
			return;
		var parameter = {};
	
		parameter.PJT_CODE = $("#sProject").val();
		parameter.userId = $('[name=userId]').val();
		parameter.solution =  $('[name=solution]').val();
		parameter.url =  $('[name=url]').val();
		
		
			var priorityList =[];
			priorityList.push('xxxx');
			$( "#priority :checkbox" ).each(function( index ) {
				if($(this).is(":checked",true))					
					priorityList.push($( this ).val() );
			});
			
			var issueTypeList =[];
			issueTypeList.push('xxxx');
			$( "#issueType :checkbox" ).each(function( index ) {
				if($(this).is(":checked",true))
					issueTypeList.push($( this ).val() );
			});
			
			var subProjects =[];
			subProjects.push('xxxx');
			$( "#subProjects :checkbox" ).each(function( index ) {
				if($(this).is(":checked",true))
					subProjects.push($( this ).val() );
			});
			
			parameter.priority = priorityList;
			parameter.issuetype =issueTypeList;
			parameter.subProjects =subProjects;
			
			
		
		
		$.ajax({
			type: "POST",
			url : "/dashboard/issueTrendsJson.do",
			data: parameter,
			modelAttribute:"searchVO",
			success : function(responseData){
				
				if(responseData.data.length == 0){
					if(parent != window && parent.noData){
						parent.noData();
						if(parent != window && parent.issueTrendsOnload)
							parent.issueTrendsOnload();
					}						
					return;
				}
				
				if(responseData.tat != null)
					$("#tat").text("※Average TAT (ResolvedDate - CreatedDate) = "+ responseData.tat.TAT +" days.");
				
				responseDataG = responseData;
				drawChart(responseData);
				if(parent != window && parent.issueTrendsOnload)
					parent.issueTrendsOnload();
			}
		});
	}
	
	
	// 가사의 UTC 날자로 실제 날의 가져올다.
	function getDataByUtc(pjtCode,utcDate){
		var dataRaw = responseDataG.data;
		for(var i=0;i<dataRaw.length;i++){
			var data = dataRaw[i];
			if(data.PJT_CODE == pjtCode && data.utcDate == utcDate )
				return data;//data.phaseSeqDt;
		}
		return 'error';
	}
	
	
	
	
	function drawIssueType(responseData){
		var priority = responseData.priority;
		var issuetype = responseData.issuetype;
		
		$( "#priority" ).html("<div style=\"width:100px;display:inline-block;float:left;\"><b>Priority:</b></div>");
		for(var i=0;i<priority.length;i++){
			var p = priority[i];
			$( "#priority" ).append('<div style=\"width:100px;display:inline-block;text-overflow:ellipsis;float:left;\" title="'+p.PRIORITY+'"><input type="checkbox" name="priority" class=\"mycheck\" value="'+p.PRIORITY+'" checked="checked" onchange="getDataByJson(false)"/><span>'+p.PRIORITY.substr(0,10)+'</span></div>' );
		}
		//$( "#priority" ).append( '<input type="checkbox" name="priority"  value="nothing" checked="checked" style="display: none;">' );
		
		$( "#issueType" ).html("<div style=\"width:100px;display:inline-block;float:left;\"><b>Issue Type:</b></div>");
		for(var i=0;i<issuetype.length;i++){
			var issue = issuetype[i];
			$( "#issueType" ).append('<div style=\"width:100px;height:20px;display:inline-block;text-overflow:hidden;float:left;\" title="'+issue.ISSUETYPE+'"><input type="checkbox" name="issuetype"  class=\"mycheck\"  value="'+issue.ISSUETYPE+'" checked="checked" onchange="getDataByJson(false)"/><span style=\"\">'+ issue.ISSUETYPE.substr(0,10)+'</span></div>' );
		}
		//$( "#issueType" ).append( '<input type="checkbox" name="issuetype"  value="nothing" checked="checked" style="display: none;">' );
		
		
	}
	
	
	

	
	
	
	
	function drawChart(responseData){
		var dataRaw = responseData.data;
		
		var data = [];	
		
		// 가져온데이타를 하이차트에 맞게 변형한다.
		// seriesP0: arearange ,  seriesP1: line
		var seriesP0 = new Array();
		var seriesP1 = new Array();
		
		var createStack = 0;
		var resolveStack = 0;
		var gapStack = 0;
		
		
		//subProject별로 된 데이타를 project별로 합친다.
		var dtwo = {PRE_DT:""};
		for (var i = 0; i < dataRaw.length; i++){
			if(dtwo.PRE_DT != dataRaw[i].PRE_DT){
				if(dtwo.PROJECT != undefined)
					data.push(dtwo);
				dtwo = {
						PROJECT: $("#sProject").val(),
						PRE_DT : dataRaw[i].PRE_DT,
						DEFECTS_DATE : dataRaw[i].DEFECTS_DATE,
						CREATED: dataRaw[i].CREATED,
						RESOLVED: dataRaw[i].RESOLVED
				};
			}else{
				dtwo.CREATED += dataRaw[i].CREATED;
				dtwo.RESOLVED += dataRaw[i].RESOLVED;
			}			
        }		
		data.push(dtwo);
		
		//서브프로젝트정보를 만든다. 서브프로젝트의 리스트 수는 똑같다.
		$.each(subProjectList,function(index,project){
			
			var dataProject = $.grep(dataRaw,function(d){			
				if(d.PROJECT == project.SUB_PJT_CODE)
					return d;
			});
			
			createStack = 0;
			resolveStack = 0;
			gapStack = 0;	
			
			for (var i = 0; i < dataProject.length; i++){		
				
				var d = dataProject[i];
				if(d.DEFECTS_DATE == undefined) 
					continue;
				var dateSplit = d.DEFECTS_DATE.split('/');			
				var utcDate = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]);
				d.utcDate = utcDate;	
				
				createStack += d.CREATED;
				resolveStack += d.RESOLVED;
				var gap = d.CREATED - d.RESOLVED;
				var gapStack = createStack - resolveStack;
				d.createStack = createStack;
				d.resolveStack = resolveStack;
				d.gapStack = gapStack;			
	        }
			subProjectInfo[project.SUB_PJT_CODE] = dataProject;
		});
		
		
		createStack = 0;
		resolveStack = 0;
		gapStack = 0;
		
		// 그래프에 보여줄 가상데이타만들기
		for (var i = 0; i < data.length; i++){			
			var d = data[i];
			if(d.DEFECTS_DATE == undefined) 
				continue;
			var dateSplit = d.DEFECTS_DATE.split('/');			
			var utcDate = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]);
			d.utcDate = utcDate;	
			
			createStack += d.CREATED;
			resolveStack += d.RESOLVED;
			var gap = d.CREATED - d.RESOLVED;
			var gapStack = createStack - resolveStack;
			d.createStack = createStack;
			d.resolveStack = resolveStack;
			d.gapStack = gapStack;			
        }
		
		// maxGap. 아래의 line 그래프보다 위에 존재하므로 가상데이타를 보여준다.
		var maxGap = 0;
		for (i = 0; i < data.length; i++){	
			if(data[i].gapStack > maxGap)
				maxGap = data[i].gapStack;
		}
		
		var mad = maxGap%50;
		maxGap += (50-mad);
		//maxGap = 0;
		// create_stack_virtual
		for (i = 0; i < data.length; i++){			
			var d = data[i];
			var dataP0 = {
				x: d.utcDate,
				low: d.resolveStack + maxGap,
				high: d.createStack + maxGap,				
				rawData: d // tooltip을 보여줄때 써먹을 수 있도록 한다.
			};
			
			var dataP1 = {
				x:d.utcDate,
				y:d.gapStack,
				rawData:d
			}
			
			//seriesP0.push([d.utcDate,d.createStack + maxGap , d.resolveStack + maxGap]);
			seriesP0.push(dataP0);
			//seriesP1.push([d.utcDate,d.gapStack]);
			seriesP1.push(dataP1);
        }
		
		
		// plotBands 구성
		var plotBandsHigh = new Array();
		var plotLinesHigh = new Array();
		var bandIndex = 0;
		var dataPhase = responseData.phase;
		for (var i = 0; i < dataPhase.length; i++){	
			//------------- plotBands 구성. Phase -----------//
			var plotBand = {};
			var phaseDtSplit = dataPhase[i].ACTUAL_START_DATE.split('/');
			//plotBand.borderColor = 'rgba(0, 0, 0, 0.1)';
			//plotBand.borderWidth = 1;
			// from
			plotBand.from = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			
			// to
			var phaseDtSplit1 = dataPhase[i].ACTUAL_END_DATE.split('/');
			plotBand.to = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
			
			// label
			plotBand.label = {
					text : dataPhase[i].PHASE ,
					style: {
						color: '#606060' ,
						fontWeight : 'bold',
						fontSize: 15 // 2015-10-27 
					}
			};	
			plotBandsHigh.push(plotBand);
			
			//-------------   plotLine 구성.  ----------------//
			var plotLine = {
					color:'black',
					width:1,
					value: 0 ,
					dashStyle: 'ShortDash'			
			};
			
			
			var phaseDtSplit = dataPhase[i].ACTUAL_END_DATE.split('/');
			plotLine.value = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			plotLinesHigh.push(plotLine);
			
			
		}
		
		
		var title = $("#sProject").val();
		if( window != parent.window )
			title = "Issue Trends";
		
		if(seriesP0.length == 0){
			if(parent != window && parent.noData)
				parent.noData();
			return;
		}
		
		$('#container').highcharts({
	        chart: {
	        	zoomType: 'x'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: ''//title
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	//tickInterval: 24 * 3600 * 1000 * 7,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y'
	            },
	            //title: {
	            //    enabled: false
	            //},
	            plotBands : plotBandsHigh,
	            plotLines: plotLinesHigh
	           ,labels: {
	        	   //rotation: 290
	                /* formatter: function () {
	                	var dt = new Date(this.value);
	                	return (dt.getMonth()+1) + '.' + dt.getDate();
	                    
	                } */
	            }
	        },
	        yAxis: {
	            title: {
	                text: ''
	            },
	            labels:{
	            	formatter:function(){
	            		if(this.value >= maxGap)
	            			return this.value - maxGap
	            		return this.value;
	            	}
	            },
	            
	            min:0
	            
	        },
	        tooltip: {
	            shared: true ,
	            crosshairs: true,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: ''  /* ,
	            // 기본포맷 . formatter 함수로 하지 말고 fommat을 설정하도록 한다.
	            
	            
	            formatter: function (tooltip) {
	            		            	
	            	var items = this.points || splat(this),
	    			series = items[0].series,
	    			s;

		    		// build the header
		    		s = [tooltip.tooltipHeaderFormatter(items[0])];
	
		    		// build the values
		    		Array.prototype.forEach.call(items, function (item) {
		    			series = item.series;
		    			s.push((series.tooltipFormatter && series.tooltipFormatter(item)) ||
		    				item.point.tooltipFormatter(series.tooltipOptions.pointFormat));
		    		});
	
		    		// footer
		    		s.push(tooltip.options.footerFormat || '');
	
		    		return s.join('');
	            } */
	            
	        }, 
	        
	        legend: {
	        	enabled: false,
	        	shadow:true
	           
	        },
	        plotOptions: {
	        	arearange:{	        		
	        		tooltip:{
	        			pointFormat:'<span style="color:{series.color}">●</span> {series.name}: <b>{point.rawData.createStack}</b> - <b>{point.rawData.resolveStack}</b><br/>'
	        		}/* ,
	        		lineColor: 'rgba(0,0,0,0.7)',
		        	//negativeColor: 'rgba(0,0,255,1)',
		        	fillColor:'rgba(255,0,0,0.5)',
		        	//turboThreshold: 90,
		        	lineWidth: 2 */
	        	} /* ,
	            area: {
	                stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: true
	            } ,
	            line: {
	            	//stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 2,
	                marker: {
	                	//enabled: false,
	                    lineWidth: 2,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false ,
	                    radius: 2
	                },
	                enableMouseTracking: true
	            } */,
	            series:{
	            	cursor:'pointer'
	            	,lineWidth:2
	            	,marker:{
	            		enabled:false,
	            		lineWidth:2
	            	},
	            	point:{
	                	events:{
	                		click: function(e){
	                			htmlExpandIssueTrend($("#sProject").val(),"P0: High",this);
	                		}
	                	}
	                }
	            }
	        },
	        series: [{
	        	type: 'arearange',
	            name: 'Create-Resolve',
	            data: seriesP0,	            
	            lineColor: 'rgba(0,0,0,0.7)',
	        	//negativeColor: 'rgba(0,0,255,1)',
	        	fillColor:'rgba(255,0,0,0.5)',
	        	//turboThreshold: 90,
	        	//lineWidth: 2,
	        	visible:true/* ,
	        	point: {
					events: {
						click: function(e) {
							//this.slice();
							//console.log(e);
							//location.href = e.point.url;
							//e.preventDefault();
						}
					}
				}, */
	        }
	        ,{
	        	type: 'line' ,
	            name: 'unresolved',
	            data: seriesP1,
	            visible:true,
	            lineWidth: 2,
	            lineColor: 'blue'
	            /* marker: {
                    radius: 2
                } */
	        }
	        ]
	    });
		
		//$('#container').highcharts.series[0].hide();
		//$('#container').highcharts.series[1].hide();
		// Apply the theme
		//Highcharts.setOptions(Highcharts.theme);
	}
	
	
	/**
	* 선택된 project Change
	**/
	function projectChanged(){
		//getSubProjectsInfo($("#sProject").val());
		//getDataByJson(true);
		getAllSearchCondition();
	}
	
	/**
	* jira project 하위 리스트 가져오기.
	* @param pjt_code: dashboard pjt_code
	**/
	function getSubProjectsInfo(pjt_code){
		var parameter = {};		
		parameter.PJT_CODE = $("#sProject").val();
		parameter.division = 'jira';
		$.ajax({
			type: "POST",
			async:false,
			url : "/dashboard/projectListSubByJson.do",
			data: parameter,
			modelAttribute:"searchVO",
			success : function(responseData){
				subProjectList = responseData.projectList;
				makeSubProjectsInfo(subProjectList);
			}
		});
	}
	
	
	
	function checkSearchCondition(){		
		$.ajax({
			type: "POST",
			async:false,
			url : "/dashboard/checkSearchConditionJson.do",
			data: $("#form").serialize() ,
			success : function(responseData){
				searchConditionG = $.extend({}, responseData.searchCondition);; 
				drawSearchCondition();
			}
		
		});
	}
	
	
	function drawSearchCondition(){
		var priority = searchConditionG.priority;
		var issuetype = searchConditionG.issuetype;
		
		$( "#priority" ).html("<div style=\"width:100px;display:inline-block;float:left;\"><b>Priority:</b></div>");
		for(var i=0;i<priorityG.length;i++){
			var p = priorityG[i];
			var pid = 'priority'+i;
			$( "#priority" ).append('<div style=\"width:100px;display:inline-block;text-overflow:ellipsis;float:left;\" title="'+p.PRIORITY+'"><input type="checkbox" name="priority" id="'+pid+'" class=\"mycheck\" value="'+p.PRIORITY+'"  onchange="getDataByJson(false)"/><span>'+p.PRIORITY.substr(0,9)+'</span></div>' );
			var val = getValueFromSimpleArray(priority,p.PRIORITY);
			if(val != ''){
				$('#'+pid).attr('checked', true);
			}
		}
		
		$( "#issueType" ).html("<div style=\"width:100px;display:inline-block;float:left;\"><b>Issue Type:</b></div>");
		for(var i=0;i<issueTypeG.length;i++){
			var issue = issueTypeG[i];
			var pid = 'issue'+i;
			$( "#issueType" ).append('<div style=\"width:100px;height:20px;display:inline-block;text-overflow:hidden;float:left;\" title="'+issue.ISSUETYPE+'"><input type="checkbox" name="issuetype" id="'+pid+'"  class=\"mycheck\"  value="'+issue.ISSUETYPE+'" onchange="getDataByJson(false)"/><span style=\"\">'+ issue.ISSUETYPE.substr(0,9)+'</span></div>' );
			var val = getValueFromSimpleArray(issuetype,issue.ISSUETYPE);
			if(val != ''){
				$('#'+pid).attr('checked', true);
			}
		}
		
		getSubProjectsInfo($("#sProject").val());
		getDataByJson();
		
		
	}
	
	
	function getAllSearchCondition(){		
		$.ajax({
			type: "POST",
			async:false,
			url : "/dashboard/issueTrendAllSearchConditionJson.do",
			data: $("#form").serialize() ,
			success : function(responseData){
				priorityG = responseData.priority;
				issueTypeG = responseData.issuetype;
				checkSearchCondition();
			}
		
		});
	}
	
	/**
	* jira 하위 프로젝트 표시하기.
	**/
	function makeSubProjectsInfo(projects){ 
		var subProjects = searchConditionG.subProjects;
		$( "#subProjects" ).html("<div style=\"width:100px;display:inline-block;float:left;\"><b>projects:</b></div>");
		for(var i=0;i<projects.length;i++){
			var p = projects[i];
			var pid = 'subprojects'+i;
			$( "#subProjects" ).append('<div style=\"width:150px;display:inline-block;text-overflow:ellipsis;float:left;\" title="'+p.SUB_PJT_CODE+'"><input type="checkbox" name="subProjects" id="'+pid+'"  class=\"mycheck\" value="'+p.SUB_PJT_CODE+'"  onchange="getDataByJson(false)"/><span>'+p.SUB_PJT_CODE.substr(0,15)+'</span></div>' );
			
			var val = getValueFromSimpleArray(subProjects,p.SUB_PJT_CODE);
			if(val != ''){
				$('#'+pid).attr('checked', true);
			}
		}
	}	
	
	
	function goJiraAnalysisByDateIssueType(pjtCode,date){
		var newWin1 = window.open("", "jiraAnalysisByDateIssueType", "left=300, top = 200, width=1000,height=380,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		var oFrm = document.getElementById("form");
		oFrm.action =  '/dashboard/jiraAnalysisByDateIssueType.do?pjtCode='+pjtCode+'&resolutionDate='+date;
		oFrm.method = "post";
		oFrm.target = 'jiraAnalysisByDateIssueType'; 
	    oFrm.submit();
	    newWin1.focus();
	}

	
	</script>
	<style type="text/css">
		html,  body, form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow: hidden;
	        font-family:'Malgun Gothic';
	     }
	      
		.div-priority{
			/* width: 100%; */
			margin-left:10px;
			height: 20px;		
			display: block;	
			font-size: 12px;
			font-weight: bold;
			
			/* overflow: hidden; */
		}
		
		.div-tat{
			/* width: 100%; */
			margin-left:10px;
			height: 20px;		
			display: block;	
			font-size: 14px;
			font-weight: bold;
			color: blue;
			float: right;
			overflow: visible;
		}
		
		.dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 99%;
			height: 80%;
			/* z-index: -100; */
		}	
		
		
		
	</style>
</head>
<body>
<form name="form" id="form">
<%-- pms인증 --%>
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>

<select name="PJT_CODE" id="sProject" size="1"  onchange="projectChanged();" <c:if test="${param.pjt_code != null}"> style="display:none;"   </c:if> >
	<option>PROJECT SELECT</option>
</select>

<input type="hidden" name="userId" value="${param.userId}"/>
<input type="hidden" name="solution" value="${param.solution}"/>
<input type="hidden" name="url" value="issueTrends.html"/>

<div class="div-priority">
	<div id="subProjects"   style="float: left;"></div>
	<div style="float: right;font-size: 14px;font-weight: bold;">Updated every hour&nbsp;&nbsp;</div>
</div>
<div id="priority" class="div-priority"></div>
<div id="issueType" class="div-priority" style="/* float: left */"></div>
<div id="tat" class="div-tat"></div>
<div id="container" class="dashboard-div"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
