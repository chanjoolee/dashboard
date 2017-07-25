<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>codesonarProjectDetail</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<!-- Additional files for the Highslide popup effect -->
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<script src="js/dashboard.js?version=2017.05.26"></script>
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	
	<script type="text/javascript">
	$(function () {
		projectListByAjaxCsv();
		//getDataByJson();
	});	
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		 
		var parameter = {};
		parameter.PJT_CODE = $("#sProject").val();		
		parameter.url = getUrlByPjtcode(parameter.PJT_CODE,"url");
		parameter.server = getUrlByPjtcode(parameter.PJT_CODE,"server");
		parameter.server = getUrlByPjtcode(parameter.PJT_CODE,"server");
		parameter.project = getUrlByPjtcode(parameter.PJT_CODE,"project");
		
		$.ajax({
			//type: "POST",
			async: true,
			url : "/dashboard/codesonarProjectDetailJson.html",
			data: parameter,
			//modelAttribute:"searchVO",
			success : function(responseData){
				if(responseData.data != undefined){
					var jsondata = $.csv2Dictionary(responseData.data);				
					responseDataG = jsondata;
					drawChart($("#sPriority").val());
				}
				
			}
		});
	}
	
	
	
	
	function drawChart(priority){				
		var data = responseDataG;	
		
		
		//01. prioriy xcategory
		var xcategory = [];
		var dataA = [];
		
		if(priority != ''){
			dataA = $.grep(data,function(d){			
				if(d.priority == priority)
					return d;
			});
		}else{
			dataA = responseDataG;
		}
		
		var dataB = groupby(dataA, 'class');
		var dataH = [];
		total = 0;
		for(var i=0;i<dataB.length;i++){
			total += dataB[i][1];
		}
		
		dataB.sort(function(a, b){
			return b[1] - a[1];
		});
		
		for(var i=0;i<dataB.length;i++){
			
			xcategory.push(dataB[i][0]);
			
			var d = {
				y: 	dataB[i][1],
				percentage : 	(dataB[i][1]/total)*100
			};
			dataH.push(d);
		}
		
		
		//context menu
		var defaultExporting = Highcharts.getOptions().exporting;
		var myExporting = $.grep(defaultExporting.buttons.contextButton.menuItems,function(menu){
			//if(menu.text == "All Class")
				return menu;
		});
		
		/* myExporting.push(
			{
				separator: true
			},{
				text: 'All Class',
				onclick: function () {
					drawChart('');
				}
			}
		); */
		
		var linkUrl = getCodesonarPriorityCsvLink($("#sProject").val(),priority);
		
		$('#container').highcharts({
	        chart: {
	        	type:'bar',
	        	zoomType: 'x'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: linkUrl ,
	            useHTML:true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons:{
	        		contextButton:{
	        			menuItems: myExporting
	        		}
	        	}
	        },
	        xAxis: {
	        	categories: xcategory,
	            title: {
	                text: null
	            }
	        },
	        yAxis: {
	            title: {
	                text: ''
	            },
	            labels:{
	            	overflow: 'justify'
	            },
	            tickInterval: null,
	            min:0
	            
	        },
	        plotOptions: {
	            series: {
	                cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function () {
	                            //alert('Category: ' + this.category + ', value: ' + this.y);
	                            //getDataByJsonPie( $("#sProject").val() , this.category)
	                        	htmlExpandClass($("#sProject").val(),this.category);
	                        }
	                    }
	                }
	            },
	            bar:{
	            	dataLabels:{
	            		enabled: true ,
	            		format: '<b> {point.y} ( {point.percentage:.1f} % )</b>'
	            	}
	            }
	        },
	        tooltip: {
	            valueSuffix: ''  ,
	            pointFormat: '{series.name}:<b> {point.y} ( {point.percentage:.1f} % )</b>'
	        }, 
	        
	        legend: {
	        	enabled: false
	           
	        },
	        series:[{
				name:"class",
				data:dataH
			}]
	    },function(){
	    	//$(".div-buttonRight").css("display", "block");
	    	//getDataByJsonPie($("#sProject").val(),"");
	    });		
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
<form name="form" id="form">
<input type="hidden" id="sProject" name="sProject" value="${param.pjt_code}" onchange="getDataByJson();"/>
<input type="hidden" id="sPriority" name="sPriority" value="${param.priority}" onchange="getDataByJson();"/>
<div id="container" class="container">
</div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
