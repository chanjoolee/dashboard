<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>regressionTestCategoryList</title>
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
	
	
	
	
	<%-- jqgrid --%>
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	
	<%-- http://swebdeveloper.com/apps/forms-plus-css/popup-form-comment.html --%>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/font-awesome.min.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/modern-forms-plus.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/purple.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/cadetBlue.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/orange.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color3.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color4.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/steelBlue.css"/>
	 
	 <!--  <link rel="stylesheet" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid.css" type="text/css" /> --> 
    <link rel="stylesheet" media="screen" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap.css" type="text/css" />
    <!-- <link rel="stylesheet" media="screen"  href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap-ui.css" type="text/css" /> -->
	 
	 
	<script type="text/javascript">
	var dataList = [];
	
	var gridModel = [
      		{ label: 'project', name: 'PJT_CODE', width: '125px' ,align:'center'/* , cellattr: arrtSetting */},
      		{ label: 'fw revison', name: 'REVISION', width: '170px' ,align:'center'/*,  cellattr: arrtSetting */},
      		{ label: 'category', name: 'CATEGORY', width: '60px',align:'center' /* , cellattr: arrtSetting */},
      		{ label: 'test name', name: 'TEST_NAME', width: '120px' ,align:'left' /* , cellattr: arrtSetting */},	
      		{ label: 'test script ', name: 'TEST_SCRIPT', width: '120px',align:'left' /* , cellattr: arrtSetting */},	
      		{ label: 'result', name: 'FINAL_RESULT', width: '70px',align:'center' /* , cellattr: arrtSetting */},
      		{ label: 'comment', name: 'BATMAN_COMMENT', width: '',align:'left' /* , cellattr: arrtSetting */}	
      		//{ label: '', name: '',width: null }
      		// sorttype is used only if the data is loaded locally or loadonce is set to true
      		//{ label: 'Quantity', name: 'Quantity', width: 80, sorttype: 'number' }                   
      	];
	
	$(function () {
		getDataByJson();
		$( window ).resize(function() {
			adjustGrid();
		});
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/regressionTestCategoryListJson.do",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawGrid(dataList,gridModel);
			}
		});
	}
	
	function drawGrid(pData,pModel){
		var gridArrayData = pData; //responseDataG.data;
		
// 		for(var i=0;i<gridArrayData.length;i++){
// 			gridArrayData[i].id= i+1;
// 		}
		
		
		var options = {
			datatype: 'local',
			styleUI : 'Bootstrap',
			
			//colNames: jmespath.search(this.gridInfo.sourceData,"[*].val"),
			colModel: gridModel,
			sortable: true,
			viewrecords: true,
			rownumbers: true, // show row numbers
	        multiSort:true,
	        //multiselect: true,
	        //multiboxonly:true,
	        width: '100%' ,
	        forceFit : false ,
	        iconSet: "fontAwesome",
	     	//height: '100%',
			rowNum: gridArrayData.length ,
			data:gridArrayData
			
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
		
		/* $("#containerGrid").html('<table id="jqGrid" style="width: 100%;height: 100%"></table>');
		if($("#jqGrid").text()!=""){
			$('#jqGrid').jqGrid('clearGridData');
			$("#jqGrid").jqGrid('setGridParam', options ,true);
			//$("#jqGrid").jqGrid('setGroupHeaders', pModel);
			$('#jqGrid').trigger('reloadGrid');
			
		}else{
			$("#jqGrid").jqGrid(options);
		} */
		
		var theGrid = $("#jqGrid");
		theGrid.jqGrid(options);
		theGrid.jqGrid('sortableRows');
		adjustGrid();
	}
	
	function adjustGrid(){
		$("#jqGrid").jqGrid('setGridWidth',$("#containerGrid").width() - 5 );
		$("#jqGrid").jqGrid('setGridHeight',$("#containerGrid").height() - 60 );
		//$(".jqgfirstrow").css('height', 0 );		
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
	      
		.containerGrid{
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
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjt_name" name="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" id="revision" name="revision" value="${param.revision}"/>
<input type="hidden" id="category" name="category" value="${param.category}"/>
<div id="containerGrid" class="containerGrid">
	<table id="jqGrid" style="width: 100%;height: 100%"></table>
	<!-- <table id="jqGrid"></table> -->
    <!-- <div id="jqGridPager"></div>  -->
</div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
