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
	<!-- <script src="js/highcharts/src/highcharts.src.js"></script> -->
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<script src="js/highcharts/grouped-categories.js"></script>
	
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
	Highcharts.SocDesignNew = function (options, callback) {
	    var defaultOptions = {
	        chart: {
	            renderTo: (options.chart && options.chart.renderTo) || this,
	            backgroundColor: null,
	            borderWidth: 0,
	            type: 'bar',
	            //margin: [-10, 0, -10, -10],
	            margin: [-10, 10, -10, 0],
	            //width: 600,
	            height: 22,
	            style: {
	                overflow: 'visible'
	            },
	            skipClone: true
	        },
	        exporting:{buttons:[]} ,
	        title: {
	            text: ''
	        },
	        credits: {
	            enabled: false
	        },
	        xAxis: {
	            labels: {
	                enabled: false
	            },
	            title: {
	                text: null
	            },
	            //startOnTick: false,
	            //endOnTick: false
	            tickPositions: [0]
	            ,tickLength :0
	            ,lineWidth :0
	        },
	        yAxis: {
	        	//type: 'datetime',
	            endOnTick: false,
	            startOnTick: false,
	            labels: {
	                enabled: false
	            },
	            title: {
	                text: null
	            }
	            ,tickPositions: []
	            ,tickLength :0
	            ,min:0
	            ,max: 100
	            ,tickWidth :0
	        },
	        legend: {
	            enabled: false
	        },
	        tooltip: {
	        	//enabled:false ,
	            backgroundColor: null,
	            //borderWidth: 0,
	            shadow: false,
	            useHTML: true,
	            hideDelay: 0,
	            shared: false,
	            padding: 0,
	            positioner: function (w, h, point) {
	                return { x: point.plotX - w , y: point.plotY - h};
	            } , 
	        	//headerFormat: '<span style="font-size: 10px">' + $td.parent().find('td').html() + '</span><br/>',
		        headerFormat:'',
		        //pointFormat: '<b>{point.options.EST_START_DATE} - {point.options.EST_END_DATE}</b>'
		        //pointFormat: '<b>{point.options.PHASE_NAME}: {point.low:%y/%m/%e} - {point.y:%y/%m/%e}</b></br>'
		        //pointFormat: '<b>{point.options.RATIO}({point.options.PASS}/{point.options.CASES})'
		        pointFormat: '<b>case: {point.options.CASES:.2f}, pass: {point.options.PASS:.2f}'
	           /* ,formatter: function() {
	                //console.log(this.point);
	                var point = this.point;
	                return Highcharts.dateFormat('%y/%m/%e', point.low) + ' - ' +  Highcharts.dateFormat('%y/%m/%e', point.y);
	            }*/
	        },
	        plotOptions: {
	            /*series: {
	                animation: false,
	                lineWidth: 1,
	                shadow: false,
	                states: {
	                    hover: {
	                        lineWidth: 1
	                    }
	                },
	                marker: {
	                    radius: 1,
	                    states: {
	                        hover: {
	                            radius: 2
	                        }
	                    }
	                },
	                fillOpacity: 0.25
	            },*/
	            bar: {
	            	grouping:false
	            	//,edgeWidth: 0
	            	//,groupZPadding: 0
	            	//,groupPadding: 0
	            	,dataLabels: {
	                    enabled: true,
	                    //color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'black',
	                    //color: ('white'),
	                    align: 'right',
	                    inside:true,
	                    shadow: false,
	                    useHTML:true,
	                    //format:'{point.options.RATIO}({point.options.PASS}/{point.options.CASES})'
	                    //format:'{point.options.RATIO:.1f}%',
	                   formatter:function(){
	                	   //var max = this.series.yAxis.max,
	                       //color =  this.y / max < 0.05 ? 'black' : 'white'; // 5% width
	                	   var color =  this.y > 10 ? 'white' : 'black'; // 5% width
	                	   return '<span style="color: ' + color + '">' + Highcharts.numberFormat(this.y,1) + '% </span>'; 
	                    }
	            	}
	            },
	            column: {
	                negativeColor: '#910000',
	                borderColor: 'silver'
	            }
	        }
	    };
	    options = Highcharts.merge(defaultOptions, options);

	    return new Highcharts.Chart(options, callback);
	};
	
	</script>
	
	<script type="text/javascript">
	$(document).ready(function(){
		//$("#makeitmove").draggable( {containment: "#containerPie", scroll: false} );
	});
	
	$(function () {
		//projectListByAjax();
		//drawChart();
		Highcharts.setOptions({
	        colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
	    });
		getDataByJson();
	});
		
	
	categoryInfo = [
		{
			category:'listTable',
			calculateCols:[
				{col:''}
			]
		}
	
	];
	
	
	
	function getDataByJson(){
		 
		var parameter = {};
		
		$.ajax({
			//type: "POST",
			async: true,
			url : "/dashboard/socDesignProjectJson.html",
			data: $("#form1").serialize(),
			//modelAttribute:"searchVO",
			success : function(responseData){
				drawChartTable(responseData);
				drawChartHistory(responseData);
				drawChartWaferTest(responseData);
				drawChartDiscrete(responseData);
				drawChartMCP(responseData);
			}
		});
	}
	
	function drawChartTable(responseData){				
		//1. table rows
		var keyArray = ['IP'];
		var detailList = responseData.detailList;
		
		var colgroups = [];
		colgroups.push('<col width="15%">')
		
		var head1 = groupbySum(detailList,['PARENT_CATEGORY',],'progress');
		var head2 = groupbySum(detailList,['PARENT_CATEGORY','CATEGORY'],'progress');
		//01. colgroup
		$("#table-sparkline > colgroup").append('<col width="15%">');
		for(var i=0;i<head2.length ;i++){
			$("#table-sparkline > colgroup").append('<col width="22%">');
		}
		
		//02. 첫번째 헤드
		var headTr1Str = '<tr>';
		headTr1Str += '<th rowspan="2">category</th>';
		for(var i=0;i<head1.length ;i++){
			var obj = head1[i];
			headTr1Str += '<th colspan="2" rowspan="1">'+ obj.PARENT_CATEGORY+'</th>'
		}
		headTr1Str += '</tr>';
		$("#table-sparkline > thead").append(headTr1Str);
		
		
		//03. 두번째 헤드
		var headTr2Str = '<tr>';
		for(var i=0;i<head2.length ;i++){
			var obj = head2[i];
			headTr2Str += '<th colspan="1" rowspan="1">'+ obj.CATEGORY+'</th>'
		}
		headTr2Str += '</tr>';
		$("#table-sparkline > thead").append(headTr2Str);
		
		
		//body
		var detailCagegorys = groupbySum(detailList,['DETAIL_CATEGORY'],'progress');
		for(var i=0 ; i < detailCagegorys.length ; i++){
			var dt = detailCagegorys[i];
			var tr = '<tr>';
			tr += '<td title="'+dt.DETAIL_CATEGORY+'" style=\'padding-left:10px;\' class=\'ipName\'>'+ dt.DETAIL_CATEGORY + '</td>';
			
			
			var filters =[];
			filters.push({col:'DETAIL_CATEGORY', val:dt.DETAIL_CATEGORY});
			//filters.push({col:'CATEGORY', val:dt.CATEGORY});
			//var categories = groupbySum(detailList, ['PARENT_CATEGORY','CATEGORY'],'PROGRESS');
			
			//draw td
			var categories = dataFilter(detailList, filters);
			$.each(categories,function(index,ca){
				tr += '<td id="td_'+ dt.DETAIL_CATEGORY + '_' + ca.CATEGORY + '">'+ '' + '</td>';
			});
			tr += '</tr>';
			//tr += '<td>'+ '' + '</td>';
			$('#table-sparkline > tbody:last-child').append(tr);
			
			//drawcharts in td
			$.each(categories,function(index,ca){
				ca.y = ca.PROGRESS1;
				var tid = 'td_' + dt.DETAIL_CATEGORY + '_' + ca.CATEGORY;
				$.each($('#table-sparkline > tbody:last-child').children().children(),function(index,child){
					
					if(child.id == tid){
						var color = 'green';
						if(ca.y >= 100)
							color = 'black';
						$(child).highcharts('SocDesignNew', {							
			                series: [{name:ca.CATEGORY,data:[ca],color: color}] ,
			                chart: {}
			            });
					}
					
					
				});
				
				
			});
			
		}
		$(".ipName").click(function(){
			var ip = $(this).attr("title");
			//goPop(ip);
		});
		$(".ipName").css("cursor","pointer");
	}
	
	
	function drawChartHistory(responseData){
		var filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'actual'});
		filters.push({col:'PARENT_CATEGORY',val:'-'});
		var dataList = dataFilter(responseData.historyList,filters);
		
		$.each(dataList,function(){
			this.MEASURE1 = this.MEASURE * 100;
		});
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				['CATEGORY','START_DT'] ,
				[], //filter
				[{col:'START_DT',convert:'x',datatype:'date'},{col:'MEASURE1',convert:'y',isnull:0}], //convert
				'', 
				'',
				{cd: 'CATEGORY', name:'CATEGORY'},
				{	isGroupby: false }
		);
	
		if($('#chartHistory').highcharts() != undefined) $('#chartHistory').highcharts().destroy();
		
		$('#chartHistory').highcharts('StockChart',{
	        chart: {
	            type: 'line',
	            zoomType: 'xy'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'History',
            	useHTML: false
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	type: 'datetime',
	        	categories: series.category ,
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            },        		
	        	range: 1 * 30 * 24 * 3600 * 1000 // 6 * 30 * 24 * 3600 * 1000 // six months
	        	
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	        	, opposite: false
	        },
	        rangeSelector: {
	        	enabled:false
	        },
	        navigator: {
	        	xAxis:{
	        		labels:{
	        			enabled:false
	        		}
	        	}
	        },
	        yAxis: {
	        	
	        	min: 0,
	        	max: 100,
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
	            //headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.point.START_TIME}</span><br/>',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y:.2f}%</b><br/>',
	            /* ,
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
	            line: {
	            	cursor: 'pointer' ,
	                //stacking: 'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.2f}%',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//gotoList(e.point.options.START_TIME,e.point.options.INFORM_ID);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    	
	    }
	    	
	    	
		);
	}
	
	
	function drawChartWaferTest(responseData){
		var dataList = [];
		
		//01. dataFilter
		var filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'target'});
		filters.push({col:'PARENT_CATEGORY',val:'Wafer'});
		filters.push({col:'CATEGORY',val:'Tested'});
		var targetWaferTestedList = dataFilter(responseData.historyList,filters);
		$.each(targetWaferTestedList,function(){
			this.WaferTestCategory = 'TargetWaferTested';
			dataList.push(this);
		});
		
		filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'target'});
		filters.push({col:'PARENT_CATEGORY',val:'Wafer'});
		filters.push({col:'CATEGORY',val:'Trimmed'});
		var targetWaferTrimmedList = dataFilter(responseData.historyList,filters);
		$.each(targetWaferTrimmedList,function(){
			this.WaferTestCategory = 'TargetWaferTrimmed';
			dataList.push(this);
		});
		
		filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'actual'});
		filters.push({col:'PARENT_CATEGORY',val:'Wafer Test'});
		filters.push({col:'CATEGORY',val:'Trimed Discrete'});
		var actualWaferTrimmedList = dataFilter(responseData.historyList,filters);
		$.each(actualWaferTrimmedList,function(){
			this.WaferTestCategory = 'ActualWaferTrimmedList';
			dataList.push(this);
		});
		
		filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'actual'});
		filters.push({col:'PARENT_CATEGORY',val:'Wafer Test'});
		filters.push({col:'CATEGORY',val:'Tested MCP'});
		var actualWaferTestedList = dataFilter(responseData.historyList,filters);
		$.each(actualWaferTestedList,function(){
			this.WaferTestCategory = 'ActualWaferTestedList';
			dataList.push(this);
		});
		
		//02. custorm field
		$.each(dataList,function(){
			this.MEASURE1 = this.MEASURE * 100;
		});
		
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				['WaferTestCategory','START_DT'] ,
				[], //filter
				[{col:'START_DT',convert:'x',datatype:'date'},{col:'MEASURE1',convert:'y',isnull:0}], //convert
				'', 
				'',
				{cd: 'WaferTestCategory', name:'WaferTestCategory'},
				{	isGroupby: false }
		);
	
		if($('#chartWaferTest').highcharts() != undefined) $('#chartWaferTest').highcharts().destroy();
		
		$('#chartWaferTest').highcharts('StockChart',{
	        chart: {
	            type: 'line',
	            zoomType: 'xy'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'Target vs Actual : Wafer test ',
            	useHTML: false
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	type: 'datetime',
	        	categories: series.category ,
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            },        		
	        	range: 1 * 30 * 24 * 3600 * 1000 // 6 * 30 * 24 * 3600 * 1000 // six months
	        	
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	        	, opposite: false
	        },
	        rangeSelector: {
	        	enabled:false
	        },
	        navigator: {
	        	xAxis:{
	        		labels:{
	        			enabled:false
	        		}
	        	}
	        },
	        yAxis: {
	        	
	        	min: 0,
	        	max: 100,
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
	            //headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.point.START_TIME}</span><br/>',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y:.2f}%</b><br/>',
	            /* ,
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
	            line: {
	            	cursor: 'pointer' ,
	                //stacking: 'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.2f}%',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//gotoList(e.point.options.START_TIME,e.point.options.INFORM_ID);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    	
	    }
	    	
	    	
		);
	}
	
	function drawChartDiscrete(responseData){
		var dataList = [];
		
		//01. dataFilter
		var filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'target'});
		filters.push({col:'PARENT_CATEGORY',val:'Package'});
		filters.push({col:'CATEGORY',val:'Discrete'});
		var targetDiscrete = dataFilter(responseData.historyList,filters);
		$.each(targetDiscrete,function(){
			this.DiscreteCategory = 'TargetDiscrete';
			dataList.push(this);
		});
		
		filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'actual'});
		filters.push({col:'PARENT_CATEGORY',val:'-'});
		filters.push({col:'CATEGORY',val:'Discrete'});
		var actualDiscrete = dataFilter(responseData.historyList,filters);
		$.each(actualDiscrete,function(){
			this.DiscreteCategory = 'ActualDiscrete';
			dataList.push(this);
		});
		
		
		
		//02. custorm field
		$.each(dataList,function(){
			this.MEASURE1 = this.MEASURE * 100;
		});
		
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				['DiscreteCategory','START_DT'] ,
				[], //filter
				[{col:'START_DT',convert:'x',datatype:'date'},{col:'MEASURE1',convert:'y',isnull:0}], //convert
				'', 
				'',
				{cd: 'DiscreteCategory', name:'DiscreteCategory'},
				{	isGroupby: false }
		);
	
		if($('#chartDiscrete').highcharts() != undefined) $('#chartDiscrete').highcharts().destroy();
		
		$('#chartDiscrete').highcharts('StockChart',{
	        chart: {
	            type: 'line',
	            zoomType: 'xy'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'Target vs Actual : Discrete Pkg ',
            	useHTML: false
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	type: 'datetime',
	        	categories: series.category ,
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            },        		
	        	range: 1 * 30 * 24 * 3600 * 1000 // 6 * 30 * 24 * 3600 * 1000 // six months
	        	
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	        	, opposite: false
	        },
	        rangeSelector: {
	        	enabled:false
	        },
	        navigator: {
	        	xAxis:{
	        		labels:{
	        			enabled:false
	        		}
	        	}
	        },
	        yAxis: {
	        	
	        	min: 0,
	        	max: 100,
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
	            //headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.point.START_TIME}</span><br/>',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y:.2f}%</b><br/>',
	            /* ,
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
	            line: {
	            	cursor: 'pointer' ,
	                //stacking: 'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.2f}%',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//gotoList(e.point.options.START_TIME,e.point.options.INFORM_ID);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    	
	    }
	    	
	    	
		);
	}
	
	function drawChartMCP(responseData){
		var dataList = [];
		
		//01. dataFilter
		var filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'target'});
		filters.push({col:'PARENT_CATEGORY',val:'Package'});
		filters.push({col:'CATEGORY',val:'MCP'});
		var targetMCP = dataFilter(responseData.historyList,filters);
		$.each(targetMCP,function(){
			this.MCPCategory = 'targetMCP';
			dataList.push(this);
		});
		
		filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'actual'});
		filters.push({col:'PARENT_CATEGORY',val:'MCP'});
		filters.push({col:'CATEGORY',val:'MCP S36'});
		var actualMCPS36 = dataFilter(responseData.historyList,filters);
		$.each(actualMCPS36,function(){
			this.MCPCategory = 'Actual_MCPS36';
			dataList.push(this);
		});
		
		filters = [];
		filters.push({col:'FIELD',val:'progress'});
		filters.push({col:'ACTUAL_TARGET',val:'actual'});
		filters.push({col:'PARENT_CATEGORY',val:'MCP'});
		filters.push({col:'CATEGORY',val:'MCP S48'});
		var actualMCPS48 = dataFilter(responseData.historyList,filters);
		$.each(actualMCPS48,function(){
			this.MCPCategory = 'Actual_MCPS48';
			dataList.push(this);
		});
		
		
		
		//02. custorm field
		$.each(dataList,function(){
			this.MEASURE1 = this.MEASURE * 100;
		});
		
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				['MCPCategory','START_DT'] ,
				[], //filter
				[{col:'START_DT',convert:'x',datatype:'date'},{col:'MEASURE1',convert:'y',isnull:0}], //convert
				'', 
				'',
				{cd: 'MCPCategory', name:'MCPCategory'},
				{	isGroupby: false }
		);
	
		if($('#chartMCP').highcharts() != undefined) $('#chartMCP').highcharts().destroy();
		
		$('#chartMCP').highcharts('StockChart',{
	        chart: {
	            type: 'line',
	            zoomType: 'xy'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'Target vs Actual : Discrete Pkg ',
            	useHTML: false
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	type: 'datetime',
	        	categories: series.category ,
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            },        		
	        	range: 1 * 30 * 24 * 3600 * 1000 // 6 * 30 * 24 * 3600 * 1000 // six months
	        	
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	        	, opposite: false
	        },
	        rangeSelector: {
	        	enabled:false
	        },
	        navigator: {
	        	xAxis:{
	        		labels:{
	        			enabled:false
	        		}
	        	}
	        },
	        yAxis: {
	        	
	        	min: 0,
	        	max: 100,
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
	            //headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.point.START_TIME}</span><br/>',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y:.2f}%</b><br/>',
	            /* ,
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
	            line: {
	            	cursor: 'pointer' ,
	                //stacking: 'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.2f}%',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//gotoList(e.point.options.START_TIME,e.point.options.INFORM_ID);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    	
	    }
	    	
	    	
		);
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
		.chartContainer {
			width : auto;
			height: 400px;
		    /* border: black; */
		    border-width: 1px 1px 1px 1px;
		    border-color: #c0c0c0;
		    border-style: solid;
		    margin-top: 10px;
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
    </colgroup>
    <thead>
    </thead>
    <tbody id="tbody-sparkline">
    </tbody>
    </table>
</div>
<div id="chartHistory" class="chartContainer" ></div>
<div id="chartWaferTest" class="chartContainer" ></div>
<div id="chartDiscrete" class="chartContainer"></div>
<div id="chartMCP" class="chartContainer" ></div>
</form>
</body>
<!-- <script src="js/highcharts/themes/dark-unica.js"></script> -->
<!-- <script src="js/highcharts/themes/sand-signika.js"></script> -->
<!-- <script src="js/highcharts/themes/grid-light-pms.js"></script> -->
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
