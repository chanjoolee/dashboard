<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>jiraDiscoveredResolution</title>
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
	<!-- <script src="http://code.highcharts.com/highcharts.js"></script> -->
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<script src="js/highcharts/grouped-categories.js"></script>
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. local --%>
	<!-- <script src="js/pms/resourceBySite.js"></script>
	<script src="js/pms/resourceByFunc.js"></script> -->
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	
	/* 
	//플러긴 연습
	(function (H) {
        function addImages (proceed) {

            proceed.call(this)

            var chart = this,
                axis = chart.xAxis[0],
                images = axis.options.images;
            H.each(axis.tickPositions, function (pos) {
                var tick = axis.ticks[pos],
                    x,
                    y;
                if (images[pos]) {
                    x = axis.toPixels(pos) - 40;
                    y = chart.plotTop + chart.plotHeight + 0;
                    if (!tick.image) {
                        tick.image = chart.renderer.image(images[pos], x, y, 32, 32)
                        .add();
                    } else { // Update existing
                        tick.image.animate({
                            x: x,
                            y: y
                        });
                    }
                }
            });
        }

        H.wrap(H.Chart.prototype, 'render', addImages);
        H.wrap(H.Chart.prototype, 'redraw', addImages);
    }(Highcharts)); */
    
//     Number.prototype.format = function(n, x) {
//         var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
//         return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
//     };
    
	var dataList = [];
	var dataListGroup = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/jiraDiscoveredResolutionJson.do",
			data: $("#form").serialize() ,
			success : function(responseData){
				//dataList = responseData.dataList;
				dataListGroup = responseData.dataListGroup;
				var chartMode = "${param.drillMode}"
				if(chartMode == "drill"){
					drawchart();
				}else{
					drawchartPlat();
				}
			}
		});
	}
	
	function drawchart(){
		
		var groupKeys = ['GUBUN','DISCOVERED_FROM_PURE'];
		var series = getDrillDownDataSeries2(
				'',
				dataListGroup ,
				groupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull:0}], //convert
				'DISCOVERED_FROM_PURE', 
				'CNT',
				{cd: 'GUBUN', name:'GUBUN'},
				{isGroupby: true}
		);
		
		$.each(series.series,function(index,s){
			if(s.name=='created'){
				//s.pointPadding = 0.3;
				s.color = '#e0e0e0';
			}else{
				s.pointPadding = 0.4;
				s.color = '#606060';
				s.dataLabels = {
						x:20,
						y:10
				};
			}
		
		});
		
		
		series.category = [];
		$.each(series.series,function(i,s){
			sortObjects(s.data,[['y','desc']]);
		});
		$.each(series.series[0].data,function(){
			series.category.push(this.DISCOVERED_FROM_PURE);
		});
		
		//카테고리 만들기
		var category1 = [];
		$.each(series.category,function(index,c){
			var tat = dataFilter(dataListGroup,[{col:'GUBUN',val:'resolved'},{col:'DISCOVERED_FROM_PURE', val: c }]);
			if(tat.length > 0){
				var tat1 = groupbySum(tat,['DISCOVERED_FROM_PURE'],'TAT');
				category1.push( [Highcharts.numberFormat(tat1[0].TAT,0) + ' days', c ]);
			}else{
				category1.push( [Highcharts.numberFormat(0,0) + ' days', c ]);
			}
			
		});
		var category2 = makeGroupCategory(category1);
		series.category = category2;
		
		//drilldown데이타만들기. 여러단계이면 recursive function으로 변경.
		$.each(series.series,function(i,s){
			s.series = series;
			/* s.series = function(){
				return series;
			}; */
			if(this.name == 'resolved'){
				//return true;
			}
			$.each(s.data,function(j,data){
				this.Oseries = s;
				/* this.upseries = function(){
					return s;
				}; */
				var relatedData = dataFilter(dataListGroup,[{col:'DISCOVERED_FROM_PURE',val:this.DISCOVERED_FROM_PURE}]);
				
				var drillSeries = getDrillDownDataSeries2(
						'',
						relatedData ,
						['GUBUN','DISCOVERED_FROM_PURE','PHASE'] ,
						[], //filter
						[{col:'CNT',convert:'y',isnull:0}], //convert
						'PHASE', 
						'CNT',
						{cd: 'GUBUN', name:'GUBUN'},
						{isGroupby: false}
				);
				
				//카테고리 만들기
				var drillCategory1 = [];
				var discoveredFrom = this.DISCOVERED_FROM_PURE;
				$.each(drillSeries.category,function(index,c){
					var drillTat = dataFilter(dataListGroup,[{col:'GUBUN',val:'resolved'},{col:'DISCOVERED_FROM_PURE', val: discoveredFrom},{col:'PHASE',val:c}]);
					var drillTat1 = groupbySum(drillTat,['PHASE'],'TAT');
					drillCategory1.push( [ Highcharts.numberFormat(drillTat1[0].TAT,0)  + ' days' , c ]);
				});
				var drillCategory2 = makeGroupCategory(drillCategory1);
				drillSeries.category = drillCategory2;
				
				/* drillSeries.category = [];
				$.each(drillSeries.series,function(i,s){
					sortObjects(s.data,[['y','desc']]);
				});
				$.each(drillSeries.series[0].data,function(){
					drillSeries.category.push(this.PHASE);
				}); */
				
				//color
				$.each(drillSeries.series,function(index,s1){
					//s1.parent = series;
					if(s1.name=='created'){
						//s.pointPadding = 0.3;
						s1.color = '#e0e0e0';
					}else{
						s1.pointPadding = 0.4;
						s1.color = '#606060';
						s1.dataLabels = {
								x:20,
								y:10
						};
					}		
				});
				
				this.drillSeries = drillSeries;
				//this.drillSeries.parent = this;
				this.drillSeries.parent = function(){
					return data;
				};
				
			});
		});
		
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		$('#container').highcharts({
	        chart: {
	            type: 'column',
	            zoomType:'x'
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
	        legend:{
	        	enabled:false
	        },
	        xAxis:{
	        	categories: series.category,
	        	labels:{
	        		groupedOptions:[{
	        			rotation: 0
	        		},{
	        			rotation: 0
	        		}],
	        		//rotation:-90,
	        		formatter: function() {
						var rtn = '';
	        			
	        			if(typeof this.value == 'string'){
	        				rtn = this.value.split("_");
	        				var matchs = this.value.match(/[\d]+\sdays/i);
	        				if(matchs != null && matchs.length > 0){
	        					var split = this.value.split(" ");
	        					rtn = split[0] + "<br/>" + split[1];
	        				}
	        			}else{
	        				rtn =  this.value.name;
	        			}
	        			
	        			return rtn;
	        		}
	        	} 
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }
	            //,tickInterval:5
	        },
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y}</b> <br/>',
	            shared: true,
	            enabled: true
	        },
	        //legend: legend,
	        plotOptions: {
	            column: {
	            	grouping: false,
	            	borderWidth: 0,
	            	cursor: 'pointer' ,
	            	point:{	                	
	                	events:{
	                		click: function(e){
	                			e.point.select(true,false);
	                			if(this.drillSeries){
	                				setChart(this.drillSeries);
	                			}else{
	                				//var phase = this.category.parent.parent.name;
		                			//var cause = this.category.name;
		                			//var data = "";
		                			//$("#phase").val(phase);
		                			//$("#discoveredFrom").val(cause);
		                			gotoDetail(this.PHASE,this.DISCOVERED_FROM_PURE);
	                			}
	                			
	                			
	                		}
	                	}
	                },
	                //stacking: 'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    useHTML: true,
	                    //format:'{point.y:.0f} ({point.percentage:.0f}%)'
	                    //x: 10,
	                    formatter:function(){
	                    	var rtn = "";
	                    	if(this.series.name == 'created'){
	                    		var resolved = this.series.chart.series[1].options.data[this.point.x].y;
	                    		if(this.y == resolved)
	                    			//rtn = "<span><img src=\"/dashboard/images/Check_Pic.jpg\"/ width=\"30px\" height=\"30px\" style=\"z-index:50\"> 완료</span>";
	                    			//rtn = "<div>완료</div>";
	                    			rtn = "<span><img src=\"/dashboard/images/Check_Pic.jpg\"/ width=\"30px\" height=\"30px\" style=\"z-index:50\"></span>";
	                    		else
	                    			rtn = this.y + '';
	                    	}else{
	                    		var created = this.series.chart.series[0].options.data[this.point.x].y;
	                    		if(created == this.y)
	                    			rtn = "";
	                    		else{
	                    			var percent = 0;
		                    		if(created > 0)
		                    			percent = (this.y/created)*100;
		                    		rtn = Highcharts.numberFormat(percent,1) + '%';
	                    		}
	                    		
	                    	}	                    	
	                    	return rtn;
	                    	
	                    },
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//gotoDetail(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		//after draw chart
	    	//100% 표시
	    	var image = this.renderer.image('/dashboard/images/Check_Pic.jpg')
	    	.attr({
	    		x: 100,
	    		y: 5,
	    		width: 20,
	            height: 20
	    	}).add();
	    	
	    	var label = this.renderer.text(':100% ')
	        .attr({
	            zIndex: 6,
	            x: 120,
	            y: 65 - 45
	        })
	        .css({
	            color: '#000000',
	            fontSize: '14px'
	        })
	        .add();
		 });
		
	}
	
	function drawchartPlat(){
		
		var groupKeys = ['GUBUN','DISCOVERED_FROM'];
		var series = getDrillDownDataSeries2(
				'',
				dataListGroup ,
				groupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull:0}], //convert
				'DISCOVERED_FROM', 
				'CNT',
				{cd: 'GUBUN', name:'GUBUN'},
				{isGroupby: true}
		);
		
		$.each(series.series,function(index,s){
			if(s.name=='created'){
				//s.pointPadding = 0.3;
				s.color = '#e0e0e0';
			}else{
				s.pointPadding = 0.4;
				s.color = '#606060';
				s.dataLabels = {
						x:20,
						y:10
				};
				
				
			}
		
		});
		
		//카테고리 만들기
		var category1 = [];
		$.each(series.category,function(index,c){
			category1.push( c.split("_"));
		});
		var category2 = makeGroupCategory(category1);
		
		//tat insert
		$.each(category2,function(index1,cPhase){
			var phase = cPhase.name;
			$.each(cPhase.categories ,function(index2,cause){
				var tat =  getFilteredData(dataListGroup,[{col:'DISCOVERED_FROM', val:phase+'_'+cause}],[])[0].TAT;
				var newObj = {
						name:tat + ' days',
						categories:[cause]
				};
				cPhase.categories[index2] = newObj;
			});
		});
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		
		$('#container').highcharts({
	        chart: {
	            type: 'column',
	            zoomType:'x'
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
	        legend:{
	        	enabled:false
	        },
	        xAxis:{
	        	categories: category2 ,//series.category,
	        	labels:{
	        		groupedOptions:[{
	        			rotation: 0
	        		},{
	        			rotation: 0
	        		}],
	        		rotation:-90,
	        		formatter: function() {
						var rtn = '';
	        			
	        			if(typeof this.value == 'string'){
	        				rtn = this.value.split("_");
	        				var matchs = this.value.match(/[\d]+\sdays/i);
	        				if(matchs != null && matchs.length > 0){
	        					var split = this.value.split(" ");
	        					rtn = split[0] + "<br/>" + split[1];
	        				}
	        			}else{
	        				rtn =  this.value.name;
	        			}
	        			
	        			return rtn;
	        		}
	        	} 
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }
	            //,tickInterval:5
	        },
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y}</b> <br/>',
	            shared: true,
	            enabled: true
	        },
	        //legend: legend,
	        plotOptions: {
	            column: {
	            	grouping: false,
	            	borderWidth: 0,
	            	cursor: 'pointer' ,
	            	point:{	                	
	                	events:{
	                		click: function(e){
	                			var phase = this.category.parent.parent.name;
	                			var cause = this.category.name;
	                			var data = "";
	                			//$("#phase").val(phase);
	                			//$("#discoveredFrom").val(cause);
	                			gotoDetail(phase,cause);
	                			
	                		}
	                	}
	                },
	                //stacking: 'percent',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    useHTML: true,
	                    //format:'{point.y:.0f} ({point.percentage:.0f}%)'
	                    //x: 10,
	                    formatter:function(){
	                    	var rtn = "";
	                    	if(this.series.name == 'created'){
	                    		var resolved = this.series.chart.series[1].options.data[this.point.x].y;
	                    		if(this.y == resolved)
	                    			//rtn = "<span><img src=\"/dashboard/images/Check_Pic.jpg\"/ width=\"30px\" height=\"30px\" style=\"z-index:50\"> 완료</span>";
	                    			//rtn = "<div>완료</div>";
	                    			rtn = "<span><img src=\"/dashboard/images/Check_Pic.jpg\"/ width=\"30px\" height=\"30px\" style=\"z-index:50\"></span>";
	                    		else
	                    			rtn = this.y + '';
	                    	}else{
	                    		var created = this.series.chart.series[0].options.data[this.point.x].y;
	                    		if(created == this.y)
	                    			rtn = "";
	                    		else{
	                    			var percent = 0;
		                    		if(created > 0)
		                    			percent = (this.y/created)*100;
		                    		rtn = Highcharts.numberFormat(percent,1) + '%';
	                    		}
	                    		
	                    	}	                    	
	                    	return rtn;
	                    	
	                    },
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//gotoDetail(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		//after draw chart
	    	//100% 표시
	    	var image = this.renderer.image('/dashboard/images/Check_Pic.jpg')
	    	.attr({
	    		x: 100,
	    		y: 50,
	    		width: 20,
	            height: 20
	    	}).add();
	    	
	    	var label = this.renderer.text(':100% ')
	        .attr({
	            zIndex: 6,
	            x: 120,
	            y: 65
	        })
	        .css({
	            color: '#000000',
	            fontSize: '14px'
	        })
	        .add();
		 });
		
	}
	
	/**
	*
	*
	*/
	function makeGroupCategory(incoming){
	    
	    function recurseKeys(o) {
	        var arr = [],
	            k = Object.getOwnPropertyNames(o),
	            i, c;
	        for (i = 0; i < k.length; ++i) {
	            if (Object.getOwnPropertyNames(o[k[i]]).length)
	                c = {name: k[i]}, c['categories'] = recurseKeys(o[k[i]]);
	            else
	                c = k[i];
	            arr.push(c);
	        }
	        return arr;
	    }
	    
	    var i, j, o = {}, c, k;

	    for (i = 0; i < incoming.length; ++i) {
	        c = o;
	        for (j = 0; j < incoming[i].length; ++j) {
	            k = incoming[i][j];
	            if (!c[k]) c[k] = {};
	            c = c[k];
	        }
	    }

	    o = recurseKeys(o);
	    
	    return o;
	}
	
	function gotoDetail(phase,discoveredFrom){
		var newWin1 = window.open("", "jiraIssueCauseStatusList", "width=1000,height=380,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		var oFrm = document.getElementById("form");
		oFrm.action =  '/dashboard/jiraIssueCauseStatusList.do?phase='+phase+'&discoveredFrom='+discoveredFrom;
		oFrm.method = "post";
		oFrm.target = 'jiraIssueCauseStatusList'; 
	    oFrm.submit();
	    newWin1.focus();
			
	}
	
	function setChart(pseries) {
		var chart = $('#container').highcharts();
		if(pseries.parent != undefined)
			chart.parent = pseries.parent();
		else
			chart.parent = null;
		chart.xAxis[0].setCategories(pseries.category, false);
		while (chart.series.length > 0) {
            chart.series[0].remove(true);
        }
		$.each(pseries.series,function(){
			chart.addSeries(this,false);
		});
		/* chart.addSeries({
			name: name,
			data: data,
			color: color || 'white'
		}, false); */
		chart.redraw();
		goParentButton();
    }
	
	function goParentButton(){
		var chart = $("#container").highcharts();
		var width = $("#container").width();
		
		$("#buttonParent").remove();
		$("#contentParent").remove();
		
		if(chart.parent != undefined && chart.parent != null){
    		if(chart.parent.Oseries != undefined && chart.parent.Oseries != null)
    			if(chart.parent.Oseries.series != undefined && chart.parent.Oseries.series != null){
    				chart.renderer.label('Up To ' + chart.parent.DISCOVERED_FROM_PURE , width - 200 , 50)
    		        .attr({
    		            padding: 3,
    		            width: 180,
    		            //fill: Highcharts.getOptions().colors[0],
    		            fill: 'rgba(0, 0, 0, 0.75)',
    		            r:5,
    		            id:'buttonParent'
    		        })                            
    		        .css({
    		            color: 'white',
    		            cursor:'pointer',//,
    		            //stroke:'red'
    		            textAlign: 'center'
    		        })
    		        .on('click', function () {
    		        	
    		        	setChart(chart.parent.Oseries.series);

    		        })
    		        .add();
    				
    				//상위정보
    				var relateData = dataFilter(dataListGroup,[{col:'DISCOVERED_FROM_PURE',val:chart.parent.DISCOVERED_FROM_PURE}]);
    				var relateDataSum = groupbySum(relateData,['GUBUN'],'CNT');
    				var date = dataFilter(dataListGroup,[{co:"GUBUN",val:'resolved'},{col:'DISCOVERED_FROM_PURE',val:chart.parent.DISCOVERED_FROM_PURE}]);
    				var dateSum = groupbySum(relateData,['GUBUN'],'TAT')[0];
    				
    				var content  = "";
    				//var content = chart.parent.DISCOVERED_FROM_PURE;
    				//content += "<br/>  ";
    				content += "tat : " + dateSum.TAT + ' days';
    				$.each(relateDataSum,function(){
    					content += "<br/>" + this.GUBUN + " : " + this.CNT;
    				});
    				
    				chart.renderer.label(content , width - 200 , 70)
    		        .attr({
    		            padding: 3,
    		            width: 150,
    		            //height: 300,
    		            //fill: Highcharts.getOptions().colors[0],
    		            //fill: 'rgba(20, 174, 215, 0.75)',
    		            r:5,
    		            id:'contentParent'
    		        })                            
    		        .css({
    		            color: 'black',
    		            //cursor:'pointer',//,
    		            //stroke:'red'
    		            textAlign: 'left',
    		            fontWeight: 'bold'
    		        })
    		        .add();
    				
    			}
    	}
	}
	
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
		
		.highcharts-tooltip span {
		    background-color:white;
		    z-index:9999;  
		}
	</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="jiraPjtCode" name="jiraPjtCode" value="${param.jiraPjtCode}"/>
<input type="hidden" id="pjtCode" name="pjtCode" value="${param.pjtCode}"/>
<input type="hidden" id="pjtName" name="pjtName" value=""/>
<%-- <c:forEach items="${searchVO.pjtCodeList}" var="pjtCode" varStatus="status"> --%>
<c:forEach items="${paramValues.pjtCodeList}" var="pjtCode" varStatus="status">
	<input type="hidden" name="pjtCodeList" value="${pjtCode}"/>
</c:forEach>
<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
