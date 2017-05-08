<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>bambooTestProject</title>
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
	<script type="text/javascript">
	var dataList = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/bambooTestProjectJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){
	
		
		var groupKeys = ['STATUS','PROJECT'];
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull:0}], //convert
				'PROJECT', 
				'CNT',
				{cd: 'STATUS', name:'STATUS'},
				{isGroupby:false}
		);
		
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
	        	categories: series.category
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }	            
	        },
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}, {point.point.START_TIME.time:%y/%m/%e}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
	            shared: true,
	            enabled: true
	        },
	        //legend: legend,
	        plotOptions: {
	            series: {
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
	                		gotoClassName(e.point.options.PROJECT);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		//after draw chart
		    }
		);
		
	}
	
	
	function gotoClassName(project){
		var newwin = window.open("", "bambooTestProjectPop", "width=1000,height=800,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		var oFrm = document.getElementById("form");
		//oFrm.menuAuthId.value = "MNU20150422131320740";
		oFrm.project.value = project;
		oFrm.action =  '/dashboard/bambooTestProjectPop.html';
		oFrm.method = "post";
		oFrm.target = 'bambooTestProjectPop'; 
	    oFrm.submit();
		newwin.focus();
	}
	
	function gotoClassNamePms(project){
		var newwin = window.open("", "popRetrieveBambooTest", "width=1000,height=800,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		var oFrm = document.getElementById("form");
		//oFrm.menuAuthId.value = "MNU20150422131320740";
		oFrm.project.value = project;
		oFrm.action =  '/nspim/dash/popRetrieveBambooTest.do';
		oFrm.method = "post";
		oFrm.target = 'popRetrieveBambooTest'; 
	    oFrm.submit();
	    newwin.focus();
			
	}
	
	function gotoClassNameBack(project){
		if(parent != window && parent.gotoClassName)
			parent.gotoClassName(project);
		else{
			var oFrm = document.getElementById("form");
			oFrm.project.value = project;
			oFrm.action =  '/dashboard/bambooTestClassName.html';
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
<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
