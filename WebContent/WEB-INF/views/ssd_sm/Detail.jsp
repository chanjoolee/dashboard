<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>SSD Script Manage Result</title>
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
		<script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js?version=2018.02.23"></script>    
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
		<script src="/dashboard/js/dashboard.js?version=2018.02.23.01"></script>
		
		<%-- 5. local --%>
		<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
		<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
		
		
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
		
		<script src="/dashboard/js/jointjs/lodash.min.js"></script>
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
		var stageList = [
			{STAGE:"WS1",value:"WS1",label:"WS1"},
			{STAGE:"WS2",value:"WS2",label:"WS2"},
			{STAGE:"ES1",value:"ES1",label:"ES1"},
			{STAGE:"ES2",value:"ES2",label:"ES2"},
			{STAGE:"CUS",value:"CUS",label:"CUS"}
		];
		var scriptGroupList = [];
		var scriptGroupListStr = "";
		
		var testInformation = {};
		var testDisks = [];
		var testResults = [];
		var testFiles = [];
		//그리드 편집전 데이타
		var beforEditRow = {};
		var beforEditRow1 = {};
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
													{STAGE:"WS1" <c:forEach items="${paramValues.stage}" var="s" varStatus="status"> <c:if test="${s == 'WS1' }"> , selected: "selected" </c:if>  </c:forEach>},
													{STAGE:"WS2" <c:forEach items="${paramValues.stage}" var="s" varStatus="status"> <c:if test="${s == 'WS2' }"> , selected: "selected" </c:if>  </c:forEach>},
													{STAGE:"ES1" <c:forEach items="${paramValues.stage}" var="s" varStatus="status"> <c:if test="${s == 'ES1' }"> , selected: "selected" </c:if>  </c:forEach>},
													{STAGE:"ES2" <c:forEach items="${paramValues.stage}" var="s" varStatus="status"> <c:if test="${s == 'ES2' }"> , selected: "selected" </c:if>  </c:forEach>},
													{STAGE:"CUS" <c:forEach items="${paramValues.stage}" var="s" varStatus="status"> <c:if test="${s == 'CUS' }"> , selected: "selected" </c:if>  </c:forEach>}
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
												change : function(){
													fn_search();
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

										// {
										// 	type:'Button',
										// 	id: 'btnSearch',
										// 	name: 'btnSearch',
										// 	label:'SEARCH',
										// 	//width: '50px',
										// 	cls: 'btn_txt btn_type_e btn_color_a',
										// 	containerCss:[
										// 		{code: 'margin-right', value:'3px'}
										// 	],
										// 	events:{
										// 		click : function(){
										// 			fn_search();
										// 		}
										// 	}
										// },
										// {
										// 	type:'Button',
										// 	id: 'btnManage',
										// 	name: 'btnManage',
										// 	label:'Management',
										// 	//width: '50px',
										// 	cls: 'btn_txt btn_type_e btn_color_a',
										// 	containerCss:[
										// 		{code: 'margin-right', value:'3px'}
										// 	],
										// 	events:{
										// 		click : function(){
										// 			fn_management();
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
										// row.sqlid = "dashbaord.corona.emmc.firmware.status.edit";
										row.sqlid = "dashbaord.ssd_sm.firmware.status.edit";
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
													//grid.trigger("reloadGrid",[{current:true}]);
												}					                    			
											}
										});
										
									}
									,afterRestore : function(rowid) {
										
									}
									,beforeEditRow :  function(options,rowid){
										//alert("beforeSaveRow")	;
										var grid = $(this).jqGrid();
										beforEditRow = grid.jqGrid('getRowData',rowid);
										return true; 

									}
									// ,onEdit :function(rowid,actop){
									// 	var grid = $(this).jqGrid();
									// 	beforEditRow = grid.jqGrid('getRowData',rowid);
									// }
									
								} 
								
								
							}
							,{label:'Script', name:'SCRIPT_NAME', id:'SCRIPT_NAME', width:160, align:'left'
								, sortable:false 
								, editable: false
								, editrules: { required: true}
								, hidden: false
							}
							,{label:'Project', name:'PROJECT', id:'PROJECT', width:70, align:'center', sortable:false, hidden: true, editable: false }
							,{label:'Firmware', name:'FIRMWARE', id:'FIRMWARE', width:70, align:'center', sortable:false, hidden: true, editable: false }
							,{label:'Stage', name:'STAGE', id:'STAGE', width:100, align:'left'
								, sortable:false 
								, editable: false
								, editrules: { required: true}
								, hidden: false
								, stype:"select"
								, searchoptions: {
									value: function(){
										var rtnList = stageList;
										var tmp = "{";
										tmp += "\"" + "" + "\":\"" + "ALL" + "\"";
										$.each(rtnList,function(i,d){
											// if(i> 0)
											tmp += ",";
											tmp += "\"" + d.STAGE + "\":\"" + d.STAGE + "\"";
										});
										tmp += "}";
										rtn = JSON.parse(tmp);

										return rtn;
									}
								}
								, edittype: 'select'
								, editoptions: {
									//value: edit_option_scriptset
									value: function(){
										var rtnList = stageList;
										var tmp = "{";
										tmp += "\"" + "" + "\":\"" + "Select" + "\"";
										$.each(rtnList,function(i,d){
											// if(i> 0)
											tmp += ",";
											tmp += "\"" + d.STAGE + "\":\"" + d.STAGE + "\"";
										});
										tmp += "}";
										rtn = JSON.parse(tmp);

										return rtn;
										
									}
								}
								// , search: false
							}
							,{label:'Group', name:'SCRIPT_GROUP', id:'SCRIPT_GROUP', width:80, align:'left'
								, sortable:false 
								, editable: false
								, editrules: { required: true}
								, hidden: false
								, edittype: 'select'
								, formatter:'select'
								, editoptions: {
									value: ""
									//value: edit_option_scriptset
								}
								, search: false 
								, stype:"select"
								, searchoptions: {
									value: function(){
										var obj = JSON.parse(scriptGroupListStr);
										obj[""] = "ALL";
										return obj;
									}
								}
							}
							,{label:'Category', name:'CATEGORY', id:'CATEGORY', width:120, align:'left'
								, sortable:false 
								, editable: false
								// , search: false
							}
							,{label:'Sub Category', name:'SUB_CATEGORY', id:'SUB_CATEGORY', width:120, align:'left'
								, sortable:false 
								, editable: false
								// , search: false
							}
							,{label:'Item', name:'ITEM', id:'ITEM', width:100, align:'left', sortable:false
								,editable: false 
								,edittype: "text"
							}
							,{label:'Sub Item', name:'SUB_ITEM', id:'SUB_ITEM', width:80, align:'left', sortable:false 
								,editable: false 
								,edittype: "text"
							}
							
							,{
								label:'Start', name:'START_DT', id:'START_DT', width:120, align:'center', sortable:false , editable: true
								,editoptions:{
									dataInit: function(el){
										$(el).datepicker({dateFormat:'yy-mm-dd'});
									}
								}
								, search: false
								
							}
							,{
								label:'End', name:'END_DT', id:'END_DT', width:120, align:'center', sortable:false , editable: true
								,editoptions:{
									dataInit: function(el){
										$(el).datepicker({dateFormat:'yy-mm-dd'});
									}
								}
								, search: false
							}
							,{label:'Result', name:'STATUS', id:'STATUS', width:110, align:'center', sortable:false
								, editable: true
								, stype:"select"
								, searchoptions: {
									value: {
										"":"ALL",
										"PASSED":"PASSED",
										"FAILED":"FAILED",
										"ING": "ING",
										"PENDING": "PENDING",
										"N/A": "N/A"
									}
								}
								, edittype: "select"
								, formatter:"select"
								, editoptions: {
									value: {
										"":"",
										"PASSED":"PASSED",
										"FAILED":"FAILED",
										"ING": "ING",
										"PENDING": "PENDING",
										"N/A": "N/A"
									}
								}
							}
							
							
						],					
						gridOpt:{
							datatype:'json',
							pager: "#grid_detailPager",
							url:function(){ 
								// return	"/dashboard/genericlListPageJson.html?" + $("#form").serialize() + "&sqlid=dashboard.corona.emmc.detail.last&paging_sqlid=dashboard.corona.emmc.detail.last.page";
								return	"/dashboard/genericlListPageJson.html?" + $("#form").serialize() + "&sqlid=dashboard.ssd_sm.detail.paging&paging_sqlid=dashboard.ssd_sm.detail.paging.page";
							},
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
										firmware:  row.FIRMWARE,
										script_name: row.SCRIPT_NAME
										, sqlid: 'dashboard.ssd_sm.detail.select.one'
									}, 
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
															keys : ['PROJECT','FIRMWARE','SCRIPT_NAME'],
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
																		// sqlid: "dashboard.ssd_sm.script_master.update"
																		sqlid: "dashbaord.ssd_sm.firmware.status.edit.by.react"
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
															{label:'Firmware', col: 'FIRMWARE' , editable: false},
															{label:'Script', col: 'SCRIPT_NAME' , editable: false},
															{label:'Remark', col: 'REMARK' , edit_tag: 'textarea' , editable: true}
														]
														
													}
													
												
												]
											}
											
										
										]
								};
								fn_makeHtml(childDiv,schema1);
								
								
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
								
								if(cm.name  == 'SCRIPT_NAME_META' || cm.name  == 'CONVERT_SCRIPT' ){
									if(row[cm.name] == undefined || row[cm.name] == "")
										return;
									
									var colname = 'SCRIPT_NAME_META';
									var newWin1 = window.open("", "coronaDetailScript_emmc:" + row[colname], "width=1300,height=900, screenY=" + event.screenY + ", top=" + event.screenY + ", screenX=" + event.screenX + ",left=" + event.screenX + ", scrollbars=yes,resizable=yes");
									var oFrm = document.getElementById("form1");
									oFrm.action =  '/dashboard/generic.html?viewName=corona_emmc/coronaDetailScript';
									oFrm.method = "post";
									oFrm.target = "coronaDetailScript_emmc:" + row[colname]; 
									$("#script_name").val(row.SCRIPT_NAME_META);
									$("#convert_script").val(row.CONVERT_SCRIPT);
									oFrm.submit();		
									newWin1.focus();	
																				
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

					var grid = findAll("grid_detail",schemaContent.elements)[0];
					if(grid != undefined){
						_.find(grid.items,{name:'SCRIPT_GROUP'}).editoptions.value = JSON.parse(scriptGroupListStr);
					}
					// rtn = JSON.parse(tmp);
				}
			});
		}	
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
			fn_load_scriptGroups();
			fn_search();
			$( window ).unload(function() {
				
			});
			
		});
		
		function fn_search(){
			$("#loader").show();
			setTimeout( function(){
				$("#contents").html("");
				fn_makeHtml('searchCondition',schemaSearch);
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
<input type="hidden" id="project" name="project" value="${param.project}"/>
<input type="hidden" id="search_firmware" name="search_firmware" value="${param.search_firmware}"/>
<input type="hidden" id="category" name="category" value="${param.category}"/>
<input type="hidden" id="testItem" name="testItem" value="${param.testItem}"/>
<input type="hidden" id="countGubun" name="countGubun" value="${param.countGubun}"/>
<input type="hidden" id="scriptGroup" name="scriptGroup" value="${param.scriptGroup}"/>
	<div class="pop_window">
		<div class="pop_tit_wrap">
			<!-- <span class="baseline"></span> -->
			<h2 class="pop_tit" style="margin-top:10px;">Detailed Information: ${param.project} / ${param.search_firmware} 
			<c:if test="${param.countGubun != null and param.countGubun != '' }"> / ${param.countGubun}</c:if>
			<c:if test="${param.groupName != null and param.groupName != ''}"> / ${param.groupName}</c:if>
			

			</h2>
		</div>
		
       	<div class="pop_con_area" style="padding-top: 3px;"> 
			<div id="searchCondition" class="wrap_a" >
			</div>  
			<div id="contents" class="wrap_a" style="margin-top: 10px;" >
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
<form name="form1" id="form1" method="post" >
	<input type="hidden" name ="sender" value="${param.sender}"/>
	<input type="hidden" name="cookieName" value="${param.cookieName}"/>
	<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
	<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
	<input type="hidden" id="script_name" name="script_name" value=""/>
	<input type="hidden" id="convert_script" name="convert_script" value=""/>
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
			this.props.options.fn_change.call(this, e.target.value);
				    	
	    }
	    
	    
	    
	    render(){
	    	
	    	if(this.props.options.editable == false || this.state.mode == "read"){
				if(this.props.options.edit_tag == "select"){
					return (
					<div style={{width:"100%",height:"100%"}} onDoubleClick={this.dblclick.bind(this)}>
						{this.props.options.selectOptions.map(opt => {
							if ( this.state.value == opt.value){
								return ( <div> {opt.label} </div> );
							}
							
						})}
					</div>
					);
				} else {
					return (
					<div style={{width:"100%",height:"100%"}} onDoubleClick={this.dblclick.bind(this)}>
						{this.state.value}
					</div>
	        		);
				} 
	    		
	    	}else if(this.state.mode == "edit") {	  
	    		if(this.state.edit_tag == "textarea"){
	    			return (
			    		<div>
							<textarea className="form-control" style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value }/>
						</div>
					);
	    		}else if(this.state.edit_tag == "select1") {
					return (
						<div>
							<select className="form-control" onChange={this.changeHandler.bind(this)} value={this.state.value } >
								<option value="grapefruit">Grapefruit</option>
								<option value="lime">Lime</option>
								<option value="coconut">Coconut</option>
								<option value="mango">Mango</option>
							</select>
						</div>

					);
				}else if(this.state.edit_tag == "select") {
					return (
						<div>
							<select  className="form-control" style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value }>
								<option value="">SELECT</option>
								{this.props.options.selectOptions.map(opt => {
									return (
										<option key={opt.value} value={opt.value}>{opt.label}</option>
									);
								})}
							</select>
						</div>

					);
				}else{
	    			return (
			    		<div>
							<input className="form-control" style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value}></input>
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