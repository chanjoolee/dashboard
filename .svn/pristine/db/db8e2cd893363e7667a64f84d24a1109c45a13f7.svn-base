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
	<script src="js/dashboard.js?version=1"></script>
	
	<%-- 5. local --%>
	
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	
	<script type="text/javascript">
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
			url : "/dashboard/pmsTatJson.html",
			data: $("#form1").serialize(),
			//modelAttribute:"searchVO",
			success : function(responseData){
				drawChart(responseData);
			}
		});
	}
	
	function drawChart(responseData){				
		//1. table rows
		var keyArray = ['PJT_ID','PJT_NAME','APPLICATION_NAME','PJT_STATE_NAME'];
		var dataList = responseData.dataList;
		var projectList = groupbySum(dataList,keyArray,'TAT');
		
		$.each(dataList,function(index,d){
			d.TAT = Math.round(d.TAT);
		})
		
		for(var i=0 ; i < projectList.length ; i++){
			var pjt = projectList[i];
			var tr = '<tr>';
			tr += '<td title="'+pjt.APPLICATION_NAME+'">'+ pjt.PJT_NAME + '</td>';
			tr += '<td>'+ pjt.PJT_STATE_NAME + '</td>';
			tr += '<td>'+ Math.round(pjt.TAT) + ' days </td>';
			tr += '<td id="td_'+pjt.PJT_ID+'">'+ '' + '</td>';
			$('#table-sparkline > tbody:last-child').append(tr);
			
			// drawchart
			var groupKeys = ['PJT_ID','PJT_NAME','START_DATE','END_DATE','PJT_PHASE_ID','PHASE_NAME','PHASE_ORDER'];
			var series = getDrillDownDataSeries2(
					'',
					dataList ,
					groupKeys ,
					[{col:'PJT_ID',val: pjt.PJT_ID}],
					[{col:'START_DATE', convert:'low',datatype:'date'},{col:'END_DATE', convert:'y', datatype:'date',isnull:null}],
					'PJT_ID',
					'TAT',
					{cd: 'PJT_PHASE_ID', name:'PHASE_NAME'}
			);
			
			//그래프를 붙이기 위해.
			$.each(series.series,function(index,s){
				$.each(s.data,function(index1,d){
					d.yOrigin = d.y;
					d.y = convertDateToUct(dateAdd(d.END_DATE,1));
					
				});
			});
			
			var $td = $('#'+'td_'+pjt.PJT_ID);
			var mindt = minValue(dataList, 'START_DATE');
			var maxdt = maxValue(dataList, 'END_DATE');
			maxdt = dateAdd(maxdt,1);
			$td.highcharts('TAT', {
                series: series.series ,
                yAxis: {
                	min: convertDateToUct(mindt),
                	max: convertDateToUct(maxdt)
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
	
		<col width="250px">
        <col width="80px">
        <col width="100px">
        <col width="">
    </colgroup>
    <thead>
    	<tr>
	    	<th>Project</th>
	    	<th>Status</th>
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
