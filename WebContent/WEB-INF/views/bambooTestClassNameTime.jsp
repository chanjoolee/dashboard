<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>bambooTestClassNameTime</title>
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
	var dataList = [];
	
	$(function () {
		getDataByJson();
		$('[name=chartType]').click(function() {
			drawchart();
		});
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/bambooTestClassNameTimeJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	
	function drawchart(){
	
		
		var groupKeys = ['STATUS','START_TIME','INFORM_ID'];
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull:0}], //convert
				'INFORM_ID', 
				'CNT',
				{cd: 'STATUS', name:'STATUS'},
				{	isGroupby: false
					, xSortColumn: 'START_TIME' 		
				}
		);
		
		$.each(series.series,function(index,s){
			$.each(s.data,function(index1,d){
				
				if(s.name=='FAIL'){
					var otherCnt = dataFilter(series.series[1].data,[{col:'STATUS',val:'PASS'},{col:'INFORM_ID',val:d.INFORM_ID}])[0].CNT;
					var sum =otherCnt + d.CNT;
					d.percentage = (d.CNT/sum)*100;
				}else{
					var otherCnt = dataFilter(series.series[0].data,[{col:'STATUS',val:'FAIL'},{col:'INFORM_ID',val:d.INFORM_ID}])[0].CNT;
					var sum =otherCnt + d.CNT;
					d.percentage = (d.CNT/sum)*100;
				}
				
			});
			
		});
	
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		
		if(series.series.length == 0){
			
			if(parent != window && parent.noData)
				parent.noData();
			return;
		}
		
		$('#container').highcharts('StockChart',{
	        chart: {
	            type: $('[name=chartType]:checked').val()
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'${param.project}',
            	useHTML: true
	        },
	        subtitle: {
	            text: '${param.className}'
	        },	        
	        xAxis:{
	        	//type:'category',
	        	categories: series.category ,
        		labels: {   
        			//rotation: -60 ,
        			formatter: function () {
        				var informId = series.category[this.value];
        				var startTime = dataFilter(dataList,[{col:'INFORM_ID',val:informId}])[0].START_TIME;
        				return startTime.substr(0,10);
        			}
        		} ,
	        	range: 10  //6 * 30 * 24 * 3600 * 1000 // six months
	        	
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
	            title: {
	                text: ''
	            },
	            opposite: false
	        },
	        
	        
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.point.START_TIME}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.options.percentage:.0f}%)<br/>',
	            formatter:function(tooltip) {
	            	var items = this.points || splat(this),
	    			s;

		    		// build the header
		    		//s = [tooltip.tooltipFooterHeaderFormatter(items[0])]; //#3397: abstraction to enable formatting of footer and header
					//s = Tooltip.tooltipFooterHeaderFormatter(items[0]);
		    		//s = [tooltip.tooltipFooterHeaderFormatter.prototype(items[0])];
		    		
		    		s = [myHeaderFommater.call(tooltip,items[0])];
		    		//s = [myHeaderFommater.call(tooltip,items[this.x])];
		    		
		    		// build the values
		    		s = s.concat(tooltip.bodyFormatter(items));
	
		    		// footer
		    		s.push(tooltip.tooltipFooterHeaderFormatter(items[0], true)); //#3397: abstraction to enable formatting of footer and header
	
		    		return s.join('');
            	}, 
	            shared: true,
	            enabled: true
	        },
	        legend: {
	        	enabled:false
	        },
	        plotOptions: {
	            column: {
	            	cursor: 'pointer' ,
	                stacking: 'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f} ({point.percentage:.0f}%)',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		gotoList(e.point.options.START_TIME,e.point.options.INFORM_ID);
                		} 
	                }
	                	
	            },
	            line: {
	            	cursor: 'pointer' ,
	                //stacking: 'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f} ({point.options.percentage:.0f}%)',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		gotoList(e.point.options.START_TIME,e.point.options.INFORM_ID);
                		} 
	                }
	                	
	            },
	            area:{
	            	stacking:'normal',
	            	cursor: 'pointer' ,
	            	events:{
	                	click: function(e){
	                		gotoList(e.point.options.START_TIME,e.point.options.INFORM_ID);
                		} 
	            
	            
	                }
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    	
	    }
	    	
	    	
		);
		
	}
	
	
	function gotoList(startTime,informId){
		var myWindow = window.open("", "bambooTestClassNameTimeList"+informId, "left=300, top = 200, width=1000,height=400,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		
		var oFrm = document.getElementById("form");
		oFrm.startTime.value = startTime;
		oFrm.informId.value = informId;
		oFrm.action =  '/dashboard/bambooTestClassNameTimeList.html';
		oFrm.method = "post";
		oFrm.target = 'bambooTestClassNameTimeList'+informId; 
	    oFrm.submit();
	    myWindow.focus();
	}
	
	function myHeaderFommater(point, isFooter) {
		var footOrHead = isFooter ? 'footer' : 'header',
			series = point.series,
			tooltipOptions = series.tooltipOptions,
			xDateFormat = tooltipOptions.xDateFormat,
			xAxis = series.xAxis,
			isDateTime = xAxis && xAxis.options.type === 'datetime' &&  typeof point.key === 'number',
			formatString = tooltipOptions[footOrHead+'Format'];

		// Guess the best date format based on the closest point distance (#568, #3418)
		if (isDateTime && !xDateFormat) {
			xDateFormat = this.getXDateFormat(point, tooltipOptions, xAxis);
		}

		// Insert the footer date format if any
		if (isDateTime && xDateFormat) {
			formatString = formatString.replace('{point.key}', '{point.key:' + xDateFormat + '}');
		}
		

		return format(formatString, {
			point: point,
			series: series
		});
	} 
	
	
	function format(str, ctx) {
		var splitter = '{',
			isInside = false,
			segment,
			valueAndFormat,
			path,
			i,
			len,
			ret = [],
			val,
			index;
		
		while ((index = str.indexOf(splitter)) !== -1) {
			
			segment = str.slice(0, index);
			if (isInside) { // we're on the closing bracket looking back
				
				valueAndFormat = segment.split(':');
				path = valueAndFormat.shift().split('.'); // get first and leave format
				len = path.length;
				val = ctx;

				// Assign deeper paths
				for (i = 0; i < len; i++) {
					val = val[path[i]];
				}

				// Format the replacement
				if (valueAndFormat.length) {
					//val = formatSingle(valueAndFormat.join(':'), val);
				}

				// Push the result and advance the cursor
				ret.push(val);
				
			} else {
				ret.push(segment);
				
			}
			str = str.slice(index + 1); // the rest
			isInside = !isInside; // toggle
			splitter = isInside ? '}' : '{'; // now look for next matching bracket
		}
		ret.push(str);
		return ret.join('');
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
	     
	    #div-option{
	     	margin-left: 10px;
	     	height: 30px;
			display: block;	     	
	     } 
		.container{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 95%;			
		}		
	</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="project" name="project" value="${param.project}"/>
<input type="hidden" id="startTime" name="startTime" value=""/>
<input type="hidden" id="informId" name="informId" value=""/>
<input type="hidden" id="project" name="project" value="${param.project}"/>
<input type="hidden" id="className" name="className" value="${param.className}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjt_name" name="pjt_name" value="${param.pjt_name}"/>
<div id="div-option" >
	<label><input type="radio" name="chartType" value="area" checked="checked">area</label>
	<label><input type="radio" name="chartType" value="column"  >bar </label> 
	 
</div>
<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
