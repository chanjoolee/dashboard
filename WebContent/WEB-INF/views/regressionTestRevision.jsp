<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>regressionTestRevision</title>
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
	<script src="js/pms/resourceBySite.js"></script>
	<script src="js/pms/resourceByFunc.js"></script>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	var dataList = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/regressionTestRevisionJson.do",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){
	
		
		var groupKeys = ['FINAL_RESULT','START_DATE','REVISION'];
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull:0}], //convert
				'REVISION', 
				'CNT',
				{cd: 'FINAL_RESULT', name:'FINAL_RESULT'},
				{isGroupby: false}
		);
		
		//category 를 날자순으로 다시 조정
		series.category.sort(function(a,b){
			var dt1 = dataFilter(dataList,[{col:'REVISION',val:a}])[0].START_DATE;
			var dt2 = dataFilter(dataList,[{col:'REVISION',val:b}])[0].START_DATE;
			
			if(dt1 > dt2)
				return 1;
			else if(dt1 < dt2){
				return -1;
			}else if(dt1 == dt2){
				return a > b ? 1:-1;
			}			
		});
		
	
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		
		if(series.series.length == 0){
			
			if(parent != window && parent.noData)
				parent.noData();
			return;
		}
		
		$('#container').highcharts('StockChart',{
	        chart: {
	            type: 'column'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'${param.pjt_name}',
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	//type:'category',
	        	categories: series.category ,
        		labels: {   
        			formatter: function () {
        				return series.category[this.value];
        			}
        		} ,
	        	range: 5 //6 * 30 * 24 * 3600 * 1000 // six months
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
	            }	            
	        },
	        
	        
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.point.REVISION}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
	            formatter:function(tooltip) {
	            	var items = this.points || splat(this),
	    			s;

		    		// build the header
		    		//s = [tooltip.tooltipFooterHeaderFormatter(items[0])]; //#3397: abstraction to enable formatting of footer and header
					//s = Tooltip.tooltipFooterHeaderFormatter(items[0]);
		    		//s = [tooltip.tooltipFooterHeaderFormatter.prototype(items[0])];
		    		
		    		s = [myHeaderFommater.call(tooltip,items[0])];
		    		
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
	        	enabled:true
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
	                		gotoCategory(e.point.options.REVISION);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    	
	    	
	    	if(series.category.length > 0){
	    		var lastcategory = series.category[series.category.length-1];
		    	if(parent != window && parent.gotoCategory)
					parent.gotoCategory(lastcategory);
		    	
			    }
	    	}
	    	
		);
		
	}
	
	
	function gotoCategory(revision){
		if(parent != window && parent.gotoCategory)
			parent.gotoCategory(revision);
		else{
			var oFrm = document.getElementById("form");
			oFrm.revision.value = revision;
			oFrm.action =  '/dashboard/regressionTestCategory.do';
			oFrm.method = "post";
			oFrm.target = '_blank'; 
		    oFrm.submit();
		}
			
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
					val = formatSingle(valueAndFormat.join(':'), val);
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
<body>
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjt_name" name="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" id="revision" name="revision" value=""/>
<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
