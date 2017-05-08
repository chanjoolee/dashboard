<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>projectOneStackByPCntDate</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
    
    <script type="text/javascript" src="js/jqGrid/jquery.jqGrid.min.js"></script>
    <script type="text/javascript" src="js/jqGrid/i18n/grid.locale-kr.js"></script>
    
    <%-- 2. highcharts --%>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=1"></script>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	
	$(function () {
		projectListByAjax();
		$( window ).resize(function() {
			adjustGrid();
		});
	});
	
	function legentControl(){
		var chart = $('#container').highcharts(); 
		if(chart == undefined) 
			return;
		
        var legend = chart.legend; 
        
        var btn = $("#updateLegend");
        if($("#legendFloat").val() == "true")
        	$("#legendFloat").val("false");
        else
        	$("#legendFloat").val("true");
        
       drawChart(responseDataG);
	}
	
	
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/projectListByJson.html",
			//data: {},
			data: $("#form").serialize(),
			success : function(responseData){
				var projectList = responseData.projectList;
				var paramPjtcode = "${param.pjt_code}" ;
				var selected ="";
				for(var i=0; i<projectList.length ; i++){					
					var pjt_code = projectList[i].PJT_CODE;
					selected ="";
					if(paramPjtcode==pjt_code)
						selected = "selected";
					$("#sProject").append("<option value=\""+ projectList[i].PJT_CODE +"\"  "+ selected +">" + projectList[i].PJT_CODE +"</option>" );	
				}
				
				if(paramPjtcode != "")
					getDataByJson();
			}
		});
	}
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/projectOneStackByPCntJson.html",
			data: {PJT_CODE: $("#sProject").val() },
			//data: $("#form").serialize(),
			success : function(responseData){
				responseDataG = responseData;
				drawChart(responseData);
			}
		});
	}
	
	
	// 가사의 UTC 날자로 실제 날의 가져올다.
	function getDataByUtc(pjtCode,utcDate){
		var dataRaw = responseDataG.data;
		for(var i=0;i<dataRaw.length;i++){
			var data = dataRaw[i];
			if(data.PJT_CODE == pjtCode && data.utcDate == utcDate )
				return data;//data.phaseSeqDt;
		}
		return 'error';
	}
	
	function getCodesonarPriorityCsvLink(pjtCode){
		var linkUrl = "";
		$.ajax({
			url : "/dashboard/codesonarPriorityCsvLinkJson.html",
			async: false,
			data: {PJT_CODE: pjtCode },
			//data: $("#form").serialize(),
			success : function(responseData){
				var list = responseData.data;
				for(var i=0;i<list.length;i++){
					var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
					var csvnum = list[i].CSV_NUM;
					linkUrl +="<a href='"+"http://"+svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=priority="+"\"P0: High\""+"' target='_blank'>"+list[i].PJT_CODE+"</a>";
					linkUrl +="</br>";
				}
			}
		});
		return linkUrl;
	}
	
	
	
	
	
	
	
	function drawChart(resonseData){		
		var data = resonseData.data;	
		
		// 가져온데이타를 하이차트에 맞게 변형한다.
		// xAxis,series(p0,p1,p2)
		var seriesP0 = new Array();
		var seriesP1 = new Array();
		var seriesP2 = new Array();
		
		
		for (var i = 0; i < data.length; i++){			
			var d = data[i];
			var dateSplit = d.ANALYSYS_DATE.split('-');			
			var utcDate = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]);
			d.utcDate = utcDate;
			//seriesP0.push([utcDate,data[i].P0]);
			//seriesP1.push([utcDate,data[i].P1]);
			//seriesP2.push([utcDate,data[i].P2]);			
			seriesP0.push({
				x:utcDate,
				y:data[i].P0,
				rawdata:d
			});
			seriesP1.push({
				x:utcDate,
				y:data[i].P1,
				rawdata:d
			});
			seriesP2.push({
				x:utcDate,
				y:data[i].P2,
				rawdata:d
			});
        }
		
		// plotBands,plotLinesHigh 구성
		var plotBandsHigh = new Array();
		var plotLinesHigh = new Array();
		var bandIndex = 0;
		var dataPhase = resonseData.phase;
		for (var i = 0; i < dataPhase.length; i++){	
			//01. ------------- plotBands 구성. Phase -----------//
			var plotBand = {};
			var phaseDtSplit = dataPhase[i].ACTUAL_START_DATE.split('/');
			//plotBand.borderColor = 'rgba(0, 0, 0, 0.1)';
			//plotBand.borderWidth = 1;
			// from
			plotBand.from = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			
			// to
			var phaseDtSplit1 = dataPhase[i].ACTUAL_END_DATE.split('/');
			plotBand.to = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
			
			// label
			plotBand.label = {
					text : dataPhase[i].PHASE ,
					style: {
						color: '#606060' ,
						fontWeight : 'bold'
					}
			};	
			plotBandsHigh.push(plotBand);
			
			//02. -------------   plotLine 구성.  ----------------//
			var plotLine = {
					color:'black',
					width:1,
					value: 0 ,
					dashStyle: 'ShortDash'			
			};
			
			
			var phaseDtSplit = dataPhase[i].ACTUAL_END_DATE.split('/');
			plotLine.value = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			plotLinesHigh.push(plotLine);
		}
		
		var title = $("#sProject").val();
		if( window != parent.window )
			title = "CodeSonar";
		
		var legend = {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -50,
            y: 100,
            floating: true,
            borderWidth: 1,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
            shadow:true
        };
		
		if($("#legendFloat").val() == "false"){
			legend.floating = false;
			legend.x = 0;
		}
		
		
		//-----context menu
		var defaultExporting = Highcharts.getOptions().exporting;
		var myExporting = $.grep(defaultExporting.buttons.contextButton.menuItems,function(menu){
			//if(menu.text == "All Class")
				return menu;
		});
		
		myExporting.push(
			{
				separator: true
			},{
				text: 'Legend',
				onclick: function () {
					legentControl();
					//prototype: defaultOptions.exporting.buttons.contextButton.menuItems.onclick;
				},
				separator: false
			}
		);
		//----- context menu End
		
		
		$('#container').highcharts({
	        chart: {
	            type: 'area'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: title
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
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            },
	            //title: {
	            //    enabled: false
	            //},
	            plotBands : plotBandsHigh,
	            plotLines: plotLinesHigh
	           /* ,labels: {
	                formatter: function () {
	                	var dt = new Date(this.value);
	                	return (dt.getMonth()+1) + '.' + dt.getDate();
	                    
	                }
	            } */
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	            
	        },
	        tooltip: {
	            shared: true ,
	            crosshairs: true,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '' /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        legend: legend,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true ,// by default
	                point:{
	                	events:{
	                		click: function(e){
	                			var priority = "P0: High";
	                			if(this.series.name=="P1")
	                				priority = "P1: Medium";
	                			else if(this.series.name=="P2"){
	                				prority = "P2: Low";
	                			}
	                			//var dt = this.rawdata.ANALYSYS_DATE;
	                			// 최근날자로 링크 나타내도록. 201505-07
	                			var ind = this.series.data.length -1;
	                			var dt =this.series.data[ind].rawdata.ANALYSYS_DATE;
	                			htmlExpandPriority($("#sProject").val(),priority,dt);
	                		}
	                	}
	                }
	            },
	            area: {
	                stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: true
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            }
	        },
	        series: [{
	            name: 'P2',
	            data: seriesP2,
	            visible:false,
	            events: {
					hide: function(){
						adjustBaseLine(this);
					},
					show: function(){
						adjustBaseLine(this);
					}
				}
	        },{
	            name: 'P1',
	            data: seriesP1,
	            visible:false,
	            events: {
					hide: function(){
						adjustBaseLine(this);
					},
					show: function(){
						adjustBaseLine(this);
					}
				}
	        }, {
	            name: 'P0',
	            data: seriesP0,
	            visible:true,
	            events: {
					hide: function(){
						adjustBaseLine(this);
					},
					show: function(){
						adjustBaseLine(this);
					}
				}
	        } ,{
				type: 'line',
				name: 'P0-BaseLine',
				dashStyle: 'dash',
				color:'rgba(255,0,0,1)',
				lineWidth:2,			
				/* marker: {
	                enabled: false
	            }, */
	            data: []
					
			},{
				type: 'line',
				name: 'P1-BaseLine',
				dashStyle: 'dash',
				color:'rgba(0,0,255,1)',
				lineWidth:2,			
				/* marker: {
	                enabled: false
	            }, */
	            data: []
					
			}
	        ]
	    },function(chart){
	    	drawGrid();	
	    }
		);
		
		adjustBaseLine(null);
		//$('#container').highcharts.series[0].hide();
		//$('#container').highcharts.series[1].hide();
		// Apply the theme
		//Highcharts.setOptions(Highcharts.theme);
	}
	
	/**
	* baseLine의 범위가 다른프로젝트 의 범위보다 항상 크므로 series.visible 값에 따라 범위를 조정한다.
	* @param obj:  해당이벤트 series 객체
	*/	
	function adjustBaseLine(obj){
		var baseLineData = new Array();
		var baseLineDataA = new Array();
		var dataPhase = responseDataG.phase;
		
		var chart = $('#container').highcharts();
		/* var uSeries = chart.series.filter( function(s){
			if(s.name != 'BaseLine' && s.name != 'BaseLineA')
				return s.visible;
		}); */
		
		var uSeries = $.grep(chart.series, function(s){
			if(s.name != 'P0-BaseLine' && s.name != 'P1-BaseLine')
				return s.visible;
		});
		
		/* var baseLine = chart.series.filter( function(s){
			if(s.name == 'BaseLine')
				return true;
		}); */
		
		var baseLine = $.grep(chart.series, function(s){
			if(s.name == 'P0-BaseLine')
				return true;
		});
		
		/* var baseLineA = chart.series.filter( function(s){
			if(s.name == 'BaseLineA')
				return true;
		}); */
		
		var baseLineA = $.grep(chart.series, function(s){
			if(s.name == 'P1-BaseLine')
				return true;
		});
		
		
		var minDt = '';
		var minDtUtc = null;
		var minDtApply = false;
		if(responseDataG.data.length>0){
			var minDt = responseDataG.data[0].ANALYSYS_DATE;
			var minDtSplit = minDt.split('-');
			minDtUtc = Date.UTC(minDtSplit[0],minDtSplit[1] -1 ,minDtSplit[2]);
		}
		
		var maxDt = '';
		var maxDtUtc = null;
		var maxDtApply = false;
		if(responseDataG.data.length>0){
			var maxDt = responseDataG.data[responseDataG.data.length-1].ANALYSYS_DATE;
			var maxDtSplit = maxDt.split('-');
			maxDtUtc = Date.UTC(maxDtSplit[0],maxDtSplit[1] -1 ,maxDtSplit[2]);
		}
		
		for (var i = 0; i < dataPhase.length; i++){
			
			
			//01. ------------- BaseLine 구성 -----------//
			var phaseDtSplit = dataPhase[i].ACTUAL_START_DATE.split('/'); //start
			var phaseDtSplit1 = dataPhase[i].ACTUAL_END_DATE.split('/'); //end
			var phaseDtSplitBend = null; //beforeEnd
			
			
			var startDt1 = phaseDtSplit[2];
			var utcDt1 = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			if(i>0){
				phaseDtSplitBend = dataPhase[i-1].ACTUAL_END_DATE.split('/');
				utcDt1 = Date.UTC(phaseDtSplitBend[0],phaseDtSplitBend[1] -1 ,phaseDtSplitBend[2]);
			}		
			var utcDt2 = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
			
			
			
			// phase정보의 시작일이 실제데이타의 시작일 보다 작은 경우적용
			// 그래프에 쓸데없은 line을 없애기 위함
			if(!minDtApply && i < (dataPhase.length) && minDt != ''){
				var nextSplit = dataPhase[i].ACTUAL_START_DATE.split('/');
				var nextSplit1 = dataPhase[i].ACTUAL_END_DATE.split('/');
				var nextUtcDt= Date.UTC(nextSplit[0],nextSplit[1] -1 ,nextSplit[2]);
				var nextUtcDt1 = Date.UTC(nextSplit1[0],nextSplit1[1] -1 ,nextSplit1[2]);
				
				if(utcDt1 < minDtUtc && 
						utcDt2 < minDtUtc){
					continue;
				}else if( nextUtcDt < minDtUtc && 
						nextUtcDt1 > minDtUtc){
					utcDt1 = minDtUtc;
					minDtApply = true;
				}
			}
			
			var target = 0;
			var targetA = 0;
			
			for(var j=0;j<uSeries.length;j++){
				var s = uSeries[j];
				if(s.name == 'P0'){ target += dataPhase[i].P0; targetA += dataPhase[i].PA0;}
				if(s.name == 'P1'){ target += dataPhase[i].P1; targetA += dataPhase[i].PA1;}
				if(s.name == 'P2'){ target += dataPhase[i].P2; targetA += dataPhase[i].PA2;}
				
			}
			
			if(utcDt2 > maxDtUtc ){
				utcDt2 = maxDtUtc;
				maxDtApply = true;
			}
				
			
			baseLineData.push(
					{
						x: utcDt1, 
						y: target,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false,
		                    color: 'red',
		                    style: {
		                        fontWeight: 'bold'
		                    }
		                }
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
			
			baseLineDataA.push(
					{
						x: utcDt1, 
						y: targetA,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false,
		                    color: 'blue',
		                    style: {
		                        fontWeight: 'bold'
		                    }
		                }
					},
					{
						x: utcDt2, 
						y:targetA,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false
		                }
					}
			);	
			if(maxDtApply)
				break;
		}	
		
		baseLine[0].update({
			data: baseLineData
		});
		
		baseLineA[0].update({
			data: baseLineDataA
		});
	}
	
	function drawGrid(){
		var gridArrayData = responseDataG.data;
		for(var i=0;i<gridArrayData.length;i++){
			gridArrayData[i].id= i+1;
		}
		//$("#jqGrid").html('');
		if($("#jqGrid").text()!=""){
			jQuery('#jqGrid').jqGrid('clearGridData');
			jQuery("#jqGrid").jqGrid('setGridParam', { data: gridArrayData, rowNum: gridArrayData.length });
			jQuery('#jqGrid').trigger('reloadGrid');
			
		}else{
			$("#jqGrid").jqGrid({
				//url: 'data.json',
				datatype: "local",
				//datatype: "json",
				data:gridArrayData,
				 colModel: [
					{name:'id',index:'id', width:60, sorttype:"int" ,align:'center'},
					{ label: 'project', name: 'PJT_CODE', width: 75 ,align:'center'},
					{ label: 'analysys_date', name: 'ANALYSYS_DATE', width: 100,align:'center' },
					{ label: 'phase', name: 'PHASE', width: 90,align:'center' },
					{ label: 'p0', name: 'P0', width: 100 ,align:'right'},
					{ label: 'p1', name: 'P1', width: 100 ,align:'right'},
					{ label: 'p2', name: 'P2', width: 100 ,align:'right'},
					{ label: '', name: '',width: null }
					// sorttype is used only if the data is loaded locally or loadonce is set to true
					//{ label: 'Quantity', name: 'Quantity', width: 80, sorttype: 'number' }                   
				],
				viewrecords: true, // show the current page, data rang and total records on the toolbar
				//width: "100%",
				//height: "100%",
				//height:'100%',
				//autowidth: true,
				//autoheight: true,
				//shrinkToFit: false,
				//pager: "#jqGridPager",
				//decimalSeparator: ',' ,
				rowNum: gridArrayData.length,
				loadonce: false // this is just for the demo
				//,caption: 'Data List'
				
			});
		}
		
		adjustGrid();
	}
	
	function adjustGrid(){
		$("#jqGrid").jqGrid('setGridWidth',$("#containerGrid").width() - 40 );
		$("#jqGrid").jqGrid('setGridHeight',$("#containerGrid").height() - 60 );
		//$(".jqgfirstrow").css('height', 0 );		
	}

	</script>
	<style type="text/css">
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow: hidden;
	      }
		
		.dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 65%;	
		}
		
		.grid-div{
			position: relative;
			min-height: 1px;
			padding: 20px;
			width: 100%;
			height: 28%;	
		}
		
		.dashboard-div ul {
		  margin: 0;
		  padding: 0;
		  list-style-type: none;
		  /* for flex */
		  display: -webkit-box;      
		  display: -moz-box;  
		  display: -ms-flexbox;   
		  display: -webkit-flex;   
		  display: flex;      
		  height: 100%;
		}
		.dashboard-div ul li {
		  display: inline-block;
		  *display: inline;
		  *zoom: 1;
		  width: 49%;
		}
		
		
		<%-- 그리드폰트 jquery-ui.css 866 line --%>
		.ui-state-default,
		.ui-widget-content .ui-state-default,
		.ui-widget-header .ui-state-default {
			color: black;
		}
		
	</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" name="version" value="${param.version}"/>
<input type="hidden" name="legendFloat" id="legendFloat" value="false"/>
<div <c:if test="${param.pjt_code != null}"> style="display:none;"   </c:if>>
	<select  name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson()" >
		<option>PROJECT SELECT</option>
	</select>
</div>
<div id="container" class="dashboard-div"></div>
<div id="containerGrid" class="grid-div">
	<table id="jqGrid" style="width: 100%;height: 100%"></table>
    <!-- <div id="jqGridPager"></div>  -->
</div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
