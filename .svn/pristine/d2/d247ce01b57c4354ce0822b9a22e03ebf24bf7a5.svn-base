<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>FwQuality Metric</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
    
    <%-- jqgrid --%>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"> 
    <link rel="stylesheet" media="screen" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap.css" type="text/css" />
    
    <%-- 2. high charts --%>
    
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=1"></script>
	
	<%-- 5. local --%>
	<script src="js/pms/resourceBySite.js"></script>
	<script src="js/pms/resourceByFunc.js"></script>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<!-- <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" /> -->
	
	<script type="text/javascript">
	var fwqDataList = [];
	var scheduleDataList = [];
	var scheduleSeries = {};
	var over60 = [];
	var on = [];
	
	var gridModel = [
			{ label: 'Project<br/>&nbsp;', name: 'PJT_NAME_PMS', width: '270px' ,align:'left' , sortable: true, cellattr:  setAttr },
       		{ label: 'Index<br/>(200)', name: 'POINT', width: '90px' ,align:'center', sortable: true,  formatter:'number',sorttype: 'number',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr },  
       		{ label: 'Static Analysis<br/>(20)', name: 'STATIC_ANALYSIS', width:  '120px' ,align:'center', sortable:false,  formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr },
       		{ label: 'Func Parameter<br/>(20)', name: 'FUNC_PARAMETER', width:  '140px' ,align:'center', sortable:false, formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2}, cellattr: setAttr },
       		{ label: 'Func LOC<br/>(20)', name: 'FUNCTION_SIZE', width:  '120px' ,align:'center', sortable:false , formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr },
       		{ label: 'Duplicate Code<br/>(20)', name: 'DUPLICATE', width:  '120px',align:'center' , sortable:false, formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr },
       		{ label: 'Coding Rule<br/>(20)', name: 'CODING_RULE', width:  '120px' ,align:'center', sortable:false, formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr},
       		{ label: 'Architecture Analysis<br/>(25)', name: 'ARCHITECTURE', width:  '160px' ,align:'center', sortable:false,formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2}, cellattr: setAttr},
       		{ label: 'Complexity<br/>(25)', name: 'COMPLEXITY', width:  '90px',align:'center', sortable:false, formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr },
       		{ label: 'Simulator Test Coverage<br/>(25)', name: 'CODE_COVERAGE', width:  '120px',align:'center', sortable:false, formatter:'number',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 2},cellattr: setAttr }
       		
       		
       		//{ label: ' ', name: '', width: '',align:'left' /* , cellattr: arrtSetting */}	
       		//{ label: '', name: '',width: null }
       		// sorttype is used only if the data is loaded locally or loadonce is set to true
       		//{ label: 'Quantity', name: 'Quantity', width: 80, sorttype: 'number' }                   
       	];
	
	function setAttr(rowId, val, rawObject, cm) {
	    //var attr = rawObject.attr[cm.name], result;
		var rownum = parseInt(rowId,10) -1 ;
		var rowspan = 1; 
		var preVal = "";
		var postVal = "";
		var attr = rawObject[cm.name];
		var result = "";
		var style = "";
		
		if(cm.name == 'PJT_NAME_PMS'){
			style +="background-image:none;background-color:skyblue;";
		}
		if(cm.name != '')
			style += " cursor:pointer;";
		result +=" style=\""+style+"\"";
		return result;
		
	};
	
	$(function () {
		pmsProjectList();
		getDataByJson();
		$( window ).resize(function() {
			adjustGrid();
		});
	});
	
	var responseData = {};
	
	function pmsProjectList(){
		$.ajax({
			//url : "/dashboard/dashboardProjectListJson.html",
			url : "/dashboard/pmsProjectListJson.html",
			data: {division:'jira'},
			async : false,
			success : function(responseData){
				
				//var projectList = responseData.projectList;
				//var projectList0 = responseData.dataList;
				//var projectList =	dataFilter(projectList0,[{col:'APPLICATION_ID',val:'SPM_00005011'},{col:'APPLICATION_ID',val:'SPM_00005010'},{col:'APPLICATION_ID',val:'SPM_00005558'}]);
				//var projectList =responseData.projectList;
				//sortObjects(projectList,['APPLICATION_NM','PJT_NAME'])
				
				var projectList =responseData.dataList;
				
				var groupKeys = ['DISPLAY_ORDER','PJT_NAME'];
				var series = getDrillDownDataSeries2(
						'',
						projectList ,
						groupKeys ,
						[], //filter
						[], //convert
						'', //xAxis
						'CNT',
						{cd: 'APPLICATION_ID', name:'APPLICATION_NAME'},
						{isGroupby: false}
				);
				
				var selected ="";
				var sb = [];
				$.each(series.series,function(index,s){
					sb.push("<optgroup label=\""+s.name+" (Click)\">");
					$.each(s.data,function(index1,d){
						if($("[name=reqPjtCodeList]").length > 0){
							if($("[name=reqPjtCodeList][value="+ d.PJT_CODE +"]").length > 0)
								selected = "selected";
							else
								selected = "";
						}else{
							if(this.APPLICATION_NAME=="Mobile Solution")
								selected = "selected";
							else 
								selected = "selected";
						}
						
						sb.push("<option value='"+ d.PJT_CODE +"' "+selected+">" + d.PJT_NAME +"</option>");
					});
					sb.push("</optgroup>");
				});
				$("select[name=pjtCodeList]").append(sb.join(""));
				
				$("select[name=pjtCodeList]").change(function(){
					getDataByJson();
				});
				var select = $("select[name=pjtCodeList]").multiselect({
					
					height:400,
					selectedText: 'Project # selected',
					noneSelectedText: 'Select projects'
				}).multiselectfilter();
				$("div.ui-multiselect-menu").css("width","500px");
				$(".ui-multiselect-filter input").css("width","200px");
			}
		});
	}
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/fwqMetricJson.html",
			data: $("#form").serialize() ,
			success : function(pResponseData){
				fwqDataList = pResponseData.fwqDataList;
				sortObjects(fwqDataList,[['POINT','desc'],'PJT_NAME_PMS']);
				drawchart();
				drawGrid();
				
			}
		});
	}
	
