<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>socDesign Chart</title>
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
			url : "/dashboard/getSummaryForChartJson.html",
			data: $("#form1").serialize(),
			//modelAttribute:"searchVO",
			success : function(responseData){
				drawChart(responseData);
			}
		});
	}
	
	function drawChart(responseData){				
		//1. table rows
		var keyArray = ['IP'];
		var dataList = responseData.dataList;
		//ip 
		var projectList = groupbySum(dataList,keyArray,'RATIO');
		
		for(var i=0 ; i < projectList.length ; i++){
			var pjt = projectList[i];
			var tr = '<tr>';
			tr += '<td title="'+pjt.IP+'" style=\'padding-left:10px;\' class=\'ipName\'>'+ pjt.IP + '</td>';
			
			
			var categories = dataFilter(dataList, [{col:'IP',val:pjt.IP}]);
			$.each(['RTL','FPGA','POST','ASIC'],function(index,ca){
				tr += '<td id="td_'+ pjt.IP + ca +'_C">'+ '' + '</td>';
				tr += '<td id="td_'+ pjt.IP + ca +'">'+ '' + '</td>';
			});
			
			//tr += '<td>'+ '' + '</td>';
			$('#table-sparkline > tbody:last-child').append(tr);
			
			// drawchart while looping categories
			/* $.each(categories,function(index,ca){
				ca.y = ca.RATIO;
				var tid = pjt.IP + ca.CATEGORY;
				var $td = $('#'+'td_'+tid.replace( /([:\.\[\],\/])/g, "\\\$1" ));
				
				$td.highcharts('SocDesign', {
	                series: [{name:ca.CATEGORY,data:[ca]}] ,
	                chart: {}
	            });
			}); */
			
			$.each(categories,function(index,ca){
				ca.y = ca.RATIO;
				var tid = 'td_' + pjt.IP + ca.CATEGORY;
				
				
				$.each($('#table-sparkline > tbody:last-child').children().children(),function(index,child){
					
					if(child.id == tid){
						var color = 'green';
						if(ca.y >= 100)
							color = 'black';
						$(child).highcharts('SocDesign', {							
			                series: [{name:ca.CATEGORY,data:[ca],color: color}] ,
			                chart: {}
			            });
					}
					
					// 왼쪽셀 원그리기
					/* if(child.id == tid + '_C'){
						var twidth = $(child).width();
						var renderer = new Highcharts.Renderer(
						    $(child)[0], twidth, 20
						);
												
						//var color = "";
						//if(ca.RATIO >= 90)
						//	color = 'green';
						//else if(ca.RATIO >= 70)
						//	color = 'yellow';
						//else if(ca.RATIO >= 50)
						//	color = 'red';
						//else
						//	color = 'black';
						
						if(ca.RATIO == 0)
							color = 'black';
						else if ( ca.RATIO <= 50)
							color = 'red';
						else if ( ca.RATIO <= 70)
							color = 'yellow';
						else if ( ca.RATIO <= 90)
							color = 'green';
						else
							color = 'green';
					
						renderer.circle(10, 10 , 7).attr({
						        fill: color , //'#FCFFC5',
						        stroke: 'black',
						        'stroke-width': 1
						    }).add();
						var tText = ca.RATIO.toFixed(1) + '%';
						renderer.text(tText,20,15).attr({
						        align: 'left'
						    })
						    .css({
						    	fontSize:'11px',
						        fontweight: 'bold',
						        textAlign: 'right'
						    }).add();
					} */
					
				});
				
				
			});
			
		}
		$(".ipName").click(function(){
			var ip = $(this).attr("title");
			goPop(ip);
		});
		$(".ipName").css("cursor","pointer");
	}
	
	function goPop(ip){
		//parent.goProject(pjt_code,pjt_name);
		var newWin1 = window.open("", "socDesignChartPop", "width=1000,height=700,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		var oFrm = document.getElementById("form1");
		oFrm.ip.value = ip;
		oFrm.action =  '/dashboard/socDesignChartPop.html';
		oFrm.method = "post";
		oFrm.target = 'socDesignChartPop'; 
	    oFrm.submit();
	    newWin1.focus();
	}
		
	</script>
	<style type="text/css">
		.container {
			width : 100%;
		}
		/* #result {
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
		}  */
		
		#table-sparkline {
			width: 100%;
			table-layout: fixed;
			border-collapse: collapse;
			/* border-top: 2px solid #fc5d57; */
			border-left: 1px solid #e1e2e6;
			border-right: 1px solid #e1e2e6;
			border-bottom: 1px solid #e1e2e6;
		}
		
		#table-sparkline th {
			color: #000;
			background: #f5f6fa;
			height: 20px;
			/* padding: 5px 10px; */
			overflow: hidden;
			border: 1px solid #e1e2e6;
			font-weight: bold;
			font-size: 12px;
		}
		
		#table-sparkline tr:hover {
		    background-color: #F0EAD0;
		}
		
		#table-sparkline td {
			height: 20px;
			word-break: break-all;
			word-break: break-word;
			table-layout: fixed;
			
			/* padding: 5px 10px; */
			padding: 0;
			border: 1px solid #e1e2e6;
			line-height: 100%;
			color: #000;
			font-size: 12px;
		} 
		
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
			width: 100%;
		}
		
	</style>
</head>
<body>
<form name="form1" id="form1">
<input type="hidden" name="pjt_code" id="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" name="pjt_name" id="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" name="ip" id="ip" value=""/>
<input type="hidden" name ="sender" value="pms"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>


<div id="container" class="container">
	<table id="table-sparkline">
	<colgroup>	
		<col width="15%">
		<%-- RTL --%>
        <col width="0%">
        <col width="22%">
        <%-- FPGA --%>
        <col width="0%">
        <col width="22%">
        <%-- POST --%>
        <col width="0%">
        <col width="22%">
        <%-- ASIC --%>
        <col width="0%">
        <col width="22%">
        <%-- <col width=""> --%>
    </colgroup>
    <thead>
    	<tr>
	    	<th rowspan="2">IP</th>
	    	<th colspan="2" rowspan="2">RTL</th>
	    	<th colspan="2" rowspan="2">FPGA</th>
	    	<th colspan="2" rowspan="2">POST Sim.</th>
	    	<th colspan="2" rowspan="2">ASIC</th>
	    	<!-- <th rowspan="1"></th> -->
    	</tr>
    	<tr>
	    	<th>Prog.</th>
	    	<th></th>
	    	<th>Prog.</th>
	    	<th></th>
	    	<th>Prog.</th>
	    	<th></th>
	    	<th>Prog.</th>
	    	<th></th>
	    	<!-- <th></th> -->
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
