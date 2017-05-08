<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>IssueUnresolved Type</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<script src="js/dashboard.js?version=1"></script>
	
	
	<!-- Additional files for the Highslide popup effect -->
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	
	<script type="text/javascript">
	$(document).ready(function(){
		//$("#makeitmove").draggable( {containment: "#containerPie", scroll: false} );
	});
	
	$(function () {
		var sender =  "${param.sender}";
		if(sender == 'pms'){
			//document.domain = 'hynix.com';
		}	
		
		projectListByAjax();
	});
	
	
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/projectListByJson.html",
			data: {division:'jira'},
			success : function(responseData){
				var projectList = responseData.projectList;
				var projectList = responseData.projectList;
				var paramPjtcode = "${param.pjt_code}" ;
				var selected ="";
				
				for(var i=0; i<projectList.length ; i++){
					var pjt_code = projectList[i].PJT_CODE;
					selected ="";
					if(paramPjtcode==pjt_code)
						selected = "selected";
					
					$("#sProject").append("<option value='"+ projectList[i].PJT_CODE +"' "+selected+">" + projectList[i].PJT_CODE +"</option>" );
					
				}	
				if(paramPjtcode != "")
					getDataByJson(true);
			}
		});
	}
	
	
	/**
	*@param: changeOption boolean 검색옵션변경여부
	*/
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		 $("#containerPie").html("");
		var parameter = {};
		//var parameter = {PJT_CODE: $("#sProject").val()}
		
		//var parameter = $("#form").serialize();
		parameter.PJT_CODE = $("#sProject").val();
		$.ajax({
			type: "POST",
			url : "/dashboard/issueUnresolvedJson.html",
			data: $("#form").serialize() ,
			//modelAttribute:"searchVO",
			success : function(responseData){
				responseDataG = responseData;
				drawChart(responseData);
			}
		});
	}
	
	
	
	function drawChart(responseData){				
		var dataRaw = responseData.data;
		var data = [];
		
		//subProject별로 된 데이타를 project별로 합친다. 2015-05-11.
		var dtwo = {
			PRIORITY : ""
		};
		
		for (var i = 0; i < dataRaw.length; i++) {
			if (dtwo.PRIORITY != dataRaw[i].PRIORITY) {
				if (dtwo.PJT_CODE != undefined && dtwo.UNRESOLVED != 0)
					data.push(dtwo);
				dtwo = {
					PJT_CODE : dataRaw[i].PJT_CODE,
					PRIORITY : dataRaw[i].PRIORITY,
					UNRESOLVED : dataRaw[i].UNRESOLVED
				};
			} else {
				dtwo.UNRESOLVED += dataRaw[i].UNRESOLVED;
			}
		}
		if (dtwo.UNRESOLVED != 0)
			data.push(dtwo);
		
		
		//01. prioriy xcategory
		var xcategory = [];
		var dataH = [];
		total = 0;
		for(var i=0;i<data.length;i++){
			total += data[i].UNRESOLVED;
		}
		
		for(var i=0;i<data.length;i++){
			
			xcategory.push(data[i].PRIORITY);
			
			var d = {
				y: 	data[i].UNRESOLVED,
				percentage : 	(data[i].UNRESOLVED/total)*100
			};
			//dataH.push(data[i].UNRESOLVED);
			dataH.push(d);
		}
		
		
		var title = $("#sProject").val();
		if( window != parent.window )
			title = "Issue Unresolved";
		
		$('#container').highcharts({
	        chart: {
	        	type:'bar'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: '' //title
	        },
	        subtitle: {
	            text: ''
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
	                            //getDataByJsonPie( $("#sProject").val() , this.category);
	                        	if(parent.drawChartJiraIssueByType){
	                            	parent.drawChartJiraIssueByType($("#sProject").val(),this.category);
	                            }
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
	           // pointFormat: '{series.name}:<b> {point.y} ( {point.percentage:.1f} % )</b>'
	            pointFormat: ':<b> {point.y} ( {point.percentage:.1f} % )</b>'
	        }, 
	        
	        legend: {
	        	enabled: false
	           
	        },
	        series:[{
				name:"priority",
				data:dataH
			}]
	    },function(){
	    	
	    	//
	    });		
	}	

	</script>
	<style type="text/css">
	     html,  body, form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow: hidden;
	     }
	     
		.container{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 90%;			
		}
		
	</style>
</head>
<body style="height: 100%;width: 100%">
<form name="form" id="form">
<select name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson(true)" <c:if test="${param.pjt_code != null}"> style="display:none;"   </c:if> >
	<option>PROJECT SELECT</option>
</select>
<%-- 검색조건추가 2015-09-25 --%>
<input type="hidden" name="userId" value="${param.userId}"/>
<input type="hidden" name="solution" value="${param.solution}"/>
<input type="hidden" name="url" value="issueTrends.html"/>

<div id="container" class="container">
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
