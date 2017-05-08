<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>codesonarProjectDetail</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	<script src="js/dashboard.js?version=1"></script>
	
	<!-- Additional files for the Highslide popup effect -->
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	
	<script type="text/javascript">
	$(function () {
		projectListByAjaxCsv();
		//getDataByJson();
	});
	
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		 
		var parameter = {};
		parameter.PJT_CODE = $("#sProject").val();		
		parameter.url = getUrlByPjtcode(parameter.PJT_CODE,"url");
		parameter.server = getUrlByPjtcode(parameter.PJT_CODE,"server");
		
		$.ajax({
			//type: "POST",
			async: true,
			url : "/dashboard/codesonarProjectDetailJson.html",
			data: parameter,
			//modelAttribute:"searchVO",
			success : function(responseData){
				if(responseData.data != undefined){
					var jsondata = $.csv2Dictionary(responseData.data);				
					responseDataG = jsondata;
					drawChart($("#sFile").val());
				}
				
			}
		});
	}
	
	function drawChart(file){				
		var data = responseDataG;	
		
		
		//01. prioriy xcategory
		var xcategory = [];
		var dataA = $.grep(data,function(d){			
			if(d.file == file)
				return d;
		}); ;
		
		var dataB = groupby(dataA, 'procedure');
		var dataH = [];
		total = 0;
		for(var i=0;i<dataB.length;i++){
			total += dataB[i][1];
		}
		
		dataB.sort(function(a, b){
			return b[1] - a[1];
		});
		
		for(var i=0;i<dataB.length;i++){
			if(i>19)
				break;
			xcategory.push(dataB[i][0]);
			
			var d = {
				y: 	dataB[i][1],
				percentage : 	(dataB[i][1]/total)*100
			};
			dataH.push(d);
		}		
	
		var linkUrl = getCodesonarFileCsvLink($("#sProject").val(),file);
		
		$('#container').highcharts({
	        chart: {
	        	type:'bar',
	        	zoomType: 'x'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: linkUrl ,
	            useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	        	categories: xcategory,
	            title: {
	                text: null
	            },
	            labels:{
	            	overflow: 'justify',
	   	         	formatter: function(){
	   	         		var len = this.value.length;
			        	if(len> 15){
			        		var text = this.value.substr(0,15) + "...";
			        		
			        		return "<div title=\""+this.value+"\">"+text+"</div>";
			        	}            		
			        	else
			        		return this.value;
	   		        }
	   		        ,useHTML: true
	            }
	        
	        },
	        yAxis: {
	            title: {
	                text: ''
	            },
	            labels:{
	            	overflow: 'justify'
	            },
	            tickInterval: null,
	            min:0
	            
	        },
	        plotOptions: {
	            series: {
	                cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function () {
	                        	htmlExpandFunction($("#sProject").val(),file,this.category);	                        	
	                        }
	                    }
	                }
	            },
	            bar:{
	            	dataLabels:{
	            		enabled: true ,
	            		format: '{point.y} ( {point.percentage:.1f} % )'
	            	}
	            }
	        },
	        tooltip: {
	            valueSuffix: ''  ,
	            pointFormat: '{series.name}:<b> {point.y} ( {point.percentage:.1f} % )</b>'
	        }, 
	        
	        legend: {
	        	enabled: false
	           
	        },
	        series:[{
				name:"procedure",
				data:dataH
			}]
	    },function(){
	    	//drawChart22(responseData);
	    });		
	}	
		
	
	
	function groupby(json,pkey){
		var abcArr = json;

		var items = {}, base, key,val ;
		for (var i = 0; i < abcArr.length; i++) {
		    base = abcArr[i];
		   // key = base['priority'];
		    key = base[pkey];
		    //val = 'cnt';
		    // if not already present in the map, add a zeroed item in the map
		    if (!items[key]) {
			items[key] = 0;
		    }
		    // add new item to the map entry
		    items[key]++;
		}

		// Now, generate new array
		var outputArr = [], temp;
		for (key in items) {
		    // create array entry for the map value
		    temp = [key, items[key]]
		    // put array entry into the output array
		    outputArr.push(temp);
		}
		
		return outputArr;
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
<form name="form" id="form">
<input type="hidden" id="sProject" name="sProject" value="${param.pjt_code}" onchange="getDataByJson();"/>
<input type="hidden" id="sFile" name="sFile" value="${param.file}" onchange="getDataByJson();"/>
<div id="container" class="container">
</div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
