<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>corona summary</title>
    <%-- 1. jquery --%>
    <!--<script src="js/jquery/jquery-1.11.2.js"></script>-->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.src.js"></script>
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
	<script src="/dashboard/js/bootstrap/bootstrap3-typeahead.js"></script>
	
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
	<script src="js/dashboard.js?version=2017.09.13.01"></script>
	
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
			
			elements:[
//				{
//					containerCss:[
//						{code: 'margin-top', value:'10px'},
//					],		
//					type:"title",
//					id: "title_script",
//					label: "Script Template"
//				},
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
											text:'Category',
											width: '50px'
										},
										
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
													data: {sqlid: "dashboard.corona.script.category.distinct"}, 
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
														id: "testItem" ,
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
										
										
										{
											type:'SearchHeader',
											id: 'testItemHead',
											name: 'testItemHead',
											label:'',
											text:'Test Item',
											width: '60px'
										},
										
										
										{
											type:'multiCombo',
											id: 'testItem',
											name: 'testItem',
											label:'',
											text:'Test Item',
											width: '300px',
											data: function(){
												var rtnList = [];
												$.ajax({
													url: "/dashboard/genericlListJson.html",
													data: {sqlid: "dashboard.corona.script.test_item.distinct", sample: $("#category").val() }, 
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
												cd:'TEST_ITEM' ,
												name:'TEST_ITEM',
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
//													parent.$("#loader").show();
//													setTimeout( function(){
//														$("#contentMain").html("");
//														makeHtml("contentMain",schemaContent);
//														parent.$("#loader").hide();
//													},50); 
												}
											}
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
								{label:'Category', name:'CATEGORY', id:'CATEGORY', width:100, align:'left', sortable:false , editable: true, editrules:{edithidden:false}
									,edittype: "text"
									,editoptions: {
			                            // dataInit is the client-side event that fires upon initializing the toolbar search field for a column
			                            // use it to place a third party control to customize the toolbar
			                            dataInit: function (element) {
										   $(element).attr("autocomplete","off").typeahead({ 
											   	appendTo : "body",
												source: function(query, proxy) {
													$.ajax({
														url: '/dashboard/genericlListJson.html?sqlid=dashboard.corona.autocomplete.script&callback=?&field=CATEGORY',
														//dataType: "jsonp",
														data: {term: query},
														//dataType: "json",
														//success : proxy
														success: function (data) {
								                            proxy($.map(data.dataList, function(item) {
								                            	return item.name;
							                                 }));//END Response
								                        } //END Success
								                        
													});//END AJAX
												}
												
											});
										}
										
									}
								}
								,{label:'Count', name:'ROWNUM_GRP', id:'ROWNUM_GRP', width:100, align:'left', sortable:false , editable: false}
								,{label:'Test Item', name:'TEST_ITEM', id:'TEST_ITEM', width:100, align:'left', sortable:false , editable: true 
									,edittype: "text"
									,editoptions: {
			                            // dataInit is the client-side event that fires upon initializing the toolbar search field for a column
			                            // use it to place a third party control to customize the toolbar
			                            dataInit: function (element) {
										   $(element).attr("autocomplete","off").typeahead({ 
											   	appendTo : "body",
												source: function(query, proxy) {
													$.ajax({
														url: '/dashboard/genericlListJson.html?sqlid=dashboard.corona.autocomplete.script&callback=?&field=TEST_ITEM',
														//dataType: "jsonp",
														data: {term: query},
														//dataType: "json",
														//success : proxy
														success: function (data) {
								                            proxy($.map(data.dataList, function(item) {
								                            	return item.name;
							                                 }));//END Response
								                        } //END Success
								                        
													});//END AJAX
												}
												
											});
										}
										
									}
								 }
								,{label:'Script', name:'SCRIPT_NAME', id:'SCRIPT_NAME', width:600, align:'left', sortable:false , editable: true }
								,{label:'TAT LVL', name:'SCRIPT_TAT_LVL', id:'SCRIPT_TAT_LVL', width:100, align:'left', sortable:false , editable: true }
								,{label:'Script Version', name:'SCRIPT_VERSION', id:'SCRIPT_VERSION', width:100, align:'left', sortable:false , editable: true }
					    		
					    	],	
					    	data: function(){
					    		var rtnList = [];
					    		$.ajax({
					    			type: "POST",
					    			url: "/dashboard/genericlListJson.html?sqlid=dashboard.corona.manage.script.search",
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
					    		loadonce: false,
					    		pager: "#grid_scriptPager",
					    		editurl: '/dashboard/ssdCusDummySaveJson.html',
					    		//editurl: '/dashboard/genericSaveJson.html?sqlid=dashboard.corona.script_master.insert',
					    		styleUI : 'Bootstrap',
					    		viewrecords: true,			    		
					    		width: '100%',
					    		height: 500,
					    		sortable: true,
					    		multiSort:true,
					    		multiselect: true,
					    		multiboxonly:true, 
					    		sortname: 'CATEGORY, SCRIPT_NAME',
					    		rowNum: 1000000,
					    		//forceFit : false ,
					    		emptyrecords: "No records to view",
					    		//rownumbers: true, // show row numbers
					    		
					    		grouping: true,
					    		groupingView: {
									groupField: ["CATEGORY","ROWNUM_GRP"],
									groupColumnShow: [false,false],
									groupText: ['<input type="checkbox" class="groupHeader"/> <b>  {0} - {1} Item(s)  </b>'],
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
						    				, sqlid: 'dashboard.corona.manage.script.search.one'}, 
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
															type: "inline_edit",
															cols: 1,
															data: function(){ 
																return detailList[0];
															},
															options : {
																keys : ['SCRIPT_NAME'],
																fn_submit: function(){
																	//alert("submit function defined");
																	var state = true;
																	var paramObj = {
																		//origindatas: this.props.options.keys
																		origindatas: this.state.keys
																	};
																	
																	//if(this.props.options.value == this.state.value)
																	//	return state;
																	//return;
																	$.ajax({
											                    		url: "/dashboard/genericSaveJson.html",
											                    		type: "POST",
											                    		data: {
											                    			searchJson: JSON.stringify(paramObj),
											                    			fieldName: this.state.name,
											                    			fieldValue: this.state.value,
											                    			fieldValueOrigin: this.state.value_origin,
											                    			userId: $("#userId").val(),
											                    			sqlid: "dashboard.corona.script_master.update"
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
																	//var filter = dataFilter()
																	$.each(keyUpdatedObjects,function(i,react){
																		if(react.state.name == "SCRIPT_NAME"){
																			theGrid.setRowData(parentRowKey,{SCRIPT_NAME:react.state.value});
																		}
																	});
																	
																},
																progressObject: parent.$("#loader")
															},
															items: [
																{label:'Script Name', col: 'SCRIPT_NAME', editable: true},
																{label:'Category', col: 'CATEGORY', editable: true},
																{label:'Test Item', col: 'TEST_ITEM', editable: true},
																{label:'Single Multi', col: 'SINGLE_MULTI'},
																{label:'Power Mode Speed', col: 'POWER_MODE_SPEED'},
																{label:'Test Time', col: 'TEST_TIME'},
																{label:'Need Vendor CMD', col: 'NEED_VENDOR_CMD'},
																{label:'Luconfig 유무', col: 'LUCONFIG_YN'},
																{label:'UFS Ver', col: 'UFS_VER'},
																{label:'Precondition', col: 'PRECONDITION'},
																{label:'POR', col: 'POR'},
																{label:'HW Reset', col: 'HW_RESET'},
																{label:'EP Reset', col: 'EP_RESET'},
																{label:'H8', col: 'H8'},
																{label:'SSU', col: 'SSU'},
																{label:'Target LU', col: 'TARGET_LU'},
																{label:'Power Control', col: 'POWER_CONTROL'},
																{label:'Item Name', col: 'ITEM_NAME'},
																{label:'Script TAT LVL', col: 'SCRIPT_TAT_LVL'},
																{label:'Script Version', col: 'SCRIPT_VERSION'},
																{label:'PF110', col: 'PF110'},
																{label:'EXYNOS 7420', col: 'EXYNOS_7420'},
																{label:'P4 Rev', col: 'P4_REV'},
																{label:'Priority', col: 'PRIORITY'},
																{label:'TG645', col: 'TG645'},
																{label:'Need Power Cycle', col: 'NEED_POWER_CYCLE'},
																{label:'Reset YN', col: 'RESET_YN'},
																{label:'Script LVL', col: 'SCRIPT_LVL'},
																{label:'Refactoring', col: 'REFACTORING'},
																{label:'Reset Type', col: 'RESET_TYPE'},
																
																{label:'Item Purpose', col: 'ITEM_PURPOSE', edit_tag: 'textarea'},
																{label:'Item Description', col: 'ITEM_DESCRIPTION' , edit_tag: 'textarea'},
																{label:'Input Parameter', col: 'INPUT_PARAMETER' , edit_tag: 'textarea'},
																{label:'Comment', col: 'USER_COMMENT' , edit_tag: 'textarea'}
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
		    							parent.$("#loader").show();
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
											parent.$("#loader").hide();
		    							},50);
									    
									});	
					    			
					    			// script master add
					    			v_grid.navGrid('#grid_scriptPager' ,
						    			// the buttons to appear on the toolbar of the grid
						    			{ edit: false, add: true, del: true, search: false, refresh: true, view: false, position: "left", cloneToTop: false  },
						    			// options for the Edit Dialog
						    			{  } ,
						    			// options for the Script Master Add Dialog
						    			{
						    				addCaption: "Add Script Master",
						    				modal:true,
						                    recreateForm: true,
						                    closeAfterAdd: true,
						                    reloadAfterSubmit: false,
											//template: template,
						                    errorTextFormat: function (data) {
						                        return 'Error: ' + data.responseText
						                    },
						                    onInitializeForm : function(formid){
						                        $(formid).attr('method','POST');
						                        $(formid).attr('action','');
						                        $(formid).attr('enctype','multipart/form-data');
						                        $(formid).css("font-size","14px");
						                        $(formid).find("#tr_CATEGORY").show();
						                    },
										    afterSubmit: function(response, postdata) 
										    { 
										    	var aaa = "a";
										    	var formdata = this.ownerDocument.FormPost;
						                    	var fd = new FormData(formdata);  	
						                    	var response1 = {};
						                    	$.ajax({
						                    		url: "/dashboard/genericSaveJson.html?sqlid=dashboard.corona.script_master.insert",
						                    		type: "POST",
						                    		data: fd, 
						                    		async: false,
						                    		cache: false,
						                    		contentType: false,
						                    		processData: false,
						                    		success:  function(data){
						                    			response1 = data;
						                    			if(response1.result == 'success'){
						                    				msg = "Add Success!";
							                    			$("#dialog-confirm").html(msg);
							                    			$("#dialog-confirm").dialog({
							                    			    resizable: false,
							                    			    modal: true,
							                    			    title: "Success",
							                    			    //height: 200,
							                    			    width: 200,
							                    			    dialogClass: 'no-close',
							                    			    closeOnEscape: false,
							                    			    buttons: [
						                    			              {
						                    			                text: "OK",
						                    			                click: function() {
						                    			                  $( this ).dialog( "close" );	
						                    			                  fn_search_script();										                    			                  
						                    			                }
						                    			              }
					                    			            ]
							                    			});
						                    			}
						                    			
						                    		}
						                    	});
						                    	
						                    	//return [success,message,new_id] ;
										    	if(response1.result == 'success'){
										    		//$(this).trigger('reloadGrid'); 
										    		return [true, response1.result, ''];
										    	}
										    	else
										    		return [false, response1.result + ":<br/>" + response1.message , ''];
										    		
										    }
						    			},
						    			// options for the Script Master Del Dialog 
						    			{
						    				
						    				afterSubmit: function(response, postdata) 
										    { 
										    	//$("#refresh_grid_script").hide();
										    	var grid = $(this);
										    	var paramObj = {
										    		delRows : []
										    	};
										    	$.each(postdata.id.split(","),function(i,rowid){
										    		var row = grid.getRowData(rowid);
										    		paramObj.delRows.push(row);
										    	});
										    	
									    		//  
									    		paramObj.loop_id = "delRows";
						                    	$.ajax({
						                    		url: "/dashboard/genericSaveJson.html",
						                    		type: "POST",
						                    		data: {
						                    			searchJson: JSON.stringify(paramObj),
						                    			sqlid: "dashboard.corona.script_master.delete"
						                    		}  , 
						                    		async: false,
						                    		success:  function(data){
						                    			response1 = data;
						                    			if(response1.result == 'success'){
						                    			
						                    				msg = "Del Success!";
							                    			$("#dialog-confirm").html(msg);
							                    			$("#dialog-confirm").dialog({
							                    			    resizable: false,
							                    			    modal: true,
							                    			    title: "Success",
							                    			    //height: 200,
							                    			    width: 200,
							                    			    dialogClass: 'no-close',
							                    			    closeOnEscape: false,
							                    			    buttons: [
						                    			              {
						                    			                text: "OK",
						                    			                click: function() {
						                    			                  $( this ).dialog( "close" );		
						                    			                  fn_search_script();
						                    			                }
						                    			              }
					                    			            ]
							                    			});
						                    			}
						                    			
						                    		}
						                    	});
						                    	
						                    	//return [success,message,new_id] ;
										    	if(response1.result == 'success'){
										    		//$(this).trigger('reloadGrid'); 
										    		return [true, response1.result, ''];
										    	}
										    	else
										    		return [false, response1.result + ":<br/>" + response1.message , ''];
										    		
										    }
						    			}
					    			);
					    			
					    			$('#grid_scriptPager .ui-paging-pager').hide();
					    		}
						    	
						    	
					    	}
							
						}
					

					
					]
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
		parent.$("#loader").show();
		setTimeout( function(){
			var rtnList = [];
			var paramObj = {
				sample : $("#to_sample").val(),
				firmware : $("#to_firmware").val(),
				sqlid: "dashboard.corona.manage.script.firmware.mapping"
			};
			$.ajax({
				type: "POST",
				url: "/dashboard/genericlListJson.html",
				//data: {searchJson: JSON.stringify(paramObj), sqlid: "dashboard.corona.manage.script.firmware.mapping"}, 
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
					parent.$("#loader").hide();
					
				}
			});		
			
		},50);
			
	}
	
	//target search condition change
	function fn_search_script(){
		parent.$("#loader").show();
		
		setTimeout( function(){
			$("#contentMain").html("");
			fn_makeHtml('contentMain',schemaContent);
			parent.$("#loader").hide();
			
			
			
//			var rtnList = [];
//			var paramObj = {
//				sample : $("#category").val(),
//				firmware : $("#testItem").val(),
//				sqlid: "dashboard.corona.manage.script.search"
//			};
//			$.ajax({
//				type: "POST",
//				url: "/dashboard/genericlListJson.html?sqlid=dashboard.corona.manage.script.search",
//				//data: {searchJson: JSON.stringify(paramObj), sqlid: "dashboard.corona.manage.script.firmware.mapping"}, 
//				data: $("#form").serialize(), 
//				//data: paramObj,
//				async: false,
//				success:  function(response){
//					rtnList  = response.dataList;
//					//return rtnList;
//					var theGrid = $("#grid_script").jqGrid();
//					theGrid.jqGrid('clearGridData');
//					theGrid.jqGrid('setGridParam', { data: rtnList});
//					theGrid.trigger('reloadGrid');	
//					parent.$("#loader").hide();
//					
//				}
//			});
					
			
		},50);
			
	}
	
	
	function fn_validation(){
		var gridScript = $("#grid_script").jqGrid();
    	var selIds = gridScript.jqGrid('getGridParam','selarrrow');
    	if(selIds.length == 0){
			alert("select more than one item!");
			return false;
		}else{
			return true;
		}
	}
	
	</script>
	<script  id="script_main">
	
	
	$(function () {
		parent.$("#loader").show();
		setTimeout( function(){
			fn_makeHtml('searchCondition',schemaSearch);
			fn_makeHtml('contentMain',schemaContent);
			
			$( window ).resize(function() {
				//console.log("aaaaa");
			});
			parent.$("#loader").hide();
		},50);
		//fn_search_firmware();
		parent.$("body").css("overflow","");
		parent.$("body .box_gray").css("height","1500px");
		$( window ).resize(function() {
			parent.$("body .box_gray").css("height","1500px");
		});
		
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
	    	//if(this.state.editable == true)
	    	//	this.setState({mode: "edit"});
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
						</div>
					);
	    		}else {
	    			return (
			    		<div>
							<input style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value}></input>
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
