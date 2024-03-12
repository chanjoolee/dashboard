<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>codeReview</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script type="text/javascript">
	
	
	$(function () {
		getDataByJson();
	});
	
	var responseData = {};
	
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/codeReviewJson.do",
			data: {PJT_CODE: '' },
			success : function(pResponseData){
				responseData = pResponseData;
				drawChart(false);
			}
		});
	}
	
	
	
	function drawChart(redraw){		
		var dataRaw = responseData.data;
		
		//01. xCategory
		var projects = [];
		for (var i = 0; i < dataRaw.length; i++){
			projects.push(dataRaw[i].PJT_CODE);
		}
		jQuery.unique(projects);
		
		var xcategory = [];
		for (var i = 0; i < projects.length; i++){
			/* var cat = dataRaw.filter( function(s){
				if(s.PJT_CODE == projects[i])
					return true;
			}); */
			
			var keywords =  projects[i];
			var search = new RegExp(keywords, "gi");
			var cat = $.grep(dataRaw, function (item) {
				return ( item.PJT_CODE.match(search) );
			});
			
			
			if(cat.length>0){
				xcategory.push(cat[0].PJT_CODE + '<br/>' + cat[0].CURRENT_PHASE);
			}
		}
		
		//02.1. series데이타. SUBMIT,review
		var seriesDataSubmit = new Array();
		var seriesDataReview = new Array();
		for (var i = 0; i < dataRaw.length; i++){
			var dataSubmit =  {
				y: dataRaw[i].	SUBMIT,				
				dataraw: dataRaw[i],
				dataLabels: {
                    enabled: true
                }
                
			};
			var dataReview =  {
					y: dataRaw[i].	REVIEW,				
					dataraw: dataRaw[i],
					dataLabels: {
	                    enabled: true
	                }
	                
				};
			seriesDataSubmit.push(dataSubmit);
			seriesDataReview.push(dataReview);
		}
		
		
		
		
		
		$('#container').highcharts({
			chart: {
	            type: 'area',
	            spacingBottom: 30
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: 'Code Review'
	        },
	        legend: {
	        	layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'top',
	            x: -50,
	            y: 50,
	            floating: true,
	            borderWidth: 1,
	            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
	        },
	        xAxis: {
	            categories: xcategory ,
	            //tickmarkPlacement: 'on',
	            title: {
	                enabled: false
	            }
	        },
	        yAxis: {
	            title: {
	                text: ' '
	            }
	        },
	        tooltip: {
	            shared: true ,
	            crosshairs: true
	        },
	        plotOptions: {
	            area: {
	                fillOpacity: 0.5
	            }
	        },
	        series: [{
	            name: 'submit',
	            data: seriesDataSubmit
	        }, {
	            name: 'review',
	            data: seriesDataReview
	        }]
	        
		});
		
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
	</style>
</head>
<body>
<form name="form">
<div  id="container" class="dashboard-div"></div>
</form>
</body>
</html>
