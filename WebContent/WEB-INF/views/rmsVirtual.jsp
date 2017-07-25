<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>RMS Chart</title>
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
    
	<!-- <script src="js/highcharts/src/highcharts.src.js"></script> -->
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
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
	
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	
	$(function () {
		getDataByJson();
	});
	
	var dataList = [];
	
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/rmsVirtualJson.html",
			data: $("#form").serialize(),
			//data: $("#form").serialize(),
			success : function(responseData){
				dataList = responseData.dataList;
				drawChart();
			}
		});
	}
	
	
	function drawChart(resonseData){		
		var categoryColor = {
			'Req. Count':'#55BCE2', // blue
			Implementation:'#B9432B', //red
			Implemented:'#B9432B', //red
			'Test Coverage':'#CCCCCC', //grey
			Verification:'#E7B80D', //orange
			Verified:'#E7B80D' //orange
		};
		var seriesOrder = {
				'Req. Count':0,
				Implementation:1,
				Implemented:1,
				'Test Coverage':2,
				Verification:3,
				Verified:3
		};
		var groupKeys = ['PJT_ID','CATEGORY','MEASURE_DT'];
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'MEASURE_DT', convert:'x',datatype:'date'},{col:'NUMERATOR', convert:'y', isnull:0}],
				'', 
				'CNT',
				{cd: 'CATEGORY', name:'CATEGORY'},
				{isGroupby: false}
		);
		
		$.each(series.series,function(){
			if(categoryColor[this.name] != undefined){
				this.color = categoryColor[this.name];
			}	
			if(seriesOrder[this.name] != undefined){
				this.order = seriesOrder[this.name];
			}	
		});
		sortObjects(series.series,['order']);
		
		$('#container').highcharts('StockChart',{
	        chart: {
	            type: 'line'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text:  'Developement Progress'	            
	        },
	        subtitle: {
	            text: dataList[0].PJT_NAME,
	            style: {
	            	color: 'blue',
	            	fontWeight: 'bold'
	            }
	        },
	        exporting:{
	        	 buttons:{
	        		contextButton:{
	        			endabled: false
	        		}
	        	} 
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%y/%m/%d',
	        		day: '%y/%m/%d',
	        		month: '%y/%m/%d',
	        		year: '%y/%m/%d'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	           // plotLines: plotLinesHigh
	           /* ,labels: {
	                formatter: function () {
	                	var dt = new Date(this.value);
	                	return (dt.getMonth()+1) + '.' + dt.getDate();
	                    
	                }
	            } */
	            , range: 3 * 30 * 24 * 3600 * 1000 // six months
	            //, tickInterval: 30 * 24 * 3600 * 1000 // one months
	            //, max: maxDtUtc
	            //, maxPadding: 2
	        },
	        yAxis: {
	            title: {
	                text: 'Progress'
	            }
	        	, opposite: false
	        	//, max: 100
	        	//, min: 0
	        	, showLastLabel: true
	            
	        },
	        tooltip: {
	        	endabled:true,
	            shared: true ,
	            crosshairs: true,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%d',
	        		day: '%y/%m/%d',
	        		month: '%y/%m/%d',
	        		year: '%y/%m/%d'
	            },
	            valueSuffix: '' /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        legend: {
	        	enabled:true
	        },
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true ,// by default
	                point:{
	                	events:{
	                		/* click: function(e){
	                			
	                		} */
	                	}
	                }
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: true,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: true
	            }
	        },
	        series: series.series
	    },function(chart){
    		
    		
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
	        overflow: hidden;
	      }
		
		.dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 100%;			
		}
		
	</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" name="version" value="${param.version}"/>
<input type="hidden" name="legendFloat" id="legendFloat" value="false"/>
<input type="hidden" name="pjt_code" id="pjt_code" value="${param.pjt_code}"/>
<div id="container" class="dashboard-div"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
