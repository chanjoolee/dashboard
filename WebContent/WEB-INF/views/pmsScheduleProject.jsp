<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>pmsSchedule</title>
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
	
	var dataPhase = [];
	var dataPhaseCount = [];
	var dataList = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/pmsScheduleProjectJson.do",
			data: $("#form").serialize() ,
			success : function(responseData){
				
				dataPhase = responseData.dataPhase;
				dataPhaseCount = responseData.dataPhaseCount;
				dataList = responseData.dataList;
				
				// 최종버전이 아니고 실적일이 없으면 최종버젼의 실적일을 적용한다.
				var maxRevision = maxValue(dataList,'REVISION');
				var maxList = dataFilter(dataList,[{col:'REVISION',val:maxRevision}]);
				for(var i=0;i<dataList.length;i++){
					var data = dataList[i];
					data.subPhaseSeqDt = getSubPhaseSeqDt.call(data, data.PJT_ID,data.REVISION, data.PHASE_ID,data.SUB_PHASE_SEQ);
					
					if(data.REVISION != maxRevision && $.trim(data.ACTUAL_DT) == '' ){
						var maxActualDt = "";
						$.each(maxList,function(index,m){
							if(m.PHASE_NAME == data.PHASE_NAME && m.SUB_PHASE_NAME == data.SUB_PHASE_NAME && $.trim(m.ACTUAL_DT) != ''){
								data.ACTUAL_DT = m.ACTUAL_DT;
								data.DELAY_DT_ORIGIN = data.DELAY_DT;
								data.DELAY_DT = getDateDiff(data.ACTUAL_DT,data.PLAN_DT);
								data.DELAY_DT_C_ORIGIN = data.DELAY_DT_C;
								data.DELAY_DT_C = "";
							}
						});
					}
				}
				
				//DELAY_DT_SUM
				var preRevision = '';
				for (var i = 0; i < dataList.length; i++){
					var data = dataList[i];
					if(preRevision != dataList[i].REVISION){
						data.DELAY_DT_SUM = 0;
						data.DELAY_DT_SUM += data.DELAY_DT;
						preRevision = dataList[i].REVISION;
					}else{
						data.DELAY_DT_SUM = dataList[i-1].DELAY_DT_SUM;
						data.DELAY_DT_SUM += data.DELAY_DT;
					}			
		        }
				
				drawchart();
			}
		});
	}
	
	function drawchart(){	
		
		var groupKeys = ['PJT_ID', 'PJT_NAME','REVISION', 'PHASE_ID', 'PHASE_NAME', 'SUB_PHASE_ID', 'SUB_PHASE_NAME','PJT_STATE_NAME', 'SUB_PHASE_SEQ','subPhaseSeqDt','PLAN_DT', 'ACTUAL_DT', 'DELAY_DT'];		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'subPhaseSeqDt',convert:'x',datatype:'date'},{col:'DELAY_DT',convert:'y',datatype:'int',isnull:null}], //convert
				'', 
				'CNT',
				{cd: 'REVISION', name:'REVISION'},
				{isGroupby:false}
		);		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		// max		
		var max = maxValue(dataList,'DELAY_DT');
		var min = minValue(dataList,'DELAY_DT');
		
		if(max >= 0 && min >= 0 ){
			//min = max * -1;
			min = -100;
		}else if(max >=0 && min < 0 ){
			if(Math.abs(max) >= Math.abs(min)){
				//min = max * -1;
				min = Math.min(min,-150);
			}
			else
				max = min * -1;				
		}
			
		//Proceeding만 처음에 표시한다. PJT_STATE_NAME
		var seriesHigh = [];
		$.each(series.series,function(index,s){
			//s.name += '(' + s.data[0].PJT_STATE_NAME  + ')';
			s.events ={
				hide: function(){
					adjustBaseLine(this);
				},
				show: function(){
					//color조정
					if(this.color.charAt(0)=='#' && this.options.success){
						var R = hexToR(this.color);
						var G = hexToG(this.color);
						var B = hexToB(this.color);
						
						this.update({
							//color: 'rgba('+R+','+G+','+B+', 1)',
							dashStyle: 'dot'
						});
					}
					adjustBaseLine(this);
				}
			};
			
			/* if(s.data[0].PJT_STATE_NAME == 'Proceeding'){
				s.visible = true;
				//s.dashStyle= 'dot';
			}
			else{
				s.visible = false;
				s.dashStyle= 'dot';
			} */
			
			//data가 하나만 있는것은 실적이 없는 것이므로 보여주지 않는다.
			if(s.data.length > 1){
				seriesHigh.push(s);
				
				/* $.each(s.data,function(indexd,d){
					if(d.ACTUAL_DT == undefined || d.ACTUAL_DT == null || $.trim(d.ACTUAL_DT) == '' ){
						d.DELAY_DT += s.data[indexd-1].DELAY_DT;
						d.y = d.DELAY_DT;
						s.data[indexd-1].dashStyle = 'Dot';
						d.dashStyle = 'Dot';
					}
				}); */
				
				// delay dt 다시계산
				$.each(s.data,function(indexd,data){
					if($.trim(data.ACTUAL_DT) == '' ){
						var preDelayDt = s.data[indexd-1].DELAY_DT;
						var curDelayDt = getDateDiff(data.CUR_DT,data.PLAN_DT);
						if(curDelayDt > preDelayDt){
							data.DELAY_DT = curDelayDt ;
							data.y = curDelayDt;
						}else{
							data.DELAY_DT = preDelayDt ;
							data.y = preDelayDt;
						}
					}
					
				});
				
			}
				
		});
		
		
		var plotBandsHigh = new Array();
		var plotLinesHigh = new Array();
		for (var i = 0; i < dataPhase.length; i++){	
			//------------- plotBands 구성. Phase -----------//
			var plotBand = {};
			var phaseDtSplit = dataPhase[i].PHASE_DT.split('-');
			// from
			plotBand.from = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			
			// to
			if(i < (dataPhase.length-1)){
				var phaseDtSplit1 = dataPhase[i+1].PHASE_DT.split('-');
				plotBand.to = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
			}else{//마지막데이타
				if(phaseDtSplit[1]=='11')
					plotBand.to = Date.UTC(phaseDtSplit[0]+1,0 , 0);
				else
					plotBand.to = Date.UTC(phaseDtSplit[0], phaseDtSplit[1] +1  , 0 );
			}
			
			// label
			plotBand.label = {
					text : dataPhase[i].PHASE_NAME ,
					style: {
						color: '#606060' ,
						fontWeight : 'bold'
					}
			};	
			plotBandsHigh.push(plotBand);
			
			//-------------   plotLine 구성.  ----------------//
			var plotLine = {
					color:'black',
					width:1,
					value: 0 ,
					dashStyle: 'ShortDash'			
			};
			
			if(i < (dataPhase.length-1)){
				var phaseDtSplit1 = dataPhase[i+1].PHASE_DT.split('-');
				//plotLine.value = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
				if(phaseDtSplit[1]=='11')
					plotLine.value = Date.UTC(phaseDtSplit1[0]+1,0 , 1);
				else
					plotLine.value = Date.UTC(phaseDtSplit1[0], phaseDtSplit1[1]-1 , 1 );
				
				plotLinesHigh.push(plotLine);
			}else{//마지막데이타
				/* if(phaseDtSplit[1]=='11')
					plotBand.value = Date.UTC(phaseDtSplit[0]+1,0 , 0);
				else
					plotBand.value = Date.UTC(phaseDtSplit[0], phaseDtSplit[1] +1 , 0 ); */
			}
			
		}
		
		var baseLine = {
			type: 'line',
			name: 'Overly Delayed',
			dashStyle: 'dash',
			color:'rgba(255,0,0,1)',
			lineWidth:2,			
			/* marker: {
                enabled: false
            }, */
            data:[]
				
		};	
		seriesHigh.push(baseLine);
		
		var legend =  {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'top',
	            //x: -50,
	            x: 0,
	            y: 50,
	            floating: false,
	            borderWidth: 1,
	            symbolWidth: 35,
	            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF' ,
	            labelFormatter: function(){
	            	//alert("aaa");
	            	var len = this.name.length;
	            	if(len> 10){
	            		var text = this.name.substr(0,10) + "...";
	            		
	            		return "<div title=\""+this.name+"\">"+text+"</div>";
	            	}            		
	            	else
	            		return this.name;
	            }
	            ,useHTML: true
	        }
		
			/* if($("#legendFloat").val() == "false"){
				legend.floating = false;
				legend.x = 0;
			} */
		
		$('#container').highcharts({
	        chart: {
	            type: 'spline'
	            , zoomType: 'xy'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'&nbsp;${param.pjt_name}',
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
	            plotBands : plotBandsHigh,
	            plotLines: plotLinesHigh,
	            labels: {
	                formatter: function () {
	                	return '';
	                }
	            }
	        },
	        yAxis: {
	        	//min: min,
	        	//max: max,
	        	plotLines: [{
	                 color: 'black',
	                 width: 2,
	                 value: 0
	                 //dashStyle: 'dash'		
	            }],
	        	//minColor: "red",
	            title: {
	                text: ''
	            }	            
	        },
	        
	        
	        legend: legend,
	        tooltip: {
	        	useHTML:true,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.point.PJT_NAME}({point.point.PJT_STATE_NAME})</span><br/>'
	          		+'Phase: {point.point.PHASE_NAME}<br/>'
	          		+'Sub Phase: {point.point.SUB_PHASE_NAME}<br/>'
	          		,
                //headerFormat:'',
	            //pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
	            pointFormat: '<span style="color:{series.color}">&nbsp;<b>{series.name}&nbsp;Delay : {point.DELAY_DT}{point.DELAY_DT_C}</b><br/>'
	            			+'&nbsp;&nbsp;&nbsp;Plan : {point.PLAN_DT}'
	            			+'&nbsp;&nbsp;&nbsp;Actual : {point.ACTUAL_DT}<br/>'
	            			//+'&nbsp;&nbsp;&nbsp;Delay : {point.DELAY_DT}{point.DELAY_DT_C}'
	            				+'</span><br/>'
	           ,
	            shared: true, // 하나만 표시한다. y이면 모두표시함
	            crosshairs: true
	            /* ,formatter: function () {
	            	if(this.series.type == 'line')
	            		return false;
	            	var point = this.point;
	            	
            		var rtn =  '<span style="color:{series.color}">' +
            		'<b>' + point.options.PJT_NAME + '(' + point.options.PJT_STATE_NAME + ')</b><br/>' + 
            		'Revision: ' + point.options.REVISION + '<br/>' +
                	'Phase: ' + point.options.PHASE_NAME + '<br/>' +
                	'Sub Phase : ' + point.options.SUB_PHASE_NAME + '<br/>'+
                	'Plan : ' + point.options.PLAN_DT + '<br/>'+
                	'Actual : ' + point.options.ACTUAL_DT + '<br/>';
                	rtn += 'Delay : ' + point.options.DELAY_DT;
                	var actualDt = point.options.ACTUAL_DT;
                	if(actualDt == undefined || actualDt == null || $.trim(actualDt) == '' ){
						rtn += '(expected)';
					}
                	
                	rtn += '<br/>';
                	//'Delay Sum: ' + point.options.DELAY_DT_SUM + '<br/>' +
                	'</span>'
	            	
                	
                	return rtn;
	            }
	            */
	        },
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true, // by default
	                point:{	                	
	                	/* events:{
	                		click: function(e){
	                			var pjt_id = this.options.PJT_ID;
	                			var pjt_name = this.options.PJT_NAME;
	                			goProject(pjt_id,pjt_name);
	                			
	                		}
	                	} */
	                }
	            },
	            line: {
	                marker: {
	                	enabled: false
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
	                    enabled: true
	                },
	                enableMouseTracking: true 
	                
	                
	            }
	        },	        
	        series: seriesHigh
	    },function(chart){
	    		adjustBaseLine(null);
		    }
		);
		
	}
	
	// 수정된 가상의 날짜를 계산한다.
	function getSubPhaseSeqDt(pjt_id, revision, phase_id, sub_phase_seq){
		var phaseDt = getPhaseDt(phase_id);
		var phaseDtSplit = phaseDt.split('-');
		var dataCount = dataPhaseCount;
		for(var i=0;i<dataCount.length;i++){
			if(pjt_id == dataCount[i].PJT_ID && revision == dataCount[i].REVISION && phase_id == dataCount[i].PHASE_ID){
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
		if(parent != window && parent.goProject)
			parent.goProject(pjt_code,pjt_name);
		else{
			var newWin1 = window.open("", "pmsScheduleProject", "resizable=yes, scrollbars=yes, status=yes,menubar=yes");
			var oFrm = document.getElementById("form");
			oFrm.pjt_code.value = pjt_code;
			oFrm.pjt_name.value = pjt_name;
			oFrm.action =  '/dashboard/pmsScheduleProject.do';
			oFrm.method = "post";
			oFrm.target = 'pmsScheduleProject'; 
		    oFrm.submit();
		    newWin1.focus();
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
			var revision = dataList[i].REVISION;
			
			/* var containPjts = uSeriesVal.filter(function(val){
				if(val == pjt)	
					return val;
			}); */
			 var containPjts = $.grep(uSeriesVal, function(val){
					if(val == revision)	
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
			var utcDt1 = convertDateToUct(phase.PHASE_DT,'-');
			var utcDt2 = convertDateToUct(monthAdd(phase.PHASE_DT,1,'-'));
			
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
