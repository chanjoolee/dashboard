<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Corona EMMC summary</title>
    <%-- 1. jquery --%>
    <!-- <script src="js/jquery/jquery-1.11.2.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    <%-- jqgrid --%>
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <!-- link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">  -->
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
	
	<%-- http://swebdeveloper.com/apps/forms-plus-css/popup-form-comment.html --%>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/font-awesome.min.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/modern-forms-plus.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/purple.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/cadetBlue.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/orange.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color4.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/steelBlue.css">
	 
    
  
   <!--  <link rel="stylesheet" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid.css" type="text/css" /> --> 
    <link rel="stylesheet" media="screen" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap.css" type="text/css" />
    <!-- <link rel="stylesheet" media="screen"  href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap-ui.css" type="text/css" /> -->
    
    
    
    <%-- 2. high charts --%>
	<!--<script src="/dashboard/js/Highcharts-5.0.7/code/highcharts.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/highcharts-more.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/drilldown.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/no-data-to-display.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/exporting.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/offline-exporting.src.js"></script> -->
	
	<script src="/dashboard/js/Highstock-5.0.9/code/highstock.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/heatmap.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/highcharts-more.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/drilldown.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/no-data-to-display.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/exporting.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/offline-exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<!-- <script src="js/highcharts/grouped-categories.js"></script> -->
	<!-- <script src="http://blacklabel.github.io/grouped_categories/grouped-categories.js"></script> -->
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.08.31.01"></script>
	
	<%-- 5. local --%>
	<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="http://www.trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" /> -->
	
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" />
	<script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script>
	
	<link rel="stylesheet" type="text/css" href="/nspim/css/common.css" />
	<link rel="stylesheet" type="text/css" href="/nspim/css/new.css" />
	<link rel="stylesheet" type="text/css" href="/nspim/css/board.css" />
	<script src="/common/js/module.js"></script>
	
	<%-- File Saver --%>
	<script type="text/javascript" src="/dashboard/js/FileSaver.js/FileSaver.js" charset="utf-8"></script>
	<script type="text/javascript" src="/dashboard/js/jquery-zclip-master/jquery.zclip.js"></script>
	
	<script type="text/javascript" src="/dashboard/js/alasql-develop/dist/alasql.js"></script>
	<script src="/dashboard/js/jointjs/lodash.min.js"></script>
	
	<%-- jqueryMohthPicker --%>
    <link rel="https://rawgit.com/KidSysco/jquery-ui-month-picker/v3.0.0/demo/MonthPicker.min.css" />
   	<script type="text/javascript" src="https://rawgit.com/digitalBush/jquery.maskedinput/1.4.1/dist/jquery.maskedinput.min.js"></script>
   	<script type="text/javascript" src="https://rawgit.com/KidSysco/jquery-ui-month-picker/v3.0.0/demo/MonthPicker.min.js"></script>
	<style type="text/css" title="main">
	
		html, body,form {
	        /* height: 100%; */
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        /* overflow-y: auto; */
	       /*  overflow-x: hidden; */
	       overflow: hidden;
	        font-size:11px;
	      }
		
		.dashboard-div{
			/* position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0; */
			width: 100%;
			/* margin-top: 10px; */
			/* height: 90%; */	
		}
		
		.container {
		    padding-right: 0px;
		    padding-left: 0px;
		}
		
		.chartContainer {
			width : auto;
			height: auto;
		    /* border: black; */
		   /*  border: 3px solid orange; */
		    border-width: 2px 2px 2px 2px;
		    border-color: orange;
		    border-style: solid; 
		    /* margin-top: 10px; */
		}
		
		.chartContainerSub {
			float: left;
		}
		
		.div-priority{
			/* width: 100%; */
			margin-left: 0 ;
			/* height: 20px; */		
			display: block;	
			font-size: 12px;
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
		
		.modern-p-form{
			font-size:11px;
			font-family:inherit;
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
		
		.btn_n2 {
		 	width: 100px;		 	
		}
		
		.btn_n2:hover {
			width: 100px;
			cursor: pointer;
			text-decoration: none;
		}
		
		.btn_n2:active {
		  width: 100px;
		}
		
		<%-- 탭뷰--%>
		a:hover,a:focus{
		    text-decoration: none;
		    outline: none;
		    cursor: pointer;
		}
		.nav-tabs {
		    border-bottom: 1px solid #e4e4e4;
		}
		.nav-tabs > li{
		    margin-right: 1px;
		}
		.nav-tabs > li > a{
		    border-radius: 0px;
		    border: 1px solid #e4e4e4;
		    border-right: 0px none;
		    margin-right: 0px;
		    padding: 8px 17px;
		    color:#222222;
		    transition: all 0.3s ease-in 0s;
		}
		.nav-tabs > li:last-child{
		    border-right:1px solid #ededed;
		}
		.nav-tabs > li > a{
		    /* padding: 15px 30px; */
		   /*  padding: 4px 6px; */
		    border:1px solid #ededed;
		    border-right: 0px none;
		    border-top: 2px solid #ededed;
		    background: #ededed;
		    color: #8f8f8f;
		    font-weight: bold;
		}
		.nav-tabs > li > a:hover{
		    border-bottom-color: #ededed;
		    border-right: 0px none;
		    background: #f1f1f1;
		    color: #444;
		}
		.nav-tabs > li.active > a,
		.nav-tabs > li.active > a:focus,
		.nav-tabs > li.active > a:hover{
		    border-top: 2px solid #3498db;
		    border-right: 0px none;
		    color: #444;
		}
		.tab-content > .tab-pane{
		    border: 1px solid #e4e4e4;
		    border-top: 0px none;
		    /* padding: 20px; */
		   /*  padding: 20px; */
		    line-height: 22px;
		}
		.tab-content > .tab-pane > h3{
		    margin-top: 0;
		}
		
		
		.table>tbody>tr>td{
			padding: 3px;
		}
		
		
		
		<%--
		/* chart가 숨김시 작아지는 현상 없앰 */
		
		.tab-content > .tab-pane,
		.pill-content > .pill-pane {
		    display: block;    
		    height: 0;          
		    overflow-y: hidden; 
		}
		
		.tab-content > .active,
		.pill-content > .active {
		    height: auto;       
		} 
		--%>
		
		.tab-content .ui-th-column{
			text-align: center;
		}
		
		.table-copy:before {
		    content: "\e142";
		}
		
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
	    
		input[type="text"], input[type="password"]{
	    	height: 34px;
	    }
	    
	    #tabContainer_host .tab_2depth {height: 19px; margin-left: 10px;}
	    #tabContainer_host .tab_2depth .on {border: 1px solid #fb6c07;background: rgba(252, 132, 57, 0.67);}
	    #tabContainer_host .tab_2depth li a {
	        height: 15px;
    		line-height: 16px;
    	}
    	
    	
    	.cellDiv 
        {
            left: 0px; top:5px; height:22px;
            position:relative;padding:0;
            margin-right:-4px;
            margin-top: 3px;
            border:0;
        }
        .gradient1{
            /* fallback (Opera) */
            background: #008AEF;
            /* Mozilla: https://developer.mozilla.org/en/CSS/-moz-linear-gradient */
            background: -moz-linear-gradient(left, #008AEF, white);
            /* Chrome, Safari: http://webkit.org/blog/175/introducing-css-gradients/ */
            background: -webkit-gradient(linear, left top, right top, from(#008AEF), to(white));
            /* MSIE http://msdn.microsoft.com/en-us/library/ms532997(VS.85).aspx */
            filter: progid:DXImageTransform.Microsoft.Gradient(StartColorStr='#008AEF', EndColorStr='white', GradientType=1);
            /*ie8*/
            -ms-filter: "progid:DXImageTransform.Microsoft.Gradient(StartColorStr='#008AEF', EndColorStr='white', GradientType=1)";
            position: absolute; left: -2px; top:-5px; right: 2px; height:22px; float:left;
        }
    	.gradient2{
            /* fallback (Opera) */
            background: #63C384;
            /* Mozilla: */
            background: -moz-linear-gradient(left, #63C384 0%, white 100%);
            /* Chrome, Safari:*/
            background: -webkit-gradient(linear, left top, right top, from(#63C384), to(white));
            /* MSIE */
            filter: progid:DXImageTransform.Microsoft.Gradient(StartColorStr='#63C384', EndColorStr='white', GradientType=1);
            /*ie8*/
            -ms-filter: "progid:DXImageTransform.Microsoft.Gradient(StartColorStr='#63C384', EndColorStr='white', GradientType=1)";
            position: absolute; left: -2px; top:-5px; right: 2px; height:22px; float:left;
        }
        .cellTextRight
        {
           /*  position:relative;
            margin-right:4px;
            text-align:right;
            float:right; */
            
            position: absolute;
		    /* left: -2px; */
		    top: -5px;
		    right: 2px;
		    height: 22px;
		   
        }
		
		<%--  jqGrid에서 dialog가 뒤로 숨는 문제.--%>
		.ui-dialog { z-index: 1000 !important ;}
		div button.ui-button.ui-dialog-titlebar-close {
			display: none;
		}
	</style>


	
	<script type="text/javascript" id="script_common" >
	var dataMain = {
			dataList : [],
			categories: [],
			testnames: []
	};
	function mergeRow(rowId, val, rowObj, cm, rowData, isCustom) {
		
		var result = "";
		var grid = $(this).jqGrid();
		var dataList0 = grid.jqGrid("getGridParam","data");	
		var vpage = grid.getGridParam('page');
		var pageleng = grid.getGridParam('rowNum');
		
		var start = parseInt(pageleng) * (vpage -1);
		var end = parseInt(pageleng) * (vpage);
		var dataList = dataList0.slice(start,end);
		var curRow = dataList[parseInt(rowId)-1];
		var colModel = grid.jqGrid('getGridParam','colModel');
		
		var getColumnSrcIndexByName = function(columnName) {
		    var cm = grid.jqGrid('getGridParam','colModel'),
		        i=0, index=0, l=cm.length, cmName;
		    while (i<l) {
		        cmName = cm[i].name;
		        i++;
		        if (cmName===columnName) {
		            return index;
		        } else if (cmName!=='rn' && cmName!=='cb' && cmName!=='subgrid') {
		            index++;
		        }
		    }
		    return -1;
		};
		
		var colid = getColumnSrcIndexByName(cm.name);
		
		var colModel1 = [];
		if( colModel[0].name == "rn"){
			colModel1 = colModel.slice(1,colModel.length -1);			
		}else{
			colModel1 = colModel;
		}
		var parentCols = colModel1.slice(0,colid + 1);
		
		
		var fn_equal = function(list1,list2,cols){  
			var isEqual = true;
			$.each(cols,function(i,col){
				if(list1[col.name] != list2[col.name]){
					isEqual = false;
					return false;
				}
			});
			return isEqual;
			
		};
		
		var fn_lastRow = function(p_list,p_rowid,p_col,span){
			span++;
			var rowid = parseInt(p_rowid) -1;
			var cur_row = p_list[rowid];
			var next_row = p_list[rowid+1];
			
			
			if(next_row == undefined)
				return {span: span, row: cur_row}; 
			
			//else if(cur_row[p_col] == next_row[p_col]){
			var equal = fn_equal(cur_row,next_row,parentCols);
			if(equal){
				return fn_lastRow(p_list, parseInt(p_rowid) + 1 ,p_col,span);
			}else
				return {span: span, row: cur_row};
		};
		
		var fn_firstRow = function(p_list,p_rowid,p_col){
			
			var rowid = parseInt(p_rowid) -1;
			var cur_row = p_list[rowid];
			var pre_row = p_list[rowid - 1];
			
			if(pre_row == undefined)
				return cur_row;
			
			var equal = fn_equal(cur_row,pre_row,parentCols);
			if(equal){
			//else if(cur_row[p_col] == pre_row[p_col]){
				return fn_firstRow(p_list, parseInt(p_rowid) - 1 ,p_col);
			}else
				return cur_row;
		};
		
		var firstRow = fn_firstRow(dataList,rowId,cm.name);
		var lastRow = fn_lastRow(dataList,rowId,cm.name,0);
		//var firstRow = fn_firstRow(dataList ,rowId,cm.name);
		//var lastRow = fn_lastRow(dataList ,rowId,cm.name,0);
		if(curRow == firstRow){
			result = " style=\"background:white;vertical-align: middle;";
			//result = " style=\"vertical-align: middle;";
			if(!isCustom){
				switch(cm.name) {
				    case 'CATEGORY':
				    	result += "color: rgba(6, 89, 203, 0.93);font-weight: bolder;cursor:pointer;"
				        break;
				    
				    default:
				}
			}
			
			result += "\" ";
			result += 'rowspan=' + lastRow.span;
		}else{
			result = " style=\"display:none;\"";
			result += "\" ";
			
		}
		
		
		
		return result;
	}
	
	// data type 이 local인 경우 적용.
	function mergeRow_local(rowId, cm) {
		
		var result = "";
		var grid = $(this).jqGrid();
		
		var dataList = grid.getRowData();
		var curRow = dataList[parseInt(rowId)-1];
		var colModel = grid.jqGrid('getGridParam','colModel');
		
		var getColumnSrcIndexByName = function(columnName) {
		    var v_cm = grid.jqGrid('getGridParam','colModel'),
		        i=0, index=0, l=v_cm.length, cmName;
		    while (i<l) {
		        cmName = v_cm[i].name;
		        i++;
		        if (cmName===columnName) {
		            return index;
		        } else if (cmName!=='rn' && cmName!=='cb' && cmName!=='subgrid') {
		            index++;
		        }
		    }
		    return -1;
		};
		
		var colid = getColumnSrcIndexByName(cm.name);
		
		var colModel1 = [];
		if( colModel[0].name == "rn"){
			colModel1 = colModel.slice(1,colModel.length -1);			
		}else{
			colModel1 = colModel;
		}
		var parentCols = colModel1.slice(0,colid + 1);
		
		
		var fn_equal = function(list1,list2,cols){  
			var isEqual = true;
			$.each(cols,function(i,col){
				if(list1[col.name] != list2[col.name]){
					isEqual = false;
					return false;
				}
			});
			return isEqual;
			
		};
		
		var fn_lastRow = function(p_list,p_rowid,p_col,span){
			span++;
			var rowid = parseInt(p_rowid) -1;
			var cur_row = p_list[rowid];
			var next_row = p_list[rowid+1];
			
			
			if(next_row == undefined)
				return {span: span, row: cur_row}; 
			
			//else if(cur_row[p_col] == next_row[p_col]){
			var equal = fn_equal(cur_row,next_row,parentCols);
			if(equal){
				return fn_lastRow(p_list, parseInt(p_rowid) + 1 ,p_col,span);
			}else
				return {span: span, row: cur_row};
		};
		
		var fn_firstRow = function(p_list,p_rowid,p_col){
			
			var rowid = parseInt(p_rowid) -1;
			var cur_row = p_list[rowid];
			var pre_row = p_list[rowid - 1];
			
			if(pre_row == undefined)
				return cur_row;
			
			var equal = fn_equal(cur_row,pre_row,parentCols);
			if(equal){
			//else if(cur_row[p_col] == pre_row[p_col]){
				return fn_firstRow(p_list, parseInt(p_rowid) - 1 ,p_col);
			}else
				return cur_row;
		};
		
		var firstRow = fn_firstRow(dataList,rowId,cm.name);
		var lastRow = fn_lastRow(dataList,rowId,cm.name,0);
		//var firstRow = fn_firstRow(dataList ,rowId,cm.name);
		//var lastRow = fn_lastRow(dataList ,rowId,cm.name,0);
		var v_td = grid.find("tbody #"+rowId + " td:eq("+colid+1+")");
		if(curRow == firstRow){
			v_td.css("background","white");
			v_td.css("vertical-align","middle");
			v_td.attr("rowspan",lastRow.span);
			//result = " style=\"background:white;vertical-align: middle;";
			
			//result += "\" ";
			//result += 'rowspan=' + lastRow.span;
		}else{
			v_td.css("display","none");
			//result = " style=\"display:none;\"";
			//result += "\" ";
			
		}
		
		
		
	}
	
	// validation
	$.extend(true, $.jgrid.inlineEdit, {
        beforeSaveRow: function (options, rowid) {
			var grid = $(this).jqGrid();
		    var row = grid.jqGrid('getRowData',rowid);
		    var v_creteria = $(this).find("select[name=COMPUTE_CRETERIA]").val();
		    var v_val = $(this).find("input[name=COMPUTE_VALUE]").val();
		    if(v_creteria == "" && Number(v_val) > 0 ){
		    	var vMsg = "Can not input when None!";
				$("#dialog-confirm").html(vMsg);
				$("#dialog-confirm").dialog({
				    resizable: false,
				    modal: true,
				    title: "Error",
				    height: 200,
				    width: 400,
				    dialogClass: 'no-close',
				    closeOnEscape: false,
				    buttons: [
			              {
			                text: "OK",
			                click: function() {
			                  $( this ).dialog( "close" );
			                  
			                }
			              }
		            ]
				});
				return false;
		    }else
		    	return true;
			
            
        }
    });
	
	</script>
	<script type="text/javascript" id="script_schemaSearchCondition">
	//그리드 편집전 데이타
	var beforEditRow = {};
	
	var EfContextPath = "";
	var Items = [];
	
	var schemaContent = {
		containerId:'contentSmart',
		type:'Vertical',
		label:'',
		elements:[ 
			{
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					//{code: 'height', value:'1000px'},
					{code: 'width', value:'99%'}
				],			
		    	type:'grid',
		    	id: 'grid_summary',
		    	label:'',
		    	data: function(){ 
		    		return dataMain.testnames;
		    	},
		    	
		    	items: Items,
		    	
		    	gridOpt:{
		    		datatype:'local',
		    		pager: "#grid_summaryPager",
		    		editurl: '/dashboard/ssdCusDummySaveJson.do',
		    		viewrecords: true,	
		    		emptyrecords: "No records to view",		    		
		    		width: '100%',
		    		height: '100%',
		    		sortable: true,
		    		multiSort:true,
		    		sortname: 'TESTNAME_FULL',
		    		rowNum: 30,
					rowList:[10,20,30],
		    		//forceFit : false ,
		    		customSortOperations: {
		                // the properties of customSortOperations defines new operations 
		                // used in postData.filters.rules items as op peroperty
		                cge: {
		                    operand: "cge",        // will be displayed in searching Toolbar for example
		                    text: ">= greater or equal",    // will be shown in Searching Dialog or operation menu in searching toolbar
		                    filter: function (options) {
		                        // The method will be called in case of filtering on the custom operation "nIn"
		                        // All parameters of the callback are properties of the only options parameter.
		                        // It has the following properties:
		                        //     item        - the item of data (exacly like in mydata array)
		                        //     cmName      - the name of the field by which need be filtered
		                        //     searchValue - the filtered value typed in the input field of the searching toolbar
		                        var fieldData = parseFloat(options.item[options.cmName]),
		                            data = $.map(
		                                options.searchValue.split(";"),
		                                function (val) {
		                                    return parseFloat(val);
		                                }
		                            );
		                        return $.inArray(fieldData, data) >= 0;
		                    }
		                }
		            },
		    		gridComplete: function () {
		    			var grid = $(this).jqGrid();
		    			var cms = grid.jqGrid("getGridParam", "colModel");
		    			var rows = grid.getRowData();
		    			var mergeCols = ['TESTNAME_FULL'];
		    			
		    			$.each(mergeCols, function(i,col){
		    				$.each(rows,function(j,row){
			    				var cm = cms.filter(function(cm){ return cm.name=='TESTNAME_FULL' })[0];
			    				mergeRow_local.call(grid, j+1+"" , cm);			    				
			    			});
		    			});
		    			
		    			
		    			
		    			grid.jqGrid('filterToolbar',
	    					{
	    						defaultSearch:'cn'
	    		                // JSON stringify all data from search, including search toolbar operators
	    		                ,stringResult: true
	    		                // instuct the grid toolbar to show the search options
	    		                ,searchOperators: true
	    		            }
	    				);
		    		}
			    	
			    	, onCellSelect: function (rowId, iCol, content, event) {
				    	var test = "";
				    	var theGrid = $(this).jqGrid();
				    	var row = theGrid.jqGrid('getRowData',rowId);
				    	var cms = theGrid.jqGrid("getGridParam", "colModel");
						var cm = cms[iCol];
						
						
				    }
		    	}
				
			}
			

		]								
	};
	
	
	function totalProgress(){
		var grid = $("#grid_summary").jqGrid();
		var captionBar = $("#grid_summary").find(".ui-jqgrid-caption");
		//var totalDiv = $(document.createElement( "div" ));
		
		
		var total_weight = 0;
		var total_progress = 0;
		
		$.each(grid.getRowData(),function(i,row){
			// weight 
			var weight = row.WEIGHT;
			if(weight == undefined)
				weight = 0;
			
			if( typeof weight == "string")
				weight = Number(weight);
			
			if(weight == 0)
				weight = 1;
			
			total_weight += weight;
			
		});
		
		$.each(grid.getRowData(),function(i,row){
			
			// one progress
			var total = row.TOTAL_COUNT;
			var pass = row.PASS_COUNT;
			var fail = total - pass;
			var progress = 0;
			var progress1 = 0;
			var progress2 = "";

			if(pass == 0 && row.COMPUTE_CRETERIA != undefined && row.COMPUTE_CRETERIA != ""  && row.COMPUTE_CRETERIA != "normal" ){
				pass = row.COMPUTE_VALUE;
				if(pass == undefined)
					pass = 0;
					
				if(row.COMPUTE_CRETERIA == "hrs"){
					total = 96;										
				}else if(row.COMPUTE_CRETERIA == "sec"){
					total = 86400;	
				}else if(row.COMPUTE_CRETERIA == "step"){
					total = 868;	
				}else if(row.COMPUTE_CRETERIA == "min"){
					total = 10000;	
				}									
			}
			progress = pass/total;
			progress1 = progress * 100;
			progress2 = progress1.toFixed(2);
			progress3 = Number(progress2);
			
			// weight 
			var weight = row.WEIGHT;
			if(weight == undefined)
				weight = 0;
			
			
			if( typeof weight == "string")
				weight = Number(weight);
			
			if(weight == 0)
				weight = 1;
			
			total_progress += (weight/total_weight) * progress3;
			
			
			//return total_progress1;
			
		});
		var total_progress1 = "(Total Progress : " + total_progress.toFixed(2) + " %)";
		$("#total_progress").text(total_progress1);
		
	}
	
	function fn_items(){
		
		var theGrid = parent.parent.$("#searchGridTable");
		var selIds = theGrid.jqGrid('getGridParam','selarrrow');
		var row = theGrid.jqGrid('getRowData',selIds[0]);
		
	   	var paramObj = {
			folderNames :[],
			selectedPoints :[]
		};
		var param = "";
		$.each(selIds,function(i,s){
			var row = theGrid.jqGrid('getRowData',s);
			if(i > 0)
				param +="&";
			param += "folderName="+ row.FOLDER_NAME;
			paramObj.folderNames.push(row.FOLDER_NAME);
		});
		
		$.ajax({
			type: "POST",
    		url: "/dashboard/genericlListJson.do",
    		data: {searchJson: JSON.stringify(paramObj),  sqlid: 'dashboard.regresson.mainlist.category.tasktime.list'}, 
    		async: false,
    		success:  function(response){
    			dataMain.dataList = response.dataList;
    		}
    	});
		
		$.each(dataMain.dataList, function(){
			var duration = this.DURATION;
			var dSplit = duration.split(":");	
			var day = Number(dSplit[0].split(".")[0]);
			var hh = Number(dSplit[0].split(".")[1]);
			var mm = Number(dSplit[1]);
			var ss = Number(dSplit[2])/60/60;
			//var duration_ss = hh + mm + ss;
			var duration_ss = day*24*60 + hh*60 + mm + ss/60;
			
			this.duration_ss = Math.round(duration_ss,0);
			//this.duration_ss = 0;
			
			var dateSplit = this.START_TIME.split("/");
			var utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2],dateSplit[3],dateSplit[4],dateSplit[5]);
			this.startTimeUtc = utcdt;	   
		});
		
		var categories = groupbyCount(dataMain.dataList,['CATEGORY']);
		var testnames = groupbyCount(dataMain.dataList,['TESTNAME_FULL','FOLDER_NAME','PJT_NAME_PMS','FIRMWARE_REVISION','SLOTNAME']);
		//var testnames = groupbyCount(dataMain.dataList,['TESTNAME_FULL','FOLDER_NAME']);
		sortObjects(testnames,['TESTNAME_FULL','FOLDER_NAME']);
		var max = maxValue(dataMain.dataList,['duration_ss']);
		dataMain.categories = categories;
		dataMain.testnames = testnames;
		
		var item = {
			label: 'Test Name' ,
			name: 'TESTNAME_FULL' , 
			id: 'TESTNAME_FULL' , 
			align:'left', 
			width: 280, 
			sortable: true,
			//cellattr: mergeRow
			//,formatter: function (cellvalue,col,row) {
			//	return row.TESTNAME_FULL;
            //}
            editrules:{edithidden:true}
		};
		Items.push(item);
		
		$.each(categories,function(i,c){			
		
			var vitem = {
					label: c.CATEGORY ,
					name: c.CATEGORY , 
					id: c.CATEGORY , 
					align:'center', 
					width: 80, 
					sortable: false,
					search: false,
					searchoptions : {
                        // show search options
                        sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  			
                        //sopt: ["ge","cge"]
					},
					formatter: function (cellvalue,col,row) {
						var category = col.colModel.name;
						var list = dataMain.dataList.filter(function(d){
							return (d.CATEGORY == category && d.TESTNAME_FULL == row.TESTNAME_FULL && d.FOLDER_NAME == row.FOLDER_NAME);
						});
						
						var str = "";
						if(list.length > 0){
							sortObjects(list,[['duration_ss','desc']]);							
							$.each(list,function(i,d){
								str += gradientNumberFormat.call(d,d.duration_ss, "gradient2", 0, 3600, 0, 100);
							});		
							return str;
						}							
						else 
							return "";

						
		            }
		            , editrules:{edithidden:true}
				};
				Items.push(vitem);
		});
		
		var item1 = {
			label: 'Folder Name' ,
			name: 'FOLDER_NAME' , 
			id: 'FOLDER_NAME' , 
			align:'left', 
			width: 370, 
			sortable: true
			//,formatter: function (cellvalue,col,row) {
			//	return row.TESTNAME_FULL;
            //}
            , editrules:{edithidden:true}
		};
		Items.push(item1);
		
		//,'PJT_NAME_PMS','FIRMWARE_REVISION','SLOTNAME
		var item1 = {
			label: 'Project' ,
			name: 'PJT_NAME_PMS' , 
			id: 'PJT_NAME_PMS' , 
			align:'left', 
			width: 210, 
			sortable: true
			//,formatter: function (cellvalue,col,row) {
			//	return row.TESTNAME_FULL;
            //}
            , editrules:{edithidden:true}
		};
		Items.push(item1);
		
		var item1 = {
			label: 'Firmware' ,
			name: 'FIRMWARE_REVISION' , 
			id: 'FIRMWARE_REVISION' , 
			align:'center', 
			width: 150, 
			sortable: true
			//,formatter: function (cellvalue,col,row) {
			//	return row.TESTNAME_FULL;
            //}
            , editrules:{edithidden:true}
		};
		Items.push(item1);
		
		var item1 = {
				label: 'Slot Name' ,
				name: 'SLOTNAME' , 
				id: 'SLOTNAME' , 
				align:'center', 
				width: 150, 
				sortable: true
				//,formatter: function (cellvalue,col,row) {
				//	return row.TESTNAME_FULL;
	            //}
	            , editrules:{edithidden:true}
			};
			Items.push(item1);
		
	}

	
	</script>
	<script type="text/javascript" id="script_main">
	
	
	$(function () {
		//$("#loader").show();
		setTimeout( function(){
			fn_items();
			//fn_makeHtml('searchCondition',schemaSearch);
			fn_makeHtml('contentMain',schemaContent);
			$( window ).resize(function() {
				//console.log("aaaaa");
			});
			$("#loader").hide();
		},50);
		
		parent.$("body").css("overflow","");
	});
	
	// header 에 검색조건을 만들어 달라고 하면
	function makeSearchOption(){
//		var theGrid = $("#searchGridTable");
//		var selIds = theGrid.jqGrid('getGridParam','selarrrow');
//		var row = theGrid.jqGrid('getRowData',selIds[0]);
//		
//		var param = "";
//		$.each(selIds,function(i,s){
//			var row = theGrid.jqGrid('getRowData',s);
//			if(i > 0)
//				param +="&";
//			param += "folderName="+ row.FOLDER_NAME;
//		});
		
		
		//search option
//		$.ajax({
//    		url: "/dashboard/genericlListJson.do",
//    		data: param + "&sqlid=dashboard.regresson.distinct.field&field=FOLDER_NAME", 
//    		async: false,
//    		success:  function(response){
//    			gridSearchOption.foldername.value = ":[ALL]";
//    			$.each(response.dataList,function(i,m){
//    				gridSearchOption.foldername.value += ";"+ m.col + ":" +m.col; 
//				});
//    		}
//    	});
		
//		$.ajax({
//    		url: "/dashboard/genericlListJson.do",
//    		data: param + "&sqlid=dashboard.regresson.distinct.field&field=FIRMWARE", 
//    		async: false,
//    		success:  function(response){
//    			gridSearchOption.firmware.value = ":[ALL]";
//    			$.each(response.dataList,function(i,m){
//    				gridSearchOption.firmware.value += ";"+ m.col + ":" +m.col; 
//				});
//    		}
//    	});
		
//		$.ajax({
//    		url: "/dashboard/genericlListJson.do",
//    		data: param + "&sqlid=dashboard.regresson.distinct.field&field=TESTNAME", 
//    		async: false,
//    		success:  function(response){
//    			gridSearchOption.testname.value = ":[ALL]";
//    			$.each(response.dataList,function(i,m){
//    				gridSearchOption.testname.value += ";"+ m.col + ":" +m.col; 
//				});
//    		}
//    	});
		
//		$.ajax({
//    		url: "/dashboard/genericlListJson.do",
//    		data: param + "&sqlid=dashboard.regresson.distinct.field&field=SLOTNAME", 
//    		async: false,
//    		success:  function(response){
//    			gridSearchOption.slotname.value = ":[ALL]";
//    			$.each(response.dataList,function(i,m){
//    				gridSearchOption.slotname.value += ";"+ m.col + ":" +m.col; 
//				});
//    		}
//    	});
		// search option end
	}
	
	function createDB(){
		//alasql('create table smart(DATA_SRC string , FIELD string, MEASURE string ,ROWKEY string, ROWVALUE string , SLOTNAME string , TESTNAME string, TOOL string)');
		//alasql('create index idxSmart on smart(FIELD,SLOTNAME,TESTNAME)');
	}
	
	function gradientNumberFormat(cellvalue, gradientClass, minDataValue, maxDataValue,minDisplayValue, maxDisplayValue) {
        var dataAsNumber = parseFloat(cellvalue); /* parseInt(cellvalue, 10);*/
        if (dataAsNumber > maxDataValue) {
            dataAsNumber = maxDataValue;
        }
        if (dataAsNumber < minDataValue) {
            dataAsNumber = minDataValue;
        }
        var prozentVal = minDisplayValue + (dataAsNumber - minDataValue) * (maxDisplayValue - minDisplayValue) / (maxDataValue - minDataValue);
        
        var dSplit = this.DURATION.split(":");			
        
		//var hh = dSplit[0] + ' Day' ;		
		//var mm = dSplit[1] + ' Min';
		//var ss = dSplit[2] + 'SS';
		//var strTime =hh + mm + ss;
        
        var rtnStr = "";
        rtnStr += '<div class="cellDiv"';
        //rtnStr += ' onclick="alert(\''+this.FOLDER_NAME+'\');"';
        rtnStr += '>';
        rtnStr +='		<div class="' + gradientClass + '" style="width:' + prozentVal + '%;"></div>';
        rtnStr +='     <div class="cellTextRight">' + cellvalue + ' min</div>';
        rtnStr +='</div>';
        return rtnStr;
    };
	
	function fn_management(){
		var newwin = window.open("coronaEmmcScriptManagement", "coronaEmmcScriptManagement", "width=1200,height=860,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		var oFrm = document.getElementById("form");
		//oFrm.menuAuthId.value = "MNU20150422131320740";
		//oFrm.action =  '/dashboard/generic.do?viewName=corona_manage_script';
		oFrm.action =  '/dashboard/generic.do?viewName=corona_emmc/corona_manage_tabs';
		oFrm.method = "post";
		oFrm.target = 'coronaEmmcScriptManagement'; 
	    oFrm.submit();
		newwin.focus();
	}

	</script>
	
	</head>


<body  style="min-width:920px" >
<form name="form" id="form" class="">
	<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
	<input type="hidden" name="cookieName" value="${param.cookieName}"/>
	<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
	<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
	
	<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
	<input type="hidden" id="category" name="category" value=""/>

	<div id="searchCondition"></div>
	<div id="contentMain" style="margin-top: 10px;width: 100%;"></div>

	<div id="loader"></div>
	<div id="dialog-confirm"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
