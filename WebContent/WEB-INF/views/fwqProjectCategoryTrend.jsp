<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>FWQuality Trend</title>
    <link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css" />
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
    
    <script type="text/javascript" src="js/jqGrid/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="js/jqGrid/i18n/grid.locale-kr.js"></script>
    <!-- <script type="text/javascript" src="js/jquery.fileDownload.js" ></script> -->
    
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/i18n/grid.locale-en.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/jquery.jqGrid.src.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/json2.js"></script> -->
    
    <%-- 2. high charts --%>
    <!-- <script src="js/highcharts/src/highcharts.src.js"></script> -->
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. local --%>
	<script src="js/pms/resourceBySite.js"></script>
	<script src="js/pms/resourceByFunc.js"></script>
	
	<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" /> -->
	
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" />
	
	<link rel="stylesheet" type="text/css" href="/dashboard/css/stylesheet-image-based.css" />
	<script type="text/javascript">
	var fwqDataList = [];
	var scheduleDataList = [];
	var scheduleSeries = {};
	
	
	$(function () {
		subProjectList();
		//getDataByJson();
		$( window ).resize(function() {
			//adjustColor();
			buttons();
		});
	});
	
	function subProjectList(){
		$.ajax({
			url : "/dashboard/fwqSubProjectListJson.html",
			data: $("#form").serialize(),
			success : function(responseData){
				var projectList = responseData.dataList;
				var sb = [];
				var selected ="";
				
				$.each(projectList,function(i){
					var checked ="";
					if(this.PROJECT =='${param.project}') checked="checked";
					sb.push("<div>");
					sb.push("<input type='radio' name='project' value='"+ this.PROJECT +"' "+checked+" />" );
					sb.push("<label for='radio"+this.PROJECT+"'><span><span></span></span>");
					sb.push(this.PROJECT);
					sb.push("</label>")
					sb.push("</div>");
				});
				
				$("[name=projectDiv]").append(sb.join(""));
				if('${param.project}' ==''){
					$("input[name=project]:first").attr('checked',true);
				}
				
				$("[name=project]").change(function(){
					getDataByJson();
				});
				
				getDataByJson();
			}
			
		});
	}
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/fwqProjectCategoryTendJson.html",
			data: $("#form").serialize(),
			success : function(responseData){
				fwqDataList = responseData.fwqDataList;
				scheduleDataList = responseData.scheduleDataList;
				drawChart();
			}
		});
	}
	
	function drawChart(){		
		var groupKeys = ['GUBUN','MEASURE_DT'];
		
		var series = getDrillDownDataSeries2(
				'',
				fwqDataList ,
				groupKeys ,
				[], //filter
				[{col:'${param.category}',convert:'y',isnull:0},{col:'MEASURE_DT',convert:'x',datatype:'date'}], //convert
				'', 
				'${param.category}',
				{cd: 'GUBUN', name:'GUBUN'},
				{	isGroupby: false
					//, xSortColumn: 'MEASURE_DT' 		
				}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		var ymax = 100;
		var ytickInterval = 25;
		
		switch($('#category').val()) {
		    case 'POINT':
		    	ymax = 200;
		    	ytickInterval = 25;
		        break;
		    case 'MEASURE':
		    	ymax = 200;
		    	ytickInterval = 25;
		        break;
		    case 'STATIC_ANALYSIS':
		    case 'FUNCTION_SIZE':
		    case 'DUPLICATE':
		    case 'FUNCTION_PARAMETER':
		    case 'FUNC_PARAMETER':
		    case 'CODING_RULE':
		    	ymax = 20;
		    	ytickInterval = 5;
		    	break;
		    default:
		    	ymax = 25;
		    	ytickInterval = 5;
		}
		
		$('#container').highcharts('StockChart',{
	        chart: {
	            type: 'line'
	        },	        
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'${param.categoryLabel} Trend',
            	useHTML: true
	        },
	        exporting: {
	        	 buttons: {
                	contextButton: {
                    	enabled: false
                	}
	        	 }
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	type:'datetime',
	        	//categories: series.category ,
	        	labels:{
	        		enabled:false
	        	},
	        	tickLength: 0,
        		dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            } ,
        		range: 6 * 30 * 24 * 3600 * 1000 ,// six months
        		tickInterval: 30 * 24 * 3600 * 1000 // one months
	        	
	        },
	        rangeSelector: {
	        	//enabled:false
	        },
	        navigator: {
	        	//enabled:false,
	        	xAxis:{
	        		labels:{
	        			enabled:false
	        		}
	        	}
	        },
	        
	        yAxis: {
	        	
	        	min: 0,
	        	max: ymax,
	        	showLastLabel: true,
	        	tickInterval: ytickInterval,
	        	//endOnTick: true,
	            title: {
	                text: ''
	            },
	            opposite: false
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
	            valueSuffix: '' ,
	            pointFormat:'<span style="color:{series.color}"><b>{point.y}</b><br/>'/* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        legend: {
	        	enabled:false
	        },
	        plotOptions: {
	            line: {
	            	cursor: 'pointer' ,
	                //stacking: 'normal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                lineWidth:3,
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y}',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){	         
	                		
	                		var vCategory = $("#category").val();
	                		var vDate = Highcharts.dateFormat('%y%m%d',e.point.x);
	                		var vPjtcode = e.point.options.PJT_CODE;
	                		var vProject = e.point.options.PROJECT;
	                		
	                		switch($('#category').val()) {
		            		    case 'POINT':
		            		        break;
		            		    case 'MEASURE':
		            		        break;
		            		    case 'STATIC_ANALYSIS':
									var url = 'http://codesonar'+ e.point.options.CODESONAR_SVR +'.skhynix.com:7340/analysis/'+ e.point.options.CSV_NUM +'.html' ;
		            		    	//window.open(url, '_blank');
									urlExists(url,function(result){
										if(result){
											window.open(url, '_blank');
										}else{
											
// 											hs.htmlExpand(null, {
// 										        pageOrigin: {
// 										            x: e.pageX || e.clientX,
// 										            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
// 										        },
// 										        headingText: 'There is no corresponding web address',
// 										        //maincontentText: url,
// 										        width: 450,
// 										        height: 0
// 										    });
											
										}
										
		            		    	});
		            		    	break;
		            		    case 'FUNCTION_SIZE':
		            		    	//var url = 'http://codesonar'+ e.point.options.CODESONAR_SVR  +'.skhynix.com:7340/html?filter=2&metrics=LCode%3A100%2CvG%3A100&scope=aid%3A'+ e.point.options.CSV_NUM +'&query=&prj_filter=29&metric_filter=8' ;
		            		    	//var url = 'http://codesonar'+ e.point.options.CODESONAR_SVR  +'.skhynix.com:7340/analysis/?filter=2&metrics=LCode%3A100%2CvG%3A100&scope=aid%3A'+ e.point.options.CSV_NUM +'&query=&prj_filter=29&metric_filter=8' ;
		            		    	var url =  'http://codesonar'+ e.point.options.CODESONAR_SVR  +'.skhynix.com:7340/metric_search.html?filter=2&metrics=LCode%3A100%2CvG%3A100&scope=aid%3A' +  e.point.options.CSV_NUM ;
		            		    	//window.open(url, '_blank');
									urlExists(url,function(result){
										if(result){
											window.open(url, '_blank');
										}else{
											
// 											hs.htmlExpand(null, {
// 										        pageOrigin: {
// 										            x: e.pageX || e.clientX,
// 										            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
// 										        },
// 										        headingText: 'There is no corresponding web address',
// 										        //maincontentText: url,
// 										        width: 450,
// 										        height: 0
// 										    });
											
										}
										
		            		    	});
		            		    	break;
		            		    case 'DUPLICATE':
		            		    	//vDate = '160320';
		            		    	//var url = 'http://bamboo.skhynix.com:6060/CPD_Result/' + vProject + '-' + vDate + '.csv'
		            		    	var url = 'http://bamboo.skhynix.com:6060/CPD_Result/' + e.point.options.DUP_CSV_NAME ;
		            		    	
		            		    	//window.open(url, '_blank');
									urlExists(url,function(result){
										if(result){
											$("#download").attr("href",url);
											$("#download")[0].click();
										}else{
											
											hs.htmlExpand(null, {
										        pageOrigin: {
										            x: e.pageX || e.clientX,
										            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
										        },
										        headingText: 'There is no corresponding web address',
										        //maincontentText: url,
										        width: 450,
										        height: 0
										    });
											
										}
										
		            		    	});
		            		    	
		            		    	
		            		    	break;
		            		    case 'CODING_RULE':
		            		    	var url = 'http://bamboo.skhynix.com:6060/CI_Result/' + e.point.options.CSV_NAME ;
		            		    	//window.open(url, '_blank');
									urlExists(url,function(result){
										if(result){
											$("#download").attr("href",url);
											$("#download")[0].click();
										}else{
											
											hs.htmlExpand(null, {
										        pageOrigin: {
										            x: e.pageX || e.clientX,
										            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
										        },
										        headingText: 'There is no corresponding web address',
										        //maincontentText: url,
										        width: 450,
										        height: 0
										    });
											
										}
										
		            		    	});
		            		    	
		            		    	
		            		    	break;
		            		    case 'COMPLEXITY':
		            		    case 'ARCHITECTURE':
		            		    	var url =  'http://10.156.81.104:8080/covcpp/tracker/'+ e.point.options.LEGACY_PJT_NAME + '/1.0.0/summary.html' ;
		            		    	//window.open(url, '_blank');
									urlExists(url,function(result){
										if(result){
											window.open(url, '_blank');
										}else{
											
											hs.htmlExpand(null, {
										        pageOrigin: {
										            x: e.pageX || e.clientX,
										            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
										        },
										        headingText: 'There is no corresponding web address',
										        //maincontentText: url,
										        width: 450,
										        height: 0
										    });
											
										}
										
		            		    	});
		            		    	
		            		    	break;
		            		    case 'CODE_COVERAGE':
// 		            		    	if(e.point.options.PRODUCT != undefined){
// 		            		    		var url =  'http://172.31.189.145:81/BatmanMeters/GetMeter?product=' + e.point.options.PRODUCT + '&type=coverage&projectFilter=CodeCoverage_WB&html=true&webpage=true';
// 			            		    	window.open(url, '_blank');
// 		            		    	}
		            		    	if(e.point.options.LINK != undefined && e.point.options.LINK != ''){
		            		    		var url =  e.point.options.LINK;
			            		    	window.open(url, '_blank');
		            		    	}
		            		    	else{
											hs.htmlExpand(null, {
									        pageOrigin: {
									            x: e.pageX || e.clientX,
									            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
									        },
									        headingText: 'There is no corresponding web address',
									        //maincontentText: url,
									        width: 450,
									        height: 0
									    });
		            		    	}
		            		    	// java 에서는 400이 나온다.
// 									urlExists(url,function(result){
// 										if(result){
// 											window.open(url, '_blank');
// 										}else{
											
// 											hs.htmlExpand(null, {
// 										        pageOrigin: {
// 										            x: e.pageX || e.clientX,
// 										            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
// 										        },
// 										        headingText: 'There is no corresponding web address',
// 										        //maincontentText: url,
// 										        width: 450,
// 										        height: 0
// 										    });
											
// 										}
										
// 		            		    	});
		            		    	
		            		    	break;
		            		    case 'FUNC_PARAMETER':
		            		    	var url =  '/dashboard/fwqFunctionParameterPop.html?measureDt='+ e.point.options.REAL_MEASURE_DT + '&project='+ e.point.options.PROJECT_ORIGIN  ;
		            		    	var newWin1 = window.open("", "fwqFunctionParameterPop", "width=1200,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		            		    	var oFrm = document.getElementById("form");
		            		    	oFrm.action =  url;
		    						oFrm.method = "post";
		    						oFrm.target = 'fwqFunctionParameterPop'; 
		    					    oFrm.submit();		
		    					    newWin1.focus();	
		            		    	//window.open(url, '_blank');
									/* urlExists(url,function(result){
										if(result){
											var newWin1 = window.open(url, "fwqFunctionParameterPop", "width=1200,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
										}else{
											
											hs.htmlExpand(null, {
										        pageOrigin: {
										            x: e.pageX || e.clientX,
										            y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
										        },
										        headingText: 'There is no corresponding web address',
										        //maincontentText: url,
										        width: 450,
										        height: 0
										    });
											
										}
										
		            		    	}); */
		            		    	
		            		    	break;
		            		    case 'CODING_RULE':
		            		    	break;
		            		    default:
		            		}
                		} 
	                }
	                	
	            }
	           
	        },	        
	        series: series.series
	    },function(chart){
	    		buttons();
	    	}
		);
		
	}
	
	function openCodingRuleRawPop(){
		//var url =  '/dashboard/fwqFunctionParameterPop.html?measureDt='+ e.point.options.REAL_MEASURE_DT + '&project='+ e.point.options.PROJECT_ORIGIN  ;
		
		var date1 = minValue(fwqDataList,"MEASURE_DT");
		var date2 = maxValue(fwqDataList,"MEASURE_DT");
		$("#measureDt1").val(date1);
		$("#measureDt2").val(date2);
		var project = $("[name=project]:checked").val();
		//var url = '/dashboard/fwqCodingRulePop.html?project=' + project;
		var url = '/dashboard/fwqCodingRulePop.html';
    	var newWin1 = window.open("", "fwqCodingRulePop", "width=1200,height=940, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
    	var oFrm = document.getElementById("form");
    	oFrm.action =  url;
		oFrm.method = "post";
		oFrm.target = 'fwqCodingRulePop'; 
	    oFrm.submit();		
	    newWin1.focus();	
	}
	
	
	
	function urlExists(url, callback){
		$.ajax({
			url : "/dashboard/urlExistsJson.html",
			data: {url:url},
			success : function(response){
				callback(response.result)
				if(response.result){
					//callback();
				}else{
					//alert("There is no corresponding web address : " + url);
					
				}
			}
			
		});
	}
	
	function buttons(){
		var chart = $("#container").highcharts();
		var width = $("#container").width();
		
		$("#buttonRawData").remove();
		$("#buttonGuide").remove();
		
		if($('#category').val() == "CODING_RULE_AAA"){
			chart.renderer.label('Raw Data', width -20 - 80  -90 ,10 )
	        .attr({
	        	width:80,
	        	
	        	//'text-anchor':'middle',
	            padding: 3,
	            dx:10,
	            //fill: Highcharts.getOptions().colors[0],
	            fill: 'rgba(0, 0, 0, 0.75)',
	            r:5,
	            id:'buttonRawData'
	        })                            
	        .css({
	            color: 'white',
	            cursor:'pointer',//,
	            //stroke:'red'
	            textAlign: 'center'
	        })
	        .on('click', function () {
	        	//popSchedule();
	        	//window.open('http://confluence.skhynix.com/display/FSSW/FW+Quality+Guide','_blank');
	        	openCodingRuleRawPop();
	        })
	        .on('mouseover',function(e){
	        	/* text = chart.renderer.text('This confluence page could be an informative text', e.layerX - 300, e.layerY - 10)
		        .attr({
		            zIndex: 9999
		        })
		        .css({
		        	overflow: 'visible'
		        })
			    .add();
			
		        var box = text.getBBox();
		        //box surrounding the tool tip text                     
		        border = chart.renderer.rect(box.x - 5, box.y - 5, box.width + 10, box.height + 10, 5)
		            .attr({
		            fill: 'rgba(255, 255, 255, 0.95)',
		            stroke: 'blue',
		                'stroke-width': 1,
		            zIndex: 100
		        })
		        .add(); */
	        })
	        .on('mouseout', function () {
		        /* text.destroy();
		        border.destroy(); */
		    })
	        .add();
		}
		
		
		chart.renderer.label('Guide', width -20 - 80 ,10 )
        .attr({
        	width:80,
        	
        	//'text-anchor':'middle',
            padding: 3,
            dx:10,
            //fill: Highcharts.getOptions().colors[0],
            fill: 'rgba(0, 0, 0, 0.75)',
            r:5,
            id:'buttonGuide'
        })                            
        .css({
            color: 'white',
            cursor:'pointer',//,
            //stroke:'red'
            textAlign: 'center'
        })
        .on('click', function () {
        	//popSchedule();
        	//window.open('http://confluence.skhynix.com/display/FSSW/FW+Quality+Guide','_blank');
        	if($("#category").val() == "CODING_RULE"){
        		var isIE = /*@cc_on!@*/false || !!document.documentMode; // At least IE6
				if (isIE){
					var fileData = ['\ufeff' + "${pageContext.request.contextPath}" + "/MISRA Rule_0329.pptx"];
		            var blobObject = new Blob(fileData);
		            window.navigator.msSaveOrOpenBlob(blobObject, row.FILE_NAME);

				}else{
					var link = document.createElement('a');
					link.download = "MISRA Rule_0329.pptx";
					link.href = "${pageContext.request.contextPath}" + "/MISRA Rule_0329.pptx";
					//Firefox requires the link to be in the body
					document.body.appendChild(link);
					link.click();
					document.body.removeChild(link);
				}
        	}else{
        		window.open("http://confluence.skhynix.com/display/FSSW/FW+Quality+Guide", "", "left=300, top = 200, width=1300,height=700resizable=yes, scrollbars=yes, status=yes,menubar=yes");	
        	}
        	
        })
        .on('mouseover',function(e){
        	/* text = chart.renderer.text('This confluence page could be an informative text', e.layerX - 300, e.layerY - 10)
	        .attr({
	            zIndex: 9999
	        })
	        .css({
	        	overflow: 'visible'
	        })
		    .add();
		
	        var box = text.getBBox();
	        //box surrounding the tool tip text                     
	        border = chart.renderer.rect(box.x - 5, box.y - 5, box.width + 10, box.height + 10, 5)
	            .attr({
	            fill: 'rgba(255, 255, 255, 0.95)',
	            stroke: 'blue',
	                'stroke-width': 1,
	            zIndex: 100
	        })
	        .add(); */
        })
        .on('mouseout', function () {
	        /* text.destroy();
	        border.destroy(); */
	    })
        .add();
	}
	
	
	</script>
	<style type="text/css">
		.wrap_a{width:100%; overflow:hidden}
		.wrap_b{width:100%; overflow:hidden}
		.wrap_b_1{width:49%; height:auto ;overflow:hidden; float:left; margin-top:30px}
		.wrap_b_2{width:49%; height:auto ;overflow:hidden; float:right; margin-top:30px}
		
		<%--.box_gray{background:#f5f6fa; border:1px solid #e1e2e6; padding:15px; text-align:center; margin-bottom:8px } --%>
		.dashboard_box{/* border:1px solid #e1e2e6;  */}
		.cont_tit {float:none}
		iframe {
			   border: none;
			   frameborder:0;
			   
			   width: 100%;
			   height: 100%;
		}
		
		.container{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 85%;			
		}	
		
		.radioDiv div{
			display:inline;
		}	
		
	</style>
</head>
<body>
<form name="form" id="form">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjt_name" name="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" id="category" name="category" value="${param.category}"/>
<input type="hidden" id="categoryLabel" name="categoryLabel" value="${param.categoryLabel}"/>
<input type="hidden" id="measureDt1" name="measureDt1" value=""/>
<input type="hidden" id="measureDt2" name="measureDt2" value=""/>
<div class="pop_window">
	<div class="pop_tit_wrap">		
		<h2 class="pop_tit" style="margin-top:10px;">${param.pjt_name}</h2>
	</div>
	<div  name="projectDiv" class="radioDiv"  id="projectDiv" style="margin:10px 0 0 10px" ></div>
	<div  id="container" class="container"></div>
</div>
<a href="" download id="download" style="display: none;" >download</a>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
