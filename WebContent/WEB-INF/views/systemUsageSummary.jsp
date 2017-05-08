<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
<title>IAR License</title>
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
   
<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
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
<script src="js/dashboard.js?version=1"></script>

<%-- 5. local --%>
<script src="js/pms/resourceBySite.js"></script>
<script src="js/pms/resourceByFunc.js"></script>

<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
<script type="text/javascript">

	$(function () {
		getDataByJson();
	});
	
	function getDataByJson() {	
		$.ajax({
			type: "POST",
			url : "/dashboard/systemUsageSummaryJson.html",
			data: {systemId:'${searchVO.systemId}'},
			success : function(responseData){
				drawchart(responseData);
			}
		});
	}
	
	function drawchart(responseData) {
		
		var groupKeys = ['SERIES_TYPE','USE_MONTH'];
		var series = getDrillDownDataSeries2(
				'',
				responseData.dataList , 									// 데이타원본
				groupKeys , 										// grouping, sorting 순서
				[], 												// filter
				[{col:'USE_MONTH', convert:'x', datatype:'date'},{col:'COUNT_VAL', convert:'y', isnull:0}], 
				'', 										// x축
				'', 												// y값이 되는 컬럼, groupby시 에만 의미있음
				{cd: 'SERIES_TYPE', name:'SERIES_TYPE'},			// series 
				{isGroupby:false, xSortColumn: 'ROW_SEQ'}
		);
		
		series.series[1].type = 'line';
		series.series[1].color = '#ffa500';
		
		series.series[0].yAxis = 1;
		
		if($('#container').highcharts() != undefined) {
			$('#container').highcharts().destroy();
		}
		
		//$('#container').highcharts('StockChart',{
		$('#container').highcharts({
	        chart: {
	            type: 'column',
	            zoomType: 'xy'
	        },
	        credits: {
                enabled: false
            },
            title: {
	        	text:'${searchVO.systemId}'
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	categories: series.category,
	        	type: 'datetime'
	        },
	        yAxis: [{
	        	title: {
	            	enabled: true,
	                text: 'Access Count',
	                align: 'high',
	                style: {
	                    fontWeight: 'normal'
	                }
	            },
	        	min: 0,
	            visible: false,
	            opposite: false
	        	},
	        	{
        		title: {
	            	enabled: true,
	                text: 'User Count',
	                align: 'high',
	                y: 60,
	                style: {
	                    fontWeight: 'normal'
	                }
	            },
	        	min: 0,
	            visible: false,
	            opposite: true
	        }],
	        legend: {
	        	enabled: false
	        },
	        plotOptions : {	 
	        	column: {
	            	cursor: 'pointer' ,
	            	point:{
	            		events:{
	            			click: function(e) {
	            				var point = e.point;
	            				//alert('${searchVO.systemId}' + ":" + point.USE_MONTH);
	            				openSystemUsageDetail('${searchVO.systemId}', point.USE_MONTH);
	            			}
	            		}
	            	}
	        	},
	        	line: {
	            	cursor: 'pointer' ,
	            	point:{
	            		events:{
	            			click: function(e) {
	            				var point = e.point;
	            				//alert('${searchVO.systemId}' + ":" + point.USE_MONTH);
	            				openSystemUsageDetail('${searchVO.systemId}', point.USE_MONTH);
	            			}
	            		}
	            	}
	        	},
	        	series : {
	        		dataLabels: {
	        			enabled: true,
	        			color: '#966124'
	        		}
	        	}
	        },
	        rangeSelector: {
                inputEnabled: false
            },
            tooltip: {
	        	formatter: function() {
	        		var txt = '';
	        		var points = this.points; 
	        		var key = this.key;
	        		$.each(points, function(i) {
	        			if(i == 0) {
	        				txt += "<b>Month : " + this.point.USE_MONTH.substr(0, 4) + "-" + this.point.USE_MONTH.substr(4) + "</b><br>";
	        				txt += "User Count : " + this.point.EMPLOYEE_COUNT + "<br>";
	        				txt += "Access Count : " + this.point.USE_COUNT + "<br>";
	        				txt += "Access/User : " + this.point.USE_AVERAGE;
	        			}
	        		});
	        		
	        		//alert(txt);

	        		return txt;
	        	},
	        	shared: true,
	        	enabled: true
	        },
	        series: series.series
	    },function(chart){
	    		//after draw chart
		    }
		);
	}

	function openSystemUsageDetail(systemId, useMonth) {
		var url = 'systemUsage.html?sender=confluence&systemId=' + systemId + '&useMonth=' + useMonth;
		window.open(url,'SYSTEM_USAGE','toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=yes,width=1000,height=768');
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

<div id="container" class="container"/>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
