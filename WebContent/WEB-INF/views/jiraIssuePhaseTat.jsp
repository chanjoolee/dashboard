<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>Phase TAT</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
    
    <script type="text/javascript" src="js/jqGrid/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="js/jqGrid/i18n/grid.locale-kr.js"></script>
    
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/i18n/grid.locale-en.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/jquery.jqGrid.src.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/json2.js"></script> -->
    
    <%-- 2. high charts --%>
    
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. local --%>
	<script src="js/pms/resourceBySite.js"></script>
	<script src="js/pms/resourceByFunc.js"></script>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	//var dataList = [];
	/*
	$(function () {
		getDataByJson();
	});
	*/
	$(function () {
		var sender =  "${param.sender}";
		if(sender == 'pms'){
			//document.domain = 'hynix.com';
		}	
		
		projectListByAjax();
	});
	
	
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/projectListByJson.html",
			data: {division:'jira'},
			success : function(responseData){
				var projectList = responseData.projectList;
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
				if(paramPjtcode != "")
					getDataByJson(true);
			}
		});
	}
	
	function getDataByJson() {
		/*
		$.ajax({
			url : "/dashboard/jiraIssuePhaseTatJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				drawchart(responseData);
			}
		});
		*/
		
		if( $("#sProject").val() == "")
			return;
		var parameter = {};
		parameter.PJT_CODE = $("#sProject").val();
		$.ajax({
			type: "POST",
			url : "/dashboard/jiraIssuePhaseTatJson.html",
			data: $("#form").serialize() ,
			//modelAttribute:"searchVO",
			success : function(responseData){
				//responseDataG = responseData;
				drawchart(responseData);
			}
		});
	}
	
	function drawchart(responseData) {
		
		var threshold = 1000;
		if(responseData.dataList.length > 1000) {
			threshold = responseData.dataList.length;
		}
		
		var groupKeys = ['IMSI_SERIES','RESOLUTIONDATE'];
		var series = getDrillDownDataSeries2(
				'',
				responseData.dataList , 									// 데이타원본
				groupKeys , 										// grouping, sorting 순서
				[], 												// filter
				//[{col:'RESOLUTIONDATE', convert:'x', datatype:'date'},{col:'TAT', convert:'y', isnull:0}], 	// convert -> col 변수를 y 변수로 치환한다 (챠트에서 y 변수를 인식)
				[{col:'${param.tatDtType}', convert:'x', datatype:'date'},{col:'TAT', convert:'y', isnull:0}], 
				'', 										// x축
				'', 												// y값이 되는 컬럼, groupby시 에만 의미있음
				{cd: 'IMSI_SERIES', name:'IMSI_SERIES'},			// series 없으므로 가상의 Column 정의
				{isGroupby:false}
		);
		
		//+++++++++++++++++++++++++++++++++++++++++++++++++
		var plotBandsHigh = new Array();
		var plotLinesHigh = new Array();
		var dataPhase = responseData.phase;
		
		for(var i=0; i<dataPhase.length; i++) {	
			var plotBand = {};
			
			var phaseFromDtSplit = dataPhase[i].ACTUAL_START_DATE.split('/');
			plotBand.from = Date.UTC(phaseFromDtSplit[0], phaseFromDtSplit[1] - 1, phaseFromDtSplit[2]);
			
			var phaseToDtSplit = dataPhase[i].ACTUAL_END_DATE.split('/');
			plotBand.to = Date.UTC(phaseToDtSplit[0], phaseToDtSplit[1] - 1, phaseToDtSplit[2]);
			
			plotBand.label = {
					text : '<span style="color:' + phaseColor[dataPhase[i].PHASE] + '">' + dataPhase[i].PHASE + '</span><br/>' ,
					style: {
						color: '#606060' ,
						fontWeight : 'bold'
					}
			};	
			plotBandsHigh.push(plotBand);
			
			var plotLine = {
					color:'black',
					width:1,
					value: 0 ,
					dashStyle: 'ShortDash'			
			};
			
			var phaseSplit = dataPhase[i].ACTUAL_END_DATE.split('/');
			plotLine.value = Date.UTC(phaseSplit[0], phaseSplit[1] - 1, phaseSplit[2]);
			plotLinesHigh.push(plotLine);
		}
		//+++++++++++++++++++++++++++++++++++++++++++++++++
		
		if($('#container').highcharts() != undefined) {
			$('#container').highcharts().destroy();
		}
		
		$('#container').highcharts({
	        chart: {
	            type: 'scatter',
	            zoomType: 'xy'
	        },
	        colors: ['#483d8b'],
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'&nbsp;',
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	type: 'datetime',
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	dateTimeLabelFormats: { 
	        		//day: '%y/%m/%e'
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            },
	            plotBands: plotBandsHigh,
	            plotLines: plotLinesHigh
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	            	enabled: true,
	                text: '<b>Day</b>',
	                align: 'high',
	                style: {
	                    fontWeight: 'normal'
	                }
	            },
	            visible: false
	        },
	        legend: {
	        	enabled: false
	        },
	        tooltip: {
	            formatter: function () {
	            	var point = this.point;
	            	var createdDt = point.options.CREATED
	            	var resolvedDt = point.options.RESOLUTIONDATE;
	            	
            		var str = '<b>' + point.options.PJT_NAME + '</b><br/>';
                		str += 'Created : ' + createdDt.substr(0,4) + "-" + createdDt.substr(4,2) + "-" + createdDt.substr(6,2) + '<br/>';
                		str += 'Resolved : ' + resolvedDt.substr(0,4) + "-" + resolvedDt.substr(4,2) + "-" + resolvedDt.substr(6,2) + '<br/>';
                		str += 'TAT : <b>' + point.options.TAT + '</b>';
                	if(point.GRP_CNT > 1) {
                		str += ' (' + point.options.GRP_CNT + ')';
                	}
                	
                	return str;
	            }
	        },
	        plotOptions : {
	        	scatter : {
	        		turboThreshold: threshold
	        	},
	        	series : {
	        		cursor:'pointer',
        			events : {
        				click: function(event) {
        					//alert(event.point);
        					var url = 'http://jira.skhynix.com/browse/' + event.point.PROJECT_KEY + '-' + event.point.ISSUE_NUM;
        					window.open(url,'_blank');
        				}
        			}
	        	}
	        },
	        series: series.series
	    },function(chart){
	    		//after draw chart
		    }
		);
	}

	</script>
	<style type="text/css">
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow:hidden;
	     }
	      
		.container{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 100%;			
		}		
	</style>
</head>
<body style="height: 100%;width: 100%">
<form name="form" id="form">
<select name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson(true)" <c:if test="${param.pjt_code != null}"> style="display:none;"   </c:if> >
	<option>PROJECT SELECT</option>
</select>
<%-- 검색조건추가 2015-09-25 --%>
<input type="hidden" name="userId" value="${param.userId}"/>
<input type="hidden" name="solution" value="${param.solution}"/>
<input type="hidden" name="url" value="issueTrends.html"/>
<input type="hidden" name="tatDtType" value="${param.tatDtType}"/>

<div id="container" class="container"/>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