function drawchart(){
		//sortObjects(fwqDataList,[['POINT','desc'],'PJT_NAME_PMS']);
		var groupKeys = ['GUBUN','PJT_NAME_PMS'];
		
		var series = getDrillDownDataSeries2(
				'',
				fwqDataList ,
				groupKeys ,
				[], //filter
				[{col:'POINT',convert:'y',isnull:0}], //convert
				'PJT_NAME_PMS', 
				'POINT',
				{cd: 'GUBUN', name:'GUBUN'},
				//{isGroupby:false,xSortColumn: 'PJT_NAME' 	}
				//{isGroupby:false,xSortColumn: 'PJT_NAME_PMS' 	}
				{isGroupby:false}
		);
		
		sortObjects(series.series[0].data,[['POINT','desc'],'PJT_NAME_PMS']);
		var category = [];
		$.each(series.series[0].data,function(){
			category.push(this.PJT_NAME_PMS);
		});
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		if(series.series.length>0)
			series.series[0].color = 'rgba(255,69,0,0.7)';
		
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
	        	enabled: false
	        },
	        xAxis:{
	        	categories: category, //series.category,
	        	labels: {
	                rotation: 60
	                //,formatter: function () {
        			//	return series.category[this.value];
        			//}
	            }
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }	            
	        },
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            pointFormat: 'point: <b>{point.y}</b><br/>',
	            shared: false,
	            enabled: true
	        },
	        //legend: legend,
	        plotOptions: {
	            column: {
	            	cursor: 'pointer' ,
	                //stacking: 'normal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y}',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		popFWQProjectSummary.call(e.point);
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
	
function drawGrid(){
	//sortObjects(fwqDataList,[['POINT','desc'],'PJT_NAME_PMS']);
	var options = {
		//url: 'data.json',
		datatype: "local",
		//datatype: "json",
		styleUI : 'Bootstrap',
		data: fwqDataList,
		colModel: gridModel,
		viewrecords: true , // show the current page, data rang and total records on the toolbar
		rowNum:10,
		rowList:[10,20,30],
		viewrecords: true,
		//width: "100%",
		height: "600",
		//height:'100%',
		//autowidth: true,
		//autoheight: true,
		//shrinkToFit: false,
		//pager: "#jqGridPager",
		decimalSeparator: ',' ,
		//rowNum: fwqDataList.length
		//,loadonce: true // this is just for the demo
		multiSort: true,
		//, sort:[['POINT','desc'],['PJT_NAME_PMS','asc']]
		sortname: 'POINT desc, PJT_NAME_PMS',
        sortorder: 'asc',           
		//,caption: 'Data List'
		onCellSelect: function (rowId, iCol, content, event) {
			var cm = jQuery("#jqGrid").jqGrid("getGridParam", "colModel");
			if(cm.name != ''){
				var val = Number($('#jqGrid').jqGrid('getCell', rowId, iCol));	
				if(cm[iCol].name == 'PJT_NAME_PMS'){
					var object = dataFilter(fwqDataList,[{col:'PJT_NAME_PMS',val:content}])[0];
					if(object != undefined){
						popFWQProjectSummary.call(object);
					}
				}else {
					//cell click
					var projectName = $('#jqGrid').jqGrid('getCell', rowId, 0);
					var object = dataFilter(fwqDataList,[{col:'PJT_NAME_PMS',val: projectName}])[0];
					var label = "";
					if(cm[iCol].label.match(/[\w\s]+/) != null)
						label = cm[iCol].label.match(/[\w\s]+/).join('');
					popFWQProjectCategoryTrend.call(object,cm[iCol].name,label);
				}
				
			}
				
	      }// end onclick
	   
		    	
		
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
	try{
		$("#containerGrid").html('<table id="jqGrid" style="width: 100%;"></table>');
		if($("#jqGrid").text()!=""){
			$('#jqGrid').jqGrid('clearGridData');
			$("#jqGrid").jqGrid('setGridParam', options ,true);
			//$("#jqGrid").jqGrid('setGroupHeaders', pModel);
			$('#jqGrid').trigger('reloadGrid');
			
		}else{
			$("#jqGrid").jqGrid(options);
		}
	}catch(err){
		if(fwqDataList.length == 0) {
			$("#load_jqGrid").text("no data");
		}
	}
	
	
	
	adjustGrid();
	
	//header 색깔조정
	$("[role='columnheader']").css("background","#EBEB9A");
	$("#jqGrid_PJT_NAME_PMS").css("background","skyblue");
	//$(".ui-widget-content").css("background-image","none");
	$(".ui-jqgrid .ui-jqgrid-sortable").css("cursor","text");
	$("#jqgh_jqGrid_PJT_NAME_PMS").css("cursor","pointer");
	$("#jqgh_jqGrid_POINT").css("cursor","pointer");
}

function adjustGrid(){
	$("#jqGrid").jqGrid('setGridWidth',$("#containerGrid").width() - 5);
	
	//$("#jqGrid").jqGrid('setGridHeight',$("#containerGrid").height() - 0);
	//$(".jqgfirstrow").css('height', 0 );		
	
	//$("#containerGrid").height(window.innerHeight - $("#application").height() - $("#container").height() );
}
	
function popFWQProjectSummary(){
	//var newWin1 = window.open("FWQualitySummary", "FWQualitySummary", "width=1000,height=870, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes"); 
	var newWin1 = window.open("", "FWQualitySummary", "width=1000,height=870, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes"); 
	
	var oFrm = document.getElementById("form");
	oFrm.pjt_code.value = this.PJT_CODE;
	oFrm.pjt_name.value = this.PJT_NAME_PMS;
	oFrm.action =  '/dashboard/fwqProjectSummary.html';
	oFrm.method = "post";
	oFrm.target = 'FWQualitySummary'; 
    oFrm.submit();		
    newWin1.focus();
}

function popFWQProjectCategoryTrend(category,label){
	//var newWin1 = window.open("FWQualityProjectCategoryTrend", "FWQualityProjectCategoryTrend", "width=750,height=600, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes"); 
	var newWin1 = window.open("", "FWQualityProjectCategoryTrend", "width=750,height=600, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
	
	var categoryMap = {
			
	};
	
	
	var oFrm = document.getElementById("form");
	oFrm.pjt_code.value = this.PJT_CODE;
	oFrm.pjt_name.value = this.PJT_NAME;
	oFrm.category.value = category;
	oFrm.categoryLabel.value = label;
	oFrm.action =  '/dashboard/fwqProjectCategoryTrend.html';
	oFrm.method = "post";
	oFrm.target = 'FWQualityProjectCategoryTrend'; 
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
	        line-height: 1.3em;
	        font-size:12px;
			font-family:'Malgun Gothic', arial, dotum, gulim;  
	     }
	     
	     .div-search{
			width: 100%;
			margin-left:10px;
			margin-top: 10px;
			/* height: 20px;		 */
			display: block;
			font-size: 12px;
			overflow: hidden;
		}
		
		.container{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 500px;			
		}		
		
		.containerGrid{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			/* width: 100%; */
			/* height: 200px; */
		}		
		
		#containerGrid #gbox_jqGrid {
			height: 100%;
		}
		.ui-jqgrid .ui-jqgrid-view {
			font-size: 11px;
		}
		
		/* multi-select 관련  */
		.ui-multiselect-checkboxes li label{
			font-size: 13px;
			line-height: 1.3em;
		}		
		.ui-multiselect-checkboxes li label input[type="checkbox"] {margin:0; padding:0; vertical-align:middle;}
		ui-multiselect-menu a:link, a:visited, a:active {
			font-family:'Malgun Gothic', arial, gulim, dotum;
			/* color: #000; */
			text-decoration:none;
		}
		
		td,th{
			font-size:12px;
		}
		
		/* .ui-widget-content {
			background-image: none;
		} */
		
		/***  jqgrid Header   ***/
		.ui-jqgrid-hdiv th {
			text-align: center;
		}
		
		.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {
    	    background-color: #f5f5f5;;
    	    background-image: none
    	}
    	
    	.ui-jqgrid .ui-jqgrid-htable th div {
			height:auto;
			overflow:hidden;
			padding-right:4px;
			padding-top:2px;
			position:relative;
			vertical-align:text-top;
			white-space:normal !important;
			}
		th.ui-th-column div{
	        white-space:normal !important;
	        height:auto !important;
	        padding:2px;
	    }
		
	</style>
</head>
<body>
<form name="form" id="form">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value=""/>
<input type="hidden" id="pjt_name" name="pjt_name" value=""/>
<input type="hidden" name ="phaseBase" value="phase"/>
<input type="hidden" id="category" name="category" value=""/>
<input type="hidden" id="categoryLabel" name="categoryLabel" value=""/>
<div id="application" class="div-search">
	<div style="display:inline-block;text-overflow:show;float:left;">
		<input type="hidden" name="pjtCodeList" value ="xxx"/>
		<select name="pjtCodeList" id="pjtCodeList" multiple="multiple" style="" >
	    </select>
	</div>
</div>

<div  id="container" class="container"></div>
<div id="containerGrid" class="containerGrid">
	<table id="jqGrid" style="width: 100%;height: 100%"></table> 
    <!-- <div id="jqGridPager"></div>  -->
</div>
</form>
<c:forEach items="${paramValues.pjtCodeList}" var="pjtCode" varStatus="status">
	<input type="hidden" name="reqPjtCodeList" value="${pjtCode}"/>
</c:forEach>
</body>

</html>
