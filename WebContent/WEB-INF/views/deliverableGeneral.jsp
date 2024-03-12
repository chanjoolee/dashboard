<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>deliverableProjectFunction</title>
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
	var dataListFiltered = [];
	
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
				dataListFiltered = $.merge([],dataList);
				makeConditions();
				drawchart();
			}
		});
	}
	
	function drawchart(){	
		
		var groupKeys = ['PJT_DOC_STATE','PJT_NAME','PJT_ID'];
		
		var series = getDrillDownDataSeries2(
				'',
				dataListFiltered ,
				groupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull:0}], //convert
				'PJT_NAME', 
				'CNT',
				{cd: 'PJT_DOC_STATE', name:'PJT_DOC_STATE'}
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
	        	categories: series.category,
	        	labels: {
	                rotation: 290 
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
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            //pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
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
	                    format:'{point.y:.0f} ({point.percentage:.0f}%)',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		goProject(e.point.options.PJT_ID,e.point.options.PJT_NAME);
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
	
	
	function goProject(pjt_code,pjt_name){
		if(parent != window && parent.goProject)
			parent.goProject(pjt_code,pjt_name);
		else{
			var newWin1 = window.open("about:blank", "_frm", "screenY=20, top=20, screenX=20,left=20, scrollbars=yes,resizable=yes"); 
			
			var oFrm = document.getElementById("form");
			oFrm.pjt_code.value = pjt_code;
			oFrm.pjt_name.value = pjt_name;
			oFrm.action =  '/dashboard/deliverableProjectFunction.do';
			oFrm.method = "post";
			oFrm.target = '_frm'; 
		    oFrm.submit();		
		    newWin1.focus();
		    
		    var newWin2 = window.open("about:blank", "_frm1", "screenY=20, top=20, screenY=300,left=300, scrollbars=yes,resizable=yes"); 
			oFrm.pjt_code.value = pjt_code;
			oFrm.pjt_name.value = pjt_name;
			oFrm.action =  '/dashboard/deliverableProjectPhase.do';
			oFrm.method = "post";
			oFrm.target = '_frm1'; 
		    oFrm.submit();
		    newWin2.focus();
		}
			
	}
	
	
	function makeConditions(){
		
		var phases = groupbySum(dataList,['PHASE_NAME'],'CNT');
		var functions = groupbySum(dataList,['FUNC_NAME'],'CNT');
		
		$("#conditionPhase").html('');
		$("#conditionPhase").append('<label class="m_right_20" style="display:none"><input type="hidden" class="chkSearch" name="chk_phase" value="xxxxxx" id="" /></label>');//더미값
		var id = "conditionPhaseAll";
		$("#conditionPhase").append('<label style=\"width:80px;display:inline-block;text-overflow:ellipsis;float:left;\" ><input type="checkbox" class="chkSearchAll" name="chk_phase" value="all" id="'+id+'" >All</label>');
		$("#"+id).attr("checked",true);
		$.each(phases,function(index,d){
			id = "conditionPhase" + index;
			$("#conditionPhase").append('<label style=\"width:80px;display:inline-block;text-overflow:ellipsis;float:left;\" title="'+d.PHASE_NAME+'"><input type="checkbox" class="chkSearch" name="chk_phase" value="'+d.PHASE_NAME+'" id="'+id+'" >'+d.PHASE_NAME.substr(0,9)+'</label>');
			$("#"+id).attr("checked",true);
		});
		
		$("#conditionFunction").html('');
		$("#conditionFunction").append('<label class="m_right_20" style="display:none"><input type="hidden" class="chkSearch" name="chk_func" value="xxxxxx" id=""></label>');//더미값
		id = "conditionFunctionAll";
		$("#conditionFunction").append('<label style=\"width:80px;display:inline-block;text-overflow:ellipsis;float:left;\" ><input type="checkbox" class="chkSearchAll" name="chk_func" value="all" id="'+id+'" >All</label>');
		$("#"+id).attr("checked",true);
		$.each(functions,function(index,d){
			id = "conditionFunction" + index;
			$("#conditionFunction").append('<label style=\"width:80px;display:inline-block;text-overflow:ellipsis;float:left;\" title="'+d.FUNC_NAME+'"><input type="checkbox" class="chkSearch" name="chk_func" value="'+d.FUNC_NAME+'" id="'+id+'" > '+d.FUNC_NAME.substr(0,9)+'</label>');
			$("#"+id).attr("checked",true);
		});
		
		
		$(".chkSearch").click(function() {
			filteredDrawChart('');
		});
		
		$(".chkSearchAll").click(function() {
			$(this).parent().parent().find("input").prop('checked',$(this).is(":checked"));
			filteredDrawChart('');
		});
	}
	
	function filteredDrawChart(){	
		var filters = $("#form").serializeArray();
		pSearch = [];
		$.each(filters,function(index,d){
			 if(d.name=="chk_phase"){
				pSearch.push({col:'PHASE_NAME',val:d.value});
			}else if(d.name=="chk_func"){
				pSearch.push({col:'FUNC_NAME',val:d.value});
			}		
		});
		
		dataListFiltered = dataFilter(dataList, pSearch);
		drawchart();
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
			height: 90%;			
		}		
		
		
		.con-checks-container {
					
		}
		.con-checks{
			/* width: 100%; */
			margin-left:10px;
			height: 20px;		
			display: block;	
			font-size: 10px;
			/* float:left; */
			
		}
	</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value=""/>
<input type="hidden" id="pjt_name" name="pjt_name" value=""/>
	<div id="conditionPhase" class="con-checks"></div>
	<div id="conditionFunction" class="con-checks"></div>

<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
