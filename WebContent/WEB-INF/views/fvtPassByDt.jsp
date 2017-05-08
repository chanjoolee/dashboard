<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>fvtPassByDt</title>
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
	
	$(function () {
		getDataByJson();
	});
	
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/fvtPassByDtJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){	
		
		var groupKeys = ['PROJECT' , 'DT'];		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter 
				[{col:'DT',convert:'x',datatype:'date'},{col:'PROGRESS',convert:'y',datatype:'int',isnull:null}], //convert
				'', 
				'',
				{cd: 'PROJECT', name:'PROJECT'},
				{isGroupby:false}
		);	
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		//project 별로 color를 통일한다.
		var colors = Highcharts.getOptions().colors;
			
		//Proceeding만 처음에 표시한다. PJT_STATE_NAME
		var seriesHigh = [];
		$.each(series.series,function(index,s){
			var colorIndex = Math.floor((index/2));
			s.color = colors[colorIndex];
			if(s.data[0].GUBUN == 'total'){
				//s.visible = true;
				s.dashStyle= 'dot';
			}
			else{
				//s.visible = false;
				s.dashStyle= 'Solid';
			}
				
		});
		
		
		$('#container').highcharts({
	        chart: {
	            type: 'spline'
	            , zoomType: 'xy'
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
	        	type: 'datetime',
	        	dateTimeLabelFormats: { 
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y'
	            },
	            title: {
	                text: ' '
	            },
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh,
	            labels: {
	                /* formatter: function () {
	                	return '';
	                } */
	            }
	        },
	        yAxis: {
	        	//min: min,
	        	max: 100,
	        	plotLines: [{
	                 color: 'black',
	                 width: 2,
	                 value: 0
	                 //dashStyle: 'dash'		
	            }],
	        	//minColor: "red",
	            title: {
	                text: ''
	            },   
		        labels: {
	                /* formatter: function () {
	                	return '';
	                } */
	            }
	        },
	        tooltip: {
	            shared: true ,
	            crosshairs: true ,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            }
	        },
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true, // by default
	                point:{	                	
	                	events:{
	                		click: function(e){
	                			//var pjt_id = this.options.PJT_ID;
	                			//var pjt_name = this.options.PJT_NAME;
	                			//goProject(pjt_id,pjt_name);
	                			
	                		}
	                	}
	                }
	            },
	            line: {
	                marker: {
	                	enabled: false,
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            },
	            spline: {
	            	//stacking: 'normal',
	                //lineColor: '#666666',
	                //lineWidth: 2,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: true,
	                    format: '<b> {point.x:%m/%e}</b>'
	                },
	                enableMouseTracking: true 
	                
	                
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    	
	    	
	    	
		   }
		);
		
	}
	
	// 수정된 가상의 날짜를 계산한다.
	function getSubPhaseSeqDt(pjt_id, phase_id, sub_phase_seq){
		var phaseDt = getPhaseDt(phase_id);
		var phaseDtSplit = phaseDt.split('-');
		var dataCount = dataPhaseCount;
		for(var i=0;i<dataCount.length;i++){
			if(pjt_id == dataCount[i].PJT_ID && phase_id == dataCount[i].PHASE_ID){
				var phaseCnt = dataCount[i].CNT;
				
				var phaseSeqDt = parseInt((sub_phase_seq-1) *(30/phaseCnt)+10);
				
				if(this.GUBUN == 'enddate'){
					// sigh off 는 마자막
					if(this.SUB_PHASE_NAME.indexOf("Sign off Review") >= 0 ){
						if(phaseDtSplit[1] != 2)
							phaseSeqDt = 30;
						else
							phaseSeqDt = 28;
					}
				}else{
					phaseSeqDt = 2;
				}
				
					
				
				//var phaseSeqDt = (phaseSeq) *(30/phaseCnt);
				return phaseDtSplit[0] + '' + phaseDtSplit[1] + '' + phaseSeqDt.toString().lpad('0',2);				
			}
		}
		return 'error';
	}
	
	// phase별로 데이타를 가져온다.
	function getPhaseDt(phase_id){
		
		for(var i=0;i<dataPhase.length;i++){
			if(phase_id == dataPhase[i].PHASE_ID){
				return dataPhase[i].PHASE_DT;
			}			
		}
	}
	
	
	
	function goProject(pjt_code,pjt_name){
		if(parent != window && parent.goProject){
			//parent.goProject(pjt_code,pjt_name);
			var newwin = window.open("", "pmsScheduleProject", "width=1000,height=700,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
			var oFrm = document.getElementById("form");
			oFrm.pjt_code.value = pjt_code;
			oFrm.pjt_name.value = pjt_name;
			oFrm.action =  '/dashboard/pmsScheduleProject.html';
			oFrm.method = "post";
			oFrm.target = 'pmsScheduleProject'; 
		    oFrm.submit();
		    newwin.focus();
		}
		else{
			var newwin = window.open("", "pmsScheduleProject", "width=1000,height=700,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
			var oFrm = document.getElementById("form");
			oFrm.pjt_code.value = pjt_code;
			oFrm.pjt_name.value = pjt_name;
			oFrm.action =  '/dashboard/pmsScheduleProject.html';
			oFrm.method = "post";
			oFrm.target = 'pmsScheduleProject'; 
		    oFrm.submit();
		    newwin.focus();
		}
			
	}
	
	function adjustBaseLine(obj){
		//alert("aaa");
		//03. visible project 들의 phase 유일값 리스트.
		var chart = $('#container').highcharts();
		/* var uSeries = chart.series.filter( function(s){
			if(s.name != 'BaseLine' && s.name != 'BaseLineA')
				return s.visible;
		}); */
		
		var uSeries =  $.grep(chart.series, function (item) {
			if(item.name != 'Overly Delayed')
				return item.visible;
		});
		
		var uSeriesVal = [];
		for(var i = 0; i< uSeries.length;i++){
			uSeriesVal.push(uSeries[i].name);
		}
		
		/* var baseLine = chart.series.filter( function(s){
			if(s.name == 'BaseLine')
				return true;
		}); */
		
		var baseLine = $.grep(chart.series, function(s){
			if(s.name == 'Overly Delayed')
				return true;
		});
		
		baseLine[0].data = [];
		
		//04. distinct PhaseList
		var phaseList = [];
		
		for(var i=0;i<dataList.length;i++){
			var pjt = dataList[i].PJT_NAME;
			
			/* var containPjts = uSeriesVal.filter(function(val){
				if(val == pjt)	
					return val;
			}); */
			 var containPjts = $.grep(uSeriesVal, function(val){
					if(val == pjt)	
						return val;
				});
			var phase = dataList[i].PHASE_NAME;
			if(containPjts.length>0)
				phaseList.push(phase);			
		}
		var phaseListUni = jQuery.unique(phaseList);
		
		//05. baseLine 값조정
		var baseLineData = []; 
		phaseListUni.sort();
		for (var i = 0; i < phaseListUni.length; i++){	
			/* var phases = dataPhase.filter(function(val){
				if(val.PHASE == phaseListUni[i])
					return val;
			}); */
			var phases = $.grep(dataPhase,function(val){
				if(val.PHASE_NAME == phaseListUni[i])
					return val;
			});
			var phase = {};
			if(phases.length > 0)
				phase = phases[0];
			var phaseDtSplit = phase.PHASE_DT.split('-');			
			var utcDt1 = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			var utcDt2 = {};
			
			// to
			if(i < (phaseListUni.length-1)){
				/* var phases1 = dataPhase.filter(function(val){
					if(val.PHASE == phaseListUni[i+1])
						return val;
				}); */
				var phases1 = $.grep(dataPhase , function(val){
					if(val.PHASE_NAME == phaseListUni[i+1])
						return val;
				});
				var phase1 = {};
				if(phases1.length > 0)
					phase1 = phases1[0];
				var phaseDtSplit1 = phase1.PHASE_DT.split('-');	
				utcDt2 = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
			}else{//마지막데이타					
				if(phaseDtSplit[1]=='11')
					utcDt2 = Date.UTC(phaseDtSplit[0]+1,0 , 0);
				else
					utcDt2 = Date.UTC(phaseDtSplit[0], phaseDtSplit[1] , 0 );
			}
			
			var target = 60; 
			baseLineData.push(
					{
						x: utcDt1, 
						y: target,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						}/* ,
						dataLabels: {
		                    enabled: false,
		                    color: 'red',
		                    style: {
		                        fontWeight: 'bold'
		                    }
		                } */
					},
					{
						x: utcDt2, 
						y:target,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false
		                }
					}
			);
			
			
			//baseLineData.push([utcDt1, (phaseListUni.length-i)*80]);
			//baseLineData.push([utcDt2, (phaseListUni.length-i)*80]);
			
		}
		//baseLineData.sort();
		//baseLine[0].data = baseLineData;
		//baseLine[0].setData(baseLineData);
		baseLine[0].update({
			data: baseLineData
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
<input type="hidden" id="pjt_code" name="pjt_code" value=""/>
<input type="hidden" id="pjt_name" name="pjt_name" value=""/>

<div id="container" class="container"></div>
<c:forEach items="${paramValues.pjtCodeList}" var="pjtCode" varStatus="status">
	<input type="hidden" name="pjtCodeList" value="${pjtCode}"/>
</c:forEach>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
