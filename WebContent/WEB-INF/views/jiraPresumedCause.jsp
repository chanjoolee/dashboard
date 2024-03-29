<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>추정원인대비확정원인</title>
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
	var dataList = [];
	var dataListGroup = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/jiraPresumedCauseJson.do",
			data: $("#form").serialize() ,
			success : function(responseData){
				//dataList = responseData.dataList;
				dataListGroup = responseData.dataListGroup;
				drawchart();
			}
		});
	}
	
	function drawchart(){
		
		var groupKeys = ['GUBUN','PRESUMED_CAUSE'];
		var series = getDrillDownDataSeries2(
				'',
				dataListGroup ,
				groupKeys ,
				[], //filter
				[{col:'CNT',convert:'y',isnull:0}], //convert
				'PRESUMED_CAUSE', 
				'CNT',
				{cd: 'GUBUN', name:'GUBUN'},
				{isGroupby: true}
		);
		
		$.each(series.series,function(index,s){
			if(s.name=='presumed'){
				//s.pointPadding = 0.3;
				s.color = '#e0e0e0';
				s.order = 1;
			}else{
				s.pointPadding = 0.4;
				s.color = '#606060';
				s.dataLabels = {
						
						x:20,
						y:10
				};	
				s.order = 2;
			}
			
		});
		
		sortObjects(series.series,['order']);
		
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
				var tat =  getFilteredData(dataListGroup,[{col:'PRESUMED_CAUSE', val:phase+'_'+cause}],[])[0].TAT;
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
	        	enabled: true,
	        	layout: 'vertical',
	            align: 'right',
	            verticalAlign: 'top',
	            x: -150,
	            y: 0,
	            floating: true,
	            borderWidth: 1,
	            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF',
	            labelFormatter: function(){
	            	//alert("aaa");
	            	var len = this.name.length;
	            	if(this.name == 'presumed'){
	            		return '추정 원인';
	            	}            		
	            	else
	            		return '확정 원인';
	            }
	            //,useHTML: true
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
	                			//$("#cause").val(cause);
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
	                    	if(this.series.name == 'presumed'){
	                    		var resolved = this.series.chart.series[1].options.data[this.point.x].y;
	                    		if(this.y == resolved)
	                    			//rtn = "<span><img src=\"/dashboard/images/Check_Pic.jpg\"/ width=\"30px\" height=\"30px\" style=\"z-index:50\"> 완료</span>";
	                    			//rtn = "<div>완료</div>";
	                    			rtn = this.y + '';
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
	
	function gotoDetail(phase,cause){
		var newWin1 = window.open("", "jiraIssueCauseStatusList", "width=1000,height=380,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		var oFrm = document.getElementById("form");
		oFrm.action =  '/dashboard/jiraIssueCauseStatusList.do?phase='+phase+'&cause='+cause;
		oFrm.method = "post";
		oFrm.target = 'jiraIssueCauseStatusList'; 
	    oFrm.submit();
	    newWin1.focus();
			
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
