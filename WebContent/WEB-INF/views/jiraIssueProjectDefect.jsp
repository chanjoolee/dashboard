<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>JIRA Issue Root Cause(Function)</title>
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
	<script src="js/pms/resourceBySite.js"></script>
	<script src="js/pms/resourceByFunc.js"></script>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	var dataList = [];
	var dataListSub = [];
	var dataListRaw = [];
	var regacyList = [];
	
	$(function () {
		getDataByJson();
		$( window ).resize(function() {
			goParentButton();
		});
	});
	
	function getDataByJson() {
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/jiraIssueProjectDefectJson.do",
			data: $("#form").serialize() ,
			success : function(responseData) {
				dataList = responseData.dataList;
				dataListSub = responseData.dataListSub;
				dataListRaw = responseData.dataListRaw;
				regacyList = responseData.regacyList;
				
				//setPmsPjtName(responseData.pmsPjtList);
				var chartMode = "${param.drillMode}"
				if(chartMode == "drill"){
					drawchart();
				}else{
					drawchartPlat();
				}
			}
		});
	}
	
	function setPmsPjtName(pmsPjtList) {
		$.each(dataList, function(index, obj) {
			var pmsPjt = dataFilter(pmsPjtList, [{col:'PJT_ID', val:obj.PROJECT_CODE}]);
			var nm = pmsPjt.PJT_NAME;
			obj.PROJECT_NAME = nm;
		});
	}
	
	function drawchart() {
		
		$.each(dataList,function(){
			this.GUBUN = 'xxx';
			this.appConfirmedCause = this.APPLICATION_NAME + '_' + this.CONFIRMED_CAUSE;
		});
		$.each(dataListSub,function(){
			this.GUBUN = 'xxx';
			this.appConfirmedCause = this.APPLICATION_NAME + '_' + this.CONFIRMED_CAUSE;
		});
		$.each(dataListRaw,function(){
			this.GUBUN = 'xxx';
			this.appConfirmedCause = this.APPLICATION_NAME + '_' + this.CONFIRMED_CAUSE;
		});
		
		var groupKeys = ['GUBUN','APPLICATION_NAME','appConfirmedCause']; // 시리즈로 나눌 컬럼을 첫번째로 해야한다.
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'GRP_CNT',convert:'y',isnull:null}], //convert
				'appConfirmedCause', 
				'GRP_CNT',
				{cd: 'GUBUN', name:'GUBUN'},
				{	isGroupby: true
				}
		);
		
		
		
		//Legend Sorting
		//series.series.sort(function(a, b) {
			//var aSeq = getFilteredData(dataList,[{col : 'CONFIRMED_CAUSE' , val :  a.data[0].CONFIRMED_CAUSE  }],[])[0].GRP_SEQ;
			//var bSeq = getFilteredData(dataList,[{col : 'CONFIRMED_CAUSE' , val :  b.data[0].CONFIRMED_CAUSE  }],[])[0].GRP_SEQ;
			//return aSeq > bSeq? 1 : -1;
		//});
		series.series[0].color = '#606060';
		series.xAxisRotation = 0;
 		sortObjects(series.series[0].data,['APPLICATION_NAME',['GRP_CNT','desc']]);
 		//카테고리 만들기
		var category1 = [];
		$.each(series.series[0].data,function(index,c){
			category1.push( c.appConfirmedCause.split("_"));
		});
		var category2 = makeGroupCategory(category1);
		series.category = category2;
		
