<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>FWQuality Trend</title>
    <script src="js/jquery/jquery-1.11.2.js"></script>
	<script type="text/javascript">
	var fwqDataList = [];
	var scheduleDataList = [];
	var scheduleSeries = {};
	
	
	$(function () {
		getDataByJson();
		$( window ).resize(function() {
			//adjustColor();
		});
	});
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/fwqProjectCategoryTendJson.html",
			data: $("#form").serialize(),
			success : function(responseData){
				fwqDataList = responseData.fwqDataList;
				scheduleDataList = responseData.scheduleDataList;
				drawChart();
			}
		});
	}
	
	function drawChart(){		
		var groupKeys = ['GUBUN','MEASURE_DT'];
		
		var series = getDrillDownDataSeries2(
				'',
				fwqDataList ,
				groupKeys ,
				[], //filter
				[{col:'${param.category}',convert:'y',isnull:0},{col:'MEASURE_DT',convert:'x',datatype:'date'}], //convert
				'', 
				'${param.category}',
				{cd: 'GUBUN', name:'GUBUN'},
				{	isGroupby: false
					//, xSortColumn: 'MEASURE_DT' 		
				}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		var ymax = 100;
		var ytickInterval = 25;
		
		switch($('#category').val()) {
		    case 'POINT':
		    	ymax = 100;
		    	ytickInterval = 25;
		        break;
		    case 'MEASURE':
		    	ymax = 125;
		    	ytickInterval = 25;
		        break;
		    case 'STATIC_ANALYSIS':
		    case 'FUNCTION_SIZE':
		    case 'DUPLICATE':
		    case 'COMPLEXITY':
		    case 'CODING_RULE':
		    	ymax = 20;
		    	ytickInterval = 5;
		    	break;
		    default:
		    	ymax = 25;
		    	ytickInterval = 5;
		}
		
		$('#container').highcharts('StockChart',{
	        chart: {
	            type: 'line'
	        },	        
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'${param.categoryLabel} Trend',
            	useHTML: true
	        },
	        exporting: {
	        	 buttons: {
                	contextButton: {
                    	enabled: false
                	}
	        	 }
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	type:'datetime',
	        	//categories: series.category ,
	        	labels:{
	        		enabled:false
	        	},
	        	tickLength: 0,
        		dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            } ,
        		range: 6 * 30 * 24 * 3600 * 1000 ,// six months
        		tickInterval: 30 * 24 * 3600 * 1000 // one months
	        	
	        },
	        rangeSelector: {
	        	//enabled:false
	        },
	        navigator: {
	        	//enabled:false,
	        	xAxis:{
	        		labels:{
	        			enabled:false
	        		}
	        	}
	        },
	        
	        yAxis: {
	        	
	        	min: 0,
	        	max: ymax,
	        	showLastLabel: true,
	        	tickInterval: ytickInterval,
	        	//endOnTick: true,
	            title: {
	                text: ''
	            },
	            opposite: false
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
	            valueSuffix: '' ,
	            pointFormat:'<span style="color:{series.color}"><b>{point.y}</b><br/>'/* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        legend: {
	        	enabled:false
	        },
	        plotOptions: {
	            line: {
	            	cursor: 'pointer' ,
	                stacking: 'normal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                lineWidth:3,
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y}',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){	                		
	                		//spiderChartIframe.drawSpiderChart(e.point.options);
                		} 
	                }
	                	
	            }
	           
	        },	        
	        series: series.series
	    },function(chart){
	    
	    	}
		);
		
	}
	
	
	
	</script>
	<style type="text/css">
		.wrap_a{width:100%; overflow:hidden}
		.wrap_b{width:100%; overflow:hidden}
		.wrap_b_1{width:49%; height:auto ;overflow:hidden; float:left; margin-top:30px}
		.wrap_b_2{width:49%; height:auto ;overflow:hidden; float:right; margin-top:30px}
		
		<%--.box_gray{background:#f5f6fa; border:1px solid #e1e2e6; padding:15px; text-align:center; margin-bottom:8px } --%>
		.dashboard_box{/* border:1px solid #e1e2e6;  */}
		.cont_tit {float:none}
		iframe {
			   border: none;
			   frameborder:0;
			   
			   width: 100%;
			   height: 100%;
		}
		
		.container{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 90%;			
		}		
		
	</style>
</head>
<body>
<form name="form" id="form">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjt_name" name="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" id="category" name="category" value="${param.category}"/>
<input type="hidden" id="categoryLabel" name="categoryLabel" value="${param.categoryLabel}"/>
<div class="pop_window">
	<div class="pop_tit_wrap">
		<span class="baseline"></span>
		<h2 class="pop_tit">${param.pjt_name}</h2>
	</div>
	<div  id="container" class="container"></div>
</div>
</form>
</body>
</html>
