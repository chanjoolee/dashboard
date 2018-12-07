<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>SSD manage copy template to scriptset</title>
		<%-- 1. jquery --%>
		<!-- <script src="js/jquery/jquery-1.11.2.js"></script> -->
		<script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
		<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
		<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
		<!-- <script src="js/jquery.csv-0.71.js"></script> -->
		
		<%-- jqgrid --%>
		<!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
		<script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
		<script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js?version=2018.02.23"></script>    
		
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
		<script src="/dashboard/js/dashboard.js?version=2018.02.23.01"></script>
		
		<%-- 5. local --%>
		<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" /> -->
		<!-- <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
		<!-- <link rel="stylesheet" type="text/css" href="http://www.trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" /> -->
		
		<%-- multi select --%>
		<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
		<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
		<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
		<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
		<!-- <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" /> -->
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
		<link rel="https://cdn.jsdelivr.net/gh/KidSysco/jquery-ui-month-picker@v3.0.0/demo/MonthPicker.min.css" />
		<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/digitalBush/jquery.maskedinput@1.4.1/dist/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/KidSysco/jquery-ui-month-picker@v3.0.0/demo/MonthPicker.min.js"></script>
		
		<%-- recat --%>
		<!--<script src="https://facebook.github.io/react/js/jsfiddle-integration-babel.js"></script>-->
		
		<script  src="/dashboard/js/react-0.14.3/build/react.js"></script>
		<script  src="/dashboard/js/react-0.14.3/build/react-dom.js"></script>
		<script  src="/dashboard/js/react-0.14.3/build/react-with-addons.js"></script>
		<script  src="/dashboard/js/react-0.14.3/browser.js" ></script>
   	
   	
	<style type="text/css" title="main">
	
		html, body,form {
	        /* height: 100%; */
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        /* overflow-y: auto; */
	    	/* overflow-x: hidden; */
	       	/* overflow: hidden; */
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
		  position: fixed;
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
            position:relative;padding:0;margin-right:-4px;border:0;
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
            position:relative;
            margin-right:4px;
            text-align:right;
            float:right;
        }
		
		<%--  jqGrid에서 dialog가 뒤로 숨는 문제.--%>
		.ui-dialog { z-index: 1000 !important ;}
		div button.ui-button.ui-dialog-titlebar-close {
			display: none;
		}
		
		
		.table_hori td {
		    height: 20px;
		    padding: 5px 10px;
		    border: 1px solid #e1e2e6;
		    word-wrap: break-word;
		    table-layout: fixed;
		    line-height: 160%;
		    color: #000;
		    white-space: pre;
		}
		.cont_tit {
		    padding-bottom: 3px;
		}
		
		<%--  jqGrid에서 add popup에서 scroll--%>
		.ui-jqdialog-content .FormGrid {
		    overflow: hidden;
		}
		
	</style>
	
	<script  id="script_common" >
	var dataList = [];
	var scriptGroupList = [];
	var scriptGroupListStr = "";
	function mergeRow(rowId, val, rowObj, cm, rowData, isCustom) {
		var result = "";
		var grid = $(this).jqGrid();
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
		
		var firstRow = fn_firstRow(grid.jqGrid("getGridParam","data"),rowId,cm.name);
		var lastRow = fn_lastRow(grid.jqGrid("getGridParam","data"),rowId,cm.name,0);
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
	
		
	</script>
	<script  id="script_schemaSearchCondition">
	//그리드 편집전 데이타
	var tempList = [];
	var beforEditRow = {};
	
	var EfContextPath = "";
	
	var schemaSearch = {
		containerId:'searchCondition',
		type:'Vertical',
		label:'',
		
		elements:[
			// {
			// 	containerCss:[
			// 		{code: 'margin-top', value:'10px'},
			// 	],		
			// 	type:"title",
			// 	id: "title_script",
			// 	label: "Script Template"
			// },
			{
				label:'',
				type: 'HorizontalLayout',
				cls: 'srch_box2',
				containerCss:[
					{code: 'margin-top', value:'3px'},
					{code: 'margin-left', value:'20px'},
					{code: 'margin-right', value:'20px'}
				],		
				elements:[
					{
						containerCss:[
							
						],
						label:'',
						type:'Vertical',
						elements:[
							// Stage
							{
								label:'',
								type: 'HorizontalLayout',
								containerCss:[
									{code:'height',value:'30px'}
								],
								elements:[
									// Stage
									{
										type:'SearchHeader',
										id: 'stageHead',
										name: 'stageHead',
										label:'',
										text:'Stage',
										width: '50px'
									},
									{
										type:'multiCombo',
										id: 'stage',
										name: 'stage',
										label:'',
										text:'Stage',
										width: '200px',
										data: function(){
											var rtnList = [
												{STAGE:"WS1", selected: "selected"},
												{STAGE:"WS2", selected: "selected"},
												{STAGE:"ES1", selected: "selected"},
												{STAGE:"ES2", selected: "selected"},
												{STAGE:"CUS", selected: "selected"}
											];
											// $.ajax({
											// 	url: "/dashboard/genericlListJson.html",
											// 	data: {sqlid: "dashboard.ssd_sm.script.category.distinct"}, 
											// 	async: false,
											// 	success:  function(response){
											// 		rtnList = response.dataList;
											// 	}
											// });
											return rtnList;
										},
										//value :'CSSD',
										options: {
											cd:'STAGE',
											name:'STAGE'
											
										},
										multiselectOpt:{
											//selectedList: 1 ,
											multiple: true,
											selectedText: function(numChecked, numTotal, checkedItems){
												//return numChecked + ' of ' + numTotal + ' checked';
												var rtn = "";
												var sb = [];
												$.each(checkedItems,function(i,d){
													if(i < 2)
														sb.push($(this).val());
												});
												rtn = sb.join(",");
												if((checkedItems.length-2) > 0){
													rtn += " ..." + (checkedItems.length-2)+" more"
												}
												return rtn;
											}
										},
										events:{
											
										}
									} 
									
								]
							}
							// Group
							,{
								label:'',
								type: 'HorizontalLayout',
								containerCss:[
									{code:'height',value:'30px'}
								],
								elements:[
									{
										type:'SearchHeader',
										id: 'scriptGroupHead',
										name: 'scriptGroupHead',
										label:'',
										text:'Group',
										width: '50px'
									},
									{
										type:'multiCombo',
										id: 'scriptGroup',
										name: 'scriptGroup',
										label:'',
										text:'Group',
										width: '300px',
										data: function(){
											return scriptGroupList;
										},
										//value :'CSSD',
										options: {
											cd:'SCRIPT_GROUP',
											name:'GROUP_NAME'
										},
										multiselectOpt:{
											//selectedList: 1 ,
											multiple: true,
											selectedText: function(numChecked, numTotal, checkedItems){
												//return numChecked + ' of ' + numTotal + ' checked';
												var rtn = "";
												var sb = [];
												$.each(checkedItems,function(i,d){
													if(i < 2)
														sb.push($(this).attr("title"));
												});
												rtn = sb.join(",");
												if((checkedItems.length-2) > 0){
													rtn += " ..." + (checkedItems.length-2)+" more"
												}
												return rtn;
											}
										},
										events:{
											change : function(){
												fn_search_script();
											}
										}
									} 
									
								]
							}
							
							// Category, Sub Category
							,{
								label:'',
								type: 'HorizontalLayout',
								containerCss:[
									{code:'height',value:'30px'}
								],
								elements:[
									//categoryHead
									{
										type:'SearchHeader',
										id: 'categoryHead',
										name: 'categoryHead',
										label:'',
										text:'Category',
										width: '50px'
									},
									//Category
									{
										type:'multiCombo',
										id: 'category',
										name: 'category',
										label:'',
										text:'Category',
										width: '300px',
										data: function(){
											var rtnList = [];
											$.ajax({
												url: "/dashboard/genericlListJson.html",
												data: {sqlid: "dashboard.ssd_sm.script.category.distinct"}, 
												async: false,
												success:  function(response){
													rtnList = response.dataList;
												}
											});
											return rtnList;
										},
										//value :'CSSD',
										options: {
											cd:'CATEGORY',
											name:'CATEGORY',
											childrens : [
												{
													id: "subCategory" ,
													topElement: "schemaSearch.elements"
												}
											]
										},
										multiselectOpt:{
											//selectedList: 1 ,
											multiple: true,
											selectedText: function(numChecked, numTotal, checkedItems){
												//return numChecked + ' of ' + numTotal + ' checked';
												var rtn = "";
												var sb = [];
												$.each(checkedItems,function(i,d){
													if(i < 2)
														sb.push($(this).val());
												});
												rtn = sb.join(",");
												if((checkedItems.length-2) > 0){
													rtn += " ..." + (checkedItems.length-2)+" more"
												}
												return rtn;
											}
										},
										events:{
											
										}
									} ,
									// SubCategory mHead
									{
										type:'SearchHeader',
										id: 'SubCategoryead',
										name: 'SubCategoryead',
										label:'',
										text:'Sub Category',
										width: '90px'
									},
									// SubCategory
									{
										type:'multiCombo',
										id: 'subCategory',
										name: 'subCategory',
										label:'',
										text:'Sub Category',
										width: '300px',
										data: function(){
											var rtnList = [];
											$.ajax({
												url: "/dashboard/genericlListJson.html",
												data: {sqlid: "dashboard.ssd_sm.script.sub_category.distinct", sample: $("#category").val() }, 
												async: false,
												success:  function(response){
													rtnList = response.dataList;
													tempList = rtnList;
												}
											});
											return rtnList;
										},
										//value :'CSSD',
										options: {
											cd:'SUB_CATEGORY' ,
											name:'SUB_CATEGORY',
											group: {
												cd:'CATEGORY',
												name: 'CATEGORY'
											}
											
										},
										multiselectOpt:{
											//selectedList: 1 ,
											multiple: true,
											selectedText: function(numChecked, numTotal, checkedItems){
												//return numChecked + ' of ' + numTotal + ' checked';
												var rtn = "";
												var sb = [];
												$.each(checkedItems,function(i,d){
													if(i < 2)
														sb.push($(this).val());
												});
												rtn = sb.join(",");
												if((checkedItems.length-2) > 0){
													rtn += " ..." + (checkedItems.length-2)+" more"
												}
												return rtn;
											}
										},
										events:{
											change : function(){
												fn_search_script();
												// parent.$("#loader").show();
												// setTimeout( function(){
												// 	$("#contentMain").html("");
												// 	makeHtml("contentMain",schemaContent);
												// 	parent.$("#loader").hide();
												// },50); 
											}
										}
									}
									
									
								]
							}
							
						]
					},
					//검색버튼
					{
						label:'',
						type: 'VerticalLayout',
						cls: 'btn_txt',
						containerCss:[
							{code: 'margin-left', value:'10px'}
							, {code: 'float', value:'right'}
						]
						, elements:[
							{
								label:'',
								type: 'HorizontalLayout',
								cls: 'btn_txt',
								containerCss:[
									{code: 'margin-left', value:'10px'}
								],
								elements:[
									{
										type:'Button',
										id: 'btnSearch',
										name: 'btnSearch',
										label:'SEARCH',
										//width: '50px',
										cls: 'btn_txt btn_type_e btn_color_a',
										containerCss:[
											{code: 'margin-right', value:'3px'}
										],
										events:{
											click : function(){
												//parent.$("#loader").show();
												//setTimeout( function(){
												//	$("#contentMain").html("");
												//	makeHtml("contentMain",schemaContent);
												//	parent.$("#loader").hide();
												//},50);
												fn_search_script();
											}
										}
									}
									// {
									// 	type:'Button',
									// 	id: 'btnUpload',
									// 	name: 'btnUpload',
									// 	label:'UPLOAD',
									// 	//width: '50px',
									// 	cls: 'btn_txt btn_type_e btn_color_a',
									// 	containerCss:[
									// 		{code: 'margin-right', value:'3px'}
									// 	],
									// 	events:{
									// 		click : function(){
									// 			$('#fileInput').click();
									// 		}
									// 	}
									// },
									// {
									// 	type:'Button',
									// 	id: 'btnDownload',
									// 	name: 'btndownload',
									// 	label:'DOWNLOAD',
									// 	//width: '50px',
									// 	cls: 'btn_txt btn_type_e btn_color_a',
									// 	containerCss:[
									// 		{code: 'margin-right', value:'3px'}
									// 	],
									// 	events:{
									// 		click : function(){
									// 			fn_FileDownloadAjax();
									// 		}
									// 	}
									// }
								
								]
							}
									
						]
						
					}
				]
			}
		
			
		
		]
			
	};
	
	var schemaContent = {
			containerId:'contentCoronaDetail',
			type:'Vertical', 
			label:'',
			elements:[ 
				
				
				
				//script master grid
				{
					label: '',
					type: 'HorizontalLayout',
					containerCss:[
						{code: 'display', value:'inline-block'},
						{code: 'width', value:'100%'},
						{code: 'padding-left', value:'20px'},
						{code: 'padding-right', value:'20px'}
					],			
					elements: [
						{
							containerCss:[
								{code: 'width', value:'100%'}
								//,{code: 'float', value:'left'}
							],			
					    	type:'grid',
					    	id: 'grid_script',
					    	label:' ',
					    	items:[				
								{label:'Seq', name:'SEQ', id:'SEQ', width:100, align:'left', sortable:false , editable: false , search: false, hidden: true}
								,{label:'Group', name:'GROUP_NAME', id:'GROUP_NAME', width:110, align:'left'
									, sortable:false 
									, search: false
								}
								,{label:'Count', name:'ROWNUM_GRP', id:'ROWNUM_GRP', width:100, align:'left', sortable:false , editable: false , search: false, hidden: true}
								,{label:'Stage', name:'STAGE', id:'STAGE', width:70, align:'center', sortable:false,editable: false, editrules:{edithidden:false}, search: false }		
								,{label:'Category', name:'CATEGORY', id:'CATEGORY', width:150, align:'left', sortable:false,editable: false, editrules:{edithidden:false}, search: false }
								,{label:'Sub Category', name:'SUB_CATEGORY', id:'SUB_CATEGORY', width:150, align:'left', sortable:false,editable: false, editrules:{edithidden:false}, search: false}
								,{label:'Item', name:'ITEM', id:'ITEM', width:150, align:'left', sortable:false , editable: false }
								,{label:'Sub Item', name:'SUB_ITEM', id:'SUB_ITEM', width:150, align:'left', sortable:false , editable: false }
								,{label:'Script', name:'SCRIPT_NAME', id:'SCRIPT_NAME', width:350, align:'left', sortable:false , editable: false}
					    		
					    	],	
					    	data: function(){
					    		var rtnList = [];
					    		$.ajax({
					    			type: "POST",
					    			url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_sm.manage.script.search",
					    			//data: {searchJson: JSON.stringify(paramObj), sqlid: 'dashboard.regresson.smartlist.raw'}, 
					    			data: $("#form").serialize(), 
					    			async: false,
					    			success:  function(response){
					    				rtnList  = response.dataList;
					    			}
					    		});
					    		
					    		return rtnList;
					    	},		
					    	
					    	// script grid option		
					    	gridOpt:{
					    		datatype:'local',
					    		//loadonce: true,
					    		pager: "#grid_scriptPager",
					    		editurl: '/dashboard/ssdCusDummySaveJson.html',
					    		//editurl: '/dashboard/genericSaveJson.html?sqlid=dashboard.corona.emmc.script_master.insert',
					    		styleUI : 'Bootstrap',
					    		viewrecords: true,			    		
					    		width: '100%',
					    		height: 500,
					    		sortable: true,
					    		multiSort:true,
					    		multiselect: true,
					    		multiboxonly:true, 
					    		sortname: 'SEQ, CATEGORY,SCRIPT_NAME',
					    		rowNum: 1000000,
					    		//forceFit : false ,
					    		emptyrecords: "No records to view",
					    		//rownumbers: true, // show row numbers
					    		
					    		grouping: true,
					    		groupingView: {
									groupField: ["GROUP_NAME","CATEGORY"],
									groupColumnShow: [false,false],
									groupText: ['<input type="checkbox" class="groupHeader"/><b>  {0} - {1} Item(s)  </b>','{0} - {1} Item(s)'],
									groupOrder: ["asc"],
									//groupSummary: [true],
									//groupSummaryPos: ["header"],
									hideFirstGroupCol: true,
									groupCollapse: true
								},
					    		
					    		//subgrid start
					    		subGrid: true,
					    		subgridtype:'json',
					    		subGridRowExpanded: function(parentRowID, parentRowKey){
					    			var test = "";
							    	var theGrid = $(this).jqGrid();
							    	var row = theGrid.jqGrid('getRowData',parentRowKey);
							    	var cms = theGrid.jqGrid("getGridParam", "colModel");
							    	
					    			
					    			
					    			// ***  grid ***//
					    			var childDivId = parentRowID + "_div_input";
					    			var childDiv = $(document.createElement("div"));
					    			childDiv.attr("id",childDivId);
					    			// add a table and pager HTML elements to the parent grid row - we will render the child grid here			    			
					                $('#' + parentRowID).append(childDiv);
					    			
					    			var detailList = [];
									$.ajax({
						    			type: "POST",
						    			url: "/dashboard/genericlListJson.html",
						    			data: {
						    				script_name: row.SCRIPT_NAME
						    				, sqlid: 'dashboard.ssd_sm.manage.script.search.one'}, 
						    			//data: $("#form").serialize(), 
						    			async: false,
						    			success:  function(response){
						    				detailList  = response.dataList;
						    				
						    			}
						    		});
						    		
						    		// script grid detail
					    			var schema1 = {
										containerId: childDivId,
										type:'Vertical',
										label: '',
										elements: [
											{
												label: "",
												type: 'Group',
												elements: [
													{
														type: "inline",
														cols: 1,
														data: function(){ 
															return detailList[0];
														},
														options : {
															keys : ['SCRIPT_NAME'],
															fn_change: function( input ){
																//
																// if(this.props.options.name == 'SCRIPT_NAME'){
																// 	var convert = this.reactObjects.find(function(td){
																// 		return td.props.options.name == 'CONVERT_SCRIPT';
																// 	});	
																// 	//convert digit
																// 	//var v_hax = this.state.value;
																// 	var v_hax = input;
																// 	var v_digit = [];
																// 	$.each(v_hax.split(" "), function(i,str){
																// 		var d = "";
																// 		if(str.startsWith("0x")){
																// 			v_digit.push(parseInt(str,16));
																// 		}else{
																// 			v_digit.push(str);
																// 		}
																// 	});																		
																// 	convert.setState({value : v_digit.join(" ")});
																	
																// }
																
															},
															fn_submit: function(){
																//alert("submit function defined");
																var state = true;
																var paramObj = {
																	//origindatas: this.props.options.keys
																	origindatas: this.state.keys
																};
																
																if(this.props.options.value == this.state.value)
																	return state;
																$.ajax({
																	url: "/dashboard/genericSaveJson.html",
																	type: "POST",
																	data: {
																		searchJson: JSON.stringify(paramObj),
																		fieldName: this.state.name,
																		fieldValue: this.state.value,
																		fieldValueOrigin: this.state.value_origin,
																		userId: $("#userId").val(),
																		sqlid: "dashboard.ssd_sm.script_master.update"
																	}, 
																	async: false,			                    		
																	success:  function(data){
																		response1 = data;
																		if(response1.result != 'success'){
																			state = false;
																			msg = "Save Success!";
																			$("#dialog-confirm").html(response1.message);
																			$("#dialog-confirm").dialog({
																				resizable: false,
																				modal: true,
																				title: "Error",
																				//height: 200,
																				width: 300,
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
																			
																			
																			
																		}						                    			
																	}
																});
																
																return state;
															},
															fn_afterSubmit: function(keyUpdatedObjects){
																
																$.each(this,function(i,react){
																	if(_.find(cms,function(cm){return cm.name == react.state.name})){
																		var vobject = {};
																		vobject[react.state.name] = react.state.value;
																		theGrid.setRowData(parentRowKey,vobject);
																	}
																	
																});
																
															},
															progressObject: parent.$("#loader")
														},
														items: [
															{label:'Script Name(key)', col: 'SCRIPT_NAME', editable: true},
															{label:'Stage', col: 'STAGE', editable: true
																, edit_tag : 'select'
																// , selectOptions : stageList
															},
															{label:'Group', col: 'GROUP_NAME', editable: true},
															{label:'CATEGORY', col: 'CATEGORY', editable: true},
															{label:'Sub Category', col: 'SUB_CATEGORY', editable: true},
															{label:'Item', col: 'ITEM', editable: true},
															{label:'Sub Item', col: 'SUB_ITEM', editable: true},
															{label:'Description', col: 'DESCRIPTION' , edit_tag: 'textarea'},
															{label:'Tester', col: 'TESTER' }

														]
														
													}
													
												
												]
											}
										]
									};
					    			fn_makeHtml(childDiv,schema1);
					    			
					    		} ,
					    		//subgrid end
					    		
					    		onSelectAll: function(rowIds, allChecked) {
									$("#grid_script input.groupHeader").prop('checked', allChecked);
								},
					    		gridComplete: function () {
					    			var v_grid = $(this).jqGrid();
					    			v_grid.jqGrid('filterToolbar',
				    					{
				    						defaultSearch:'cn'
				    		                // JSON stringify all data from search, including search toolbar operators
				    		                ,stringResult: true
				    		                // instuct the grid toolbar to show the search options
				    		                //,searchOperators: true
				    		            }
				    				);
				    				
				    				$("#grid_script tbody input[type=checkbox].groupHeader").change(function (e) {		
		    							if("${param.scriptset}" == ""){ 
		    								parent.$("#loader").show(); 
		    							}else{
		    								$("#loader").show();
		    							}
		    							var currentCB = $(this);
		    							setTimeout( function(){		    								
										    var grid = jQuery('#grid_script');
											var isChecked = this.checked;
											if (currentCB.is(".groupHeader")) {	//if group header is checked, to check all child checkboxes						
												var checkboxes = currentCB.closest('tr').
										          nextUntil('tr.grid_scriptghead_0').find('.cbox[type="checkbox"]');
												checkboxes.each(function(){
												    //if (!this.checked || !isChecked)                   
										            //    grid.setSelection($(this).closest('tr').attr('id'), true); 
										            grid.setSelection($(this).closest('tr').attr('id'), isChecked);
												});		
												var a = "a";
											}
											if("${param.scriptset}" == ""){ 
			    								parent.$("#loader").hide(); 
			    							}else{
			    								$("#loader").hide();
			    							}
		    							},50);
									    
									});	
					    			
					    			// script master add
					    			//$("#grid_scriptContainer input.cbox").hide();
					    			$('#grid_scriptPager .ui-paging-pager').hide();
					    		}
						    	
						    	
					    	}
							
						}
					

					
					]
				},
				
				// copy Button
				{ 
					type:'Button',
					id: 'to_btnCopy',
					name: 'to_btnCopy',
					label:'Copy',
					//width: '50px',
					cls: 'btn_txt btn_type_e btn_color_c',
					controlCss: [
						{code: 'width', value:'300px'}
					],
					containerCls : "center_section",
					containerCss:[
						{code: 'margin-top', value:'20px'}
					],
					events:{
						click : function(){
									// if(fn_validation()){
									// 	parent.$("#loader").show();
									// 	setTimeout( function(){
									// 		fn_copy();
									// 		fn_search_firmware();
									// 		//parent.$("#loader").show();
									// 	},50);	
									// }
							
							fn_validation(function(){
								if("${param.scriptset}" == ""){ 
    								parent.$("#loader").show(); 
    							}else{
    								$("#loader").show();
    							}
								setTimeout( function(){
									var v_ok = fn_copy();
									if(v_ok == true)
										fn_search_firmware();
									else {
										if("${param.scriptset}" == ""){ 
											parent.$("#loader").hide(); 
										}else{
											$("#loader").hide();
										}
									}

									//parent.$("#loader").show();
								},50);	
							});
							
						}
					}
				},
				
				{
					controlCss:[
						{code: 'margin-top', value:'10px'} 
					],	
					type:"title",
					label: "Target: Script Set"
				},
				
				// target search
				{
					label: '',
					type: 'HorizontalLayout', 
					cls: 'srch_box2',
					containerCss:[
						{code: 'height', value:'40px'},
						{code: 'margin-top', value:'3px'},
						{code: 'margin-right', value:'20px'},
						{code: 'margin-left', value:'20px'}
					],
					elements: [
						{
							type:'SearchHeader',
							id: 'scriptsetHead',
							name: 'scriptsetHead',
							label:'',
							text:'Script Set',
							width: '70px'
						},
						
						{
							type:'multiCombo',
							id: 'to_scriptset',
							name: 'to_scriptset',
							label:'',
							text:'Scriptset',
							width: '230px',
							data: function(){
								var rtnList = [];
								$.ajax({
									url: "/dashboard/genericlListJson.html",
									data: {sqlid: "dashboard.ssd_sm.manage.scriptsets.search"}, 
									async: false,
									success:  function(response){
										rtnList = response.dataList;
										$.each(rtnList,function(i,d){
											if(d.SCRIPTSET == "${param.scriptset}")
												d.selected = "selected";
											
										});
									}
								});
								return rtnList;
							},
							//value :'CSSD',
							options: {
								cd:'SCRIPTSET',
								name:'SCRIPTSET'
							},
							multiselectOpt:{
								selectedList: 1 ,
								multiple: false,
								selectedText: function(numChecked, numTotal, checkedItems){
									 //return numChecked + ' of ' + numTotal + ' checked';
									 var sb = [];
									 $.each(checkedItems,function(){
										 sb.push($(this).val());
									 });
									 return sb.join(",");
								}
							},
							events:{
								change : function(){
									// end change events
									fn_search_firmware();
								}
							}
						} ,
						
						// search Button
						{
							type:'Button', 
							id: 'to_btnSearch',
							name: 'to_btnSearch',
							label:'SEARCH',
							//width: '50px',
							cls: 'btn_txt btn_type_e btn_color_a',
							containerCss:[
								{code: 'margin-right', value:'3px'},
								{code: 'float', value:'right'}
							],
							events:{
								click : function(){
									fn_search_firmware();
								}
							}
						}
						
						
					]
				},
				
				
				
				// target grid
				{
					containerCss:[
						{code: 'margin-top', value:'10px'},
						{code: 'width', value:'100%'},
						{code: 'padding-left', value:'20px'},
						{code: 'padding-right', value:'20px'}
					],			
			    	type:'grid',
			    	id: 'grid_firmware',
			    	label:' ',
			    	items:[	
						{label:'Seq', name:'SEQ', id:'SEQ', width:100, align:'left', sortable:false , editable: false , search: false, hidden: true}
						,{label:'Group', name:'GROUP_NAME', id:'GROUP_NAME', width:110, align:'left'
							, sortable:false 
							, search: false
						}
						,{label:'Count', name:'ROWNUM_GRP', id:'ROWNUM_GRP', width:100, align:'left', sortable:false , editable: false , search: false, hidden: true}
						
						,{label:'Stage', name:'STAGE', id:'STAGE', width:70, align:'center', sortable:false,editable: false, editrules:{edithidden:false}, search: false }		
						,{label:'Category', name:'CATEGORY', id:'CATEGORY', width:150, align:'left', sortable:false,editable: false, editrules:{edithidden:false}, search: false }
						,{label:'Sub Category', name:'SUB_CATEGORY', id:'SUB_CATEGORY', width:150, align:'left', sortable:false,editable: false, editrules:{edithidden:false}, search: false}
						,{label:'Item', name:'ITEM', id:'ITEM', width:150, align:'left', sortable:false , editable: false }
						,{label:'Sub Item', name:'SUB_ITEM', id:'SUB_ITEM', width:150, align:'left', sortable:false , editable: false }
						,{label:'Script', name:'SCRIPT_NAME', id:'SCRIPT_NAME', width:350, align:'left', sortable:false , editable: false}
			    		
			    	],	
			    	data: function(){
			    		//var rtnList = [];
			    		return [];
			    	},	
			    	
			    	// target Grid option			
			    	gridOpt:{
			    		datatype:'local',
			    		pager: "#grid_firmwarePager",
			    		editurl: '/dashboard/ssdCusDummySaveJson.html',
			    		styleUI : 'Bootstrap',
			    		viewrecords: true,			    		
			    		width: '100%',
			    		height: 500,
			    		sortable: true,
			    		multiSort:true,
			    		multiselect: true,
			    		multiboxonly:true, 
			    		sortname: 'SEQ, CATEGORY,SCRIPT_NAME',
			    		rowNum: 1000000,
			    		//forceFit : false ,
			    		emptyrecords: "No records to view",
			    		//rownumbers: true, // show row numbers
			    		
			    		grouping: true,
			    		groupingView: {
							groupField: ["GROUP_NAME","CATEGORY"],
							groupColumnShow: [false,false],
							//groupText: ['<input type="checkbox" class="groupHeader"/> <b>  {0}  </b>'],
							groupText: ['   {0} - {1} Item(s)','{0} - {1} Item(s)'],
							groupOrder: ["asc"],
							//groupSummary: [true],
							//groupSummaryPos: ["header"],
							hideFirstGroupCol: true,
							groupCollapse: true
						},
			    		
			    		//subgrid start
			    		subGrid: true,
			    		subgridtype:'json',
			    		
			    		subGridRowExpanded: function(parentRowID, parentRowKey){
			    			var test = "";
					    	var theGrid = $(this).jqGrid();
					    	var row = theGrid.jqGrid('getRowData',parentRowKey);
					    	var cms = theGrid.jqGrid("getGridParam", "colModel");
			    			
			    			// ***  grid ***//
			    			var childDivId = parentRowID + "_div_input";
			    			var childDiv = $(document.createElement("div"));
			    			childDiv.attr("id",childDivId);
			    			// add a table and pager HTML elements to the parent grid row - we will render the child grid here			    			
			                $('#' + parentRowID).append(childDiv);
			                
			                var detailList = [];
							$.ajax({
				    			type: "POST",
				    			url: "/dashboard/genericlListJson.html",
				    			data: {
				    				scriptset: row.SCRIPTSET
				    				, script_name: row.SCRIPT_NAME
				    				, sqlid: 'dashboard.ssd_sm.manage.script.search.one'
				    			}, 
				    			//data: $("#form").serialize(), 
				    			async: false,
				    			success:  function(response){
				    				detailList  = response.dataList;
				    				
				    			}
				    		});
				    		
				    		// target grid detail
			    			var schema1 = {
								containerId: childDivId,
								type:'Vertical',
								label: '',
								elements: [
									{
										label: "",
										type: 'Group',
										elements: [
											{
												type: "inline",
												cols: 1,
												data: function(){ 
													return detailList[0];
												},
												options : {
													keys : ['SCRIPT_NAME'],
													fn_change: function( input ){
														//
														// if(this.props.options.name == 'SCRIPT_NAME'){
														// 	var convert = this.reactObjects.find(function(td){
														// 		return td.props.options.name == 'CONVERT_SCRIPT';
														// 	});	
														// 	//convert digit
														// 	//var v_hax = this.state.value;
														// 	var v_hax = input;
														// 	var v_digit = [];
														// 	$.each(v_hax.split(" "), function(i,str){
														// 		var d = "";
														// 		if(str.startsWith("0x")){
														// 			v_digit.push(parseInt(str,16));
														// 		}else{
														// 			v_digit.push(str);
														// 		}
														// 	});																		
														// 	convert.setState({value : v_digit.join(" ")});
															
														// }
														
													},
													fn_submit: function(){
														//alert("submit function defined");
														var state = true;
														var paramObj = {
															//origindatas: this.props.options.keys
															origindatas: this.state.keys
														};
														
														if(this.props.options.value == this.state.value)
															return state;
														$.ajax({
															url: "/dashboard/genericSaveJson.html",
															type: "POST",
															data: {
																searchJson: JSON.stringify(paramObj),
																fieldName: this.state.name,
																fieldValue: this.state.value,
																fieldValueOrigin: this.state.value_origin,
																userId: $("#userId").val(),
																sqlid: "dashboard.ssd_sm.script_master.update"
															}, 
															async: false,			                    		
															success:  function(data){
																response1 = data;
																if(response1.result != 'success'){
																	state = false;
																	msg = "Save Success!";
																	$("#dialog-confirm").html(response1.message);
																	$("#dialog-confirm").dialog({
																		resizable: false,
																		modal: true,
																		title: "Error",
																		//height: 200,
																		width: 300,
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
																	
																	
																	
																}						                    			
															}
														});
														
														return state;
													},
													fn_afterSubmit: function(keyUpdatedObjects){
														
														$.each(this,function(i,react){
															if(_.find(cms,function(cm){return cm.name == react.state.name})){
																var vobject = {};
																vobject[react.state.name] = react.state.value;
																theGrid.setRowData(parentRowKey,vobject);
															}
															
														});
														
													},
													progressObject: parent.$("#loader")
												},
												items: [
													{label:'Script Name(key)', col: 'SCRIPT_NAME', editable: true},
													{label:'Stage', col: 'STAGE', editable: true
														, edit_tag : 'select'
														// , selectOptions : stageList
													},
													{label:'Group', col: 'GROUP_NAME', editable: true},
													{label:'CATEGORY', col: 'CATEGORY', editable: true},
													{label:'Sub Category', col: 'SUB_CATEGORY', editable: true},
													{label:'Item', col: 'ITEM', editable: true},
													{label:'Sub Item', col: 'SUB_ITEM', editable: true},
													{label:'Description', col: 'DESCRIPTION' , edit_tag: 'textarea'},
													{label:'Tester', col: 'TESTER' }

												]
												
											}
											
										
										]
									}
								]
							};
			    			
			    			fn_makeHtml(childDiv,schema1);
			    			
			    		} ,
			    		//subgrid end
			    		
			    		onSelectAll: function(rowIds, allChecked) {
							$("#grid_firmware input.groupHeader").prop('checked', allChecked);
						},
			    		gridComplete: function () {
			    			var v_grid = $(this).jqGrid();
			    			v_grid.jqGrid('filterToolbar',
		    					{
		    						defaultSearch:"cn"
		    		                // JSON stringify all data from search, including search toolbar operators
		    		                ,stringResult: true
		    		                // instuct the grid toolbar to show the search options
		    		                //,searchOperators: true
		    		            }
		    				);
		    				
			    			// Firmware Script master Edit
							$("#grid_firmwareContainer input.cbox").hide();
							$('#grid_firmwarePager .ui-paging-pager').hide();
			    		}
				    	
				    	
			    	}
					
				}
				
				
			]								
	};
		
	// 테스트 중. 그룹별로 상세리스트 만들기
	function groupbyList(json,pkeys){
		var abcArr = json;
		var items = {}, base, key,val ;
		for (var i = 0; i < abcArr.length; i++) {
		    base = abcArr[i];
		    
		    var pkey = '';
		    var key = '';
		    for(var j=0; j < pkeys.length; j++){
		    	pkey = pkeys[j];
		    	
		    	if(j>0)
		    		key += ";;;";
		    	// if not already present in the map, add a zeroed item in the map
			    if(!items[key]){
			    	items[key] = {
			    		count: 0,
			    		list:[]
			    	};
			    }
			    
		    	key += base[pkey];
		    }
		}

		// Now, generate new array
		var outputArr = [], temp;
		for (key in items) {
		    // create array entry for the map value
		    //temp = [key, items[key]];
			temp = {};
			temp.count =  items[key].count;
			//temp.key =  items[key];
		    for(var j=0; j < pkeys.length; j++){
		    	var pkey = pkeys[j];
		    	//if(temp[pkey])
		    		temp[pkey] = key.split(';;;')[j];
		    }
		    // put array entry into the output array
		    outputArr.push(temp);
		}
		
		return outputArr;
	}
	
	//target search condition change
	function fn_search_firmware(){
		if("${param.scriptset}" == ""){ 
			parent.$("#loader").show(); 
		}else{
			$("#loader").show();
		}
		setTimeout( function(){
			var rtnList = [];
			var paramObj = {
				search_scriptset : $("#to_scriptset").val(),
				sqlid: "dashboard.ssd_sm.manage.scriptset_script_map.search"
			};
			$.ajax({
				type: "POST",
				url: "/dashboard/genericlListJson.html",
				//data: {searchJson: JSON.stringify(paramObj), sqlid: "dashboard.corona.emmc.manage.script.scriptset.mapping"}, 
				//data: $("#form").serialize(), 
				data: paramObj,
				async: false,
				success:  function(response){
					rtnList  = response.dataList;
					//return rtnList;
					var theGrid = $("#grid_firmware").jqGrid();
					theGrid.jqGrid('clearGridData');
					theGrid.jqGrid('setGridParam', { data: rtnList});
					theGrid.trigger('reloadGrid');	
					
					if("${param.scriptset}" == ""){ 
						parent.$("#loader").hide(); 
					}else{
						$("#loader").hide();
					}
					
				}
			});		
			
		},50);
			
	}
	
	//target search condition change
	function fn_search_script(){
		if("${param.scriptset}" == ""){ 
			parent.$("#loader").show(); 
		}else{
			$("#loader").show();
		}
		setTimeout( function(){
			var rtnList = [];
			var paramObj = {
				sample : $("#category").val(),
				firmware : $("#testItem").val(),
				sqlid: "dashboard.ssd_sm.manage.script.search"
			};
			$.ajax({
				type: "POST",
				url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_sm.manage.script.search",
				//data: {searchJson: JSON.stringify(paramObj), sqlid: "dashboard.corona.emmc.manage.script.firmware.mapping"}, 
				data: $("#form").serialize(), 
				//data: paramObj,
				async: false,
				success:  function(response){
					rtnList  = response.dataList;
					//return rtnList;
					var theGrid = $("#grid_script").jqGrid();
					theGrid.jqGrid('clearGridData');
					theGrid.jqGrid('setGridParam', { data: rtnList});
					theGrid.trigger('reloadGrid');	
					if("${param.scriptset}" == ""){ 
						parent.$("#loader").hide(); 
					}else{
						$("#loader").hide();
					}
					
				}
			});		
			
		},50);
			
	}
	
	function fn_copy(){
		var paramObj = {
			
			selectedlist : [],
			src : {
				
			},
			target : {
				scriptset : $("#to_scriptset").val()
			}
		}
		
		var gridScript = $("#grid_script").jqGrid();
    	var selIds = gridScript.jqGrid('getGridParam','selarrrow');
    	$.each(selIds,function(i,rowid){
    		var row = gridScript.getRowData(rowid);
    		paramObj.selectedlist.push(row);
    	});
		
		// 01. hystory no 
		var v_hystoryno = "";
		$.ajax({
			url: "/dashboard/genericlListJson.html",
			type: "POST",
			timeout: 200000,
			data: {
				sqlid: "dashboard.ssd_sm.historyno"
			}, 
			async: false,			                    		
			success:  function(data){
				v_hystoryno =  data.dataList[0].HISTORY_NO;            			
			}
		});
		
		// 02. hystory no insert
		var update_ok = false;
		$.ajax({
			url: "/dashboard/genericSaveJson.html",
			type: "POST",
			timeout: 200000,
			data: {
				searchJson: JSON.stringify(paramObj),
				history_no : v_hystoryno ,
				// sqlid: "dashboard.corona.emmc.manage.insert.historyno.copy_template_scriptset"
				sqlid: "dashboard.ssd_sm.manage.insert.historyno.copy_template_scriptset"
			}, 
			async: false,			                    		
			success:  function(data){
				response1 = data;
				if(response1.result == 'success'){
					update_ok = true;
				}else {
					update_ok = false;
	    			$("#dialog-confirm").html(response1.message);
	    			$("#dialog-confirm").dialog({
	    			    resizable: false,
	    			    modal: true,
	    			    title: "Success",
	    			    //height: 200,
	    			    width: 300,
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
				}						                    			
			}
		});
		
		if( !update_ok)
			return update_ok;
		
		paramObj.loop_id = "selectedlist";
		// 03. last process data
		$.ajax({
			url: "/dashboard/genericSaveJson.html",
			type: "POST",
			data: {
				searchJson: JSON.stringify(paramObj),
				history_no : v_hystoryno ,
				// sqlid: "dashboard.corona.emmc.manage.script_copy_scriptset.update"
				sqlid: "dashboard.ssd_smc.manage.script_copy_scriptset.update"
			}, 
			async: false,			                    		
			success:  function(data){
				response1 = data;
				if(response1.result == 'success'){
					update_ok = true;
					
				}else {
					update_ok = false;
	    			$("#dialog-confirm").html(response1.message);
	    			$("#dialog-confirm").dialog({
	    			    resizable: false,
	    			    modal: true,
	    			    title: "Success",
	    			    //height: 200,
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
				}						                    			
			}
		});
		
		
		if( !update_ok)
			return update_ok;
		
		return true;
		// 04. stauts update
	}
	
	function fn_validation(onSuccess){
		
		var gridScript = $("#grid_script").jqGrid();
    	var selIds = gridScript.jqGrid('getGridParam','selarrrow');
    	if(selIds.length == 0){
			alert("select more than one item!");
			return false;
		}else{
			var message = "Do you copy to \"" + $("#to_scriptset").val() + "\" ?";
			$("#dialog-confirm").html(message);
			var rtn = $("#dialog-confirm").dialog({
			    resizable: false,
			    modal: true,
			    title: "Confirm",
			    //height: 200,
			    width: 350,
			    dialogClass: 'no-close',
			    closeOnEscape: false,
			    buttons: [
		              {
		                text: "OK",
		                click: function() {		
		                	$( this ).dialog( "close" );	
		                	onSuccess();
		                  	
		                  											                    			                  
		                }
		              },
		              {
		                text: "No",
		                click: function() {		
		                  	$( this ).dialog( "close" );	
		                  											                    			                  
		                }
		              }
	            ]
			});
			
			
		}
	}
	
	function fn_load_scriptGroups() {
		$.ajax({
			url: "/dashboard/genericlListJson.html",
			data: {sqlid: "dashboard.ssd_sm.script.group.list"}, 
			async: false,
			success:  function(response){
				// for grid list
				scriptGroupList = response.dataList;
				$.each(scriptGroupList,function(){
					this.value = this.SCRIPT_GROUP;
					this.label = this.GROUP_NAME;
				});
				scriptGroupListStr = "{";
				scriptGroupListStr += "\"" + "" + "\":\"" + "Select" + "\"";
				$.each(scriptGroupList,function(i,d){
					// if(i> 0)
					scriptGroupListStr += ",";
					scriptGroupListStr += "\"" + d.SCRIPT_GROUP + "\":\"" + d.GROUP_NAME + "\"";
				});
				scriptGroupListStr += "}";

				// var grid = findAll("grid_firmware",schemaContent.elements)[0];
				// if(grid != undefined){
				// 	var col = _.find(grid.items,{name:'SCRIPT_GROUP'});
				// 	if( col != undefined)
				// 		col.editoptions.value = JSON.parse(scriptGroupListStr);
				// }
				// rtn = JSON.parse(tmp);
			}
		});
	}
	</script>
	<script  id="script_main">
	
	
	$(function () {
		if("${param.scriptset}" == ""){ 
			parent.$("#loader").show(); 
		}else{
			$("#loader").show();
		}
		setTimeout( function(){
			fn_load_scriptGroups();
			fn_makeHtml('searchCondition',schemaSearch);
			fn_makeHtml('contentMain',schemaContent);
			
			$( window ).resize(function() {
				//console.log("aaaaa");
			});
			if("${param.scriptset}" == ""){ 
				parent.$("#loader").hide(); 
			}else{
				$("#loader").hide();
			}
			fn_search_firmware();
		},50);
		
//		parent.$("body").css("overflow","");
//		parent.$("body .box_gray").css("height","1500px");
//		$( window ).resize(function() {
//			parent.$("body .box_gray").css("height","1500px");
//		});
		
	});
	
	</script>
	
	</head>


<body  style="min-width:920px" >
<form name="form" id="form" class="">
	<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
	<input type="hidden" name="cookieName" value="${param.cookieName}"/>
	<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
	<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
	<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
	
	<div id="searchCondition"></div>
	<div id="contentMain" style="margin-top: 10px;width: 100%;"></div>

	<div id="div1"></div>
	<div id="div2"></div>
	<div id="loader" style="display:none;"></div>
	<div id="dialog-confirm"></div>
</form>

</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
<script type="text/babel">
	var Greeting = React.createClass({
	  render: function() {
	    return (
	      <p>Hello, Universe {this.props.name}</p>
	    )
	  }
	});

	
	
	window.fn_greeting=function(vLabel){
		ReactDOM.render(
		  <Greeting />,
		  document.getElementById('div1')
		);
	}
	
	class ContactInfo extends React.Component {
	    render() {
	        return(
	            <li>{this.props.name} {this.props.phone}</li>
	            );
	    }
	}
	
	class App extends React.Component {
	    render(){

	        return (
	                <Contacts/>
	        );
	    }
	}
	
	class Contacts extends React.Component {
	    constructor(props) {
	        super(props);
	        this.state = {
	            contactData: [
	                {name: "Abet", phone: "010-0000-0001"},
	                {name: "Betty", phone: "010-0000-0002"},
	                {name: "Charlie", phone: "010-0000-0003"},
	                {name: "David", phone: "010-0000-0004"}
	            ]
	        };
	    }
	    render(){
	        return(
	            <div>
	                <h1>Contacts</h1>
	                <ul>
	                    {this.state.contactData.map((contact, i) => {
	                        return (<ContactInfo name={contact.name}
	                                            phone={contact.phone}
	                                              key={i}/>);
	                    })}
	                </ul>
	            </div>
	        );
	    }
	}

	
	//ReactDOM.render(<App />, document.getElementById('div2'));
	
	window.fn_contacts=function(){
		ReactDOM.render(<App />, document.getElementById('div2'));
	}
	
	
	class Td extends React.Component {
		
		constructor(props) {
	        super(props);
	        // Configure default state
			this.state = this.props.options;
			//this.dblclick.bind(this);
			this.changeHandler = this.changeHandler.bind(this);
	    }
	    
	    dblclick(){
	    	if(this.state.editable == true)
	    		this.setState({mode: "edit"});
	    }
	    
	    confirm(){
	    	this.props.options.fn_submit.call(this);
	    	this.setState({mode: "read"});
	    }
	    
	    cancel(){
	    	this.setState({value: this.props.options.value});
	    	this.setState({mode: "read"});
	    }
	    
	    changeHandler(e){
	    	//alert("changeHandler");
	    	this.setState({value: e.target.value });	    	
	    }
	    
	    
	    
	    render(){
	    	
	    	if(this.props.options.editable == false || this.state.mode == "read"){
	    		return(
				<div style={{width:"100%",height:"100%"}} onDoubleClick={this.dblclick.bind(this)}>
					{this.state.value}
				</div>
	        	);
	    	}else if(this.state.mode == "edit") {	  
	    		if(this.state.edit_tag == "textarea"){
	    			return (
			    		<div>
							<textarea style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value }/>;
							<div className="right_section"  >
								<a href="#" className="btn_txt btn_type_e btn_color_a" onClick={this.cancel.bind(this)}>
		                          <span className="name">
		                              <span className="txt">Cancel</span>
		                          </span>
		                      	</a>
							</div>
							
							<div className="right_section" style={{marginRight:"3px"}} >
								<a href="#" className="btn_txt btn_type_e btn_color_c" onClick={this.confirm.bind(this)}>
		                          <span className="name">
		                              <span className="txt">Confirm</span>
		                          </span>
		                      	</a>
							</div>
							
						</div>
					);
	    		}else {
	    			return (
			    		<div>
							<input style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value}></input>
							<div className="right_section"  >
								<a href="#" className="btn_txt btn_type_e btn_color_a" onClick={this.cancel.bind(this)}>
		                          <span className="name">
		                              <span className="txt">Cancel</span>
		                          </span>
		                      	</a>
							</div>
							<div className="right_section" style={{marginRight:"3px"}}>
								<a href="#" className="btn_txt btn_type_e btn_color_c" onClick={this.confirm.bind(this)}>
		                          <span className="name">
		                              <span className="txt">Confirm</span>
		                          </span>
		                      	</a>
							</div>
							
						</div>
					);
	    		}		
	    		
				
	    	}
	        
	            
	    }
	}
	
	window.fn_td = function(cell, options){
		return ReactDOM.render(<Td options={options}/>, cell);
	}
	
</script>
</html>
