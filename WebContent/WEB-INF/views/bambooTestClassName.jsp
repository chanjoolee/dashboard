<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>bambooTestClassName</title>
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
	<!-- <script src="js/Highstock-2.1.7/js/highstock.src.js"></script> -->
	<script src="js/highcharts/modules/drilldown.src.js"></script>
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
			url : "/dashboard/bambooTestClassNameJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){
	
		
		var groupKeys = ['STATUS','CLASS_NAME'];
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull:0}], //convert
				'CLASS_NAME', 
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
	        	text:'${param.project}&nbsp;',
            	useHTML: true
	        },
	        xAxis:{
	        	categories: series.category ,
	            labels: {
	                rotation: 290 
	                //,formatter: function () {
        			//	return series.category[this.value];
        			//}
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
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.point.CLASS_NAME}, {point.point.START_TIME}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
	            shared: true,
	            enabled: true
	        },
	        legend: {
	        	enabled: false
	        },
	        plotOptions: {
	            series : {
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
	                		gotoClassTime(e.point.options.PROJECT, e.point.options.CLASS_NAME);
	                		//gotoList(e.point.options.CATEGORY);
                		} 
	                }
	                
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    	
	    	if(series.category.length > 0){
	    		var lastcategory = series.category[series.category.length-1];
		    	if(parent != window && parent.gotoClassTime){
		    		//임시주석
		    		parent.gotoClassTime('${param.project}',lastcategory);
		    	}
					
		    	
			}
	    	
		  }
		);
		
	}
	
	/**
	* 시간별 class 히스토리를 보여준다.
	*
	*/
	function gotoClassTime(project,className){
		if(parent != window && parent.gotoClassTime)
			parent.gotoClassTime(project,className);
		else{
			var oFrm = document.getElementById("form");
			oFrm.project.value = project;
			oFrm.className.value = className;
			oFrm.action =  '/dashboard/bambooTestClassNameTime.html';
			oFrm.method = "post";
			oFrm.target = '_blank'; 
		    oFrm.submit();
		}
			
	}
	
	/* function gotoList(category){
		if(parent != window && parent.gotoList)
			parent.gotoList(category);
		else{
			window.open("", "categorylistPop", "resizable=yes, scrollbars=yes, status=yes,menubar=yes");
			var oFrm = document.getElementById("form");
			oFrm.category.value = category;
			oFrm.action =  '/dashboard/regressionTestCategoryList.html';
			oFrm.method = "post";
			oFrm.target = 'categorylistPop'; 
		    oFrm.submit();
		}			
	} */
	

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
<input type="hidden" id="project" name="project" value="${param.project}"/>
<input type="hidden" id="className" name="className" value=""/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjt_name" name="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" id="revision" name="revision" value="${param.revision}"/>
<input type="hidden" id="category" name="category" value=""/>
<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
