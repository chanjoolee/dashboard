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
			url : "/dashboard/deliverableGeneralJson.do",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){	
		
		// 09-09. 필터링을 한 경우 목록에서 빠지는 경우가 있기 때문에 강제로 모든 PJT_DOC_STATE에 대해 cnt 가 0 인 데이타를 한줄 넣는다.
		// 1. unique 리스트를 뽑는다.
		// 1. loop >> 해당되는 한건을 가져온다. >> 모든컬럼을 copy 한다.   >> cnt 0 >> dataList push
		var stateList = groupbySum(dataList,['FUNC_NAME'],'CNT');
		$.each(stateList,function(index,val){
			var filter = dataFilter(dataList,[{col:'FUNC_NAME',val:val.FUNC_NAME}]);
			var filter1 = filter[0];
			var nilObj1 = {}; var nilObj2 = {};
			$.each(filter1,function(key,val){
				nilObj1[key] = val; nilObj2[key] = val;
			});
			nilObj1['PJT_DOC_STATE'] = 'COMPLETED'; nilObj2['PJT_DOC_STATE'] = 'APPROVED';
			nilObj1['CNT'] = null; nilObj2['CNT'] = null;
			dataList.push(nilObj1); dataList.push(nilObj2);
		});
		
		
		
		$.each(dataList,function(index,val){
			val.PJT_DOC_STATE_ORIGIN = val.PJT_DOC_STATE;
			if(val.PJT_DOC_STATE == 'COMPLETED'){
				val.PJT_DOC_STATE = 'Complete';
			}else if(val.PJT_DOC_STATE == 'APPROVED'){
				val.PJT_DOC_STATE = 'Approved';
			}else if(val.PJT_DOC_STATE == 'WAIVE'){
				val.PJT_DOC_STATE = 'Waived';
			}else if(val.PJT_DOC_STATE == 'WAITING'){
				val.PJT_DOC_STATE = 'Waiting';
			}else if(val.PJT_DOC_STATE == 'EDITING'){
				val.PJT_DOC_STATE = 'Editing';
			}
			
		});
		
		
		var funcGroupKeys = ['PJT_DOC_STATE','FUNC_NAME'];		
		var funcSeries = getDrillDownDataSeries2(
				'',
				dataList ,
				funcGroupKeys ,
				[{col:'PJT_DOC_STATE',val:['Complete','Approved']}], //filter
				[{col:'CNT',convert:'y',isnull: null}], //convert
				'FUNC_NAME', 
				'CNT',
				{cd: 'PJT_DOC_STATE', name:'PJT_DOC_STATE'}
		);
		$.each(funcSeries.series,function(index,val){
			if(['Complete','Approved'].indexOf(val.name) < 0 ){
				val.showInLegend = false;
				//val.shadow = true;
				val.visible = false;
			}
		});
		
		//작성필요건수
		var groupKeyAll =  ['PJT_ID','PJT_NAME','FUNC_NAME'];
		var allSeries = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeyAll ,
				[], //filter
				[{col:'CNT',convert:'y',isnull: null}], //convert
				'FUNC_NAME', 
				'CNT',
				{cd: 'PJT_ID', name:'PJT_NAME'}
		);
		
		$.each(allSeries.series,function(index,val){
			val.id = 'All';
			val.name = '작성필요건수';
			val.type = "line";
			val.color = phaseColor[val.name];
			//val.zoomType =  'xy';
		});	
		
		// percentage 계산.
		$.each(allSeries.series,function(index,val){
			
			$.each(val.data,function(dIndex,d){
				var point = d.y;
				var funcPointSum = 0;
				
				$.each(funcSeries.series,function(fIndex,f){
					funcPointSum += f.data[dIndex].y;
				});
				
				var percent = (funcPointSum/point) * 100;
				d.custerPercentage = percent;
			});
			
		});
		
		//series merge
		var series = [];
		$.merge(series,funcSeries.series);
		$.merge(series,allSeries.series);
		
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
	        	categories: funcSeries.category
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
	            //pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
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
	                    format:'{point.y:.0f}',
	                    color: 'black'
	                    ,verticalAlign: 'top'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//gotoRevison(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
                		} 
	                },
	                grouping : false
	                	
	            },
	            line: {
	            	//stacking: 'notmal',//'percent',
	            	dataLabels: {
	                    enabled: true,
	                    //format:'{point.y:.0f} ({point.percentage:.0f}%)',
	                    format:'{point.y:.0f}({point.custerPercentage:.0f}%)',
	                    color: 'black'
	                },
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
