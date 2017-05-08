<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>LicenseUsageAll</title>
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
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script src="/dashboard/js/jointjs/lodash.min.js"></script>
	<script type="text/javascript">
	var dataList = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/licenseUsageJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){

		var avrGroupKeys = ['GBNM','TMONTH'];
		
		var series = [];
		// 01 avg
		var seriesavg = getDrillDownDataSeries2(
				'',
				dataList ,
				avrGroupKeys ,
				[], //filter
				[{col:'AVR',convert:'y',isnull:null}], //convert
				'TMONTH', 
				'AVR',
				{cd: 'GBNM', name:'GBNM'},
				{isGroupby:false}
		);
		
		$.each(seriesavg.series,function(i,s){
			if(s.name == 'PEAK')
				s.color = '#336688';
			
			if(s.name == 'DENIAL')
				s.color = '#616688';
			series.push(s);
		});
		
		var monthgroup = groupbyCount(dataList,['TMONTH']);
		// 02 max
		var seriesmax = {
			data : [],
			id :'Max Avail',
			name: 'Max Avail',
			type: 'line',
			color: 'green'
		};
		$.each(monthgroup,function(i,month){
			var data = dataFilter(dataList,[{col:'TMONTH',val: month.TMONTH}]);
			var max = maxValue(data,'AVAIL');
			seriesmax.data.push({y: max});
		});
		series.push(seriesmax);
		// 03 min
		var seriesmin = {
			data : [],
			id : '%Used',
			name : '%Used',
			type: 'spline',
			color: 'red'
		};
		$.each(monthgroup,function(i,month){
			var data = dataFilter(dataList,[{col:'TMONTH',val: month.TMONTH}]);
			var max = maxValue(data,'USED');
			seriesmin.data.push({y: max});
		});
		series.push(seriesmin);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		$('#container').highcharts({
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
	        	categories: seriesavg.category
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }	            
	        },
	        
	        tooltip: {
	            //valueDecimals: 0.1,
	          	//headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}, {point.point.START_TIME.time:%y/%m/%e}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y:.1f}</b><br/>',
	            shared: true,
	            enabled: true
	        },
	        //legend: legend,
	        plotOptions: {
	            series: {
	            	cursor: 'pointer' ,
	                stacking: 'notmal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.1f}',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		gotoClassName(e.point.options.TMONTH);
                		} 
	                }
	                	
	            }
	        },	
	        
	        series: series
	    },function(chart){
	    		//after draw chart
		    }
		);
		
	}
	
	
	function gotoClassName(tMonth){
		
		var newwin = window.open("", "licenseUsagePop", "width=1200,height=600,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		var oFrm = document.getElementById("form");
		
		var useMonth = tMonth;
		useMonth = useMonth.substr(0, 4) +  useMonth.substr(5,6);
		
		oFrm.useMonth.value = useMonth;
		
		oFrm.action =  '/dashboard/licenseUsagePop.html';
		oFrm.method = "post";
		oFrm.target = 'licenseUsagePop'; 
	    oFrm.submit();
		newwin.focus();
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
			height: 100%;			
		}		
	</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="project" name="project" value=""/>
<input type="hidden" id="pjt_code" name="pjt_code" value=""/>
<input type="hidden" id="pjt_name" name="pjt_name" value=""/>
<input type="hidden" id="fromUseMonth" name="fromUseMonth" value="${param.fromUseMonth}"/>
<input type="hidden" id="toUseMonth" name="toUseMonth" value="${param.toUseMonth }"/>
<input type="hidden" id="licenseNm" name="licenseNm" value="${param.licenseNm }"/>
<input type="hidden" id="siteNm" name="siteNm" value="${param.siteNm }"/>
<input type="hidden" id="useMonth" name="useMonth" value=""/>
<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
