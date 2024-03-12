<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>FWQualitySummary: ${param.pjt_name}</title>
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
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. local --%>
	<script src="js/pms/resourceBySite.js"></script>
	<script src="js/pms/resourceByFunc.js"></script>
	
	<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" /> -->
	
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>

	<style>
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow:hidden;
	        line-height: 1.3em;
	        font-size:12px;
			font-family:'Malgun Gothic', arial, dotum, gulim;
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
<script type="text/javascript">

	var dataList = [];
	var pageData = {};
	
	$(function () {
		//if(parent.getDataByJson)
		//	parent.getDataByJson();
		drawSpiderChart();
	});
		
	
	function drawSpiderChart(){
		var data = parent.currentData;
		pageData = data;		
		$('#container').highcharts({

	        chart: {
	            polar: true,
	            type: 'line'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	            text: 'Basic Index('+data.MEASURE_DT.substr(0,4)+'/'+data.MEASURE_DT.substr(4,2)+'/'+data.MEASURE_DT.substr(6,2)+')',
	            style:{
	            	fontSize:'12px',
	            	fontWeight:'bold'
	            }
	           
	        },
	        exporting: {
	        	 buttons: {
               	contextButton: {
                   	enabled: false
               	}
	        	 }
	        },
	        pane: {
	            size: '80%'
	        },

	        xAxis: {
	            categories: ['Static Analysis', 'Function Parameter', 'Function LOC', 'Duplicate Code', 'Coding Rule'],
	            tickmarkPlacement: 'on',
	            lineWidth: 0
	        },

	        yAxis: {
	            gridLineInterpolation: 'polygon',
	            lineWidth: 0,
	            min: 0,
	            max: 20
	        },
	       
	        tooltip: {
	            shared: true,
	            pointFormat: '<span style="color:{series.color}"><b>{point.y:.2f}</b><br/>'
	        },

	        legend: {
	        		enabled: false,
	            align: 'right',
	            verticalAlign: 'top',
	            y: 70,
	            layout: 'vertical'
	        },
	        plotOptions: {
	        	series: {
	                shadow:false,
	                cursor: 'pointer',
	                point:{	                	
	                	events:{
	                		click: function(e){
	                			var category ="";
	                			var label = e.point.category;
	                			switch(e.point.category) {
		                		    case 'Static Analysis':
		                		    	category = 'STATIC_ANALYSIS';
		                		        break;
		                		    case 'Function Parameter':
		                		    	category = 'FUNC_PARAMETER';
		                		        break;
		                		    case 'Function Size':
		                		    	category = 'FUNCTION_SIZE';
		                		        break;
		                		    case 'Function LOC':
		                		    	category = 'FUNCTION_SIZE';
		                		        break;
		                		    case 'Duplicate Code':
		                		    	category = 'DUPLICATE';
		                		        break;
		                		    case 'Complexity':
		                		    	category = 'COMPLEXITY';
		                		        break;
		                		    case 'Coding Rule':
		                		    	category = 'CODING_RULE';
		                		        break;
		                		    default:
		                		}
	                			popFWQProjectCategoryTrend.call(pageData,category,label);
	                			
	                		}
	                	}
	                }
	            }
	        },
	        series: [{
	            name: '',
	            data: [data.STATIC_ANALYSIS, data.FUNC_PARAMETER  , data.FUNCTION_SIZE, data.DUPLICATE , data.CODING_RULE],
	            //data: [0,0,0,0,0],
	            pointPlacement: 'on',
	            type:'area',
	            color: '#FF7122'
	        }]

	    });
	}
	
	
	function popFWQProjectCategoryTrend(category,label){
		//var newWin1 = window.open("FWQualityProjectCategoryTrend", "FWQualityProjectCategoryTrend", "width=750,height=600, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes"); 
		var newWin1 = window.open("", "FWQualityProjectCategoryTrend", "width=750,height=600, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		
		var oFrm = document.getElementById("form1");
		oFrm.pjt_code.value = this.PJT_CODE;
		oFrm.pjt_name.value = this.PJT_NAME;
		oFrm.project.value = this.PROJECT;
		oFrm.category.value = category;
		oFrm.categoryLabel.value = label;
		oFrm.action =  '/dashboard/fwqProjectCategoryTrend.do';
		oFrm.method = "post";
		oFrm.target = 'FWQualityProjectCategoryTrend'; 
	    oFrm.submit();		    
	    newWin1.focus();
	}
	
	
	
</script>
</head>
<body>
<form name="form1" id="form1" method="post" >
<input type="hidden" name="version" id="version"  value=""/>
<input type="hidden" name ="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" name="userId" value="${login_id}"/>
<input type="hidden" name="solution" value="pms"/>

<input type="hidden" name ="chartType" value="${param.chartType}"/>
<input type="hidden" name="project" id="project" value="${param.project}"/>
<input type="hidden" name="className" id="className" value=""/>
<input type="hidden" name="pjt_code" id="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" name="pjt_name" id="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" id="category" name="category" value=""/>
<input type="hidden" id="categoryLabel" name="categoryLabel" value=""/>

<div  id="container" class="container"></div>
</form>	
</body>
</html>