<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>summaryDashboard</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script type="text/javascript">
	
	
	$(function () {
		getDataByJson();
		$( window ).resize(function() {
			//adjustColor();
		});
	});
	
	var responseData = {};
	
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/summaryDashboardJson.html",
			data: {PJT_CODE: '' },
			success : function(pResponseData){
				responseData = pResponseData;
				drawChart(false);
			}
		});
	}
	
	
	
	function drawChart(redraw){		
		var dataRaw = responseData.data;
		
		//01. series데이타. project
		var dataHigh = new Array();
		
		for (var i = 0; i < dataRaw.length; i++){
			var data =  {
				x: dataRaw[i].	QUALITY ,
				y: dataRaw[i].	DELIVERY,
				
				dataraw: dataRaw[i],
				dataLabels: {
                    enabled: true,
                    //format:'{point.dataraw.PJT_CODE}'
                    formatter: function() {
    	                return '<b style="font-size:16px;">'+ this.point.dataraw.PJT_CODE +'</b>'
    	            }
                }
                
			};
			dataHigh.push(data);
			//dataHigh.push([dataRaw[i].QUALITY ,dataRaw[i].DELIVERY, 300]);
		}
		
		
		$('#container').highcharts({
	        chart: {
	        	//type:'bubble',
	        	//zoomType: 'xy',
	        	defaultSeriesType:'scatter',
	            borderWidth:1,
	            borderColor:'#ccc',
	            marginLeft: 150,
	            marginBottom: 100,
	            marginTop: 100,
	            marginRight: 100,
	            //marginLeft:200,
	            //marginRight:200,
	            backgroundColor:'#eee',
	            plotBackgroundColor:'#fff',
	            events:{
	            	redraw: function () {
	            		adjustColor();
	            	}
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
	                return '<b>'+ this.point.dataraw.PJT_CODE +'</b><br/>'+
	                    'Quality: ' + this.x +' , '+ 'Delivery: ' + this.y;
	            }
	        },
	        plotOptions: {
	            series: {
	                shadow:false,
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
	                text:'Quality'
	            },
	            min:-10,
	            max:10,
	            tickInterval:10,
	            tickLength:0,
	            minorTickLength:0,
	            gridLineWidth:1,
	            showLastLabel:true,
	            showFirstLabel:false,
	            lineColor:'#ccc',
	            lineWidth:1                
	        },
	        yAxis:{
	            title:{
	                text:'Delivery',
	                rotation:0,
	                margin:25,
	            },
	            min:-10,
	            max:10,
	            tickInterval:10,
	            tickLength:3,
	            minorTickLength:0,
	            lineColor:'#ccc',
	            lineWidth:1        
	        },
	        series: [{
	            //color:'#185aa9',
	            data: dataHigh ,
	            marker: {
	                fillColor: {
	                    radialGradient: { cx: 0.5, cy: 0.5, r: 0.9 },
	                    stops: [
	                        [0, 'rgba(100,0,0,1)'],
	                        [1, Highcharts.Color(Highcharts.getOptions().colors[0]).setOpacity(0.5).get('rgba')]
	                    ]
	                },
	                style:{
	                	fontSize: '20px'
	                }
	            }
	        }]
	    }, function(chart) { // on complete
	    		adjustColor();
			}
		
		);
		
	}
	
	
	
	
	
	//$( "input[type=checkbox]" ).on( "click", drawChart );
	
	$( "#p0" ).click(function() {
		drawChart();
	});
	$( "#p1" ).click(function() {
		drawChart();
	});
	$( "#p2" ).click(function() {
		drawChart();
	});
	
	
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
	
	</script>
	<style type="text/css">
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	      }
		
		.dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 90%;	
		}
	</style>
</head>
<body>
<form name="form">

<div  id="container" class="dashboard-div"></div>
</form>
</body>
</html>
