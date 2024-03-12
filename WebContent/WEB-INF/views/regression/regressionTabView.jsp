<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Regression Tab View</title>
    <%-- 1. jquery --%>
    <!-- <script src="js/jquery/jquery-1.11.2.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
    <!-- <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script> -->
     <!-- <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
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
	<script src="js/dashboard.js?version=2017.11.06"></script>
	
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
	<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/alasql/0.3/alasql.min.js"></script> -->
	<script src="/dashboard/js/jointjs/lodash.min.js"></script>
	<!-- <script src="/dashboard/js/parallel.js"></script> -->
	
	<script type="text/javascript" id="script_common" >
	var folderList = [];	
	var dataMain = {dataList:[]};
	
	</script>
	<script type="text/javascript" id="script_schemaSearchCondition">
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
//								{
//									label:'',
//									type: 'HorizontalLayout',
//									containerCss:[
//							    		{code:'height',value:'30px'}
//							    	],
//									elements:[
//										{
//											type:'SearchHeader',
//											id: 'testDateHead',
//											name: 'testDateHead',
//											label:'',
//											text:'Test Date',
//											width: '60px'
//										}
//										,{
//											type: 'dateInput',
//											id: 'dateFrom',
//											name: 'dateFrom',
//											label:'',
//											value:'',
//											//width:'100px',
//										//		cls: 'btn_txt btn_type_d btn_color_b',
//											containerCss:[
//												
//											],
//											controlCss:[
//												{code: 'text-align', value:'center'},
//												{code: 'height', value:'22px'},
//												{code: 'margin-left', value:'10px'},
//												{code: 'width', value:'100px'}
//											],
//											events:{
//												click : function(){
//													//alert($("[name=radioDate]").val());
//												},
//												change: function(){
//													
//												}
//											},
//											value: function(){
//												var today = new Date();
//										    	var year = today.getFullYear();
//										    	var month = today.getMonth();
//										    	var date = today.getDate();
//										    	
//										    	var startDate = new Date(year,month-6,date+1);
//										    	
//										    	return startDate.toISOString('YYYY-MM-DD').substr(0,10);
//										    	//$("#dateButtonFrom").val(startDate.toISOString('YYYY-MM-DD').substr(0,10));
//										    	//$("#dateButtonFrom").val(today.toISOString('YYYY-MM-DD').substr(0,10));
//											}
//										}
//										,{
//											type: 'dateButton', 
//											id: 'dateButtonFrom',
//											name: 'dateButtonFrom',
//											label:'',
//											parentContainerId:'dateFromContainer',
//											value: function(){
//												
//											},
//											//width:'100px',
//											cls: 'btn_date',
//											containerCss:[
//											              
//											],
//											controlCss:[
//												{code: 'margin-left', value:'0'}
//												//,{code: 'margin-top', value:'-4px'}
//											],
//											events:{
//												click : function(){
//													calendar.calendar_show(event, this, 'dateFrom');
//												}
//											}
//										}
//										,{
//											type:'SearchHeader',
//											id: 'testDateBetweenHead',
//											name: 'testDateBetweenHead',
//											label:'',
//											text:' ~ ',
//											width: '10px',
//											containerCss:[
//												{code: 'margin-left', value:'0'}       
//											],
//											controlCss:[
//												{code: 'width', value:'10px'}
//												
//											]
//										}
//										,{
//											type: 'dateInput',
//											id: 'dateTo',
//											name: 'dateTo',
//											label:'',
//											value:'',
//											//width:'100px',
//										//		cls: 'btn_txt btn_type_d btn_color_b',
//											containerCss:[
//												{code: 'margin-left', value:'4px'},
//											],
//											controlCss:[
//												{code: 'text-align', value:'center'},
//												{code: 'height', value:'22px'},
//												{code: 'width', value:'100px'}
//											],
//											events:{
//												click : function(){
//													//alert($("[name=radioDate]").val());
//												},
//												change: function(){
//													//alert($(this).val());
//													
//												}
//											},
//											value: function(){
//												var today = new Date();
//										    	var year = today.getFullYear();
//										    	var month = today.getMonth();
//										    	var date = today.getDate();
//										    	
//										    	var startDate = new Date(year,month-3,date+1);
//										    	
//										    	return today.toISOString('YYYY-MM-DD').substr(0,10)
//										    	//$("#dateButtonFrom").val(startDate.toISOString('YYYY-MM-DD').substr(0,10));
//										    	//$("#dateButtonFrom").val(today.toISOString('YYYY-MM-DD').substr(0,10));
//											}
//										}
//										,{
//											type: 'dateButton',
//											id: 'dateButtonTo',
//											name: 'dateButtonTo',
//											label:'',
//											value:'',
//											parentContainerId:'dateToContainer',
//											//width:'100px',
//											cls: 'btn_date',
//											containerCss:[
//											],
//											controlCss:[
//												{code: 'margin-left', value:'0'}
//												//,{code: 'margin-top', value:'-4px'}
//											],
//											events:{
//												click : function(){
//													calendar.calendar_show(event, this, 'dateTo');
//												}
//											}
//										}
//										
//									]
//								}
//								//2line
//								,
								{
									label:'',
									type: 'HorizontalLayout',
									containerCss:[
							    		{code:'height',value:'30px'}
							    	],
									elements:[
										{
											type:'SearchHeader',
											id: 'searchPjtHead',
											name: 'searchPjtHead',
											label:'',
											text:'Project',
											width: '60px'
										},
										{
											type:'multiCombo',
											id: 'search_project',
											name: 'search_project',
											label:'',
											text:'Project',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
													url: "/dashboard/genericlListJson.do",
													data: {sqlid: 'dashboard.regresson.pjt_list'}, 
													async: false,
													success:  function(response){
														rtnList = response.dataList;
													}
												});
												return rtnList;
											},
											//value :'CSSD',
											options: {
												cd:'PJT_CODE',
												name:'PJT_NAME'
												,childrens : [
													{
														id: "firmware" ,
														topElement: "schemaSearch.elements"
													}
												]
											},
											multiselectOpt:{
												//selectedList: 1
												multiple: true
												
											},
											events:{
												
											}
										},
										
										{
											type:'SearchHeader',
											id: 'firmwareHead',
											name: 'firmwareHead',
											label:'',
											text:'Firmware',
											width: '60px'
										},
										{
											type:'multiCombo',
											id: 'firmware',
											name: 'firmware',
											label:'',
											text:'Firmware',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
													url: "/dashboard/genericlListJson.do",
													data: {sqlid: 'dashboard.regresson.firmware.list'}, 
													async: false,
													success:  function(response){
														rtnList = response.dataList;
													}
												});
												return rtnList;
											},
											//value :'CSSD',
											options: {
												cd:'FIRMWARE',
												name:'FIRMWARE',
												group: {
													cd:'PJT_CODE',
													name: 'PJT_NAME'
												},
												childrens : [
													{
														id: "revision" ,
														topElement: "schemaSearch.elements"
													}
												]
											},
											multiselectOpt:{
												//selectedList: 1
												multiple: true
												
											},
											events:{
//												change : function(){
//													// start change events
//													// disable Enable
//													$("select[name=firmware] option").each(function(i,sel){
//														var obj = $("select[name=revision] option[FIRMWARE ='"+$(this).val()+"'] ");
//														obj.prop( "disabled", !$(this).is(':checked') );
//														obj.prop( "selected", $(this).is(':checked') );
//													});	
//													// check uncheck multiselect
//													$("select[name=revision] option").each(function(i,project){		
//														var obj = $("input[name=multiselect_revision][value='"+$(this).val()+"']");
//														obj.prop( "disabled", $(this).prop("disabled") );
//														if($(this).prop('disabled')){
//															obj.parent().addClass( "ui-state-disabled" );
//															obj.attr("checked",false);
//															
//														}else{
//															obj.parent().removeClass( "ui-state-disabled" );
//															obj.attr("checked",true);
//														}
//													});
//													
//													
//													$("select[name=revision]").multiselect('refresh');
//													$("div.ui-multiselect-menu").css("width","400px");
//													$(".ui-multiselect-filter input").css("width","150px");
//													// end change events
//												}
											}
										},
										{
											type:'SearchHeader',
											id: 'revisionHead',
											name: 'revisionHead',
											label:'',
											text:'Revision',
											width: '60px'
										},
										{
											type:'multiCombo',
											id: 'revision',
											name: 'revision',
											label:'',
											text:'revision',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
													url: "/dashboard/genericlListJson.do",
													data: {sqlid: 'dashboard.regresson.firmware.revision.list'}, 
													async: false,
													success:  function(response){
														rtnList = response.dataList;
													}
												});
												return rtnList;
											},
											//value :'CSSD',
											options: {
												cd:'REVISION',
												name:'FIRMWARE_REVISION',
												group: {
													cd:'FIRMWARE',
													name: 'FIRMWARE'
												},
											},
											multiselectOpt:{
												//selectedList: 1
												multiple: true
												
											},
											events:{
												change : function(){
													
												}
											}
										}
									]
									
								}
								
								// end 2 line
								
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
													
													getGridData();
												}
											}
										},
										{
											type:'Button',
											id: 'btnShow',
											name: 'btnShow',
											label:'ShowData',
											//width: '50px',
											cls: 'btn_txt btn_type_e btn_color_a',
											
											events:{
												click : function(){
													
													// search
													var theGrid = $("#searchGridTable");
													var selIds = theGrid.jqGrid('getGridParam','selarrrow');													
													if(selIds.length == 0){
														alert("select more than one item!");
														return;
													}
													
													//if(selIds.length > 2){
													//	alert("You can not select more than two.");
													//	return;
													//}
													
													theGrid.jqGrid('setGridState','hidden');	
													$("#contentMain").html("");	
													$.each(schemaTabs.elements[0].elements,function(i,el){
														$("#"+ el.id + 'Frame').remove();
														$("#"+ el.id + 'Content').remove();
														
													});									
													fn_makeHtml('contentMain',schemaTabs);
													
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
	
	var schemaTabs = {
			containerId:'contentCoronaDetail',
			type:'Vertical', 
			label:'',
			elements:[ 
				{
					"type": "tab_list",
					"id" : "tab_list",
					"label" : "",
					//
					"elements" : [
						
						{
							"type": "tab_iframe",
							"id" : "main_tabs",
							"label" : "Main",							
							"connected_content" :  {
								"viewName": "regression/regression_main_tabs",
								"form_id" : "form"
							},
							"events" : {
								//"click" : tab_click
							},
							"iframe_css" : [
								{ "code": "height", "value": "3000px" },
								{ "code": "margin-top", "value": "-7px" }
							]
						},
						{
							"type": "tab_iframe",
							"id" : "smart_tabs",
							"label" : "Smart",							
							"connected_content" :  {
								"viewName": "regression/regression_smart_tabs",
								"form_id" : "form"
							},
							"events" : {
								//"click" : tab_click
							},
							"iframe_css" : [
								{ "code": "height", "value": "30000px" },
								{ "code": "margin-top", "value": "3px" }
								
							]
						},
						{
							"type": "tab_iframe",
							"id" : "hostinfo_tabs",
							"label" : "HostIfo",							
							"connected_content" :  { 
								"viewName": "regression/regression_hostinfo_tabs",
								"form_id" : "form"
							},
							"events" : {
								//"click" : tab_click
							},
							"iframe_css" : [
								{ "code": "height", "value": "2000px" },
								{ "code": "margin-top", "value": "3px" }
							]
						},
						
						
						{
							"type": "tab_iframe",
							"id" : "pecount_tabs",
							"label" : "PECount",							
							"connected_content" :  {
								"viewName": "regression/regression_pecount_tabs",
								"form_id" : "form"
							},
							"events" : {
								//"click" : tab_click
							},
							"iframe_css" : [
								{ "code": "height", "value": "2000px" },
								{ "code": "margin-top", "value": "3px" }
							]
						},
						{
							"type": "tab_iframe",
							"id" : "error_tabs",
							"label" : "Error Log",							
							"connected_content" :  {
								"viewName": "regression/regression_error_tabs",
								"form_id" : "form"
							},
							"events" : {
								//"click" : tab_click
							},
							"iframe_css" : [
								{ "code": "height", "value": "2000px" },
								{ "code": "margin-top", "value": "3px" }
							]
						}
						
						
					]
				}
						
				
			]								
	};
	
	</script>
	<script type="text/javascript" id="script_main">
	
	
	
	$(function () {
		//parent.$("html").css("overflow","scroll");
		//parent.$(".box_gray").css("height","2500px");
		fn_makeHtml('searchCondition',schemaSearch);
		gridInit();
		getGridData();
		$( window ).resize(function() {
			//console.log("aaaaa");
		});
	});
	
	function gridInit(){
		var theGrid = $("#searchGridTable");
		var vColModel = [
			{label:'Pjt Code', name: 'PJT_CODE', index: 'PJT_CODE', width: '100px', editable: false}		                 
			, {label:'Pjt Name', name: 'PJT_NAME_PMS', index: 'PJT_NAME_PMS', width: '200px', editable: false}
			, {label: 'Folder name', name: 'FOLDER_NAME', index: 'FOLDER_NAME', width: '450px', editable: false}
			, {label: 'Firmware' ,name: 'FIRMWARE', index: 'FIRMWARE', width: '100px', editable: false}
			, {label: 'Revision', name: 'REVISION', index: 'REVISION', width: '100px', editable: false}
		];
		var opt ={
				datatype: 'local',
				styleUI : 'Bootstrap',
				colModel: vColModel ,
				rowNum:30,
				rowList:[10,20,30,50,100],
				pager: $("#searchGridPager"),
				sortable: false,
				viewrecords: true,
				rownumbers: true, // show row numbers
		        multiSort:true,
		        multiselect: true,
		        //multiboxonly:true,
		        caption: 'Analysis List',
		        width: '100%' ,
		        forceFit : false ,
		        iconSet: "fontAwesome",
		     	height: '100%',
				editurl:'clientArray'
				,cellsubmit: 'clientArray'
				,onInitGrid: function () {
			        var p = $(this).jqGrid("getGridParam");
			        // save names of columns in custom option of jqGrid
			        p.originalColumnOrder = $.map(p.colModel, function (cm) {
			            return cm.name;
			        });
			        //alert(JSON.stringify(p.originalColumnOrder));
			        
			    },
			    gridComplete: function () {
			    	
			    },
			    onSelectRow: function(id){ 
			    	//alert(id);
			    },
			    onHeaderClick: function(gridstate){
			    	//console.log(gridstate);
			    	if(gridstate == 'visible')
			    		$("#testNameSelector").show();
			    	else
			    		$("#testNameSelector").hide();
			    	
			    },
			    data: folderList
		};
		"use strict";
		theGrid.jqGrid(opt);
		theGrid.jqGrid('sortableRows');
		//theGrid.jqGrid("setFrozenColumns");
		theGrid.jqGrid('filterToolbar',
			{
				defaultSearch:'cn'
                // JSON stringify all data from search, including search toolbar operators
                ,stringResult: true
                // instuct the grid toolbar to show the search options
                //searchOperators: true
            }
		);
		
		$('.ui-jqgrid').css("width",'100%');
		$('.ui-jqgrid-view').css("width",'100%');
		$('.ui-jqgrid-hdiv').css("width",'100%');
		$('.ui-jqgrid-bdiv').css("width",'100%');
		$('.ui-jqgrid-pager').css("width",'100%');
	}
	
	function getGridData(){
		var theGrid = $("#searchGridTable");
		$.ajax({
			url : "/dashboard/regressionTabViewFolderListJson.do",
			data: $("#form").serialize(),
			success : function(responseData){
				folderList = responseData.folderList;				
				theGrid.jqGrid('clearGridData')
					.jqGrid('setGridParam',
				        { 
				            datatype: 'local',
				            data:folderList
				        })
			    	.trigger("reloadGrid",[{ page: 1}]);
				
				$("#loader").hide();
			}
		});
		theGrid.jqGrid('setGridState','visible');
		$("#contents").hide();
		
	}
		
	
	// 가사의 UTC 날자로 실제 날의 가져올다.
	function getDataByUtc(pjtCode,phaseSeqDtUtc){
		var dataRaw = responseData.dataRaw;
		for(var i=0;i<dataRaw.length;i++){
			var data = dataRaw[i];
			if(data.PJT_NAME == pjtCode && data.phaseSeqDtUTC == phaseSeqDtUtc )
				return data;//data.phaseSeqDt;
		}
		return 'error';
	}

	
	alasql.fn.mysplit = function(a,gubun) {
		var splits = [];
		var rtn = '';
		try{
			splits = a.split(gubun);	
			 
		    if( splits.length > 0){
		    	rtn = splits[0];
		    }else
		    	rtn = a;
		}catch(e){
			rtn = a;
		}
	    return rtn;
	}
	
	
	Highcharts.setOptions({
		lang: {
	        decimalPoint: '.',
	        thousandsSep: ','
	    },
		colors: ['#058DC7', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
    });
	
	
	
	</script>
	
	<style type="text/css" title="main">
	
		html, body,form {
	        
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        /* overflow-y: auto; */
	        /* overflow-x: hidden; */
	        
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
		
	</style>
</head>
<body  style="min-width:920px ">
<form name="form" id="form" class="">
	<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
	<input type="hidden" name="cookieName" value="${param.cookieName}"/>
	<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
	<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
	<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>

<div id="searchCondition"></div>
<div id="searchGrid" style="width:100% ;margin-top: 10px;/* display:inline-block;float:left; */">
	<table id="searchGridTable"></table>
	<div id="searchGridPager"></div>
</div>
<div id="testNameSelector"></div>
<div id="contentMain" style="margin-top: 10px;width: 100%;">
	<ul class="tab_2depth">
		<li class="on" id="tabMain" target="main">
       		<a >Main</a>
       	</li>
       	<li class="off" id="tabSmart" target="smart">
       		<a >Smart</a>
       	</li>
       	<li class="off" id="tabHostinfo" target="block">
       		<a >HostInfo</a>
       	</li>
       	<li class="off" id="tabPecount" target="pecount">
       		<a >PECount</a>
       	</li>
       	<li class="off" id="tabErrorlog" target="errorlog">
       		<a >Error log</a>
       	</li>
	</ul>
</div>

<div id="loader"></div>
</form>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</body>
 <div id="dialog-confirm"></div>
</html>
