<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>projectOneStackByPCntDate</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script type="text/javascript">
	$(function () {
		projectListByAjax();
	});
	
	
	var responseDataG = {};
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/projectListByJson.html",
			data: {},
			success : function(responseData){
				var projectList = responseData.projectList;
				for(var i=0; i<projectList.length ; i++){
					$("#sProject").append("<option value='"+ projectList[i].PJT_CODE +"'>" + projectList[i].PJT_CODE +"</option>" );	
				}				
			}
		});
	}
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/defectsTrendsJson.html",
			data: {PJT_CODE: $("#sProject").val() },
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
	
	function drawChart(resonseData){		
		var data = resonseData.data;	
		
		// 가져온데이타를 하이차트에 맞게 변형한다.
		// seriesP0: arearange ,  seriesP1: line
		var seriesP0 = new Array();
		var seriesP1 = new Array();
		
		var createStack = 0;
		var resolveStack = 0;
		var gapStack = 0;
		
		// 가상데이타.
		for (i = 0; i < data.length; i++){			
			var d = data[i];
			var dateSplit = d.DEFECTS_DATE.split('/');			
			var utcDate = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]);
			d.utcDate = utcDate;	
			
			createStack += d.CREATED;
			resolveStack += d.RESOLVED;
			var gap = d.CREATED - d.RESOLVED;
			var gapStack = createStack - resolveStack;
			d.createStack = createStack;
			d.resolveStack = resolveStack;
			d.gapStack = gapStack;
			
        }
		
		// maxGap
		var maxGap = 0;
		for (i = 0; i < data.length; i++){	
			if(data[i].gapStack > maxGap)
				maxGap = data[i].gapStack;
		}
		
		var mad = maxGap%50;
		maxGap += (50-mad);
		// create_stack_virtual
		for (i = 0; i < data.length; i++){			
			var d = data[i];
			var dataP0 = {
				x: d.utcDate,
				low: d.resolveStack + maxGap,
				high: d.createStack + maxGap,				
				rawData: d // tooltip을 보여줄때 써먹을 수 있도록 한다.
			};
			
			//seriesP0.push([d.utcDate,d.createStack + maxGap , d.resolveStack + maxGap]);
			seriesP0.push(dataP0);
			seriesP1.push([d.utcDate,d.gapStack]);
			
        }
		
		
		// plotBands 구성
		var plotBandsHigh = new Array();
		var plotLinesHigh = new Array();
		var bandIndex = 0;
		var dataPhase = resonseData.phase;
		for (var i = 0; i < dataPhase.length; i++){	
			//------------- plotBands 구성. Phase -----------//
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
			
			//-------------   plotLine 구성.  ----------------//
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
		
		$('#container').highcharts({
	        chart: {
	        	zoomType: 'x'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: $("#sProject").val()
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%m/%e',
	        		year: '%m/%e'
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
	            },
	            labels:{
	            	formatter:function(){
	            		if(this.value >= maxGap)
	            			return this.value - maxGap
	            		return this.value;
	            	}
	            },
	            min:0
	            
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
	            valueSuffix: ''  
	            
	            // 기본포맷 . formatter 함수로 하지 말고 fommat을 설정하도록 한다.
	            /* ,
	            
	            formatter: function (tooltip) {
	            		            	
	            	var items = this.points || splat(this),
	    			series = items[0].series,
	    			s;

		    		// build the header
		    		s = [tooltip.tooltipHeaderFormatter(items[0])];
	
		    		// build the values
		    		Array.prototype.forEach.call(items, function (item) {
		    			series = item.series;
		    			s.push((series.tooltipFormatter && series.tooltipFormatter(item)) ||
		    				item.point.tooltipFormatter(series.tooltipOptions.pointFormat));
		    		});
	
		    		// footer
		    		s.push(tooltip.options.footerFormat || '');
	
		    		return s.join('');
	            } */
	            
	        }, 
	        
	        legend: {
	            layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'top',
	            x: -80,
	            y: 100,
	            floating: true,
	            borderWidth: 1,
	            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
	        },
	        plotOptions: {
	        	arearange:{
	        		tooltip:{
	        			pointFormat:'<span style="color:{series.color}">●</span> {series.name}: <b>{point.rawData.createStack}</b> - <b>{point.rawData.resolveStack}</b><br/>'
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
	            	stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
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
	        series: [{
	        	type: 'arearange',
	            name: 'Create-Resolve',
	            data: seriesP0,
	            tooltipOptions:{
	            	//pointFormat: '<span style="color:{series.color}">\u25CF</span> {series.name}: <b>{point.y}</b><br/>'
	            	//pointFormat: 'dfdfdfdfd'
	            },
	            visible:true
	        },{
	        	type: 'line' ,
	            name: 'gap',
	            data: seriesP1,
	            visible:true
	        }
	        ]
	    });
		
		//$('#container').highcharts.series[0].hide();
		//$('#container').highcharts.series[1].hide();
		// Apply the theme
		//Highcharts.setOptions(Highcharts.theme);
	}
	
	
	
	/**
	 * Grid-light theme for Highcharts JS
	 * @author Torstein Honsi
	 */

	// Load the fonts
	Highcharts.createElement('link', {
	   href: 'http://fonts.googleapis.com/css?family=Dosis:400,600',
	   rel: 'stylesheet',
	   type: 'text/css'
	}, null, document.getElementsByTagName('head')[0]);

	Highcharts.theme = {
	   colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
	      "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
	   chart: {
	      backgroundColor: null,
	      style: {
	         fontFamily: "Dosis, sans-serif"
	      }
	   },
	   title: {
	      style: {
	         fontSize: '16px',
	         fontWeight: 'bold',
	         textTransform: 'uppercase'
	      }
	   },
	   tooltip: {
	      borderWidth: 0,
	      backgroundColor: 'rgba(219,219,216,0.8)',
	      shadow: false
	   },
	   legend: {
	      itemStyle: {
	         fontWeight: 'bold',
	         fontSize: '13px'
	      }
	   },
	   xAxis: {
	      gridLineWidth: 1,
	      labels: {
	         style: {
	            fontSize: '12px'
	         }
	      }
	   },
	   yAxis: {
	      minorTickInterval: 'auto',
	      title: {
	         style: {
	            textTransform: 'uppercase'
	         }
	      },
	      labels: {
	         style: {
	            fontSize: '12px'
	         }
	      }
	   },
	   plotOptions: {
	      candlestick: {
	         lineColor: '#404048'
	      }
	   },

  
	   // General
	   background2: '#F0F0EA'
	   
	};

	</script>
</head>
<body>
<form>
<select name="sProject" id="sProject" size="1"  onchange="getDataByJson()">
	<option>PROJECT SELECT</option>
</select>
<div id="container" style="width:100%; height:80%;overflow: auto;position: relative;"></div>
</form>
</html>
