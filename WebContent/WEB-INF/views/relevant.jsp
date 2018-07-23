<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!doctype html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>PMS Controller Map</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    <!-- <script type="text/javascript" src="js/jqGrid/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="js/jqGrid/i18n/grid.locale-kr.js"></script> -->
    
    <%-- 2. high charts --%>    
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<!-- <script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
 -->	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. treetable --%>
	<script src="/dashboard/js/jquery-treetable/jquery.treetable.js"></script>
	<script src="/dashboard/js/jquery-treetable/bower_components/jquery-ui/ui/jquery.ui.core.js"></script>
    <script src="/dashboard/js/jquery-treetable/bower_components/jquery-ui/ui/jquery.ui.widget.js"></script>
    <script src="/dashboard/js/jquery-treetable/bower_components/jquery-ui/ui/jquery.ui.mouse.js"></script>
    <script src="/dashboard/js/jquery-treetable/bower_components/jquery-ui/ui/jquery.ui.draggable.js"></script>
    <script src="/dashboard/js/jquery-treetable/bower_components/jquery-ui/ui/jquery.ui.droppable.js"></script>
	<link rel="stylesheet" href="/dashboard/js/jquery-treetable/css/screen.css" media="screen" />
    <link rel="stylesheet" href="/dashboard/js/jquery-treetable/css/jquery.treetable.css" />
    <link rel="stylesheet" href="/dashboard/js/jquery-treetable/css/jquery.treetable.theme.default.css" />
    <%-- 6. svgDraw --%>
    <!-- <script src="/dashboard/js/svgDraw/svgDraw.js"></script> -->
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<!-- <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css"> -->
	
	<script type="text/javascript">
	var labelColor = {
			P3C: '#000',
			P4C: '#000',
			P5C: '#000',
			P6C: '#000',
			P6S: '#000',
			P7C: '#000',
			P7S: '#000',
			P8C: '#fff',
			P8S: '#fff',
			P9C: '#fff',
			P9S: '#fff',
			P10C: '#fff',
			Execute:'#fff',
			Terminate: '#fff',
			Termination: '#fff'	,
			Hold: '#000',
			Drop: '#000'
	};
	
	Highcharts.Relevant = function (options, callback) {
	    var defaultOptions = {
	        chart: {
	            renderTo: (options.chart && options.chart.renderTo) || this,
	            backgroundColor: null,
	            borderWidth: 0,
	            type: 'bar',
	            margin: [-14, 0, -14, -10],
	            //width: 600,
	            height: 30,
	            style: {
	                overflow: 'visible'
	            },
	            skipClone: true
	        },
	        exporting:{buttons:[]} ,
	        title: {
	            text: ''
	        },
	        credits: {
	            enabled: false
	        },
	        xAxis: {
	            labels: {
	                enabled: false
	            },
	            title: {
	                text: ''
	            },
	            startOnTick: false,
	            endOnTick: false
	            ,tickPositions: [1]
	            ,tickLength :0
	        },
	        yAxis: {
	        	type: 'datetime',
	            endOnTick: false,
	            startOnTick: false,
	            labels: {
	                enabled: false
	            },
	            title: {
	                text: null
	            }
	            ,tickPositions: [1]
	            ,tickLength :0
	            
	        },
	        legend: {
	            enabled: false
	        },
	        tooltip: {
	        	enabled:true ,
	            backgroundColor: null,
	            borderWidth: 0,
	            shadow: false,
	            useHTML: true,
	            hideDelay: 0,
	            shared: false,
	            padding: 0,
	            positioner: function (w, h, point) {
	                return { x: point.plotX - w , y: point.plotY - h};
	            }
	           ,formatter: function() {
	                //console.log(this.point);
	                var point = this.point;
	                
	                var diff = (point.y - point.low)/(1000 * 60 * 60 * 24);
	                /* if(diff < 30){
	                	 return this.point.SUB_PHASE_NAME + ': ' + Highcharts.dateFormat('%y/%m/%d', point.low) + ' ~ ' +  Highcharts.dateFormat('%y/%m/%d', point.yOrigin);
	                }
	                else{
	                	//return this.point.SUB_PHASE_NAME + ': ' + Highcharts.dateFormat('%y/%m/%e', point.low) + ' ~ ' +  Highcharts.dateFormat('%y/%m/%e', point.yOrigin);
	                	return false;
	                } */
	                
	                var pointHeight =  this.point.shapeArgs.height;
                	/* if(this.series.index == 0 && pointHeight < 60){
                		 return this.point.SUB_PHASE_NAME + ': ' + Highcharts.dateFormat('%y/%m/%d', point.low) + ' ~ ' +  Highcharts.dateFormat('%y/%m/%d', point.yOrigin);
                	}else if(this.series.index > 0 && pointHeight < 70){
                		return this.point.SUB_PHASE_NAME + ': ' + Highcharts.dateFormat('%y/%m/%d', point.low) + ' ~ ' +  Highcharts.dateFormat('%y/%m/%d', point.yOrigin);
                	}*/
	                if(this.series.index == 0 && pointHeight >= 130){
	               		 return false;
	               	}else if(this.series.index == 0 || pointHeight < 50){
                		return this.point.SUB_PHASE_NAME + ': ' + Highcharts.dateFormat('%y/%m/%d', point.low) + ' ~ ' +  Highcharts.dateFormat('%y/%m/%d', point.yOrigin);
                	}
                	else{
                		return false;
                	}
	               
	            }
	        },
	        plotOptions: {
	            /*series: {
	                animation: false,
	                lineWidth: 1,
	                shadow: false,
	                states: {
	                    hover: {
	                        lineWidth: 1
	                    }
	                },
	                marker: {
	                    radius: 1,
	                    states: {
	                        hover: {
	                            radius: 2
	                        }
	                    }
	                },
	                fillOpacity: 0.25
	            },*/
	            bar: {
	            	grouping:false
	            	//,edgeWidth: 1
	            	//,groupZPadding: 0
	            	//,groupPadding: 0
	            	//,borderWidth:1
	            	,borderColor:'#aaa'
	            	,dataLabels: {
	                    enabled: true,
	                    //color: '{point.series.labelColor}',
	                    inside:true,
	                    //format:'{point.options.SUB_PHASE_NAME}<br/> ~ {point.y:%y/%m/%d}',
	                    align:'right' ,
	                    verticalAlign:'top',
	                    y:-3,
	                    style: {
	                        fontWeight: 'bold',
	                        fontSize: '10px'
	                    },
	                    //useHTML:false,
	                    id:'{point.options.SUB_PHASE_NAME}',
	                    formatter: function(){
	                    	var rtn = '';
	                    	var diff = (this.point.y - this.point.low)/(1000 * 60 * 60 * 24);
	                    	
	                    	/* if(diff >= 30){
	                    		rtn += '<span id="spanSeries" style="color:' + labelColor[this.point.series.name] + '" >';
	                    		rtn += ''+this.point.SUB_PHASE_NAME;
	                    		rtn += '</span>';
		                    	rtn += '<br>';
		                    	rtn += '<span style="color:' + labelColor[this.point.series.name] + '">';
		                    	if(this.series.index == 0){
	                    			rtn += Highcharts.dateFormat('%y/%m/%d', this.point.low);
	                    		}
		                    	rtn += ' ~ ';
		                    	rtn += Highcharts.dateFormat('%y/%m/%d', this.point.yOrigin);
		                    	rtn += '</span>';
	                    	} */
	                    	var pointHeight =  this.point.shapeArgs.height;
	                    	var tdSchedule = $('td:regex(id,schedule_'+this.point.series.options.path+'$)');
	                    	if(this.series.index == 0 ){
	                    		//pointHeight = this.point.shapeArgs.y - tdSchedule.offset().left; 
	                    	}
	                    	
	                    	/* if(this.series.index == 0 && pointHeight >= 140){
	                    		rtn += '<span style="color:' + labelColor[this.point.series.name] + '" >';
	                    		rtn += ''+this.point.SUB_PHASE_NAME;
	                    		rtn += '</span>';
		                    	rtn += '<br>';
		                    	rtn += '<span style="color:' + labelColor[this.point.series.name] + '">';
	                    		rtn += Highcharts.dateFormat('%y/%m/%d', this.point.low);
		                    	rtn += ' ~ ';
		                    	rtn += Highcharts.dateFormat('%y/%m/%d', this.point.yOrigin);
		                    	rtn += '</span>';
		                    
	                    	}else if(this.series.index == 0 && pointHeight >= 60){
	                    		rtn += '<span style="color:' + labelColor[this.point.series.name] + '" >';
	                    		rtn += ''+this.point.SUB_PHASE_NAME;
	                    		rtn += '</span>';
		                    	rtn += '<br>';
		                    	rtn += '<span style="color:' + labelColor[this.point.series.name] + '">';
	                    		rtn += Highcharts.dateFormat('%y/%m/%d', this.point.low);
		                    	rtn += ' ~ ';
		                    	rtn += Highcharts.dateFormat('%y/%m/%d', this.point.yOrigin);
		                    	rtn += '</span>';
		                    
	                    	}
	                    	else */ 
	                    	if(this.series.index == 0 && pointHeight >= 130){
	                    		rtn += '<span style="color:' + labelColor[this.point.series.name] + '" >';
	                    		rtn += ''+this.point.SUB_PHASE_NAME;
	                    		rtn += '</span>';
		                    	rtn += '<br/>';
		                    	rtn += '<span style="color:' + labelColor[this.point.series.name] + '">';
	                    		rtn += Highcharts.dateFormat('%y/%m/%d', this.point.low);
		                    	rtn += ' ~ ';
		                    	rtn += Highcharts.dateFormat('%y/%m/%d', this.point.yOrigin);
		                    	rtn += '</span>';
		                    
	                    	}else if(pointHeight >= 50){
	                    		rtn += '<span style="color:' + labelColor[this.point.series.name] + '" >';
	                    		rtn += ''+this.point.SUB_PHASE_NAME;
	                    		rtn += '</span>';
		                    	rtn += '<br/>';
		                    	rtn += '<span style="color:' + labelColor[this.point.series.name] + '">';
		                    	rtn += ' ~ ';
		                    	rtn += Highcharts.dateFormat('%y/%m/%d', this.point.yOrigin);
		                    	rtn += '</span>';
	                    	}else if(pointHeight >= 30){
	                    		rtn += '<span style="color:' + labelColor[this.point.series.name] + '" >';
	                    		rtn += ''+this.point.SUB_PHASE_NAME;
	                    		rtn += '</span>';
	                    	}
	                    	
	                    	return rtn;
	                    },
	                    inside:true
	                    
	            	}
	            },
	            column: {
	                negativeColor: '#910000',
	                borderColor: 'silver'
	            }
	        }
	    };
	    options = Highcharts.merge(defaultOptions, options);

	    return new Highcharts.Chart(options, callback);
	};
	</script>
	
	<script type="text/javascript">
	var relevantList = [];
	var scheduleList = [];
	var holds = [];
	var spec = [];
	$(function () {
		 $("#svg1").attr("height", "0");
		 $("#svg1").attr("width", "0");
		//projectListByAjax();
		//drawChart();
		getDataRelevant();
	});		
	
	$(window).resize(function () {
	    // reset svg each time 
	    $("#svg1").attr("height", "0");
	    $("#svg1").attr("width", "0");
	    connectSVGRelevantPath();
	});
	
	function getDataRelevant(){
		
		$.ajax({
			//type: "POST",
			async: true,
			url : "/dashboard/relevantJson.html",
			data: $("#form1").serialize(),
			success : function(responseData){
				relevantList = responseData.relevantList;
				scheduleList = responseData.scheduleList;
				spec = responseData.spec;
				holds = responseData.holds;
				
				controllerInfo();
				drawRelevantList();
			}
		});
	}
	
	function controllerInfo(){
		var data = dataFilter(spec,[{col:'CODE_NAME',val:'Controller_Name'},{col:'REP_YN',val:'N'}]);
		if(data.length>0){
			$("#controllerMapName").text(data[0].CODE_VALUE_NAME);
		}
	}
	function drawRelevantList(){				
		
		
		$.each(relevantList,function(){
			drawTableRow.call(this);
			drawPhaseSchedule.call(this);			
		});	
		setTreeTable();
		drawSVGRelevantLines();
		//$("body").html($("body").html());
		//$("#svgContainer").html($("#svgContainer").html());
		$(window).trigger('resize');
		if("${param.pjt_id}".length > 0){
			$("body").css("overflow","hidden");
		}
	}
	
	function drawTableRow(){
		var pathCopy = this.PATH;
		var pathCopySplit = pathCopy.split("/");
		pathCopySplit.pop(); // 마지막 element삭제
		
		var cls = "";
		if(this.RELEVANT == 'mother'){
			cls = "relevant_mother";
		}
		if(this.RELEVANT == 'revision'){
			cls = "relevant_revision";
		}else if(this.RELEVANT =='child'){
			cls = "relevant_child";
		}
		
		var state = dataFilter(scheduleList,[{col:'PJT_ID',val:this.PJT_ID}])[0].PJT_STATE_NAME;
		if(state == undefined){
			state = '';
		}
		
		var tr = '<tr id="'+this.PATH+'" data-tt-id="'+this.PATH+'" data-tt-parent-id="'+pathCopySplit.join("/")+'">'; 
		tr += '<td class="tdFirst"><span class="'+ cls +'">'+ this.PJT_NAME + '</span><span class="pull-right" >['+ state + ']</span><div style="clear:both;"></div></td>';
		tr += '<td id="schedule_'+this.PATH+'">'+ '' + '</td>';
		tr += '</tr>';
		$('#table-sparkline > tbody:last-child').append(tr);
	}
	
	
	
	Array.prototype.insert = function(index) {
	    index = Math.min(index, this.length);
	    arguments.length > 1
	        && this.splice.apply(this, [index, 0].concat([].pop.call(arguments)))
	        && this.insert.apply(this, arguments);
	    return this;
	};
	// ["a", "b", "c", "d"].insert(2, "V", ["W", "X", "Y"], "Z").join("-");
	
	function drawPhaseSchedule(){
		var scheduleList1 = $.extend(true, [], scheduleList );
		
		
		// drawchart		
		var groupKeys = ['PJT_ID','PJT_NAME','START_DATE','END_DATE','SUB_PHASE_ID','SUB_PHASE_NAME','ORDER_NUM'];
		var series = getDrillDownDataSeries2(
				'',
				scheduleList1 ,
				groupKeys ,
				[{col:'PJT_ID',val: this.PJT_ID}],
				[{col:'START_DATE', convert:'low',datatype:'date'},{col:'END_DATE', convert:'y', datatype:'date',isnull:null}],
				'PJT_ID',
				'TAT',
				{cd: 'SUB_PHASE_ID', name:'SUB_PHASE_NAME'},
				{isGroupby:false}
		);
		var series1 =[];
		var path = this.PATH;
		$.each(series.series,function(index,s){
			/**** Hold ********/
			// 01. Hold 데이타가 있는지
			var isHold = false;
			var firstData = s.data[0];
			var vholds = dataFilter(holds,[{col:'PJT_ID',val:firstData.PJT_ID},{col:'PJT_PHASE_ID',val:firstData.SUB_PHASE_ID}]);
			sortObjects(vholds,['START_DATE']);
			if(vholds.length> 0)
				isHold = true;
			// 02. merge schedule with hold
			if(isHold){
				var delS = series.series.splice(index,1)[0];
				var scheduleHolds = [];
				//var scheduleHolds1 = [];
				
				var firstSchedule = $.extend(true, {}, firstData );
				firstSchedule.START_DATE = firstSchedule.START_DATE.replace(/-/g,'');
				firstSchedule.low = convertDateToUct(firstSchedule.START_DATE);
				scheduleHolds.push(firstSchedule);
				series.series.insert(index,{
					id: firstSchedule.SUB_PHASE_ID,
					name: firstSchedule.SUB_PHASE_NAME,
					color: delS.color,
					data: [firstSchedule],
					labelColor:  labelColor[delS.name],
					path : path
				});
				series1.push({
					id: firstSchedule.SUB_PHASE_ID,
					name: firstSchedule.SUB_PHASE_NAME,
					color: delS.color,
					data: [firstSchedule],
					labelColor:  labelColor[delS.name],
					path : path
				});
				$.each(vholds,function(holdIndex,hold){
					//01. 이젼의 end_date수정
					scheduleHolds[scheduleHolds.length-1].END_DATE = hold.START_DATE.replace(/-/g,'');
					scheduleHolds[scheduleHolds.length-1].y = convertDateToUct(dateAdd(hold.START_DATE.replace(/-/g,''),1));
					scheduleHolds[scheduleHolds.length-1].yOrigin = convertDateToUct(hold.START_DATE.replace(/-/g,''));
					//02. hold
					var holdSchedule = $.extend(true, {}, firstSchedule );
					holdSchedule.START_DATE = hold.START_DATE.replace(/-/g,'');
					holdSchedule.low = convertDateToUct(holdSchedule.START_DATE);
					holdSchedule.END_DATE = hold.END_DATE.replace(/-/g,'');
					holdSchedule.y = convertDateToUct(holdSchedule.END_DATE);
					holdSchedule.yOrigin = convertDateToUct(holdSchedule.END_DATE);
					holdSchedule.SUB_PHASE_NAME = 'Hold';
					scheduleHolds.push(holdSchedule);
					series.series.insert(index + holdIndex + 1,{
						id: holdSchedule.SUB_PHASE_ID + holdIndex,
						name: holdSchedule.SUB_PHASE_NAME ,
						color: phaseColor['Hold'],
						data: [holdSchedule],
						labelColor:  labelColor['Hold'],
						path : path
					});
					series1.push({
						id: holdSchedule.SUB_PHASE_ID + holdIndex,
						name: holdSchedule.SUB_PHASE_NAME ,
						color: phaseColor['Hold'],
						data: [holdSchedule],
						labelColor:  labelColor['Hold'],
						path : path
					});
					//03. next
					var nextSchedule = $.extend(true, {}, firstData );
					nextSchedule.START_DATE = hold.END_DATE.replace(/-/g,'');
					nextSchedule.low = convertDateToUct(nextSchedule.START_DATE);
					nextSchedule.SUB_PHASE_NAME = firstData.SUB_PHASE_NAME;
					scheduleHolds.push(nextSchedule);	
					series.series.insert(index + holdIndex + 2,{
						id: nextSchedule.SUB_PHASE_ID + (holdIndex +1),
						name: nextSchedule.SUB_PHASE_NAME,
						color: delS.color,
						data: [nextSchedule],
						labelColor:  labelColor[delS.name] ,
						path : path
					});
					series1.push({
						id: nextSchedule.SUB_PHASE_ID + (holdIndex +1),
						name: nextSchedule.SUB_PHASE_NAME,
						color: delS.color,
						data: [nextSchedule],
						labelColor:  labelColor[delS.name] ,
						path : path
					});
				});
				// 04. END DATE
				var enddate = firstData.END_DATE.replace(/-/g,'')
				scheduleHolds[scheduleHolds.length-1].END_DATE = enddate;
				scheduleHolds[scheduleHolds.length-1].y = convertDateToUct(dateAdd(enddate,1));
				scheduleHolds[scheduleHolds.length-1].yOrigin = convertDateToUct(dateAdd(enddate,0));
				
				
				
				/**** Hold End*****/	
			}else{
				s.labelColor = labelColor[s.name];
				s.path = path
				$.each(s.data,function(index1,d){
					d.yOrigin = d.y;
					//그래프를 붙이기 위해.
					d.y = convertDateToUct(dateAdd(d.END_DATE,1));
					
				});
				series1.push(s);
			}
			
			
			
		});
		
		var $td = $('#'+'schedule_'+ this.PATH.replace(/([ #;&,.%+*~\':"!^$[\]()=>|\/])/g,'\\\\$1') );
		
		var filter = [];
		$.each(relevantList,function(){
			filter.push({col:'PJT_ID',val:this.PJT_ID});
		});
		
		var mindt = minValue(dataFilter(scheduleList1,filter), 'START_DATE');
		//mindt = dateAdd(mindt,-30);
		var maxdt = maxValue(dataFilter(scheduleList1,filter), 'END_DATE');
		maxdt = dateAdd(maxdt,1);
		$td.highcharts('Relevant', {
            //series: series.series ,
            series: series1 ,
            yAxis: {
            	min: convertDateToUct(mindt),
            	max: convertDateToUct(maxdt)
            },
            tooltip: {
                //headerFormat: '<span style="font-size: 10px">' + $td.parent().find('td').html() + '</span><br/>',
                headerFormat:'',
                //pointFormat: '<b>{point.options.EST_START_DATE} - {point.options.EST_END_DATE}</b>'
                //pointFormat: '<b>{point.options.PHASE_NAME}: {point.low:%y/%m/%e} - {point.y:%y/%m/%e}</b></br>'
                pointFormat: '<b>{point.options.PHASE_NAME}: {point.low:%y/%m/%e} - {point.options.yOrigin:%y/%m/%e}</b></br>'
            },
            chart: {}
        },function(chart){
        	tspanPhaseRight();
        	
        });
		$(".highcharts-button").remove();
	}
	
	var initialExpaned = false;
	function setTreeTable(){
		$("#table-sparkline").treetable({ 
			expandable: true,
			onNodeCollapse: function() {
				if(initialExpaned)
					connectSVGRelevantPath();
			},
			onNodeExpand: function() {
				if(initialExpaned){
					//connectSVGRelevantPath();
					setTimeout(connectSVGRelevantPath,100);
				}
					
			}
		});
		 
		// Highlight selected row
		$("#table-sparkline tbody").on("mousedown", "tr", function() {
		  $(".selected").not(this).removeClass("selected");
		  $(this).toggleClass("selected");
		});
		
		$('#table-sparkline').treetable('expandAll');
		initialExpaned = true;
		
	}
	
	function drawSVGRelevantLines(){
		makeSVGRelevantPath();
		//setTimeout(connectSVGRelevantPath,1000);
		connectSVGRelevantPath();
	}
	
	
	
	/**
	* path개체를 하나씩 만든다.
	*/
	function makeSVGRelevantPath(){
		$.each(relevantList,function(){		
			
			//var path = makeSVG('path',{id:'path_' + this.PATH ,d:'M0 0',strok:'#000',fill:'none','stroke-width':'2px'});
			//document.getElementById('svg1').appendChild(path);
			
			var tr = '<path id="path_'+this.PATH+'" '; 
			tr += ' d="M0 0"';
			tr += ' stroke="#000"';
			tr += ' fill="none"';
			tr += ' stroke-width="1px"';
			//tr += ' style="visibility: visible"';
			tr += '/>';
			$('#svg1:last-child').append(tr); 
		});	
		
	}
	
	/**
	* path개체를 연결한다.
	*/
	function connectSVGRelevantPath(){
		$('svg > path').attr('d','M0 0');
		$.each(relevantList,function(){		
			var $child = $('tr:regex(id,'+this.PATH+'/PJT_[0-9]+$)');
			var $mother = this;
			var $thisEl = $('tr:regex(id,'+$mother.PATH+'$)');
			
			if($thisEl.hasClass('collapsed'))
				return true;
			
			$.each($child,function(){
				
				var $parentEl = $('tr:regex(id,'+$mother.PATH+'$)> td:first > span:nth-child(2)');
				if($parentEl.length ==0) 
					return true;
				var $childEl = $('tr:regex(id,'+this.id+'$)> td:first > span:nth-child(2)');
				var $childPath = $('path:regex(id,path_'+this.id+'$)');
				if($childEl.length ==0) 
					return true;
				
				connectElements($("#svg1"), $childPath, $parentEl,   $childEl );
			});
			
		});
		//setTimeout($("#svgContainer").html($("#svgContainer").html()),1000);
		$("#svgContainer").html($("#svgContainer").html())
	}
	
	
	/**
	* jQuery 정규식으로 찾기
	*/
	jQuery.expr[':'].regex = function(elem, index, match) {
	    var matchParams = match[3].split(','),
	        validLabels = /^(data|css):/,
	        attr = {
	            method: matchParams[0].match(validLabels) ? 
	                        matchParams[0].split(':')[0] : 'attr',
	            property: matchParams.shift().replace(validLabels,'')
	        },
	        regexFlags = 'ig',
	        regex = new RegExp(matchParams.join('').replace(/^s+|s+$/g,''), regexFlags);
	    return regex.test(jQuery(elem)[attr.method](attr.property));
	}
	
	
	function tspanPhaseRight(){
		$.each(labelColor,function(key,value){
			var spans = $('tspan:contains('+key+')');
			$.each(spans,function(){
				var nextEl = this.nextSibling;
				if(nextEl != undefined){
					if($(nextEl).text().length == 19)
						$(this).attr("x",100);
					else
						$(this).attr("x",45);	
				}
				
			});
		});
	}
		
	function spanRightWidth(){
		$("[class=pull-right]").each(function(){
			//$(this).css("width")
		});
	}
	</script>
	<script type="text/javascript">
		
		
	//svg connect
	//helper functions, it turned out chrome doesn't support Math.sgn() 
	function signum(x) {
	    return (x < 0) ? -1 : 1;
	}
	function absolute(x) {
	    return (x < 0) ? -x : x;
	}
	
	function drawPath(svg, path, startX, startY, endX, endY) {
	    // get the path's stroke width (if one wanted to be  really precize, one could use half the stroke size)
	    var stroke =  parseFloat(path.attr("stroke-width"));
	    // check if the svg is big enough to draw the path, if not, set heigh/width
	    if (svg.attr("height") <  endY)                 svg.attr("height", endY);
	    if (svg.attr("width" ) < (startX + stroke) )    svg.attr("width", (startX + stroke));
	    if (svg.attr("width" ) < (endX   + stroke) )    svg.attr("width", (endX   + stroke));
	    
	    //var deltaX = (endX - startX) * 0.15;
	    //var deltaY = (endY - startY) * 0.15;
		var deltaX = (endX - startX) * 1;
	    var deltaY = (endY - startY) * 1;
	    // for further calculations which ever is the shortest distance
	    var delta  =  deltaY < absolute(deltaX) ? deltaY : absolute(deltaX);
	    //chanjoo added
	    delta = deltaY;
	
	    // set sweep-flag (counter/clock-wise)
	    // if start element is closer to the left edge,
	    // draw the first arc counter-clockwise, and the second one clock-wise
	    var arc1 = 0; var arc2 = 1;
	    if (startX > endX) {
	        arc1 = 1;
	        arc2 = 0;
	    }
	    // draw tha pipe-like path
	    // 1. move a bit down, 2. arch,  3. move a bit to the right, 4.arch, 5. move down to the end 
	    /* path.attr("d",  "M"  + startX + " " + startY +
	                    " V" + (startY + delta) +
	                    //" A" + delta + " " +  delta + " 0 0 " + arc1 + " " + (startX + delta*signum(deltaX)) + " " + (startY + 2*delta) +
	                    //" H" + (endX - delta*signum(deltaX)) + 
	                    //" A" + delta + " " +  delta + " 0 0 " + arc2 + " " + endX + " " + (startY + 3*delta) +
						" H" + endX + 
	                    " V" + endY ); */
	    path.attr("stroke-dasharray","3,3");
	    path.attr("d",  "M"  + startX + " " + startY +
                " V" + (startY + delta) +
                //" A" + delta + " " +  delta + " 0 0 " + arc1 + " " + (startX + delta*signum(deltaX)) + " " + (startY + 2*delta) +
                //" H" + (endX - delta*signum(deltaX)) + 
                //" A" + delta + " " +  delta + " 0 0 " + arc2 + " " + endX + " " + (startY + 3*delta) +
				" H" + endX 
				);
	}
	
	function connectElements(svg, path, startElem, endElem) {
	    var svgContainer= $("#svgContainer");
	
	    // if first element is lower than the second, swap!
	    if(startElem.offset().top > endElem.offset().top){
	        var temp = startElem;
	        startElem = endElem;
	        endElem = temp;
	    }
	
	    // get (top, left) corner coordinates of the svg container   
	    var svgTop  = svgContainer.offset().top;
	    var svgLeft = svgContainer.offset().left;
	
	    // get (top, left) coordinates for the two elements
	    var startCoord = startElem.offset();
	    var endCoord   = endElem.offset();
	
	    // calculate path's start (x,y)  coords
	    // we want the x coordinate to visually result in the element's mid point
	    var startX = startCoord.left + 0.0*startElem.outerWidth() - svgLeft + 8; //var startX = startCoord.left + 0.5*startElem.outerWidth() - svgLeft;    // x = left offset + 0.5*width - svg's left offset
	    var startY = startCoord.top  + startElem.outerHeight() - svgTop;        // y = top offset + height - svg's top offset
	
	        // calculate path's end (x,y) coords
	    //var endX = endCoord.left + 0.5*endElem.outerWidth() - svgLeft;
		var endX = endCoord.left  - svgLeft;
	
	    var endY = endCoord.top  - svgTop;
		//var endY = endCoord.left  - svgTop;
		var endY = endCoord.top  + 0.5*endElem.outerHeight() - svgTop;
	
	    // call function for drawing the path
	    drawPath(svg, path, startX, startY, endX, endY);
	
	}
	
	function makeSVG(tag, attrs) {
        var el= document.createElementNS('http://www.w3.org/2000/svg', tag);
        for (var k in attrs)
            el.setAttribute(k, attrs[k]);
        return el;
    }
		
	</script>
	<style type="text/css">
		#table-sparkline {
			width: 100%;
			margin: 0 auto;
		    border-collapse: collapse;
		}
		/* 
		// 2016-01-27
		th {
		    font-weight: bold;
		    text-align: left;
		}
		td, th {
		    padding: 5px;
		    border-bottom: 1px solid silver;
		    height: 20px;
		}
		
		thead th {
		    border-top: 2px solid gray;
		    border-bottom: 2px solid gray;
		}  
		*/
		
		/* #table-sparkline {
			width: 100%;
			table-layout: fixed;
			border-collapse: collapse;
			border-top: 2px solid #fc5d57;
			border-left: 1px solid #e1e2e6;
			border-right: 1px solid #e1e2e6;
			border-bottom: 1px solid #e1e2e6;
		}
		
		#table-sparkline th {
			color: #000;
			background: #f5f6fa;
			height: 20px;
			padding: 5px 10px;
			overflow: hidden;
			border: 1px solid #e1e2e6;
			font-weight: normal
		}
		
		#table-sparkline td {
			height: 20px;
			word-break: break-all;
			word-break: break-word;
			table-layout: fixed;
			
			padding: 5px 10px;
			border: 1px solid #e1e2e6;
			line-height: 160%;
			color: #000
		} */
		#table-sparkline th{
			text-align: center;
		}
		#table-sparkline td.tdFirst{
			/* width: 30px; */
		    overflow: hidden;
		    /* display: inline-block; */
		    white-space: nowrap;
		    overflow: hidden;
		}
		.tdFirst:after {content:""; display:block; clear:both;}
		.highcharts-tooltip>span {
			background: white;
			border: 1px solid silver;
			border-radius: 3px;
			box-shadow: 1px 1px 2px #888;
			padding: 8px;
		}
		.pull-right {
		    /* float:right; */
		    white-space: normal;
		    *zoom: ~"expression( this.runtimeStyle.zoom='1',parentNode.insertBefore( this,parentNode.firstChild ))";
		}
		
		body{
			background: #fff;
			margin:0;
			overflow: auto;
			width: 100%;
		}
		
		
		table.treetable span.relevant_mother {
		  background-image: url(/dashboard/images/relevantMother2.png);
		  /* background-size: 20px; */
		}
		
		table.treetable span.relevant_revision {
		  background-image: url(/dashboard/images/relevantRevision1.png);
		 /*  background-size: 20px; */
		}
		table.treetable span.relevant_child {
		  background-image: url(/dashboard/images/relevantChild1.png);
		  /* background-size: 20px; */
		}
		
		table.treetable tr.selected {
		  background-color: rgba(255,0,0,0.1);
		  color: #000;
		}
		
		table.treetable tr.branch {
		    background-color: transparent;
		}
		table.treetable tr.branch.selected {
		    background-color: rgba(255,0,0,0.1);
		}
		
		table.treetable tr.collapsed span.indenter a {
		  	background-image: url(data:image/png;base64,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);
		}
		table.treetable tr.collapsed.selected span.indenter a{
			background-image: url(data:image/png;base64,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);
		}
		table.treetable tr.expaned span.indenter a {
		  	background-image: url(data:image/png;base64,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);
		}
		table.treetable tr.expanded.selected span.indenter a {
		  	background-image: url(data:image/png;base64,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);
		}
		
		
		
		
		#svgContainer { 
			z-index: -10;
			position:absolute;
			/* background-color:silver; */
			/* opacity: 0.5; */
		}
		
		
		
	</style>
	
