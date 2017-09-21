<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>Fwq Division Not Manage</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <!-- <script src="http://www.guriddo.net/demo/js/jquery.min.js"></script> -->
    <script src="/dashboard/js/jquery-number-master/jquery.number.min.js"></script>
    <%-- jqgrid --%>
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
   <script type="text/javascript" src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script> 
    <!-- <script type="text/javascript" src="http://www.guriddo.net/demo/js/trirand/jquery.jqGrid.min.js"></script> -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"/>
	
	
	<%-- http://swebdeveloper.com/apps/forms-plus-css/popup-form-comment.html --%>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/font-awesome.min.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/modern-forms-plus.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/purple.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/cadetBlue.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/orange.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color3.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color4.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/steelBlue.css"/>
  
    <link rel="stylesheet" media="screen" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap.css" type="text/css" />
    <!-- <link rel="stylesheet" media="screen" href="http://www.guriddo.net/demo/css/trirand/ui.jqgrid-bootstrap.css" type="text/css" /> -->
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    <!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script> -->
    
    
    <%-- 2. high charts --%>
    
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<!-- <script src="js/Highstock-2.1.7/js/highstock.src.js"></script> -->
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<!-- <script src="js/Highstock-2.1.7/js/highcharts-more.js"></script> -->
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<script src="js/highcharts/grouped-categories.js"></script>
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<%--
		<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
		<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	 --%>
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.09.15"></script>
	
	<%-- 5. local --%>
	<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="http://www.trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" /> -->
	
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" />
	<script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script>
	
	<link rel="stylesheet" type="text/css" href="/nspim/css/common.css" />
	<link rel="stylesheet" type="text/css" href="/nspim/css/new.css" />
	<link rel="stylesheet" type="text/css" href="/nspim/css/board.css" />
	
	<script src="/common/js/module.js"></script>
	<link rel="stylesheet" type="text/css" href="/common/css/calendar.css" />
	<script type="text/javascript">	
	var projectList = [];
	var pageChart;
	var symbolRenderer;
	 Highcharts.SVGRenderer.prototype.symbols.triangleUp = function (x, y, w, h) {
		 
		 return {
			id:'myTriangle',
			d:[
				'M', x, y,
				'L', x + w, y,
				x + w / 2, y + h,
				'Z'
			]
		 };
     };
     
	Highcharts.SVGRenderer.prototype.symbol = function (symbol, x, y, width, height, options) {
		var symbolSizes ={};
		var obj,
		
		// get the symbol definition function
		symbolFn = this.symbols[symbol],

		// check if there's a path defined for this symbol
		path = symbolFn && symbolFn(
			Math.round(x),
			Math.round(y),
			width,
			height,
			options
		),

		imageElement,
		imageRegex = /^url\((.*?)\)$/,
		imageSrc,
		imageSize,
		centerImage;

	if (path) {

		obj = this.path(path);
		// expando properties for use in animate and attr
		extend(obj, {
			symbolName: symbol,
			x: x,
			y: y,
			width: width,
			height: height
		});
		if (options) {
			extend(obj, options);
			if(options.elementObj != undefined){
				extend(obj.element, options.elementObj);
			}
		}


	// image symbols
	} else if (imageRegex.test(symbol)) {

		// On image load, set the size and position
		centerImage = function (img, size) {
			if (img.element) { // it may be destroyed in the meantime (#1390)
				img.attr({
					width: size[0],
					height: size[1]
				});

				if (!img.alignByTranslate) { // #185
					img.translate(
						Math.round((width - size[0]) / 2), // #1378
						Math.round((height - size[1]) / 2)
					);
				}
			}
		};

		imageSrc = symbol.match(imageRegex)[1];
		imageSize = symbolSizes[imageSrc] || (options && options.width && options.height && [options.width, options.height]);

		// Ireate the image synchronously, add attribs async
		obj = this.image(imageSrc)
			.attr({
				x: x,
				y: y
			});
		obj.isImg = true;

		if (imageSize) {
			centerImage(obj, imageSize);
		} else {
				// Initialize image to be 0 size so export will still function if there's no cached sizes.
				obj.attr({ width: 0, height: 0 });
	
				// Create a dummy JavaScript image to get the width and height. Due to a bug in IE < 8,
				// the created element must be assigned to a variable in order to load (#292).
				imageElement = Highcharts.createElement('img', {
					onload: function () {
						centerImage(obj, symbolSizes[imageSrc] = [this.width, this.height]);
					},
					src: imageSrc
				});
			}
		}
	
		if(options && options.elementObj != undefined){
			extend(obj.element, options.elementObj);
		}

		return obj;
     }
     
     function extend(a, b) {
   		var n;
   		if (!a) {
   			a = {};
   		}
   		for (n in b) {
   			a[n] = b[n];
   		}
   		return a;
   	}
	
	
	
	var fwqDataList = [];
	var scheduleDataList = [];
	var scheduleSeries = {};
	var over60 = [];
	var on = [];
	
	$(function () {
		//pmsProjectList();
		//pmsAllSchedule();
		getDataByJson();
		$( window ).resize(function() {
			//buttons();
		});
	});
	
	var responseData = {};
	
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
				responseData = pResponseData;
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
					getDataByJson();
					//drawchart();
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
		
		getDataByJson();
	}
	
	function pmsAllSchedule(){
		//jQuery.support.cors = true;
		$.ajax({
			url : "/dashboard/pmsScheduleAllJson.html",
			async : false,
			data: {phaseBase: $("#phaseBase").val()},
			success : function(pResponseData){
				scheduleDataList = pResponseData.dataList;
				adjustDelay();
			}
		});
	
	}
	
	function getDataByJson(){
		//jQuery.support.cors = true;
		$.ajax({
			url : "/dashboard/fwqDivisionJson.html",
			data: $("#form").serialize(),
			//type: "POST",
			//crossDomain: true,
			//dataType: 'json',
			success : function(pResponseData){
				fwqDataList = pResponseData.fwqDataList;
				//scheduleDataList = pResponseData.scheduleDataList;
				//mergeFwqSchedule();
				//virtualDelay();
				//drawChart();
				drawGrid();
				
				$("#measure_dt").text("Measure Date: " + Highcharts.dateFormat('%Y-%m-%d',convertDateToUct(maxValue(fwqDataList,"MEASURE_DT")))); 
				
			}
		});
	
	}
	
	function adjustDelay(){
		
		//DELAY_DT_SUM
		var groupKeys = ['PJT_ID', 'PJT_NAME', 'PHASE_ID', 'PHASE_NAME', 'SUB_PHASE_ID', 'SUB_PHASE_NAME','PJT_STATE_NAME', 'SUB_PHASE_SEQ','subPhaseSeqDt','PLAN_DT', 'ACTUAL_DT', 'DELAY_DT'];
		var prePjtId = "";
		sortObjects(scheduleDataList,groupKeys);
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
		$.each(scheduleSeries.series,function(index,s){
			$.each(s.data,function(indexd,data){
				if($.trim(data.ACTUAL_DT) == '' && indexd > 0 ){
					var preDelayDt = s.data[indexd-1].DELAY_DT;
					var curDelayDt = getDateDiff(data.CUR_DT,data.PLAN_DT);
					if(curDelayDt > preDelayDt){
						data.DELAY_DT = curDelayDt ;
						//data.y = curDelayDt;
					}else{
						//data.DELAY_DT = curDelayDt ;
						data.DELAY_DT = preDelayDt ;
						//data.y = preDelayDt;
					}
					
				}
				
			});
		});
		
		
		
	}
	
	/**
	* fwq와 schedule delay를 합친다.
	* 
	**/
	function mergeFwqSchedule(){
		
		$.each(fwqDataList,function(){
			var schedules = dataFilter(scheduleSeries.series,[{col:'id',val:this.PJT_CODE}]);
			this.schedule = schedules;
			if(schedules.length > 0)
				this.DELAY_DT = schedules[0].data[schedules[0].data.length-1].DELAY_DT;
		});
		
	}
	
	function virtualDelay(){
		over60 = [];
		on = [];
		$.each(fwqDataList,function(){
			if(this.DELAY_DT > 60)
				over60.push(this);
			else if(this.DELAY_DT <= 0)
				on.push(this);
		});
		
		var over60Max = maxValue(over60,'DELAY_DT');
		var over60Min = minValue(over60,'DELAY_DT');
		var over60Gap = over60Max - over60Min;
		
		var over60Avg = groupbyAvg(over60,['GUBUN'],'DELAY_DT');
		if(over60Avg.length>0) 
			over60Avg = over60Avg[0].average;
		else 
			over60Avg = 0;
		
		var onMax = maxValue(on,'DELAY_DT');
		var onMin = minValue(on,'DELAY_DT');
		var onGap = onMax - onMin;
		var onAvg = groupbyAvg(on,['GUBUN'],'DELAY_DT');
		if(onAvg.length>0) 
			onAvg = onAvg[0].average;
		else 
			onAvg = 0;
		
		var over60Range = 30;
		var onRange = 30;
		$.each(fwqDataList,function(){
			if(this.DELAY_DT > 60){
				var avg = over60Range/2;
				if(over60Gap == 0)
					this.delayDtVirtual = avg;
				else{
					//var pointPer = over60Range/over60Gap;
					//var scale = over60Gap * 1/ over60Range;
					//var gab = (this.DELAY_DT - over60Min) * scale;
					//this.delayDtVirtual = gab*-1;
					
					//var scale = 30/over60Avg;
					var scale = 30/over60Gap;
					this.delayDtVirtua = (this.DELAY_DT - over60Min) * scale;
					
					/* var gapAvg = this.DELAY_DT - over60Avg;
					if(gapAvg > 0){
						l = (gapAvg*scale*15)/30;
					}else{
						
						this.delayDtVirtual = 15 + (gapAvg*scale*15)/30*-1;
						
					}		 */			
					
				}
				
			}
			else if(this.DELAY_DT <=60 && this.DELAY_DT > 30){
				
				this.delayDtVirtual = over60Range + (60 - this.DELAY_DT);
			}
			else if(this.DELAY_DT <=30 && this.DELAY_DT > 0){
				this.delayDtVirtual = over60Range + 30 +  (30 - this.DELAY_DT) ;
			}
			else if(this.DELAY_DT <= 0){
					var avg = onRange/2;
					var gab = 0;
					if(onGap == 0)
						this.delayDtVirtual = 90 + avg;
					else{
						//var pointPer = onRange/onGap;
						//var scale = onGap * 1/ onRange;
						//var gab = (this.DELAY_DT - onMin) * scale;
						//this.delayDtVirtual = onRange + 60 + gab;
						
						//var scale = Math.abs(30/onAvg);
						var scale = Math.abs(30/onGap);
						this.delayDtVirtual = 90 + Math.abs(this.DELAY_DT - onMax) * scale;
						
						/* var gapAvg = this.DELAY_DT - onAvg;
						
						if(gapAvg > 0){
							this.delayDtVirtual = 90 + 15- (gapAvg*scale*15)/30;
						}else{
							this.delayDtVirtual = 90 + 15 + (gapAvg*scale*15)/30*-1;
							if(this.delayDtVirtual > 120)
								this.delayDtVirtual = Math.floor(this.delayDtVirtual);
						} */
					}
			}
			else{
				
			}
				
		});
		
	}
	
	function drawChart(){		
		//01. series데이타. project
		var dataHigh = new Array();
		
		for (var i = 0; i < fwqDataList.length; i++){
			var preData = {};
			var diff = 0;
			//var symbol ="circle"; 
			var symbol ="url(/dashboard/images/unchange.png)"; 
			var symbolTxtUp ="▲";
			var symbolTxtDown ="▼ ";
			var symbolTxt = '<span style="color:grey">-</span>';
			var symbolHtml = "";
			var fillColor = "yellow";
			
			if( fwqDataList[i].preData != null){
				preData = fwqDataList[i].preData;
			}
			if(preData.POINT != undefined){
				diff = Number(fwqDataList[i].POINT.toFixed(2))  - Number(preData.POINT.toFixed(2)) ;
			}
			
			if(diff > 0 ){
				//symbol = 'triangle';
				//fillColor = 'red';
				symbol = 'url(/dashboard/images/up.png)';
				symbolTxt = '<span style="color: blue">'+symbolTxtUp+'</span>';
			}else if(diff < 0){
				//symbol = 'triangle-down';
				//fillColor = 'blue';
				symbol = 'url(/dashboard/images/down.png)';
				symbolTxt = '<span style="color: red">'+symbolTxtDown+'</span>';
			}
			
			var data =  {
				x: fwqDataList[i].delayDtVirtual ,
				y: fwqDataList[i].POINT,
				
				dataraw: fwqDataList[i],
				dataLabels: {
                    enabled: false,
                    format:'<b>{point.dataraw.PJT_NAME}</b>',
//                     formatter: function() {
//     	               return '<b style="font-size:11px;">'+ this.point.dataraw.PJT_NAME +'</b>';
//     	                //alert('a');
//     	            },
    	            y: - 8
                },
                //symbol
	          	marker:{
	          		symbol: symbol,
	          		width:15,
	          		height:15,
	          		fillColor : 'rgba(255,0,0,1)',
	          		//lineColor : '#000000',
	          		//lineWidth : 1,
	          		elementObj:{
	          			id: fwqDataList[i].PJT_CODE + '-' + fwqDataList[i].MEASURE_DT 
	          		}
// 	          		,states: {
//                         hover: {
//                         	//endabled:true,
//                             //fillColor: fillColor,
//                             //lineColor: '#000000',
//                             //lineWidth: 2
//                             symbol:symbol,
//                             width:33,
//                             height:33
//                         }
//                     }
	          	}  
                
			};
			dataHigh.push(data);
			//dataHigh.push([dataRaw[i].QUALITY ,dataRaw[i].DELIVERY, 300]);
		}
		
		
		$('#container').highcharts({
	        chart: {
	        	//type:'bubble',
	        	zoomType: 'xy',
	        	defaultSeriesType:'scatter',
	        	animation:true,
	            //borderWidth:1,
	            //borderColor:'#ccc',
	            marginLeft: 120,
	            //marginBottom: 100,
	            //marginTop: 100,
	            marginRight: 50,
	            //marginLeft:200,
	            //marginRight:200,
	            //backgroundColor:'#eee',
	            //plotBackgroundColor:'#fff',
	            events:{
	            	redraw: function () {
	            		//symbolText();
	            		symbolTextTimeOut();
	            		//buttons();
	            	}
	            }
				,style: {
	                overflow: 'visible'
	            }
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title:{
	            text:'&nbsp;',
            	useHTML: true
	        },
	        legend:{
	            enabled:false                                
	        },
	        tooltip: {
	            formatter: function() {
	            	var schedules = this.point.dataraw.schedule[0].data;
	            	var phase = schedules[schedules.length-1].SUB_PHASE_NAME;
	                return '<b>'+ this.point.dataraw.PJT_NAME +'</b><br/>'+
	                    'Quality: ' + this.y +' , '+ 'Schedule: ' + phase + '('+ this.point.dataraw.DELAY_DT +')';
	                
	            }
	        },
	        plotOptions: {
	            series: {
	                shadow:false,
	                cursor: 'pointer',
	                animation: {
	                    complete:  function () {
	                    	//alert("complete");
	                    }
	               	},
	                events:{
	                	afterAnimate: function () {
	                    	 //symbolText();
	                		//alert("afterAnimate");
	                		
	                     }
	                },
	                point:{	                	
	                	events:{
	                		click: function(e){
	                			popFWQProjectSummary.call(this);
	                		},
	                		mouseOver: function() {
	                            this.graphic.attr('width', 25);
	                            this.graphic.attr('height', 25);
		                    },
		                    mouseOut: function() {
		                        this.graphic.attr('width', 15);
		                        this.graphic.attr('height', 15);
		                     }
		                     
	                	}
	                	
	                }
	            },
	            scatter:{
	            	marker:{
	            		radius: 7,
	            		states: {
	                        hover: {
	                            enabled: true,
	                            lineColor: 'rgb(100,100,100)'
	                        }
	                    }
	                    
	            	}
	            }
	        },
	        xAxis:{
	            title:{
	                text:'Schedule'
	                , align: 'high'
	                , offset :30
	                
	                
	            },
	            min:0,
	            max:120,
	            tickInterval:30,
	            tickLength:10,
	            
	            //minorTickLength:0,
	            //gridLineWidth:1,
	            //showLastLabel:true,
	            //showFirstLabel:false,
	            //lineColor:'#ccc',
	            //lineWidth:1    
				labels: {
					enabled: true
	                , formatter: function () {
	                	return '';
	                } 
	            	
	            } 
	            , plotBands: [{ 
		                //color: '#FCFFC5',
		                from: 0,
		                to: 30,
		                label: {
			                    text: 'Extremely Delayed<br/>(60 days~) ',
			                    verticalAlign: 'bottom'
			                },
		            	color:'rgba(255,0,0,0.05)'
		            },
		            { // mark the weekend
		                //color: '#FCFFC5',
		                from: 30,
		                to: 60,
		                label: {
		                    text: 'Significantly Delayed<br/>(~60 days) ',
		                    verticalAlign: 'bottom'
		                },
		           		color:'rgba(255,255,0,0.05)'
		            },
		            { // mark the weekend
		                //color: '#FCFFC5',
		                from: 60,
		                to: 90,
		                label: {
		                    text: 'Some Delay<br/>(~30 days) ',
		                    verticalAlign: 'bottom'
		                },
		                color:'rgba(255,255,0,0.05)'
		            },
		            { // mark the weekend
		                //color: '#FCFFC5',
		                from: 90,
		                to: 120,
		                label: {
		                    text: 'On Schedule ',
		                    verticalAlign: 'bottom'
		                },
		                color:'rgba(0,255,0,0.05)'
		            }
	            ]
	        	, plotLines:[
	        		{value: 30,width:1,color: '#000000',dashStyle: 'dash'},
	        		{value: 60,width:1,color: '#000000',dashStyle: 'dash'},
	        		{value: 90,width:1,color: '#000000',dashStyle: 'dash'}
	        	]
	            , events: {
	                afterSetExtremes: function(event){
	                    //if (this.getExtremes().dataMin < event.min)
	                    //	symbolText();//alert("Zoomed in!");
	                    
	                }
	            }
	        },
	        yAxis:{
	            title:{
	                text:'Quality'
	                , rotation:0
	                , margin:25
	                , align: 'high'
		            , offset :0
		            , y: -10
	            },
	            min:0,
	            max:200,
	            tickInterval:5,
	            //tickInterval:10,
	            tickLength:0,
	            minorTickLength:0,
	            lineColor:'#ccc',
	            lineWidth:1     ,
	            gridLineWidth: 0,
	            labels: {
	                formatter: function () {
	                	return '';
	                }
	            }    
	            , plotBands: [{ 
		                //color: '#FCFFC5',
		                from: 0,
		                to: 50,
		                label: {
		                    text: 'Need Improvement<br/>(0~50) ',
		                    textAlign: 'right',
		                    verticalAlign: 'middle',
		                    x: -10
		                }
		            },
		            { 
		                //color: '#FCFFC5',
		                from: 51,
		                to: 80,
		                label: {
		                    text: 'Intermediate<br/>(51~80) ',
		                    textAlign: 'right',
		                    verticalAlign: 'middle',
		                    x: -10
		                }
		            },
		            { 
		                //color: '#FCFFC5',
		                from: 81,
		                to: 100,
		                label: {
		                    text: 'Good<br/>(81~100) ',
		                    textAlign: 'right',
		                    verticalAlign: 'middle',
		                    x: -10
		                }
		            },
		            { 
		                //color: '#FCFFC5',
		                from: 101,
		                to: 150,
		                label: {
		                    text: 'Very Good<br/>(101~150) ',
		                    textAlign: 'right',
		                    verticalAlign: 'middle',
		                    x: -10
		                }
		            },
		            { 
		                //color: '#FCFFC5',
		                from: 151,
		                to: 200,
		                label: {
		                    text: 'Excellent<br/>(151~200) ',
		                    textAlign: 'right',
		                    verticalAlign: 'middle',
		                    x: -10
		                }
		            }
	            ]
	            , plotLines:[
    	        		{value: 50,width:1,color: '#000000',dashStyle: 'dash'},
    	        		{value: 80,width:1,color: '#000000',dashStyle: 'dash'},
    	        		{value: 100,width:1,color: '#000000',dashStyle: 'dash'},
    	        		{value: 150,width:1,color: '#000000',dashStyle: 'dash'},
    	        		{value: 200,width:1,color: '#000000',dashStyle: 'dash'}
    	        	]
	            ,  events: {
	                afterSetExtremes: function(event){
	                    //if (this.getExtremes().dataMin < event.min)
	                    //    alert("Zoomed in!");
	                    //symbolText();
	                }
	            }
	        },
	        series: [{
	            //color:'#185aa9',
	            data: dataHigh //,
	           /*  marker: {
	            	symbol: 'triangle',
	            	elementObj:{
	            		id:'dashboardSymbolText'
	            	},
	               //fillColor: {
	               //     radialGradient: { cx: 0.5, cy: 0.5, r: 0.9 } ,
	               //     stops: [
	               //         [0, 'rgba(100,0,0,1)'],
	               //         [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0.5).get('rgba')]
	               //     ]
	               //} ,
	                style:{
	                	//fontSize: '20px'
	                } 
	            } */
	        }]
	        , navigation: {
	            buttonOptions: {
	                theme: {
	                    // Good old text links
	                    style: {
	                        color: '#039',
	                        textDecoration: 'underline'
	                    }
	                }
	            }
	        }
	        , exporting: {
	            buttons: {
	                contextButton: {
	                    enabled: false
	                }/* ,
	                printButton: {
	                    text: 'Schedule',
	                    onclick: function () {
	                    	popSchedule();
	                    }
	                },
	                exportButton: {
	                    text: 'Quality',
	                    stroke: "#000",
	                    onclick: function () {
	                    	popFWQuality();
	                    	
	                    }
	                } */
	            }
	        }
	    }, function(chart) { // on complete
	    		pageChart = chart;
	    		symbolRenderer = new Highcharts.Renderer(
					    $('.highcharts-markers')[0],2000,2000
				);
				//symbolRenderer = chart.renderer;
	    		 $('.highcharts-markers').resize(function(){
	    			 //symbolText();
	    		 });
	    		
	    		symbolText();
	    		buttons();
			}
		
		);
		
	}
	
	function symbolTextTimeOut(){
		setTimeout(symbolText,500);
	}
	
	function symbolText(){
		//symbol path 리스트를 찾는다.
		//차이를 그린다.
		//symbol path에서 값을 읽어들여 text를 그린다.
		$.each(fwqDataList,function(){
			var id = "symbolText"+this.PJT_CODE+'-'+this.MEASURE_DT;
			var $obj = $("#"+id);
			if($obj.length>0)
				$obj.remove();
		});
		
		$.each(fwqDataList,function(){
			var diff = 0;
			var preData = this.preData;
			if(preData != undefined && preData.POINT != undefined){
				diff = Number(this.POINT.toFixed(2)) - Number(preData.POINT.toFixed(2));
			}
			var symbolPath = $("#"+this.PJT_CODE + '-' + this.MEASURE_DT);
			if(symbolPath.attr("d") != undefined ){
				var x,y;
				if(diff > 0){
					x = Math.round((symbolPath).attr("d").split(" ")[6])+1;
					y = Math.round((symbolPath).attr("d").split(" ")[7]);
				}else {
					x = Math.round((symbolPath).attr("d").split(" ")[1]);
					y = Math.round((symbolPath).attr("d").split(" ")[7]);
				}
				
				if(x != undefined && diff != 0){
					symbolRenderer.text(diff.toFixed(2) + '' , x , y +10).attr("id","symbolText"+this.PJT_CODE+'-'+this.MEASURE_DT).add();
				}
			}else if(symbolPath[0].tagName == 'image'){
				if(diff > 0){
					var xoffset = 2;
					if(diff >= 10) xoffset = 0;
					x = Math.round((symbolPath).attr("x")) + xoffset;
					y = Math.round((symbolPath).attr("y"))+13;
				}else {
					x = Math.round((symbolPath).attr("x"));
					y = Math.round((symbolPath).attr("y"))+13;
				}
				
				if(x != undefined && diff != 0){
					symbolRenderer.text(diff.toFixed(2) + '' , x , y +15)
					.attr("id","symbolText"+this.PJT_CODE+'-'+this.MEASURE_DT)
					.attr("style","font-weight:bolder;font-size:11px")
					.add($(".highcharts-series-group")[0]);
				}
			}
			
		
		});
	}
	
	
	// 창의 크기가 변했을 때 안쪽의 색깔범위를 다시 조정한다.
	function adjustColor(){
		var chart = $('#container').highcharts();
		var width = chart.plotBox.width / 2.0;
        var height = chart.plotBox.height / 2.0 + 1;
        
        //초기화
        $("#colorRect11").remove() ;
        $("#colorRect12").remove() ;
        $("#colorRect21").remove() ;
        $("#colorRect22").remove() ;
       
        //좌상   
        chart.renderer.rect(chart.plotBox.x,                      
                            chart.plotBox.y, width, height, 1)
            .attr({
                fill: 'white',
                zIndex: 0,
                id:'colorRect11'
            })
            .add();
    	//우상
     	chart.renderer.rect(chart.plotBox.x + width,                      
                            chart.plotBox.y, width, height, 1)
            .attr({
                fill: 'lightblue',
                zIndex: 0,
                id:'colorRect12'
            })
            .add();
    	//좌하
    	chart.renderer.rect(chart.plotBox.x,                      
                            chart.plotBox.y + height, width, height, 1)
            .attr({
                fill: 'rgba(255,0,0,0.5)',
                zIndex: 0,
                id:'colorRect21'
            })
            .add();
    	//우하
    	chart.renderer.rect(chart.plotBox.x + width,                      
                            chart.plotBox.y + height, width, height, 1)
            .attr({
                fill: 'white',
                zIndex: 0,
                id:'colorRect22'
            })
            .add();
	}
	
	function drawGrid(){
		sortObjects(fwqDataList,[['POINT','desc']]);
		var setAttrProject = function(rowId, val, rawObject, cm) {
		    //var attr = rawObject.attr[cm.name], result;
			var rownum = parseInt(rowId,10) -1 ;
			var rowspan = 1; 
			var preVal = "";
			var postVal = "";
			var attr = rawObject[cm.name];
			var result = "";
			var style = "";
			
			if(cm.name == 'PJT_NAME_PMS'){
				//style +="background-image:none;background-color:skyblue;";
				//style += " cursor:pointer;";
			}
			if(cm.name != '')
				style += " cursor:pointer;";
			result +=" style=\""+style+"font-weight:bold;\"";
			result +=" title=\""+val+"\"";
			return result;
			
		};
		var setAttr = function(rowId, val, rawObject, cm) {
		    //var attr = rawObject.attr[cm.name], result;
			var rownum = parseInt(rowId,10) -1 ;
			var rowspan = 1; 
			var preVal = "";
			var postVal = "";
			var attr = rawObject[cm.name];
			var result = "";
			var style = "";
			
			if(cm.name == 'PJT_NAME_PMS'){
				//style +="background-image:none;background-color:skyblue;";
				//style += " cursor:pointer;";
			}
			if(cm.name != '')
				style += " cursor:pointer;";
			result +=" style=\""+style+"\"";
			result +=" title=\""+val+"\"";
			return result;
			
		};
		
		var item_formatter = function(cellValue, options, rowObject){
			var result = "";
			if(rowObject[options.colModel.name + '_EXISTS'] == 'Y'){
				//result = cellValue.toFixed(2);
				
				var datalHtml = "";
				var imageHtml = "";
				var labelHtml = "";
				
				var data = dataFilter(fwqDataList,[{col:'PJT_CODE',val:rowObject.PJT_CODE}])[0];
				var preData = {};
				var diff = 0;
				//var symbol ="circle"; 
				var symbol ="/dashboard/images/unchange.png"; 
				var symbolTxtUp ="▲";
				var symbolTxtDown ="▼ ";
				var symbolTxt = '<span style="color:grey"></span>';
				var symbolHtml = "";
				var fillColor = "yellow";
				
				if( data.preData != null){
					preData = data.preData;
				}
				if(preData[options.colModel.name] != undefined){
					diff = Number(data[options.colModel.name].toFixed(2)) - Number(preData[options.colModel.name].toFixed(2));
				}
				
				
				//diff = Number(diff.toFixed(2));
				
				if(diff  > 0 ){
					//symbol = 'triangle';
					//fillColor = 'red';
					symbol = '/dashboard/images/up.png';
					symbolTxt = '<span style="color: blue">'+symbolTxtUp+'</span>';
				}else if(diff < 0.00){
					//symbol = 'triangle-down';
					//fillColor = 'blue';
					symbol = '/dashboard/images/down.png';
					symbolTxt = '<span style="color: red">'+symbolTxtDown+'</span>';
				}
				
				if(Math.abs(diff).toFixed(2) == "0.00")
					diff = 0;
				
				var fontWeight = options.colModel.fontWeight != undefined ? options.colModel.fontWeight : 'normal';
				//dataHtml = '<span style="font-weight:bold">' + rowObject[options.colModel.name].toFixed(options.colModel.formatoptions.decimalPlaces) +'</span>';
				dataHtml = '<span style="font-weight:'+fontWeight+'">' + $.number(rowObject[options.colModel.name],options.colModel.formatoptions.decimalPlaces) +'</span>';
				imageHtml = '<br/><img src="' + symbol + '" style="width:20px;"/>';
				symbolHtml = '<br/>'+symbolTxt + "";
				labelHtml = "<span> ("+  $.number(diff,options.colModel.formatoptions.decimalPlaces) + ")</span>";
				
				
				//result = "<span style='cursor:pointer;'>" + dataHtml + imageHtml + labelHtml + "</span>";
				//result = "<span style='cursor:pointer;'>" + dataHtml + "</span>";
				var cursor = options.colModel.cursor != undefined ? options.colModel.cursor : '';
				result = "<span style='cursor: "+cursor+";'>" + dataHtml + symbolHtml + labelHtml + "</span>";
			}				
			else
				result = 'N/A';
			
			
			return result;
 		}
		
		var gridModel = [
  			{ label: 'Project', name: 'PJT_NAME', width: 210 ,align:'left' , sortable: true, formatter:'string',cellattr:  setAttrProject },
  			//{ label: 'dummy', name: 'POINT', width: 80 ,align:'center', sortable: true, hidden: true},
      		{ label: 'Index<br/>(200)', name: 'POINT', width: 90 ,align:'center', sortable: true, formatter: item_formatter ,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr,fontWeight:'bold' ,cursor:'pointer' },  
      		{ label: 'Loc', name: 'LOC', width:  65 ,align:'center', sortable:false,  formatter: item_formatter ,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 0},cellattr: setAttr,fontWeight:'bold' ,cursor:'pointer' },
      		{ label: 'Static Analysis<br/>(20)', name: 'STATIC_ANALYSIS', width:  65 ,align:'center', sortable:false,  formatter: item_formatter,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr,fontWeight:'bold' ,cursor:'pointer' },
      		{ label: 'Function Parameter<br/>(20)', name: 'FUNC_PARAMETER', width: 70 ,align:'center', sortable:false, formatter: item_formatter,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2}, cellattr: setAttr,fontWeight:'bold'  ,cursor:'pointer' },
      		{ label: 'Function LOC<br/>(20)', name: 'FUNCTION_SIZE', width: 65 ,align:'center', sortable:false , formatter: item_formatter,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr ,fontWeight:'bold' ,cursor:'pointer' },
      		{ label: 'Duplicate Code<br/>(20)', name: 'DUPLICATE', width:  65,align:'center' , sortable:false, formatter: item_formatter,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr,fontWeight:'bold' ,cursor:'pointer'  },
      		{ label: 'Coding Rule<br/>(20)', name: 'CODING_RULE', width:  65 ,align:'center', sortable:false, formatter: item_formatter,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr,fontWeight:'bold' ,cursor:'pointer' },
      		{ label: 'Architecture Analysis<br/>(25)', name: 'ARCHITECTURE', width:  80 ,align:'center', sortable:false,formatter: item_formatter ,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2}, cellattr: setAttr,fontWeight:'bold'  ,cursor:'pointer' },
      		{ label: 'Complexity<br/>(25)', name: 'COMPLEXITY', width:  75,align:'center', sortable:false, formatter:  item_formatter,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr ,fontWeight:'bold'  ,cursor:'pointer' },
      		{ label: 'Simulator Test Coverage<br/>(25)', name: 'CODE_COVERAGE', width: 70,align:'center', sortable:false, formatter: item_formatter,formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr ,fontWeight:'bold'  ,cursor:'pointer' }
      		
      		
      	];
		
		//sortObjects(fwqDataList,[['POINT','desc'],'PJT_NAME_PMS']);
		var options = {
			datatype: "local",
			styleUI : 'Bootstrap',
			colModel: gridModel,
			data: fwqDataList,
			rowNum: 100000, 
			//rowList:[10,20,30,50,100],
			caption:'',
			sortable: true,			
			multiSort: true,
			//sortname: 'POINT desc, PJT_NAME_PMS',
	        //sortorder: 'asc',  
	        emptyrecords: "No records to view",
	        viewrecords: true,
			//rownumbers: true, // show row numbers
	        //multiSort: false,
	        //multiselect: false,
	        width: '100%' ,
	        //width: '1200',
	        height: '600',
	        //pager:'#jqGridPager',
	        //mtype: 'POST',
	        //grouping:true,
			onCellSelect: function (rowId, iCol, content, event) {
				var cm = jQuery("#jqGrid").jqGrid("getGridParam", "colModel");
				if(cm.name != ''){
					var val = Number($('#jqGrid').jqGrid('getCell', rowId, iCol));	
					if(cm[iCol].name == 'PJT_NAME' ){
						var val1 = $('#jqGrid').jqGrid('getCell', rowId, 0);	
						var object = dataFilter(fwqDataList,[{col:'PJT_NAME',val: val1}])[0];
						if(object != undefined){
							popFWQProjectSummary.call(object);
						}
					}else if( cm[iCol].name == 'Phase'  || cm[iCol].name == 'Status'){
						// nothing
					}else {
						//cell click
						var projectName = $('#jqGrid').jqGrid('getCell', rowId, 0);
						var object = dataFilter(fwqDataList,[{col:'PJT_NAME',val: projectName}])[0];
						var label = "";
						if(cm[iCol].label.match(/[\w\s]+/) != null)
							label = cm[iCol].label.match(/[\w\s]+/).join('');
						popFWQProjectCategoryTrend.call(object,cm[iCol].name,label);
					}
					
				}
					
		      }// end onclick
		      ,gridComplete: function () {
			    	var grid = $(this).jqGrid();
			    	//grid.navGrid('#confluencePager', { edit: false, add: false, del: false, search: false, refresh: false, view: false, position: "left", cloneToTop: true  });
			    	//$('#funcParamsPager .ui-paging-pager').hide();
			    	
	 				$('#containerGrid .ui-jqgrid').css("width",'100%');
	 				$('#containerGrid .ui-jqgrid').css("border",'0');
	 				//$('#containerGrid .ui-jqgrid .table-bordered').css("border-left",'1px !important');
	 				$('#containerGrid .ui-jqgrid-view').css("width",'100%');
	 				$('#containerGrid .ui-jqgrid-hdiv').css("width",'100%');
	 				$('#containerGrid .ui-jqgrid-bdiv').css("width",'100%');
	 				$('#containerGrid .ui-jqgrid-pager').css("width",'100%');
	 				
	 				
	 				
	 				//header 색깔조정
	 				/* $("[role='columnheader']").css("background","#EBEB9A");
	 				$("#jqGrid_PJT_NAME_PMS").css("background","skyblue");
	 				//$(".ui-widget-content").css("background-image","none");
	 				$(".ui-jqgrid .ui-jqgrid-sortable").css("cursor","text");
	 				$("#jqgh_jqGrid_PJT_NAME_PMS").css("cursor","pointer");
	 				$("#jqgh_jqGrid_POINT").css("cursor","pointer"); */
	 				
	 				
	 				/* grid.jqGrid('filterToolbar',
						{
							defaultSearch:'cn' ,
			                // JSON stringify all data from search, including search toolbar operators
			                stringResult: true
			                // instuct the grid toolbar to show the search options
			                //searchOperators: false
			            }
					);	 */
	 				
	 				
	 				
			    }
			
		};
		
		try{
			if($("#jqGrid tbody").length >0 ){
				$('#jqGrid').jqGrid('clearGridData');
				$("#jqGrid").jqGrid('setGridParam', options ,true);
				//$("#jqGrid").jqGrid('setGroupHeaders', pModel);
				$('#jqGrid').trigger('reloadGrid');
				
			}else{
				$("#jqGrid").jqGrid(options);
				$('#jqGrid').setGroupHeaders(
		                {
		                    useColSpanStyle: true,
		                    groupHeaders: [
								//{ numberOfColumns: 2, titleText: '' , startColumnName: 'PJT_NAME_PMS' },
		                        { numberOfColumns: 5, titleText: 'Basic Index', startColumnName: 'STATIC_ANALYSIS' },
		                        { numberOfColumns: 3, titleText: 'Advanced Index', startColumnName: 'ARCHITECTURE' }
		                     ]
		                
		                });
			}
		}
		catch(err){
			if(fwqDataList.length == 0) {
				$("#load_jqGrid").text("no data");
			}
		}
		
	}

	function adjustGrid(){
		//$("#jqGrid").jqGrid('setGridWidth',$("#containerGrid").width() - 10);
		
		//$("#jqGrid").jqGrid('setGridHeight',$("#containerGrid").height() - 0);
		//$(".jqgfirstrow").css('height', 0 );		
		
		//$("#containerGrid").height(window.innerHeight - $("#application").height() - $("#container").height() );
	}
	
	function popFWQProjectSummary(){
		//var newWin1 = window.open("FWQualitySummary", "FWQualitySummary", "width=1000,height=870, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes"); 
		// 2016.05.31 ie에서 404 나는 현상수정
		var newWin1 = window.open("", "FWQualitySummary", "width=1000,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		
		var oFrm = document.getElementById("form");
		if(this.options != undefined){
			oFrm.pjt_code.value = this.options.dataraw.PJT_CODE;
			oFrm.pjt_name.value = this.options.dataraw.PJT_NAME_PMS;
		}else{
			oFrm.pjt_code.value = this.PJT_CODE;
			oFrm.pjt_name.value = this.PJT_NAME_PMS;
		}
		
		oFrm.action =  '/dashboard/fwqProjectSummary.html';
		oFrm.method = "post";
		oFrm.target = 'FWQualitySummary'; 
	    oFrm.submit();		
	    newWin1.focus();
	}
	
	function popFWQProjectCategoryTrend(category,label){
		//var newWin1 = window.open("FWQualityProjectCategoryTrend", "FWQualityProjectCategoryTrend", "width=750,height=600, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes"); 
		var newWin1 = window.open("", "FWQualityProjectCategoryTrend", "width=750,height=600, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		
		var categoryMap = {
				
		};
		
		
		var oFrm = document.getElementById("form");
		oFrm.pjt_code.value = this.PJT_CODE;
		oFrm.pjt_name.value = this.PJT_NAME;
		oFrm.category.value = category;
		oFrm.categoryLabel.value = label;
		oFrm.action =  '/dashboard/fwqProjectCategoryTrend.html';
		oFrm.method = "post";
		oFrm.target = 'FWQualityProjectCategoryTrend'; 
	    oFrm.submit();		 
	    newWin1.focus();
	}
	
	function popFWQuality(){
		//var newWin1 = window.open("FWQuality", "FWQuality", "width=1000,height=870, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes"); 
		var newWin1 = window.open("", "FWQuality", "width=1200,height=870, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		
		var oFrm = document.getElementById("form");
		//oFrm.pjt_code.value = this.options.dataraw.PJT_CODE;
		//oFrm.pjt_name.value = this.options.dataraw.PJT_NAME;
		oFrm.action =  '/dashboard/fwqMetric.html';
		oFrm.method = "post";
		oFrm.target = 'FWQuality'; 
	    oFrm.submit();		    
	    newWin1.focus();
	}
	
	function popSchedule(){
		//var newWin1 = window.open("PmsSchedule", "PmsSchedule", "width=1200,height=870, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		var newWin1 = window.open("", "PmsSchedule", "width=1200,height=870, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		
		var oFrm = document.getElementById("form");
		//oFrm.pjt_code.value = this.options.dataraw.PJT_CODE;
		//oFrm.pjt_name.value = this.options.dataraw.PJT_NAME;
		oFrm.action =  '/dashboard/pmsSchedule.html';
		oFrm.method = "post";
		oFrm.target = 'PmsSchedule'; 
	    oFrm.submit();	
	    newWin1.focus();
	}
	function fn_close(){
		window.close();
	}	
	</script>
	<style type="text/css">
		html, body,form {
	       height: 1600px;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow:hidden;
	        /* line-height: 1.3em; */
	        font-size:11px;
			/* font-family:'Malgun Gothic', arial, dotum, gulim; */
	     }
		
		.container{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			/* width: 100%;
			height: 850px; */			
			width: 960px;
			height: 590px;
			margin-left: 0px;
			margin-right: 0px;
		}	
		
		.containerGrid{
			position: relative;
			min-height: 1px;
			margin-top: 3px;
			padding-left: 10px;
			padding-right: 0;
			/* width: 100%; */
			/* height: 400px; */
			/* width: 960px; */
			/* height: 590px; */
		}			
		
		.divlabel{
			margin-top: 0px;
			margin-left: 10px;
			font-weight: bold;
			font-size: 13px;
		}
		
		.div-search{
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
		
		.modern-p-form{
			font-size:11px;
			font-family:inherit;
		}
		
		
		#loader {
		  position: absolute;
		  left: 50%;
		  top: 50%;
		  z-index: 1;
		  width: 150px;
		  height: 150px;
		  margin: -75px 0 0 -75px;
		  border: 16px solid #f3f3f3;
		  border-radius: 50%;
		  border-top: 16px solid #3498db;
		  width: 120px;
		  height: 120px;
		  -webkit-animation: spin 2s linear infinite;
		  animation: spin 2s linear infinite;
		}
		
		@-webkit-keyframes spin {
		  0% { -webkit-transform: rotate(0deg); }
		  100% { -webkit-transform: rotate(360deg); }
		}
		
		@keyframes spin {
		  0% { transform: rotate(0deg); }
		  100% { transform: rotate(360deg); }
		}
		
		/* Add animation to "page content" */
		.animate-bottom {
		  position: relative;
		  -webkit-animation-name: animatebottom;
		  -webkit-animation-duration: 1s;
		  animation-name: animatebottom;
		  animation-duration: 1s
		}
		
		@-webkit-keyframes animatebottom {
		  from { bottom:-100px; opacity:0 } 
		  to { bottom:0px; opacity:1 }
		}
		
		@keyframes animatebottom { 
		  from{ bottom:-100px; opacity:0 } 
		  to{ bottom:0; opacity:1 }
		}
		
		.btn_n2 {
		 	width: 100px;		 	
		}
		
		.btn_n2:hover {
			width: 100px;
			cursor: pointer;
			text-decoration: none;
		}
		
		.btn_n2:active {
		  width: 100px;
		}
		
		<%-- 탭뷰--%>
		a:hover,a:focus{
		    text-decoration: none;
		    outline: none;
		    cursor: pointer;
		}
		.nav-tabs {
		    border-bottom: 1px solid #e4e4e4;
		}
		.nav-tabs > li{
		    margin-right: 1px;
		}
		.nav-tabs > li > a{
		    border-radius: 0px;
		    border: 1px solid #e4e4e4;
		    border-right: 0px none;
		    margin-right: 0px;
		    padding: 8px 17px;
		    color:#222222;
		    transition: all 0.3s ease-in 0s;
		}
		.nav-tabs > li:last-child{
		    border-right:1px solid #ededed;
		}
		.nav-tabs > li > a{
		    /* padding: 15px 30px; */
		   /*  padding: 4px 6px; */
		    border:1px solid #ededed;
		    border-right: 0px none;
		    border-top: 2px solid #ededed;
		    background: #ededed;
		    color: #8f8f8f;
		    font-weight: bold;
		}
		.nav-tabs > li > a:hover{
		    border-bottom-color: #ededed;
		    border-right: 0px none;
		    background: #f1f1f1;
		    color: #444;
		}
		.nav-tabs > li.active > a,
		.nav-tabs > li.active > a:focus,
		.nav-tabs > li.active > a:hover{
		    border-top: 2px solid #3498db;
		    border-right: 0px none;
		    color: #444;
		}
		.tab-content > .tab-pane{
		    border: 1px solid #e4e4e4;
		    border-top: 0px none;
		    /* padding: 20px; */
		   /*  padding: 20px; */
		    line-height: 22px;
		}
		.tab-content > .tab-pane > h3{
		    margin-top: 0;
		}
		
		
		<%-- jqGrid--%>
		.ui-jqgrid .ui-jqgrid-htable {
			border-top: 1px solid #ddd;
			border-left: 1px solid #ddd !important;
		}
		.ui-jqgrid .ui-jqgrid-btable {
			border-left: 1px solid #ddd !important;
		}
		/* .table>tbody>tr>td{
			padding: 3px;
		} */
		
		<%--
		/* chart가 숨김시 작아지는 현상 없앰 */
		
		.tab-content > .tab-pane,
		.pill-content > .pill-pane {
		    display: block;    
		    height: 0;          
		    overflow-y: hidden; 
		}
		
		.tab-content > .active,
		.pill-content > .active {
		    height: auto;       
		} 
		--%>
		
		.tab-content .ui-th-column{
			text-align: center;
		}
		
		/***  jqgrid Header   ***/
		.ui-jqgrid-hdiv th {
			text-align: center;
		}
		
		<%-- group headers  --%>
		.ui-jqgrid .ui-jqgrid-labels th.ui-th-column-header {
    	    background-color: #e5e5e5;
    	    background-image: none
    	}
    	
    	.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {
    	    background-color: #f5f5f5;
    	    background-image: none
    	}
    	
    	.ui-jqgrid .ui-jqgrid-htable th div {
			height:auto;
			overflow:hidden;
			padding-right:4px;
			padding-top:2px;
			position:relative;
			vertical-align:text-top;
			white-space:normal !important;
			}
		th.ui-th-column div{
	        white-space:normal !important;
	        height:auto !important;
	        padding:2px;
	    }
	    input[type="text"], input[type="password"]{
	    	height: 34px;
	    }
	    
	    .table>tbody>tr>td{
			padding: 7px;
		}
		
		/* #searchCondition h3{
			font-size: 1px;
		} */
		
		
		.tit_btn {
		    position: relative;
		}
	    .m_top_10 {
		    margin-top: 10px;
		}
		
		.tab_2depth {
		    border-bottom: 1px solid #e1e2e6;
		    border-collapse: collapse;
		    position: relative;
		    height: 25px;
		}
		ol, ul {
		    list-style: none;
		}
		
		.tab_2depth li {
		    display: inline-block;
		    list-style: none;
		    float: left;
		    overflow: hidden;
		    text-align: center;
		    margin-right: 3px;
		}
		.tab_2depth li a {
		    height: 24px;
		    display: block;
		    line-height: 24px;
		    overflow: hidden;
		}
		.tab_2depth .on {
		    border: 1px solid #fb6c07;
		    background: #fc8939;
		}
		.tab_2depth .on a {
		    color: #fff;
		    padding: 0 25px;
		}
		.tab_2depth .off {
		    border: 1px solid #e1e2e6;
		    background: #edeef3;
		}
		.tab_2depth .off a {
		    color: #a4a7a9;
		    padding: 0 25px;
		}
		
		.table>tbody>tr>td {
			/* line-height: 4em; */
		}
	</style>
	<style type="text/css" title="nspmstyle">
		
		
		.pop_window .pop_tit_wrap {
		    position: relative;
		    height: 50px;
		    padding: 0 15px 0 20px;
		    background-color: #2e3441;
		}
		
		.pop_window .pop_con_area {
		    padding: 20px 30px;
		    overflow: auto;
		    background-color: #ffffff;
		}
		
		.pop_window .pop_tit {
		    font-size: 18px;
		    font-weight: bold;
		    color: #ffffff;
		    line-height: 1.33em;
		    display: inline-block;
		    vertical-align: middle;
		}
	
		.cont_tit{font-size:15px; display:block; color:#000; text-align:left; padding-bottom:12px; position:relative; background:url(/nspim/images/board/bullet.gif) no-repeat left 1px; padding-left:18px}
		.cont_tit {float:none}
		
		<%--  table style--%>
		.table_hori {
		    width: 100%;
		    table-layout: fixed;
		    border-collapse: collapse;
		    border-top: 1px solid #fc5d57;
		    border-left: 1px solid #e1e2e6;
		    border-right: 1px solid #e1e2e6;
		}
		
		.table_hori th {
		    background: rgba(245,246,250,0.6);
		    color: #000;
		    /* background: #f5f6fa; */
		    height: 20px;
		    padding: 5px 10px;
		    overflow: hidden;
		    border: 1px solid #e1e2e6;
		    font-weight: normal;
		}
		
		.table_hori td {
		    height: 20px;
		    padding: 5px 10px;
		    border: 1px solid #e1e2e6;
		    word-wrap: break-word;
		    table-layout: fixed;
		    line-height: 160%;
		    color: #000;
		}
		.cont_tit {
		    padding-bottom: 3px;
		}
		
		.txt_right {
		    text-align: right;
		}
		<%--//  table style--%>
	
	</style>

</head>
<body>
<form name="form" id="form">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" name="PMS_ROLE" id="PMS_ROLE" value="${param.PMS_ROLE}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value=""/> 
<input type="hidden" id="pjt_name" name="pjt_name" value=""/>
<input type="hidden" id ="phaseBase" name ="phaseBase" value="phase"/>
<input type="hidden" id="category" name="category" value=""/>
<input type="hidden" id="categoryLabel" name="categoryLabel" value=""/>
<input type="hidden" id="notProject" name="notProject" value="Y"/>
	<div class="pop_window">
		<div class="pop_tit_wrap">
			<!-- <span class="baseline"></span> -->
			<h2 class="pop_tit" style="margin-top:10px;">Firmware Quality (Non-Project)</h2>
		</div>
		
       <div class="pop_con_area" style="padding-top: 3px;"> 
			<div id="contents" class="wrap_a" >
       	   		<div id="measure_dt" class="divlabel">2017.08.29</div>
				<div id="containerGrid" class="containerGrid">
					<table id="jqGrid"></table> 
				    <!-- <div id="jqGridPager"></div> --> 
				</div>
       	   </div>  
       	  
       	   <div class="btn_section">
	            <div class="right_section">
	            	
	                  <a href="#"  id="goDatail" class="btn_txt btn_type_e btn_color_c" onclick="fn_close();return false;">
	                      <span class="name">
	                          <span class="txt">Close</span>
	                      </span>
	                  </a>	                  
	            </div>
        	</div>         
       </div> 
       
    </div>
    <div id="dialog-confirm"></div>	



</form>
<iframe id="devFrame" name="devFrame" width="0" height="0"></iframe>
</body>
</html>
