<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>deliverableGeneral</title>
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
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/deliverableGeneralJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){	
		
		var phaseGroupKeys = ['PJT_DOC_STATE','PHASE_NAME'];
		$.each(dataList,function(index,val){
			val.PJT_DOC_STATE_ORIGIN = val.PJT_DOC_STATE;
			if(val.PJT_DOC_STATE == 'COMPLETED'){
				val.PJT_DOC_STATE = 'Complete';
			}else if(val.PJT_DOC_STATE == 'APPROVED'){
				val.PJT_DOC_STATE = 'Approved';
			}else if(val.PJT_DOC_STATE == 'WAIVE'){
				val.PJT_DOC_STATE = 'Waived';
			}else if(val.PJT_DOC_STATE == 'WAITING'){
				val.PJT_DOC_STATE = 'Incomplete';
			}else if(val.PJT_DOC_STATE == 'EDITING'){
				val.PJT_DOC_STATE = 'Incomplete';
			}
			
		});	
		var phaseSeries = getDrillDownDataSeries2(
				'',
				dataList ,
				phaseGroupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull: 0}], //convert
				'PHASE_NAME', 
				'CNT',
				{cd: 'PJT_DOC_STATE', name:'PJT_DOC_STATE'}
		);
		
		
		//series merge
		var series = [];
		$.merge(series,phaseSeries.series);
		
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
	        	categories: phaseSeries.category
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
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
	            shared: true,
	            enabled: true
	        },
	        //legend: legend,
	        plotOptions: {
	            column: {
	            	cursor: 'pointer' ,
	                stacking: 'notmal',//'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    //format:'{point.y:.0f} ({point.percentage:.0f}%)',
	                    formatter: function(){
	                    	if(this.point.y> 0){
	                    		return this.point.y + '(' + Highcharts.numberFormat(this.percentage,0) + '%)';
	                    	}
	                    	return null;
	                    },
	                    color: 'black',
	                    //color: '#fff',
	                    //align: ''
	                   // ,verticalAlign: 'top'
	                    inside: false
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//gotoRevison(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
                		} 
	                },
	                grouping : false
	                	
	            }
	        },	        
	        series: series
	    },function(chart){
	    		//after draw chart
		    }
		);
		
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
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjt_name" name="pjt_name" value="${param.pjt_name}"/>
<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
