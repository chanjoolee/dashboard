<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>resolution analysis by issuetype</title>
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
	<!-- <script src="http://code.highcharts.com/highcharts.js"></script> -->
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<!-- <script src="js/highcharts/grouped-categories.js"></script> -->
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=1"></script>
	
	<%-- 5. local --%>
	<!-- <script src="js/pms/resourceBySite.js"></script>
	<script src="js/pms/resourceByFunc.js"></script> -->
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	
	var dataList = [];
	var dataListGroup = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/jiraAnalysisByDateIssueTypeJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){
		
		var groupKeys = ['PJT_CODE','PJT_NAME','ETC'];
		var series = [];
		var seriesIssueType = getDrillDownDataSeries2(
				'',
				dataList,
				groupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull:0}], //convert
				'ISSUETYPE', 
				'CNT',
				{cd: 'ETC', name:'ETC'},
				{isGroupby: false}
		);
		
		$.each(seriesIssueType.series,function(index,s){
			s.name = 'Issue Cnt';
			s.type = 'column';
			s.yAxis = 0;
			series.push(s);
		});
		
		var seriesTat = getDrillDownDataSeries2(
				'',
				$.extend(true,[],dataList) ,
				groupKeys ,
				[], //filter
				[{col:'AVG_TAT',convert:'y',isnull:0}], //convert
				'ISSUETYPE', 
				'AVG_TAT',
				{cd: 'ETC', name:'ETC'},
				{isGroupby: false}
		);
		
		$.each(seriesTat.series,function(index,s){
			s.name = 'Avg TAT';
			s.type = 'spline';
			s.yAxis = 1;
			s.tooltip = {
				valueSuffix : ' days'
			};
			series.push(s);
		});
		
		
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		
		$('#container').highcharts({
	        chart: {
	            //type: 'column',
	            zoomType:'x'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text: dataList[0].PJT_NAME ,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },	     
	        legend:{
	        	enabled: false
	        },
	        xAxis:{
	        	categories: seriesIssueType.category,
	        	labels:{
	        		
	        	} 
	        },
	        yAxis: [{
	        	min: 0,
	            title: {
	                text: 'Issue Cnt'
	            }
	            //,tickInterval:5
	        },{
	        	min: 0,
	            title: {
	                text: 'Avg TAT'
	            },
	            opposite: true
	        }],
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y}</b> <br/>',
	            shared: true,
	            enabled: true
	        },
	        //legend: legend,
	        plotOptions: {
	        	spline:{
	        		dataLabels: {
	        			format:'{point.y:.0f}'
	        		}
	        	},
	            column: {
	            	grouping: false,
	            	borderWidth: 0,
	            	cursor: 'pointer' ,
	            	point:{	                	
	                	events:{
	                		click: function(e){
	                			var name= "";
	                			
	                		}
	                	}
	                },
	                //stacking: 'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    //useHTML: true,
	                    format:'{point.y:.0f}',
	                    //x: 10,
	                    
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//gotoDetail(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series
	    },function(chart){
	    		//after draw chart
		 });
		
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
		
		.highcharts-tooltip span {
		    background-color:white;
		    z-index:9999;  
		}
	</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="jiraPjtCode" name="jiraPjtCode" value="${param.jiraPjtCode}"/>
<input type="hidden" id="pjtCode" name="pjtCode" value="${param.pjtCode}"/>
<input type="hidden" id="pjtName" name="pjtName" value=""/>
<input type="hidden" id="resolutionDate" name="resolutionDate" value="${param.resolutionDate}"/>
<c:forEach items="${paramValues.priority}" var="priority" varStatus="status">
	<input type="hidden" name="priority" value="${priority}"/>
</c:forEach>

<c:forEach items="${paramValues.issuetype}" var="issuetype" varStatus="status">
	<input type="hidden" name="issuetype" value="${issuetype}"/>
</c:forEach>

<c:forEach items="${paramValues.subProjects}" var="subProjects" varStatus="status">
	<input type="hidden" name="subProjects" value="${subProjects}"/>
</c:forEach>

<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
