<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>ssd Custom</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script> -->
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    <%-- jqgrid --%>
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	
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
    
	<!-- <script src="js/highcharts/src/highcharts.src.js"></script> -->
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<script src="js/highcharts/grouped-categories.js"></script>
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<%--
		<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
		<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	 --%>
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=1"></script>
	
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
	<link rel="stylesheet" type="text/css" href="/common/css/calendar.css" />
	
	<script type="text/javascript" title="schema">
	var EfContextPath = "";
	var schema = {
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
							label:'',
							type:'Vertical',
							elements:[
								{
									label:'',
									type: 'HorizontalLayout',
									
									elements:[
										{
											type:'SearchHeader',
											id: 'deviceTypeHead',
											name: 'deviceTypeHead',
											label:'',
											text:'Device Type',
											width: '70px'
										},
										{
											type:'multiCombo',
											id: 'deviceType',
											name: 'deviceType',
											label:'',
											text:'Device Type',
											width: '180px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/ssdCusDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['DEVICE_TYPE']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'DEVICE_TYPE',
												name:'DEVICE_TYPE'
											},
											events:{
												change : function(){
													var name = 'change';
													// start change events
													// disable Enable
													$("select[name=deviceType] option").each(function(i,sel){
														if($(this).is(':selected')){
															$("select[name=modelName] option[device_type ='"+$(this).val()+"'] ").prop( "disabled", false );
															$("select[name=fimwareVersion] option[device_type ='"+$(this).val()+"']").prop( "disabled", false );
														}else{
															$("select[name=modelName] option[device_type='"+$(this).val()+"']").prop( "disabled", true );
															$("select[name=fimwareVersion] option[device_type='"+$(this).val()+"']").prop( "disabled", true );
														}
													});
													
													// check uncheck multiselect
													$("select[name=modelName] option").each(function(i,project){			
														$("input[name=multiselect_modelName][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_modelName][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_modelName][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_modelName][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													$("select[name=fimwareVersion] option").each(function(i,project){			
														$("input[name=multiselect_fimwareVersion][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_fimwareVersion][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_fimwareVersion][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_fimwareVersion][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													
													$("input[name=multiselect_modelName]").each(function(){
														$("select[name=modelName] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													$("input[name=multiselect_fimwareVersion]").each(function(){
														$("select[name=fimwareVersion] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													
													$("select[name=deviceType], select[name=modelName], select[name=fimwareVersion]").multiselect('refresh');
													$("div.ui-multiselect-menu").css("width","400px");
													$(".ui-multiselect-filter input").css("width","150px");
													
													getGridData();
													
													
												}
												// end change events
											}
										},	
										{
											type:'SearchHeader',
											id: 'modelNameHead',
											name: 'modelNameHead',
											label:'',
											text:'Model Name',
											width: '70px'
										},
										{
											type:'multiCombo',
											id: 'modelName',
											name: 'modelName',
											label:'',
											text:'Model Name',
											width: '160px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/ssdCusDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['DEVICE_TYPE','MODEL_NAME']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    			
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'MODEL_NAME',
												name:'MODEL_NAME'
													
											},
											events: {
												change: function(){
													getGridData();
												}
											}
										},
										{
											type:'SearchHeader',
											id: 'fimwareVersionHead',
											name: 'fimwareVersionHead',
											label:'',
											text:'FW Version',
											width: '70px'
										},
										{
											type:'multiCombo',
											id: 'fimwareVersion',
											name: 'fimwareVersion',
											label:'',
											text:'FW Version',
											width: '160px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/ssdCusDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['DEVICE_TYPE','FIRMWARE_VERSION']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'FIRMWARE_VERSION',
												name:'FIRMWARE_VERSION'
													
											},
											events: {
												change: function(){
													getGridData();
												}
											}
										}
									]
								},
								{
									label:'',
									type: 'HorizontalLayout',
									containerCss:[
										{code:'margin-top',value:'1px'}									
									]
									,elements:[
										{
											type:'SearchHeader',
											id: 'systemManufacturerHead',
											name: 'systemManufacturerHead',
											label:'',
											text:'System Manufacturer',
											width: '70px'
										},
										{
											type:'multiCombo',
											id: 'systemManufacturer',
											name: 'systemManufacturer',
											label:'',
											text:'System Manufacturer',
											width: '180px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/ssdCusDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['SYSTEM_MANUFACTURER']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'SYSTEM_MANUFACTURER',
												name:'SYSTEM_MANUFACTURER'
													
											},
											events:{
												change : function(){
													// start change events
													// disable Enable
													$("select[name=systemManufacturer] option").each(function(i,sel){
														if($(this).is(':selected')){
															$("select[name=systemModel] option[system_manufacturer ='"+$(this).val()+"'] ").prop( "disabled", false );
															$("select[name=systemChipset] option[system_manufacturer ='"+$(this).val()+"']").prop( "disabled", false );
														}else{
															$("select[name=systemModel] option[system_manufacturer='"+$(this).val()+"']").prop( "disabled", true );
															$("select[name=systemChipset] option[system_manufacturer='"+$(this).val()+"']").prop( "disabled", true );
														}
													});
													
													// check uncheck multiselect
													$("select[name=systemModel] option").each(function(i,project){			
														$("input[name=multiselect_systemModel][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_systemModel][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_systemModel][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_systemModel][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													$("select[name=systemChipset] option").each(function(i,project){			
														$("input[name=multiselect_systemChipset][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_systemChipset][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_systemChipset][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_systemChipset][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													
													$("input[name=multiselect_systemModel]").each(function(){
														$("select[name=systemModel] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													$("input[name=multiselect_systemChipset]").each(function(){
														$("select[name=systemChipset] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													
													$("select[name=systemManufacturer], select[name=systemModel], select[name=systemChipset]").multiselect('refresh');
													$("div.ui-multiselect-menu").css("width","400px");
													$(".ui-multiselect-filter input").css("width","150px");
													
													getGridData();
													/* projectMultiSelect = $("select[name=pjtCodeList]").multiselect({
														height:400,
														selectedText: 'Project # selected',
														noneSelectedText: 'Select projects'
													}).multiselectfilter(); */
												}
												// end change events
											}
										},	
										{
											type:'SearchHeader',
											id: 'systemModelHead',
											name: 'systemModelHead',
											label:'',
											text:'System Model',
											width: '70px'
										},
										{
											type:'multiCombo',
											id: 'systemModel',
											name: 'systemModel',
											label:'',
											text:'System Model',
											width: '160px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/ssdCusDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['SYSTEM_MANUFACTURER','SYSTEM_MODEL']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'SYSTEM_MODEL',
												name:'SYSTEM_MODEL'
													
											},
											events: {
												change: function(){
													getGridData();
												}
											}
										},
										{
											type:'SearchHeader',
											id: 'systemChipsetHead',
											name: 'systemChipsetHead',
											label:'',
											text:'System Chipset',
											width: '70px'
										},
										{
											type:'multiCombo',
											id: 'systemChipset',
											name: 'systemChipset',
											label:'',
											text:'System Chipset',
											width: '160px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/ssdCusDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['SYSTEM_MANUFACTURER','SYSTEM_CHIPSET']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'SYSTEM_CHIPSET',
												name:'SYSTEM_CHIPSET'
													
											},
											events: {
												change: function(){
													getGridData();
												}
											}
										}
									]
								},
								{
									label:'',
									type: 'HorizontalLayout',
									containerCss:[
										{code:'margin-top',value:'3px'},
										{code:'display',value:'none'}	
									],
									elements:[
										{
											type:'SearchHeader',
											id: 'testDateHead',
											name: 'testDateHead',
											label:'',
											text:'Test Date',
											width: '120px'
										},
										{
											type: 'radioButton',
											id: 'radioDateAll',
											name: 'radioDate',
											label:'All',
											value:'all',
											width:'40px',
// 											cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												{code: 'margin-left', value:'10px'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												}
											},
											checked: true
										},
										{
											type: 'radioButton',
											id: 'radioDateBetween',
											name: 'radioDate',
											label:'Between',
											value:'between',
											width:'70px',
// 											cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												{code: 'margin-left', value:'10px'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												}
											},
											checked: false
										},
										{
											type: 'dateInput',
											id: 'dateFrom',
											name: 'dateFrom',
											label:'',
											value:'',
											//width:'100px',
// 											cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												
											],
											controlCss:[
												{code: 'text-align', value:'center'},
												{code: 'height', value:'1.8em'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												}
											},
											value: function(){
												var today = new Date();
										    	var year = today.getFullYear();
										    	var month = today.getMonth();
										    	var date = today.getDate();
										    	
										    	var startDate = new Date(year,month-3,date+1);
										    	
										    	return startDate.toISOString('YYYY-MM-DD').substr(0,10);
										    	//$("#dateButtonFrom").val(startDate.toISOString('YYYY-MM-DD').substr(0,10));
										    	//$("#dateButtonFrom").val(today.toISOString('YYYY-MM-DD').substr(0,10));
											}
										},
										{
											type: 'dateButton',
											id: 'dateButtonFrom',
											name: 'dateButtonFrom',
											label:'',
											value: function(){
												
											},
											//width:'100px',
											cls: 'btn_date',
											containerCss:[
											],
											controlCss:[
												{code: 'margin-left', value:'0'},
												{code: 'margin-top', value:'-4px'}
											],
											events:{
												click : function(){
													calendar.calendar_show(event, this, 'dateFrom');
												}
											}
										},
										{
											type: 'dateInput',
											id: 'dateTo',
											name: 'dateTo',
											label:'',
											value:'',
											//width:'100px',
// 											cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												{code: 'margin-left', value:'10px'},
											],
											controlCss:[
												{code: 'text-align', value:'center'},
												{code: 'height', value:'1.8em'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												}
											},
											value: function(){
												var today = new Date();
										    	var year = today.getFullYear();
										    	var month = today.getMonth();
										    	var date = today.getDate();
										    	
										    	var startDate = new Date(year,month-3,date+1);
										    	
										    	return today.toISOString('YYYY-MM-DD').substr(0,10)
										    	//$("#dateButtonFrom").val(startDate.toISOString('YYYY-MM-DD').substr(0,10));
										    	//$("#dateButtonFrom").val(today.toISOString('YYYY-MM-DD').substr(0,10));
											}
										},
										{
											type: 'dateButton',
											id: 'dateButtonTo',
											name: 'dateButtonTo',
											label:'',
											value:'',
											//width:'100px',
											cls: 'btn_date',
											containerCss:[
											],
											controlCss:[
												{code: 'margin-left', value:'0'},
												{code: 'margin-top', value:'-4px'}
											],
											events:{
												click : function(){
													calendar.calendar_show(event, this, 'dateTo');
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
											events:{
												click : function(){
													getGridData();
												}
											}
										},
										{
											type:'Button',
											id: 'btnReset',
											name: 'btnReset',
											label:'Reset',
											width: '46px',
											cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												{code: 'margin-left', value:'10px'}
											],
											events:{
												click : function(){
													$("#searchCondition select option:selected").prop("selected", false);
													$("#searchCondition select").multiselect('refresh');
													
													$("div.ui-multiselect-menu").css("width","400px");
													$(".ui-multiselect-filter input").css("width","150px");
												}
											}
										}
									 ]
					 			},
					 			{
					 				label:'',
							 		type: 'HorizontalLayout',
									cls: 'btn_txt',
									containerCss:[
										{code: 'margin-left', value:'-1px'},
										{code: 'margin-top', value:'3px'},
										{code: 'display', value:'block'}
									],
									elements:[
										{
											type:'Button',
											id: 'btnChart',
											name: 'btnChart',
											label:'Chart',
											width: '46px',
											cls: 'btn_txt btn_type_d btn_color_c',
											containerCss:[
												{code: 'margin-left', value:'10px'},
												{code: 'float', value:'right'}
											],
											events:{
												click : function(){
													//var newWin1 = window.open("PmsSchedule", "PmsSchedule", "width=1200,height=870, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
													var newWin1 = window.open("", "SSD_CUSTOMER_CHART", "width=1500,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
													
													var oFrm = document.getElementById("form");
													//oFrm.pjt_code.value = this.options.dataraw.PJT_CODE;
													//oFrm.pjt_name.value = this.options.dataraw.PJT_NAME;
													oFrm.action =  '/dashboard/ssdCusMainChart.html';
													oFrm.method = "post";
													oFrm.target = 'SSD_CUSTOMER_CHART'; 
												    oFrm.submit();	
												    newWin1.focus();
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
	
	function makeHtml(container, _schema){
		var containerSub = null;
		if(container == null)
			container = _schema.containerId;
		if(typeof container == 'string')
			container = $("#" + container);
		
		if(_schema.parentSchema != undefined && _schema.parentSchema.cls != undefined)
			container.addClass(_schema.parentSchema.cls);
		if(_schema.parentSchema != undefined &&  _schema.parentSchema.containerCss != undefined){
			$.each(_schema.parentSchema.containerCss,function(i,v){
				container.css(v.code,v.value);
			});
		}
			
		var mainContainer = null;
		var mainControl = null;
		if(_schema.type == 'inline'){
			var cols = 3;
			if(_schema.cols != undefined)
				cols = _schema.cols;
			
			//tableCreate
			mainContainer = $(document.createElement("table"));
			//table.addClass("table_hori m_bottom_20");
			mainContainer.addClass("table_hori");
			container.append(mainContainer);
			
			// colgroup
			var colgroup = $(document.createElement("colgroup"));
			mainContainer.append(colgroup);
			
			for(var i=0; i< cols;i++){
				if(i == (cols - 1) ){
					colgroup.append("<col width=\"150\"/><col width=\"\"/>");
				}else{
					colgroup.append("<col width=\"150\"/><col width=\"180\"/>");
				}
			}
			// -- colgroup
			
			// tbody
			var tbody = $(document.createElement("tbody"));
			mainContainer.append(tbody); 
			var tr = null;
			$.each(_schema.items,function(i,item){
				if(i%cols == 0 ){
					tr =$(document.createElement("tr"));
					tbody.append(tr);
				}
				//header
				var th = $(document.createElement("th"));
				th.addClass("txt_right");
				th.text(item.label);
				//td value
				var td = $(document.createElement("td"));
				td.addClass("hori_t_data");
				td.text(_schema.data()[item.col]);
				
				tr.append(th);
				tr.append(td);
				
			});
			// --tbody
		}else if(_schema.type == 'grid'){
			//==grid create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(container.children().length > 0)
					mainContainer.css("margin-left","10px");
			}
				
			container.append(mainContainer);
			//mainContainer.css("width","100%");
			//grid.addClass("chartContainerSub");
			
			
			//==table create
			mainControl = $(document.createElement( "table" ));
			mainControl.attr("id",_schema.id);
			//table.css("width","100%");
			mainContainer.append(mainControl);
			
			//== page create
			var pager = $(document.createElement( "div" ));
			pager.attr("id",_schema.id + 'Pager');
			mainContainer.append(pager);
			
			//== common option
			var opt = {
					datatype: 'local',
					styleUI : 'Bootstrap',
					colModel: _schema.items,
					//rowNum:10,
					rownumbers: true, // show row numbers
					caption: _schema.label,
					//width: '100%',
					//height: '100%',
					iconSet: "fontAwesome",
					sortable: false,
					//viewrecords: true,
					//pager : pager, 
					//data : _schema.data() 
			};
			if(_schema.data != undefined && typeof _schema.data == 'function')
				opt.data = _schema.data();
			
			if(_schema.gridOpt != undefined){
				$.extend(opt, _schema.gridOpt);
			}
			
			mainControl.jqGrid(opt);
		}else if(_schema.type == 'chart'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				if(container.children().length > 0)
					mainContainer.css("margin-left","10px");
			}
				
			container.append(mainContainer);
			
			if($(mainContainer).highcharts() != undefined) $(mainContainer).highcharts().destroy();
			var series = {};
			var options = _schema.options();
			if(_schema.data != undefined && typeof _schema.data == 'function'){
				var vData = _schema.data();
				series = vData.series;
				options.series = vData.series.series;
				options.xAxis = vData.xAxis;
			}
				
			$(mainContainer).highcharts(options,function(chart){
		    	
			 });
			
		}else if(_schema.type == 'SearchHeader'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				if(container.children().length > 0)
					mainContainer.css("margin-left","10px");
			}
				
			mainControl = $(document.createElement("h3"));
			//h3.addClass("cont_tit");
			mainContainer.append(mainControl);
			mainControl.text(_schema.text);
			mainControl.css("font-weight","bold");
			mainControl.css("text-align","right");
			mainControl.css("color","#000");
			
			container.append(mainContainer);
		}else if (_schema.type == 'multiCombo'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				if(container.children().length > 0)
					mainContainer.css("margin-left","10px");
			}
			container.append(mainContainer);
			
			var vData = _schema.data();
			var sb = [];
			//sb.push("<option value='' multiple='multiple' ></option>");
			mainControl = $(document.createElement( "select" ));
			mainControl.css("width",_schema.width);
			mainControl.attr("multiple","multiple");
			if(_schema.name != undefined)
				mainControl.attr("name",_schema.name)
			if(_schema.id != undefined)
				mainControl.attr("id",_schema.id)
			mainContainer.append(mainControl);
			$.each(vData,function(){
				var option = $(document.createElement( "option" ));
				option.val(this[_schema.options.cd]);
				option.text(this[_schema.options.name]);
				//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
				$.each(this,function(k,v){
					option.attr(k.toLowerCase(),v);
				});
				//sb.push("<option value='"+ this[_schema.options.cd] +"' "+''+">" + this[_schema.options.name] +"</option>");
				mainControl.append(option);
			});
			//$(vSelect).append(sb.join(""));
			var vMultiSelect = $(mainControl).multiselect({
				//selectedList: 1,
				height:300,
				minWidth: 100,
				//selectedText: _schema.text + ' # selected',
				selectedText: function(numChecked, numTotal, checkedItems){
				     return numChecked + ' of ' + numTotal + ' checked';
				},
				noneSelectedText: 'Select ' + _schema.text
			}).multiselectfilter();
			
			
		}else if(_schema.type == 'Button'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			mainControl = $(document.createElement("a"));
			mainContainer.append(mainControl);
			
			
			var span = $(document.createElement("span"));
			span.addClass("name");
			var span1 = $(document.createElement("span"));
			span1.addClass("txt");
			span1.text(_schema.label);
			span.append(span1);
			mainControl.append(span);
			
			container.append(mainContainer);
		}else if(_schema.type == 'radioButton'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			mainControl = $(document.createElement("input"));
			mainControl.attr("type","radio");
			mainControl.attr("name",_schema.name);
			mainControl.attr("id",_schema.id);
			
			if(_schema.checked != undefined)
				mainControl.prop("checked",_schema.checked);
			
			mainContainer.append(mainControl);
			
			var label = $(document.createElement("label"));
			label.text(_schema.label);
			mainContainer.append(label);
			
			container.append(mainContainer);
		}else if(_schema.type == 'dateInput'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				
			}
			
			// text
			mainControl = $(document.createElement("input"));
			mainControl.attr("type","text");
			mainControl.attr("name",_schema.name);
			mainControl.attr("id",_schema.id);
			mainControl.attr("readonly", "readonly");
			mainContainer.append(mainControl);			
			
			container.append(mainContainer);
		}else if(_schema.type == 'dateButton'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
			}
			
			// btn
			mainControl = $(document.createElement("a"));
			mainContainer.append(mainControl);

			var span = $(document.createElement("span"));
			span.addClass("blind");
			
			mainControl.append(span);
			
			
			container.append(mainContainer);
		}
		
		//******* common properties *******//
		
		//*** default value ***//
		if(mainControl != null  && _schema.value != undefined){
			if(typeof _schema.value == 'string')
				mainControl.val(_schema.value);
			else if(typeof _schema.value == 'function')
				mainControl.val(_schema.value());
		}
		
		//***  class ***//
		if(mainControl != null  && _schema.cls != undefined)
			mainControl.addClass(_schema.cls);
		
		//***  events ***//
		//if(_schema.events != undefined && _schema.events.click != undefined)
		//	vInput.click(_schema.events.click);
		if(mainControl != null  && _schema.events != undefined ){
			$.each(_schema.events,function(ikey,event){
				mainControl.on( ikey, event);
				
			});
		}
		
		//***  css ***//
		//- control
		if(mainControl != null && _schema.controlCss != null){
			$.each(_schema.controlCss,function(i,v){
				mainControl.css(v.code,v.value);
			});
		}
		//- container
		if(mainContainer != null && _schema.containerCss != null){
			$.each(_schema.containerCss,function(i,v){
				mainContainer.css(v.code,v.value);
			});
		}
		
		var containerType = container.attr("type");
		if(mainContainer != null && _schema.parentSchema != undefined && _schema.parentSchema.type == 'HorizontalLayout'){
			mainContainer.css("display","inline-block");
			if(_schema.width != undefined)
				mainContainer.css("width",_schema.width);
		}
		//******* End common properties *******//
		
		
		// data process
		if(_schema.elements != undefined &&  _schema.label != undefined){
			
			if(_schema.label != ""){
				var h3 = $(document.createElement("h3"));
				h3.addClass("cont_tit");
				h3.text(_schema.label);
				container.append(h3);
			}
			
			containerSub = $(document.createElement("div"));
			//상위 container type을 줘서 알아서 판단 할 수 있도록 한다.
			containerSub.attr("type", _schema.type);
			if(_schema.parentSchema != undefined 
					&& _schema.parentSchema.type == 'HorizontalLayout'){
				
				containerSub.css("display","inline-block");
				if(_schema.width != undefined)
					containerSub.css("width",_schema.width);
				//if(container.children().length > 0)
				//	containerSub.css("margin-left","10px");
			}
			container.append(containerSub);
			
		}
		
		if(_schema.elements != undefined){
			$.each(_schema.elements, function(i,el){
				
				el.parentSchema = _schema;
				el.parentContainer = container;
				makeHtml(containerSub,el);
				/* if(el.type == 'inline'){
					makeInline(containerSub, el);
				}else if(el.type == 'grid'){
					makeGrid(containerSub , el );
				}else if(el.type == 'chart'){
					makeChart(containerSub , el );
				}else if(el.type == 'SearchHeader'){
					makeSearchHeader(containerSub , el );
				}else if(el.type == 'multiCombo'){
					makeMultiCombo(containerSub , el );
				}else if(el.elements != undefined){
					makeHtml(container, el);
				} */
			});
		}
		
		
		
		$("div.ui-multiselect-menu").css("width","400px");
		$(".ui-multiselect-filter input").css("width","150px");
	}
	</script>
	
	<script type="text/javascript">
	var dataList = [];
	$(function () {
		//getDataByJson();
		drawGrid();
		makeHtml('searchCondition', schema);
		
		$( window ).resize(function() {
			adjustGrid();
		});
	});
	
	function getDataByJson(){
		$.ajax({
			url : "/dashboard/ssdCusMainJson.html",
			data: $("#form").serialize(),
			success : function(responseData){
				dataList = responseData.dataList;
				drawGrid();
				$("#loader").hide();
			}
		});
	}
	
	function getGridData(){
		var theGrid = $("#jqgridTable");
		theGrid.jqGrid('setGridParam',{url:'/dashboard/ssdCusMainJson.html?'+ $("#form").serialize()}).trigger( 'reloadGrid',[{page:1}]);
		//adjustGrid();
	}
	
	function adjustGrid() {
		$("#jqgridTable").jqGrid('setGridWidth',$("#container").width() - 5 );
		//$("#jqgridTable").jqGrid('setScrollOffset',15 );
		//$("#jqgridTable").jqGrid('setGridHeight',$("#container").height() - 60 );
		
		$('.ui-jqgrid').css("width",'100%');
		$('.ui-jqgrid-view').css("width",'100%');
		$('.ui-jqgrid-hdiv').css("width",'100%');
		$('.ui-jqgrid-bdiv').css("width",'100%');
		$('.ui-jqgrid-pager').css("width",'100%');
	}
	
	function drawGrid(){
		var gridModel = [
    		    {label:'Test Id<br>&nbsp;', name:'TEST_ID', id:'TEST_ID', width:'130px', align:'center', textAlign:'center',sortable:false, cellattr: cellStyle, search: true, color:'blue'},
    		    {label:'Date<br>&nbsp;', name:'TEST_DATE', id:'TEST_DATE', width:'150px', align:'left',sortable:false},
    		    {label:'Tester<br>Name', name:'TESTER_NAME', id:'TESTER_NAME',  width:'130px', align:'center', sortable:false, hidden:true},
    		    {label:'Tester<br>Name', name:'TESTER_NAME_KO', id:'TESTER_NAME_KO',  width:'130px', align:'center', sortable:false},
    		    {label:'Model<br>Name', name:'MODEL_NAME', id:'MODEL_NAME', width:'130px', align:'center' , sortable:false},
    		    {label:'FW Version<br>&nbsp', name:'FIRMWARE_VERSION', id:'FIRMWARE_VERSION',  width:'130px' ,  align:'center', sortable:false},
    		    {label:'Capacity<br>&nbsp', name:'CAPACITY', id:'CAPACITY', width:'130px', align:'center',  sortable:false},
    		    {label:'System<br>Manufactuer', name:'SYSTEM_MANUFACTURER', id:'SYSTEM_MANUFACTURER', width:'130px', align:'center',  sortable:false},
    		    {label:'System<br>Model', name:'SYSTEM_MODEL', id:'SYSTEM_MODEL', width: '130px', align:'center',  sortable:false},
    		    {label:'System<br>Chipset', name:'SYSTEM_CHIPSET', id:'SYSTEM_CHIPSET', width: '130px', align:'center',  sortable:false},
    		    {label:'Test Result<br>(Pass / Total)', name:'TEST_RESULT', id:'TEST_RESULT', width:140,   align:'center', sortable:false, search:false}
          	];
		var theGrid = $("#jqgridTable");
		var opt ={
				//== js ==//
				//datatype: 'local',
				//data: dataList,
				
				//==server side paging ==//
				url: '/dashboard/ssdCusMainJson.html?'+ $("#form").serialize(),
                //mtype: "GET",
                datatype: 'json',
                userdata: "dataList",
				styleUI : 'Bootstrap',
				colModel: gridModel,
				rowNum: 20,
				rowList:[10,20,30,50,100],
				sortable: true,   // change column order
				viewrecords: true,
				emptyrecords: "No records to view",
				rownumbers: true, // show row numbers
		        multiSort: false,
		        multiselect: false,
		        //caption: 'Analysis List',
		        //width: '100%' ,
		        autowidth:true,
		        scrollOffset:15,
		        //forceFit : false ,
		        iconSet: "fontAwesome",
		        height: '100%',
		        pager: $("[id='"+'jqgridPager'+"']"),
		        //height: '220px',
				onInitGrid: function () {
			        var p = $(this).jqGrid("getGridParam");
			        // save names of columns in custom option of jqGrid
			        p.originalColumnOrder = $.map(p.colModel, function (cm) {
			            return cm.name;
			        });
			        //alert(JSON.stringify(p.originalColumnOrder));
			    },
			    beforeProcessing: function(data, status, xhr){
			    	data = data.dataList;
			    },
			    beforeRequest: function(){
			    	var aaa = "aaa";
			    },  
			    gridComplete: function () {
			    	var test = "";
			    	if(dataList.length == 0){
			    		
			    	}
			    	//adjustGrid();
			    	
			    }, 
			    onCellSelect: function (rowId, iCol, content, event) {
			    	var test = "";
			    	var grid = $("#jqgridTable");
			    	var row = theGrid.jqGrid('getRowData',rowId);
			    	var cms = grid.jqGrid("getGridParam", "colModel");
					var cm = cms[iCol];
					
					var ispop = false;
					var oFrm = document.getElementById("form");
					oFrm.testId.value = "";
					
					if(cm.name  == 'TEST_ID'){
						ispop = true;
						oFrm.testId.value = row.TEST_ID;
					}
					
					if(ispop){
						var newWin1 = window.open("", "ssdCusPop", "width=1300,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
						
						oFrm.action =  '/dashboard/ssdCusPop.html';
						oFrm.method = "post";
						oFrm.target = 'ssdCusPop'; 
					    oFrm.submit();		
					    newWin1.focus();	
					}
					
			    }
			    
		};
		
		//"use strict";
		theGrid.jqGrid(opt);
		//theGrid.jqGrid('sortableRows');
		theGrid.jqGrid('filterToolbar',
			{
				defaultSearch:'cn' ,
                // JSON stringify all data from search, including search toolbar operators
                stringResult: true
                // instuct the grid toolbar to show the search options
                //searchOperators: false
            }
		);
		adjustGrid();
		$("#loader").hide();	
	}
	
	function cellStyle(rowId, val, rowObj, cm, rowData) {
		var result = '';
		if(cm.name=='TEST_ID'){
			result = ' style="cursor:pointer;color: rgba(6, 89, 203, 0.93);bold; font-weight: bold;"';
		}
		return result;
	}
	
		
	</script>
	<style type="text/css">
	
		html, body,form {
	        /* height: 100%; */
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        /* overflow-y: auto; */
	        /* overflow-y: hidden; */
	       /*  overflow-x: hidden; */
	        font-size:11px;
	      }
		
		.dashboard-div{
			/* position: relative;
			min-height: 1px;  */
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			margin-top: 10px; 
			/* height: 100%; */
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
		
		
		<%-- jqGrid--%>
		.ui-jqgrid .ui-jqgrid-htable {
			border-top: 1px solid #ddd;
		}
		/* .table>tbody>tr>td{
			padding: 3px;
		} */
		
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
	    
	    .table>tbody>tr>td{
			padding: 7px;
		}
		
		/* #searchCondition h3{
			font-size: 1px;
		} */
	    
	</style>
</head>
<body style="min-width:950px ">
<form name="form" id="form" class="">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<input type="hidden" id="testId" name="testId" value=""/>
<div id="searchCondition"></div>
<div align="left" id="container" class="dashboard-div container" >
	<div id="jqgrid" style="width:100%;/* display:inline-block;float:left; */">
		<table id="jqgridTable"></table>
		<div id="jqgridPager"></div>
	</div>
</div>
<div id="loader"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
