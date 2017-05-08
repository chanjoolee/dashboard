<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>fwqProjectSummaryAdvanced</title>
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
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	
	
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
	var pageData = {};
	
	$(function () {
		drawchart(parent.currentData);
	});
		
	
	function drawchart(data){	
		pageData = data;
		$('#container').highcharts({
	        chart: {
	            type: 'column'
	            //,zoomType: 'xy'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text: 'Advanced Index('+data.MEASURE_DT.substr(0,4)+'/'+data.MEASURE_DT.substr(4,2)+'/'+data.MEASURE_DT.substr(6,2)+')',
	            style:{
	            	fontSize:'12px',
	            	fontWeight:'bold'
	            }
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	categories: ['Architecture','Complexity','Simulator Test Coverage']
	        },
	        yAxis: {
	        	min: 0,
	        	max: 25,
	        	tickInterval:5,
	            title: {
	                text: ''
	            }	            
	        },
	        legend: {
	        	enabled:false
	        },
	        tooltip: {
	            valueDecimals: 0,
	          	//headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            pointFormat: 'point: <b>{point.y:.2f}</b><br/>',
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
	            column: {
	            	cursor: 'pointer' ,
	                //stacking: 'normal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.2f}',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		var category ="";
                			var label = e.point.category;
                			switch(e.point.category) {
	                		    case 'Architecture':
	                		    	category = 'ARCHITECTURE';
	                		        break;
	                		    case 'Complexity':
	                		    	category = 'COMPLEXITY';
	                		        break;
	                		    case 'Code Coverage':
	                		    	category = 'CODE_COVERAGE';
	                		        break;
	                		        
	                		    case 'Simulator Test Coverage':
	                		    	category = 'CODE_COVERAGE';
	                		        break;
	                		    
	                		    default:
	                		}
                			popFWQProjectCategoryTrend.call(pageData,category,label);
                		} 
	                }
	                	
	            }
	        },	        
	        series: [{
	        	name:'',
	        	color: 'rgba(255,69,0,0.7)',
	        	//lineWidth: 4,
	        	data:[data.ARCHITECTURE,data.COMPLEXITY, data.CODE_COVERAGE]
	        }]
	    },function(chart){
	    		//after draw chart
		    }
		);
		
	}
	
	function popFWQProjectCategoryTrend(category,label){
		//var newWin1 = window.open("FWQualityProjectCategoryTrend", "FWQualityProjectCategoryTrend", "width=750,height=600, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		var newWin1 = window.open("", "FWQualityProjectCategoryTrend", "width=750,height=600, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		
		var oFrm = document.getElementById("form");
		oFrm.pjt_code.value = this.PJT_CODE;
		oFrm.pjt_name.value = this.PJT_NAME;
		oFrm.project.value = this.PROJECT;
		oFrm.category.value = category;
		oFrm.categoryLabel.value = label;
		oFrm.action =  '/dashboard/fwqProjectCategoryTrend.html';
		oFrm.method = "post";
		oFrm.target = 'FWQualityProjectCategoryTrend'; 
	    oFrm.submit();		
	    newWin1.focus();
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
			height: 95%;			
		}		
		
		.div-application{
			width: 100%;
			margin-left:10px;
			height: 20px;		
			display: block;	
			font-size: 12px;
			
			overflow: hidden;
		}
	</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjt_name" name="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" id="project" name="project" value=""/>
<input type="hidden" id="category" name="category" value=""/>
<input type="hidden" id="categoryLabel" name="categoryLabel" value=""/>

<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
