<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>bambooTestClassNameTimeList_${param.startTime}</title>
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
	<script src="js/dashboard.js?version=1"></script>
	
	<%-- 5. local --%>
	
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	var dataList = [];
	
	var gridModel = [
      		{ label: 'no',name:'id',index:'id', width:60, sorttype:"int" ,align:'center'},
      		{ label: 'project', name: 'PROJECT', width: 75 ,align:'left'/* , cellattr: arrtSetting */},
      		{ label: 'class', name: 'CLASS_NAME', width: 75 ,align:'left'/*,  cellattr: arrtSetting */},
      		{ label: 'test name', name: 'TEST_NAME', width: 120,align:'left' /* , cellattr: arrtSetting */},	
      		{ label: 'status', name: 'STATUS', width: 70,align:'center' /* , cellattr: arrtSetting */},	
      		{ label: 'cpu time', name: 'CPU_TIME', width: 70,align:'right' /* , cellattr: arrtSetting */},
      		{ label: 'time', name: 'TIME', width: 70,align:'right' /* , cellattr: arrtSetting */},
      		{ label: 'error type', name: 'ERROR_TYPE', width: 80,align:'center' /* , cellattr: arrtSetting */},
      		{ label: 'seed', name: 'SEED', width: 80,align:'center' /* , cellattr: arrtSetting */},
      		{ label: 'user info', name: 'USER_INFO', width: 120,align:'left' /* , cellattr: arrtSetting */},
      		{ label: 'bamboo link', name: 'BAMBOO_LINK', width: 120,align:'left' , cellattr: attrCursorPointer }
      		//{ label: '', name: '',width: '' }
      		// sorttype is used only if the data is loaded locally or loadonce is set to true
      		//{ label: 'Quantity', name: 'Quantity', width: 80, sorttype: 'number' }                   
      	];
	
	function attrCursorPointer(rowId, val, rawObject, cm){
		var attr  = ' style="cursor:pointer"';
		return attr;
	}
	
	
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
			url : "/dashboard/bambooTestClassNameTimeListJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawGrid(dataList,gridModel);
			}
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
			
			, onCellSelect: function (rowId, iCol, content, event) {
			 	
				if(iCol == 10){
					// $('[id='+rowId+'] td[aria-describedby=jqGrid_STATUS]').text()
					var rowData = jQuery(this).getRowData(rowId);
					var url = 'http://bamboo.skhynix.com/browse/'+rowData.BAMBOO_LINK ;
		    		hsClick(url,this);
		      	}
			    	  
		    }
			
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
<input type="hidden" id="project" name="project" value="${param.project}"/>
<input type="hidden" id="className" name="className" value="${param.className}"/>
<input type="hidden" id="informId" name="informId" value="${param.informId}"/>
<div id="containerGrid" class="containerGrid">
	<table id="jqGrid" style="width: 100%;height: 100%"></table>
    <!-- <div id="jqGridPager"></div>  -->
</div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
