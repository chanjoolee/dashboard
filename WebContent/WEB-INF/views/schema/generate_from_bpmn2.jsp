<!DOCTYPE html>
<html lang="en">
<head>
  	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Generate Source By BPMN2</title>
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
		<!-- <script type="text/javascript" src="js/highslide/highslide-full.js"></script>
		<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script> -->
		
		<%-- 4. local common --%>
		<script src="js/dashboard.js?version=2017.10.31.01"></script>
		
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

		<!-- xml to js -->
		<script type="text/javascript" src="/dashboard/js/convertjson/x2js.js"></script>
	
  
  	<style type="text/css" title="main">
	
		html, body,form {
	        /* height: 100%; */
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        /* overflow-y: auto; */
	       /*  overflow-x: hidden; */
	       /*overflow: hidden;*/
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
	</style>


  	<script type="text/javascript" title="schemaSearchCondition">
		var schemaSearch = {
				containerId:'searchCondition',
				type:'Vertical',
				label:'',
				
				elements:[
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
												id: 'schemaUrlHead',
												name: 'schemaUrlHead',
												label:'',
												text:'BPMN SchemaUrl',
												width: '120px',
												containerCss :[
													{code:'padding-right',value:'10px'}
												]
												
											},
											{
												type:'input',
												id: 'schemaUrl',
												name: 'schemaUrl',
												label:'SchemaUrl',
												text:' ',
												width: '700px',
												controlCss :[
													{code:'width',value:'100%'}
												]
												
											}
											
											
										]
									}
									
								]
							},
							// 검색버튼
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
												id: 'btnCreate',
												name: 'btnCreate',
												label:'Create Source From BPMN2',
												//width: '50px',
												cls: 'btn_txt btn_type_e btn_color_a',
												containerCss:[
													{code: 'margin-right', value:'3px'}
												],
												events:{
													click : function(){
														fn_load_schema();
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
		

		var enityStr = "";
		var enity = {};
		var workFlowStr = "";
		var workFlow = {};

		var config = {};
		config.skipEmptyTextNodesForObj = true;
		//config.arrayAccessForm = "property";
		config.stripWhitespaces = true;
		config.enableToStringFunc = false;
		var x2js = new X2JS(config);
		var genmyModelxmi = "";
		var schema_bpmn = {};
		var schema_jpa = {};
		var v_files = {};
		var v_src = {};
  	
  	</script>
	<script type="text/javascript">
		$(function () {
			$("#btn_file_open").change(function(){
				var file = this.files[0];
				
				enityStr = "";
				var reader = new FileReader();
				reader.onload = function(progressEvent){
				  // Entire file
				  //console.log(this.result);

				  // By lines
				  var lines = this.result.split('\n');
				  for(var line = 0; line < lines.length; line++){
				    //console.log(lines[line]);
				    enityStr += lines[line];
				  }
				  enity = JSON.parse(enityStr);
				  fn_create_workflow();
				};
				reader.readAsText(file);
			});
			
			fn_makeHtml('searchCondition',schemaSearch);
			$("#schemaUrl").val("https://api.genmymodel.com/projects/_OlwJkAbzEeipbtix-oa2Dg/xmi");
			$("#loader").hide();
		});
		
		
		function fn_file_open(){
			$("input#btn_file_open").trigger("click");
		}
		function fn_create_workflow(){
			
			// select workflow file.json
			// generate webpages in files ?
			// ... 
			// or diynamic load webpage
			// ... param2: wokflow Object
			// ... param1: workflow_id
			// ... param3: type
			
			
			
			
			
			// 01. table list
			// 02. find connections
			// 02.1. parents
			// 02.2. childs
			// 03. make search condition
			// 04. make grid
			
			
			
			
			
			// var filename= 'entity_'+ $("#owner").val();
			// var blob = new Blob([JSON.stringify(schema)], {type: "text/plain;charset=utf-8"});
			// saveAs(blob, filename+".json");


			// var newWin1 = window.open("", "MS_WordReport", "width=1200,height=800, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
			
			// var oFrm = document.getElementById("formReport");
			// oFrm.searchJson.value = JSON.stringify(schema);
			
			// oFrm.action =  '/dashboard/performanceReportJson.html';
			// oFrm.method = "post";
			// oFrm.target = 'MS_WordReport';
		    // oFrm.submit();		    
		    // newWin1.focus();	
		}

		function fn_load_schema(){
			var url = $("#schemaUrl").val();
			$.ajax({
				url: url ,
				// data: {sqlid: "codegen.tables",owner: $("#owner").val()}, 
				async: false,
				success:  function(doc,result,response){
					// console.log(response.responseText);
					genmyModelxmi = response.responseText;
					schema_bpmn =  x2js.xml_str2json(genmyModelxmi);
					fn_create_source();
				}
			});
		}


		function fn_create_source(){
			// find process
			var processes = _.filter(schema_bpmn.Definitions.rootElements,{"_xsi:type": "bpmn2:Process"});			
			$.each(processes,function(i,process){
				fn_start(process);
			});
			
			fn_source();
		}

		// return start in process flowElements 
		function fn_start(process){
			var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
			var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
			var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
			if(process.depth != undefined)
				target_task.depth = process.depth + 1;
			
			if(process["file_name"] != undefined){
				var content = {						
					"task": target_task,
					"depth": target_task.depth,
					// "detail": detail,
					"is_start": true
				};
				// v_files[process["file_name"]].contents.push(content);
			}
			target_task.is_start = true;
			fn_task(process,target_task);
		}

		function fn_start_detail(process){
			var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
			var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
			var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
			if(process.depth != undefined)
				target_task.depth = process.depth + 1;
			
			if(process["file_name"] != undefined){
				var content = {						
					"task": target_task,
					"depth": target_task.depth,
					// "detail": detail,
					"is_start": true
				};
				v_files[process["file_name"]].contents.push(content);
			}
			fn_task_detail(process,target_task);
		}
		
		function fn_task(process, task){
			task.parent = process;
			// subprocess . file create
			if( _.isArray(task.eAnnotations.details) 
				&& _.find(task.eAnnotations.details,{"_key":"file_type"}) != undefined
				&& process["file_name"] == undefined
			){
					var file_name = _.find(task.eAnnotations.details,{"_key":"file_name"})._value;
					var file_path = _.find(task.eAnnotations.details,{"_key":"file_path"})._value;
					var file_path_type = _.find(task.eAnnotations.details,{"_key":"file_path_type"})._value;
					task.file_name = file_name;

					v_files[file_name] = {};
					v_files[file_name].process = task;
					v_files[file_name].file_path = file_path;
					v_files[file_name].file_path_type = file_path_type;
					v_files[file_name].contents = [];
					task.depth = -1;
			}
			
			// detail properties
			if( _.isArray(task.eAnnotations.details) 
				&& _.find(task.eAnnotations.details,{"_key":"file_type"}) == undefined
				&& process["file_name"] != undefined
			){

				var content = {						
					task: task ,
					"depth": task.depth 
				};
				v_files[process["file_name"]].contents.push(content);
			}

			
			// file name
			if(process["file_name"] != undefined){
				task.file_name = process["file_name"];
			} 			
			
			// subProces			
			if(task.flowElements != undefined){
				// task.parent = process;
				fn_start(task);
			}

			
			
			// end Process
			if(task["_outgoing"] == undefined){
				return;
			}
				

			// --- next task ------- //
			// sequence
			var sequence = _.find(process.flowElements,{"_xmi:id": task["_outgoing"]});
			if(process.depth != undefined){
				sequence.parent = process;
				sequence.depth = process.depth + 1;
			}
				
			fn_process_sequence(process, task, sequence);

			var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
			if(process.depth != undefined)
				target_task.depth = process.depth + 1;
			fn_task(process,target_task);
		}

		function fn_task_detail(process, task){
			task.parent = process;
			// subprocess . file create
			if( _.isArray(task.eAnnotations.details) 
				&& _.find(task.eAnnotations.details,{"_key":"file_type"}) != undefined
				&& process["file_name"] == undefined
			){

					var file_name = _.find(task.eAnnotations.details,{"_key":"file_name"})._value;
					var file_path = _.find(task.eAnnotations.details,{"_key":"file_path"})._value;
					var file_path_type = _.find(task.eAnnotations.details,{"_key":"file_path_type"})._value;
					task.file_name = file_name;
					v_files[file_name] = {};
					v_files[file_name].file_path = file_path;
					v_files[file_name].file_path_type = file_path_type;
					v_files[file_name].contents = [];
					task.depth = -1;
					

			}
			
			// detail properties
			if( _.isArray(task.eAnnotations.details) 
				&& _.find(task.eAnnotations.details,{"_key":"file_type"}) == undefined
				&& process["file_name"] != undefined
			){

				$.each(task.eAnnotations.details,function(i,detail){
					if ( detail["_key"] == "uuid")
						return true;
					
					var content = {						
						task: task,
						"depth": task.depth,
						"detail": detail						
						//"variable": detail["_key"],
						//"value": detail["_value"]
					};
					content.variable = detail["_key"] + fn_depth(task,detail);
					content.value = fn_keyward_variable(process, detail);

					v_files[process["file_name"]].contents.push(content);
				});

			}

			
			// file name
			if(process["file_name"] != undefined){
				task.file_name = process["file_name"];
			} 
			
			// loop start
			if(_.isArray(task.eAnnotations.details)
				&& _.find(task.eAnnotations.details,{"_key":"loop_condition"}) != undefined
			){
				var content = {
					task: task,
					"depth": task.depth,
					is_loop: true,
					loop_start : true,
					loop_end : false,
					"variable": "v_loop" + fn_depth(task),
					"value": _.find(task.eAnnotations.details,{"_key":"loop_condition"})._value
				};
				v_files[process["file_name"]].contents.push(content);
			}
			// subProces			
			if(task.flowElements != undefined){
				// task.parent = process;
				fn_start_detail(task);
			}

			// data assosiation  datastore target
			if(task.dataOutputAssociations != undefined && task.dataOutputAssociations._targetRef != undefined){
				var target_refer = _.find(process.flowElements,{"_xmi:id": task.dataOutputAssociations._targetRef });
				if (target_refer._dataStoreRef != undefined){
					var data_store = _.find(schema_bpmn.Definitions.rootElements,{"_xmi:id": target_refer._dataStoreRef});
					var data_def = _.find(schema_bpmn.Definitions.rootElements,{"_xmi:id": data_store._itemSubjectRef});
					var content = {
						task: task,
						"depth": task.depth
					};
					content.data_store = data_store;
					content.data_def = data_def;

					// get jpa enity
					var match = data_def.structureRef._href.match(/genmymodel:\/\/(?<project_id>[\w]+)#(\/\/@)(?<tag_name>[\w]+)\.(?<index>[\d]+)/);
					//var url_data = 'https://api.genmymodel.com/projects/_yDLSMDfMEeiQp6eXyhUzBA/xmi';
					var url_data = 'https://api.genmymodel.com/projects/' + match.groups.project_id+ '/xmi';
					var schema_jpa1 = {};
					$.ajax({
						url: url_data  ,
						// data: {sqlid: "codegen.tables",owner: $("#owner").val()},
						async: false,
						success:  function(doc,result,response){
							// console.log(response.responseText);
							genmyModelxmi = response.responseText;
							schema_jpa1 =  x2js.xml_str2json(genmyModelxmi);	
							content.schema_jpa = schema_jpa1;
							content.schema_jpa_enity = schema_jpa1.Model.ownedEntities[match.groups.index];
						}
					});					
					v_files[process["file_name"]].contents.push(content);
				}
			}
		
			// loop end
			if(_.isArray(task.eAnnotations.details)
				&& _.find(task.eAnnotations.details,{"_key":"loop_condition"}) != undefined
			){
				var content = {
					task: task,
					"depth": task.depth,
					is_loop: true,
					loop_start : false,
					loop_end : true,
					"variable": "v_loop" + fn_depth(task),
					"value": _.find(task.eAnnotations.details,{"_key":"loop_condition"})._value
				};
				v_files[process["file_name"]].contents.push(content);
			}
			
			// end Process
			if(task["_outgoing"] == undefined){
				if (process["file_name"] != undefined ){
					var content = {						
						"task": task,
						"depth": task.depth,
						// "detail": detail,
						"is_end": true
					};
					v_files[process["file_name"]].contents.push(content);
				}				
				return;
			}
				

			// --- next task ------- //
			// sequence
			var sequence = _.find(process.flowElements,{"_xmi:id": task["_outgoing"]});
			if(process.depth != undefined)
				sequence.depth = process.depth + 1;
			fn_process_sequence_detail(process, task, sequence);

			var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
			if(process.depth != undefined)
				target_task.depth = process.depth + 1;
			fn_task_detail(process,target_task);
		}

		function fn_process_sequence(process,task,sequence){
			
			// detail properties
			if( _.isArray(sequence.eAnnotations.details) 
				&& _.find(sequence.eAnnotations.details,{"_key":"file_type"}) == undefined
				&& process["file_name"] != undefined
			){
				var content = {						
					"gateway": task,
					"task": sequence 
				};
				v_files[process["file_name"]].contents.push(content);

				if(task["_xsi:type"] == "bpmn2:ExclusiveGateway"
					&& _.find(sequence.eAnnotations.details,{"_key":"check_type"}) != undefined
					&& _.find(sequence.eAnnotations.details,{"_key":"check_type"})["_value"] == "file_exists"
					&& _.find(sequence.eAnnotations.details,{"_key":"compare"}) != undefined
					&& _.find(sequence.eAnnotations.details,{"_key":"compare"})["_value"] == "equal"
				){
					
				}

			}
			
		}
		
		function fn_process_sequence_detail(process,task,sequence){
			// detail properties
			if( _.isArray(sequence.eAnnotations.details) 
				&& _.find(sequence.eAnnotations.details,{"_key":"file_type"}) == undefined
				&& process["file_name"] != undefined
			){

				$.each(sequence.eAnnotations.details,function(i,detail){
					if ( detail["_key"] == "uuid")
						return true;
					
					var content = {											
						"task": sequence,
						"is_sequence": true,
						"depth": sequence.depth,
						"detail": detail						
					};
					content.variable = detail["_key"] + fn_depth(sequence,detail);
					content.value = fn_keyward_variable(process, detail);

					v_files[process["file_name"]].contents.push(content);
				});
				
				if(task["_xsi:type"] == "bpmn2:ExclusiveGateway"
					&& _.find(sequence.eAnnotations.details,{"_key":"check_type"}) != undefined
					&& _.find(sequence.eAnnotations.details,{"_key":"check_type"})["_value"] == "file_exists"
					&& _.find(sequence.eAnnotations.details,{"_key":"compare"}) != undefined
					&& _.find(sequence.eAnnotations.details,{"_key":"compare"})["_value"] == "equal"
				){
					
				}

			}
			
		}
		
		function fn_create_file(){

		}

		function fn_create_file_python(){

		}

		function fn_keyward_variable(process, detail){
			
			
			
			rtn = detail._value;
			


			if(detail._key == "path"){
				// defined process 
				if( _.isArray(process.eAnnotations.details)
					&& _.find(process.eAnnotations.details,{"_key":"path"}) != undefined
				){
					rtn = "";
					rtn = _.find(process.eAnnotations.details,{"_key":"path"})._key + fn_depth(process,detail);					
					// rtn += "+\"/\" + ";
					// check parent is loop
					if( true
						// && process.parent != undefined 
						// && _.isArray(process.parent.eAnnotations.details)
						// && _.find(process.parent.eAnnotations.details,{"_key":"loop_condition"}) != undefined){
						&& _.find(process.eAnnotations.details,{"_key":"loop_condition"}) != undefined){
						 rtn += " + \"/\" + " + "v_loop" + fn_depth(process) ;
					}
					rtn += " + \"/\" +  " + detail._value  ;
					return rtn;
				}
				// find parent
				else if( process.parent != undefined){
					return fn_keyward_variable(process.parent,detail);
				}
				
			}

			// v_loop
			var match = rtn.match(/(?<v_loop>v_loop)/);
			if(match != null){
				
			}

			return rtn;
		}

		function fn_depth(task,detail){
			if(detail != undefined){
				if(detail._key == "path"){
					if (task.depth == undefined)
						return "";
					else if(task.depth != undefined && task.depth == 0){
						return "";
					}else
						return "_" + task.depth;
				}else {
					return "";
				}
			}else{
				if (task.depth == undefined)
					return "";
				else if(task.depth != undefined && task.depth == 0){
					return "";
				}else
					return "_" + task.depth;
			}
			
			
		}

		function fn_source(){
			$.each(v_files,function(k,v){
				if( _.isArray(v.process.eAnnotations.details) 
					&& _.find(v.process.eAnnotations.details,{"_key":"file_type"})._value == "python"){
					fn_source_python(k,v);
				}
			});
		}

		function fn_source_python(file_name){
			var sources = [];			
			v_files[file_name]['sources'] = sources;
			var top_resource = v_files[file_name];

			var dfn_indent = function(task){
				var process_tree = [];
				var fn_process_tree = function(_task){
					if(_task.depth == -1)
						return;
					else{
						process_tree.unshift(_task);
						fn_process_tree(_task.parent);
					}
				};				
				fn_process_tree(task);
				
				var indent = 0;
				for( var i=1; i < process_tree.length ; i++){
					var _task = process_tree[i];
					var _parent = process_tree[i-1]
					if(i==0)
						continue;
					if( _.isArray(_parent.eAnnotations.details) 
						&& _.find(_parent.eAnnotations.details,{"_key":"loop_condition"}) != undefined
					){
						indent++;
					}
				}

				return indent;
			};
			var dfn_indent_write = function(indent){
				var src = "";
				for(var j = 0; j < indent ; j++ )
					src += "\t";
				return src ;
			}
			
			var dfn_split_string = function(task){
				if( _.isArray(task.eAnnotations.details)){
					$.each(task.eAnnotations.details,function(i,detail){
						if ( detail["_key"] == "uuid")
							return true;

						if ( detail["_key"] == "is_string_split"
							&& detail["_value"] == "true"
						){
							var indent = dfn_indent(task);
							//
							// var src =  dfn_indent_write(indent);
							// src += "string_split_data = {}"
							// sources.push(src);
							//
							// var src =  dfn_indent_write(indent);
							// src += "if is_string_split == True:"
							// sources.push(src);
							//
							src = dfn_indent_write(indent);
							src +="string_split_data = {\"target\": string_split_target ,  \"data\": dict(zip( string_split_info , string_split_target.split(string_split_char) ))}";
							sources.push(src);

						}
					});

					
				}
				
			}

			var dfn_detail_variable = function(task){
				if( _.isArray(task.eAnnotations.details)){
					$.each(task.eAnnotations.details,function(i,detail){
						if ( detail["_key"] == "uuid")
							return true;
						
						src = "";
						// indent
						var indent = dfn_indent(task);
						src += dfn_indent_write(indent);
						// for(var j = 0; j < indent ; j++ )
						// 	src += "\t";
						
						variable = detail["_key"] + fn_depth(task,detail);
						value = fn_keyward_variable(task.parent, detail);
						if( value.match(/true/i) != null)
							value = "True";
						if( value.match(/false/i) != null)
							value = "False";

						src += variable + " = " + value;
						sources.push(src);
						// dfn_split_string(task,detail);

						
					});
				}
			};
			
			var dfn_loop = function(task){
				if( _.isArray(task.eAnnotations.details)
					&& _.find(task.eAnnotations.details,{"_key":"loop_condition"}) != undefined
				){
					src = "";
					// indent
					var indent = dfn_indent(task);
					for(var j = 0; j < indent ; j++ )
						src += "\t";
					
					variable = "v_loop" + fn_depth(task);
					value = _.find(task.eAnnotations.details,{"_key":"loop_condition"})._value;
					src += "for " + variable + " in " + value + ":";
					sources.push(src);
				}
			};

			var dfn_comment = function(task){
				src = "";
				// indent
				var indent = dfn_indent(task);
				for(var j = 0; j < indent ; j++ )
					src += "\t";
				src += "# " + task["_name"];
				sources.push(src);
			};

			var dfn_data_output = function(task){
				var process = task.parent;
				// data assosiation  datastore target
				var v_dataOutputAssociations = null;
				var indent = dfn_indent(task);
				if(_.isArray(task.dataOutputAssociations)){
					v_dataOutputAssociations = _.find(task.dataOutputAssociations,function(o){
						if(o._targetRef != undefined){ 
							return true;
						}else{
							return false;
						}

					});
				}
				else 
					v_dataOutputAssociations =  task.dataOutputAssociations;

				if(v_dataOutputAssociations != null && v_dataOutputAssociations != undefined && v_dataOutputAssociations._targetRef != undefined){
					var target_refer = _.find(process.flowElements,{"_xmi:id": v_dataOutputAssociations._targetRef });
					if (target_refer._dataStoreRef != undefined){
						var data_store = _.find(schema_bpmn.Definitions.rootElements,{"_xmi:id": target_refer._dataStoreRef});
						var data_def = _.find(schema_bpmn.Definitions.rootElements,{"_xmi:id": data_store._itemSubjectRef});

						// get jpa enity
						var match = data_def.structureRef._href.match(/genmymodel:\/\/(?<project_id>[\w]+)#(\/\/@)(?<tag_name>[\w]+)\.(?<index>[\d]+)/);
						//var url_data = 'https://api.genmymodel.com/projects/_yDLSMDfMEeiQp6eXyhUzBA/xmi';
						var url_data = 'https://api.genmymodel.com/projects/' + match.groups.project_id+ '/xmi';
						var schema_jpa1 = {};
						schema_jpa_enity = {};
						$.ajax({
							url: url_data  ,
							// data: {sqlid: "codegen.tables",owner: $("#owner").val()},
							async: false,
							success:  function(doc,result,response){
								// console.log(response.responseText);
								genmyModelxmi = response.responseText;
								schema_jpa1 =  x2js.xml_str2json(genmyModelxmi);	
								schema_jpa_enity = schema_jpa1.Model.ownedEntities[match.groups.index];
							}
						});	
						
						// // variable
						// target_refer.depth = task.depth;
						// target_refer.parent = task.parent;
						// dfn_detail_variable(target_refer);
						// db connection
						src = dfn_indent_write(indent);	src += "v_con = cx_Oracle.connect(con_str)"; sources.push(src);
						src = dfn_indent_write(indent);	src += "v_cur = v_con.cursor()"; sources.push(src);
						
						// query
						// // if delete 
						if( _.isArray(target_refer.eAnnotations.details) 
							&& _.find(target_refer.eAnnotations.details,{"_key":"keyword_delete","_value":"true"}) != null )
						{
							src = dfn_indent_write(indent) + "v_query = '''"; sources.push(src);
							src = dfn_indent_write(indent) + "\tdelete from " + schema_jpa_enity._name ; sources.push(src);
							src = dfn_indent_write(indent) + "\twhere 1=1" ; sources.push(src);
							// query key
							var bindings = [];
							$.each(schema_jpa_enity.properties,function(i,p){
								if(p.annotations == undefined)
									return true;

								var annotations = []
								if(_.isArray(p.annotations)){
									annotations = p.annotations;
								}else{
									annotations.push(p.annotations);
								}

								var isId = false;
								if( _.find(annotations,{"_xsi:type":"gmmjpa:Id"}) != null)
									isId = true;
								else{
									isId = true;
										
								}
								if(isId){
									src = dfn_indent_write(indent) + "\tand " +"" + p._name + " = :bind_" + _.camelCase(p._name); sources.push(src);
									src = dfn_indent_write(indent) + "'''"; sources.push(src);
									bindings.push({name: p._name, "bind_name":"bind_" + _.camelCase(p._name) ,"src": src});
								}

							});

							// query binding
							var basic_data = _.find(target_refer.eAnnotations.details,{"_key":"keyword_basic_data"});
							if( basic_data != null ){
								src = dfn_indent_write(indent) +  basic_data._key + " = " + basic_data._value; sources.push(src);
								src = dfn_indent_write(indent) + "v_binding = {}"; sources.push(src);
								$.each(bindings,function(i,binding){
									// if binding_data
									if( basic_data != null ){
										src = dfn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + basic_data._value + "['" + binding.name + "']" ; sources.push(src);
									}
									// specific binding data
									if( _.isArray(target_refer.eAnnotations.details)){
										$.each(target_refer.eAnnotations.details,function(i,detail){
											if ( detail["_key"] == "uuid")
												return true;
											
											var regex = new RegExp('^'+detail._key,'i')
											if(binding.name.match(regex) != null ){
												src = dfn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + detail._value ; sources.push(src);
											}

											
										});
									}
								});				
								
							}

						
							// excuete
							src = dfn_indent_write(indent) + "cur.execute(v_query ,v_binding)"; sources.push(src);
							// db connection end

							// // test code
							// var match = target_refer.documentation._text.match(/<code class="language-python">(?<content>[\w\s\(\)\."\=:\r\n]+)<\/code>/);
							// if(match != null){
							// 	var indent = dfn_indent(task);
							// 	var content = match.groups.content;
							// 	var codes = content.split('\n');
							// 	for(var i=0;i<codes.length;i++){
							// 		src = dfn_indent_write(indent);
							// 		src += codes[i];
							// 		sources.push(src);
							// 	}
							// }

						}
					
						// // insert query
						if(true){
							src = dfn_indent_write(indent) + "v_query = '''"; sources.push(src);
							src = dfn_indent_write(indent) + "\tinsert into  " + schema_jpa_enity._name ; sources.push(src);
							src = dfn_indent_write(indent) + "\t(" ; sources.push(src);
							// query columns
							var bindings = [];
							$.each(schema_jpa_enity.properties,function(i,p){
								src = dfn_indent_write(indent) + "\t\t" + p._name + " , " ; sources.push(src);
								bindings.push({name: p._name, "bind_name":"bind_" + _.camelCase(p._name) ,"src": src});
							});
							src = dfn_indent_write(indent) + "\t\tins_dt " ; sources.push(src);
							src = dfn_indent_write(indent) + "\t)" ; sources.push(src);
							// query values
							src = dfn_indent_write(indent) + "\tvalues(" ; sources.push(src);
							$.each(schema_jpa_enity.properties,function(i,p){
								src = dfn_indent_write(indent) + "\t\t:bind_" + _.camelCase(p._name) + " , " ; sources.push(src);
							});
							src = dfn_indent_write(indent) + "\t\tsysdate " ; sources.push(src);
							src = dfn_indent_write(indent) + "\t)" ; sources.push(src);
							src = dfn_indent_write(indent) + "'''"; sources.push(src);
							// query binding
							var basic_data = null;
							if(_.isArray(target_refer.eAnnotations.details)){
								basic_data = _.find(target_refer.eAnnotations.details,{"_key":"keyword_basic_data"});
							}
							if( basic_data != null ){
								src = dfn_indent_write(indent) +  basic_data._key + " = " + basic_data._value; sources.push(src);
								src = dfn_indent_write(indent) + "v_binding = {}"; sources.push(src);
								$.each(bindings,function(i,binding){
									// if binding_data
									if( basic_data != null ){
										src = dfn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + basic_data._value + "['" + binding.name + "']" ; sources.push(src);
									}
									// specific binding data
									if( _.isArray(target_refer.eAnnotations.details)){
										$.each(target_refer.eAnnotations.details,function(i,detail){
											if ( detail["_key"] == "uuid")
												return true;
											
											var regex = new RegExp('^'+detail._key,'i')
											if(binding.name.match(regex) != null ){
												src = dfn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + detail._value ; sources.push(src);
											}

											
										});
									}
								});				
							}
						}
						// excuete
						src = dfn_indent_write(indent) + "cur.execute(v_query ,v_binding)"; sources.push(src);

						// query commit
						src = dfn_indent_write(indent);	src += "con.commit()"; sources.push(src);
						// close 
						src = dfn_indent_write(indent);	src += "if cur:"; sources.push(src);
						src = dfn_indent_write(indent);	src += "\tcur.close()"; sources.push(src);
						src = dfn_indent_write(indent);	src += "if con:"; sources.push(src);
						src = dfn_indent_write(indent);	src += "\tcon.close()"; sources.push(src);

					}
				}
			}

			// // by content
			// $.each(top_resource.contents,function(i,content){
			// 	dfn_comment(content.task);
			// 	dfn_detail_variable(content.task);
			// 	dfn_split_string(content.task);
			// 	dfn_data_output(content.task);
			// 	dfn_loop(content.task);
				
				
			// });

			// by process
			var dfn_start = function(process){
				var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
				var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
				var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
				dfn_task(process,target_task);
			}
			var dfn_task = function(process,task){
				dfn_comment(task);
				dfn_detail_variable(task);
				dfn_split_string(task);
				dfn_loop(task);

				if(task.flowElements != undefined){
					// task.parent = process;
					dfn_start(task);
				}			

				dfn_data_output(task);

				// end Process
				if(task["_outgoing"] == undefined){
					return;
				}

				// --- next task ------- //
				// sequence
				var sequence = _.find(process.flowElements,{"_xmi:id": task["_outgoing"]});
				// dfn_process_sequence(process, task, sequence);

				var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
				dfn_task(process,target_task);
			}
			dfn_start(top_resource.process);

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
	<input type="file" id="btn_file_open" name="btn_file_open" style="display: none" />
	<div id="searchCondition"></div>
	<div id="contentMain" style="margin-top: 10px;width: 100%;"></div>

	<div id="loader"></div>
	<div id="dialog-confirm"></div>
</form>
<form name="formReport" id="formReport" class="">
	<input type="hidden" id="searchJson" name="searchJson" value=""/>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>