<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>socDesinTestCaseChart</title>
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
	var dataList = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/socDesignChartPopJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){
		var groupKeys = ['CATEGORY','PROJECT'];
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'CASES',convert:'y',isnull:0}], //convert
				'PROJECT', 
				'CASES',
				{cd: 'CATEGORY', name:'CATEGORY'},
				{isGroupby:false}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		
		$('#container').highcharts({
	        chart: {
	            type: 'bar',
	            zoomType: 'xy'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'&nbsp;${param.ip}',
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	categories: series.category ,
	        	title: 'Project'
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }	            
	        },
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:{series.color}">{series.name}: </span><b>cases({point.y}), pass({point.options.PASS}), ratio({point.options.RATIO:.1f}%)</b><br/>',
	            shared: true,
	            enabled: true/* ,
	            formatter: function () {
	                var s = '<b>' + this.x + '</b>';

	                $.each(this.points, function () {
	                	if(this.y > 0){
	                		s += '<br/>' + '<span style="color:' + this.series.color + '">' +this.series.name + '</span>: ' + this.y + '';
	                	}
	                    
	                });

	                return s;
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	            bar: {
	            	cursor: 'pointer' ,
	                stacking: 'normal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f}',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	//click: function(e){
	                	//	gotoRevison(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
                		//} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		//after draw chart
		    }
		);
		
	}
	
	
	function gotoRevison(pjt_code,pjt_name){
		if(parent != window && parent.gotoRevison)
			parent.gotoRevison(pjt_code,pjt_name);
		else{
			var oFrm = document.getElementById("form");
			oFrm.pjt_code.value = pjt_code;
			oFrm.pjt_name.value = pjt_name;
			oFrm.action =  '/dashboard/regressionTestRevision.html';
			oFrm.method = "post";
			oFrm.target = '_blank'; 
		    oFrm.submit();
		}
			
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
<input type="hidden" id="pjt_code" name="pjt_code" value=""/>
<input type="hidden" id="pjt_name" name="pjt_name" value=""/>
<input type="hidden" name="ip" id="ip" value="${param.ip}"/>
<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
