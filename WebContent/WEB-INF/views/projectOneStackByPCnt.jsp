<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>projectOneStackByPCnt</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script type="text/javascript">
	$(function () {
		projectListByAjax();
	});
	
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
			url : "/dashboard/projectOneStackByPCntJson.html",
			data: {PJT_CODE: $("#sProject").val() },
			success : function(responseData){
				
				drawChart(responseData);
			}
		});
	}
	
	function drawChart(resonseData){		
		var data = resonseData.data;	
		
		// 가져온데이타를 하이차트에 맞게 변형한다.
		// xAxis,series(p0,p1,p2)
		var categoriesHigh = new Array();
		var seriesP0 = new Array();
		var seriesP1 = new Array();
		var seriesP2 = new Array();
		
		var plotBandsHigh = new Array();
		var plotLinesHigh = new Array();
		var bandIndex = 0;
		for (i = 0; i < data.length; i++){			
			categoriesHigh.push(data[i].ANALYSYS_DATE );
			seriesP0.push(data[i].P0);
			seriesP1.push(data[i].P1);
			seriesP2.push(data[i].P2);
			
			//plotBands 구성			
			var prePhase = data[Math.max(i-1,0)].PHASE;
			var curPhase = data[i].PHASE;
			if(i==0 || (prePhase != curPhase)){
				var plotBand = {};
				plotBand.from = i-1;
				if(bandIndex>0)
					plotBandsHigh[bandIndex-1].to = i-1;
				
				// phase 색깔지정
				/* var imod = bandIndex%2;
				if(imod == 0){
					plotBand.color = 'rgba(68, 170, 213, 0.1)';
				}					
				else{
					plotBand.color = 'rgba(0, 0, 0, 0)';
				}
				plotBand.borderColor = 'rgba(0, 0, 0, 0.1)';
				plotBand.borderWidth = 1; */
				
				
				//plotBand.dashStyle = 'ShortDash';
				plotBand.label = {};
				//plotBand.label.verticalAlign = 'bottom';
				//plotBand.label.y = -20;
				plotBand.label.text = curPhase ;
				plotBand.label.style = {};
				plotBand.label.style.color = '#606060';
				plotBand.label.style.fontWeight = 'bold';
				
				
				// plotLine
				var plotLine = {
						color:'black',
						width:1,
						value:i-1,
						dashStyle: 'ShortDash'			
						
						/* ,label:{
							text: curPhase,
							rotation: 0,
							verticalAlign: 'top',
							x:100,
							textAlign:'right',
							style:{
								color:'#606060',
								fontWeight:'bold'
							}
						} */
				};
				
				
				
				bandIndex++;
				plotBandsHigh.push(plotBand);
				plotLinesHigh.push(plotLine);
			}
			if(i== (data.length -1))
				plotBandsHigh[bandIndex-1].to = i;
			
        }
		
		// plotBands 구성
		
		$('#container').highcharts({
	        chart: {
	            type: 'area'
	        },
	        title: {
	            text: data[0].PJT_CODE
	        },
	        subtitle: {
	            text: data.PJT_CODE
	        },
	        xAxis: {
	            categories: categoriesHigh ,
	            tickmarkPlacement: 'on',
	            title: {
	                enabled: false
	            },
	            plotBands : plotBandsHigh,
	            plotLines: plotLinesHigh,
	            labels: {
	                formatter: function () {
	                	var valSplit = this.value.split('-');
	                    return valSplit[1] + '-' + valSplit[2] ;
	                }
	            }
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	            
	        },
	        tooltip: {
	            shared: true,
	            valueSuffix: ''
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
	            area: {
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
	            name: 'P2',
	            data: seriesP2,visible:false
	        },{
	            name: 'P1',
	            data: seriesP1,visible:false
	        }, {
	            name: 'P0',
	            data: seriesP0,visible:true
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
<form name="form">
<select name="sProject" id="sProject" size="1"  onchange="getDataByJson()">
	<option>PROJECT SELECT</option>
</select>
<div id="container" style="width:100%; height:90%;"></div>
</form>
</html>
