<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>pmsTat</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
    
    <script type="text/javascript" src="js/jqGrid/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="js/jqGrid/i18n/grid.locale-kr.js"></script>
    
    <%-- 2. high charts --%>    
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. local --%>
	
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	
	<script type="text/javascript">
	var mindtG = null;
	var maxdtG = null;
	$(document).ready(function(){
		//$("#makeitmove").draggable( {containment: "#containerPie", scroll: false} );
	});
	
	$(function () {
		//projectListByAjax();
		//drawChart();
		getDataByJson();
	});
		
	
	
	function getDataByJson(){
		 
		var parameter = {};
		
		$.ajax({
			//type: "POST",
			async: true,
			url : "/dashboard/pmsTatByModelJson.do",
			data: $("#form1").serialize(),
			//modelAttribute:"searchVO",
			success : function(responseData){
				drawChart(responseData);
			}
		});
	}
	
	
	function drawChart(responseData){
		makeDataModelPlan(responseData.dataList,{startDt:'STD_START_DATE',endDt:'STD_END_DATE',targetCol:'TAT_STD',title:'Model'});
		makeDataModelPlan(responseData.dataList,{startDt:'START_DATE',endDt:'END_DATE',targetCol:'TAT',title:'Actual'});
	}
	
	function makeDataModelPlan(dataList,obj){			
		if(dataList.length == 0)
			return;
		//1. table rows
		//var keyArray = ['PJT_PHASE_ID','PHASE_NAME',obj.startDt,obj.endDt,'PHASE_ORDER'];
		var keyArray = ['PJT_PHASE_ID','PHASE_NAME'];
		var all_tat = 0;
		var modelList = groupbyAvg(dataList,keyArray,obj.targetCol);
		var mindt = minValue(dataList, obj.startDt);
		var maxdt = minValue(dataList, obj.startDt);
		$.each(modelList,function(index,d){
			if(index == 0)
				d[obj.startDt] = mindt;
			if(index>0){
				d[obj.startDt] = dateAdd(modelList[index-1][obj.endDt],1);
			}
			var tat = Math.round(d[obj.targetCol]/d.count);
			if(isNaN(tat))
				tat = 0;
			
			//d[obj.startDt+'ORIGIN'] = d[obj.startDt];
			d[obj.endDt] = dateAdd(d[obj.startDt],tat);
			d.TAT = tat;
			
			
			all_tat += tat;
		});
		
		
		//var pjt = projectList[i];
		var tr = '<tr>';
		tr += '<td>'+ obj.title + '</td>';
		tr += '<td>'+ all_tat + ' days </td>';
		tr += '<td id="td_'+obj.title+'">'+ '' + '</td>';
		$('#table-sparkline > tbody:last-child').append(tr);
		
		// drawchart
		var groupKeys = ['PJT_PHASE_ID','PHASE_NAME',obj.startDt,obj.endDt];
		var series = getDrillDownDataSeries2(
				'',
				modelList ,
				groupKeys ,
				[],
				[{col:obj.startDt, convert:'low',datatype:'date'},{col:obj.endDt, convert:'y', datatype:'date',isnull:null}],
				'',
				'TAT',
				{cd: 'PJT_PHASE_ID', name:'PHASE_NAME'}
		);
		
		var $td = $('#'+'td_'+obj.title);
		mindt = minValue(modelList, obj.startDt);
		maxdt = maxValue(modelList, obj.endDt);
		if(obj.title=="Model"){
			mindtG = mindt;
			maxdtG = maxdt;
		}
		
		//그래프를 붙이기 위해.
		$.each(series.series,function(index,s){
			$.each(s.data,function(index1,d){
				d.yOrigin = d.y;
				d.y = convertDateToUct(dateAdd(d[obj.endDt],1));
				
			});
		});
		
		$td.highcharts('TAT', {
               series: series.series ,
               yAxis: {
               	min: convertDateToUct(mindtG),
               	max: convertDateToUct(maxdtG)
               	//tickPositions: convertDateToUct(mindtG) + 1000000
               },
               tooltip: {
                   //headerFormat: '<span style="font-size: 10px">' + $td.parent().find('td').html() + '</span><br/>',
                   headerFormat:'',
                   //pointFormat: '<b>{point.options.EST_START_DATE} - {point.options.EST_END_DATE}</b>'
                   //pointFormat: '<b>{point.options.PHASE_NAME}: {point.low:%y/%m/%e} - {point.y:%y/%m/%e}</b></br>'
                   pointFormat: '<b>{point.options.PHASE_NAME}: {point.low:%y/%m/%e} - {point.options.yOrigin:%y/%m/%e}</b></br>'
               },
               chart: {}
           });
		
	}
	
	
	
		
	</script>
	<style type="text/css">
#result {
	text-align: right;
	color: gray;
	min-height: 2em;
}

#table-sparkline {
			width: 100%;
			margin: 0 auto;
		    border-collapse: collapse;
		}
		th {
		    font-weight: bold;
		    text-align: left;
		}
		td, th {
		    padding: 5px;
		    border-bottom: 1px solid silver;
		    height: 20px;
		}
		
		thead th {
		    border-top: 2px solid gray;
		    border-bottom: 2px solid gray;
		} 
		
		/* #table-sparkline {
			width: 100%;
			table-layout: fixed;
			border-collapse: collapse;
			border-top: 2px solid #fc5d57;
			border-left: 1px solid #e1e2e6;
			border-right: 1px solid #e1e2e6;
			border-bottom: 1px solid #e1e2e6;
		}
		
		#table-sparkline th {
			color: #000;
			background: #f5f6fa;
			height: 20px;
			padding: 5px 10px;
			overflow: hidden;
			border: 1px solid #e1e2e6;
			font-weight: normal
		}
		
		#table-sparkline td {
			height: 20px;
			word-break: break-all;
			word-break: break-word;
			table-layout: fixed;
			
			padding: 5px 10px;
			border: 1px solid #e1e2e6;
			line-height: 160%;
			color: #000
		} */

	.highcharts-tooltip>span {
		background: white;
		border: 1px solid silver;
		border-radius: 3px;
		box-shadow: 1px 1px 2px #888;
		padding: 8px;
	}

	body{
			margin:0;
			overflow: hidden;
			width: 99%;
		}
</style>
</head>
<body>
<form name="form1" id="form1">
<input type="hidden" name="searchApplication" value="${param.searchApplication}"/>
<input type="hidden" name="searchStatus" value="${param.searchStatus}"/>
<div id="container" class="container">
	<table id="table-sparkline">
	<colgroup>
	
		<col width="100px">
        <col width="100px">
        <col width="">
    </colgroup>
    <thead>
    	<tr>
	    	<th>Project</th>
	    	<th>TAT</th>
	    	<th>Phase(TAT)</th>
    	</tr>
    </thead>
    <tbody id="tbody-sparkline">
    </tbody>
    </table>
</div>
</form>
</body>
<!-- <script src="js/highcharts/themes/dark-unica.js"></script> -->
<!-- <script src="js/highcharts/themes/sand-signika.js"></script> -->
<!-- <script src="js/highcharts/themes/grid-light-pms.js"></script> -->
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
