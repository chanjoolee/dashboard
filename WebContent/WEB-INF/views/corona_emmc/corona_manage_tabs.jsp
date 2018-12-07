<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Corona Emmc manage script</title>
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
	<script src="js/dashboard.js?version=2017.08.22.01"></script>
	
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
		
	</style>
	
	<script  id="script_common" >
		var dataList = [];
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
				cls: 'srch_box2',
				elements:[
					{
						label:'',
						type: 'HorizontalLayout',
						elements:[
							{
								containerCss:[
									
								],
								label:'',
								type:'Vertical',
								elements:[
									{
										label:'',
										type: 'HorizontalLayout',
										containerCss:[
											{code:'height',value:'30px'}
										],
										elements:[
											
											{
												type:'SearchHeader',
												id: 'categoryHead',
												name: 'categoryHead',
												label:'',
												text:'Corona EMMC Management',
												width: '300px',
												controlCss:[
													{code:'text-align',value:'left'},
													{code:'font-size',value:'14px'}
												]
											}
											
										]
									}
									//2line
									
									
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
												label:'Refresh',
												//width: '50px',
												cls: 'btn_txt btn_type_e btn_color_b',
												containerCss:[
													{code: 'margin-right', value:'3px'}
												],
												events:{
													click : function(){											
														fn_refresh();
													}
												}
											}
										
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
					
					//tab list
					{
						"type": "tab_list",
						"id" : "tab_list",
						"label" : "",
						//
						"elements" : [
							// {
							// 	"type": "tab_iframe",
							// 	"id" : "script_manage",
							// 	"label" : "Script Master Manage",							
							// 	"connected_content" :  {
							// 		"viewName": "corona_manage_script",
							// 		"form_id" : "form"
							// 	}
							// },
							{
								"type": "tab_iframe",
								"id" : "scriptset_management",
								"label" : "TestScript Set Mgmt.",							
								"connected_content" :  {
									"viewName": "corona_emmc/corona_manage_scriptset_tabs",
									"form_id" : "form"
								},
								"events" : {
									//"click" : tab_click
								},
								"iframe_css" : [
									{ "code": "height", "value": "770px" }
								]
							},
							{
								"type": "tab_iframe",
								"id" : "template_script_edit",
								"label" : "Master TS Mgmt.",							
								"connected_content" :  {
									"viewName": "corona_emmc/corona_manage_template_edit",
									"form_id" : "form"
								},
								"iframe_css" : [
									{ "code": "height", "value": "770px" }
								]
							},
							{
								"type": "tab_iframe",
								"id" : "template_script_edit_paging",
								"label" : "Master TS Mgmt. Paging.",							
								"connected_content" :  {
									"viewName": "corona_emmc/corona_manage_template_edit_paging",
									"form_id" : "form"
								},
								"iframe_css" : [
									{ "code": "height", "value": "770px" }
								]
							},
							{
								"type": "tab_iframe",
								"id" : "firmware_script_edit",
								"label" : "Project TS Mgmt.",							
								"connected_content" :  {
									"viewName": "corona_emmc/corona_manage_firmware_edit_paging",
									"form_id" : "form"
								},
								"events" : {
									//"click" : tab_click
								},
								"iframe_css" : [
									{ "code": "height", "value": "770px" }
								]
							},
							{
								"type": "tab_iframe",
								"id" : "project_config",
								"label" : "Project Config",							
								"connected_content" :  {
									"viewName": "corona_emmc/corona_manage_project_showview",
									"form_id" : "form"
								},
								"events" : {
									//"click" : tab_click
								},
								"iframe_css" : [
									{ "code": "height", "value": "770px" }
								]
							}
						]
					}
							
					
				]								
		};
		
		</script>
		<script  id="script_main">
		
		
		$(function () {
			//$("#loader").show();
			setTimeout( function(){
				fn_makeHtml('searchCondition',schemaSearch);
				fn_makeHtml('contentMain',schemaContent);
				
				$( window ).resize(function() {
					//console.log("aaaaa");
				});
				$("#loader").hide();
			},50);
			
			// nspim 안에서 호출하는 경우
			// parent.$("body").css("overflow","");
			// parent.$("body .box_gray").css("height","1500px");
			// $( window ).resize(function() {
			// 	parent.$("body .box_gray").css("height","1500px");
			// });
			
		});
		
		
		function fn_refresh(){
			$("#contentMain").html("");
			fn_makeHtml('contentMain',schemaContent);
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
	
	<div id="searchCondition"></div>
	<div id="contentMain" style="margin-top: 10px;width: 100%;"></div>

	<div id="div1"></div>
	<div id="div2"></div>
	<div id="loader"></div>
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
