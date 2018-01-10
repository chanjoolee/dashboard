<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>Corona Emmc Detail Script</title>
	<!-- <link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css" /> -->
	
	
	<%-- 1. jquery --%>
    <!-- <script src="js/jquery/jquery-1.11.2.js"></script> -->
    <!-- <script src="js/jquery/jquery.form.js"></script> -->
    <!-- <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script> -->
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    
    <%-- 2. high charts --%>
    
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<!-- <script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script> -->
	
	<%-- jqgrid --%>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"> 
	<!-- <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script> -->
	<%-- datetimepicker --%>
	<script src="/dashboard/js/datetimepicker-master/build/jquery.datetimepicker.full.min.js"></script>
	<link rel="stylesheet" href="/dashboard/js/datetimepicker-master/jquery.datetimepicker.css"> 
	
	
	<%-- http://swebdeveloper.com/apps/forms-plus-css/popup-form-comment.html --%>
	<!--  <link rel="stylesheet" href="/dashboard/css/bootstrap/font-awesome.min.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/modern-forms-plus.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/purple.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/cadetBlue.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/orange.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color4.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/steelBlue.css"> -->
  
	<!--  <link rel="stylesheet" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid.css" type="text/css" /> --> 
	<link rel="stylesheet" media="screen" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap.css" type="text/css" />
	<!-- <link rel="stylesheet" media="screen"  href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap-ui.css" type="text/css" /> -->
	<%--// jqgrid --%>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<!-- <script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script> -->
	
	<%-- x축 그룹라벨 --%>
	<!-- <script src="js/highcharts/grouped-categories.js"></script> -->
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<!-- <script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script> -->
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.11.17.01"></script>
	
	<%-- 5. local --%>
	<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
	
	
	<%-- multi select --%>
	<!-- <script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" /> -->
	
	<!-- <link rel="stylesheet" type="text/css" href="/dashboard/css/stylesheet-image-based.css" /> -->
	
	<!-- <script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script> -->
	<link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css">
	
	<%-- recat --%>
   	<!--<script src="https://facebook.github.io/react/js/jsfiddle-integration-babel.js"></script>-->
   	
   	<script  src="/dashboard/js/react-0.14.3/build/react.js"></script>
   	<script  src="/dashboard/js/react-0.14.3/build/react-dom.js"></script>
   	<script  src="/dashboard/js/react-0.14.3/build/react-with-addons.js"></script>
   	<script  src="/dashboard/js/react-0.14.3/browser.js" ></script>
   	
	<style>
		html, body,form {
			padding: 0;
	        margin: 0;
	        font-size:11px;
	    }
	    
	    
		.wrap_a{width:100%; overflow:hidden}
		.wrap_b{width:100%; overflow:hidden}
		.wrap_b_1{width:49%; height:auto ;overflow:hidden; float:left; margin-top:30px}
		.wrap_b_2{width:49%; height:auto ;overflow:hidden; float:right; margin-top:30px}
		
		<%--.box_gray{background:#f5f6fa; border:1px solid #e1e2e6; padding:15px; text-align:center; margin-bottom:8px } --%>
		.dashboard_box{/* border:1px solid #e1e2e6;  */}
		
		iframe {
			   border: none;
			   frameborder:0;
			   
			   width: 100%;
			   height: 100%;
		}
		
		.radioDiv div{
			display:inline;
		}
		
		
		
		/***  jqgrid Header   ***/
		.ui-jqgrid-hdiv th {
			text-align: center;
		}
		
		.h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
		    font-weight: bold;
		    margin-bottom: 0px; */
		}
		
		
		
		.border_boxAll{
			border-color: #c0c0c0;
			border-style: solid;
			border-width: 1px;
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
		
		<%--  jqGrid에서 dialog가 뒤로 숨는 문제.--%>
		.ui-dialog { z-index: 1000 !important ;}
		
		/***  jqgrid Header   ***/
		.ui-jqgrid-hdiv th {
			text-align: center;
		}
		
		.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {    	    
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
		.ui-jqgrid .ui-jqgrid-htable th.ui-th-column div{
	        white-space:normal !important;
	        height:auto !important;
	        padding:2px;
	    }
		.ui-jqgrid .ui-jqgrid-htable th.ui-th-column {
	        vertical-align: top;
	    }
	    
	    .ui-jqgrid-hdiv .ui-jqgrid-htable .ui-search-toolbar input {
	    	height: 30px;
	    }
	    
	    .ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td {
	    	white-space: nowrap;
	    }
		
	</style>
	<style type="text/css" title="nspmstyle">
		
		
		.pop_window .pop_tit_wrap {
		    position: relative;
		    height: 50px;
		    padding: 0 15px 0 20px;
		    background-color: #2e3441;
		}
		
		.pop_window .pop_con_area {
		    padding: 5px 10px; 
		    overflow: auto;
		    background-color: #ffffff;
		}
		
		.pop_window .pop_tit {
		    font-size: 18px;
		    font-weight: bold;
		    color: #ffffff;
		    line-height: 1.33em;
		    display: inline-block;
		    vertical-align: middle;
		}
	
		.cont_tit{font-size:12px; display:block; color:#000; text-align:left; padding-bottom:12px; position:relative; background:url(/nspim/images/board/bullet.gif) no-repeat left 1px; padding-left:18px}
		.cont_tit {float:none}
		
		<%--  table style--%>
		.table_hori {
		    width: 100%;
		    table-layout: fixed;
		    border-collapse: collapse;
		    /* border-top: 1px solid #fc5d57; */
		    border-top: 1px solid #e1e2e6;
		    border-left: 1px solid #e1e2e6;
		    border-right: 1px solid #e1e2e6;
		}
		
		.table_hori th {
		    background: rgba(245,246,250,0.6);
		    color: #000;
		    /* background: #f5f6fa; */
		    height: 20px;
		    padding: 5px 10px;
		    overflow: hidden;
		    border: 1px solid #e1e2e6;
		    font-weight: normal;
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
		
		.txt_right {
		    text-align: right;
		}
		<%--//  table style--%>
		
		input[type="text"], input[type="password"] {
		    height: auto;
    		font-size: 14px;
    		line-height: 1.42857143;
		}
	
	</style>
<script title="schema">
// 	$.jgrid.defaults.width = 780;
// 	$.jgrid.defaults.responsive = true;
// 	$.jgrid.defaults.styleUI = 'Bootstrap';
	
	var testInformation = {};
	var testDisks = [];
	var testResults = [];
	var testFiles = [];
	//그리드 편집전 데이타
	var beforEditRow = {};
	var beforEditRow1 = {};
	
	var schemaContent = {
			containerId:'contentCoronaDetail',
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
			    	id: 'grid_detail',
			    	label:'',
			    	items:[
						{
							label: " ",
							search: false,
							name: "actions",
							align:'center',
							width: 60,
							formatter: "actions",	
							formatoptions: {
		                        keys: true
		                        ,delbutton:false
		                        ,editformbutton: false
		                        ,editOptions: {} // editformbutton 가 true 인경우
		                        ,addOptions: {}
		                        ,delOptions: {}
		                        
		                        ,afterSave : function(rowid,res) {
		                        	var grid = $(this).jqGrid();
		                        	var row = grid.jqGrid('getRowData',rowid);
		                        	row.sqlid = "dashbaord.corona.emmc.firmware.status.edit";
		                        	row.userId = $("#userId").val();
		                        	row.origindata = JSON.stringify(beforEditRow);
		                        	
		                        	var response1 = {};
		                        	$.ajax({
			                    		url: "/dashboard/genericSaveJson.html",
			                    		type: "POST",
			                    		data: row, 
			                    		async: false,			                    		
			                    		success:  function(data){
			                    			response1 = data;
			                    			if(response1.result != 'success'){
			                    				msg = "Save Success!";
				                    			$("#dialog-confirm").html(data.message);
				                    			$("#dialog-confirm").dialog({
				                    			    resizable: false,
				                    			    modal: true,
				                    			    title: "Error",
				                    			    //height: 200,
				                    			    width: 500,
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
				                    			
				                    			
				                    			  
			                    			}else{
			                    				grid.trigger("reloadGrid",[{current:true}]);
			                    			}					                    			
			                    		}
			                    	});
		                        	
		                        }
		                        ,afterRestore : function(rowid) {
		                        	
		                        }
		                        ,onEdit :function(rowid,actop){
		                        	var grid = $(this).jqGrid();
		                        	beforEditRow = grid.jqGrid('getRowData',rowid);
		    					}
		                        
		                    } 
		                    
		                	
						}
						,{label:'Test Board', name:'TEST_BOARD', id:'TEST_BOARD', width:70, align:'center', sortable:false, hidden: true, editable: false }
						,{label:'Project', name:'SAMPLE', id:'SAMPLE', width:200, align:'left', sortable:false, hidden: false, editable: false }
						,{label:'Firmware', name:'FIRMWARE', id:'FIRMWARE', width:120, align:'left', sortable:false, hidden: false, editable: false }
						
						,{label:'YYYYMM', name:'YYYYMM', id:'YYYYMM', width:70, align:'center', sortable:false ,hidden: true, editable: false}  
						,{label:'Test Item', name:'TEST_ITEM', id:'TEST_ITEM', width:100, align:'center', sortable:false, editable: false }
						,{label:'Script', name:'SCRIPT_NAME_META', id:'SCRIPT_NAME_META', width:400, align:'left', sortable:false, editable: false, hidden: true }
						,{label:'Jira No', name:'JIRA', id:'JIRA', width:80, align:'center', sortable:false, editable: true
							, edittype: "text"							
							,cellattr: function(rowId, val, rowObj, cm, rowData) {
								var result = '';
								if(rowObj.JIRA != undefined && rowObj.JIRA != ""){
									result = ' style="cursor:pointer;';
									result += 'color: blue;font-weight: bolder;"';
								}
									
								return result;
								
							}
						}
						,{label:'Script Name', name:'SCRIPT_NAME', id:'SCRIPT_NAME', width:170, align:'center', sortable:false ,hidden: true, editable: false }
						,{label:'Sample Number', name:'SAMPLE_NUMBER', id:'SAMPLE_NUMBER', width:80, align:'center', sortable:false ,hidden: true, editable: false
							,cellattr: function(){
								var result = " style=\"background:white;vertical-align: middle;cursor:pointer;";
								result += "color: blue;font-weight: bolder;";
								return result;
							}
						}
						,{label:'Status', name:'STATUS', id:'STATUS', width:100, align:'center', sortable:false
							, editable: true
							, edittype: "select"
							, formatter:"select"
							, editoptions: {
								value: {
									"Not Yet":"Not Yet",
									"PASS":"PASS",
									"FAIL": "FAIL"
								}
							}
						}
						,{label:'Status Detail', name:'STATUS_DETAIL', id:'STATUS_DETAIL', width:100, align:'center', sortable:false,hidden: true, editable: false }
			    		,{label:'Duration', name:'DURATION', id:'DURATION', width:70, align:'center', sortable:false ,hidden: true, editable: false}
			    		
			    		,{label:'Test Time', name:'TEST_TIME_MASTER', id:'TEST_TIME_MASTER', width:90, align:'center', sortable:false, editable: false }
			    		,{label:'Customer Item', name:'CUSTOMER_ITEM', id:'CUSTOMER_ITEM', width:90, align:'center', sortable:false, editable: false }
			    		,{label:'Need Vendor<br>CMD', name:'NEED_VENDOR_CMD', id:'NEED_VENDOR_CMD', width:90, align:'center', sortable:false , editable: false}
			    		,{label:'Need Vendor<br>Cycle', name:'NEED_VENDOR_CMD', id:'NEED_POWER_CYCLE', width:90, align:'center', sortable:false, editable: false }
			    		
			    		,{label:'EMMC<br>Ver', name:'EMMC_VER', id:'EMMC_VER', width:50, align:'center', sortable:false, editable: false }
			    		,{label:'Taget<br>Device', name:'TARGET_DEVICE', id:'TARGET_DEVICE', width:70, align:'center', sortable:false, editable: false }
			    		,{label:'Category1', name:'CATEGORY1', id:'CATEGORY1', width:90, align:'center', sortable:false, editable: false }
			    		,{label:'Category2', name:'CATEGORY2', id:'CATEGORY2', width:90, align:'center', sortable:false, editable: false }
			    		,{label:'Category3', name:'CATEGORY3', id:'CATEGORY3', width:90, align:'center', sortable:false, editable: false }
			    		,{label:'Category4', name:'CATEGORY4', id:'CATEGORY4', width:90, align:'center', sortable:false, editable: false }
			    		,{label:'Category5', name:'CATEGORY5', id:'CATEGORY5', width:90, align:'center', sortable:false, editable: false }
			    		,{label:'Write Mode', name:'WRITE_MODE', id:'WRITE_MODE', width:70, align:'center', sortable:false, editable: false }
			    		,{label:'Read Mode', name:'WRITE_MODE', id:'READ_MODE', width:70, align:'center', sortable:false, editable: false }
			    		,{label:'Platform', name:'PLATFORM', id:'PLATFORM', width:70, align:'center', sortable:false, editable: false }
			    		,{label:'Function Name', name:'FUNCTION_NAME', id:'FUNCTION_NAME', width:150, align:'left', sortable:false, editable: false }
			    		
			    		
			    		,{label:'Description', name:'DESCRIPTION', id:'DESCRIPTION', width:200, align:'left', sortable:false, hidden: true, editable: false  }
			    		,{label:'Description', name:'DESCRIPTION_SIMPLE', id:'DESCRIPTION_SIMPLE', width:200, align:'left', sortable:false , editable: false
							, cellattr : function(rowId, val, rowObj, cm, rowData, isCustom){
								var result = "";
								var grid = $(this).jqGrid();
								var colModel = grid.jqGrid('getGridParam','colModel');
								result = " title=\""+ rowObj.DESCRIPTION + "\"";
								
								return result;
								
							}	    			
			    		}
			    		,{label:'Argument', name:'ARGUMENT', id:'ARGUMENT', width:200, align:'left', sortable:false, hidden: true, editable: false  }
			    		,{label:'Argument', name:'ARGUMENT_SIMPLE', id:'ARGUMENT_SIMPLE', width:200, align:'left', sortable:false , editable: false
			    			, cellattr : function(rowId, val, rowObj, cm, rowData, isCustom){
								var result = "";
								var grid = $(this).jqGrid();
								var colModel = grid.jqGrid('getGridParam','colModel');
								result = " title=\""+ rowObj.ARGUMENT + "\"";
								
								return result;
								
							}	    		
			    		
			    		}
			    		
			    		
			    	],					
			    	gridOpt:{
			    		datatype:'json',
			    		pager: "#grid_detailPager",
			    		url:function(){ 
			    			return	"/dashboard/genericlListPageJson.html?" + $("#form").serialize() + "&sqlid=dashboard.corona.emmc.detail.last&paging_sqlid=dashboard.corona.emmc.detail.last.page";
			    			//return	"/dashboard/genericlListPageJson.html?" + "testId=${param.testId}&sample=${param.sample}&firmware=${param.firmware}&category=${param.category}" + "&sqlid=dashboard.corona.emmc.detail.last&paging_sqlid=dashboard.corona.emmc.detail.last.page";
			    		},
			    		//url: "/dashboard/genericlListPageJson.html?" + "testId=${param.testId}&sample=${param.sample}&firmware=${param.firmware}&category=${param.category}" + "&sqlid=dashboard.corona.emmc.detail.last&paging_sqlid=dashboard.corona.emmc.detail.last.page",
			    		viewrecords: true,			    		
			    		width: '100%',
			    		height: '100%',
			    		sortable: false,
			    		multiSort:false,
			    		//sortname: 'CATEGORY, TEST_ITEM ',
			    		rowNum: 20,
						rowList:[10,15,20,30],
			    		//forceFit : false ,
			    		emptyrecords: "No records to view",
			    		rownumbers: true, // show row numbers
			    		
			    		//subgrid start
			    		subGrid: true,
			    		subgridtype:'json',
			    		subGridRowExpanded: function(parentRowID, parentRowKey){
			    			var test = "";
					    	var theGrid = $(this).jqGrid();
					    	var row = theGrid.jqGrid('getRowData',parentRowKey);
					    	var cms = theGrid.jqGrid("getGridParam", "colModel");
					    	
			    			var childGridURL = "/dashboard/genericlListJson.html?sqlid=dashboard.corona.emmc.detail"; 
			    			childGridURL  += "&test_board=" + row.TEST_BOARD;
			    			childGridURL  += "&sample=" + row.SAMPLE;
			    			childGridURL  += "&firmware=" + row.FIRMWARE;
			    			childGridURL  += "&script=" + row.SCRIPT_NAME_META;
			    			
			    			// ***  grid ***//
			    			var childDivId = parentRowID + "_div_input";
			    			var childDiv = $(document.createElement("div"));
			    			childDiv.attr("id",childDivId);
			    			// add a table and pager HTML elements to the parent grid row - we will render the child grid here			    			
			                $('#' + parentRowID).append(childDiv);
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
														var datas = [];
														$.ajax({
											    			type: "POST",
											    			url: "/dashboard/genericlListJson.html",
											    			data: {
											    				sample: row.SAMPLE,
											    				firmware: row.FIRMWARE,
											    				script_name: row.SCRIPT_NAME_META
											    				, sqlid: 'dashboard.corona.emmc.detail.subDetail'}, 
											    			//data: $("#form").serialize(), 
											    			async: false,
											    			success:  function(response){
											    				datas  = response.dataList;
											    				
											    			}
											    		});
														
														return datas[0];
													},
													options : {
														keys : ['FIRMWARE', 'SAMPLE', 'SCRIPT_NAME'],
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
									                    			sqlid: "dashboard.corona.emmc.firmware_script_map.update"
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
																if(react.state.name == "JIRA"){
																	theGrid.setRowData(parentRowKey,{JIRA: react.state.value});
																}
															});
// 															$.each(keyUpdatedObjects,function(i,react){
// 																if(react.state.name == "JIRA"){
// 																	theGrid.setRowData(parentRowKey,{JIRA: react.state.value});
// 																}
// 															});
															
														},
														progressObject: $("#loader")
													},													
													items: [
														//{label:'Jira No', col: 'JIRA'},
														{label:'Description', col: 'DESCRIPTION',edit_tag: 'textarea'},
														{label:'Argument', col: 'ARGUMENT',edit_tag: 'textarea'},
													]
												}
			    					    	
			    					    	]
			    					    }
			    						
			    					
			    					]
			    			};
			    			
			    			fn_makeHtml(childDiv,schema1);
			    			childDiv.find(".right_section").css("float","left");
			    			
			    			
			    			// ***  grid ***//
			    			var childGridID = parentRowID + "_table";
			    			// add a table and pager HTML elements to the parent grid row - we will render the child grid here
			                $('#' + parentRowID).append('<table id=' + childGridID + '></table>');

			                $("#" + childGridID).jqGrid({
			                    url: childGridURL,
			                    //mtype: "GET",
			                    datatype: "json",
			                    //root: "dataList", 
			                    //userdata: "dataList",
			                    jsonReader: {
								      root: function(data){
									    return data.dataList;
								      }
								      //,userdata: function(data){
									  //  return data.dataList;
								      //}
								     ,repeatitems:false
								},
			                    styleUI : 'Bootstrap',
			                    rownumbers: true, // show row numbers
			                    iconSet: "fontAwesome",
			                    //autowidth:true,
			    		        //scrollOffset:15,
			    		        //viewrecords: true,
			    				//emptyrecords: "No records to view",
			    				caption:"Detail List",
			                    colModel: [
									{
										label: " ",
										search: false,
										name: "actions",
										align:'center',
										width: 60,
										formatter: "actions",	
										formatoptions: {
					                        keys: true
					                        ,delbutton:false
					                        ,editformbutton: false
					                        ,editOptions: {} // editformbutton 가 true 인경우
					                        ,addOptions: {}
					                        ,delOptions: {}
					                        
					                        ,afterSave : function(rowid,res) {
					                        	var grid = $(this).jqGrid();
					                        	var row = grid.jqGrid('getRowData',rowid);
					                        	row.sqlid = "dashbaord.corona.emmc.firmware.log.status.edit";
					                        	row.userId = $("#userId").val();
					                        	row.origindata = JSON.stringify(beforEditRow1);
					                        	
					                        	var response1 = {};
					                        	$.ajax({
						                    		url: "/dashboard/genericSaveJson.html",
						                    		type: "POST",
						                    		data: row, 
						                    		async: false,			                    		
						                    		success:  function(data){
						                    			response1 = data;
						                    			if(response1.result != 'success'){
						                    				msg = "Save Success!";
							                    			$("#dialog-confirm").html(data.message);
							                    			$("#dialog-confirm").dialog({
							                    			    resizable: false,
							                    			    modal: true,
							                    			    title: "Error",
							                    			    //height: 200,
							                    			    width: 500,
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
							                    			
							                    			
							                    			  
						                    			}else{
						                    				grid.trigger("reloadGrid",[{current:true}]);
						                    			}					                    			
						                    		}
						                    	});
					                        	
					                        }
					                        ,afterRestore : function(rowid) {
					                        	
					                        }
					                        ,onEdit :function(rowid,actop){
					                        	var grid = $(this).jqGrid();
					                        	beforEditRow1 = grid.jqGrid('getRowData',rowid);
					    					}
					                        
					                    } 
					                    
					                	
									}
									,{label:'Sample', name:'SAMPLE', id:'SAMPLE', width:100, align:'center', sortable:false,hidden: true, editable: false }  
									,{label:'Firmware', name:'FIRMWARE', id:'FIRMWARE', width:100, align:'center', sortable:false,hidden: true, editable: false }  
									,{label:'YYYYMM', name:'YYYYMM', id:'YYYYMM', width:100, align:'center', sortable:false, editable: false }  
									,{label:'Test Board', name:'TEST_BOARD', id:'TEST_BOARD', width:100, align:'center', sortable:false, editable: false }
									,{label:'Sample Number', name:'SAMPLE_NUMBER', id:'SAMPLE_NUMBER', width:80, align:'center', sortable:false, editable: false 
										,cellattr: function(){
											var result = " style=\"cursor:pointer;";
											result += "color: blue;font-weight: bolder;";
											return result;
										}
									}
									,{label:'Script Name', name:'SCRIPT_NAME', id:'SCRIPT_NAME', width:170, align:'center', sortable:false, editable: false }
									,{label:'Script', name:'SCRIPT', id:'SCRIPT', width:250, align:'left', sortable:false, editable: false , hidden: true}
									,{label:'Script', name:'CONVERT_SCRIPT', id:'CONVERT_SCRIPT', width:250, align:'left', sortable:false, editable: false , hidden: true}
									,{label:'Status', name:'STATUS', id:'STATUS', width:100, align:'center', sortable:false 
										, editable: true
										, edittype: "select"
										, formatter:"select"
										, editoptions: {
											value: {
												"PASS":"PASS",
												"FAIL": "FAIL"
											}
										}
									 }
									,{label:'Status Detail', name:'STATUS_DETAIL', id:'STATUS_DETAIL', width:100, align:'center', sortable:false, editable: false }
									,{label:'Seq', name:'SEQ', id:'SEQ', width:100, align:'center', sortable:false, editable: false }
									,{label:'Test Time', name:'TEST_TIME', id:'TEST_TIME', width:120, align:'center', sortable:false, editable: false }
									,{label:'Duration', name:'DURATION', id:'DURATION', width:100, align:'center', sortable:false, editable: false }
									,{label:'FILA_PATH', name:'FILA_PATH', id:'FILA_PATH', width:100, align:'center', sortable:false, editable: false, hidden: true }
									,{label:'FILE_NAME', name:'FILE_NAME', id:'FILE_NAME', width:100, align:'center', sortable:false, editable: false, hidden: true }
			                    ],
			    				loadonce: true,
			                    width: '100%'
			                    ,height: '100%'
		                    	,onCellSelect: function (rowId, iCol, content, event) {
					    			var test = "";
							    	//var grid = $("#attachments");
							    	var grid = $(this).jqGrid();
							    	var row = grid.jqGrid('getRowData',rowId);
							    	var cms = grid.jqGrid("getGridParam", "colModel");
									var cm = cms[iCol];
									
									var oFrm = document.getElementById("form");
									if(cm.name  == 'SAMPLE_NUMBER'){
										
										//var path = 'file:///' + row.FILA_PATH + '.parsed.log' ;
										var path = row.FILA_PATH;
										var path = path.replace(/\.parsed\.log$/gi,"");
										var path = path + '.parsed.log' ;
										//var path1 = path.replace(/z:\//gi,"/dashboard/das_sol/");
										var path1 = path.replace(/^z:\//gi,"http://solutionpms.skhynix.com/dashboard/das_sol/");
										
										var path2 = path1.replace(/\\/g,"/");
										var path3 = path2.replace(/#/g,"%23");
										if(true){
											var newWin1 = window.open("", "filedownload_log", "width=1200,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
											
											oFrm.action =  path3;
											oFrm.method = "post";
											oFrm.target = 'filedownload_log'; 
										    oFrm.submit();		
										    newWin1.focus();	
										}
										
										// localfile 이기 때문에 보안에 걸림
										if(false){
											var path = 'file:///' + row.FILA_PATH + '.parsed.log' ;
											var path1 = path.replace(/#/g,"%23");
											var isIE = /*@cc_on!@*/false || !!document.documentMode; // At least IE6
											if (isIE){
												//var fileData = ['\ufeff' + path1];
												var fileData = [path1];
									            var blobObject = new Blob(fileData);
									            window.navigator.msSaveOrOpenBlob(blobObject, row.FILE_NAME);

											}else{
												var link = document.createElement('a');
												link.download = row.FILE_NAME;
												link.href = path1;
												//Firefox requires the link to be in the body
												document.body.appendChild(link);
												link.click();
												document.body.removeChild(link);
											}
										}
										

									}
					    		}
			                    //pager: "#" + childGridPagerID
			                });
			                
			                
			                var subgrid = $("#" + parentRowID);
			                subgrid.find(".ui-jqgrid").css("width","100%");
			                subgrid.find(".ui-jqgrid-view").css("width","100%");
			                subgrid.find(".ui-jqgrid-hdiv").css("width","100%");
			                subgrid.find(".ui-jqgrid-bdiv").css("width","100%");
			                subgrid.find(".ui-jqgrid-sdiv").css("width","100%");
			                subgrid.find(".ui-jqgrid-pager").css("width","100%");
			                
			                subgrid.find(".ui-jqgrid").css("margin-top","10px");
			    			
			    			
			    		} ,
			    		onCellSelect: function (rowId, iCol, content, event) {
			    			var test = "";
					    	//var grid = $("#attachments");
					    	var grid = $(this).jqGrid();
					    	var row = grid.jqGrid('getRowData',rowId);
					    	var cms = grid.jqGrid("getGridParam", "colModel");
							var cm = cms[iCol];
							
							var oFrm = document.getElementById("form1");
							if(cm.name  == 'JIRA' || cm.name  == 'CONFLUENCE'){
								if(row[cm.name] == undefined || row[cm.name] == "")
									return;
								//var orgRow = dataFilter(testResults,[{col:'DISPLAY_ORDER',val:row.DISPLAY_ORDER}])[0];
								//if(orgRow == undefined)
								//	return;										
								//var path = orgRow[cm.name];
								
								var path = row[cm.name];
								if(path != undefined && path != ""){
									var link = document.createElement('a');
									link.target = "_blank";
									if(path.match(/^(http)|(www)/gi) != null)
										link.href = path;
									else if(cm.name == 'JIRA'){
										link.href = "http://jira.skhynix.com/browse/" + path;
									}else if (cm.name == 'CONFLUENCE'){
										link.href = "http://confluence.skhynix.com/pages/viewpage.action?pageId=" + path;
									}
										
									//Firefox requires the link to be in the body
									document.body.appendChild(link);
									link.click();
									document.body.removeChild(link);
								}
																			
							}
							
					
			    		},
			    		//subgrid end
			    		gridComplete: function () {
			    			var grid = $(this).jqGrid();
			    			grid.jqGrid('filterToolbar',
		    					{
		    						defaultSearch:'cn'
		    		                // JSON stringify all data from search, including search toolbar operators
		    		                ,stringResult: true
		    		                // instuct the grid toolbar to show the search options
		    		                //,searchOperators: true
		    		            }
		    				);
			    			
			    			grid.navGrid('#grid_detailPager' ,
					    			// the buttons to appear on the toolbar of the grid
					    			{ edit: false, add: false, del: false, search: true, refresh: true, view: false, position: "left", cloneToTop: false  },
					    			// options for the Edit Dialog
					    			{  } ,
					    			// options for the Script Master Add Dialog
					    			{	},
					    			// options for the Script Master Del Dialog 
					    			{  },
					    			{ 
					    				multipleSearch: true,
					    				multipleGroup: true
					    			}
					    			
				    			);
			    			
			    		}
				    	
				    	
			    	}
					
				}
				

			]								
	};
	
	
</script>
<script title="ui-schema">
	
	
	
</script>
<script type="text/javascript">
	// form의 데이타를 object화 한다.
	$.fn.serializeObject = function()
	{
	    var o = {};
	    var a = this.serializeArray();
	    $.each(a, function() {
	        if (o[this.name] !== undefined) {
	            if (!o[this.name].push) {
	                o[this.name] = [o[this.name]];
	            }
	            o[this.name].push(this.value || '');
	        } else {
	            o[this.name] = this.value || '';
	        }
	    });
	    return o;
	};

	//var spiderData = {};
	$(function () {
		fn_search();
		$( window ).unload(function() {
			
		});
		
	});
	
	function fn_search(){
		$("#loader").show();
		setTimeout( function(){
			$("#contents").html("");
			fn_makeHtml('contents',schemaContent);
			$("#loader").hide();
		},50);
	}
	
	
	
	function fn_close(){
		window.close();
	}	
</script>
</head>
<body>
<form name="form" id="form" method="post" >
<input type="hidden" name="version" id="version"  value=""/>
<input type="hidden" name ="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="testId" name="testId" value="${param.testId}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="sample" name="sample" value="${param.sample}"/>
<input type="hidden" id="script_name" name="script_name" value="${param.script_name}"/>
	<div class="pop_window">
		<div class="pop_tit_wrap">
			<!-- <span class="baseline"></span> -->
			<h2 class="pop_tit" style="margin-top:10px;">Detailed Information: ${param.sample} / ${param.convert_script}</h2>
		</div>
		
       <div class="pop_con_area" style="padding-top: 3px;"> 
			<div id="contents" class="wrap_a" >
       	   		
       	   </div>  
       	  
       	   <div class="btn_section">
	            <div class="right_section">
	            	
	                  <a href="#"  id="goDatail" class="btn_txt btn_type_e btn_color_c" onclick="fn_close();return false;">
	                      <span class="name">
	                          <span class="txt">Close</span>
	                      </span>
	                  </a>	                  
	            </div>
        	</div>         
       </div> 
       
    </div>
    <div id="loader"></div>
    <div id="dialog-confirm"></div>
    <!-- ## //PAGE CONTENTS ## -->	
</form>
</body>
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
<iframe id="file_iframe" style="display:none;"></iframe>

</html>