// 		series.category = [];
// 		$.each(series.series[0].data,function(){
// 			series.category.push(this.CONFIRMED_CAUSE);
// 		});
		
		//drilldown데이타만들기. 여러단계이면 recursive function으로 변경.
		$.each(series.series,function(i,s){
			s.series = series;			
			$.each(s.data,function(j,data){
				this.Oseries = s;
			
				var relatedData = dataFilter(dataList,[{col:'appConfirmedCause',val:this.appConfirmedCause}]);
				var drillSeries = getDrillDownDataSeries2(
						'',
						relatedData ,
						['GUBUN','CONFIRMED_CAUSE','PJT_CODE','PJT_NAME'] ,
						[], //filter
						[{col:'GRP_CNT',convert:'y',isnull:0}], //convert
						'PJT_NAME', 
						'GRP_CNT',
						{cd: 'GUBUN', name:'GUBUN'},
						{isGroupby: true}
				);
				
				//color
				drillSeries.xAxisRotation = -45;
				drillSeries.series[0].color =s.color = '#606060';
				//sort
				sortObjects(drillSeries.series[0].data,[['GRP_CNT','desc']]);
				drillSeries.category = [];
				$.each(drillSeries.series[0].data,function(){
					drillSeries.category.push(this.PJT_NAME);
					
				});
				
				
				
				//parent
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
	            type: 'column'
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
	        	categories: series.category
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }	            
	        },
	        tooltip: {
	        	formatter: function() {
	        		var point = this.point;
	        		var txt = '';
	        		var tipList = [];
	        		if(point.series.chart.parent != undefined)
	        			tipList = dataFilter(dataListSub, [{col:'PJT_CODE', val:point.PJT_CODE},{col:'CONFIRMED_CAUSE', val:point.CONFIRMED_CAUSE}]);
	        		else
	        			tipList = dataFilter(dataListSub, [{col:'appConfirmedCause', val:point.appConfirmedCause}]);
	        		
	        		var tipList1 = groupbySum(tipList,['PHASE'],'GRP_CNT');
	        		sortObjects(tipList1,['PHASE']);
	        		txt = '<b>' + this.x + '</b>';
	        		$.each(tipList1, function() {
	        			txt += '<br><span style="color:' + phaseColor[this.PHASE] + '">' + this.PHASE + '</span> : <b>' + this.GRP_CNT + '</b>';
	        		});
					
	        		return txt;
	        	} 
	        },
	        plotOptions: {
	            column: {
	            	cursor: 'pointer',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y}',
	                    color: 'black'
	                },
	                //allowPointSelect: true,
	                point:{	                	
	                	events:{
	                		click: function(e){
								var point = e.point;
								if (this.drillSeries) { // drill down
									/* $.each(point.series.data,function(){
										this.selected = false;
									});
									point.options.selected = true; */
									point.select(true,false);
                                    setChart(this.drillSeries);
                                } else {
                                	point.select(true,false);
		    						var url = "http://jira.skhynix.com/issues/?jql=";
		    						url += "(";
		    						url += "(\"issue from\" is not EMPTY or \"Discovered from\" is not EMPTY)";
		    						var confirmedCause = e.point.CONFIRMED_CAUSE;

		    						if(confirmedCause != 'N/A')
		    							url += " and \"Confirmed cause\"=\"" +confirmedCause +"\"";
		    						else{
		    							
		    							/* url += " and issuetype not  in (Debug, \"Non Visual Defect\", \"FVT Fail\", \"Function Fail\", Bug,";
		    							url += "\"Trouble shooting\", \"Failure\", \"Defect Item\", BM, \"Verification Fail\", Fail, \"NAND Defect\", FA, \"Booting Fail\", \"Aging Fail\", ";
		    							url += "\"Develop F/A\", \"QVT Fail\", \"CS Test F/A\", \"Customer RMA\", \"Mass F/A\", \"Manufacture Fail\", \"DV_REPORT\", \"D/L Fail\", \"SPOR Fail\", \"Fault Injection Fail\")";
		    							url += " "; */
		    							// N/A이 경우 issue_num을 넘긴다.
		    							url += " and \"key\" in(";
		    							var keys = groupbyCount(rawData,['PROJECT_KEY','ISSUE_NUM']);
		    							$.each(keys,function(i){
		    								if(i>0)
		    									url += ",";
		    								url += "\"" + this.PROJECT_KEY +"-"+ this.ISSUE_NUM+ "\"";
		    							});
		    							url += ")";
		    						}
	    							
		    						url += " and \"resolution\"  is not EMPTY ";
		    						
		    						// 프로젝트
		    						var regacy = dataFilter(regacyList,[{col:'PJT_NAME', val: point.PJT_CODE}]);
		    						url += " and \"project\" in(";
		    						$.each(regacy,function(i){
		    							if(i>0)
		    								url += ",";
		    							if(this.LEGACY_PJT_KEY == "SAF")
		    								url += "\"SAFE\"";
		    							else
		    								url += "\"" + this.LEGACY_PJT_NAME + "\"";
		    						});
		    						url += ")";
		    						
		    						// phase
		    						var tipList = dataFilter(dataListSub, [{col:'PJT_CODE', val:point.PJT_CODE},{col:'CONFIRMED_CAUSE', val:point.CONFIRMED_CAUSE}]);
		    						url += " and \"PMS Phase\" in(";
		    						$.each(tipList, function(i) {
		    							if(i>0)
		    								url += ",";
		    							url += "\"" + this.PHASE + "\"";
		    		        		});
		    						url += ")";
		    						url += "	)";
									
		    						var safProjects = dataFilter(dataListRaw,
										[
											{col:'PJT_CODE',val: point.PJT_CODE},
											{col:'CONFIRMED_CAUSE',val: point.CONFIRMED_CAUSE},
										 	{col:'PROJECT_KEY',val:'SAF'}
										]
									);
		    						var isSafe = arrayContain(safProjects,[{col:'PROJECT_KEY',val:'SAF'}]);
									if(isSafe){
										
										url += " or  (\"key\" in(";
										$.each(safProjects,function(i){
											if(i>0)
												url += ",";
											url += "\"" + this.PROJECT_KEY +"-"+ this.ISSUE_NUM+ "\"";
										});
										url += "	))";
									}
									
									
		    							
		    			    		hsClick(url,this);
                                }
	                		}
	                	}
	                }
	            }
	        },
	        series: series.series
	    },function(chart){
	    		//after draw chart
		    }
		);		
	}
	
	