</head>
<body>

<form name="form1" id="form1">
<input type="hidden" name="searchApplication" value="${param.searchApplication}"/>
<input type="hidden" name="searchStatus" value="${param.searchStatus}"/>
<input type="hidden" name="phaseBase" value="phase"/>
<input type="hidden" name="dateGubun" value="endDate"/>
<input type="hidden" name="pjt_id" value="${param.pjt_id}"/>
<div id="svgContainer" style="margin: 0 0;">
    <svg id="svg1" width="0" height="0" xmlns="http://www.w3.org/2000/svg" >
     </svg>
</div>
<div id="container" class="container" style="margin-top: 10px;display: inline;">
	<div style="position: relative;">
		<h3 class="" style="display: inline;padding-left: 30px;">Controller Map:</h3><h4 id="controllerMapName" style="display: inline;"></h4>
	</div>
	<table id="table-sparkline">
	<colgroup>	
		<col width="550px">
        <col width="">
    </colgroup>
    <thead style="line-height: 1.5;font-weight: bold;">
    	<tr>
	    	<th style="font-weight: bold;">PROJECT</th>
	    	<th style="font-weight: bold;">SCHEDULE</th>
    	</tr>
    </thead>
    <tbody id="tbody-sparkline">
    </tbody>
    </table>
