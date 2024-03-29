<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>projectOneStackByPCntDate</title>
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
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. local --%>
	<script src="js/pms/resourceBySite.js?version=16"></script>
	<script src="js/pms/resourceByFunc.js?version=16"></script>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	var dataListOrigine = [];
	var dataList = [];
	var dataProject = {data:[],pkeys:[]};
	var dataProjectSite = {data:[],pkeys:[]};
	var dataProjectFunction = {data:[],pkeys:[]};
	var dataSite = {data:[],pkeys:[]};
	var dataFunction = {data:[],pkeys:[]};
	
	//pms에서 검색조건을 만들기 위해서 
	var searchProject = [];
	var searchSite = [];
	var searchFunction	= []
	
	var currentFunc = null;
	var currentArg = [];
	
	
	var gridModel = [
		{name:'id',index:'id', width:60, sorttype:"int" ,align:'center'},
		{ label: 'project', name: 'PJT_NAME', width: 75 ,align:'center'/* , cellattr: arrtSetting */},
		{ label: 'site', name: 'NATL_NAME', width: 75 ,align:'center'/*,  cellattr: arrtSetting */},
		{ label: 'upFunction', name: 'UP_PJT_FUNC_NAME', width: 100,align:'center' /* , cellattr: arrtSetting */},
		{ label: 'function', name: 'PJT_FUNC_NAME', width: 100,align:'center' /* , cellattr: arrtSetting */},
		{ label: 'month', name: 'YYYYMM', width: 90,align:'center' },
		{ label: 'resource', name: 'MM_RESULT', width: 100 ,align:'right'},
		{ label: '', name: '',width: null }
		// sorttype is used only if the data is loaded locally or loadonce is set to true
		//{ label: 'Quantity', name: 'Quantity', width: 80, sorttype: 'number' }                   
	];
	
	var gridModel_site_project_func = [
   		{name:'id',index:'id', width:60, sorttype:"int" ,align:'center'},
   		{ label: 'site', name: 'NATL_NAME', width: 75 ,align:'center'/*,  cellattr: arrtSetting */},
   		{ label: 'project', name: 'PJT_NAME', width: 75 ,align:'center'/* , cellattr: arrtSetting */},   
   		{ label: 'upFunction', name: 'UP_PJT_FUNC_NAME', width: 100,align:'center' /* , cellattr: arrtSetting */},
   		{ label: 'function', name: 'PJT_FUNC_NAME', width: 100,align:'center' /* , cellattr: arrtSetting */},   		
   		{ label: 'month', name: 'YYYYMM', width: 90,align:'center' },
   		{ label: 'resource', name: 'MM_RESULT', width: 100 ,align:'right'},
   		{ label: '', name: '',width: null }
   		// sorttype is used only if the data is loaded locally or loadonce is set to true
   		//{ label: 'Quantity', name: 'Quantity', width: 80, sorttype: 'number' }                   
   	];
	
	var gridModel_site_func_project = [
   		{name:'id',index:'id', width:60, sorttype:"int" ,align:'center'},
   		{ label: 'site', name: 'NATL_NAME', width: 75 ,align:'center'/*,  cellattr: arrtSetting */},
   		{ label: 'upFunction', name: 'UP_PJT_FUNC_NAME', width: 100,align:'center' /* , cellattr: arrtSetting */},
   		{ label: 'function', name: 'PJT_FUNC_NAME', width: 100,align:'center' /* , cellattr: arrtSetting */},
   		{ label: 'project', name: 'PJT_NAME', width: 75 ,align:'center'/* , cellattr: arrtSetting */},  		
   		{ label: 'month', name: 'YYYYMM', width: 90,align:'center' },
   		{ label: 'resource', name: 'MM_RESULT', width: 100 ,align:'right'},
   		{ label: '', name: '',width: null }
   		// sorttype is used only if the data is loaded locally or loadonce is set to true
   		//{ label: 'Quantity', name: 'Quantity', width: 80, sorttype: 'number' }                   
   	];
	
	$(function () {
		//projectListByAjax();
		//getDataByJsonProjectAll();
		//getDataByJson();
		getDataByJsonSiteAll();
		
		$( window ).resize(function() {
			adjustGrid();
		});
	});
	
	function legentControl(){
		var chart = $('#container').highcharts(); 
		if(chart == undefined) 
			return;
		
        var legend = chart.legend; 
        
        var btn = $("#updateLegend");
        if($("#legendFloat").val() == "true")
        	$("#legendFloat").val("false");
        else
        	$("#legendFloat").val("true");
        
       drawChart(responseDataG);
	}
	
	
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/projectListByJson.do",
			//data: {},
			data: $("#form").serialize(),
			success : function(responseData){
				var projectList = responseData.projectList;
				var paramPjtcode = "${param.pjt_code}" ;
				var selected ="";
				for(var i=0; i<projectList.length ; i++){					
					var pjt_code = projectList[i].PJT_CODE;
					selected ="";
					if(paramPjtcode==pjt_code)
						selected = "selected";
					$("#sProject").append("<option value=\""+ projectList[i].PJT_CODE +"\"  "+ selected +">" + projectList[i].PJT_CODE +"</option>" );	
				}
				
				if(paramPjtcode != "")
					getDataByJson();
			}
		});
	}
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/pmsResourceJson.do",
			//data: {PJT_CODE: $("#sProject").val() },
			data: $("#form").serialize(),
			success : function(responseData){
				dataList = responseData.data;
				//convertLastDate(dataList,'YYYYMM');
				dataListOrigine = $.merge([],dataList);
				
				//makeChartData();
				//drawchartByAllProject();
				//drawchartByAllSite();
				
				
				// data loadingd을 빠르게 하기위해 
				/* var searchOption = $("#category").val();	
				
				if(searchOption == 'project')
					drawchartByAllProject();
				else if(searchOption == 'site')
					drawchartByAllSite();
				else
					drawchartByAllFunc(); */
				
				//makePmsSearch(responseData.searchs);
				
				
			}
		});
	}
	
	/**
	* 데이타로딩이 많이 걸리므로 처음에 groupby 된 데이타를 가져오고
	* 일단 화면 로딩 후 rawdata를 가져온다.
	**/
	function getDataByJsonProjectAll(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/pmsResourceProjectAllJson.do",
			//data: {PJT_CODE: $("#sProject").val() },
			data: $("#form").serialize(),
			success : function(responseData){
				dataProject = responseData.data;
				makePmsSearch(responseData.searchs);
				
				$("#loader").show();
		    	setTimeout(function(){			
		    		drawchartByAllProject();
				},50);
		    	
				getDataByJson();
			}
		});
	}
	
	/**
	* 데이타로딩이 많이 걸리므로 처음에 groupby 된 데이타를 가져오고
	* 일단 화면 로딩 후 rawdata를 가져온다.
	**/
	function getDataByJsonSiteAll(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/pmsResourceSiteAllJson.do",
			//data: {PJT_CODE: $("#sProject").val() },
			data: $("#form").serialize(),
			success : function(responseData){
				dataProject = responseData.data;
				//convertLastDate(dataProject,'YYYYMM');
				makePmsSearch(responseData.searchs);
				drawchartByAllSite();
				getDataByJson();
			}
		});
	}
	
	/**
	 * 
	 */
	function makePmsSearch(pArray){
		// 01. search project
		var groupKeys = ['APPLICATION','PJT_ID','PJT_NAME'];
		searchProject = getDrillDownDataSeries2(
				'',
				pArray ,
				groupKeys ,
				[],
				[],
				'', // 없다고 xCol을 삽입하지 안는다.
				'TAT',
				{cd: 'APPLICATION', name:'APPLICATION'}
		);
		
		$.each(searchProject.series,function(i){
			if (this.id == "Mobile Solution" )
				this.order = 10;
			else if(this.id == "eSSD")
				this.order = 20;
			else if(this.id == "cSSD")
				this.order = 30;
			else 
				this.order = 100;
		});
		sortObjects(searchProject.series,['order','id']);
		
		
		// 02. search functon
		groupKeys = ['UP_PJT_FUNC_NAME','UP_PJT_FUNC_NAME'];
		searchFunction = groupbySum(pArray,groupKeys,'TAT');
		sortObjects(searchFunction,['UP_PJT_FUNC_NAME']);
		
		// 03. search site
		groupKeys = ['NATL_NAME','NATL_NAME'];
		searchSite = groupbySum(pArray,groupKeys,'TAT');
		
		if(parent.makeSearch)
			parent.makeSearch();
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
	
	function getCodesonarPriorityCsvLink(pjtCode){
		var linkUrl = "";
		$.ajax({
			url : "/dashboard/codesonarPriorityCsvLinkJson.do",
			async: false,
			data: {PJT_CODE: pjtCode },
			//data: $("#form").serialize(),
			success : function(responseData){
				var list = responseData.data;
				for(var i=0;i<list.length;i++){
					var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
					var csvnum = list[i].CSV_NUM;
					linkUrl +="<a href='"+"http://"+svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=priority="+"\"P0: High\""+"' target='_blank'>"+list[i].PJT_CODE+"</a>";
					linkUrl +="</br>";
				}
			}
		});
		return linkUrl;
	}

	
	function filteredDrawChart(filters,searchOption){
		if(dataListOrigine.length == 0)
			return;
		
		dataList = dataFilter(dataListOrigine, filters);
		
		if(searchOption != ''){
			if(searchOption == 'project'){
				$("#loader").show();
		    	setTimeout(function(){			
		    		drawchartByAllProject();
				},50);
			}else if(searchOption == 'site')
				drawchartByAllSite();
			else
				drawchartByAllFunc();
		}else{
			$("#loader").show();
			setTimeout(function(){
				currentFunc.apply({},currentArg);
				$("#loader").hide();
			},50);
		}
		
	
	}
	
	function drawchartByAllProject(){
		
		currentFunc = drawchartByAllProject;
		currentArg = arguments;
		
		var groupKeys = ['PJT_ID','PJT_NAME','YYYYMM'];
		
		var data = [];
		if(dataListOrigine.length == 0){
			data = dataProject;
			//console.log('data = dataProject;');
		}
		else{
			data  = dataList;
			//console.log('data  = dataList;');
		} 
			
		
		
		/* var series = getDrillDownDataSeries(
				'',
				data,
				groupKeys,
				[],
				'YYYYMM',
				'MM_RESULT',
				{cd: 'PJT_ID', name:'PJT_NAME'}
		);  */
		
		
		var series = getDrillDownDataSeries2(
				'',
				data ,
				groupKeys ,
				[], //filter
				[{col:'MM_RESULT',convert:'y',isnull:0},{col:'YYYYMM',convert:'x',datatype:'date'}], //convert
				'YYYYMM', 
				'MM_RESULT',
				{cd: 'PJT_ID', name:'PJT_NAME'}
		);
		
		setConvertButton();
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();;
		$('#container').highcharts({
	        chart: {
	            type: 'area'
	            ,zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text:'&nbsp;',
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	/* buttons:{
	        		contextButton:{
	        			menuItems: myExporting
	        		}
	        	} */
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
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
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: true,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y'
	            },
	            valueSuffix: '' ,
	            valueDecimals: 2
	            /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer'
	                ,connectNulls:true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
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
	                    enabled: true,
	                    //format:'{point.y:.0f}',
	                    formatter: function(){
	                    	if(this.point.y != 0)
	                    		return Math.round(this.point.y);
	                    }
	                },
	                trackByArea: true,
	                enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		drawchartByProjectSite(this.options.id);
                		} 
	                }
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		//getDataByJson();
		    	/* var filters = [];
				var sorts = ['PJT_NAME','NATL_NAME','UP_PJT_FUNC_NAME','PJT_FUNC_NAME','YYYYMM'];			
				var list = getFilteredData(dataList,filters,sorts);
				setAlldataInList(list);
		    	drawGrid(list, gridModel);	 */
		    	$("#loader").hide();
		    }
		);
		
	}
	
	
	
	function drawchartByProjectSite(pjtId){
		currentFunc = drawchartByProjectSite;
		currentArg = arguments;
		
		var groupKeys = ['PJT_ID','PJT_NAME','NATL_CD','NATL_NAME','YYYYMM'];
		/* var series = getDrillDownDataSeries(
				'',
				dataList,
				groupKeys,
				[{col:'PJT_ID',val:pjtId}],
				'YYYYMM',
				'MM_RESULT',
				{cd: 'NATL_CD', name:'NATL_NAME'}
		); */
		
		var series = getDrillDownDataSeries2(
				'',
				dataList,
				groupKeys,
				[{col:'PJT_ID',val:pjtId}],
				[{col:'YYYYMM',convert:'x',datatype:'date'},{col:'MM_RESULT',convert:'y',isnull:0}], //convert
				'YYYYMM',
				'MM_RESULT',
				{cd: 'NATL_CD', name:'NATL_NAME'}
		);
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		var title = "";
		if(series.series.length>0)
			title = series.series[0].data[0].PJT_NAME + '(by Project > Site)' ;
			
		$('#container').highcharts({
	        chart: {
	            type: 'area'
	            ,zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text: title ,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					{
						//cursor: 'pointer',
					    x: -270,
					    y: 5,
					    onclick: function () {
					    	$("#loader").show();
					    	setTimeout(function(){			
					    		drawchartByAllProject();
							},50);
							
					    },
					    symbol: 'square',
					    text:'Up to All Project'
					},
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	drawchartByProjectFunc(pjtId);
					    },
					    symbol: 'square',
					    text:'Convert Project > Func'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
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
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: true,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '' ,
	            valueDecimals: 2/* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
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
	                    enabled: true,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		drawchartByProjectSiteFunc(pjtId,this.options.id);
                		}  
	                }
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            }
	        },	        
	        series: series.series
	        //drilldown: {series: drilldowns}
	        
	        
	    },function(chart){	    	
		    	/* var filters = [
		    		{col: 'PJT_ID',val: pjtId}
		    	];
				var sorts = ['PJT_NAME','NATL_NAME','UP_PJT_FUNC_NAME','PJT_FUNC_NAME','YYYYMM'];			
				var list = getFilteredData(dataList,filters,sorts);
				setAlldataInList(list);
		    	drawGrid(list, gridModel);	 */
	    	}
		);
		
	}
	
	function drawchartByProjectSiteFunc(pjtId,site){
		currentFunc = drawchartByProjectSiteFunc;
		currentArg = arguments;
		
		var groupKeys = ['PJT_ID','PJT_NAME','NATL_CD','NATL_NAME','UP_PJT_FUNC_NAME','YYYYMM'];
		/* var series = getDrillDownDataSeries(
				site,
				dataList,
				groupKeys,
				[{col:'PJT_ID',val:pjtId},{col:'NATL_CD',val:site}],
				'YYYYMM',
				'MM_RESULT',
				{cd: 'UP_PJT_FUNC_NAME', name:'UP_PJT_FUNC_NAME'}
		); */
		
		var series = getDrillDownDataSeries2(
				site,
				dataList,
				groupKeys,
				[{col:'PJT_ID',val:pjtId},{col:'NATL_CD',val:site}],
				[{col:'YYYYMM',convert:'x',datatype:'date'},{col:'MM_RESULT',convert:'y',isnull:0}], //convert
				'YYYYMM',
				'MM_RESULT',
				{cd: 'UP_PJT_FUNC_NAME', name:'UP_PJT_FUNC_NAME'}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		var title = "";
		if(series.series.length>0)
			title = series.series[0].data[0].PJT_NAME + ' > ' + series.series[0].data[0].NATL_NAME +  ' (by Project > Site > Func)';
		
		$('#container').highcharts({
	        chart: {
	            type: 'area'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text: title ,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					/* {
						cursor: 'pointer',
					    x: -250,
					    y: 5,
					    onclick: function () {
							drawchartByAllProject();
					    },
					    symbol: 'square',
					    text:'Up to Main'
					}, */
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	drawchartByProjectSite(pjtId);
					    },
					    symbol: 'square',
					    text:'Up to Project > Site'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
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
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: false,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '',
	            valueDecimals: 2/* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
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
	                    enabled: true,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		drawchartByProjectSiteFuncSubfunc(pjtId,site,this.name);
                		}  
	                }
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            },
	            column: {
	            	stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: true,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: true
	            }
	        },	        
	        series: series.series
	    },function(chart){
    			/* var filters = [
   		    		{col: 'PJT_ID',val: pjtId},
   		    		{col: 'NATL_CD',val: site}
   		    	];
   				var sorts = ['PJT_NAME','NATL_NAME','UP_PJT_FUNC_NAME','PJT_FUNC_NAME','YYYYMM'];			
   				var list = getFilteredData(dataList,filters,sorts);
   				setAlldataInList(list);
   		    	drawGrid(list, gridModel);	 */
	    	}
		);
		
	}
	
	function drawchartByProjectSiteFuncSubfunc(pjtId,site,func){
		currentFunc = drawchartByProjectFuncSubfunc;
		currentArg = arguments;
		
		var pjtNames = dataFilter(dataList,[{col: 'PJT_ID', val: pjtId}]);
		var pjtName = pjtNames[0].PJT_NAME;
		var siteName = dataFilter(dataList,[{col: 'NATL_CD', val: site}])[0].NATL_NAME;
		
		var vlist = [];
		var funcIds = dataFilter(dataList,[{col: 'UP_PJT_FUNC_NAME', val: func}]);
		var funcId = funcIds[0].UP_PJT_FUNC_ID;
		$.ajax({
			url: "/dashboard/pmsResourceSubfuncJson.do",
			data: {pjt_code: pjtId, site: site , func: funcId, estStartDate: $("#estStartDate").val(), estEndDate: $("#estEndDate").val()}, 
			async: false,
			success:  function(response){
				vlist = response.data;
			}
		});
		
		var groupKeys = ['UP_PJT_FUNC_NAME','FUNC_NAME','YYYYMM'];
		var series = getDrillDownDataSeries2(
				func,
				vlist,
				groupKeys,
				[],
				[{col:'YYYYMM',convert:'x',datatype:'date'},{col:'MM_RESULT',convert:'y',isnull:0}], //convert
				'YYYYMM', //x축 date
				'MM_RESULT', //y축
				{cd: 'FUNC_NAME', name:'FUNC_NAME'}			
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		var title = "";
		if(series.series.length>0)
			title = pjtName + ' > ' + siteName  +  ' > '+ func + ' (by Project > Site > Func > Sub function )';
		
		$('#container').highcharts({
	        chart: {
	            type: 'area'
	            ,zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
	            enabled: false
	        },
	        title: {
	        	text: title ,
	        	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					/* {
						cursor: 'pointer',
					    x: -250,
					    y: 5,
					    onclick: function () {
							drawchartByAllProject();
					    },
					    symbol: 'square',
					    text:'Up to Main'
					}, */
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	drawchartByProjectSiteFunc(pjtId,site);
					    },
					    symbol: 'square',
					    text:'Up to Project > Site > Func'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
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
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: false,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '' ,
	            valueDecimals: 2
	            /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		//cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
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
	                    enabled: true ,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true
	                /* events:{
	                	click: function(e){
	                		
	            		}  
	                } */
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            },
	            column: {
	            	stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: true,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: true
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		/* var filters = [
			    		{col: 'PJT_ID',val: pjtId}
			    		,{col: 'PJT_FUNC_ID',val: func}
			    	];
					var sorts = ['PJT_NAME','NATL_NAME','UP_PJT_FUNC_NAME','PJT_FUNC_NAME','YYYYMM'];			
					var list = getFilteredData(dataList,filters,sorts);
					setAlldataInList(list);
			    	drawGrid(list, gridModel);	 */
	    }
		);
		
	}
	
	function drawchartByProjectFunc(pjtId){
		currentFunc = drawchartByProjectFunc;
		currentArg = arguments;
		
		var groupKeys = ['PJT_ID','PJT_NAME','UP_PJT_FUNC_NAME','YYYYMM'];
		/* var series = getDrillDownDataSeries(
				'',
				dataList,
				groupKeys,
				[{col:'PJT_ID',val:pjtId}],
				'YYYYMM', //x축 date
				'MM_RESULT', //y축
				{cd: 'UP_PJT_FUNC_NAME', name:'UP_PJT_FUNC_NAME'}
		); */
		
		var series = getDrillDownDataSeries2(
				'',
				dataList,
				groupKeys,
				[{col:'PJT_ID',val:pjtId}],
				[{col:'YYYYMM',convert:'x',datatype:'date'},{col:'MM_RESULT',convert:'y',isnull:0}], //convert
				'YYYYMM', //x축 date
				'MM_RESULT', //y축
				{cd: 'UP_PJT_FUNC_NAME', name:'UP_PJT_FUNC_NAME'}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		var title = "";
		if(series.series.length>0)
			title = series.series[0].data[0].PJT_NAME + '(by Project > Func)';
			
		$('#container').highcharts({
	        chart: {
	            type: 'area'
	            ,zoomType: 'y'
	            
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text: title ,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					{
						cursor: 'pointer',
					    x: -270,
					    y: 5,
					    onclick: function () {
					    	$("#loader").show();
					    	setTimeout(function(){			
					    		drawchartByAllProject();
							},50);
					    },
					    symbol: 'square',
					    text:'Up to All Project'
					},
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	drawchartByProjectSite(pjtId);
					    },
					    symbol: 'square',
					    text:'Convert Project > Site'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
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
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: true,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '' ,
	            valueDecimals: 2 /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
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
	                    enabled: true,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true ,
	                events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		drawchartByProjectFuncSite(pjtId,this.name);
                		}  
	                }
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		/* var filters = [
   		    		{col: 'PJT_ID',val: pjtId}
   		    		//,{col: 'PJT_FUNC_ID',val: func}
   		    	];
   				var sorts = ['PJT_NAME','NATL_NAME','UP_PJT_FUNC_NAME','PJT_FUNC_NAME','YYYYMM'];			
   				var list = getFilteredData(dataList,filters,sorts);
   				setAlldataInList(list);
   		    	drawGrid(list, gridModel);	 */
	    	}
		);
		
	}
	
function drawchartByProjectFuncSite(pjtId,func){
		currentFunc = drawchartByProjectFuncSite;
		currentArg = arguments;
		
		var groupKeys = ['PJT_ID','PJT_NAME','UP_PJT_FUNC_NAME','NATL_CD','NATL_NAME','YYYYMM'];
		/* var series = getDrillDownDataSeries(
				func,
				dataList,
				groupKeys,
				[{col:'PJT_ID',val:pjtId},{col:'UP_PJT_FUNC_NAME',val: func}],
				'YYYYMM', //x축 date
				'MM_RESULT', //y축
				{cd: 'NATL_CD', name:'NATL_NAME'}
		); */
		
		var series = getDrillDownDataSeries2(
				func,
				dataList,
				groupKeys,
				[{col:'PJT_ID',val:pjtId},{col:'UP_PJT_FUNC_NAME',val: func}],
				[{col:'YYYYMM',convert:'x',datatype:'date'},{col:'MM_RESULT',convert:'y',isnull:0}], //convert
				'YYYYMM', //x축 date
				'MM_RESULT', //y축
				{cd: 'NATL_CD', name:'NATL_NAME'}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		var title = "";
		if(series.series.length>0)
			title = series.series[0].data[0]['PJT_NAME'] + ' > ' + series.series[0].data[0]['UP_PJT_FUNC_NAME']  +  ' (by Project > Func > Site)';
		
		$('#container').highcharts({
	        chart: {
	            type: 'area'
	            ,zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text: title ,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					/* {
						cursor: 'pointer',
					    x: -250,
					    y: 5,
					    onclick: function () {
							drawchartByAllProject();
					    },
					    symbol: 'square',
					    text:'Up to Main'
					}, */
					{
					    x: -350,
					    y: 5,
					    onclick: function () {
					    	drawchartByProjectFunc(pjtId);
					    },
					    symbol: 'square',
					    text:'Up to Project > Func'
					},
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	drawchartByProjectFuncSubfunc(pjtId,func);
					    },
					    symbol: 'square',
					    text:'Convert Project > Func > Sub function'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
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
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: false,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '' ,
	            valueDecimals: 2
	            /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		//cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
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
	                    enabled: true ,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true
	                /* events:{
	                	click: function(e){
	                		
                		}  
	                } */
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            },
	            column: {
	            	stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: true,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: true
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		/* var filters = [
  		    		{col: 'PJT_ID',val: pjtId}
  		    		,{col: 'PJT_FUNC_ID',val: func}
  		    	];
  				var sorts = ['PJT_NAME','NATL_NAME','UP_PJT_FUNC_NAME','PJT_FUNC_NAME','YYYYMM'];			
  				var list = getFilteredData(dataList,filters,sorts);
  				setAlldataInList(list);
  		    	drawGrid(list, gridModel);	 */
	    }
		);
		
	}
	
function drawchartByProjectFuncSubfunc(pjtId,func){
	currentFunc = drawchartByProjectFuncSubfunc;
	currentArg = arguments;
	
	var pjtNames = dataFilter(dataList,[{col: 'PJT_ID', val: pjtId}]);
	var pjtName = pjtNames[0].PJT_NAME;
	
	var vlist = [];
	var funcIds = dataFilter(dataList,[{col: 'UP_PJT_FUNC_NAME', val: func}]);
	var funcId = funcIds[0].UP_PJT_FUNC_ID;
	$.ajax({
		url: "/dashboard/pmsResourceSubfuncJson.do",
		data: {pjt_code: pjtId, func: funcId, estStartDate: $("#estStartDate").val(), estEndDate: $("#estEndDate").val()}, 
		async: false,
		success:  function(response){
			vlist = response.data;
		}
	});
	
	var groupKeys = ['UP_PJT_FUNC_NAME','FUNC_NAME','YYYYMM'];
	var series = getDrillDownDataSeries2(
			func,
			vlist,
			groupKeys,
			[],
			[{col:'YYYYMM',convert:'x',datatype:'date'},{col:'MM_RESULT',convert:'y',isnull:0}], //convert
			'YYYYMM', //x축 date
			'MM_RESULT', //y축
			{cd: 'FUNC_NAME', name:'FUNC_NAME'}			
	);
	
	
	if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
	var title = "";
	if(series.series.length>0)
		title = pjtName + ' > ' + series.series[0].data[0]['UP_PJT_FUNC_NAME']  +  ' (by Project > Func > Sub function )';
	
	$('#container').highcharts({
        chart: {
            type: 'area'
            ,zoomType: 'y'
        },
        credits: {//gets rid of the highcharts logo in bottom right
            enabled: false
        },
        title: {
        	text: title ,
        	useHTML: true
        },
        subtitle: {
            text: ''
        },
        exporting:{
        	buttons: [
				/* {
					cursor: 'pointer',
				    x: -250,
				    y: 5,
				    onclick: function () {
						drawchartByAllProject();
				    },
				    symbol: 'square',
				    text:'Up to Main'
				}, */
				{
				    x: -350,
				    y: 5,
				    onclick: function () {
				    	drawchartByProjectFunc(pjtId);
				    },
				    symbol: 'square',
				    text:'Up to Project > Func'
				},
				{
				    x: -100,
				    y: 5,
				    onclick: function () {
				    	drawchartByProjectFuncSite(pjtId,func);
				    },
				    symbol: 'square',
				    text:'Convert Project > Func > Site'
				}
			]
        },
        xAxis: {
        	type: 'datetime',
        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
        	tickInterval: 24 * 3600 * 1000 * 30,
        	//tickmarkPlacement: 'on',
        	dateTimeLabelFormats: { // don't display the dummy year
        		week: '%m/%e',
        		day: '%m/%e',
        		month: '%y/%m',
        		year: '%y/%m/%e'
            }
            //title: {
            //    enabled: false
            //},
            //plotBands : plotBandsHigh,
            //plotLines: plotLinesHigh
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
            }
            
        },
        tooltip: {
        	enabled:true,
            shared: true ,
            crosshairs: false,
            dateTimeLabelFormats: {
            	week: '%y/%m/%e',
        		day: '%y/%m/%e',
        		month: '%y/%m',
        		year: '%y/%m/%e'
            },
            valueSuffix: '' ,
            valueDecimals: 2
            /* ,
            formatter: function () {
            	var data = getDataByUtc($("#sProject").val(), this.x);
                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
                    '' + this.series.name + ':' + this.y + '';
            } */
        },
        //legend: legend,
        plotOptions: {
        	series: {
        		//cursor: 'pointer',
                connectNulls: true // by default
               /*  point:{
                	events:{
                		click: function(e){
                			//alert('click');
                		}
                	}
                } */
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
                    enabled: true ,
                    format:'{point.y:.0f}'
                },
                trackByArea: true,
                enableMouseTracking: true
                /* events:{
                	click: function(e){
                		
            		}  
                } */
                	
            },
            line: {
            	//stacking: 'normal',
                //lineColor: 'red',
                //lineWidth: 1,
                marker: {
                	enabled: false,
                    lineWidth: 1,
                    lineColor: '#666666'
                },
                dataLabels: {
                    enabled: false
                },
                enableMouseTracking: false
            },
            column: {
            	stacking: 'normal',
                //lineColor: 'red',
                //lineWidth: 1,
                marker: {
                	enabled: true,
                    lineWidth: 1,
                    lineColor: '#666666'
                },
                dataLabels: {
                    enabled: false
                },
                enableMouseTracking: true
            }
        },	        
        series: series.series
    },function(chart){
    		/* var filters = [
		    		{col: 'PJT_ID',val: pjtId}
		    		,{col: 'PJT_FUNC_ID',val: func}
		    	];
				var sorts = ['PJT_NAME','NATL_NAME','UP_PJT_FUNC_NAME','PJT_FUNC_NAME','YYYYMM'];			
				var list = getFilteredData(dataList,filters,sorts);
				setAlldataInList(list);
		    	drawGrid(list, gridModel);	 */
    }
	);
	
}
	
	
	function makeChartData(){
		// format
		var data = {
				/* yyyymm, 
				pjt_id, 
				pjt_name, 
				pjt_func_id, 
				pjt_func_name, 
				natl_cd, 
				natl_name, 
				pjt_phase_id, 
				mm_result */
		};
		dataProject.pkeys = ['PJT_ID','PJT_NAME','YYYYMM'];
		dataProject.data = groupbySum(dataList,dataProject.pkeys,'MM_RESULT');
		
		dataProjectSite.pkeys = ['PJT_ID','PJT_NAME','NATL_CD','NATL_NAME','YYYYMM'];
		dataProjectSite.data = groupbySum(dataList,dataProjectSite.pkeys,'MM_RESULT');
		
		
		dataProjectFunction.pkeys = ['PJT_ID','PJT_NAME','PJT_FUNC_ID','PJT_FUNC_NAME','YYYYMM'];
		dataProjectFunction.data = groupbySum(dataList,dataProjectFunction.pkeys,'MM_RESULT');
		
		dataSite.pkeys = ['NATL_CD','NATL_NAME','YYYYMM'];
		dataSite.data = groupbySum(dataList,dataSite.pkeys,'MM_RESULT');
		sortObjects(dataSite.data, ['NATL_CD', ['YYYYMM', 'asc']] /*, primers*/);
		
		dataFunction.pkeys = ['PJT_FUNC_ID','PJT_FUNC_NAME','YYYYMM'];
		dataFunction.data = groupbySum(dataList,dataFunction.pkeys,'MM_RESULT');
		
	}
	
	/**
	* baseLine의 범위가 다른프로젝트 의 범위보다 항상 크므로 series.visible 값에 따라 범위를 조정한다.
	* @param obj:  해당이벤트 series 객체
	*/	
	function adjustBaseLine(obj){
		var baseLineData = new Array();
		var baseLineDataA = new Array();
		var dataPhase = responseDataG.phase;
		
		var chart = $('#container').highcharts();
		/* var uSeries = chart.series.filter( function(s){
			if(s.name != 'BaseLine' && s.name != 'BaseLineA')
				return s.visible;
		}); */
		
		var uSeries = $.grep(chart.series, function(s){
			if(s.name != 'P0-BaseLine' && s.name != 'P1-BaseLine')
				return s.visible;
		});
		
		/* var baseLine = chart.series.filter( function(s){
			if(s.name == 'BaseLine')
				return true;
		}); */
		
		var baseLine = $.grep(chart.series, function(s){
			if(s.name == 'P0-BaseLine')
				return true;
		});
		
		/* var baseLineA = chart.series.filter( function(s){
			if(s.name == 'BaseLineA')
				return true;
		}); */
		
		var baseLineA = $.grep(chart.series, function(s){
			if(s.name == 'P1-BaseLine')
				return true;
		});
		
		
		var minDt = '';
		var minDtUtc = null;
		var minDtApply = false;
		if(responseDataG.data.length>0){
			var minDt = responseDataG.data[0].ANALYSYS_DATE;
			var minDtSplit = minDt.split('-');
			minDtUtc = Date.UTC(minDtSplit[0],minDtSplit[1] -1 ,minDtSplit[2]);
		}
		
		var maxDt = '';
		var maxDtUtc = null;
		var maxDtApply = false;
		if(responseDataG.data.length>0){
			var maxDt = responseDataG.data[responseDataG.data.length-1].ANALYSYS_DATE;
			var maxDtSplit = maxDt.split('-');
			maxDtUtc = Date.UTC(maxDtSplit[0],maxDtSplit[1] -1 ,maxDtSplit[2]);
		}
		
		for (var i = 0; i < dataPhase.length; i++){
			
			
			//01. ------------- BaseLine 구성 -----------//
			var phaseDtSplit = dataPhase[i].ACTUAL_START_DATE.split('/'); //start
			var phaseDtSplit1 = dataPhase[i].ACTUAL_END_DATE.split('/'); //end
			var phaseDtSplitBend = null; //beforeEnd
			
			
			var startDt1 = phaseDtSplit[2];
			var utcDt1 = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			if(i>0){
				phaseDtSplitBend = dataPhase[i-1].ACTUAL_END_DATE.split('/');
				utcDt1 = Date.UTC(phaseDtSplitBend[0],phaseDtSplitBend[1] -1 ,phaseDtSplitBend[2]);
			}		
			var utcDt2 = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
			
			
			
			// phase정보의 시작일이 실제데이타의 시작일 보다 작은 경우적용
			// 그래프에 쓸데없은 line을 없애기 위함
			if(!minDtApply && i < (dataPhase.length) && minDt != ''){
				var nextSplit = dataPhase[i].ACTUAL_START_DATE.split('/');
				var nextSplit1 = dataPhase[i].ACTUAL_END_DATE.split('/');
				var nextUtcDt= Date.UTC(nextSplit[0],nextSplit[1] -1 ,nextSplit[2]);
				var nextUtcDt1 = Date.UTC(nextSplit1[0],nextSplit1[1] -1 ,nextSplit1[2]);
				
				if(utcDt1 < minDtUtc && 
						utcDt2 < minDtUtc){
					continue;
				}else if( nextUtcDt < minDtUtc && 
						nextUtcDt1 > minDtUtc){
					utcDt1 = minDtUtc;
					minDtApply = true;
				}
			}
			
			var target = 0;
			var targetA = 0;
			
			for(var j=0;j<uSeries.length;j++){
				var s = uSeries[j];
				if(s.name == 'P0'){ target += dataPhase[i].P0; targetA += dataPhase[i].PA0;}
				if(s.name == 'P1'){ target += dataPhase[i].P1; targetA += dataPhase[i].PA1;}
				if(s.name == 'P2'){ target += dataPhase[i].P2; targetA += dataPhase[i].PA2;}
				
			}
			
			if(utcDt2 > maxDtUtc ){
				utcDt2 = maxDtUtc;
				maxDtApply = true;
			}
				
			
			baseLineData.push(
					{
						x: utcDt1, 
						y: target,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false,
		                    color: 'red',
		                    style: {
		                        fontWeight: 'bold'
		                    }
		                }
					},
					{
						x: utcDt2, 
						y:target,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false
		                }
					}
			);		
			
			baseLineDataA.push(
					{
						x: utcDt1, 
						y: targetA,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false,
		                    color: 'blue',
		                    style: {
		                        fontWeight: 'bold'
		                    }
		                }
					},
					{
						x: utcDt2, 
						y:targetA,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false
		                }
					}
			);	
			if(maxDtApply)
				break;
		}	
		
		baseLine[0].update({
			data: baseLineData
		});
		
		baseLineA[0].update({
			data: baseLineDataA
		});
	}
	
	function drawGrid(pData,pModel){
		var gridArrayData = pData; //responseDataG.data;
		
		for(var i=0;i<gridArrayData.length;i++){
			gridArrayData[i].id= i+1;
		}
		
		
		var options = {
			//url: 'data.json',
			datatype: "local",
			//datatype: "json",
			data:gridArrayData,
			colModel: pModel,
			viewrecords: true , // show the current page, data rang and total records on the toolbar
			//width: "100%",
			//height: "100%",
			//height:'100%',
			//autowidth: true,
			//autoheight: true,
			//shrinkToFit: false,
			//pager: "#jqGridPager",
			decimalSeparator: ',' ,
			rowNum: gridArrayData.length
			//,loadonce: true // this is just for the demo
			//,caption: 'Data List'
			
		};
		
		/* var grid = $('#jqGrid');
		if(grid[0].grid == undefined) {
		  grid.jqGrid(options);
		} else {
		  //delete grid;
		  var jqGrid = $("#jqGrid"); 
		  jqGrid.jqGrid('gridUnload');
		  //$('#jqGrid').unload('#jqGrid');
		  $('#jqGrid').jqGrid(options);
		  //$('#jqGrid').trigger('reloadGrid');
		} */
		
		//$("#jqGrid").html('');
		$("#containerGrid").html('<table id="jqGrid" style="width: 100%;height: 100%"></table>');
		if($("#jqGrid").text()!=""){
			$('#jqGrid').jqGrid('clearGridData');
			$("#jqGrid").jqGrid('setGridParam', options ,true);
			//$("#jqGrid").jqGrid('setGroupHeaders', pModel);
			$('#jqGrid').trigger('reloadGrid');
			
		}else{
			$("#jqGrid").jqGrid(options);
		}
		
		adjustGrid();
	}
	
	function adjustGrid(){
		$("#jqGrid").jqGrid('setGridWidth',$("#containerGrid").width() - 40 );
		$("#jqGrid").jqGrid('setGridHeight',$("#containerGrid").height() - 60 );
		//$(".jqgfirstrow").css('height', 0 );		
	}
	
	
	function setConvertButton(){
		//pms에서는 상단에 버튼이 있으므로 필요없다.
		if("${param.sender}"=="pms")
			return;
		var defaultExporting = Highcharts.getOptions().exporting;
		var searchs = $.grep(defaultExporting.buttons.contextButton.menuItems,
				function(menu) {
					if (menu.text == "Analysis By Project")
						return menu;
				});

		if (searchs.length == 0) {
			defaultExporting.buttons.contextButton.menuItems.push({
					separator : true
				}, {
					text : 'Analysis By Project',
					onclick : function() {
						$('#sPriority').val("");
						
						$("#loader").show();
				    	setTimeout(function(){			
				    		drawchartByAllProject();
						},50);
					}
				}, {
					text : 'Analysis By Site',
					onclick : function() {
						$('#sPriority').val("");
						drawchartByAllSite();
					}
				}, {
					text : 'Analysis By Function',
					onclick : function() {
						$('#sPriority').val("");
						drawchartByAllFunc();
					}
				}
			);
		}
	}
	
	
	//list: array, col: string
	function convertLastDate(list,col){
		$.each(list,function(){
			var lastDate = new Date(parseInt(this[col].substr(0,4),10),parseInt(this[col].substr(4,2),10),0);
			//var lastDateStr = lastDate.toISOString().slice(0,10).replace(/-/g,"");
			var lastDateStr = $.datepicker.formatDate('yymmdd',lastDate);
			this[col+'Origin'] = this[col];
			this[col] = lastDateStr;
		});
		
	}

	</script>
	<style type="text/css">
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow: hidden;
	      }
		
		.dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 100%;	
		}
		
		.grid-div{
			position: relative;
			min-height: 1px;
			padding: 20px;
			width: 100%;
			height: 0%;	
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
		
		
		<%-- 그리드폰트 jquery-ui.css 866 line --%>
		.ui-state-default,
		.ui-widget-content .ui-state-default,
		.ui-widget-header .ui-state-default {
			color: black;
		}
		
		#loader {
		  position: absolute;
		  left: 50%;
		  top: 50%;
		  z-index: 1;
		  width: 150px;
		  height: 150px;
		  margin: -75px 0 0 -75px;
		  border: 16px solid #f3f3f3;
		  border-radius: 50%;
		  border-top: 16px solid #3498db;
		  width: 120px;
		  height: 120px;
		  -webkit-animation: spin 2s linear infinite;
		  animation: spin 2s linear infinite;
		}
		
		@-webkit-keyframes spin {
		  0% { -webkit-transform: rotate(0deg); }
		  100% { -webkit-transform: rotate(360deg); }
		}
		
		@keyframes spin {
		  0% { transform: rotate(0deg); }
		  100% { transform: rotate(360deg); }
		}
		
		/* Add animation to "page content" */
		.animate-bottom {
		  position: relative;
		  -webkit-animation-name: animatebottom;
		  -webkit-animation-duration: 1s;
		  animation-name: animatebottom;
		  animation-duration: 1s
		}
		
		@-webkit-keyframes animatebottom {
		  from { bottom:-100px; opacity:0 } 
		  to { bottom:0px; opacity:1 }
		}
		
		@keyframes animatebottom { 
		  from{ bottom:-100px; opacity:0 } 
		  to{ bottom:0; opacity:1 }
		}
		
	</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" name="version" value="${param.version}"/>
<input type="hidden" name="legendFloat" id="legendFloat" value="false"/>
<input type="hidden" id="estStartDate" name="estStartDate" value="${param.estStartDate}"/>
<input type="hidden" id="estEndDate" name="estEndDate" value="${param.estEndDate}"/>
<input type="hidden" name="category" id="category" value="${param.category}"/>
<div <c:if test="${param.pjt_code != null}"> style="display:none;"   </c:if> style="display:none;">
	<select  name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson()" >
		<option>PROJECT SELECT</option>
	</select>
</div>
<div id="container" class="dashboard-div"></div>
<div id="containerGrid" class="grid-div">
	<table id="jqGrid" style="width: 100%;height: 100%"></table>
    <!-- <div id="jqGridPager"></div>  -->
</div>
<div id="loader"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>

</html>
