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
			url : "/dashboard/iarLicenseUseJson.html",
			data: {fromDt:'${searchVO.fromDt}', toDt:'${searchVO.toDt}'},
			success : function(responseData){
				drawchart(responseData);
			}
		});
	}
	
	function drawchart(responseData) {
		
		var groupKeys = ['USE_DATE'];
		var series = getDrillDownDataSeries2(
				'',
				responseData.dataList , 									// 데이타원본
				groupKeys , 										// grouping, sorting 순서
				[], 												// filter
				[{col:'USE_DATE', convert:'x', datatype:'date'},{col:'USE_CNT', convert:'y', isnull:0}], 
				'', 										// x축
				'', 												// y값이 되는 컬럼, groupby시 에만 의미있음
				{cd: 'IMSI', name:'IMSI'},			// series 없으므로 가상의 Column 정의
				{isGroupby:false}
		);
		
		if($('#container').highcharts() != undefined) {
			$('#container').highcharts().destroy();
		}
		
		var maxVal = 7;
		var dataObj;
		for(var i=0; i<series.series[0].data.length; i++) {
			dataObj = series.series[0].data[i];
			if(dataObj.y >= 7) {
				dataObj.color = '#BF0B23';
			}
			
			if(dataObj.y > maxVal) {
				maxVal = dataObj.y;
			}
		}
		
		$('#container').highcharts('StockChart',{
	        chart: {
	            type: 'column'
	        },
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
	        	dateTimeLabelFormats: { 
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            }
	        },
	        yAxis: {
	        	min: 0,
	        	max: maxVal,
	        	tickInterval: 1,
	            title: {
	            	enabled: true,
	                text: '<b>Count</b>',
	                align: 'high',
	                style: {
	                    fontWeight: 'normal'
	                }
	            },
	            plotLines: [{
                    value: 6,
                    color: 'red',
                    dashStyle: 'shortdash',
                    width: 2,
                    label: {
                        text: 'Limit',
                        style: {
                            color: 'red',
                            fontWeight: 'bold'
                        }
                    }
                }],
	            visible: false,
	            opposite: false
	        },
	        legend: {
	        	enabled: false
	        },
	        plotOptions : {	        	
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

<div id="container" class="container"/>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
