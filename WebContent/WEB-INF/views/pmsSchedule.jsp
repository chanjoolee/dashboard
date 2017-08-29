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
	
	<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" /> -->
	
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" />
	
	<script src="/dashboard/js/jointjs/lodash.min.js"></script>
	<script type="text/javascript">	
	var starttime = new Date();
	if (window.console) console.log('start time:' + starttime.toString());
	var endtime;
	
	var dataPhase = [];
	var dataPhaseCount = [];
	var dataList = [];
	var projectList = [];
	
	$(function () {
		pmsProjectList();
		getDataByJson();
	});
	
	function pmsProjectList(){
		$.ajax({
			//url : "/dashboard/dashboardProjectListJson.html",
			url : "/dashboard/pmsProjectListJson.html",
			data: {division:'jira'},
			async : false,
			success : function(pResponseData){
				//var projectList = responseData.projectList;
				//var projectList0 = responseData.dataList;
				//var projectList =	dataFilter(projectList0,[{col:'APPLICATION_ID',val:'SPM_00005011'},{col:'APPLICATION_ID',val:'SPM_00005010'},{col:'APPLICATION_ID',val:'SPM_00005558'}]);
				//var projectList =responseData.projectList;
				//sortObjects(projectList,['APPLICATION_NM','PJT_NAME'])
				//responseData = pResponseData;
				projectList =pResponseData.dataList;
				
				var groupKeys = ['DISPLAY_ORDER','PJT_NAME'];
				var series = getDrillDownDataSeries2(
						'',
						projectList ,
						groupKeys ,
						[], //filter
						[], //convert
						'', //xAxis
						'CNT',
						{cd: 'APPLICATION_ID', name:'APPLICATION_NAME'},
						{isGroupby: false}
				);
				
				var selected ="";
				var sb = [];
				$.each(series.series,function(index,s){
					sb.push("<optgroup label=\""+s.name+" (Click)\">");
					$.each(s.data,function(index1,d){
						if(this.APPLICATION_NAME=="Mobile Solution")
							selected = "selected";
						else 
							selected = "selected";
						sb.push("<option value='"+ d.PJT_CODE +"' "+selected+" status='"+d.PJT_STATE+"'>" + d.PJT_NAME +"</option>");
					});
					sb.push("</optgroup>");
				});
				
				$("select[name=pjtCodeList]").append(sb.join(""));
				
				$("select[name=pjtCodeList]").change(function(){
					//getDataByJson();
					drawchart();
				});
				projectMultiSelect = $("select[name=pjtCodeList]").multiselect({
					height:400,
					selectedText: 'Project # selected',
					noneSelectedText: 'Select projects'
				}).multiselectfilter();
				$("div.ui-multiselect-menu").css("width","500px");
				$(".ui-multiselect-filter input").css("width","200px");
				
				//상태표시
				$.each(series.series,function(index,s){
					$.each(s.data,function(index1,d){
						var label = $("input[name=multiselect_pjtCodeList][value="+d.PJT_CODE+"]").parent();
						label.append("<span style='color: blue;float:right;'>"+ d.PJT_STATE_NAME +"</span>");
						
					});
				});
				
				pjtStatus(projectList);
			}
		});
	}
	
	
	function pjtStatus(projectList){
		var status = groupbyCount(projectList,['PJT_STATE','PJT_STATE_NAME']);
		
		var selected ="";
		var sb = [];
		$.each(status,function(){
			if(this.PJT_STATE_NAME=="Proceeding")
				selected = "selected";
			else 
				selected = "";
			sb.push("<option value='"+ this.PJT_STATE +"' "+selected+">" + this.PJT_STATE_NAME +"</option>");
		});
		
		$("select[name=pjtStatus]").append(sb.join(""));
		$("select[name=pjtStatus]").change(function(){
			filterByStatus();
			
		});
		var select = $("select[name=pjtStatus]").multiselect({
			selectedList: 1,
			height:100,
			selectedText: 'Status # selected',
			noneSelectedText: 'Select Status'
		});
		filterByStatus(status);
	}
	
	function filterByStatus(){
		$("select[name=pjtStatus] option").each(function(i,sel){
			if($(this).is(':selected')){
				$("select[name=pjtCodeList] option[status="+$(this).val()+"]").prop( "disabled", false );
				//$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", true );
			}else{
				$("select[name=pjtCodeList] option[status="+$(this).val()+"]").prop( "disabled", true );
				//$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", false );
			}
		});
		$("select[name=pjtCodeList] option").each(function(i,project){			
			$("input[name=multiselect_pjtCodeList][value="+$(this).val()+"]").prop( "disabled", $(this).prop("disabled") );
			if($(this).prop("disabled")){
				$("input[name=multiselect_pjtCodeList][value="+$(this).val()+"]").parent().addClass( "ui-state-disabled" );
				$("input[name=multiselect_pjtCodeList][value="+$(this).val()+"]").attr("checked",false);
				
			}else{
				$("input[name=multiselect_pjtCodeList][value="+$(this).val()+"]").parent().removeClass( "ui-state-disabled" );
			}
			
		});
		
		$("input[name=multiselect_pjtCodeList]").each(function(){
			$("select[name=pjtCodeList] option[value="+$(this).val()+"]").prop( "selected", $(this).is(":checked") );
		});
		
		//projectMultiSelect.multiselect('refresh');
				
		/* var groupKeys = ['DISPLAY_ORDER','PJT_NAME'];
		var series = getDrillDownDataSeries2(
				'',
				projectList ,
				groupKeys ,
				[], //filter
				[], //convert
				'', //xAxis
				'CNT',
				{cd: 'APPLICATION_ID', name:'APPLICATION_NAME'},
				{isGroupby: false}
		); */
		
		projectMultiSelect = $("select[name=pjtCodeList]").multiselect({
			height:400,
			selectedText: 'Project # selected',
			noneSelectedText: 'Select projects'
		}).multiselectfilter();
		//$("div.ui-multiselect-menu").css("width","500px");
		//$(".ui-multiselect-filter input").css("width","200px");
		
		//상태표시
		/* $.each(series.series,function(index,s){
			$.each(s.data,function(index1,d){
				var label = $("input[name=multiselect_pjtCodeList][value="+d.PJT_CODE+"]").parent();
				label.append("<span style='color: blue;float:right;'>"+ d.PJT_STATE_NAME +"</span>");
				
			});
		}); */
		
		//getDataByJson();
		drawchart();
	}
	
	function getDataByJson(){
		var requesttime = new Date();		
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/pmsScheduleJson.html",
			//url : "http://10.92.142.215:8080/dashboard/pmsScheduleJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				var vEndtime = new Date();
				if (window.console) console.log('dataLoadingTime:' + (vEndtime.getTime() - requesttime.getTime()) );
				
				dataPhase = responseData.dataPhase;
				dataPhaseCount = responseData.dataPhaseCount;
				dataList = responseData.dataList;
				
				for(var i=0;i<dataList.length;i++){
					var data = dataList[i];
					data.subPhaseSeqDt = getSubPhaseSeqDt.call(data, data.PJT_ID,data.PHASE_ID,data.SUB_PHASE_SEQ);
					
				}
				
				//DELAY_DT_SUM
				var prePjtId = "";
				for (var i = 0; i < dataList.length; i++){
					var data = dataList[i];
					if(prePjtId != dataList[i].PJT_ID){
						data.DELAY_DT_SUM = 0;
						data.DELAY_DT_SUM += data.DELAY_DT;
						prePjtId = dataList[i].PJT_ID;
					}else{
						data.DELAY_DT_SUM = dataList[i-1].DELAY_DT_SUM;
						data.DELAY_DT_SUM += data.DELAY_DT;
					}			
		        }
				
				drawchart();
				getDataByJsonAll();
			}
		});
	}
	
	// dataloading 시간을 줄이기 위해 나중에 처라
	function getDataByJsonAll(){
		var requesttime = new Date();		
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/pmsScheduleAllJson.html",
			//url : "http://10.92.142.215:8080/dashboard/pmsScheduleJson.html",
			data: {} ,
			success : function(responseData){
				var vEndtime = new Date();
				if (window.console) console.log('dataLoadingAllTime:' + (vEndtime.getTime() - requesttime.getTime()) );
				dataList = responseData.dataList;
				
				for(var i=0;i<dataList.length;i++){
					var data = dataList[i];
					data.subPhaseSeqDt = getSubPhaseSeqDt.call(data, data.PJT_ID,data.PHASE_ID,data.SUB_PHASE_SEQ);
				}
				
				//DELAY_DT_SUM
				var prePjtId = "";
				for (var i = 0; i < dataList.length; i++){
					var data = dataList[i];
					if(prePjtId != dataList[i].PJT_ID){
						data.DELAY_DT_SUM = 0;
						data.DELAY_DT_SUM += data.DELAY_DT;
						prePjtId = dataList[i].PJT_ID;
					}else{
						data.DELAY_DT_SUM = dataList[i-1].DELAY_DT_SUM;
						data.DELAY_DT_SUM += data.DELAY_DT;
					}			
		        }
			}
		});
	}
	
	
	function drawchart(){	
		var drawStartTime = new Date();		
		// 2015-08-18. application 추가함.
		// 서버재시작을 하지 않기위해 java는 건드리지 않음.
		var appFilters = [ {col:'PJT_ID',val: []}];
		var application = $("[name=pjtCodeList] option:selected");
		$.each(application,function(index,app){			
			appFilters[0].val.push(app.value);
		});
		
		var groupKeys = ['PJT_ID', 'PJT_NAME', 'PHASE_ID', 'PHASE_NAME', 'SUB_PHASE_ID', 'SUB_PHASE_NAME','PJT_STATE_NAME', 'SUB_PHASE_SEQ','subPhaseSeqDt','PLAN_DT', 'ACTUAL_DT', 'DELAY_DT'];		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				appFilters, //filter 
				[{col:'subPhaseSeqDt',convert:'x',datatype:'date'},{col:'DELAY_DT',convert:'y',datatype:'int',isnull:null}], //convert
				'', 
				'CNT',
				{cd: 'PJT_ID', name:'PJT_NAME'},
				{isGroupby:false}
		);	
		
		
		//if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
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
			
			if(s.data[0].PJT_STATE_NAME == 'Proceeding'){
				s.visible = true;
				//s.dashStyle= 'dot';
			}
			else{
				s.visible = false;
				s.dashStyle= 'dot';
			}
			
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
				
				// 60이하의 값을가진 시리즈는 보여주지 않는다.
				var isShow = $('[name=showBelow60]').is(':checked');
				var lastdata = s.data[s.data.length-1];
				if (s.name != 'Overly Delayed' && lastdata.y <= 60 ){
					s.visible = isShow;
				}
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
		
		// 60 이상인 것만 simbol보이기.
		makeMarkerSimbol(seriesHigh);
			
		$('#container').highcharts({
	        chart: {
	            type: 'spline'
	            , zoomType: 'xy'
	            , animation: true
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
	            },
	            gridLineWidth: 0,
	            tickInterval: 100
	        },
	        
	        
	        legend: legend,
	        tooltip: {
	          	//headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            //pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> ({point.percentage:.0f}%)<br/>',
	            //pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b> <br/>',
	            shared: false, // 하나만 표시한다. y이면 모두표시함
	            crosshairs: false,
	            formatter: function () {
	            	if(this.series.type == 'line')
	            		return false;
	            	var point = this.point;
	            	
            		var rtn =  '<span style="color:{series.color}">' +
            		'<b>' + point.options.PJT_NAME + '(' + point.options.PJT_STATE_NAME + ')</b><br/>' + 
                	'Phase: ' + point.options.PHASE_NAME + '<br/>' +
                	'Sub Phase : ' + point.options.SUB_PHASE_NAME + '<br/>'+
                	'Plan : ' + point.options.PLAN_DT + '<br/>'+
                	'Actual : ' + point.options.ACTUAL_DT + '<br/>';
                	rtn += '<span style="font-weight: bold;">Delay : ' + point.options.DELAY_DT ;
                	var actualDt = point.options.ACTUAL_DT;
                	if(actualDt == undefined || actualDt == null || $.trim(actualDt) == '' ){
						rtn += '(expected)';
					}
                	rtn += '</span>';
                	rtn += '<br/>';
                	//'Delay Sum: ' + point.options.DELAY_DT_SUM + '<br/>' +
                	'</span>'
	            	
                	
                	return rtn;
	            }
	        },
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true, // by default
	                point:{	                	
	                	events:{
	                		click: function(e){
	                			var pjt_id = this.options.PJT_ID;
	                			var pjt_name = this.options.PJT_NAME;
	                			goProject(pjt_id,pjt_name);
	                			
	                		}
	                	}
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
	                	//enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: true,
	                    style:{fontSize: "8px"}
	                    
	                },
	                enableMouseTracking: true 
	                
	                
	            }
	        },	        
	        series: seriesHigh
	    },function(chart){
	    		adjustBaseLine(null);
	    		//hideBelowBaseLine();
	    		endtime = new Date();
	    		var diff = endtime.getTime() - drawStartTime.getTime();
	    		if (window.console) console.log('drawingTime:' + diff.toString());
	    		
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
	
	
	/**
	* 60이 넘는 데이타만 심볼을 만든다.
	**/
	function makeMarkerSimbol(series){
		$.each(series,function(i,s){
			var sindex = i % Highcharts.getOptions().symbols.length;
			var simbol = Highcharts.getOptions().symbols[sindex];
			
			$.each(s.data,function(j,d){
				if(d.y <= 60){
					d.marker = {
						enabled: false
					};
				}
			});
		});
		
	}
		
	
	/**
	* 60이하의 값을가진 시리즈는 보여주지 않는다.
	**/
	function hideBelowBaseLine(){
		var vStime = new Date();		
		
		var isShow = $('[name=showBelow60]').is(':checked');
		var chart = $('#container').highcharts();
		$.each(chart.series, function (index,s) {
			if(s.data.length > 0) {
				var lastdata = s.data[s.data.length-1];
				if (s.name != 'Overly Delayed' && lastdata.y <= 60 ){
					//s.visible = false;
					s.setVisible(isShow,false);
				}
			}
			
		});
		chart.redraw();
		var vEtime =  new Date();		
		var diff = vEtime.getTime() - vStime.getTime();
		if (window.console) console.log('Show all projects Time:' +diff );
		
		
	}
	

	</script>
	<style type="text/css">
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
			height: 95%;			
		}		
		
		.div-application{
			width: 100%;
			/* margin-left:10px; */
			/* height: 20px;		 */
			display: block;	
			font-size: 12px;
			overflow: hidden;
		}
		
		/* multi-select 관련  */
		.ui-multiselect-checkboxes li label{
			font-size: 13px;
			line-height: 1.3em;
		}		
		.ui-multiselect-checkboxes li label input[type="checkbox"] {margin:0; padding:0; vertical-align:middle;}
		ui-multiselect-menu a:link, a:visited, a:active {
			font-family:'Malgun Gothic', arial, gulim, dotum;
			/* color: #000; */
			text-decoration:none;
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
<div id="application" class="div-application">
	<div style="display:inline-block;text-overflow:hidden;float:left;" title="Mobile">
		<select name="pjtStatus" id="pjtStatus" multiple="multiple" style="width:150px" >
	    </select>
		<input type="hidden" name="pjtCodeList" value ="xxx"/>
		<select name="pjtCodeList" id="pjtCodeList" multiple="multiple" style="" >
	    </select>
	</div>
	<div style="width:200px;height:20px;display:inline-block;text-overflow:hidden;float:left;" title=""><input type="checkbox" name="showBelow60"  class="mycheck"  value=""  onchange="hideBelowBaseLine()"/><span style="">Show all projects</span></div>
</div>
<div id="container" class="container"></div>
</form>
<c:forEach items="${paramValues.pjtCodeList}" var="pjtCode" varStatus="status">
	<input type="hidden" name="reqPjtCodeList" value="${pjtCode}"/>
</c:forEach>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
