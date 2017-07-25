<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>Root Cause TAT</title>
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
	var dataListRaw = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson() {
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/jiraIssueRootCauseTatJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				dataListRaw = responseData.dataListRaw;
				
				drawchart();
			}
		});
	}
	
	function drawchart() {
		
		var groupKeys = ['IMSI_SERIES'];
		var notNullList = dataFilter(dataList, [{col:'GRP_SEQ', val:1},{col:'PHASE_NULL', val:'N'}]);
		var categoryDataList = [];
		if(notNullList.length > 0) {
			categoryDataList = dataFilter(dataList, [{col:'GRP_SEQ', val:1}]);
		}
		var series = getDrillDownDataSeries2(
				'',
				categoryDataList , 									// 데이타원본
				groupKeys , 										// grouping, sorting 순서
				[], 												// filter
				[{col:'CAUSE_TERM_AVG', convert:'y', isnull:null}], 	// convert -> col 변수를 y 변수로 치환한다 (챠트에서 y 변수를 인식)
				'ROOT_CAUSE', 										// x축
				'', 												// y값이 되는 컬럼, groupby시 에만 의미있음
				{cd: 'IMSI_SERIES', name:'IMSI_SERIES'},			// series 없으므로 가상의 Column 정의
				{isGroupby:false, xSortColumn: 'ROOT_CAUSE_SEQ'}
		);
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		$('#container').highcharts({
	        chart: {
	            type: 'bar'
	        },
	        colors: ['#5f9ea0'],
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
				min : 0,
	            title: {
	            	enabled: true,
	                text: '<b>Average</b>',
	                align: 'high',
	                style: {
	                    fontWeight: 'normal'
	                }
	            },
	            labels: {
	                overflow: 'justify'
	            },
	            visible: false
	        },	        
	        tooltip: {
	        	formatter: function() {
	        		var txt = '';
	        		var phaseList = dataFilter(dataList, [{col:'ROOT_CAUSE', val:this.x}]);
	        		
	        		txt = '<b>' + this.x + '</b>';
	        		$.each(phaseList, function() {
	        			if(this.PHASE != undefined) {
	        				txt += '<br><span style="color:' + phaseColor[this.PHASE] + '">' + this.PHASE + "</span> : <b>" + this.PHASE_TERM_AVG + "</b> (" + this.PHASE_TERM_TOT + " / " + this.PHASE_CNT + ")";
	        			} 
	        		});

	        		return txt;
	        	},
	        	shared: true,
	        	enabled: true
	        },
	        legend: {
	        	enabled: false
	        },
	        plotOptions: {
	            bar: {
	            	cursor: 'pointer' ,
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    color: 'black',
	                    //format: '<b>{point.y}</b>'
	                	formatter: function() {
	                		var txt = '';
	                		if(this.y > 0) {
	                			txt = '<b>' + this.y + '</b><br>(' + this.point.CAUSE_TERM_TOT + ' / ' + this.point.CAUSE_CNT + ')';
	                		}
	                		return txt;
	                	}
	                }	,
	                point:{	                	
	                	events:{
	                		click: function(e){
								var point = e.point;
	    						var url = "http://jira.skhynix.com/issues/?jql=";
	    						url += "(";
	    						url += "(\"issue from\" is not EMPTY or \"Discovered from\" is not EMPTY)";
	    						var confirmedCause = e.point.ROOT_CAUSE;
	    						
	    						var rawdata = dataFilter(dataListRaw,
    									[
    									 {col:'CONFIRMED_CAUSE',val: point.ROOT_CAUSE}
    									]
    							); 
	    						
	    						if(confirmedCause == 'N/A'){
	    							// N/A이 경우 issue_num을 넘긴다.
	    							url += " and \"key\" in(";
	    							var keys = groupbyCount(rawdata,['PROJECT_KEY','ISSUE_NUM']);
	    							$.each(keys,function(i){
	    								if(i>0)
	    									url += ",";
	    								url += "\"" + this.PROJECT_KEY +"-"+ this.ISSUE_NUM+ "\"";
	    							});
	    							url += ")";
	    							url += ")";
	    						}
	    						else{
	    							url += " and \"Confirmed cause\"=\"" +confirmedCause +"\"";
	    							//url += " and \"Phase (PMS)\"=\"" + phaseId+"\"";
		    						//url += " and \"Presumed cause\"=\"" + rowData.presumed +"\"";
		    						url += " and \"resolution\"  is not EMPTY ";
		    						
		    						// project
		    						url += " and \"project\" in (";
		    						$.each(groupbyCount(rawdata , ['PROJECT','PROJECT_KEY'] ), function(i) {
		    							if(i>0)
		    								url += ",";
		    							if(this.PROJECT_KEY == 'SAF')
		    								url += "\"SAFE\"";
		    							else
		    								url += "\"" + this.PROJECT + "\"";
		    		        		});
		    						url += ")";
		    						
		    						// phase
		    						url += " and \"PMS Phase\" in (";
		    						$.each(groupbyCount(rawdata , ['PHASE'] ), function(i) {
		    							if(i>0)
		    								url += ",";
		    							url += "\"" + this.PHASE + "\"";
		    		        		});
		    						url += ")";
		    						url += ")";
		
		    						var isSafe = arrayContain(rawdata,[{col:'PROJECT_KEY',val:'SAF'}]);
		    						var safProjects = dataFilter(rawdata,
											[
											 	{col:'PROJECT_KEY',val:'SAF'}
											]
										);
									if(isSafe){
										
										url += " or  (\"key\" in(";
										$.each(safProjects,function(i){
											if(i>0)
												url += ",";
											url += "\"" + this.PROJECT_KEY +"-"+ this.ISSUE_NUM+ "\"";
										});
										url += "	))";
									}
	    						}
	    							
	    						url += " order by key asc ";
	    						
		    						
	    						
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
