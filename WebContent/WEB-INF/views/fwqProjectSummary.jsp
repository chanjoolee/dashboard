<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>FWQualitySummary: ${param.pjt_name}</title>
	<link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css" />
	
	
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
    
	<!-- <script src="js/highcharts/src/highcharts.src.js"></script> -->
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=1"></script>
	
	<%-- 5. local --%>
	
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" />
	
	<link rel="stylesheet" type="text/css" href="/dashboard/css/stylesheet-image-based.css" />
	<style>
		.wrap_a{width:100%; overflow:hidden}
		.wrap_b{width:100%; overflow:hidden}
		.wrap_b_1{width:49%; height:auto ;overflow:hidden; float:left; /* margin-top:30px */}
		.wrap_b_2{width:49%; height:auto ;overflow:hidden; float:right; /* margin-top:30px */}
		
		<%--.box_gray{background:#f5f6fa; border:1px solid #e1e2e6; padding:15px; text-align:center; margin-bottom:8px } --%>
		.dashboard_box{/* border:1px solid #e1e2e6;  */}
		.cont_tit {float:none}
		iframe {
			   border: none;
			   frameborder:0;
			   
			   width: 100%;
			   height: 100%;
		}
		
		.radioDiv div{
			display:inline;
		}
		.table_hori th {
			font-weight: bolder;
			height: 40px;
		}
		.table_hori td {
			height: 40px;
			font-weight: bold;
		}
		
		
		.border_boxAll{
			border-color: #c0c0c0;
			border-style: solid;
			border-width: 1px;
		}
		
		
		
		
		
		
	</style>
<script type="text/javascript">

	var dataList = [];
	var scheduleDataList = [];
	var scheduleSeries = {};
	var current = 0;
	var delayDt = 0;
	var currentShedule = {} ;
	var currentData = {};
	var subProjectList = [];
	var buttonRenderer = null;
	
	//var spiderData = {};
	$(function () {
		//initSpider();
		//initAdvanced();
		//getDataByJson();
		//subProjectList();
		subProjectPoint();
		
		$( window ).resize(function() {
			buttons();
		});
		
	});
		
	function initSpider(){
		var oFrm = document.getElementById("form1");
		//oFrm.pjt_code.value = this.options.dataraw.PJT_CODE;
		//oFrm.pjt_name.value = this.options.dataraw.PJT_NAME;
		oFrm.action =  '/dashboard/fwqProjectSummarySpider.html';
		oFrm.method = "post";
		oFrm.target = 'spiderChartIframe'; 
	    oFrm.submit();		    
	}
	function initAdvanced(){
		var oFrm = document.getElementById("form1");
		//oFrm.pjt_code.value = this.options.dataraw.PJT_CODE;
		//oFrm.pjt_name.value = this.options.dataraw.PJT_NAME;
		oFrm.action =  '/dashboard/fwqProjectSummaryAdvanced.html';
		oFrm.method = "post";
		oFrm.target = 'advancedChartIframe'; 
	    oFrm.submit();		    
	}
	
	function drawAdvanced(){
		var oFrm = document.getElementById("form1");
		//oFrm.pjt_code.value = this.options.dataraw.PJT_CODE;
		//oFrm.pjt_name.value = this.options.dataraw.PJT_NAME;
		oFrm.action =  '/dashboard/fwqProjectSummaryAdvanced.html';
		oFrm.method = "post";
		oFrm.target = 'advancedChartIframe'; 
	    oFrm.submit();		    
	}
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/fwqProjectSummaryJson.html",
			data: $("#form1").serialize(),
			success : function(responseData){
				dataList = responseData.fwqDataList;
				scheduleDataList = responseData.scheduleDataList; 				
				drawTimeLineChart();
				adjustDelay();
			}
		});
	}
	
	function subProjectList(){
		$.ajax({
			url : "/dashboard/fwqSubProjectListJson.html",
			data: $("#form1").serialize(),
			success : function(responseData){
				var projectList = responseData.dataList;
				var sb = [];
				
				$.each(projectList,function(i){
					var checked ="";
					if(i==0) checked="checked";
					sb.push("<div>");
					sb.push("<input type='radio' name='project' value='"+ this.PROJECT +"' "+checked+" />" );
					sb.push("<label><span><span></span></span>");
					sb.push(this.PROJECT);
					sb.push("</label>")
					sb.push("</div>");
				});
				$("[name=projectDiv]").append(sb.join(""));
				$("[name=project]").change(function(){
					getDataByJson();
				});
				
				getDataByJson();
			}
			
		});
	}
	
	function subProjectPoint(){
		$.ajax({
			url : "/dashboard/fwqSubProjectDataJson.html",
			data: $("#form1").serialize(),
			success : function(responseData){
				subProjectList = responseData.dataList;
				drawChartSubPoints();
				buttons();
			}
			
		});
	}
	
	function adjustDelay(){
		
		//DELAY_DT_SUM
		var prePjtId = "";
		for (var i = 0; i < scheduleDataList.length; i++){
			var data = scheduleDataList[i];
			if(prePjtId != scheduleDataList[i].PJT_ID){
				data.DELAY_DT_SUM = 0;
				data.DELAY_DT_SUM += data.DELAY_DT;
				prePjtId = scheduleDataList[i].PJT_ID;
			}else{
				data.DELAY_DT_SUM = scheduleDataList[i-1].DELAY_DT_SUM;
				data.DELAY_DT_SUM += data.DELAY_DT;
			}			
        }
		
		var groupKeys = ['PJT_ID', 'PJT_NAME', 'PHASE_ID', 'PHASE_NAME', 'SUB_PHASE_ID', 'SUB_PHASE_NAME','PJT_STATE_NAME', 'SUB_PHASE_SEQ','PLAN_DT', 'ACTUAL_DT', 'DELAY_DT'];		
		scheduleSeries = getDrillDownDataSeries2(
				'',
				scheduleDataList ,
				groupKeys ,
				[], //filter 
				[], //convert
				'', 
				'CNT',
				{cd: 'PJT_ID', name:'PJT_NAME'},
				{isGroupby:false}
		);	
		
		// delay dt 다시계산	
		// 2016-01-20. subphase단위로 계산하는 경우에만 
		//if($("[name=phaseBase]").val() != undefined && $("[name=phaseBase]").val() == 'subPhase' ){
			$.each(scheduleSeries.series,function(index,s){
				$.each(s.data,function(indexd,data){
					if($.trim(data.ACTUAL_DT) == '' ){
						var preDelayDt = s.data[indexd-1].DELAY_DT;
						var curDelayDt = getDateDiff(data.CUR_DT,data.PLAN_DT);
						if(curDelayDt > preDelayDt){
							data.DELAY_DT = curDelayDt ;
							//data.y = curDelayDt;
						}else{
							data.DELAY_DT = preDelayDt ;
							//data.y = preDelayDt;
						}
						
					}
					
				});
			});
		//}
		
		
		
		var schedules = scheduleSeries.series;		
		if(schedules.length > 0){
			currentShedule = schedules[0].data[schedules[0].data.length-1];
			delayDt = currentShedule.DELAY_DT;
			if($("[name=phaseBase]").val() != undefined && $("[name=phaseBase]").val() == 'phase' ){
				//$("#currentPhase").text(currentShedule.SUB_PHASE_NAME);
				$("#currentPhase").text(currentShedule.CUR_PJT_PHASE_NM);
			}else{
				$("#currentPhase").text(currentShedule.PHASE_NAME + '('+ currentShedule.SUB_PHASE_NAME + ')');
			}
			
			//$("#currentStatus").text(currentShedule.PJT_STATE_NAME);			
			if(currentShedule.PJT_STATE_NAME !='Proceeding'){
				$("#currentStatusSignal").attr("class","");
				$("#currentStatusLabel").text(currentShedule.PJT_STATE_NAME);
				statusHtml = currentShedule.PJT_STATE_NAME;
			}else if(delayDt > 59 && currentShedule.PJT_STATE_NAME !='Drop' && currentShedule.PJT_STATE_NAME !='Hold'){
				$("#currentStatusSignal").attr("class","signal1");
				$("#currentStatusLabel").text(delayDt + ' days delayed');
			}else if(delayDt >0 && delayDt < 60 &&  currentShedule.PJT_STATE_NAME !='Drop' && currentShedule.PJT_STATE_NAME !='Hold'){
				$("#currentStatusSignal").attr("class","signal2");
				$("#currentStatusLabel").text(delayDt + ' days delayed');
			}else{
				$("#currentStatusSignal").attr("class","signal3");
				$("#currentStatusLabel").text('On Schedule');
			}
				
			
		}
			
	}
	
	function drawTimeLineChart(){
		var groupKeys = ['GUBUN','MEASURE_DT'];
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'POINT',convert:'y',isnull:0},{col:'MEASURE_DT',convert:'x',datatype:'date'}], //convert
				'', 
				'POINT',
				{cd: 'GUBUN', name:'GUBUN'},
				{	isGroupby: false
					//, xSortColumn: 'MEASURE_DT' 		
				}
		);
		
		if($('#timeLineChart').highcharts() != undefined) $('#timeLineChart').highcharts().destroy();
		
		$('#timeLineChart').highcharts('StockChart',{
	        chart: {
	            type: 'line'
	        },	        
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'FW Quality Trend ',
            	useHTML: true
	        },
	        exporting: {
	        	 buttons: {
                	contextButton: {
                    	enabled: false
                	}
	        	 }
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	type:'datetime',
	        	labels:{
	        		enabled:false
	        	},
	        	//categories: series.category ,
        		dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            } ,
        		range: 6 * 30 * 24 * 3600 * 1000 ,// six months
        		tickInterval: 30 * 24 * 3600 * 1000, // one months
	        	tickLength: 0
	        },
	        navigator: {
	        	xAxis:{
	        		labels:{
	        			enabled:true
	        		}
	        	}
	        },
	        
	        yAxis: {
	        	
	        	min: 0,
	        	max: 200,
	        	showLastLabel: true,
	        	//tickInterval: 5,
	        	tickLength:0,
	        	//gridLineWidth: 0,
	            title: {
	                text: ''
	            },
	            opposite: false
	            /* ,labels: {
	                formatter: function () {
	                	if(this.value == 175)
	                		return  this.value.toString();
	                	else
	                		return '';
	                }
	            } */
	            
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
	            valueSuffix: '' ,
	            pointFormat:'<span style="color:{series.color}"><b>{point.y:.2f}</b><br/>'
	            /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        legend: {
	        	enabled:false
	        },
	        plotOptions: {
	            line: {
	            	cursor: 'pointer' ,
	                //stacking: 'normal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                lineWidth:3,
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.2f}',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){	   
	                		currentData = e.point.options;
	                		//spiderChartIframe.drawSpiderChart(e.point.options);
	                		initSpider();
	                		drawAdvanced();
                		} 
	                }
	                	
	            }
	           
	        },	        
	        series: series.series
	    },function(chart){
	    	var datas = chart.series[0].data;
	    	var data = datas[datas.length-1];
	    	if(data != undefined){
	    		currentData = data;
	    		//drawLastDataSpiderChart(data);
	    		initSpider();
	    		drawAdvanced();
	    	}
	    		
	    }
	    	
	    	
		);
	}
	
	function drawLastDataSpiderChart(data){
		
		spiderChartIframe.drawSpiderChart(data);
		drawAdvanced();
	}
	
	function drawArchitectureChart(){
		
	}
	
	function displaySchedule(){
		
	}
	
	
	function drawChartSubPoints(){	
		
		var groupKeys = ['PJT_CODE','PROJECT'];
		var series = getDrillDownDataSeries2(
				'',
				subProjectList ,
				groupKeys ,
				[], //filter
				[{col:'POINT',convert:'y',isnull:0}], //convert
				'PROJECT', 
				'POINT',
				{cd: 'GUBUN', name:'GUBUN'},
				{	isGroupby: false
					//, xSortColumn: 'MEASURE_DT' 		
				}
		);
		
		$('#projectPoint').highcharts({
	        chart: {
	            type: 'column'
	            //,zoomType: 'xy'
	        },
	        credits: {
                enabled: false
            },
            exporting:{
            	enabled: false
            },
	        title: {
	        	text: '',
	            style:{
	            	fontSize:'12px',
	            	fontWeight:'bold'
	            }
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	tickLength:0,
	        	categories: series.category
	        },
	        yAxis: {
	        	//min: 0,
	        	max: 200,
	        	tickInterval:25,
	            title: {
	                text: ''
	            },
	            labels: {
	            	formatter:function(){
	            		if(this.value == 50)
	                		return  this.value.toString();
	            		else if(this.value == 80)
	                		return  this.value.toString();
	            		else if(this.value == 100)
	                		return  this.value.toString();
	            		else if(this.value == 150)
	                		return  this.value.toString();
	            		else if(this.value == 200)
	                		return  this.value.toString();
	                	else
	            			return '';
	            	}
	            },
	            gridLineWidth: 1
	        },
	        legend: {
	        	enabled:false
	        },
	        tooltip: {
	            valueDecimals: 0,
	          	//headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            pointFormat: 'point: <b>{point.y:.2f}</b><br/>',
	            shared: true,
	            enabled: false/* ,
	            formatter: function () {
	                var s = '<b>' + this.x + '</b>';

	                $.each(this.points, function () {
	                	if(this.y > 0){
	                		s += '<br/>' + '<span style="color:' + this.series.color + '">' +this.series.name + '</span>: ' + this.y + '';
	                	}
	                    
	                });

	                return s;
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	                //allowPointSelect: true,
	                states: {
	                    select: {
	                        color: '#077AEE' //'red'
	                    }
	                }
	            },
	            column: {
	            	cursor: 'pointer' ,
	                stacking: 'normal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.2f}',
	                    color: 'black'
	                },
	                //allowPointSelect: true,
	               /*  states: {
	                    select: {
	                        fillColor: 'red',
	                        lineWidth: 0
	                    }
	                }, */
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		var category ="";
	                		$("#project").val(e.point.PROJECT);
	                		$("#title_fwQualityDetail").text(e.point.PROJECT);
	        	    		getDataByJson();
	        	    		e.point.select(true,false);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		chart.series[0].data[0].select(true,false);
	    		$("#project").val(subProjectList[0].PROJECT);
	    		$("#title_fwQualityDetail").text(subProjectList[0].PROJECT);
	    		getDataByJson();
		    }
		);
		
	}
	
	function buttons(){
		//var chart = $("#projectPoint").highcharts();
		var width = $(window).width();
		if(buttonRenderer != null)
			buttonRenderer.destroy();
		//if(buttonRenderer == null)
		buttonRenderer = new Highcharts.Renderer($("#buttonContainer")[0],width ,50);
		$("#buttonGuide").remove();
		
		buttonRenderer.label('Guide', width -55 - 80 ,10 )
        .attr({
        	width:80,
        	
        	//'text-anchor':'middle',
            padding: 3,
            dx:10,
            //fill: Highcharts.getOptions().colors[0],
            fill: 'rgba(0, 0, 0, 0.75)',
            r:5,
            id:'buttonGuide'
        })                            
        .css({
            color: 'white',
            cursor:'pointer',//,
            //stroke:'red'
            textAlign: 'center'
        })
        .on('click', function () {
        	//popSchedule();
        	//window.open('http://confluence.skhynix.com/display/FSSW/FW+Quality+Guide','_blank');
        	window.open("http://confluence.skhynix.com/display/FSSW/FW+Quality+Guide", "", "left=300, top = 200, width=1300,height=700resizable=yes, scrollbars=yes, status=yes,menubar=yes");
        })
        .on('mouseover',function(e){
        	/* text = chart.renderer.text('This confluence page could be an informative text', e.layerX - 300, e.layerY - 10)
	        .attr({
	            zIndex: 9999
	        })
	        .css({
	        	overflow: 'visible'
	        })
		    .add();
		
	        var box = text.getBBox();
	        //box surrounding the tool tip text                     
	        border = chart.renderer.rect(box.x - 5, box.y - 5, box.width + 10, box.height + 10, 5)
	            .attr({
	            fill: 'rgba(255, 255, 255, 0.95)',
	            stroke: 'blue',
	                'stroke-width': 1,
	            zIndex: 100
	        })
	        .add(); */
        })
        .on('mouseout', function () {
	        /* text.destroy();
	        border.destroy(); */
	    })
        .add();
	}
	
</script>
</head>
<body>
<form name="form1" id="form1" method="post" >
<input type="hidden" name="version" id="version"  value=""/>
<input type="hidden" name ="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" name ="chartType" value="${param.chartType}"/>
<input type="hidden" name ="phaseBase" value="phase"/>

<input type="hidden" name="className" id="className" value=""/>
<input type="hidden" name="pjt_code" id="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" name="pjt_name" id="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" name ="project"  id ="project" value=""/>

<input type="hidden" name="userId" value="${login_id}"/>
<input type="hidden" name="solution" value="pms"/>


<input type="hidden" name="revision" id="revision"  value=""/>
<input type="hidden" name="category" id="category"  value=""/>
	<div class="pop_window">
		<div class="pop_tit_wrap">
			<!-- <span class="baseline"></span> -->
			<h2 class="pop_tit" style="margin-top:10px;">${param.pjt_name}</h2>
		</div>
		<div id="buttonContainer"></div>
        <div class="pop_con_area" style="padding-top: 3px;"> 
       	   <div class="wrap_b_1" >
       	   		<h3 class="cont_tit">FW Quality Index</h3>
       	   		<div id="projectPoint" style="height: 150px;"></div>
       	   </div>
       	   <div class="wrap_b_2">
	           <h3 class="cont_tit">Schedule</h3>
	           <div id="divCurrrentSchedule" class="dashboard_box" style="height:150px">
	           		<table class="table_hori m_bottom_20" >
	            		<colgroup>
	                  <col width="150">
	                  <col width="150">
	              </colgroup>
	            		<tbody>  		   
	                 <tr class="hori_t_row" id="sh_area_nc">
	                      <th class="txt_center" scope="row">Current Phase</th>
	                      <td id="currentPhase" class="txt_center" scope="row"></th>
	                      
	                      
	                  </tr>		   
	                 <tr class="hori_t_row" id="sh_area_nc">
	                 	  <th class="txt_center">Status</td>
	                      <td id="currentStatusContainer" class="txt_center">
	                      	<span id="currentStatusSignal" style="float: left;"></span><span id="currentStatusLabel"></span>
	                      </td>
	                      
	                  </tr>
	            		</tbody>
	        		</table>
	           </div>
       	   </div>
       	   <div class="wrap_a" style="height:20px;"></div>
           <div class="wrap_a">
               <h3 class="cont_tit">FW Quality Details:&nbsp;<conf id='title_fwQualityDetail'  style="color: blue;display: inline;"></conf> </h3>
			   <!-- <div  name="projectDiv" class="radioDiv"  id="projectDiv" style="" ></div> -->
               <div style="height:270px" class="border_boxAll">
               		<div id="spiderChart" class="dashboard_box border_boxAll" style="height:100%;width: 49%;float:left;border-width: 0 1px 0 0;"><iframe frameborder="0" id="spiderChartIframe" name="spiderChartIframe" src=""></iframe></div>
               		<div id="architectureChart" class="dashboard_box " style="height:100%;width: 49%;float:right;border-left-width: 0;"><iframe frameborder="0" id="advancedChartIframe" name="advancedChartIframe" src=""></iframe></div>
               </div>
               <div id="timeLineChart" class="dashboard_box border_boxAll" style="height:270px;padding-right: 20px;border-top-width: 0;"></div>
               
           </div>
           
       </div> 
    </div>
    <!-- ## //PAGE CONTENTS ##--->	
</form>	
</body>
</html>