</div>
</form>
<div>
	<ui>
		<li style="background-image: url(/dashboard/images/relevantMother2.png);
		/* background-size: 20px; */
		background-position: center left;
    	background-repeat: no-repeat;
    	padding: .2em 0 .2em 1.5em;
    	list-style: none;
    	font-size: 14px;
    	font-weight: normal;
    	display: inline;">Core</li>
		<li style="background-image: url(/dashboard/images/relevantRevision1.png);
		/* background-size: 20px; */
		background-position: center left;
    	background-repeat: no-repeat;
    	padding: .2em 0 .2em 1.5em;
    	list-style: none;
    	font-size: 14px;
    	font-weight: normal;
    	display: inline;">Revision</li>
    	<li style="background-image: url(/dashboard/images/relevantChild1.png);
    	/* background-size: 20px; */
		background-position: center left;
    	background-repeat: no-repeat;
    	padding: .2em 0 .2em 1.5em;
    	list-style: none;
    	font-size: 14px;
    	font-weight: normal;
    	display: inline;">Derivative</li>
	</ui>
</div>
<div class="btn_section" style="margin: 5px 0 0 0;display: inline-block; width: 99%;position: absolute; bottom: 10px;right: 10px;">
	<div class="right_section" style="float: right;">
 		<a href="#" class="btn_txt btn_type_e btn_color_a" 
 			style="
 				font-family: 'Malgun Gothic', arial, gulim, dotum;
			    color: #000;
			    text-decoration: none;
			    background-position: left -400px;
			    height: 28px;
			    padding-left: 10px;
			    margin-right: 10px;
		        background-image: url('/nspim/images/btn/btn_color_a.png');
		        display: inline-block;
			    background-repeat: no-repeat;
			    cursor: pointer;
			    vertical-align: top;
 			"
 		 		onclick="javascript:window.close();">
             	<span class="name" style="
             		background-image: url('/nspim/images/btn/btn_color_a.png');
             		background-position: right -400px;
				    height: 28px;
				    padding-right: 10px;
				    margin-right: -10px;
				    font-size: 12px;
				    line-height: 28px;
				    font-weight: bold;
				    color: #fff;
				    text-align: center;
				    
				    display: block;
				    /* height: 100%; */
				    background-repeat: no-repeat;
				    cursor: pointer;
    
             	">
              		<span class="txt" style="
              		display: inline-block;
				    text-align: center;
				    /* vertical-align: middle; */">
    					Close
    				</span>
             	</span>
        </a>
	</div>
</div>
</body>

<!-- <script src="js/highcharts/themes/dark-unica.js"></script> -->
<!-- <script src="js/highcharts/themes/sand-signika.js"></script> -->
<!-- <script src="js/highcharts/themes/grid-light-pms.js"></script> -->
<!-- <script src="js/highcharts/themes/dashboard-simple.js"></script> -->
</html>
