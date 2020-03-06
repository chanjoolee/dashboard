<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<link rel="stylesheet" type="text/css" href="./css/pms/style_master_pop.css" />
		<%-- 1. jquery --%>
		<!-- <script src="js/jquery/jquery-1.11.2.js"></script> -->
		<script type="text/javascript" src="./js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
		<script src="./js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
		<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
		<!-- <script src="js/jquery.csv-0.71.js"></script> -->
		<script src="./js/jquery/jquery.form.js"></script>
		
		<%-- jqgrid --%>
		<!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
		<script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
		<script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js?version=2018.02.23"></script>    
		
		<!--  Context Menu -->
		<!-- grid Context -->
		<!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/plugins/jquery.contextmenu.js"></script>     -->
		<!-- Jquery Context Menu-->
		<!-- Web -->
		<!-- <link rel="stylesheet" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.css" type="text/css" /> -->
		<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.contextMenu.min.js"></script> -->
		<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-contextmenu/2.7.1/jquery.ui.position.js"></script> -->
		<!-- local -->
		<link rel="stylesheet" media="screen" href="js/jQuery-contextMenu-master/dist/jquery.contextMenu.min.css" type="text/css" />
		<script src="./js/jQuery-contextMenu-master/dist/jquery.contextMenu.min.js"></script>
		<script src="./js/jQuery-contextMenu-master/dist/jquery.ui.position.js"></script>


		
		<!-- <link rel="stylesheet" href="/dashboard/js/maxcdn/bootstrap/3.3.6/css/bootstrap.min.css"> -->
		<!-- <script src="/dashboard/js/maxcdn/bootstrap/3.3.6/js/bootstrap.min.js"></script> -->
		<link rel="stylesheet" href="./js/maxcdn/bootstrap/3.3.6/css/bootstrap.min.css">
		<script src="./js/maxcdn/bootstrap/3.3.6/js/bootstrap.min.js"></script>
		
		<script src="./js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
		
		<%-- http://swebdeveloper.com/apps/forms-plus-css/popup-form-comment.html --%>
		<link rel="stylesheet" href="./css/bootstrap/font-awesome.min.css">
		<link rel="stylesheet" href="./css/bootstrap/modern-forms-plus.css">
		<link rel="stylesheet" href="./css/bootstrap/purple.css">
		<link rel="stylesheet" href="./css/bootstrap/cadetBlue.css">
		<link rel="stylesheet" href="./css/bootstrap/orange.css">
		<link rel="stylesheet" href="./css/bootstrap/extra1color3.css">
		<link rel="stylesheet" href="./css/bootstrap/extra1color4.css">
		<link rel="stylesheet" href="./css/bootstrap/extra2color3.css">
		<link rel="stylesheet" href="./css/bootstrap/extra2color3.css">
		<link rel="stylesheet" href="./css/bootstrap/steelBlue.css">
		
		
	
		<!--  <link rel="stylesheet" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid.css" type="text/css" /> --> 
		<link rel="stylesheet" media="screen" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap.css" type="text/css" />
		<!-- <link rel="stylesheet" media="screen"  href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap-ui.css" type="text/css" /> -->
		
		
		
		<%-- 2. high charts --%>
		<!--<script src="js/Highcharts-5.0.7/code/highcharts.src.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/highcharts-more.src.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/modules/drilldown.src.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/modules/no-data-to-display.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/modules/exporting.src.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/modules/offline-exporting.src.js"></script> -->
		
		<script src="./js/Highstock-5.0.9/code/highstock.src.js"></script>
		<script src="./js/Highstock-5.0.9/code/modules/heatmap.src.js"></script>
		<script src="./js/Highstock-5.0.9/code/highcharts-more.src.js"></script>
		<script src="./js/Highstock-5.0.9/code/modules/drilldown.src.js"></script>
		<script src="./js/Highstock-5.0.9/code/modules/no-data-to-display.js"></script>
		<script src="./js/Highstock-5.0.9/code/modules/exporting.src.js"></script>
		<script src="./js/Highstock-5.0.9/code/modules/offline-exporting.src.js"></script>
		
		<%-- x축 그룹라벨 --%>
		<!-- <script src="js/highcharts/grouped-categories.js"></script> -->
		<!-- <script src="http://blacklabel.github.io/grouped_categories/grouped-categories.js"></script> -->
		
		<%-- 3. Additional files for the Highslide popup effect --%>
		<!-- <script type="text/javascript" src="./js/highslide/highslide-full.js"></script> -->
		<!-- <script type="text/javascript" src="./js/highslide/highslide.config.js" charset="utf-8"></script> -->
		<!-- <link rel="stylesheet" type="text/css" href="./js/highslide/highslide.css" /> -->

		<%-- 4. local common --%>
		<script src="./js/dashboard.toolbox.js?version=0"></script>
		
		<%-- 5. local --%>		
		<!-- <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
		<!-- <link rel="stylesheet" type="text/css" href="http://www.trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" /> -->
		
		<%-- multi select --%>
		<script src="./js/jquery-multiselect/jquery.multiselect.js"></script>
		<script src="./js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
		<link rel="stylesheet" type="text/css" href="./js/jquery-multiselect/jquery.multiselect.css" />
		<link rel="stylesheet" type="text/css" href="./js/jquery-multiselect/jquery.multiselect.filter.css" />
		<!-- <link rel="stylesheet" type="text/css" href="/nspim/css/jquery-ui.css" /> -->
		<!-- <script src="./js/jmespath.js-master/jmespath.js?version=1"></script> -->
		
		
		<%-- File Saver --%>
		<!-- <script type="text/javascript" src="./js/FileSaver.js/FileSaver.js" charset="utf-8"></script> -->
		<!-- <script type="text/javascript" src="./js/jquery-zclip-master/jquery.zclip.js"></script> -->
		
		<script type="text/javascript" src="./js/alasql-develop/dist/alasql.js"></script>
		<script src="./js/jointjs/lodash.4.17.10.js"></script>
		
		<!-- JS Tree -->
		<script type="text/javascript" src="./js/jstree/3.3.8/dist/jstree.min.js"></script>
		<link rel="stylesheet" type="text/css" href="./js/jstree/3.3.8/dist/themes/default/style.min.css" />

		<%-- recat --%>
		<!--<script src="https://facebook.github.io/react/js/jsfiddle-integration-babel.js"></script>-->
		<script  src="./js/react-0.14.3/build/react.js"></script>
		<script  src="./js/react-0.14.3/build/react-dom.js"></script>
		<script  src="./js/react-0.14.3/build/react-with-addons.js"></script>
		<script  src="./js/react-0.14.3/browser.js" ></script>

		<!------- datetimepicker -------->
		<script src="./js/datetimepicker-master/build/jquery.datetimepicker.full.min.js"></script>
		<link rel="stylesheet" href="./js/datetimepicker-master/jquery.datetimepicker.css"> 
		
		<%-- jqueryMohthPicker --%>
		<!-- <link rel="https://rawgit.com/KidSysco/jquery-ui-month-picker/v3.0.0/demo/MonthPicker.min.css" />
		<script type="text/javascript" src="https://rawgit.com/digitalBush/jquery.maskedinput/1.4.1/dist/jquery.maskedinput.min.js"></script>
		<script type="text/javascript" src="https://rawgit.com/KidSysco/jquery-ui-month-picker/v3.0.0/demo/MonthPicker.min.js"></script> -->

		<!-- xml to js -->
		<script type="text/javascript" src="/dashboard/js/convertjson/x2js.js"></script>

		<!-- fileconvert -->
		<script type="text/javascript" src="./js/bpmn/python.js"></script>
		<script type="text/javascript" src="./js/bpmn/common.js"></script>
		<script type="text/javascript" src="./js/bpmn/class_common.js"></script>
		<script type="text/javascript" src="./js/bpmn/class_python.js"></script>
		<script type="text/javascript" src="./js/bpmn/class_python_txt.js"></script>
		<script type="text/javascript" src="./js/bpmn/java_jsp/class_javaJsp.js"></script>
		<script type="text/javascript" src="./js/bpmn/java_jsp/class_sql.js"></script>
		<script type="text/javascript" src="./js/bpmn/java_jsp/allFromJpa.toolbox.js"></script>

		<!-- jszip -->
		<script type="text/javascript" src="./js/Stuk-jszip-3109282/dist/jszip.js"></script>
				
		<!-- PMS -->
		<link rel="stylesheet" type="text/css" href="./css/pms/common.css" />
		<link rel="stylesheet" type="text/css" href="./css/pms/new.css" />
		<link rel="stylesheet" type="text/css" href="./css/pms/board.css" />
		<!-- <script src="/common/js/module.js"></script> -->
		<script type="text/javascript" src="/dashboard/js/FileSaver.js/FileSaver.js" charset="utf-8"></script>

		<style type="text/css" title="main">
	
		html, body,form {
	        /* height: 100%; */
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        /* overflow-y: auto; */
	       /*  overflow-x: hidden; */
	       /*overflow: hidden;*/
	        /* font-size:11px; */
	      }
		
		/********** PMS Button Start **********/
		.srch_box2{
			border: 0 ;
			padding: unset;
			background: unset;
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

		.content_container {
			margin-left: 20px;
			margin-right: 20px;
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
			
			padding: <c:choose><c:when test="${empty param.is_pop_select}"> 5px;  </c:when><c:otherwise> 4px;</c:otherwise></c:choose>
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
		
		

		th.ui-th-column div{
	        white-space:normal !important;
	        height:auto !important;
	        padding:2px;
	    }
	    
		input[type="text"].form-control, input[type="password"].form-control{
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
		
		/* jqGrid에서 dialog가 뒤로 숨는 문제 */
		.ui-dialog { z-index: 1000 !important ;}
		div button.ui-button.ui-dialog-titlebar-close {
			display: none;
		}


		/* .contextMenu-parent:before{
			content: " P ";
			color: yellow;
			background-color: red;
			font-weight: bold;
			border-radius: 50%;
			
		}
		
		.contextMenu-child:before{
			content: " C ";
			color: yellow ;
			background-color: blue;
			font-weight: bold;
			border-radius: 50%;
			
		}
		.contextMenu-all:before{
			content: " A " ;
			color: white;
			background-color: black;
			font-weight: bold;
			border-radius: 50%;
			
		} */
		
		/* .contextMenu-parent{
			color: #337ab7;			
			font-weight: bold;
		}
		
		.contextMenu-child{
			color: #337ab7;			
			font-weight: bold;			
		}
		.contextMenu-all{
			color: #337ab7;			
			font-weight: bold;			
		} */

		.contextMenu{
			color: #337ab7;			
			font-weight: bold;
		}
		/* *********** Bootstrap Custom Start************/
		/***  jqgrid Header   ***/
		.ui-jqgrid-hdiv th {
			text-align: center;
		}
		
		.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {
    	    color: #000;
			background-color: #f5f5f5;
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
		.ui-jqgrid .ui-jqgrid-bdiv .table>tbody>tr>td.active {
			background-color: unset;
		}

		.ui-jqgrid {
			border-top: 2px solid #fc5d57;
		} 

		.ui-jqgrid-view  .ui-jqgrid-bdiv td.glyphicon {
			top : 0px;
			display: table-cell ;
		}

		/* *********** Bootstrap Custom End************/
		.modal-content.ui-resizable {
			overflow: scroll;
		}

		.required:after {
			content:"*";color:red;
		}

		div[type=HorizontalLayout] {
			min-height:  22px;
		}
		


	</style>
		