function drawchartPlat() {
		
		var groupKeys = ['CONFIRMED_CAUSE','PJT_NAME']; // 시리즈로 나눌 컬럼을 첫번째로 해야한다.
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'GRP_CNT',convert:'y',isnull:null}], //convert
				'PJT_NAME', 
				'GRP_CNT',
				{cd: 'CONFIRMED_CAUSE', name:'CONFIRMED_CAUSE'},
				{	isGroupby: false
				}
		);
		
		//Legend Sorting
		series.series.sort(function(a, b) {
			var aSeq = getFilteredData(dataList,[{col : 'CONFIRMED_CAUSE' , val :  a.data[0].CONFIRMED_CAUSE  }],[])[0].GRP_SEQ;
			var bSeq = getFilteredData(dataList,[{col : 'CONFIRMED_CAUSE' , val :  b.data[0].CONFIRMED_CAUSE  }],[])[0].GRP_SEQ;
			return aSeq > bSeq? 1 : -1;
		});
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		$('#container').highcharts({
	        chart: {
	            type: 'column'
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
	        xAxis:{
	        	categories: series.category
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }	            
	        },
	        tooltip: {
	        	formatter: function() {
	        		var point = this.point;
	        		var txt = '';
	        		
	        		var tipList = dataFilter(dataListSub, [{col:'PJT_CODE', val:point.PJT_CODE},{col:'CONFIRMED_CAUSE', val:point.CONFIRMED_CAUSE}]);
	        		txt = '<b>' + this.x + '</b>';
	        		$.each(tipList, function() {
	        			txt += '<br><span style="color:' + phaseColor[this.PHASE] + '">' + this.PHASE + '</span> : <b>' + this.GRP_CNT + '</b>';
	        		});
					
	        		return txt;
	        	}
	        },
	        plotOptions: {
	            column: {
	            	cursor: 'pointer',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y}',
	                    color: 'black'
	                },
	                point:{	                	
	                	events:{
	                		click: function(e){
								var point = e.point;
	    						var url = "http://jira.skhynix.com/issues/?jql=";
	    						url += "(";
	    						url += "(\"issue from\" is not EMPTY or \"Discovered from\" is not EMPTY)";
	    						var confirmedCause = e.point.CONFIRMED_CAUSE;

	    						if(confirmedCause != 'N/A')
	    							url += " and \"Confirmed cause\"=\"" +confirmedCause +"\"";
	    						else{
	    							
	    							/* url += " and issuetype not  in (Debug, \"Non Visual Defect\", \"FVT Fail\", \"Function Fail\", Bug,";
	    							url += "\"Trouble shooting\", \"Failure\", \"Defect Item\", BM, \"Verification Fail\", Fail, \"NAND Defect\", FA, \"Booting Fail\", \"Aging Fail\", ";
	    							url += "\"Develop F/A\", \"QVT Fail\", \"CS Test F/A\", \"Customer RMA\", \"Mass F/A\", \"Manufacture Fail\", \"DV_REPORT\", \"D/L Fail\", \"SPOR Fail\", \"Fault Injection Fail\")";
	    							url += " "; */
	    							// N/A이 경우 issue_num을 넘긴다.
	    							url += " and \"key\" in(";
	    							var keys = groupbyCount(rawData,['PROJECT_KEY','ISSUE_NUM']);
	    							$.each(keys,function(i){
	    								if(i>0)
	    									url += ",";
	    								url += "\"" + this.PROJECT_KEY +"-"+ this.ISSUE_NUM+ "\"";
	    							});
	    							url += ")";
	    						}
	    						
	    						url += " and \"resolution\"  is not EMPTY ";
	    						
	    						// 프로젝트
	    						var regacy = dataFilter(regacyList,[{col:'PJT_NAME', val: point.PJT_CODE}]);
	    						url += " and \"project\" in(";
	    						$.each(regacy,function(i){
	    							if(i>0)
	    								url += ",";
	    							if(this.LEGACY_PJT_KEY == "SAF")
	    								url += "\"SAFE\"";
	    							else
	    								url += "\"" + this.LEGACY_PJT_NAME + "\"";
	    						});
	    						url += ")";
	    						
	    						// phase
	    						var tipList = dataFilter(dataListSub, [{col:'PJT_CODE', val:point.PJT_CODE},{col:'CONFIRMED_CAUSE', val:point.CONFIRMED_CAUSE}]);
	    						url += " and \"PMS Phase\" in(";
	    						$.each(tipList, function(i) {
	    							if(i>0)
	    								url += ",";
	    							url += "\"" + this.PHASE + "\"";
	    		        		});
	    						url += ")";
	    						url += "	)";
								
	    						var safProjects = dataFilter(dataListRaw,
									[
										{col:'PJT_CODE',val: point.PJT_CODE},
										{col:'CONFIRMED_CAUSE',val: point.CONFIRMED_CAUSE},
									 	{col:'PROJECT_KEY',val:'SAF'}
									]
								);
	    						var isSafe = arrayContain(safProjects,[{col:'PROJECT_KEY',val:'SAF'}]);
								if(isSafe){
									
									url += " or  (\"key\" in(";
									$.each(safProjects,function(i){
										if(i>0)
											url += ",";
										url += "\"" + this.PROJECT_KEY +"-"+ this.ISSUE_NUM+ "\"";
									});
									url += "	))";
								}
	    							
	    						
		    						
	    						
	    			    		hsClick(url,this);
	                			
	                		}
	                	}
	                }
	            }
	        },
	        series: series.series
	    },function(chart){
	    		//after draw chart
		    }
		);		
	}
	
	
	function setChart(pseries) {
		var chart = $('#container').highcharts();
		if(pseries.parent != undefined)
			chart.parent = pseries.parent();
		else
			chart.parent = null;
		chart.xAxis[0].setCategories(pseries.category, false);
		chart.xAxis[0].options.labels.rotation = pseries.xAxisRotation;
		//chart.xAxis[0].update({labels:{rotation:rotationValue}});
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
		/* if(selectedPoint != undefined && selectedPoint != null){
			
		} */
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
    				chart.renderer.label('Up To ' + chart.parent.appConfirmedCause.split('_').join(', ') , width - 300 , 50)
    		        .attr({
    		            padding: 3,
    		            width: 250,
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
    				var tipList = [];
    				tipList = dataFilter(dataListSub, [{col:'appConfirmedCause', val: chart.parent.appConfirmedCause}]);
    				var tipList1 = groupbySum(tipList,['PHASE'],'GRP_CNT');
    				sortObjects(tipList1,['PHASE']);
    				var content  = "TOTAL : " + chart.parent.GRP_CNT;
    				//var content = chart.parent.CONFIRMED_CAUSE;
    				//content += "<br/>  ";
    				$.each(tipList1,function(){
    					content +=  "<br/>" +  this.PHASE + " : " + this.GRP_CNT ;
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
	
	function realignLabels(serie) {

	    $.each(serie.points, function (j, point) {
	        if (!point.dataLabel) return true;

	        if(point.drillSeries != undefined && point.drillSeries != null){
	        	 point.dataLabel.attr({
		                rotation: 270
		            });
	        }
	    });
	};
	
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
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="jiraPjtCode" name="jiraPjtCode" value="${param.jiraPjtCode}"/>
<input type="hidden" id="pjtCode" name="pjtCode" value="${param.pjtCode}"/>
<input type="hidden" id="pjtName" name="pjtName" value=""/>
<c:forEach items="${paramValues.pjtCodeList}" var="pjtCode" varStatus="status">
	<input type="hidden" name="pjtCodeList" value="${pjtCode}"/>
</c:forEach>
<div id="container" class="container"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
