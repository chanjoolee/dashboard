<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>performance</title>
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
    
<!-- 	<script src="js/highcharts/src/highcharts.src.js"></script> 
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script> -->
	
	<script src="/dashboard/js/Highcharts-5.0.7/code/highcharts.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/highcharts-more.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/drilldown.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/no-data-to-display.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/exporting.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/offline-exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<!-- <script src="js/highcharts/grouped-categories.js"></script> -->
	<script src="http://blacklabel.github.io/grouped_categories/grouped-categories.js"></script>
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.08.31.01"></script>
	<script src="/dashboard/js/performance/category_new.1.002.js"></script>
	<script src="/dashboard/js/performance/category_sustain.1.001.js"></script>
	
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
	
	<script type="text/javascript" title="schemaSearchCondition">
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
											id: 'categoryHead',
											name: 'categoryHead',
											label:'',
											text:'Category',
											width: '70px'
										},
										{
											type:'multiCombo',
											id: 'category',
											name: 'category',
											label:'',
											text:'Category',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/performanceDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['CATEGORY']})}, 
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
												name:'CATEGORY'
											},
											multiselectOpt:{
												selectedList: 1
												,selectedText: function(numChecked, numTotal, checkedItems){
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
													// start change events
													// disable Enable
													$("select[name=category] option").each(function(i,sel){
														if($(this).is(':selected')){
															$("select[name=vendor] option[category ='"+$(this).val()+"'] ").prop( "disabled", false );
															$("select[name=nandTech] option[category ='"+$(this).val()+"']").prop( "disabled", false );
														}else{
															$("select[name=vendor] option[category='"+$(this).val()+"']").prop( "disabled", true );
															$("select[name=nandTech] option[category='"+$(this).val()+"']").prop( "disabled", true );
														}
													});
													
													// check uncheck multiselect
													$("select[name=vendor] option").each(function(i,project){			
														$("input[name=multiselect_vendor][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_vendor][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_vendor][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_vendor][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													$("select[name=nandTech] option").each(function(i,project){			
														$("input[name=multiselect_nandTech][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_nandTech][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_nandTech][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_nandTech][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													
													$("input[name=multiselect_vendor]").each(function(){
														$("select[name=vendor] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													$("input[name=multiselect_nandTech]").each(function(){
														$("select[name=nandTech] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													
													$("select[name=category], select[name=vendor], select[name=nandTech]").multiselect('refresh');
													$("div.ui-multiselect-menu").css("width","400px");
													$(".ui-multiselect-filter input").css("width","150px");
													
													getGridData();
													
													// end change events
												}
											}
										}
									
									]
								},
								{
									label:'',
									type: 'HorizontalLayout',
									containerCss:[
										{code:'margin-top',value:'3px'}									
									],
									elements:[
										
										{
											type:'SearchHeader',
											id: 'vendorHead',
											name: 'vendorHead',
											label:'',
											text:'Vendor',
											width: '70px'
										},
										{
											type:'multiCombo',
											id: 'vendor',
											name: 'vendor',
											label:'',
											text:'Vendor',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/performanceDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['CATEGORY','VENDOR']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'VENDOR',
												name:'VENDOR'
											},
											events:{
												change : function(){
													// start change events
													// disable Enable
													$("select[name=vendor] option").each(function(i,sel){
														if($(this).is(':selected')){
															$("select[name=productName] option[vendor ='"+$(this).val()+"'] ").prop( "disabled", false );
															$("select[name=firmware] option[vendor ='"+$(this).val()+"']").prop( "disabled", false );
														}else{
															$("select[name=productName] option[vendor='"+$(this).val()+"']").prop( "disabled", true );
															$("select[name=firmware] option[vendor='"+$(this).val()+"']").prop( "disabled", true );
														}
													});
													
													// check uncheck multiselect
													$("select[name=productName] option").each(function(i,project){			
														$("input[name=multiselect_productName][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_productName][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_productName][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_productName][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													$("select[name=firmware] option").each(function(i,project){			
														$("input[name=multiselect_firmware][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_firmware][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_firmware][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_firmware][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													
													$("input[name=multiselect_productName]").each(function(){
														$("select[name=productName] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													$("input[name=multiselect_fimware]").each(function(){
														$("select[name=fimware] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													
													$("select[name=vendor], select[name=productName], select[name=fimware]").multiselect('refresh');
													$("div.ui-multiselect-menu").css("width","400px");
													$(".ui-multiselect-filter input").css("width","150px");
													
													getGridData();
													
													// end change events
												}
												
											}
										},	
										{
											type:'SearchHeader',
											id: 'productNameHead',
											name: 'productNameHead',
											label:'',
											text:'product Name',
											width: '80px'
										},
										{
											type:'multiCombo',
											id: 'productName',
											name: 'productName',
											label:'',
											text:'Product Name',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/performanceDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['VENDOR','PRODUCT_NAME']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    			
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'PRODUCT_NAME',
												name:'PRODUCT_NAME'
													
											},
											events: {
												change: function(){
													getGridData();
												}
											}
										},
										{
											type:'SearchHeader',
											id: 'firmwareHead',
											name: 'firmwareHead',
											label:'',
											text:'FW Version',
											width: '90px'
										},
										{
											type:'multiCombo',
											id: 'firmware',
											name: 'firmware',
											label:'',
											text:'FW Version',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/performanceDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['VENDOR','FIRMWARE']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'FIRMWARE',
												name:'FIRMWARE'
													
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
										{code:'margin-top',value:'3px'}									
									]
									,elements:[
										{
											type:'SearchHeader',
											id: 'nandTechHead',
											name: 'nandTechHead',
											label:'',
											text:'Nand Tech',
											width: '70px'
										},
										{
											type:'multiCombo',
											id: 'nandTech',
											name: 'nandTech',
											label:'',
											text:'Nand Tech',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/performanceDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['CATEGORY','NAND_TECH']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'NAND_TECH',
												name:'NAND_TECH'
													
											},
											events:{
												change : function(){
													// start change events
													// disable Enable
													$("select[name=nandTech] option").each(function(i,sel){
														if($(this).is(':selected')){
															$("select[name=cellType] option[nand_tech ='"+$(this).val()+"'] ").prop( "disabled", false );
															$("select[name=capacity] option[nand_tech ='"+$(this).val()+"']").prop( "disabled", false );
														}else{
															$("select[name=cellType] option[nand_tech='"+$(this).val()+"']").prop( "disabled", true );
															$("select[name=capacity] option[nand_tech='"+$(this).val()+"']").prop( "disabled", true );
														}
													});
													
													// check uncheck multiselect
													$("select[name=cellType] option").each(function(i,project){			
														$("input[name=multiselect_cellType][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_cellType][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_cellType][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_cellType][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													$("select[name=capacity] option").each(function(i,project){			
														$("input[name=multiselect_capacity][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
														if($(this).prop("disabled")){
															$("input[name=multiselect_capacity][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
															$("input[name=multiselect_capacity][value='"+$(this).val()+"']").attr("checked",false);
															
														}else{
															$("input[name=multiselect_capacity][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
														}
														
													});
													
													$("input[name=multiselect_cellType]").each(function(){
														$("select[name=cellType] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													$("input[name=multiselect_capacity]").each(function(){
														$("select[name=capacity] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
													});
													
													$("select[name=nandTech], select[name=cellType], select[name=capacity]").multiselect('refresh');
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
											id: 'cellTypeHead',
											name: 'cellTypeHead',
											label:'',
											text:'Cell Type',
											width: '80px'
										},
										{
											type:'multiCombo',
											id: 'cellType',
											name: 'cellType',
											label:'',
											text:'Cell Type',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/performanceDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['NAND_TECH','CELL_TYPE']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'CELL_TYPE',
												name:'CELL_TYPE'
													
											},
											events: {
												change: function(){
													getGridData();
												}
											}
										},
										{
											type:'SearchHeader',
											id: 'capacitytHead',
											name: 'capacityHead',
											label:'',
											text:'Capacity',
											width: '90px'
										},
										{
											type:'multiCombo',
											id: 'capacity',
											name: 'capacity',
											label:'',
											text:'Capacity',
											width: '150px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/performanceDistinctFieldJson.html",
										    		data: {filters: JSON.stringify({fields:['NAND_TECH','CAPACITY']})}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'CAPACITY',
												name:'CAPACITY'
													
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
										{code:'margin-top',value:'3px'}
										,{code:'display',value:'none'}	
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
							type: 'HorizontalLayout',
							cls: 'btn_txt',
							containerCss:[
								{code: 'margin-left', value:'10px'}
								, {code: 'float', value:'right'}
							]
							, elements:[
								{
									type:'Button',
									id: 'btnReport',
									name: 'btnReport',
									label:'Report',
									//width: '50px',
									cls: 'btn_txt btn_type_e btn_color_a',
									containerCss:[
										//{code: 'margin-left', value:'10px'}
									],
									events:{
										click : function(){
											fn_parameter_result();
										}
									}
								},
								
								{
									type:'Button',
									id: 'btnSearch',
									name: 'btnSearch',
									label:'SEARCH',
									//width: '50px',
									cls: 'btn_txt btn_type_e btn_color_a',
									containerCss:[
										{code: 'margin-left', value:'10px'}
									],
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
			
			// width가 100%인 경우
			if(opt.width != undefined && opt.width == '100%'){
				mainContainer.find(".ui-jqgrid").css("width","100%");
				mainContainer.find(".ui-jqgrid-view").css("width","100%");
				mainContainer.find(".ui-jqgrid-hdiv").css("width","100%");
				mainContainer.find(".ui-jqgrid-bdiv").css("width","100%");
				mainContainer.find(".ui-jqgrid-sdiv").css("width","100%");
			}
			
			
		}else if(_schema.type == 'chart'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(container.children().length > 0)
					mainContainer.css("margin-left","10px");
			}
			if(_schema.width != undefined)
				mainContainer.css("width",_schema.width);
				
			if(_schema.label != ""){
				var h3 = $(document.createElement("h3"));
				h3.addClass("cont_tit");
				h3.text(_schema.label);
				container.append(h3);
			}
			
			container.append(mainContainer);
			
			
			
			
			
			if($(mainContainer).highcharts() != undefined) $(mainContainer).highcharts().destroy();
			var defaultOption =  {
					credits: {//gets rid of the highcharts logo in bottom right
               			enabled: false
					}
            };
			var series = {};
			var options = $.extend( defaultOption, _schema.options());
			if(_schema.data != undefined && typeof _schema.data == 'function'){
				var vData = _schema.data();
				series = vData.series;
				options.series = vData.series.series;
				if(vData.xAxis != undefined)
					options.xAxis = vData.xAxis;
				if(vData.yAxis != undefined)
					options.yAxis = vData.yAxis;
			}
// 			var chartUser = Highcharts.stockChart($(mainContainer).attr('id') ,options,function(chart){
		    	
// 	 		});
			
			$(mainContainer).highcharts(options,function(chart){
		    	
			 });
			 
			//var chart = mainContainer.highcharts();
			//chart.reflow();
			
// 			$(mainContainer).highcharts(options,function(chart){
		    	
// 			 });
			
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
					mainContainer.css("margin-left","1px");
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
			
			/* var option1 = $(document.createElement( "option" ));
			option1.val('xxx');
			option1.text('xxx');
			option1.css("display","none");
			mainControl.append(option1); */
			
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
			var options = {};
			if(_schema.options.isSingle != undefined && _schema.options.isSingle == true){
				var options = {
					selectedList: 1,
					multiple: false,
					height:300,
					minWidth: 100,
					//selectedText: _schema.text + ' # selected',
					noneSelectedText: 'Select ' + _schema.text
				};
			}else{
				var options = {
					//selectedList: 1,
					height:300,
					minWidth: 100,
					//selectedText: _schema.text + ' # selected',
					selectedText: function(numChecked, numTotal, checkedItems){
					     return numChecked + ' of ' + numTotal + ' checked';
					},
					noneSelectedText: 'Select ' + _schema.text
				};
			}
			
			if(_schema.options != undefined){
				$.extend(options, _schema.options);
			}

			
			var vMultiSelect = $(mainControl).multiselect(options).multiselectfilter();
			
				
			
			
			
			
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
			//mainContainer = $(document.createElement( "div" ));
			//mainContainer.attr("id",_schema.id + 'Container');
			if(_schema.parentContainerId != undefined){
				mainContainer = $("#"  + _schema.parentContainerId);
				
				// btn
				mainControl = $(document.createElement("a"));
				mainContainer.append(mainControl);

				var span = $(document.createElement("span"));
				span.addClass("blind");
				
				mainControl.append(span);
			}
			else{
				mainContainer = $(document.createElement( "div" ));	
				
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
			
		}else if(_schema.type == 'dummy'){
			//==chart container create
			mainContainer = $(document.createElement( "div" ));
			mainContainer.attr("id",_schema.id + 'Container');
			
			var containerType = container.attr("type");
			if(_schema.parentSchema.type == 'HorizontalLayout'){
				mainContainer.css("display","inline-block");
				if(_schema.width != undefined)
					mainContainer.css("width",_schema.width);
				if(container.children().length > 0)
					mainContainer.css("margin-left","1px");
			}
				
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
		var containerType = container.attr("type");
		if(mainContainer != null && _schema.parentSchema != undefined && _schema.parentSchema.type == 'HorizontalLayout'){
			mainContainer.css("display","inline-block");
			if(_schema.width != undefined)
				mainContainer.css("width",_schema.width);
		}
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
	<script type="text/javascript" title="main">

	
	
	//01. series데이타. project
	var dataList = [];
	var dataListAll = [];
	var dataListSmart = [];
	var dataListPerformance = [];
	var tabList = [];
	var folderList = [];
	var multiSearchObj = {}
	var chartContainers = [];
	var pendingDrawChart = false;
	var selectedList = [];
	var $showAllBtn  = {};
	
	var sqlMap = {
			"defect_lists.csv":"dashboard.hms.defect.datalist",
			"drive_level.csv":"dashboard.hms.drive.datalist",
			"erase_count.csv":"dashboard.hms.erase.datalist",
			"performance_data.csv":"dashboard.hms.performance.datalist",
			"smart_attributes.csv":"dashboard.hms.smart.datalist",
			"test_summary.csv":"dashboard.hms.test.datalist"
	};
	
	$(function () {
		makeCategoryHms();
		getDataByJson();
	});
	
	function getDataByJson(){
		if($("#report").val() != "Y"){
			
			$.ajax({
				url : "/dashboard/performanceFolderListJson.html",
				data: $("#form").serialize(),
				success : function(responseData){
					//dataList = responseData.dataList;
					folderList = responseData.folderList;
					//tabList = responseData.tabList;
					makeHtml('searchCondition', schema);
					makeMultiSearchObj();
					//makeTabList();
					document.getElementById("loader").style.display = "none";
				}
			});
		}else{
			makeMultiSearchObj();			
			document.getElementById("loader").style.display = "none";
			$("#searchContainer").hide();
		}
		
	}
	
	function getGridData(){
		$.ajax({
			url : "/dashboard/performanceFolderListJson.html",
			data: $("#form").serialize(),
			success : function(responseData){
				folderList = responseData.folderList;
				var theGrid = $("#"+ multiSearchObj.gridInfo.tableId);
				theGrid.jqGrid('clearGridData')
					.jqGrid('setGridParam',
				        { 
				            datatype: 'local',
				            data:folderList
				        })
			    	.trigger("reloadGrid",[{ page: 1}]);
				
				document.getElementById("loader").style.display = "none";
			}
		});
		$("#"+ multiSearchObj.gridInfo.tableId).jqGrid('setGridState','visible');
		$("#container").hide();
		
	}
	
	function makeMultiSearchObj(){
		//var columns = ['FOLDER_NAME','EDIT_MODE','TARGET','SYSTEM', 'OPERATING_SYSTEM', 'VENDOR', 'PRODUCT_NAME', 'NAND_TECH', 'CELL_TYPE', 'CONTROLLER', 'FORM_FACTOR', 'CAPACITY', 'FIRMWARE', 'SLC_BUFFER', 'MEASURE_DT','IS_GOOD_DATA'];
		var columns = ['FOLDER_NAME','EDIT_MODE','TARGET','CATEGORY','MEASURE_DT','VENDOR','PRODUCT_NAME', 'CONTROLLER', 'NAND_TECH','CELL_TYPE', 'FORM_FACTOR','CAPACITY','FIRMWARE','SLC_BUFFER','SERIAL_NUMBER','TEST_COUNT','IS_GOOD_DATA',
		             //EI-1057 comment 추가
		               'REMARK'];
		var gridColumns = [
               	{
						label: "Edit",
						search: false,
	                    name: "actions",
	                    width: 70,
	                    formatter: "actions",		                    
	                    formatoptions: {
	                        keys: true
	                        ,delbutton:false
	                        ,editOptions: {}
	                        ,addOptions: {}
	                        ,delOptions: {}
	                        ,afterSave : function(rowid,res) {
	                        	var theGrid = $("#"+ multiSearchObj.gridInfo.tableId);
	                        	theGrid.jqGrid('setRowData',rowid,{EDIT_MODE:'U'});
	                        	var row = theGrid.jqGrid('getRowData',rowid);
	                        	$.ajax({
	                    			url : "/dashboard/performanceSaveJson.html",
	                    			//contentType: "application/x-www-form-urlencoded; charset=UTF-8",  
	                    			data: row,
	                    			//EI-1057 comment 추가
	                    			type: "POST",
	                    			//crossDomain: true,
	                    			//dataType: 'json',
	                    			success : function(responseData){
	                    				if(responseData.result == 'fail'){
	                    					alert(responseData.message);
	                    				}
	                    			}
	                    		});
	                        	
	                        }
	                        ,afterRestore : function(rowid) {
	                        	
	                        }
	                        ,onEdit :function(rowid,actop){
	                        	//jQuery("#rowed1").jqGrid('navGrid',"#prowed1",{edit:false,add:false,del:false});
	    						//alert(aaa);
	    					}
	                        
	                    } 
                    
                	}
                	
           ];
		//각 컬럼별로 넓이설정
		$.each(columns,function(i,col){
			var opt = {name: col, index: col, width: '90px', editable: false};
			if(this == 'EDIT_MODE'){
				opt.hidden = true;
			}
			if(this == 'TARGET'){
				opt.width = '80px';
			}
			if(this == 'FOLDER_NAME'){
				opt.hidden = true;
			}
			if(this == 'CATEGORY'){
				opt.width = '75px';
			}
			if(this == 'MEASURE_DT'){
				opt.width = '110px';
			}
			if(this == 'PRODUCT_NAME'){
				opt.width = '120px';
			}
			if(this == 'CONTROLLER'){
				opt.width = '110px';
			}
			if(this == 'FORM_FACTOR'){
				opt.width = '110px';
			}
			if(this == 'SLC_BUFFER'){
				opt.width = '100px';
			}
			if(this == 'SERIAL_NUMBER'){
				opt.width = '120px';
			}
			if(this == 'TEST_COUNT'){
				opt.width = '110px';
			}
			if(this == 'IS_GOOD_DATA'){
				opt.editable = true;
				opt.edittype="checkbox";
				opt.editoptions = {value:"Yes:No"};
				opt.width = '100px'
			}	
			//EI-1057 comment 추가
			if(this == 'REMARK'){
				opt.editable = true;
				opt.width = '200px';
				//opt.edittype = 'textarea';
			}
				
			gridColumns.push(opt);
		});
		multiSearchObj = new multiSearch(
				'selectContainer'
				,folderList
				,columns
				,{
					tableId:'jqgridTable',
					pagerId:'jqgridPager',
					sourceData: folderList,
					colModel:gridColumns
				}						
		);
		
		if($("#report").val() == "Y"){
			multiSearchObj.drawchart();
		}
		
	}
	
	function makeTabList(){
		var tabList1 = [];
		var tabListFilter =[];
		//order by 조정
		$.each(tabList,function(i,src){
			var vCateInfos = dataFilter(categoryInfo,[{col:'category',val: src.DATA_SRC}]);
			var vCateInfo ={};
			if(vCateInfos.length> 0 ){
				vCateInfo = vCateInfos[0];
				tabList1.push(src);
			}else{
		    	//alert('category 정보가 없습니다.' + '('+ src.DATA_SRC +')');		    	
		    	return true;
		    }
			if(vCateInfo.orderby != undefined){
				src.orderby = vCateInfo.orderby;
			}else
				src.orderby = 100;				
		});
		tabList = tabList1;
		sortObjects(tabList,['orderby']);
		$.each(tabList,function(i,src){
			var $li = $(document.createElement( "li" ));
			$("#container .nav-tabs").append($li);
			var $a = $(document.createElement( "a" ));
			$a.attr("target",src.DATA_SRC);
			//$a.attr("href","#chart_" + src.DATA_SRC);
			$a.text(src.DATA_SRC);
			$li.append($a);
			
			//drawchart(i,src.DATA_SRC);	
		});
		
		$(".nav-tabs a").click(function(){
			$(this).tab('show');
			if($showAllBtn.text() != "View All"){
				var dataSrc = $(this).attr("target");
				window.location.href = '#chart_' + dataSrc;
				return;
			}
			
			$("#loader").show();
			//$(".tab-content").hide();
	        
// 	        $.each($("[id^='chart_']"),function(){
// 				$(this).remove();
// 			});			
	        
	        //$(".chartContainer").removeClass("in active");
	        //$("[id='"+$(this).attr("target").replace("#","")+"']" ).addClass("in active");
	        var exists = false;
	        var dataSrc = $(this).attr("target");
	        $.each($("ul li a"),function(){
	        	$("[id='chart_"+$(this).attr("target")+"']" ).removeClass("in active");
	        	//$("[id='chart_"+$(this).attr("target")+"']" ).css("display","none");
			});
	        
	        if($("[id='chart_"+dataSrc+"']" ).length >  0)
	        	exists = true;
	        if(!exists){
				getDataListByAjax($(this).attr("target"),function(){
					setTimeout(function(){ 
						drawchart(0, dataSrc);
						$('.ui-jqgrid').css("width",'100%');
						$('.ui-jqgrid-view').css("width",'100%');
						$('.ui-jqgrid-hdiv').css("width",'100%');
						$('.ui-jqgrid-bdiv').css("width",'100%');
						$('.ui-jqgrid-pager').css("width",'100%');
						$("#loader").hide();
						
						//var charts = $("[id^=chart][id$='highChart']");
						var charts = $("[id^=chart]");
						$.each(charts,function(i,chartDiv){
							var chart =  $(chartDiv).highcharts();
							if(chart != undefined)
								chart.reflow();
						});
						
						//$(window).trigger('resize');
						
					}, 0);
					
				});
	        }else{
	        	setTimeout(function(){ 
	        		// 이미존재한다면
		        	$("[id='chart_"+dataSrc+"']" ).addClass("in active");
		        	$("[id='chart_"+dataSrc+"']" ).trigger('resize');
		        	//$(window).trigger('resize');
		        	$("[id^='chart_"+dataSrc+"'][id$='_highChart']").each(function () { // for only visible charts container in the curent context
		                var $chart = $(this).highcharts(); // cast from JQuery to highcharts obj
		                // 쓸데없는 짓이므로 원복한다.
// 		                if($chart != undefined)
// 		                	$chart.setSize($(this).width(), $chart.chartHeight, doAnimation = true); // adjust chart size with animation transition
		                	
			        });
		        	//$(".tab-content").show();
		        	$("#loader").hide();
		        	//var charts = $("[id^=chart][id$='highChart']");
		        	var charts = $("[id^=chart]");
					$.each(charts,function(i,chartDiv){
						var chart =  $(chartDiv).highcharts();
						if(chart != undefined)
							chart.reflow();
					});
	        	},50);
	        	
				
	        }
	        
	        
	    });
		
		
		var $li = $(document.createElement( "li" ));
		$("#container .nav-tabs").append($li);
		/* $showAllBtn = $(document.createElement( "button" ));
		$showAllBtn.attr("type","button");
		$showAllBtn.addClass("btn btn-info");
		//$showAllBtn.attr("disabled","disabled");
		//$showAllBtn.css("float","right");
		//$showAllBtn.css("width","150px");
		$showAllBtn.css("background-color","#FB6C07");
		$showAllBtn.css("border-color","#CC5713");
		$showAllBtn.text("View All");
		$showAllBtn.click(function(){
			//myInstance.drawchart();
			if($(this).text()=="View All"){
				viewAlltab();
				$(this).text("View One");				
			}else{
				viewOnetab();
				$(this).text("View All");
			}
		}); */
		var $a = $(document.createElement( "a" ));
		if($("#report").val() == "Y"){
			$a.text("View One");
		}else
			$a.text("View All");
		$a.css("background-color","#FB6C07");
		$a.css("color","#fff");
		$a.append($showAllBtn);
		$a.click(function(){
			//myInstance.drawchart();
			if($(this).text()=="View All"){
				viewAlltab();
				$(this).text("View One");				
			}else{
				viewOnetab();
				$(this).text("View All");
			}
		});
		$li.append($a);
		if($showAllBtn.remove != undefined)
			$showAllBtn.remove();
		$showAllBtn = $a;
		//document.getElementById("loader").style.display = "none";
		//getDataListByAjax();
		
		// EI-1057 No. 9. 선택화면을 크게 확장
		$("#"+ multiSearchObj.gridInfo.tableId).jqGrid('setGridState','hidden');
	}
	
	
	
	function getDataListByAjax(pDataSrc,callback){
	
		// Start 이미 있는데이타는 가져오지 않는다.
		var ajaxFilter = [{col:'FOLDER_NAME', val:'xxx'}];
		$.each(selectedList,function(){
			if(dataFilter(dataListAll,[this,{col:'DATA_SRC', val:pDataSrc}]).length == 0){
				ajaxFilter.push(this);
				ajaxFilter.push({col:'DATA_SRC', val:pDataSrc});
			}						
		});
		
		if(ajaxFilter.length > 1){
			var folderNames = getSimpleArray(ajaxFilter,[{col:'col',val:'xxx'},{col:'col',val:'FOLDER_NAME'}],'val');
			var parameter = {
				//FOLDER_NAME: jmespath.search(ajaxFilter,"[?col=='FOLDER_NAME'].val") ,
				FOLDER_NAME : folderNames ,
				data_src : pDataSrc
			};
			if(sqlMap[pDataSrc] != undefined )
				parameter.sqlid = sqlMap[pDataSrc]; 
				
			$.ajax({
				url : "/dashboard/performanceDataListJson.html",
				//data: {FOLDER_NAME: jmespath.search(filters,"[?col=='FOLDER_NAME'].val") },
				data: parameter ,
				//data: jmespath.search(filters,"[?col=='FOLDER_NAME'].{FOLDER_NAME: val}") ,
				async: callback != undefined ? true:false ,
				success : function(responseData){
					//dataList.push(responseData.dataList);
					//dataList = dataList.concat(responseData.dataList);
					//dataList = $.merge(responseData.dataList, dataList);		
					//dataListAll = $.merge(responseData.dataList, dataListAll);	
					dataListAll = $.merge(dataListAll, responseData.dataList );	
					dataList = responseData.dataList;
					if(callback != undefined){
						callback();
					}
				}
				//sucess End
			});
		}else{
			if(callback != undefined){
				callback();
			}
		}
		// End 이미 있는데이타는 가져오지 않는다.
	}
	
	
	function getSimpleArray(arr,searchArr,col){
		var rtn = [];
		var filtered = dataFilter(arr,searchArr);
		$.each(filtered,function(i,val){
			rtn.push(val[col]);
		});
		return rtn;
	}
	
	/**
	* jsonList를 자동으로 multisearch 만듬.
	* excel과 비슷한 filter적용. hierachey 가 아닌 다른조건들 감안
	* list table 추가.
	* 아 이것은 filter dataTable을 통해서 해결 할 수 있다.
	* @param container :  영역
	* @param jsonList: multsearch를 할 데이타소스
	* @param conTree: multisearch를 할 columns
	* @param gridInfo : {tableId:'', pagerId:'', sourceData :resultList,colModel:[{},] }
	*/
	function multiSearch(container,jsonList,colTree,gridInfo){
		var myInstance = this;
		this.container = container;
		this.jsonList = jsonList;
		this.colTree = [];
		this.gridInfo = gridInfo;
		this.analysisList = [];
		
		for(i in colTree){
			var col = colTree[i];
			if(typeof col == 'object'){
				if(col.isMultiple == undefined) {
					col.isMultiple = true;
				}
				this.colTree.push(col);
			}else{
				var colconf = {
					name:col
					,isMultiple: true
				};
				this.colTree.push(colconf)
			}
				
		};
		this.prefix = 'search';
		this.searchList = [];
		
		this.makeSelectObjects = function(instance){
			$.each(instance.colTree,function(i,col){
				var colname=col.name;
				//makeSelectTag
				var $select = $(document.createElement( "select" ));
				$select.attr("id",instance.prefix+colname);
				$select.attr("name",instance.prefix+colname);
				$select.attr("col",colname);
				$select.css("width","150px");
				var list = groupbyCount(instance.groupbyList,[$select.attr("col")]);
				$.each(list,function(i1,m){
					$select.append($('<option>', {
					    value: m[$select.attr("col")],
					    text: m[$select.attr("col")]
					}));
				});
				
				//if(typeof col == 'object' && col.isMultiple)
				$select.attr("multiple","multiple");
				$select.attr("arrindex",i);
				
				
				//관리리스트에 추가
				instance.searchList.push($select);
				//dom에 추가
				$("#"+instance.container).append($select);
				//makeSelectTag end
				//multiselect start
				var opt = {
					multiple: col.isMultiple,
					width:200,
					minWidth: 150,
					//height:400,
					//selectedText: this.attr("col") + ' # ',
					noneSelectedText: 'select ' + $select.attr("col"),
					selectedText: function(numChecked, numTotal, checkedItems){
					      //return numChecked + ' of ' + numTotal + ' checked';
					      return this.element.attr("col") + ": " + $(checkedItems).val();
					},
					open: function(){
					      //$callback.text("Select opened!");
					 	$(this).attr("prev",  $(this).val() );
					 }
				};
				if(!col.isMultiple)
					opt.selectedList = 1;
				//$select.multiselect(opt).multiselectfilter();
				$select.multiselect(opt);
				
			});
			//multiselect end
		};
		
		this.tableSearch = function(instance){
			sortObjects(this.gridInfo.sourceData,[['MEASURE_DT','desc'],'VENDOR', 'PRODUCT_NAME', 'CONTROLLER', 'NAND_TECH', 'CELL_TYPE', 'FORM_FACTOR', 'CAPACITY','FIRMWARE', 'SLC_BUFFER', 'SERIAL_NUMBER', 'TEST_COUNT']);
			var theGrid = $("#"+ this.gridInfo.tableId);
			var lastsel2;
			var opt ={
					datatype: 'local',
					styleUI : 'Bootstrap',
					
					//colNames: jmespath.search(this.gridInfo.sourceData,"[*].val"),
					colModel: this.gridInfo.colModel,
					//rowNum:100000,
					// EI-1057 No. 9. 선택화면을 크게 확장
					rowNum:30,
					rowList:[10,20,30,50,100],
					pager: $("[id='"+this.gridInfo.pagerId+"']"),
					sortable: true,
					viewrecords: true,
					rownumbers: true, // show row numbers
			        multiSort:true,
			        multiselect: true,
			        multiboxonly:true,
			        //sortname: 'orderdate asc, price',
			        //sortorder: 'asc',    
			        //sortname:'MEASURE_DT desc,VENDOR,PRODUCT_NAME, CONTROLLER, NAND_TECH, CELL_TYPE, FORM_FACTOR, CAPACITY, FIRMWARE, SLC_BUFFER, SERIAL_NUMBER, TEST_COUNT',
			        //sortname:'MEASURE_DT desc',
			        //sortorder: 'desc',  
			        //autowidth : true,
			        //shrinkToFit: true,
			        caption: 'Analysis List',
			        width: '100%' ,
			        forceFit : false ,
			        iconSet: "fontAwesome",
			        //height: '100%',
			        //height: '220px',
			     	// EI-1057 No. 9. 선택화면을 크게 확장
			     	 height: '100%',
// 			        onSelectRow: function(id){
// 						if(id && id!==lastsel2){
// 							theGrid.jqGrid('restoreRow',lastsel2);
// 							theGrid.jqGrid('editRow',id,true);
// 							lastsel2=id;
// 						}
// 					}
// 	        	  	onSelectRow : function (rowid, status) {
// 		        	      return false;
// 		        	      //theGrid.setSelection(rowid, false);
// 	        	    }
					//,editurl:"/dashboard/performanceJson.html"
					editurl:'clientArray'
					//, cellEdit: true
					//, forceFit : true
					,cellsubmit: 'clientArray'
					//,cellsubmit: '/dashboard/performanceJson.html'
// 					,afterEditCell: function (id,name,val,iRow,iCol){
					
// 					}
//  					, afterSaveCell : function(rowid,name,val,iRow,iCol) {
// 						if(name == 'IS_GOOD_DATA') {
// 							theGrid.jqGrid('setRowData',rowid,{EDIT_MODE:'U'});
// 						}
						
// 					}
					//,altRows: true
					,onInitGrid: function () {
				        var p = $(this).jqGrid("getGridParam");
				        // save names of columns in custom option of jqGrid
				        p.originalColumnOrder = $.map(p.colModel, function (cm) {
				            return cm.name;
				        });
				        //alert(JSON.stringify(p.originalColumnOrder));
				        
				    },
				    gridComplete: function () {
				    	//$(this).jqGrid('setGridState','hidden');
// 				    	$('#container').append('<span id="widthTest" />');

// 		                gridName = this.id;

// //			                $('#gbox_' + gridName + ' .ui-jqgrid-htable,#' + gridName).css('width', 'inherit');
// 		                $('#' + gridName).parent().css('width', 'inherit');

// 		                var columnNames = $("#" + gridName).jqGrid('getGridParam', 'colModel');
// 		                var thisWidth;

// 		                // Loop through Cols
// 		                for (var itm = 0, itmCount = columnNames.length; itm < itmCount; itm++) {

// 		                    var curObj = $('[aria-describedby=' + gridName + '_' + columnNames[itm].name + ']');
		                    
// 		                    var thisCell = $('#' + gridName + '_' + columnNames[itm].name + ' div');
// 		                    $('#widthTest').html(thisCell.text()).css({
// 		                            'font-family': thisCell.css('font-family'),
// 		                            'font-size': thisCell.css('font-size'),
// 		                            'font-weight': thisCell.css('font-weight')
// 		                        });
// 		                    var maxWidth = Width = $('#widthTest').width() + 24;                    
// 		                    //var maxWidth = 0;                      

// 		                    // Loop through Rows
// //			                    for (var itm2 = 0, itm2Count = curObj.length; itm2 < itm2Count; itm2++) {
// //			                        var thisCell = $(curObj[itm2]);

// //			                        $('#widthTest').html(thisCell.html()).css({
// //			                            'font-family': thisCell.css('font-family'),
// //			                            'font-size': thisCell.css('font-size'),
// //			                            'font-weight': thisCell.css('font-weight')
// //			                        });

// //			                        thisWidth = $('#widthTest').width();
// //			                        if (thisWidth > maxWidth) maxWidth = thisWidth;                        
// //			                    }                    

// 		                    $('#' + gridName + ' .jqgfirstrow td:eq(' + itm + '), #' + gridName + '_' + columnNames[itm].name).width(maxWidth).css('min-width', maxWidth);

// 		                }

// 		                $('#widthTest').remove();
				    },
				    data: this.gridInfo.sourceData
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
			//theGrid.jqGrid().setGridParam({sortorder: "desc"}).jqGrid("sortGrid","MEASURE_DT",true).trigger("reloadGrid");
			//theGrid.jqGrid('navGrid','#' + this.gridInfo.pagerId,{});
			//theGrid.jqGrid('navGrid','#' + this.gridInfo.pagerId,{search: true,edit:false,add:false,del:false});
			//theGrid.jqGrid('inlineNav','#' + this.gridInfo.pagerId);
			theGrid.bind("jqGridAfterGridComplete", function () {
// 				// Test - resize cols based on content

//                 $('#container').append('<span id="widthTest" />');

//                 gridName = this.id;

// //	                $('#gbox_' + gridName + ' .ui-jqgrid-htable,#' + gridName).css('width', 'inherit');
//                 $('#' + gridName).parent().css('width', 'inherit');

//                 var columnNames = $("#" + gridName).jqGrid('getGridParam', 'colModel');
//                 var thisWidth;

//                 // Loop through Cols
//                 for (var itm = 0, itmCount = columnNames.length; itm < itmCount; itm++) {

//                     var curObj = $('[aria-describedby=' + gridName + '_' + columnNames[itm].name + ']');
                    
//                     var thisCell = $('#' + gridName + '_' + columnNames[itm].name + ' div');
//                     $('#widthTest').html(thisCell.text()).css({
//                             'font-family': thisCell.css('font-family'),
//                             'font-size': thisCell.css('font-size'),
//                             'font-weight': thisCell.css('font-weight')
//                         });
//                     var maxWidth = Width = $('#widthTest').width() + 24;                    
//                     //var maxWidth = 0;                      

//                     // Loop through Rows
// //	                    for (var itm2 = 0, itm2Count = curObj.length; itm2 < itm2Count; itm2++) {
// //	                        var thisCell = $(curObj[itm2]);

// //	                        $('#widthTest').html(thisCell.html()).css({
// //	                            'font-family': thisCell.css('font-family'),
// //	                            'font-size': thisCell.css('font-size'),
// //	                            'font-weight': thisCell.css('font-weight')
// //	                        });

// //	                        thisWidth = $('#widthTest').width();
// //	                        if (thisWidth > maxWidth) maxWidth = thisWidth;                        
// //	                    }                    

//                     $('#' + gridName + ' .jqgfirstrow td:eq(' + itm + '), #' + gridName + '_' + columnNames[itm].name).width(maxWidth).css('min-width', maxWidth);

//                 }

//                 $('#widthTest').remove();
			});
			

			$('.ui-jqgrid').css("width",'100%');
			$('.ui-jqgrid-view').css("width",'100%');
			$('.ui-jqgrid-hdiv').css("width",'100%');
			$('.ui-jqgrid-bdiv').css("width",'100%');
			$('.ui-jqgrid-pager').css("width",'100%');
			
		};
		
		this.drawchart = function(){
			
			/* if($("#report").val() == "Y"){
				$("#loader").show();
				//$("#container").hide();
				makeTabList();
				viewAlltab();
				
				return;
			} */
			
			var theGrid = $("#"+ myInstance.gridInfo.tableId);
			var selIds = theGrid.jqGrid('getGridParam','selarrrow');
			
			// EI-1057 No. 6. (반영예정) 2개 비교 여러 개로 확장
			if(selIds.length == 0){
				alert("select more than one item!");
				return;
			}else if(selIds.length>2){
				//alert("select two items!");
				//return;
			}
			
			$("#loader").show();
			//$("#container").hide();
			
// 			if(dataList.length == 0 ){
// 				//alert("waiting data!");
// 				//return;
// 				//timeout = setTimeout(function(){ }, 20000);
// 				pendingDrawChart = true;
// 				return;
// 			}else{
// 				pendingDrawChart = false;
// 			}
			
			
			//Target set
			$.each(theGrid.jqGrid('getDataIDs'),function(i,rowid){
				theGrid.jqGrid('setRowData',rowid,{TARGET:''});
			});			
			
			multiSearchObj.analysisList = [];
			var firstIndex = theGrid.jqGrid('getDataIDs').indexOf(selIds[0]);
			var secondIndex = theGrid.jqGrid('getDataIDs').indexOf(selIds[1]);
			var minIndex = minValue([firstIndex,secondIndex]);
			
			selectedList = [];
			$.each(selIds,function(i,s){
				var row = theGrid.jqGrid('getRowData',s);
				selectedList.push({col:"FOLDER_NAME",val: row.FOLDER_NAME});
				var currentIndex = theGrid.jqGrid('getDataIDs').indexOf(s);
				// EI-1057 No. 6. (반영예정) 2개 비교 여러 개로 확장
				if(selIds.length == 1){
					row.target = 'Target';
				}
				else if(selIds.length == 2){
					if(currentIndex == minIndex){
						row.target = 'Initial';
					}else{
						row.target = 'Target';
					}
				} else{
					row.target = s;
				}
				theGrid.jqGrid('setRowData',s,{TARGET:row.target});
				multiSearchObj.analysisList.push(row);				
					
			});
			
			$.each($("#container ul li"),function(){
				$(this).remove();
			});
			
			$.each($("[id^='chart_']"),function(){
				$(this).remove();
			});			
			//setTimPCMARK7.txtPCMARK7.txteout(function(){$("#loader").show(); }, 50);
			
			$("#loader").show();
			//document.getElementById("loader").style.display = "auto";
			setTimeout(function(){
				var folderNames = getSimpleArray(selectedList,[{col:'col',val:'xxx'},{col:'col',val:'FOLDER_NAME'}],'val');
				var parameter = {
					//FOLDER_NAME: jmespath.search(selectedList,"[?col=='FOLDER_NAME'].val")
					FOLDER_NAME: folderNames
				};
				
				//report 이면 서버를 갖다오지 않는다.
				if($("#report").val() != "Y"){
					$.ajax({
						url : "/dashboard/performanceTabListJson.html",
						//data: {FOLDER_NAME: jmespath.search(filters,"[?col=='FOLDER_NAME'].val") },
						data: parameter ,
						//data: jmespath.search(filters,"[?col=='FOLDER_NAME'].{FOLDER_NAME: val}") ,
						async: false,
						success : function(responseData){
							//dataList.push(responseData.dataList);
							//dataList = dataList.concat(responseData.dataList);
							tabList = responseData.dataList;
							makeTabList();
						}
						//sucess End
					});
				
					// Start 이미 있는데이타는 가져오지 않는다.
					dataListAll = [];
					dataListSmart = [];
					dataListPerformance = [];
					getDataListByAjax(tabList[0].DATA_SRC);
					// End 이미 있는데이타는 가져오지 않는다.
					
					
					setTimeout(function(){
						drawchart(0, tabList[0].DATA_SRC);
						
						$("li a[target='"+ tabList[0].DATA_SRC +"']").tab('show');
						//theGrid.jqGrid('resetSelection');// 
						$('.ui-jqgrid').css("width",'100%');
						$('.ui-jqgrid-view').css("width",'100%');
						$('.ui-jqgrid-hdiv').css("width",'100%');
						$('.ui-jqgrid-bdiv').css("width",'100%');
						$('.ui-jqgrid-pager').css("width",'100%');
						$("#loader").hide();
						$("#container").show();
						
						//setTimeout(function(){
							//var charts = $("[id^=chart][id$='highChart']");
							var charts = $("[id^=chart]");
							$.each(charts,function(i,chartDiv){
								var chart =  $(chartDiv).highcharts();
								if(chart != undefined)
									chart.reflow();
							});
						//},50);
						
						//$(window).trigger('resize');
						//$($(".nav-tabs a")[0]).click();
						//$showARllBtn.removeAttr("disabled");
					},50);
					//End draw chart
				}else{
					makeTabList();
					viewAlltab();
					//$("#loader").hide();
					$("#container").show();
				}
				
				
			
			},0);
			
		};
		
		
		
		this.groupbyList = groupbyCount(this.jsonList ,jmespath.search(this.colTree,'[*].name'));
		
		//initial construct
		//this.makeSelectObjects(this);
		//makeSearchButton start
// 		var $searchBtn = $(document.createElement( "button" ));
// 		$searchBtn.attr("type","button");
// 		$searchBtn.addClass("btn btn-info btn-sm");
// 		$searchBtn.text("Search");
// 		var instance = this;
// 		$searchBtn.click(function(){
// 			instance.tableSearch();
// 		});
// 		$("#"+this.container).append($searchBtn);
// 		$("#"+this.container).append(" ");
		//makeSearchButton end
		//makeUpdateButton start
// 		var $updateBtn = $(document.createElement( "button" ));
// 		$updateBtn.attr("type","button");
// 		$updateBtn.addClass("btn btn-info btn-sm");
// 		$updateBtn.text("Update");
// 		$("#"+this.container).append($updateBtn);
// 		$("#"+this.container).append(" ");
		//makeUpdateButton end
		//ChatShowButton start
		
// 		var $applyBtn = $(document.createElement( "button" ));
// 		$applyBtn.attr("type","button");
// 		$applyBtn.addClass("btn btn-info btn-sm inline");
// 		$applyBtn.text("Show");
// 		$applyBtn.click(function(){
// 			myInstance.drawchart();
// 		});
// 		$("#"+this.container).append($applyBtn);		
		if($("#report").val() != "Y"){
			var $applyBtnA = $(document.createElement( "a" ));
			$applyBtnA.addClass("btn_n2");
			var $applyBtn = $(document.createElement( "span" ));
			//$applyBtn.attr("type","button");
			$applyBtn.addClass("btn_n2_right txt_color_c");
			$applyBtn.text("Show");
			$applyBtn.click(function(){
				myInstance.drawchart();
			});
			$applyBtnA.append($applyBtn);
			$("#"+this.container).append($applyBtnA);	
		
		
			//report
			var $applyBtnA1 = $(document.createElement( "a" ));
			$applyBtnA1.attr("id","btnReport");
			$applyBtnA1.css("display","none");
			$applyBtnA1.addClass("btn_n1");
			var $applyBtn1 = $(document.createElement( "span" ));
			//$applyBtn.attr("type","button");
			$applyBtn1.addClass("btn_n1_right txt_color_a");
			
			//$applyBtn1.text("Report");
			$applyBtn1.text("ChartToImage");
			$applyBtn1.click(function(){
				//saveFile();
				chartConvertToImage();
			});
			$applyBtnA1.append($applyBtn1);
			$("#"+this.container).append($applyBtnA1);	
			
			//download csv
			var $applyBtnA2 = $(document.createElement( "a" ));
			$applyBtnA2.attr("id","btnCsv");
			$applyBtnA2.css("display","none");
			$applyBtnA2.addClass("btn_n1");
			var $applyBtn2 = $(document.createElement( "span" ));
			//$applyBtn.attr("type","button");
			$applyBtn2.addClass("btn_n1_right txt_color_a");
			$applyBtn2.text("csv");
			$applyBtn2.click(function(){
				downloadCsv();
			});
			$applyBtnA2.append($applyBtn2);
			$("#"+this.container).append($applyBtnA2);	
		
		//ChatShowButton end
		//**Legend Button start **//
// 		var $legendLabel1 = $(document.createElement( "label" ));
// 		$legendLabel1.addClass("checkbox-inline");
// 		//$legendLabel1.text("legend show");
// 		$("#"+this.container).append($legendLabel1);
// 		var $legendOption1 = $(document.createElement( "input" ));
// 		$legendOption1.attr("type","checkbox");
// 		//$legendOption1.val("");
// 		$legendLabel1.append($legendOption1);
// 		$legendLabel1.append("legend show");
		
// 		var $legendLabel2 = $(document.createElement( "label" ));
// 		$legendLabel2.addClass("checkbox-inline");
// 		$legendLabel1.text("legend hide");
// 		$("#"+this.container).append($legendLabel2);
// 		var $legendOption2 = $(document.createElement( "input" ));
// 		$legendOption2.attr("type","checkbox");
// 		//$legendOption1.val("");
// 		$legendLabel2.append($legendOption2);
		//** Legend Button end **//
		//end construct
			$("#"+this.container).append("   ");
			$("#"+this.container).append('<label class="radio-inline"><input type="radio" name="optLegend" checked value="on">Legend Show</label><label class="radio-inline"><input type="radio" name="optLegend" value="off">Legend Hide</label>');
			$('input[type=radio][name=optLegend]').change(function() {
				myInstance.drawchart();
		    });
		
		
// 		//Button : show All 
// 		$("#"+this.container).append("   ");
// 		$("#"+this.container).append("   ");
// 		$("#"+this.container).append("   ");
// 		var $showAllBtnA = $(document.createElement( "a" ));
// 		$showAllBtnA.addClass("btn_n2");
// 		var $showAllBtn = $(document.createElement( "span" ));
// 		//$applyBtn.attr("type","button");
// 		$showAllBtn.addClass("btn_n2_right txt_color_c");
// 		$showAllBtn.text("All chart");
// 		$showAllBtn.click(function(){
// 			//myInstance.drawchart();
// 		});
// 		$showAllBtnA.append($showAllBtn);
// 		$("#"+this.container).append($showAllBtnA);
		
// 		$showAllBtn = $(document.createElement( "button" ));
// 		$showAllBtn.attr("type","button");
// 		$showAllBtn.addClass("btn btn-info btn-xs inline");
// 		$showAllBtn.attr("disabled","disabled");
// 		$showAllBtn.css("float","right");
// 		$showAllBtn.css("width","150px");
// 		$showAllBtn.css("background-color","#FB6C07");
// 		$showAllBtn.css("border-color","#CC5713");
// 		$showAllBtn.text("View All");
// 		$showAllBtn.click(function(){
// 			//myInstance.drawchart();
// 			if($(this).text()=="View All"){
// 				viewAlltab();
// 				$(this).text("View One");				
// 			}else{
// 				viewOnetab();
// 				$(this).text("View All");
// 			}
// 		});
			$("#"+this.container).append($showAllBtn);		
		}
		
		this.tableSearch();
		
	}
	
	
	function removeInActive(){
		$.each($("ul li a"),function(){
			var dataSrc = $(this).attr("target");
			$("[id='chart_"+$(this).attr("target")+"']" ).removeClass("in active");
		});
	}
	
	function viewOnetab(){
		$.each($("ul li a"),function(){
			var dataSrc = $(this).attr("target");
			if(!$(this).parent().hasClass("active"))
				$("[id='chart_"+$(this).attr("target")+"']" ).removeClass("in active");
		});
		$(".p-title").hide();
	}
	
	function  viewAlltab(){
		$("#loader").show();
		
		setTimeout(function(){ 
			$.each($("ul li a"),function(){
				var exists = false;
				var dataSrc = $(this).attr("target");
				if(dataSrc == undefined || dataSrc == "")
					return true;
				if($("[id='chart_"+dataSrc+"']" ).length >  0)
		        	exists = true;
				
				if(!exists){
					getDataListByAjax(dataSrc);
					drawchart(0, dataSrc);
		        }else{
		        	//setTimeout(function(){ 
		        		// 이미존재한다면
			        	$("[id='chart_"+dataSrc+"']" ).addClass("in active");
	// 		        	$("[id^='chart_"+dataSrc+"'][id$='_highChart']").each(function () { // for only visible charts container in the curent context
	// 		                var $chart = $(this).highcharts(); // cast from JQuery to highcharts obj
	// 		                $chart.setSize($(this).width(), $chart.chartHeight, doAnimation = true); // adjust chart size with animation transition
	// 			        });
		        	//},0);
		        }
				
	        	//$("[id='chart_"+$(this).attr("target")+"']" ).css("display","none");
			});
			
			//sort div
			$(".chartContainer").sort(function(a,b){
				var vCateInfosA = dataFilter(categoryInfo,[{col:'category',val: $(a).attr("data_src")}])[0];
				var vCateInfosB = dataFilter(categoryInfo,[{col:'category',val: $(b).attr("data_src")}])[0]; 
				var orderA = vCateInfosA.orderby != undefined ? vCateInfosA.orderby: 10000;
				var orderB = vCateInfosB.orderby != undefined ? vCateInfosB.orderby: 10000;
				if(orderA > orderB)
					return 1;
				if(orderA < orderB)
					return -1;
				return 0;
			}).detach().appendTo($("#container .tab-content"));
			
			//$(".chartContainer").detach().appendTo($("#container .tab-content"));
			
			
			$(".p-title").show();
			$(window).trigger('resize');
			$("#loader").hide();
			$('.ui-jqgrid').css("width",'100%');
			$('.ui-jqgrid-view').css("width",'100%');
			$('.ui-jqgrid-hdiv').css("width",'100%');
			$('.ui-jqgrid-bdiv').css("width",'100%');
			$('.ui-jqgrid-pager').css("width",'100%');
			
			//focus
			if($("ul li.active a").length > 0){
				window.location.href = '#chart_' + $("ul li.active a").attr("target");
			}
			
			$("#btnReport").show();
			$("#btnCsv").show();
			
			//var charts = $("[id^=chart][id$='highChart']");
			var charts = $("[id^=chart]");
			$.each(charts,function(i,chartDiv){
				var chart =  $(chartDiv).highcharts();
				if(chart != undefined)
					chart.reflow();
			});
			
		},50);
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
	
	function drawchart(order,pDataSrc){
		//$("#container").empty();
		//$("#container").html("");
		/* $.each(chartContainers,function(){
			this.remove();
		});
		chartContainers = []; */
		//document.getElementById("container").innerHTML = "";
		var theGrid = $("#"+ multiSearchObj.gridInfo.tableId);
		var chartContainerId = 'chart_' +  pDataSrc;
		
		
		if($("[id='"+chartContainerId+"']" ).length == 0){
			//SubContainer 생성
			var $chartContainer = $(document.createElement( "div" ));
			$chartContainer.attr("id",chartContainerId);
			$chartContainer.attr("data_src",pDataSrc);
			//css
			//$chartContainer.css("height","700px");
			$chartContainer.css("width","100%");
			//$chartContainer.css("display","none");
			$chartContainer.addClass( "chartContainer modern-p-form p-form-modern-orange tab-pane fade");
			if(order==0)
				$chartContainer.addClass( "in active");
			//$chartContainer.addClass( "modern-p-form p-form-modern-steelBlue");
			$("#container .tab-content").append($chartContainer);
			
			//$chartContainer.addClass( "span4");
			// var $subject = $(document.createElement( "h3" ));
			// $subject.addClass( "p-title");
			// $subject.text(pDataSrc.split(".")[0]);
			// $chartContainer.append($subject);
			
			var $subjectDiv = $(document.createElement( "div" ));
			//$subjectDiv.addClass( "p-title text-left");
			$subjectDiv.addClass( "p-title");
			$subjectDiv.css( "display","none");
			var $subject = $(document.createElement( "h3" ));
			$subject.addClass( "p-title-line");
			$subject.css( "margin-top","0px");
			$subject.css( "font-size","15px");
			//$subject.text(pDataSrc.split(".")[0]);
			$subject.text(pDataSrc);
			$subjectDiv.append($subject);
			$chartContainer.append($subjectDiv);
			
			var $top = $(document.createElement( "a" ));
			$top.css( "font-size","15px");
			$top.css( "float","right");
			$top.css( "color","#fff");
			//$subject.text(pDataSrc.split(".")[0]);
			$top.text("Top");
			$top.click(function(){
				window.location.href = '#container';
			});
			$subject.append($top);
		}
		

		
		//01. 데이타필터링
		var filters = [];
// 		var selIds = theGrid.jqGrid('getGridParam','selarrrow')
// 		$.each(selIds,function(i,s){
// 			var row = theGrid.jqGrid('getRowData',s);
// 			filters.push({col:"FOLDER_NAME",val: row.FOLDER_NAME});
// 		});
		$.each(selectedList,function(i,s){
			//filters.push(s);
		});
		//filters.push({col:'DATA_SRC',val:pDataSrc});
		
		//01.01. 각타입별로 filters 추가. categoryInfo 참조
	    var vCateInfos = dataFilter(categoryInfo,[{col:'category',val: pDataSrc}]);
	    var vCateInfo ={};
	    if(vCateInfos.length> 0 ){
	    	vCateInfo = vCateInfos[0];
		    if(vCateInfo.uiSchema != undefined){
		    	$lineContainer =  $(document.createElement( "div" ));
				var lineId = chartContainerId + '_line';
				$lineContainer.attr("id",lineId);
				$lineContainer.css("width","100%");
				$lineContainer.addClass("chartContainerSub");
				$chartContainer.append($lineContainer);
				makeHtml($lineContainer,vCateInfo.uiSchema );
				return;
			}
	    	//계산된컬럼	    	
    		$.each(vCateInfo.calculateCols,function(j,c){
    			$.each(dataList,function(i,m){
    				if(m.DATA_SRC == pDataSrc ){
    					m[c.col] =  c.val.apply(m);
    				}
    			});
	    	});
	    	
	    	//데이타추가
	    	if(vCateInfo.addRows != undefined){
	    		vCateInfo.addRows.apply(dataList);
	    	}
	    	
	    	$.each(vCateInfo.filters,function(i,f){
	    		filters.push(f);
	    	});
	    	
	    }else{
	    	alert('category 정보가 없습니다.' + '('+ pDataSrc +')');
	    	return;
	    }
	    

	    
	    var decimalPoint = 0;
	    if(vCateInfo.decimalPoint != undefined)
	    	decimalPoint = vCateInfo.decimalPoint;
		
		//sortObjects(filteredData, vCateInfo.categoryCols);
		
		//02. series
		//03. value 축
		//04. drawchart
		
		
		// multichart
		var filteredData = dataFilter(dataList,filters);
		var vCols = [{containerId:chartContainerId, filter:[]}];
		if(vCateInfo.multichart.enabled &&  vCateInfo.multichart.splitCol != undefined){
			//customStyle count ==> 0
			if(vCateInfo.multichart.customStyle != undefined){
				$.each(vCateInfo.multichart.customStyle,function(i,style){
					style.count = 0;
				});
			}
			
			vCols = [];
			var vColsG = groupbyCount(filteredData,[vCateInfo.multichart.splitCol]);
			
			//parent height
// 			var parentHeight = $chartContainer.height();
// 			if(vCateInfo.multichart.oneLineChatNum != undefined){
// 				var lines = Math.ceil(vColsG.length/vCateInfo.multichart.oneLineChatNum);
// 				parentHeight += (lines -1) * vCateInfo.multichart.oneLineHeight;
// 			}
// 			$chartContainer.css("height",  parentHeight + "px");
			
			//sortObjects(vColsG,[vCateInfo.multichart.splitCol]);
			//EI-1057 No.1orderby 
			$.each(vColsG,function(i,col){
				if(col[vCateInfo.multichart.splitCol] == 'IOps')
					col.multichartOrder = 100;
				else
					col.multichartOrder = 1;
			});
			if(vCateInfo.multichart.orderBy != undefined){
				$.each(vColsG,function(){
					this.orderBy = vCateInfo.multichart.orderBy.call(this);
				});
				sortObjects(vColsG,['orderBy',vCateInfo.multichart.splitCol]);
			}
			else
				sortObjects(vColsG,['multichartOrder',vCateInfo.multichart.splitCol]);
			
			var $lineContainer = {};
			//customStyle을 위한 변수
			var pre = "";
			var cur = "";
			var j=0;
			
			//series 별 스타일이 있는경우
			var selectedStyle = null;
			var selectedStyle_pre = null;
			selectedStyleCount = 0;
			$.each(vColsG,function(i,col){
				var isNewLine = false;			
				var vdevide =  vCateInfo.multichart.oneLineChatNum != undefined ? vCateInfo.multichart.oneLineChatNum  : 2 ;
				if(i%vdevide == 0)
					isNewLine = true;
				
				
				if(vCateInfo.multichart.customStyle != undefined){
					
					$.each(vCateInfo.multichart.customStyle,function(i1,style){
						var re = new RegExp('^' + style.name,'i');
						var re_result = re.exec(col[vCateInfo.multichart.splitCol]);
						if(re_result != null){
							selectedStyle = style;							
							return false;
						}
					});
					if(selectedStyle != null){
						vdevide = selectedStyle.oneLineChatNum != undefined ? selectedStyle.oneLineChatNum  : 2 ;
						//if(selectedStyle.count % vdevide == 0){
						if (selectedStyle_pre != selectedStyle )
							selectedStyleCount = 0;
						
						if (selectedStyleCount == 0 )
							isNewLine = true;
						else if(selectedStyleCount % vdevide == 0){
							isNewLine = true;
							selectedStyleCount = 0;
						}
						else{
							isNewLine = false;
						}
							
						//selectedStyle.count = selectedStyle.count + 1;
						selectedStyleCount = selectedStyleCount + 1;
						
						selectedStyle_pre = selectedStyle;
						
					}
				}
				//pre = vColsG[i-1] != undefined ? vColsG[i-1];
				//cur = 
				if(isNewLine){
					$lineContainer =  $(document.createElement( "div" ));
					var lineId = chartContainerId + '_line' + Math.ceil(i/2);
					$lineContainer.attr("id",lineId);
					$lineContainer.css("width","100%");
					$lineContainer.addClass("chartContainerSub");
					$chartContainer.append($lineContainer);
				}
				var subId = chartContainerId + '_' + i;
				if($("[id='"+subId+"']" ).length == 0){
					var $subContainer = $(document.createElement( "span" ));
					$subContainer.attr("id",subId);
					$subContainer.attr("data_src",pDataSrc);
					//css
					//height
// 					var subHeight = 600;
// 					if(vCateInfo.multichart.oneLineHeight != undefined){
// 						subHeight = vCateInfo.multichart.oneLineHeight;
// 					}
					//$subContainer.css("height",subHeight + 'px');
					//width
					
					var subWidth = (1/vColsG.length)*100 ;
					if(vCateInfo.multichart.chartWidth != undefined){
						subWidth = vCateInfo.multichart.chartWidth;
					}
					
					// series별 스타일
					if(selectedStyle != null){
						subWidth = selectedStyle.chartWidth;
					}
					$subContainer.css("width",subWidth + '%');
					$subContainer.addClass("chartContainerSub");
					
					//$chartContainer.append($subContainer);
					$lineContainer.append($subContainer);
				}
				
				
				vCols.push({
					containerId : subId,
					filter:[{col:vCateInfo.multichart.splitCol,val:col[vCateInfo.multichart.splitCol]}]
					//chartType: vCateInfo.chartType != undefined ? vCateInfo.chartType  : 'column'
				});
				
			});
			
		}
		else{
			//단일차트인경우
			vCols = [];
			var subId = chartContainerId + '_' + '0';
			if($("[id='"+subId+"']" ).length == 0){
				var $subContainer = $(document.createElement( "span" ));
				$subContainer.attr("id",subId);
				$subContainer.attr("data_src",pDataSrc);
				//css
				//height
				var subHeight = 600;
				//$subContainer.css("height",subHeight + 'px');
				//width
				$subContainer.css("width", '100%');
				$subContainer.addClass("chartContainerSub");
				
				$chartContainer.append($subContainer);
				vCols.push({
					containerId : subId,
					filter:[]
				});
			}
		}
		
		$.each(vCols,function(i,col){
			var chart_title = "";
			
			
			
			var filteredDataSub = dataFilter(filteredData,col.filter);
			var series = {};
			if(vCateInfo.fn_data != undefined){
				series = vCateInfo.fn_data.call(this,filteredDataSub);
			}else{
				series = getDrillDownDataSeries2(
						'',
						filteredDataSub ,
						vCateInfo.xOderbyCols , //groupby를 안하므로 length:0
						[], //filter
						[{col:vCateInfo.yCol , convert:'y',isnull:0}], //convert
						vCateInfo.categoryCols[vCateInfo.categoryCols.length-1] , 
						//vCateInfo.categoryCols[0] ,
						'CNT',
						vCateInfo.seriesCol,
						{isGroupby: false}
				);
				
				
				//EI-1057 No.5 Raw data table 을 기존 DVT 레포트 처럼 보이게 Raw data를 아래와 같이 나타내 주면 이거 보기 힘듭니다.
				series.categoryOrigin = series.category;
				
				series.category = [];
				$.each(series.series,function(i,s){
					//sortObjects(s.data,[['y','desc']]);
				});
				$.each(series.series[0].data,function(i,d){
					var colvalues = [];
					$.each(vCateInfo.categoryCols,function(){
						colvalues.push(d[this]);
					});
					series.category.push(colvalues);
				});
				
				
				//카테고리 만들기
				var category1 = [];
				
				$.each(series.category,function(index,c){
					category1.push(c);
				});
				var category2 = makeGroupCategory(category1);
				series.category = category2;
				
				///Start chart Type 2017.11.13
			    var chartType = 'column';
			    if(vCateInfo.chartType != undefined ){
					chartType = vCateInfo.chartType;
				}
			    if(vCateInfo.multichart != undefined && vCateInfo.multichart.chartType != undefined){
			    	if(vCateInfo.multichart.chartType[this.filter[0].val] != undefined)
						chartType = vCateInfo.multichart.chartType[this.filter[0].val];
				}
				
				///End chart Type 2017.11.13
				
				/** Start addSeries **/
				var yAxisTitle = "";
				if(vCateInfo.yAxisTitle != undefined){
					yAxisTitle = vCateInfo.yAxisTitle;
				}else{
					if(series.series[0].data[0].yAxisTitle != undefined )
		        		yAxisTitle = series.series[0].data[0].yAxisTitle;
		        	else if(series.series[0].data[0].FIELD != undefined)
		        		yAxisTitle =  series.series[0].data[0].FIELD;
		        	else
		        		yAxisTitle =  "";
				}
				
				if(vCateInfo.multichart != undefined && vCateInfo.multichart.yAxisTitle != undefined){
					yAxisTitle = vCateInfo.multichart.yAxisTitle[this.filter[0].val];
				}
				
				
				
				var yAxis = [{
			        	min: 0,
			            title: {
			            	text: yAxisTitle
			            }
			            //,tickInterval:5
			    }];
			    
			    
				
				if(vCateInfo.addSeries != undefined && vCateInfo.addSeries.length > 0){
					$.each(vCateInfo.addSeries,function(addSIndex,addSeries){
						//01. 새로운 series 생성
						var addS = {
							id: this.name,
							name: this.name,
							type: this.type,
							data: []
						};
						if(this.yAxis != undefined){
							yAxis.push(this.yAxis);
							//EI-1057 No.2: (반영예정) 추세선의 기준선 위치 고정 : 중간을 0%로 해서 고정. 기준으로 오르락 변경되는데, 잘 못 이해할 수 있겠네요.
							addS.yAxis = this.yAxis;
						}					
						var seriesResult = this.seriesFunction.apply(addS, series.series )
						//03. add series
						if(seriesResult)
							series.series.push(addS);
					});
				}
				
				/** End addSeries **/
			}
			
			
			//Start DrawChart
			var legendVal = $("[name=optLegend]:checked").val();
			var isLegend = false;
			if(legendVal == "on")
				isLegend = true;
			var $subjectDiv = $(document.createElement( "div" ));
			$subjectDiv.attr("id",this.containerId+'_highChart');
			$subjectDiv.css("width","100%");
			$subjectDiv.css("height","100%");
			$("[id='"+ this.containerId +"']" ).append($subjectDiv);
			
			//if($("[id='"+ this.containerId +"']" ).highcharts() != undefined) $("[id='"+this.containerId+"']" ).highcharts().destroy();
			if($("[id='"+ this.containerId +"_highChart']" ).highcharts() != undefined) $("[id='"+this.containerId+"_highChart']" ).highcharts().destroy();
			
			var chartOption = {};
			if(vCateInfo.fn_chartOption != undefined){
				chartOption = vCateInfo.fn_chartOption.call(this,series);
			}else{				
				chartOption = {
						 exporting: {
						        chartOptions: { // specific options for the exported image
						            plotOptions: {
						                series: {
						                    dataLabels: {
						                        enabled: true,
						                        fontSize: '8px',
						                        fontWeight: 'normal'
						                    }
						                }
						            }
						        },
						        fallbackToExportServer: false
						    },
				        chart: {
				            type: chartType,
				            zoomType:'x',
				            height: 400
				            //,animation: false
				            //,width: '100%'
				        },
				        credits: {
			                enabled: false
			            },
				        title: {
				        	//text:pDataSrc.split(".")[0],
				        	//text:pDataSrc,
				        	text: chart_title,
			            	useHTML: true
				        },
				        subtitle: {
				            text: ''
				        },	     
				        legend:{
				        	enabled: isLegend
				        },
				        xAxis:{
				        	categories: series.category,
				        	categoriesGroup: series.category,
				        	categoriesOrigin: series.categoryOrigin ,
				        	labels:{
				        		groupedOptions:[{
				        			rotation: 0
				        		},{
				        			rotation: 0
				        		}],
				        		rotation:0,
				        		//formatter: function() {
								//	
				        		//}
				        	} 
				        },
				        yAxis: yAxis,
				        
				        tooltip: {
				            valueDecimals: 0,
				          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
			                //headerFormat:'',
				            pointFormat: "<span style='color:#303030'>{series.name}</span>: <b>{point.y:."+decimalPoint+"f}</b> <br/>",
				            shared: true,
				            enabled: true
				        },
				        //legend: legend,
				        plotOptions: {
				            column: {
				            	grouping: true,
				            	borderWidth: 0,
				            	cursor: 'pointer' ,
				            	
				            	point:{	                	
				                	events:{
				                		click: function(e){
//		 		                			e.point.select(true,false);
//			 	                			if(this.drillSeries){
//			 	                				setChart(this.drillSeries);
//			 	                			}else{
//			 	                				//var phase = this.category.parent.parent.name;
//			 		                			//var cause = this.category.name;
//			 		                			//var data = "";
//			 		                			//$("#phase").val(phase);
//			 		                			//$("#discoveredFrom").val(cause);
//			 		                			gotoDetail(this.PHASE,this.DISCOVERED_FROM_PURE);
//			 	                			}
				                			
				                			
				                		}
				                	}
				                },
				                //stacking: 'percent',
				                marker: {
				                    lineColor: '#666666',
				                    enabled: true
				                },
				                dataLabels: {
				                    enabled: true,
				                    allowOverlap: true,
				                    //useHTML: true,
				                    //format:'{point.y:.0f} ({point.percentage:.0f}%)'
				                    format:'{point.y:.'+decimalPoint+'f}',
				                    //x: 10,
				                   /*  formatter:function(){
				                    	
				                    }, */
				                    color: 'black'
				                },
				                //enableMouseTracking: true,
				                events:{
				                	click: function(e){
				                		//gotoDetail(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
			                		} 
				                }
				                	
				            }
				        },	        
				        series: series.series
				    };
			}
			
			$("[id='"+this.containerId+"_highChart']" ).highcharts(chartOption,function(chart){
		    	
			 });//chart end
			 
			 
			 
			//*****  Start makeTable ******//
			if(vCateInfo.fn_drawGrid != undefined){
				
			}else{
//				01. subContainer
				//var gridId =  chartContainerId.split(".")[0].replace(/[\s]/gi,"") + 'Grid';
				var $subChart = $("[id='"+ this.containerId + "']" );
				var gridId =  this.containerId.replace(/[\s]/gi,"").replace(/[\.]/gi,"_") + 'Grid';
				var $subGrid = $(document.createElement( "div" ));
				$subGrid.attr("id",gridId);
				$subGrid.css("width","100%");
				$subGrid.addClass("chartContainerSub");
				//		01.01. container height + 
				var chartHeight = $subChart.height();
				var gridHeight = 400;
				//$subChart.height(chartHeight + gridHeight);
				//$subGrid.height(gridHeight);
				$subChart.append($subGrid);
				//		01.02.subDivs
				//			01.02.01. table
				var tableId =  gridId + 'Table';
				var $subTable = $(document.createElement( "table" ));
				$subTable.attr("id",tableId);
				$subGrid.append($subTable);
				//				01.02.02. pager
				var pagerId =  gridId + 'Pager';
				var $subPager = $(document.createElement( "div" ));
				$subPager.attr("id",pagerId);
				$subGrid.append($subPager);
				
				
				//		02. option
				var gridOpt = {
						datatype: 'local',
						styleUI : 'Bootstrap',
						//data: this.gridInfo.sourceData,
						//colModel: this.gridInfo.colModel,
//	 					rowNum:100000,
						rowNum:10,
						//rowList:[10,20,30],
						pager: $subPager , //'#' + pagerId,
						sortable: true,
						viewrecords: true,
						rownumbers: true, // show row numbers
				        multiSort:true,
				    	//sortname : 'FIELD,SPEC,FIRMWARE1,QUEUE_DEPTH',
				        //multiselect: true,
				        //multiboxonly:true,
				        //sortname: 'orderdate asc, price',
				        //sortorder: 'asc',           
				        //caption: pDataSrc.split(".")[0]
				        caption: 'Data'
						, width: '100%'
				        , height:280
				        , hidegrid:true
				        , hiddengrid: false
						//, editurl:'clientArray'
						//, cellEdit: true
						, forceFit : false
						//, cellsubmit: 'clientArray'
						//,cellsubmit: '/dashboard/performanceJson.html'
						// , afterEditCell: function (id,name,val,iRow,iCol){
						
						// }
						// , afterSaveCell : function(rowid,name,val,iRow,iCol) {
						// 	if(name == 'IS_GOOD_DATA') {
						// 		theGrid.jqGrid('setRowData',rowid,{EDIT_MODE:'U'});
						// 	}
						// }
						,iconSet: "fontAwesome"
						,onInitGrid: function () {
					        var p = $(this).jqGrid("getGridParam");
					        // save names of columns in custom option of jqGrid
					        p.originalColumnOrder = $.map(p.colModel, function (cm) {
					            return cm.name;
					        });
					        //alert(JSON.stringify(p.originalColumnOrder));
					    }
					    , gridComplete: function () {
					    	if($("#report").val() != "Y"){
					    		//copybutton 생성
						    	var grid = $(this).jqGrid();
						    	var captionBar = $("#" + gridId).find(".ui-jqgrid-caption");
						    	var copyBtn = $(document.createElement( "a" ));					    	
						    	copyBtn.attr("role","link");
						    	copyBtn.addClass("ui-jqgrid-titlebar-close HeaderButton");
						    	copyBtn.attr("title","copy table");
						    	copyBtn.css("right","15px");
						    	captionBar.append(copyBtn);
						    	var imgspan =  $(document.createElement( "span" ));
						    	imgspan.addClass("glyphicon ui-jqgrid-headlink table-copy");
						    	copyBtn.append(imgspan);
						    	
						    	copyBtn.zclip({
					    		  path: '/dashboard/js/jquery-zclip-master/ZeroClipboard.swf',
					    		  copy: function(){
					    			  var copy = [];
					    			  var $copyTable = $subTable.clone();
					    			  var $copyGrid = $subGrid.clone();
					    			  $.each($subGrid.find(".ui-jqgrid-htable").find("th"),function(i,th){
					    				  var text = $(th).text();
					    				  var $td = $($copyTable.find("tr:first").find("td")[i]);
					    				  $td.text(text);
					    			  });
					    			  //return $copyTable[0].outerHTML;
					    			  copy.push($copyTable[0].outerHTML);
					    			  //copy.push($subGrid[0].outerHTML);
					    		      return copy.join("");
					    		  },
					    		  afterCopy:function(){
					    			  $("#dialog-confirm").html("Table Copied !");
		                  			  $("#dialog-confirm").dialog({
		                  			    resizable: false,
		                  			    modal: true,
		                  			    title: "Table Copied !",
		                  			    height: 0,
		                  			    width: 150
		                  			  });	                  			  
		                  			  $("#dialog-confirm").hide();
		                  				
					    		  }
					    		});
						    	
					    	}
					    	
					    }
				};
				//		03.01. option column
				gridOpt.colModel = [{name: 'Series',index: 'Series',width: '210px'}];
				if(pDataSrc.match(/Mixed_/gi) != null)
					gridOpt.colModel[0].width = '45px';
				
				// series col을 지정한다.
				if(vCateInfo.gridSeriesColWidth != undefined && vCateInfo.gridSeriesColWidth != ''){
					gridOpt.colModel[0].width = vCateInfo.gridSeriesColWidth;
				}
				
				//EI-1057 No.5 Raw data table 을 기존 DVT 레포트 처럼 보이게 Raw data를 아래와 같이 나타내 주면 이거 보기 힘듭니다.
				var chart = $("[id='"+this.containerId+"_highChart']" ).highcharts();
				$.each(chart.xAxis[0].categories,function(icategory,category){
					//var gridcol = {name: category,index: category};
					var gridcol = {name: category.name ,index: category.name,formatter: 'number', align: 'right',width: '110px'};
					if(vCateInfo.gridColWidth != undefined){
						gridcol.width = vCateInfo.gridColWidth; 
					}
					gridOpt.colModel.push(gridcol);
				});

				//EI-1057 No.5 Raw data table 을 기존 DVT 레포트 처럼 보이게 Raw data를 아래와 같이 나타내 주면 이거 보기 힘듭니다.
				gridOpt.data = [];
				$.each(chart.series,function(iseries,se){
					var griddata = {Series: se.name};
					$.each(se.data,function(idata,data){
						griddata[data.category.name] = data.y;
//	 					$.each(data,function(c,v){
//	 						if(c == vCateInfo.categoryCols[vCateInfo.categoryCols.length-1]){
//	 							griddata[v] = data.y;
//	 						}
//	 					});
					});
					
					gridOpt.data.push(griddata);
				});
				//		04. make table
				"use strict";
				$subTable.jqGrid(gridOpt);
				//$subTable.jqGrid('setFrozenColumns');
				//$subTable.jqGrid('destroyFrozenColumns');
				//***** End  makeTable ******//
				
				//var vChart = $("[id='"+this.containerId+"_highChart']" ).highcharts();
				//vChart.reflow();
			} // default grid
			
			 
		});	// loop end
				
		//$("[id='"+chartContainerId+"']" ).css("display","none");
		
		// zclip copy를 활성화 하기위해.
		//$("[id='"+chartContainerId+"']" ).trigger('resize');
		//$("[id='"+chartContainerId+"']" ).trigger('resize');
		//$(".nav-tabs a[target='" + pDataSrc + "']").click();
	}
	
	
	function makeGroupCategory(incoming){
	    
	    function recurseKeys(o) {
	        var arr = [],
	            k = Object.getOwnPropertyNames(o),
	            i, c;
	        for (i = 0; i < k.length; ++i) {
	            if (Object.getOwnPropertyNames(o[k[i]]).length)
	                c = {name: k[i]}, c['categories'] = recurseKeys(o[k[i]]);
	            else
	                c = k[i];
	            arr.push(c);
	        }
	        return arr;
	    }
	    
	    var i, j, o = {}, c, k;

	    for (i = 0; i < incoming.length; ++i) {
	        c = o;
	        for (j = 0; j < incoming[i].length; ++j) {
	            k = incoming[i][j];
	            if (!c[k]) c[k] = {};
	            c = c[k];
	        }
	    }

	    o = recurseKeys(o);
	    
	    return o;
	}
	
	var makeCategoryHms = function (){
		var cateroryHmsDefect = {
				
				chartType:'column',
				category:'defect_lists.csv',
				calculateCols:[
					
				],
				filters:[
					//{col:'FIELD',val:'IOps'}
				],
				xOderbyCols:[],
				categoryCols:['MEASURE'],
				yCol:'CNT',
				seriesCol:{cd:'FIELD',name:'FIELD'},
				multichart:{
					enabled:false,
					splitCol:'FIELD'
				},
				gridColWidth: '160px',
				orderby: 10
		};		
		categoryInfo.push(cateroryHmsDefect);
		
		var cateroryHmsErase = {				
				category:'erase_count.csv',				
				orderby: 20,
				uiSchema: {
					containerId:'erase_count',
					type:'HorizontalLayout',
					label:'',
					elements:[ 
						{
							containerCss:[
								{code: 'display', value:''}
								,{code: 'float', value:'left'}
								,{code: 'height', value:'600px'}
								,{code: 'width', value:'100%'}
							],					
							type:'chart',
		   	            	id: 'chart_erase_count_highChart',
		   	            	label:'',
		   	            	width: '100%',
		   	            	//height:'800px',
		   	            	data: function(){
			            		var rtn = {};
								
			            		$.each(dataList, function(){
			            			try{
			            				var dateSplit = this.DT.split("/");
				            			var utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2],dateSplit[3],dateSplit[4],dateSplit[5]);
				            			this.dtUtc = utcdt;	
			            			}catch(e){
			            				var err = e;
			            			}
			            			
			            			
			            		});
			            		
			            		var series = {series: []};
			            		var series1 = getDrillDownDataSeries2(
			            				'',
			            				dataList ,
			            				['CAPACITY','DT'] , //groupby
			            				[], //filter
			            				[{col: 'dtUtc' , convert:'x'},{col: 'Avg' , convert:'y'}], //convert
			            				'' ,  //category
			            				'Avg',
			            				{cd:'CAPACITY', name:'CAPACITY'},
			            				{isGroupby: false}
			            		);
			            		
			            		$.each(series1.series,function(i,s){
									if(i > 0) s.visible = false;
									s.type = 'line';
									s.id = s.name + '_avg';
									s.zIndex = 1;
									s.marker = {
										//fillColor: 'white',
							            lineWidth: 2
									};
									s.color = Highcharts.defaultOptions.colors[i];
			            			series.series.push(s);	
			            		});
			            		
			            		var series2 = getDrillDownDataSeries2(
			            				'',
			            				dataList ,
			            				['CAPACITY','DT'] , //groupby
			            				[], //filter
			            				[{col: 'dtUtc' , convert:'x'},{col: 'Max' , convert:'high'},{col: 'Min' , convert:'low'}], //convert
			            				'' ,  //category
			            				'Avg',
			            				{cd:'CAPACITY', name:'CAPACITY'},
			            				{isGroupby: false}
			            		);
				            		
			            		$.each(series2.series,function(i,s){
			            			if(i > 0) s.visible = false;
			            			var avgSeries = alasql('select * from ? where name="'+s.name+'" ',[series1.series]);
			            			if(avgSeries.length > 0){
										s.type= 'arearange';	            				
			            				s.linkedTo = avgSeries[0].id;
			            				s.lineWidth= 0;
			            				s.color = avgSeries[0].color;
			            				s.zIndex = 0;
			            				s.fillOpacity=  0.3;
			            			}
			            				
			            			series.series.push(s);	
			            			
			            		});
			            		//////////// xcategory?
			            		var xAxis = {
			            			type: 'datetime'	
			            			, dateTimeLabelFormats:{
			            				
			            				second: '%Y.%m.%e %H:%M:%S',
			            				minute: '%Y.%m.%e %H:%M',
			            				hour: '%Y.%m.%e %H',
			            				day: '%Y.%m.%e',
			            				week: '%Y.%m.%e',
			            				month: '%Y.%m',
			            				year: '%Y'
			            			},
				            		labels: {
				                        rotation: -45
				                        
				                    }
			            		};
			            		
			            		rtn.xAxis = xAxis;
			            		
			            		// return start
			            		rtn.series = series;
			            		return rtn;
		   	            	},
		   	            	options: function(){
		   	            		var option = {
			            				chart:{
			            					//type: 'bubble'
			            					//, plotBorderWidth: 1
			            			        zoomType: 'xy'
			            				}
			            				, legend: {
			            			        enabled: true
			            			    }
			            				, title: {
			            			        text: ' '
			            			    }
			            			    ,tooltip: {
			            			    	crosshairs: false,
			            			    	shared: false,
//		 	            			        useHTML: true,
			            			        headerFormat: '',
//		 	            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
//		 	            			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
//		 	            			            '<tr><th>group name:</th><td>{point.ID}: {point.GROUP_NAME}</td></tr>' +
//		 										'<tr><th>min:</th><td>{point.MIN}</td></tr>' +
//		 										'<tr><th>max:</th><td>{point.MAX}</td></tr>' +
//		 	            			            '<tr><th>avg:</th><td>{point.y}</td></tr>',
//		 	            			        footerFormat: '</table>',
											pointFormatter: function(){
												if(this.series.type=='line'){
													var rtn = '';
													rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
													rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
													rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
													rtn += '<br><b>Time:</b>' + this.DT_STR;
													rtn += '<br><b>Average:</b>' + Highcharts.numberFormat(this.Avg ,0,'.',',') ;
													rtn +=  '<br><b>Min:</b> ' +  Highcharts.numberFormat(this.Min ,0,'.',',');
													rtn +=  '<br><b>Max:</b> ' + Highcharts.numberFormat(this.Max ,0,'.',',');
													return rtn;
												}else if(this.series.type == 'arearange'){
													var rtn = '';
													
													rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
													rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
													rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
													rtn += '<br><b>Time:</b>' + this.DT_STR;
													rtn += '<br><b>Average:</b>' + Highcharts.numberFormat(this.Avg ,0,'.',',') ;
													rtn +=  '<br><b>Min:</b> ' +  Highcharts.numberFormat(this.Min ,0,'.',',');
													rtn +=  '<br><b>Max:</b> ' + Highcharts.numberFormat(this.Max ,0,'.',',');
													
													return rtn;
														
												}
											},
			            			        followPointer: true
			            			    }
			            				
			            		};
			            		
			            		return option;
			            	}
		   	            	
		   	            }
						
					]								
			}
			//uiSchema end
		};		
		categoryInfo.push(cateroryHmsErase);
		
		var cateroryHmsSmart = {				
				category:'smart_attributes.csv',				
				orderby: 30,
				calculateCols:[
				],
				filters:[
					
				],
				//xOderbyCols:[],
				//categoryCols:],
				//yCol:'',
				//seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
				multichart:{
					enabled:true,
					splitCol:'ATT',
					chartWidth: 100 , // percent 로 표시
					oneLineChatNum: 1
				}
				, gridColWidth: '160px'
				, fn_drawGrid : function(){
					
				}
				, fn_data : function(data){
					var series = {};
					$.each(data, function(){
            			try{
            				var dateSplit = this.DT.split("/");
	            			var utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2],dateSplit[3],dateSplit[4],dateSplit[5]);
	            			this.dtUtc = utcdt;	
            			}catch(e){
            				var err = e;
            			}
            			
            			
            		});
					series = getDrillDownDataSeries2(
            				'',
            				data ,
            				['CAPACITY','DT'] , //groupby
            				[], //filter
            				[{col: 'dtUtc' , convert:'x'},{col: 'VALUE' , convert:'y'}], //convert
            				'' ,  //category
            				'VALUE',
            				{cd:'CAPACITY', name:'CAPACITY'},
            				{isGroupby: false}
            		);
					
					return series;
					
				}
				, fn_chartOption: function(series){
					var option = {
            				chart:{
            					type: 'line',
            					//, plotBorderWidth: 1
            			        zoomType: 'xy'
            				},
							credits: {
				                enabled: false
				            }
            				, legend: {
            			        enabled: true
            			    }
            				, title: {
            			        text: series.series[0].data[0].ATT_NAME
            			    }
            				, xAxis : {
		            			type: 'datetime'	
		            			, dateTimeLabelFormats:{
		            				second: '%Y.%m.%e %H:%M:%S',
		            				minute: '%Y.%m.%e %H:%M',
		            				hour: '%Y.%m.%e %H',
		            				day: '%Y.%m.%e',
		            				week: '%Y.%m.%e',
		            				month: '%Y.%m',
		            				year: '%Y'
		            			},
			            		labels: {
			                        rotation: -45
			                    }
            				}	
            			    ,tooltip: {
            			    	crosshairs: false,
            			    	shared: false,
//	            			        useHTML: true,
            			        headerFormat: '',
//	            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
//	            			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
//	            			            '<tr><th>group name:</th><td>{point.ID}: {point.GROUP_NAME}</td></tr>' +
//										'<tr><th>min:</th><td>{point.MIN}</td></tr>' +
//										'<tr><th>max:</th><td>{point.MAX}</td></tr>' +
//	            			            '<tr><th>avg:</th><td>{point.y}</td></tr>',
//	            			        footerFormat: '</table>',
								pointFormatter: function(){
									if(this.series.type=='line'){
										var rtn = '';
										rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
										rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
										rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
										rtn += '<br><b>Time:</b>' + this.DT_STR;
										rtn += '<br><b>Value:</b>' + Highcharts.numberFormat(this.VALUE ,0,'.',',') ;
										return rtn;
									}else if(this.series.type == 'arearange'){
										var rtn = '';
										rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
										rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
										rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
										rtn += '<br><b>Time:</b>' + this.DT_STR;
										rtn += '<br><b>Value:</b>' + Highcharts.numberFormat(this.VALUE ,0,'.',',') ;
										
										return rtn;
											
									}
								},
            			        followPointer: true
            			    }
            			    ,series: series.series
            				
            		};
            		
            		return option;
				}
		};		
		//categoryInfo.push(cateroryHmsSmart);
		
		// 맨위에 multi select box 
		var cateroryHmsSmartSelect = {				
				category:'smart_attributes.csv',				
				orderby: 30,
				uiSchema: {
					containerId:'smart_attributes',
					type:'Vertical',
					label:'',
					elements:[
						{
							containerCss:[
								{code: 'margin-top', value:'10px'}			
							],			
							type:'HorizontalLayout',
							label:'',
							elements:[ 
								{
									type:'SearchHeader',
									id: 'attributeHead',
									name: 'attributeHead',
									label:'',
									text:'Attributes: ',
									width: '80px'
								},
								{
									containerCss:[
									],					
									type:'multiCombo',
				   	            	id: 'smart_attributes_select',
				   	            	name: 'smart_attributes_select',		   	            	
				   	            	label:'',
				   	            	text:'Attribute',
				   	            	width: '200px',
				   	            	//height:'800px',
				   	            	data: function(){
				   	            		var rtnList = [];
				   	            		var attList = alasql('select distinct Number(ATT) att, ATT || ". " || ATT_NAME att_name from ?  order by 1' ,[dataList]);
				   	            		rtnList = attList;
					            		return rtnList;
				   	            	},
				   	            	options: {
				   	            		cd:'att',
										name:'att_name'
					            	},
					            	events: {
										change: function(){
											
										}
									}
				   	            	
				   	            },
					   	        {
				   	            	
				   	            	containerCss:[
		  								{code: 'margin-left', value:'10px'}
		  							],
									type:'Button',
									id: 'btnSearchSmart',
									name: 'btnSearchSmart',
									label:'Search Smart',
									//width: '50px',
									cls: 'btn_txt btn_type_e btn_color_a',
									events:{
										click : function(){
											$("#loader").show();
											setTimeout(function(){
												fn_makeSmart();
												$("#smart_attributes_contentsContainer").find("div").each(function(){
													var chart = $(this).highcharts();
												    if( chart != undefined){
														chart.reflow();
												    }
												});
												$("#loader").hide();
											},50);
										}
									}
								}
							]
						},// end of select
						{
							containerCss:[
							],			
		   	            	type:'dummy',
		   	            	id:'smart_attributes_contents',
		   	            	name:'smart_attributes_contents',
		   	            	label:''
		   	            }
					]
													
			}
			//uiSchema end
		};		
		categoryInfo.push(cateroryHmsSmartSelect);
		
		var cateroryHmsPerformanceSelect = {				
				category:'performance_data.csv',				
				orderby: 40,
				uiSchema: {
					containerId:'performance_data',
					type:'Vertical',
					label:'',
					elements:[
						{
							containerCss:[
								{code: 'margin-top', value:'10px'}			
							],			
							type:'HorizontalLayout',
							label:'',
							elements:[ 
								{
									type:'SearchHeader',
									id: 'performanceHead',
									name: 'performanceHead',
									label:'',
									text:'Field: ',
									width: '80px'
								},
								{
									containerCss:[
									],					
									type:'multiCombo',
				   	            	id: 'performance_select',
				   	            	name: 'performance_select',		   	            	
				   	            	label:'',
				   	            	text:'Field',
				   	            	width: '250px',
				   	            	//height:'800px',
				   	            	data: function(){
				   	            		var rtnList = [];
				   	            		rtnList.push({code:'Execution Time (seconds)'});
				   	            		rtnList.push({code:'Avg latency (uSec)'});
				   	            		rtnList.push({code:'Max latency (uSec)'});
				   	            		rtnList.push({code:'IO/Sec'});
				   	            		rtnList.push({code:'Cmd count'});
				   	            		rtnList.push({code:'Rate (MB/Sec)'});
				   	            		rtnList.push({code:'QoS'});
				   	            		
					            		return rtnList;
				   	            	},
				   	            	options: {
				   	            		cd:'code',
										name:'code'
					            	},
					            	events: {
										change: function(){
											
										}
									}
				   	            	
				   	            },
					   	        {
				   	            	
				   	            	containerCss:[
		  								{code: 'margin-left', value:'10px'}
		  							],
									type:'Button',
									id: 'btnSearchPerformance',
									name: 'btnSearchPerformance',
									label:'Search Performance',
									//width: '50px',
									cls: 'btn_txt btn_type_e btn_color_a',
									events:{
										click : function(){
											$("#loader").show();
											setTimeout(function(){
												fn_makePerformance();
												$("#performance_contentsContainer").find("div").each(function(){
													var chart = $(this).highcharts();
												    if( chart != undefined){
														chart.reflow();
												    }
												});
												$("#loader").hide();
											},50);
										}
									}
								}
							]
						},// end of select
						{
							containerCss:[
							],			
		   	            	type:'dummy',
		   	            	id:'performance_contents',
		   	            	name:'performance_contents',
		   	            	label:''
		   	            }
					]
													
			}
			//uiSchema end
		};		
		categoryInfo.push(cateroryHmsPerformanceSelect);
		
	};
	
	
	
	function fn_makeSmart(){
		
		var parentEl = $("#smart_attributes_contentsContainer");
		parentEl.html("");
		
		var atts1 = [];
		var atts = $("#smart_attributes_select").val();
		if(atts == null)
			atts = [];
		var paramstr = "&sqlid=dashboard.hms.smart.datalist.by.atts&attributes=xxx";
		$.each(atts,function(i,att){
			var dataCnt = alasql('select count(*) cnt from ? where ATT = "'+att+'"',[dataListSmart]);
			var data = [];
			if(dataCnt[0].cnt == 0 ){
				atts1.push(att);
				paramstr += "&attributes="+att;
			}
		});
		
		
		var data = [];
		var parameter = {};	
		//parameter.sqlid = "dashboard.hms.smart.datalist.by.atts";
		//parameter.attribute = att;		
		if(atts1.length > 0){
			$.ajax({
				url : "/dashboard/performanceDataListJson.html",
				data: $("#form").serialize() + paramstr,
				async: false ,
				success : function(responseData){
					dataListSmart = $.merge(dataListSmart, responseData.dataList );	
					data = responseData.dataList
				}
			});
		}
		
		
		$.each(atts,function(i,att){
			// 1. create chart element
			var elid = "chart_smart_attributes_contents_"+att;
			var el = $("#" + elid);
			if(el.length == 0){
				el = $(document.createElement( "div" ));
				el.attr("id",elid);
				
				parentEl.append(el);
			}
			// 2. data
			var series = {};
			var data = alasql('select * from ?  where ATT="'+att+'"',[dataListSmart]);
			$.each(data, function(){
          			try{
          				var dateSplit = this.DT.split("/");
           			var utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2],dateSplit[3],dateSplit[4],dateSplit[5]);
           			this.dtUtc = utcdt;	
          			}catch(e){
          				var err = e;
          			}
          		});
			series = getDrillDownDataSeries2(
       			'',
      				data ,
      				['CAPACITY','DT'] , //groupby
      				[], //filter
      				[{col: 'dtUtc' , convert:'x'},{col: 'VALUE' , convert:'y'}], //convert
      				'' ,  //category
      				'VALUE',
      				{cd:'CAPACITY', name:'CAPACITY'},
      				{isGroupby: false}
       		);
			// 3. draw chart
			var option = {
       				chart:{
       					type: 'line',
       					//, plotBorderWidth: 1
       			        zoomType: 'xy',
       			        //width: '100%',
       			        height:'600'
       				},
					credits: {
		                enabled: false
		            }
       				, legend: {
       			        enabled: true
       			    }
       				, title: {
       			        text: series.series[0].data[0].ATT + '. ' + series.series[0].data[0].ATT_NAME
       			    }
       				, xAxis : {
            			type: 'datetime'	
            			, dateTimeLabelFormats:{
            				second: '%Y.%m.%e %H:%M:%S',
            				minute: '%Y.%m.%e %H:%M',
            				hour: '%Y.%m.%e %H',
            				day: '%Y.%m.%e',
            				week: '%Y.%m.%e',
            				month: '%Y.%m',
            				year: '%Y'
            			},
	            		labels: {
	                        rotation: -45
	                    }
       				}	
       			    ,tooltip: {
       			    	crosshairs: false,
       			    	shared: false,
       			        headerFormat: '',
						pointFormatter: function(){
							if(this.series.type=='line'){
								var rtn = '';
								rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
								rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
								rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
								rtn += '<br><b>Time:</b>' + this.DT_STR;
								rtn += '<br><b>Value:</b>' + Highcharts.numberFormat(this.VALUE ,0,'.',',') ;
								return rtn;
							}else if(this.series.type == 'arearange'){
								var rtn = '';
								rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
								rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
								rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
								rtn += '<br><b>Time:</b>' + this.DT_STR;
								rtn += '<br><b>Value:</b>' + Highcharts.numberFormat(this.VALUE ,0,'.',',') ;
								
								return rtn;
									
							}
						},
       			        followPointer: true
       			    }
       			    ,series: series.series
       				
       		};
			
			el.highcharts(option,function(chart){
		    	
			 });//chart end
				
			 
			
			
		}); // loop end
		
		
	}
	
	
	
    function fn_makePerformance(){
		
		var parentEl = $("#performance_contentsContainer");
		parentEl.html("");
		
		var atts1 = [];
		var atts = $("#performance_select").val();
		if(atts == null)
			atts = [];
		var paramstr = "&sqlid=dashboard.hms.performance.datalist.by.field&field=xxx";
		$.each(atts,function(i,att){
			var dataCnt = alasql('select count(*) cnt from ? where FIELD = "'+att+'"',[dataListPerformance]);
			var data = [];
			if(dataCnt[0].cnt == 0 ){
				atts1.push(att);
				paramstr += "&field="+att;
			}
		});
		
		
		var data = [];
		var parameter = {};	
		//parameter.sqlid = "dashboard.hms.smart.datalist.by.atts";
		//parameter.attribute = att;		
		if(atts1.length > 0){
			$.ajax({
				url : "/dashboard/performanceDataListJson.html",
				data: $("#form").serialize() + paramstr,
				async: false ,
				success : function(responseData){
					dataListPerformance = $.merge(dataListPerformance, responseData.dataList );	
					data = responseData.dataList
				}
			});
		}
		
		
		$.each(atts,function(i,att){
			// 1. create chart element
			var elid = "chart_performance_contents_"+att;
			var el = $("[id='"+elid+"']");
			if(el.length == 0){
				el = $(document.createElement( "div" ));
				el.attr("id",elid);
				
				parentEl.append(el);
			}
			// 2. data
			var series = {};
			var data = alasql('select * from ?  where FIELD="'+att+'"',[dataListPerformance]);
			$.each(data, function(){
          			try{
          				var dateSplit = this.DT.split("/");
           			var utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2],dateSplit[3],dateSplit[4],dateSplit[5]);
           			this.dtUtc = utcdt;	
          			}catch(e){
          				var err = e;
          			}
          		});
			series = getDrillDownDataSeries2(
       			'',
      				data ,
      				['CAPACITY','DT'] , //groupby
      				[], //filter
      				[{col: 'dtUtc' , convert:'x'},{col: 'VALUE' , convert:'y'}], //convert
      				'' ,  //category
      				'VALUE',
      				{cd:'CAPACITY', name:'CAPACITY'},
      				{isGroupby: false}
       		);
			// 3. draw chart
			var option = {
       				chart:{
       					type: 'line',
       					//, plotBorderWidth: 1
       			        zoomType: 'xy',
       			        //width: '100%',
       			        height:'600'
       				},
					credits: {
		                enabled: false
		            }
       				, legend: {
       			        enabled: true
       			    }
       				, title: {
       			        text: series.series[0].data[0].FIELD 
       			    }
       				, xAxis : {
            			type: 'datetime'	
            			, dateTimeLabelFormats:{
            				second: '%Y.%m.%e %H:%M:%S',
            				minute: '%Y.%m.%e %H:%M',
            				hour: '%Y.%m.%e %H',
            				day: '%Y.%m.%e',
            				week: '%Y.%m.%e',
            				month: '%Y.%m',
            				year: '%Y'
            			},
	            		labels: {
	                        rotation: -45
	                    }
       				}	
       			    ,tooltip: {
       			    	crosshairs: false,
       			    	shared: false,
       			        headerFormat: '',
						pointFormatter: function(){
							if(this.series.type=='line'){
								var rtn = '';
								rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
								rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
								rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
								rtn += '<br><b>Time:</b>' + this.DT_STR;
								rtn += '<br><b>'+ this.FIELD +':</b>' + Highcharts.numberFormat(this.VALUE ,0,'.',',') ;
								return rtn;
							}else if(this.series.type == 'arearange'){
								var rtn = '';
								rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
								rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
								rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
								rtn += '<br><b>Time:</b>' + this.DT_STR;
								rtn += '<br><b>'+ this.FIELD +':</b>' + Highcharts.numberFormat(this.VALUE ,0,'.',',') ;
								
								return rtn;
									
							}
						},
       			        followPointer: true
       			    }
       			    ,series: series.series
       				
       		};
			
			el.highcharts(option,function(chart){
		    	
			 });//chart end
				
			 
			
			
		}); // loop end
		
		
	}
	
	function fn_parameter_result(){
		var parameter = {list:[]};
		var series = [];
		var charts = $("[id^=chart][id$='highChart']");
		$.each(charts,function(i,chartDiv){
			var chart =  $(chartDiv).highcharts();
			//series
			var categoryName = chart.userOptions.series[0].data[0].DATA_SRC;
			var catgory = {
				name : categoryName,
				order: alasql('select * from ? where category = ?',[categoryInfo,categoryName])[0].orderby,
				series : chart.userOptions.series
			};	
			parameter.list.push(catgory);
		});
		sortObjects(parameter.list,['order']);
		var newWin1 = window.open("", "MS_WordReport", "width=1200,height=800, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		
		var oFrm = document.getElementById("formReport");
		oFrm.searchJson.value = JSON.stringify(parameter);
		
		oFrm.action =  '/dashboard/performanceReportJson.html';
		oFrm.method = "post";
		oFrm.target = 'MS_WordReport';
	    oFrm.submit();		    
	    newWin1.focus();	
		
	}
	</script>
	
	<script type="text/javascript" title="saveFile">
		function saveFile(){
			var saveStr = "<!DOCTYPE html>\r\n";
			saveStr += "<html>\r\n";
			var headers = document.head.children;		
			saveStr += "<head>\r\n";
			$.each(headers, function(i, el){
				switch(this.tagName) {
				    case 'META':		
						saveStr += this.outerHTML;
						saveStr += "\r\n";
						break;
				    case 'LINK':
				    	
				    	saveStr += "<" + this.localName ;
						$.each(this.attributes, function(j, attr){
							saveStr += " " + this.nodeName + "=\""+el[this.nodeName]  + "\"";
						});
						saveStr += ">";
						saveStr += "\r\n";
						break;
						
				    case 'TITLE':
				    	break;
				    	saveStr += this.outerHTML ;
				    	saveStr += "\r\n";
				    	break;
				    	
				    case 'SCRIPT':				    	
				  		if(this.src != ""){
				  			saveStr += "<" + this.localName ;
							$.each(this.attributes, function(j, attr){
								saveStr += " " +  this.nodeName + "=\""+el[this.nodeName] + "\"";
							});
							saveStr += " >";
							saveStr += "</" + this.localName  + ">";
							saveStr += "\r\n";
							
				  		}else{
				  			if(this.title == "saveFile")
				  				break;
				  			saveStr += "<" + this.localName ;
				  			$.each(this.attributes, function(j, attr){
								saveStr += " " +  this.nodeName + "=\""+el[this.nodeName] + "\"";
							});
							saveStr += " >";
							saveStr += "\r\n";
							var str = $(this).html();
							var regDataList = /var\s+dataList\s*=\s*\[\];/i;
							var regTabList = /var\s+tabList\s*=\s*\[\];/i;
							var regFolderList = /var\s+folderList\s*=\s*\[\];/i;
							//var regSelectedList = /var\s+selectedList\s*=\s*\[\];/i;
							var regSelIds = /var\s+selIds\s*=\s*[\w\.\(\)',]+;/i ;
							var regDashboard = /\/dashboard/gi ;
							
							str = str.replace(regDataList,"var dataList = " + JSON.stringify(dataList) + ";");
							str = str.replace(regTabList,"var tabList = " + JSON.stringify(tabList) + ";");
							str = str.replace(regFolderList,"var folderList = " + JSON.stringify(folderList) + ";");
							//str = str.replace(regSelectedList,"var selectedList = " + JSON.stringify(selectedList) + ";");
							str = str.replace(regSelIds,"var selIds = " + JSON.stringify($("#"+ multiSearchObj.gridInfo.tableId).jqGrid('getGridParam','selarrrow')) + ";");
							//str = str.replace(regDashboard,window.location.origin+"/dashboard");
							
							saveStr += str;
							saveStr += "\r\n</" + this.localName  + ">";
							saveStr += "\r\n";							
							
				  		}
				    	break;
				    case 'STYLE':
				    	if(this.title != "main"){
				    		break;
				    	}
				    	saveStr += "<" + this.localName ;
				    	$.each(this.attributes, function(j, attr){
							saveStr += " " + this.nodeName + "=\""+this.nodeValue  + "\"";
						});
				    	saveStr += ">";
				    	saveStr += "\r\n";
				    	var str = $(this).html();
				    	saveStr += str;
				    	saveStr += "\r\n</" + this.localName  + ">";
				    	saveStr += "\r\n";
				    	
				    	
				    	break;
				    default:
				    	saveStr += "";
				}
								
				var head = this;
			});
			saveStr += "</head>\r\n";
			saveStr += "<body>\r\n";
			var bodyStr = "";
			bodyStr += '<form name="form" id="form" class="">\r\n';
			bodyStr += '<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>\r\n';
			bodyStr += '<input type="hidden" id="report" name="report" value="Y"/>\r\n';
			bodyStr += '<div id="searchContainer" align="left" class="dashboard-div container">\r\n';
			bodyStr += '	<div id = "selectContainer" style="/* text-align: right; */ /* display:inline-block;text-overflow:hidden;float:left; */">\r\n';
			bodyStr += '	</div>\r\n';
			bodyStr += '	<div id="jqgrid" style="width:100%;/* display:inline-block;float:left; */">\r\n';
			bodyStr += '		<table id="jqgridTable"></table>\r\n';
			bodyStr += '		<div id="jqgridPager"></div>\r\n';
			bodyStr += '	</div>\r\n';
			bodyStr += '</div>\r\n';
			bodyStr += '<div  id="container" class="dashboard-div container">\r\n';
			bodyStr += '	<ul class="nav nav-tabs"></ul>\r\n';
			bodyStr += '	  <div class="tab-content"></div>\r\n';
			bodyStr += '</div>\r\n';
			bodyStr += '<div id="loader"></div>\r\n';
			bodyStr += '</form>\r\n';		
			bodyStr += "<script src=\"http://solutionpms.skhynix.com/dashboard/js/highcharts/themes/dashboard-simple.js\"><\/script>\r\n";
			bodyStr += '</body>\r\n';
			saveStr += bodyStr;
			saveStr += '\r\n';
			
			saveStr += "</html>";
			
			var filename= 'savePerformance';
			var blob = new Blob([saveStr], {type: "text/plain;charset=utf-8"});
			saveAs(blob, filename+".htm");
		}
		
		function downloadCsv(){
			var str = [];
			str.push("Category,Category1,SeriesName,Spec,Value");
			var charts = $("[id^=chart][id$='highChart']");
			var category = "";
			$.each(charts,function(i,chartDiv){
				var chart =  $(chartDiv).highcharts();
				//series
				$.each(chart.series,function(j,s){
					//data
					$.each(s.data,function(k,data){
						category = data.DATA_SRC == undefined?category: data.DATA_SRC;
						var category1 = data.category.parent == undefined ? "none" : data.category.parent.name;
						str.push(category + "," + category1 + "," +  s.name +"," + data.category.name + "," + data.y );
					});
				});
			});
			
			var filename= 'Performance';
			var blob = new Blob([str.join("\r\n")], {type: "text/plain;charset=utf-8"});
			saveAs(blob, filename+".csv");
		}
		
		function chartConvertToImage(){
			$("#loader").show();
			
			$("#container").css("padding-left","100px");
			$("#container").css("padding-right","100px");
			
			var exportUrl = 'http://export.highcharts.com/';
			//var charts = $("[id^=chart][id$='highChart']");
			var charts = $("[id^=chart]");
			$("span[id^=chart]").css("width","100%");
			//$("span[id^=chart]").css("width","");
			//charts.css("width","100%");
			setTimeout(function(){ 
				//$("span[id^=chart]").css("width","100%");
				$.each(charts,function(i,chartDiv){
						var chart =  $(chartDiv).highcharts();
						if(chart != undefined){
							chart.reflow();
						}else{
							return true;
						}			
	// 					chart.options.xAxis[0].categories = chart.options.xAxis[0].categoriesOrigin;
						
						var width = $(chartDiv).width() ;
						var height = $(chartDiv).height() ;
						//height = 200;
						var optionsStr = JSON.stringify(chart.options);
						var dataString = encodeURI('async=true&type=png&width=' + width + '&height=' + height + '&options=' + optionsStr);
						//var dataString = encodeURI('async=true&type=jpeg&options=' + optionsStr);
						
// 						$.ajax({
// 			                type: 'POST',
// 			                data: dataString,
// 			                url: exportUrl,
// 			                //async: false,
// 			                success: function (data) {
// 			                    //console.log('get the file from relative url: ', data);
// 			                    $(chartDiv).html('<img style="width:'+width+'px;height:'+height+'px;"  src="' + exportUrl + data + '"/>');		 
// 			                    chart.destroy();
// 			                },
// 			                error: function (err) {
// 			                    //debugger;
// 			                    console.log('error', err.statusText)
// 			                }
// 			            });
						
// 						var svg = chart.getSVG();
// 						var base_image = new Image();
// 						$(base_image).css("width",width);
// 					    $(base_image).css("height",height);
// 					    svg = "data:image/svg+xml,"+svg;
// 					    base_image.src = svg;
					    
// 					    //$(chartDiv).html('<img style="width:'+width+'px;height:'+height+'px;"  src="' + svg + '"/>')
// 						chart.destroy();
// 						$(chartDiv).append(base_image);


						//--  offline-exporting.src.js : Highcharts.imageToDataUrl . referred
						//var svg = chart.getSVG();
						var svg = chart.getChartHTML();
						var svgurl = Highcharts.svgToDataUrl(svg);
						var img = new Image();
						//$(img).css("width",width);
						//$(img).css("height",height);
						//img.width = width;
						//img.height = height;
						
						var imageType = 'image/png';
						var scale = 1;
						var loadHandler = function() {
		                    setTimeout(function() {
		                        var canvas = document.createElement('canvas'),
		                            ctx = canvas.getContext && canvas.getContext('2d'),
		                            dataURL;
		                        try {
		                            if (!ctx) {
		                                //noCanvasSupportCallback(imageURL, imageType, callbackArgs, scale);
		                            } else {
		                                canvas.height = img.height * scale;
		                                canvas.width = img.width * scale;
		                                //canvas.height = height;
		                                //canvas.width = width;
		                                ctx.drawImage(img, 0, 0, canvas.width, canvas.height);

		                                // Now we try to get the contents of the canvas.
		                                try {
		                                    var dataURL = canvas.toDataURL(imageType);
		                                    //$(chartDiv).html('<img style="width:'+width+'px;height:'+height+'px;"  src="' + svg + '"/>')
		            						var base_image = new Image();
		            						//var cols = $(chartDiv).parent().parent().find("[id^=chart_]").length;
		            						//var cols = $(chartDiv).parent().parent().children().length;
		            						var cols = $(chartDiv).parent().parent().find('span[id^=chart_]').length;
		            						
		            						//$(base_image).css("width","100%");
										    //$(base_image).css("height","100%");
		                                    if(cols==1){
		                                    	
		                                    	//$(base_image).css("height",'100%');
		                                    }
		                                    else{
		                                    	//$(base_image).css("width","100%");
											    //$(base_image).css("height","100%");
		                                    }											
										    base_image.src = dataURL;
		                                    chart.destroy();		                                    
		            						$(chartDiv).append(base_image);
		                                } catch (e) {
		                                    
		                                }
		                            }
		                        } finally {
		                            
		                        }
		                    }, 0); // IE bug where image is not always ready despite calling load event.
		                };
		                img.onload = loadHandler;
		                img.src = svgurl;
					
				});
				$("#searchCondition").hide();
				$("#selectContainer").hide();
				$("#jqgrid").hide();				
				$("[id^=chart][id$=GridPager]").hide();
				$(".nav.nav-tabs").hide();
				$("div.ui-jqgrid-bdiv").css("height",'');
				$(".ui-jqgrid-titlebar-close.HeaderButton").hide();
				$("div.ui-jqgrid-bdiv").css("margin-bottom",'3px');
				$("div.ui-jqgrid-view.table-responsive th div").css("font-size","11px");
				$("div.ui-jqgrid-view.table-responsive td").css("font-size","10px");
				
				
				$(".ui-jqgrid-titlebar.ui-jqgrid-caption").hide();
				
				
				/////header
				//$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-hdiv .ui-jqgrid-htable tr").find("th:eq(1)").css("width","250px");
				//$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-hdiv .ui-jqgrid-htable tr").find("th:eq(2)").css("width","90px");
				//$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-hdiv .ui-jqgrid-htable tr").find("th:gt(1)").css("width","130px");
				
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-hdiv table").css("width","");
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-hdiv .ui-jqgrid-htable tr").find("th:eq(0)").css("width","35px");
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-hdiv .ui-jqgrid-htable tr").find("th:eq(1)").css("width","150px");
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-hdiv .ui-jqgrid-htable tr").find("th:gt(1)").css("width","100px");
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-hdiv .ui-jqgrid-htable tr").find("th:last").css("width","");
				
				//$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-hdiv table").css("width","");
				/////body
				//$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv tbody tr").find("td:eq(1)").css("width","250px");
				//$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv tbody tr").find("td:eq(2)").css("width","90px");
				//$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv tbody tr").find("td:gt(1)").css("width","130px");
				//$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv tbody tr").find("td:gt(0)").css("width","");
				
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv table").css("width","");
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv tbody tr").find("td:eq(0)").css("width","35px");
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv tbody tr").find("td:eq(1)").css("width","150px");
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv tbody tr").find("td:gt(1)").css("width","100px");
// 				$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv tbody tr").find("td:last").css("width","");
				
				//$("div.ui-jqgrid-view.table-responsive .ui-jqgrid-bdiv table").css("width","")
				
				
				$("#loader").hide();
			},50);
			
		}
		
		
	</script>
	<script type="text/javascript" title="schema" >
		var categoryInfo =[
	    			 {
	     					category:'Latency.csv',
	     					calculateCols:[
								{
									col:'ORDER',
									val: function(){
										if(this.SPEC.match(/Seq_Read/gi) != null  ){
												return 1;
											}else if(this.SPEC.match(/Ran_Read/gi) != null ){
												return 2;
											}else if(this.SPEC.match(/Seq_Write/gi) != null ){
												return 3;
											}else if(this.SPEC.match(/Ran_Write/gi) != null ){
												return 4;
											}else{
												return 100;
											}
										
									}
								},
								{
									col:'MEASURE1',
									val: function(){
										return this.MEASURE * 1000;									
									}
								}
	     					],
	     					filters:[
	     						{col:'FIELD',val:'Average Response Time'}
	     					],
	     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
	     					categoryCols:['SPEC'],
	     					yCol:'MEASURE1',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:false,
	     						cols:[]
	     					},
	     					decimalPoint:2
	     					, gridSeriesColWidth: ''
		     				, gridColWidth: '115px'
	     					, orderby: 9
	     			 },
	     			 {
	     					category:'SLC_Latency.csv',
	     					calculateCols:[
								{
									col:'ORDER',
									val: function(){
										if(this.SPEC.match(/Seq_Read/gi) != null  ){
												return 1;
											}else if(this.SPEC.match(/Ran_Read/gi) != null ){
												return 2;
											}else if(this.SPEC.match(/Seq_Write/gi) != null ){
												return 3;
											}else if(this.SPEC.match(/Ran_Write/gi) != null ){
												return 4;
											}else{
												return 100;
											}
										
									}
								} ,
								{
									col:'MEASURE1',
									val: function(){
										return this.MEASURE * 1000;									
									}
								}
	     					],
	     					filters:[
	     						{col:'FIELD',val:'Average Response Time'}
	     					],
	     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
	     					categoryCols:['SPEC'],
	     					yCol:'MEASURE1',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:false,
	     						cols:[]
	     					},
	     					decimalPoint:2,
	     					gridColWidth: '115px',
	     					orderby:2
	     			 },
	     			 {
	     					category:'Max Throughput.csv',
	     					calculateCols:[
								{
									col:'ORDER',
									val: function(){
										if(this.SPEC.match(/Seq_Read/gi) != null  ){
												return 1;
											}else if(this.SPEC.match(/Ran_Read/gi) != null ){
												return 2;
											}else if(this.SPEC.match(/Seq_Write/gi) != null ){
												return 3;
											}else if(this.SPEC.match(/Ran_Write/gi) != null ){
												return 4;
											}else{
												return 100;
											}
										
									}
								}                     
	     					],
	     					filters:[
	     						{col:'FIELD',val:'MBps (Decimal)'},
	     						{col:'FIELD',val:'IOps'}
	     					],
	     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
	     					categoryCols:['FIELD','SPEC'],
	     					yCol:'MEASURE',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:true,
	     						splitCol:'FIELD'
	     					}
	     					, gridSeriesColWidth: ''
		     				, gridColWidth: '115px'
	     					,orderby: 8
	     			 },
	     			 // SPECwpcSummary
	     			 {
	     					category:'SPECwpcSummary',
	     					calculateCols:[
								{
									col:'ORDER',
									val: function(){
										if(this.SPEC.match(/Media and Entertainment/gi) != null  ){
	     									return 1;
	     								}else if(this.SPEC.match(/Product Development/gi) != null ){
	     									return 2;
	     								}else if(this.SPEC.match(/Life Sciences/gi) != null ){
	     									return 3;
	     								}else if(this.SPEC.match(/Energy/gi) != null ){
	     									return 4;
	     								}else if(this.SPEC.match(/General Operations/gi) != null ){
	     									return 5;
	     								}else{
	     									return 100;
	     								}
										
									}
								}               
	     					],
	     					filters:[
	     						{col:'FIELD',val:'IOMeter'} ,
	     						{col:'QUEUE_DEPTH',val:'Summary'}
	     						
	     					],
	     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
	     					categoryCols:['FIELD','SPEC'],
	     					yCol:'MEASURE',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:false,
	     						splitCol:'FIELD'
	     					}
	     					, decimalPoint:2
	     					, gridSeriesColWidth: ''
	     					, gridColWidth: '115px'
	     					, orderby: 0.1
	     			 },
	     			 // wpc1.csv
	     			 {
     					category:'wpc1.csv',
     					calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/64K Sequential Reads/gi) != null  ){
     									return 1;
     								}else if(this.SPEC.match(/64K Sequential Writes/gi) != null ){
     									return 2;
     								}else if(this.SPEC.match(/8K Sequential Writes/gi) != null ){
     									return 3;
     								}else if(this.SPEC.match(/8K Sequential Reads/gi) != null ){
     									return 4;
     								}else if(this.SPEC.match(/3dsmax/gi) != null ){
     									return 5;
     								}else if(this.SPEC.match(/ansys/gi) != null ){
     									return 6;
     								}else if(this.SPEC.match(/blender/gi) != null ){
     									return 7;
     								}else if(this.SPEC.match(/Handbrake/gi) != null ){
     									return 8;
     								}else if(this.SPEC.match(/Solidworks/gi) != null ){
     									return 9;
     								}else if(this.SPEC.match(/NX6/gi) != null ){
     									return 10;
     								}else if(this.SPEC.match(/Maya2012/gi) != null ){
     									return 11;
     								}else if(this.SPEC.match(/Inventor/gi) != null ){
     									return 12;
     								}else if(this.SPEC.match(/Energy/gi) != null ){
     									return 13;
     								}else if(this.SPEC.match(/Life Sci/gi) != null ){
     									return 14;
     								}else if(this.SPEC.match(/General/gi) != null ){
     									return 15;
     								}else{
     									return 100;
     								}
									
								}
							}               
     					],
     					filters:[
     						{col:'FIELD',val:'Read MBps (Decimal)'} ,
     						{col:'FIELD',val:'Write MBps (Decimal)'}
     					],
     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
     					categoryCols:['FIELD','SPEC'],
     					yCol:'MEASURE',
     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     					multichart:{
     						enabled:true,
     						splitCol:'FIELD',
     						chartWidth: 100 , // percent 로 표시
     						oneLineChatNum: 1,
     						oneLineHeight: 600
     					}
     					, decimalPoint:2
     					, gridSeriesColWidth: ''
     					, gridColWidth: '115px'
     					, orderby: 0.2
	     			 },
	     			 {
     					category:'wpc2.csv',
     					calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/64K Sequential Reads/gi) != null  ){
     									return 1;
     								}else if(this.SPEC.match(/64K Sequential Writes/gi) != null ){
     									return 2;
     								}else if(this.SPEC.match(/8K Sequential Writes/gi) != null ){
     									return 3;
     								}else if(this.SPEC.match(/8K Sequential Reads/gi) != null ){
     									return 4;
     								}else if(this.SPEC.match(/3dsmax/gi) != null ){
     									return 5;
     								}else if(this.SPEC.match(/ansys/gi) != null ){
     									return 6;
     								}else if(this.SPEC.match(/blender/gi) != null ){
     									return 7;
     								}else if(this.SPEC.match(/Handbrake/gi) != null ){
     									return 8;
     								}else if(this.SPEC.match(/Solidworks/gi) != null ){
     									return 9;
     								}else if(this.SPEC.match(/NX6/gi) != null ){
     									return 10;
     								}else if(this.SPEC.match(/Maya2012/gi) != null ){
     									return 11;
     								}else if(this.SPEC.match(/Inventor/gi) != null ){
     									return 12;
     								}else if(this.SPEC.match(/Energy/gi) != null ){
     									return 13;
     								}else if(this.SPEC.match(/Life Sci/gi) != null ){
     									return 14;
     								}else if(this.SPEC.match(/General/gi) != null ){
     									return 15;
     								}else{
     									return 100;
     								}
									
								}
							}               
     					],
     					filters:[
     						{col:'FIELD',val:'Read MBps (Decimal)'} ,
     						{col:'FIELD',val:'Write MBps (Decimal)'}
     					],
     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
     					categoryCols:['FIELD','SPEC'],
     					yCol:'MEASURE',
     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     					multichart:{
     						enabled:true,
     						splitCol:'FIELD',
     						chartWidth: 100 , // percent 로 표시
     						oneLineChatNum: 1,
     						oneLineHeight: 600,
     					}
     					, decimalPoint:2
     					, gridSeriesColWidth: ''
     					, gridColWidth: '115px'
     					, orderby: 0.3
	     			 },
	     			 {
     					category:'wpc3.csv',
     					calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/64K Sequential Reads/gi) != null  ){
     									return 1;
     								}else if(this.SPEC.match(/64K Sequential Writes/gi) != null ){
     									return 2;
     								}else if(this.SPEC.match(/8K Sequential Writes/gi) != null ){
     									return 3;
     								}else if(this.SPEC.match(/8K Sequential Reads/gi) != null ){
     									return 4;
     								}else if(this.SPEC.match(/3dsmax/gi) != null ){
     									return 5;
     								}else if(this.SPEC.match(/ansys/gi) != null ){
     									return 6;
     								}else if(this.SPEC.match(/blender/gi) != null ){
     									return 7;
     								}else if(this.SPEC.match(/Handbrake/gi) != null ){
     									return 8;
     								}else if(this.SPEC.match(/Solidworks/gi) != null ){
     									return 9;
     								}else if(this.SPEC.match(/NX6/gi) != null ){
     									return 10;
     								}else if(this.SPEC.match(/Maya2012/gi) != null ){
     									return 11;
     								}else if(this.SPEC.match(/Inventor/gi) != null ){
     									return 12;
     								}else if(this.SPEC.match(/Energy/gi) != null ){
     									return 13;
     								}else if(this.SPEC.match(/Life Sci/gi) != null ){
     									return 14;
     								}else if(this.SPEC.match(/General/gi) != null ){
     									return 15;
     								}else{
     									return 100;
     								}
									
								}
							}               
     					],
     					filters:[
     						{col:'FIELD',val:'Read MBps (Decimal)'} ,
     						{col:'FIELD',val:'Write MBps (Decimal)'}
     					],
     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
     					categoryCols:['FIELD','SPEC'],
     					yCol:'MEASURE',
     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     					multichart:{
     						enabled:true,
     						splitCol:'FIELD',
     						chartWidth: 100 , // percent 로 표시
     						oneLineChatNum: 1,
     						oneLineHeight: 600,
     					}
     					, decimalPoint:2
     					, gridSeriesColWidth: ''
     					, gridColWidth: '115px'
     					, orderby: 0.4
	     			 },
	     			 // SLC_Max Throughput.csv
	     			 {
	     					category:'SLC_Max Throughput.csv',
	     					calculateCols:[
								{
									col:'ORDER',
									val: function(){
										if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return 1;
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return 2;
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return 3;
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return 4;
	     								}else{
	     									return 100;
	     								}
										
									}
								}               
	     					],
	     					filters:[
	     						{col:'FIELD',val:'MBps (Decimal)'},
	     						{col:'FIELD',val:'IOps'}
	     					],
	     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
	     					categoryCols:['FIELD','SPEC'],
	     					yCol:'MEASURE',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:true,
	     						splitCol:'FIELD'
	     					}
	     					, gridSeriesColWidth: ''
	     					, gridColWidth: '115px'
	     					, orderby:1
	     			 },
	     			 {
	     				 	//x축을 2개이상 사용하도록 설정필요.
	     					category:'QD 1 to 32.csv',
	     					calculateCols:[
								{
									col:'QD_QUEUE_DEPTH',
									val: function(){
										return 'QD_' + this.QUEUE_DEPTH;
										
									}
								},
	     						{
	     							col:'QD_CAL',
	     							val: function(){
	     								if((this.SPEC.match(/^4kb/gi) != null ) && this.FIELD == 'IOps'){
	     									return 'O';
	     								}else if((this.SPEC.match(/^4kb/gi) == null ) && this.FIELD == 'MBps (Decimal)'){
	     									return 'O';
	     								}else{
	     									return 'null';
	     								}
	     								
	     							}
	     						}
	     					],
	     					filters:[
	     						{col:'QD_CAL',val:  'O'}
	     					],
	     					xOderbyCols:['FIRMWARE1','QD_QUEUE_DEPTH'],
	     					categoryCols:['SPEC','QD_QUEUE_DEPTH'],
	     					yCol:'MEASURE',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:true,
	     						splitCol:'SPEC',
	     						chartWidth: 50 , // percent 로 표시
	     						oneLineChatNum: 2,
	     						oneLineHeight: 600
	     					},
	     					gridColWidth: '75px',
	     					orderby: 10
	     			 },
	     			 {
	     				 	//x축을 2개이상 사용하도록 설정필요.
	     					category:'SLC_QD 1 to 32.csv',
	     					calculateCols:[
								{
										col:'QD_QUEUE_DEPTH',
										val: function(){
											return 'QD_' + this.QUEUE_DEPTH;
											
										}
									},
		     						{
		     							col:'QD_CAL',
		     							val: function(){
		     								if((this.SPEC.match(/^4kb/gi) != null ) && this.FIELD == 'IOps'){
		     									return 'O';
		     								}else if((this.SPEC.match(/^4kb/gi) == null ) && this.FIELD == 'MBps (Decimal)'){
		     									return 'O';
		     								}else{
		     									return 'null';
		     								}
		     								
		     							}
		     						}
		     					],
		     					filters:[
		     						{col:'QD_CAL',val:  'O'}
		     					],
		     					xOderbyCols:['FIRMWARE1','QD_QUEUE_DEPTH'],
		     					categoryCols:['SPEC','QD_QUEUE_DEPTH'],
		     					yCol:'MEASURE',
		     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		     					multichart:{
		     						enabled:true,
		     						splitCol:'SPEC',
		     						chartWidth: 50 , // percent 로 표시
		     						oneLineChatNum: 2,
		     						oneLineHeight: 600
		     					},
		     					gridColWidth: '75px',
		     					orderby:3
	     			 },
	     			 {
	     			 	//x축을 2개이상 사용하도록 설정필요.
	     				category:'Workload_Align.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},      
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 400
	     				},
	     				gridSeriesColWidth: '120',
	     				gridColWidth: '40px',
	     				orderby: 11
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요.
	     				category:'Workload_Align_Qdepth1.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},      
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 400
	     				},
	     				gridSeriesColWidth: '',
	     				gridColWidth: '50px',
	     				orderby: 11.5
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요.
	     				category:'Workload_Align_QD1.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},      
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 400
	     				},
	     				gridSeriesColWidth: '120',
	     				gridColWidth: '40px',
	     				orderby: 11.5
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요.
	     				category:'Workload_Unalign.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},   
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 400
	     				},
	     				gridSeriesColWidth: '120',
	     				gridColWidth: '40px',
	     				orderby: 12
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요.
	     				category:'Workload_Unalign_Qdepth1.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},   
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 400
	     				},
	     				gridColWidth: '65px',
	     				orderby: 12.5
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요.
	     				category:'Workload_Unalign_QD1.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},   
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 400
	     				},
	     				gridSeriesColWidth: '120',
	     				gridColWidth: '40px',
	     				orderby: 12.5
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요. 
	     				category:'SLC_Workload_Align.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},    
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 400
	     				},
	     				gridSeriesColWidth: '120',
	     				gridColWidth: '40px',
	     				orderby: 4
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요. 
	     				category:'SLC_Workload_Align_Qdepth1.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},    
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 400
	     				},
	     				gridSeriesColWidth:'80px',
	     				gridColWidth: '65px',
	     				orderby: 4.5
	     		 	},	  
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요. 
	     				category:'SLC_Workload_Align_QD1.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},    
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 400
	     				},
	     				gridSeriesColWidth: '120',
	     				gridColWidth: '40px',
	     				orderby: 4.5
	     		 	},	   
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요. 
	     				category:'SLC_Workload_Unalign.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},   
     					{
     						col:'WA_CATEGORY',
     						val: function(){
     							if(this.FIELD == 'MBps (Decimal)'){
     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
     									return '01.Seq.Read';
     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
     									return '02.Ran.Read';
     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
     									return '03.Seq.Write';
     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
     									return '04.Ran.Write';
     								}else{
     									return 'null';
     								}
     							}else return 'null'
     							
     						}
     					},
     					{
     						col:'WA_SPEC',
     						val: function(){
     							if(this.FIELD == 'MBps (Decimal)'){
     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
     								}else{
     									return 'null';
     								}
     							}else{
     								return 'null';
     							}
     							
     						}
     					}
     				],
     				filters:[
     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
     					{col:'FIELD',val:'MBps (Decimal)'}
     				],
     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
     				categoryCols:['WA_CATEGORY','WA_SPEC'],
     				yCol:'MEASURE',
     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     				multichart:{
     					enabled:true ,
     					splitCol:'WA_CATEGORY',
     					chartWidth: 100 , // percent 로 표시
     					oneLineChatNum: 1,
     					oneLineHeight: 400
     				},
     				gridSeriesColWidth: '120',
     				gridColWidth: '40px',
     				orderby: 5
	     		 },
	     		 {
	     			 	//x축을 2개이상 사용하도록 설정필요. 
	     				category:'SLC_Workload_Unalign_Qdepth1.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},   
		  					{
		  						col:'WA_CATEGORY',
		  						val: function(){
		  							if(this.FIELD == 'MBps (Decimal)'){
		  								if(this.SPEC.match(/Seq_Read/gi) != null  ){
		  									return '01.Seq.Read';
		  								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
		  									return '02.Ran.Read';
		  								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
		  									return '03.Seq.Write';
		  								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
		  									return '04.Ran.Write';
		  								}else{
		  									return 'null';
		  								}
		  							}else return 'null'
		  							
		  						}
		  					},
		  					{
		  						col:'WA_SPEC',
		  						val: function(){
		  							if(this.FIELD == 'MBps (Decimal)'){
		  								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
		  									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
		  								}else{
		  									return 'null';
		  								}
		  							}else{
		  								return 'null';
		  							}
		  							
		  						}
		  					}
		  				],
		  				filters:[
		  					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
		  					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
		  					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
		  					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
		  					{col:'FIELD',val:'MBps (Decimal)'}
		  				],
		  				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
		  				categoryCols:['WA_CATEGORY','WA_SPEC'],
		  				yCol:'MEASURE',
		  				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		  				multichart:{
		  					enabled:true ,
		  					splitCol:'WA_CATEGORY',
		  					chartWidth: 100 , // percent 로 표시
		  					oneLineChatNum: 1,
		  					oneLineHeight: 400
		  				},
		  				gridColWidth: '65px',
		  				orderby: 5.5
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요. 
	     				category:'SLC_Workload_Unalign_QD1.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},   
		  					{
		  						col:'WA_CATEGORY',
		  						val: function(){
		  							if(this.FIELD == 'MBps (Decimal)'){
		  								if(this.SPEC.match(/Seq_Read/gi) != null  ){
		  									return '01.Seq.Read';
		  								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
		  									return '02.Ran.Read';
		  								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
		  									return '03.Seq.Write';
		  								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
		  									return '04.Ran.Write';
		  								}else{
		  									return 'null';
		  								}
		  							}else return 'null'
		  							
		  						}
		  					},
		  					{
		  						col:'WA_SPEC',
		  						val: function(){
		  							if(this.FIELD == 'MBps (Decimal)'){
		  								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
		  									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
		  								}else{
		  									return 'null';
		  								}
		  							}else{
		  								return 'null';
		  							}
		  							
		  						}
		  					}
		  				],
		  				filters:[
		  					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
		  					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
		  					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
		  					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
		  					{col:'FIELD',val:'MBps (Decimal)'}
		  				],
		  				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
		  				categoryCols:['WA_CATEGORY','WA_SPEC'],
		  				yCol:'MEASURE',
		  				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		  				multichart:{
		  					enabled:true ,
		  					splitCol:'WA_CATEGORY',
		  					chartWidth: 100 , // percent 로 표시
		  					oneLineChatNum: 1,
		  					oneLineHeight: 400
		  				},
		  				gridSeriesColWidth: '120',
	     				gridColWidth: '40px',
		  				orderby: 5.5
	     		 	},
	     		 	{
	     				category:'Mixed_Seq_RW.csv',
	     				calculateCols:[
	     					{
	     						col:'MIXED_SERIES',
	     						val: function(){
	     							if(this.FIELD == 'Read MBps (Decimal)'  ){
	     								return 'Read';
	     							}else if(this.FIELD == 'Write MBps (Decimal)' ){
	     								return 'Write';
	     							}else{
	     								return null;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'MIXED_SPEC',
	     						val: function(){
	     							//return this.SPEC;
	     							if(this.SPEC.match(/R[\d]+\/W[\d]+$/gi) != null  ){
	     								return this.SPEC.match(/R[\d]+\/W[\d]+$/gi)[0];
	     							}else{
	     								return this.SPEC;
	     							}
	     						}
	     					},
	     					{
	     						col:'MIXED_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'MIXED_SERIES',val:  'Read'},
	     					{col:'MIXED_SERIES',val:  'Write'}				
	     				],
	     				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
	     				xOderbyCols:['MIXED_SERIES',['MIXED_SPEC','desc']],
	     				categoryCols:['FIRMWARE1','MIXED_SPEC'],
	     				yCol:'MEASURE',
	     				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
	     				seriesCol:{cd:'MIXED_SERIES',name:'MIXED_SERIES'},
	     				multichart:{
	     					enabled: true,
	     					splitCol:'FIRMWARE1',
	     					chartWidth: 50 , // percent 로 표시
     						oneLineChatNum: 2
	     				},
	     				addSeries:[
	     					{
	     						name: 'Sum',
	     						type: 'spline',
	     						seriesFunction: function(){
		  	     						var series = arguments;
		  	     						var addS = this;
		     							$.each(series,function(seriesIndex,s){
		     								$.each(s.data,function(dataIndex,d){
		     									if(addS.data[dataIndex] != undefined){
		     										addS.data[dataIndex].y += d.y;
		     									}else{
		     										addS.data[dataIndex] = {
		     											y : d.y	
		     										};
		     									}
		     								});
		     								
		     							});
		     						}
	     					}
	     				],
	     				gridSeriesColWidth: '50px',
		  	     		gridColWidth: '58px',
	     				orderby: 13
	     		 	},
	     		 	{
	     				category:'Mixed_Ran_RW.csv',
	     				calculateCols:[
	     					{
	     						col:'MIXED_SERIES',
	     						val: function(){
	     							if(this.FIELD == 'Read MBps (Decimal)'  ){
	     								return 'Read';
	     							}else if(this.FIELD == 'Write MBps (Decimal)' ){
	     								return 'Write';
	     							}else{
	     								return null;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'MIXED_SPEC',
	     						val: function(){
	     							//return this.SPEC;
	     							if(this.SPEC.match(/R[\d]+\/W[\d]+$/gi) != null  ){
	     								return this.SPEC.match(/R[\d]+\/W[\d]+$/gi)[0];
	     							}else{
	     								return this.SPEC;
	     							}
	     						}
	     					},
	     					{
	     						col:'MIXED_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'MIXED_SERIES',val:  'Read'},
	     					{col:'MIXED_SERIES',val:  'Write'}				
	     				],
	     				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
	     				xOderbyCols:['MIXED_SERIES',['MIXED_SPEC','desc']],
	     				categoryCols:['FIRMWARE1','MIXED_SPEC'],
	     				yCol:'MEASURE',
	     				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
	     				seriesCol:{cd:'MIXED_SERIES',name:'MIXED_SERIES'},
	     				multichart:{
	     					enabled: true,
	     					splitCol:'FIRMWARE1',
	     					chartWidth: 50 , // percent 로 표시
     						oneLineChatNum: 2
	     				},
	     				addSeries:[
	   	     					{
	   	     						name: 'Sum',
	   	     						type: 'spline',
		   	     					seriesFunction: function(){
			  	     						var series = arguments;
			  	     						var addS = this;
			     							$.each(series,function(seriesIndex,s){
			     								$.each(s.data,function(dataIndex,d){
			     									if(addS.data[dataIndex] != undefined){
			     										addS.data[dataIndex].y += d.y;
			     									}else{
			     										addS.data[dataIndex] = {
			     											y : d.y	
			     										};
			     									}
			     								});
			     								
			     							});
			     						}
	   	     					}
	   	     				],
	   	     			gridSeriesColWidth: '50px',
		  	     		gridColWidth: '58px',
	   	     			orderby: 14
	     		 	},
	     		 	// Rw Block Sweep
	     		 	{
	     		 		
     				 	//x축을 2개이상 사용하도록 설정필요.
     					category:'RW Block Sweep parsed.csv',
     					//chartType:'spline',
     					calculateCols:[
							{
								col:'Category',
								val: function(){
									var vSplit = this.SPEC.split("_");
									return vSplit[0] + " " + vSplit[1];									
								}
							},
							{
								col:'BlockSize',
								val: function(){
									var vSplit = this.SPEC.split("_");
									return vSplit[2];
									
								}
							}
							
     					],
     					filters:[
     						{col:'FIELD',val:  'Average of 3 runs'}
     					],
     					xOderbyCols:['FIRMWARE1','BlockSize'],
     					categoryCols:['Category','BlockSize'],
     					yCol:'MEASURE',
     					decimalPoint:2,
     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     					multichart:{
     						enabled:true,
     						splitCol:'Category',
     						chartWidth: 50 , // percent 로 표시
     						oneLineChatNum: 2,
     						oneLineHeight: 600,
     						yAxisTitle:{
     							"Random Read":'IOps',
     							"Random Write":'IOps',
     							"Sequential Read":'MBps (Binary)',
     							"Sequential Write":'MBps (Binary)',
     							"Random 25R/75W":'IOps',
     							"Random 75R/25W":'IOps',     							
     							"Sequential 25R/75W":'MBps (Binary)',
     							"Sequential 75R/25W":'MBps (Binary)',
     						},
     						orderBy : function(){
	   							if(this.Category.match(/Random Read/gi) != null  ){
									return 10;
								}else if(this.Category.match(/Random Write/gi) != null  ){
									return 20;
								}else if(this.Category.match(/Sequential Read/gi) != null  ){
									return 30;
								}else if(this.Category.match(/Sequential Write/gi) != null  ){
									return 40;
								}else if(this.Category.match(/Random 75R\/25W/gi) != null  ){
									return 50;
								}else if(this.Category.match(/Random 25R\/75W/gi) != null  ){
									return 60;
								}else if(this.Category.match(/Sequential 75R\/25W/gi) != null  ){
									return 70;
								}else if(this.Category.match(/Sequential 25R\/75W/gi) != null  ){
									return 80;
								}else{
									return 100;
								}
								
							}
     					},
     					gridColWidth: '50px',
     					orderby:14.2
	     		 	},
	     		 	// SSD Performance V1.csv
	     		 	{
	     		 		
     				 	//x축을 2개이상 사용하도록 설정필요.
     					category:'SSD Performance V1.csv',
     					//chartType:'spline',
     					calculateCols:[
     						{
								col:'isShow',
								val: function(){
									if(this.SPEC == "Seqread" && this.FIELD == "MBps (Decimal)" ){
										return "O";
									}else if(this.SPEC == "SeqWrite" && this.FIELD == "MBps (Decimal)" ){
										return "O";
									}else if(this.SPEC == "RandomRead" && this.FIELD == "IOps" ){
										return "O";
									}else if(this.SPEC == "RandomWrite" && this.FIELD == "IOps" ){
										return "O";
									}else{
										return "X";
									}										
								}
							},
							{
								col:'SeqRandom',
								val: function(){
									if(this.SPEC.match(/^Random/gi) != null ){
										return 'Ran';
									}else if(this.SPEC.match(/^Seq/gi) != null ){
										return 'Seq';
									}										
								}
							},
							{
								col:'Seq',
								val: function(){
									return Number(this.SPEC1);
									
								}
							}
							
     					],
     					filters:[
     						{col:'isShow',val:  "O"}
     					],
     					xOderbyCols:['FIRMWARE1','Seq'],
     					categoryCols:['SPEC','Seq'],
     					yCol:'MEASURE',
     					decimalPoint:2,
     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     					multichart:{
     						enabled:true,
     						splitCol:'SPEC',
     						chartWidth: 100 , // percent 로 표시
     						oneLineChatNum: 1,
     						oneLineHeight: 600,
     						yAxisTitle:{
     							"Seqread":'MB/s',
     							"SeqWrite":'MB/s',
     							"RandomRead":'IOps',
     							"RandomWrite":'IOps'
     						},
     						orderBy : function(){
	   							if(this.SPEC.match(/Seqread/gi) != null  ){
									return 10;
								}else if(this.SPEC.match(/SeqWrite/gi) != null  ){
									return 20;
								}else if(this.SPEC.match(/RandomRead/gi) != null  ){
									return 30;
								}else if(this.SPEC.match(/RandomWrite/gi) != null  ){
									return 40;
								}else{
									return 100;
								}
								
							}
     					},
     					gridColWidth: '50px',
     					orderby:14.3
	     		 	},
	     		 	{
	     				category:'SLC_Mixed_Seq_RW.csv',
	     				calculateCols:[
 		     					{
 		     						col:'MIXED_SERIES',
 		     						val: function(){
 		     							if(this.FIELD == 'Read MBps (Decimal)'  ){
 		     								return 'Read';
 		     							}else if(this.FIELD == 'Write MBps (Decimal)' ){
 		     								return 'Write';
 		     							}else{
 		     								return null;
 		     							}
 		     							
 		     						}
 		     					},
 		     					{
 		     						col:'MIXED_SPEC',
 		     						val: function(){
 		     							//return this.SPEC;
 		     							if(this.SPEC.match(/R[\d]+\/W[\d]+$/gi) != null  ){
 		     								return this.SPEC.match(/R[\d]+\/W[\d]+$/gi)[0];
 		     							}else{
 		     								return this.SPEC;
 		     							}
 		     						}
 		     					},
 		     					{
 		     						col:'MIXED_DUMMY',
 		     						val: function(){
 		     							return 'measure';
 		     						}
 		     					}
 		     				],
 		     				filters:[
 		     					{col:'MIXED_SERIES',val:  'Read'},
 		     					{col:'MIXED_SERIES',val:  'Write'}				
 		     				],
 		     				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
 		     				xOderbyCols:['MIXED_SERIES',['MIXED_SPEC','desc']],
 		     				categoryCols:['FIRMWARE1','MIXED_SPEC'],
 		     				yCol:'MEASURE',
 		     				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
 		     				seriesCol:{cd:'MIXED_SERIES',name:'MIXED_SERIES'},
 		     				multichart:{
 		     					enabled: true,
 		     					splitCol:'FIRMWARE1',
 		     					chartWidth: 50 , // percent 로 표시
	     						oneLineChatNum: 2
 		     				},
 		     				addSeries:[
 		  	     					{
 		  	     						name: 'Sum',
 		  	     						type: 'spline',
	 		  	     					seriesFunction: function(){
	 		  	     						var series = arguments;
	 		  	     						var addS = this;
	 		     							$.each(series,function(seriesIndex,s){
	 		     								$.each(s.data,function(dataIndex,d){
	 		     									if(addS.data[dataIndex] != undefined){
	 		     										addS.data[dataIndex].y += d.y;
	 		     									}else{
	 		     										addS.data[dataIndex] = {
	 		     											y : d.y	
	 		     										};
	 		     									}
	 		     								});
	 		     								
	 		     							});
	 		     						}
 		  	     					}
 		  	     				] ,
 		  	     			gridSeriesColWidth: '50px',
 		  	     			gridColWidth: '58px',
 		  	     			orderby: 6
	     		 	},
	     		 	{
	     				category:'SLC_Mixed_Ran_RW.csv',
	     				calculateCols:[
  		     					{
  		     						col:'MIXED_SERIES',
  		     						val: function(){
  		     							if(this.FIELD == 'Read MBps (Decimal)'  ){
  		     								return 'Read';
  		     							}else if(this.FIELD == 'Write MBps (Decimal)' ){
  		     								return 'Write';
  		     							}else{
  		     								return null;
  		     							}
  		     							
  		     						}
  		     					},
  		     					{
  		     						col:'MIXED_SPEC',
  		     						val: function(){
  		     							//return this.SPEC;
  		     							if(this.SPEC.match(/R[\d]+\/W[\d]+$/gi) != null  ){
  		     								return this.SPEC.match(/R[\d]+\/W[\d]+$/gi)[0];
  		     							}else{
  		     								return this.SPEC;
  		     							}
  		     						}
  		     					},
  		     					{
  		     						col:'MIXED_DUMMY',
  		     						val: function(){
  		     							return 'measure';
  		     						}
  		     					}
  		     				],
  		     				filters:[
  		     					{col:'MIXED_SERIES',val:  'Read'},
  		     					{col:'MIXED_SERIES',val:  'Write'}				
  		     				],
  		     				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
  		     				xOderbyCols:['MIXED_SERIES',['MIXED_SPEC','desc']],
  		     				categoryCols:['FIRMWARE1','MIXED_SPEC'],
  		     				yCol:'MEASURE',
  		     				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
  		     				seriesCol:{cd:'MIXED_SERIES',name:'MIXED_SERIES'},
  		     				multichart:{
  		     					enabled: true,
  		     					splitCol:'FIRMWARE1',
  		     					chartWidth: 50 , // percent 로 표시
	     						oneLineChatNum: 2
  		     				},
  		     				addSeries:[
  		 	     					{
  		 	     						name: 'Sum',
  		 	     						type: 'spline',
	  		 	     					seriesFunction: function(){
	 		  	     						var series = arguments;
	 		  	     						var addS = this;
	 		     							$.each(series,function(seriesIndex,s){
	 		     								$.each(s.data,function(dataIndex,d){
	 		     									if(addS.data[dataIndex] != undefined){
	 		     										addS.data[dataIndex].y += d.y;
	 		     									}else{
	 		     										addS.data[dataIndex] = {
	 		     											y : d.y	
	 		     										};
	 		     									}
	 		     								});
	 		     								
	 		     							});
	 		     						}
  		 	     					}
  		 	     				],
  		 	     			gridSeriesColWidth: '50px',
 		  	     			gridColWidth: '58px',
  		 	     			orderby: 7
	     		 	},
	     		 	
	     		 	{
	     				category:'CDM301.xlsx',
	     				calculateCols:[
	     					{
	     						col:'CDM_SPEC',
	     						val: function(){	     							
	     							if(this.FIELD.match(/[\d]+/gi) != null ){
	     								var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\([\w\=\s,]+\))?/i);
	     								//["Read 4KB (QD=1)", "Read", "4KB", "(QD=1)"]
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								
	     								var vqd = '';
	     								if(arr[3] != undefined)
	     									vqd = arr[3];
	     								
	     								var vnum = '';
	     								if(arr[2] != undefined)
	     									vnum = arr[2];
	     								
	     								return arr[2] + ' ' + vspec + arr[1].substr(0,1) + vqd;
	     								
	     							}else{
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								return vspec + ' ' + this.FIELD;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'CDM_ORDER',
	     						val: function(){	     							
	     							if(this.FIELD.match(/[\d]+/gi) != null ){
	     								var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\([\w\=\s,]+\))?/i);
	     								//["Read 4KB (QD=1)", "Read", "4KB", "(QD=1)"]
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								
	     								var vqd = '';
	     								if(arr[3] != undefined)
	     									vqd = arr[3];
	     								
	     								var vnum = '';
	     								if(arr[2] != undefined)
	     									vnum = arr[2];
	     								
	     								return arr[2] + ' ' + vqd + vspec + arr[1].substr(0,1);
	     								
	     							}else{
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = '1.';
	     								else
	     									vspec = '2.';
	     								return vspec + ' ' + this.FIELD;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'CDM_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     					
	     				],
	     				xOderbyCols:['FIRMWARE1','CDM_ORDER','CDM_SPEC'],
	     				categoryCols:['CDM_SPEC'],
	     				yCol:'MEASURE',
	     				yAxisTitle :' MB/s',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:false,
	     					cols:[]
	     				},
	     				gridSeriesColWidth: '100px',
		 	     		gridColWidth: '70px',
	     				orderby: 210
	     		 },
	     		 {
	     				category:'CDM503.xlsx',
	     				calculateCols:[
	     					{
	     						col:'CDM_SPEC',
	     						val: function(){
	     							if(this.FIELD.match(/[\d]+/gi) != null ){
	     								var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\([\w\=\s,]+\))?/i);
	     								//["Read 4KB (QD=1)", "Read", "4KB", "(QD=1)"]
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								
	     								var vqd = '';
	     								if(arr[3] != undefined)
	     									vqd = arr[3];
	     								
	     								var vnum = '';
	     								if(arr[2] != undefined)
	     									vnum = arr[2];
	     								
	     								return vnum + ' ' + vspec + arr[1].substr(0,1) + vqd;
	     								
	     							}else{
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								return vspec + ' ' + this.FIELD;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'ORDER',
	     						val: function(){
	     							if(this.FIELD.match(/[\d]+/gi) != null ){
	     								var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\(([Q\s]+\=[\w\s]+)?,?([T\s]+\=[\w\s]+)?\))?/i);
	     								//["Read 4KiB (Q= 32,T= 1)", "Read", "4KiB", "(Q= 32,T= 1)", "Q= 32", "T= 1"]
	     								var qd = '0';
	     								if(arr[4] != undefined)
	     									qd = arr[4];
	     								
	     								
	     								var vspec = '0';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = '1';
	     								else
	     									vspec = '2';
	     								
	     								var vnum = '0';
	     								if(arr[2] != undefined)
	     									vnum = arr[2];
	     								
	     								var rw = '0';
	     								if(arr[1] != undefined)
	     									rw = arr[1];
	     								//return qd +'_'+ vnum + '_' +  vspec;
	     								return qd +'_'+ vnum + '_' + rw ;
	     								
	     							}else{
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = '1. ';
	     								else
	     									vspec = '2. ';
	     								return vspec + ' ' + this.FIELD;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'CDM_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     					
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','CDM_SPEC'],
	     				categoryCols:['CDM_SPEC'],
	     				yCol:'MEASURE',
	     				yAxisTitle :' MB/s',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:false,
	     					cols:[]
	     				},
	     				gridSeriesColWidth: '100px',
		 	     		gridColWidth: '70px',
	     				orderby: 220
	     		 },
	     		{
     				category:'AS-SSD1.6.xml',
     				calculateCols:[
     					{
     						col:'AS_SSD_SPEC',
     						val: function(){
     							var sarr = this.SPEC.match(/([a-z]+)([\d]+[a-z]+)([\d]+)/i);
     							if(sarr != undefined){
     								//Random4K64TTest : ["Random4K64", "Random", "4K", "64"]
     								var rs = sarr[1];
     								var rst = '';
     								if(rs.match(/random/gi) != null)
     									rst = 'R.';
     								else
     									rst = 'Seq.';
     								var vol = sarr[2];
     								var speed = sarr[3];
     								var rw = this.FIELD;
     								var rwt = '';
     								if(rw.match(/read/gi) != null)
     									rwt = 'R';
     								else if(rw.match(/Write/gi) != null)
     									rwt = 'W';
     								
     								var speedt = '';
     								if(speed != undefined)
     									speedt = '('+speed+'Thrd)';
     								return vol + ' ' + rst + rwt + speedt;
     								
     							}else if(this.SPEC == 'AccTimeTest'){
     								if(this.FIELD == 'Read')
     									return 'Access Time(Read)';
     								else
     									return 'Access Time(Write)';
     							}else {
     								if(this.FIELD == 'Read')
     									return 'Seq. Read';
     								else
     									return 'Seq. Write';
     							}
     								
     							
     						}
     					},
     					{
     						col:'AS_SSD_ORDER',
     						val: function(){
     							var sarr = this.SPEC.match(/([a-z]+)([\d]+[a-z]+)([\d]+)/i);
     							if(sarr != undefined){
     								//Random4K64TTest : ["Random4K64", "Random", "4K", "64"]
     								var rs = sarr[1];
     								var rst = '';
     								if(rs.match(/random/gi) != null)
     									rst = 'R.';
     								else
     									rst = 'Seq.';
     								var vol = sarr[2];
     								var speed = sarr[3];
     								var rw = this.FIELD;
     								var rwt = '';
     								if(rw.match(/read/gi) != null)
     									rwt = 'R';
     								else if(rw.match(/Write/gi) != null)
     									rwt = 'W';
     								
     								var speedt = '';
     								if(speed != undefined)
     									speedt = '('+speed+'Thrd)';
     								//return vol + ' ' + rst + rwt + speedt;
     								return vol + ' ' + speedt + rst + rwt ;
     								
     							}else if(this.SPEC == 'AccTimeTest'){
     								if(this.FIELD == 'Read')
     									return 'Access Time(Read)';
     								else
     									return 'Access Time(Write)';
     							}else {
     								if(this.FIELD == 'Read')
     									return '1';
     								else
     									return '2';
     							}
     								
     							
     						}
     					},
     					{
     						col:'AS_SSD_DUMMY',
     						val: function(){
     							return 'measure';
     						}
     					}
     				],
     				filters:[
     					{col:'FIELD',val:'Read'},
     					{col:'FIELD',val:'Write'}
     				],
     				xOderbyCols:['FIRMWARE1','AS_SSD_ORDER','AS_SSD_SPEC'],
     				categoryCols:['AS_SSD_SPEC'],
     				yCol:'MEASURE',
     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     				multichart:{
     					enabled:false,
     					cols:[]
     				},
     				gridSeriesColWidth: '100px',
	 	     		gridColWidth: '70px',
     				orderby: 230
     		 	},
     		 	{
     				category:'AS-SSD1.8.xml',
     				calculateCols:[
     					{
     						col:'AS_SSD_SPEC',
     						val: function(){
     							var sarr = this.SPEC.match(/([a-z]+)([\d]+[a-z]+)([\d]+)/i);
     							if(sarr != undefined){
     								//Random4K64TTest : ["Random4K64", "Random", "4K", "64"]
     								var rs = sarr[1];
     								var rst = '';
     								if(rs.match(/random/gi) != null)
     									rst = 'R.';
     								else
     									rst = 'Seq.';
     								var vol = sarr[2];
     								var speed = sarr[3];
     								var rw = this.FIELD;
     								var rwt = '';
     								if(rw.match(/read/gi) != null)
     									rwt = 'R';
     								else if(rw.match(/Write/gi) != null)
     									rwt = 'W';
     								
     								var speedt = '';
     								if(speed != undefined)
     									speedt = '('+speed+'Thrd)';
     								return vol + ' ' + rst + rwt + speedt;
     								
     							}else if(this.SPEC == 'AccTimeTest'){
     								if(this.FIELD == 'Read')
     									return 'Access Time(Read)';
     								else
     									return 'Access Time(Write)';
     							}else {
     								if(this.FIELD == 'Read')
     									return 'Seq. Read';
     								else
     									return 'Seq. Write';
     							}
     								
     							
     						}
     					},
     					{
     						col:'AS_SSD_ORDER',
     						val: function(){
     							var sarr = this.SPEC.match(/([a-z]+)([\d]+[a-z]+)([\d]+)/i);
     							if(sarr != undefined){
     								//Random4K64TTest : ["Random4K64", "Random", "4K", "64"]
     								var rs = sarr[1];
     								var rst = '';
     								if(rs.match(/random/gi) != null)
     									rst = 'R.';
     								else
     									rst = 'Seq.';
     								var vol = sarr[2];
     								var speed = sarr[3];
     								var rw = this.FIELD;
     								var rwt = '';
     								if(rw.match(/read/gi) != null)
     									rwt = 'R';
     								else if(rw.match(/Write/gi) != null)
     									rwt = 'W';
     								
     								var speedt = '';
     								if(speed != undefined)
     									speedt = '('+speed+'Thrd)';
     								//return vol + ' ' + rst + rwt + speedt;
     								return vol + ' ' + speedt + rst + rwt ;
     								
     							}else if(this.SPEC == 'AccTimeTest'){
     								if(this.FIELD == 'Read')
     									return 'Access Time(Read)';
     								else
     									return 'Access Time(Write)';
     							}else {
     								if(this.FIELD == 'Read')
     									return '1';
     								else
     									return '2';
     							}
     								
     							
     						}
     					},
     					{
     						col:'AS_SSD_DUMMY',
     						val: function(){
     							return 'measure';
     						}
     					}
     				],
     				filters:[
     					{col:'FIELD',val:'Read'},
     					{col:'FIELD',val:'Write'}
     				],
     				xOderbyCols:['FIRMWARE1','AS_SSD_ORDER','AS_SSD_SPEC'],
     				categoryCols:['AS_SSD_SPEC'],
     				yCol:'MEASURE',
     				yAxisTitle :' MB/s',
     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     				multichart:{
     					enabled:false,
     					cols:[]
     				},
     				gridSeriesColWidth: '100px',
	 	     		gridColWidth: '70px',
     				orderby: 240
     		 	},
	     		 // PCMARK_VANTAGE.xlsx
	     		 {
	     				category:'PCMARK_VANTAGE.xlsx',
	     				calculateCols:[
							{
								col:'IS_SCORE',
								val: function(){
									if(this.SPEC == 'Score'  ){
											return 'Score';
										}else{
											return 'NotScore';
										}
									
								}
							},                     
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC','IS_SCORE'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				yAxisTitle :'MB/s',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE',
	     					yAxisTitle:{NotScore:'MB/s'},
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 600
	     				},
	     				gridSeriesColWidth: '100px',
	     				gridColWidth: '65px',
	     				orderby: 250
	     		 },
	     		 {
	     				category:'PCMARK_VANTAGE_30GB.xlsx',
	     				calculateCols:[
							{
								col:'IS_SCORE',
								val: function(){
									if(this.SPEC == 'Score'  ){
											return 'Score';
										}else{
											return 'NotScore';
										}
									
								}
							},                     
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC','IS_SCORE'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				yAxisTitle :'MB/s',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE',
	     					yAxisTitle:{NotScore:'MB/s'},
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 600
	     				},
	     				gridSeriesColWidth: '100px',
	     				gridColWidth: '65px',
	     				orderby: 250
	     		 },
	     		 {
	     				category:'PCMARK_VANTAGE_60GB.xlsx',
	     				calculateCols:[
							{
								col:'IS_SCORE',
								val: function(){
									if(this.SPEC == 'Score'  ){
											return 'Score';
										}else{
											return 'NotScore';
										}
									
								}
							},                     
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC','IS_SCORE'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				yAxisTitle :'MB/s',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE',
	     					yAxisTitle:{NotScore:'MB/s'},
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 600
	     				},
	     				gridSeriesColWidth: '100px',
	     				gridColWidth: '65px',
	     				orderby: 250
	     		 },
	     		 {
	     				category:'PCMARK_VANTAGE_90GB.xlsx',
	     				calculateCols:[
							{
								col:'IS_SCORE',
								val: function(){
									if(this.SPEC == 'Score'  ){
											return 'Score';
										}else{
											return 'NotScore';
										}
									
								}
							},                     
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC','IS_SCORE'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				yAxisTitle :'MB/s',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE',
	     					yAxisTitle:{NotScore:'MB/s'},
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 600
	     				},
	     				gridSeriesColWidth: '100px',
	     				gridColWidth: '65px',
	     				orderby: 250
	     		 },
	     		 {
	     				category:'PCMARK_VANTAGE_120GB.xlsx',
	     				calculateCols:[
							{
								col:'IS_SCORE',
								val: function(){
									if(this.SPEC == 'Score'  ){
											return 'Score';
										}else{
											return 'NotScore';
										}
									
								}
							},                     
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC','IS_SCORE'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				yAxisTitle :'MB/s',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE',
	     					yAxisTitle:{NotScore:'MB/s'},
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 600
	     				},
	     				gridSeriesColWidth: '100px',
	     				gridColWidth: '65px',
	     				orderby: 250
	     		 },
	     		 //PCMARK7.txt
	     		 {
	     				category:'PCMARK7.txt',
	     				calculateCols:[
							{
								col:'IS_SCORE',
								val: function(){
									if(this.SPEC.match(/Score/gi) != null  ){
											return 'Score';
										}else{
											return 'NotScore';
										}
									
								}
							},         
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				yAxisTitle :' MB/s',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE',
	     					yAxisTitle:{NotScore:'MB/s'},
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 600
	     				},
	     				gridSeriesColWidth: '100px',
		 	     		gridColWidth: '80px',
	     				orderby: 260
	     		 },
	     		 {
	     				category:'PCMARK8.xml',
	     				calculateCols:[
						{
							col:'IS_SCORE',
							val: function(){
								if(this.SPEC.match(/Score/gi) != null  ){
										return 'Score';
									}else{
										return 'NotScore';
									}
								
							}
						},         
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				yAxisTitle :' MB/s',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE',
	     					yAxisTitle:{NotScore:'MB/s'},
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 600
	     				},
	     				gridColWidth: '140px',
	     				orderby: 270
	     		 },
	     		{
	     				category:'POR.txt',
	     				calculateCols:[
	     					
	     					{
	     						col:'POR_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:false,
	     					cols:[]
	     				},
	     				orderby: 280
	     		 },
	     		 {
	     				category:'SPOR.txt',
	     				calculateCols:[
	     					{
	     						col:'POR_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:false,
	     					cols:[]
	     				},
	     				orderby: 290
	     		 },
     		 	{
     				category:'SYSMARK2014.fdr',
     				calculateCols:[
     					{
     						col:'SYSMARK_DUMMY',
     						val: function(){
     							return 'measure';
     						}
     					}
     				],
     				filters:[
     				],
     				xOderbyCols:['FIRMWARE1','SPEC'],
     				categoryCols:['SPEC'],
     				yCol:'MEASURE',
     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     				multichart:{
     					enabled:false,
     					cols:[]
     				},
     				orderby: 300
     		 	},
     		 	// Sustain 보류
     		 //========= ESSD Start ============//
     		{
   					category:'result_HBA.csv', //Max Throughput.csv 참조
   					calculateCols:[
						
   					    {
   					    	col: 'PreCond_QD',
   					    	val:function(){
   					    		var specSplit = this.SPEC.split("_");
   					    		return specSplit[0] + "_" + this.QUEUE_DEPTH + "_" + this.FIELD;
   					    	}
   					    },
   					 	{
   					    	col: 'QoS',
   					    	val:function(){
   					    		if(this.FIELD == 'ReadQoS(3-nine)' || this.FIELD == 'WriteQoS(3-nine)')
   					    			return 'QoS-3nine';
   					    		if(this.FIELD == 'ReadQoS(6-nine)' || this.FIELD == 'WriteQoS(6-nine)')
   					    			return 'QoS-6nine';
   					    		
   					    	}
   					    },
   					 	{
   					    	col: 'isQoS',
   					    	val:function(){
   					    		if(this.SPEC.match(/128k/i) != null)
   					    			return false;
   					    		else if(this.FIELD == 'ReadQoS(3-nine)' || this.FIELD == 'WriteQoS(3-nine)' || this.FIELD == 'ReadQoS(6-nine)' || this.FIELD == 'WriteQoS(6-nine)')
   					    			return true;
   					    		else 
   					    			return false;
   					    	}
   					    },
   					 	{
   					    	col: 'PreCond_Field',
   					    	val:function(){
   					    		var specSplit = this.SPEC.split("_");
   					    		if(this.isQoS)
   					    			return specSplit[0] + "_" + this.QoS;
   					    		else 
   					    			return specSplit[0] + "_" + this.FIELD;
   					    	}
   					    },   					    
   					 	{
   					    	col: 'BlockSize',
   					    	val:function(){
   					    		var specSplit = this.SPEC.split("_");
   					    		if(specSplit[1].match(/[\d]+/i) != null)
   					    			return parseInt(specSplit[1].match(/[\d]+/i)[0]);
   					    		else
   					    			return 0;
   					    	}
   					    },
	   					 {
	   					    	col: 'SizeUnit',
	   					    	val:function(){
	   					    		var specSplit = this.SPEC.split("_");
	   					    		if(specSplit[1].match(/[a-z]+/i) != null)
	   					    			return specSplit[1].match(/[a-z]+/i)[0];
	   					    		else
	   					    			return 0;
	   					    	}
	   					    },
	   					 	{
	   					    	col: 'isDisplay',
	   					    	val:function(){
	   					    		var specSplit = this.SPEC.split("_");
	   					    		if(this.FIELD == 'MBps')
	   					    			return 'O';
	   					    		else if(this.FIELD == 'IOPS')
	   					    			return 'O';
	   					    		else if(specSplit[0] == 'Sustained' && this.FIELD == 'Consistency')
	   					    			return 'O';
	   					    		else if(specSplit[0] == 'Sustained' && this.isQoS && this.MEASURE > 0 )
	   					    			return 'O';
	   					    		else
	   					    			return 'X';
	   					    		
	   					    	}
	   					    },
	   					 	{
	   					    	col: 'isDisplay',
	   					    	val:function(){
	   					    		var specSplit = this.SPEC.split("_");
	   					    		if(this.FIELD == 'MBps')
	   					    			return 'O';
	   					    		else if(this.FIELD == 'IOPS')
	   					    			return 'O';
	   					    		else if(specSplit[0] == 'Sustained' && this.FIELD == 'Consistency')
	   					    			return 'O';
	   					    		else if(specSplit[0] == 'Sustained' && this.isQoS && this.MEASURE > 0 )
	   					    			return 'O';
	   					    		else
	   					    			return 'X';
	   					    		
	   					    	}
	   					    },
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/Seq_Read/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/Rnd_Read/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/Seq_Write/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/Rnd_Write/gi) != null ){
											return 4;
										}else{
											return 100;
										}
									
								}
							},
							{
							   	col: 'essdSpec',
							   	val:function(){
							   		var specSplit = this.SPEC.split("_");
							   		var spec = "";
							   		
							   		// rnd seq
							   		var RS = "";
							   		if(specSplit[2] != undefined)
							   			RS = specSplit[2];
							   		if(RS.match(/rnd/gi)  != null)
							   			RS = "Rnd";
							   		else if(RS.match(/seq/gi)  != null)
							   			RS = "Seq";
							   		else
							   			RS = specSplit[2];
							   		
							   		// read write
							   		var RW = "";							   		
							   		if(specSplit[3] != undefined)
							   			RW = specSplit[3];
							   		if(RW.match(/read/gi)  != null)
							   			RW = "R";
							   		else if(RW.match(/write/gi)  != null)
							   			RW = "W";
							   		else
							   			RW = specSplit[3];
							   		
							   		if(this.isQoS && specSplit[3] == "RW70" && this.FIELD.match(/^read/gi) != null)
							   			spec = this.BlockSize + this.SizeUnit + "_" + RS  + "" +"R70" + "_QD"+ this.QUEUE_DEPTH;
							   		else if(this.isQoS && specSplit[3] == "RW70" && this.FIELD.match(/^write/gi) != null)
							   			spec = this.BlockSize + this.SizeUnit + "_" + RS  + "" +"W70" + "_QD"+ this.QUEUE_DEPTH;
							   		else
							   			spec = this.BlockSize + this.SizeUnit + "_" + RS  + "" +RW + "_QD"+ this.QUEUE_DEPTH;
							   		return spec;
							   	}
							 },
							 // y축 표시를 위해
							 {
	   					    	col: 'yAxisTitle',
	   					    	val:function(){
	   					    		if(this.isQoS)
	   					    			return this.QoS;
	   					    		else
	   					    			return this.FIELD;
	   					    		
	   					    	}
	   					    }
						
   					],
   					filters:[
   						//{col:'FIELD',val:'MBps'},
   						//{col:'FIELD',val:'IOPS'},
   						//{col:'FIELD',val:'Consistency'}
   						//{col:'isQoS',val:true},
   						{col:'isDisplay',val: 'O'}
   					],
   					xOderbyCols:['FIRMWARE1','PreCond_Field',['QUEUE_DEPTH','desc'],'BlockSize','ORDER'],
   					categoryCols:['PreCond_Field','essdSpec'],
   					yCol:'MEASURE',
   					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
   					multichart:{
   						enabled:true,
   						splitCol:'PreCond_Field',
   						orderBy : function(){
   							if(this.PreCond_Field.match(/fob/gi) != null  ){
								return 10;
							}else if(this.PreCond_Field.match(/sustained_iops/gi) != null  ){
								return 20;
							}else if(this.PreCond_Field.match(/sustained_mbps/gi) != null ){
								return 30;
							}else if(this.PreCond_Field.match(/sustained_consistency/gi) != null ){
								return 40;
							}else{
								return 100;
							}
							
						},
   						chartWidth: 50 , // percent 로 표시
   						oneLineChatNum: 2,
   						customStyle: [
   							{
   								name: 'FOB', // 시리즈명이 앞부분과 일치
   								chartWidth: 50,
   								oneLineChatNum: 2
   							},
   							{
   								name: 'Sustain',
   								chartWidth: 100,
   								oneLineChatNum: 1
   							}
   						]
   						             
   					}
   					,orderby: 10
   			 },
   			{
					category:'cardspec.csv', //Max Throughput.csv 참조
					calculateCols:[
						
					    {
					    	col: 'PreCond_QD',
					    	val:function(){
					    		var specSplit = this.SPEC.split("_");
					    		return specSplit[0] + "_" + this.QUEUE_DEPTH + "_" + this.FIELD;
					    	}
					    },
					 	{
					    	col: 'QoS',
					    	val:function(){
					    		if(this.FIELD == 'ReadQoS(3-nine)' || this.FIELD == 'WriteQoS(3-nine)')
					    			return 'QoS-3nine';
					    		if(this.FIELD == 'ReadQoS(6-nine)' || this.FIELD == 'WriteQoS(6-nine)')
					    			return 'QoS-6nine';
					    		
					    	}
					    },
					 	{
					    	col: 'isQoS',
					    	val:function(){
					    		if(this.SPEC.match(/128/i) != null)
					    			return false;
					    		else if(this.FIELD == 'ReadQoS(3-nine)' || this.FIELD == 'WriteQoS(3-nine)' || this.FIELD == 'ReadQoS(6-nine)' || this.FIELD == 'WriteQoS(6-nine)')
					    			return true;
					    		else 
					    			return false;
					    	}
					    },
					 	{
					    	col: 'PreCond_Field',
					    	val:function(){
					    		var rtn = "";
					    		var specSplit = this.SPEC.split("_");
					    		if(this.isQoS)
					    			rtn = specSplit[0] + "_" + this.QoS;
					    		else if(specSplit[0].match(/sust/i) != null)
					    			rtn = specSplit[0] + "_" + this.FIELD + "_" +specSplit[2];
					    		else
					    			rtn =  specSplit[0] + "_" + this.FIELD;
					    		
					    		return rtn;
					    	}
					    },   					    
					 	{
					    	col: 'BlockSize',
					    	val:function(){
					    		var specSplit = this.SPEC.split("_");
					    		if(specSplit[1].match(/[\d]+/i) != null)
					    			return parseInt(specSplit[1].match(/[\d]+/i)[0]);
					    		else
					    			return 0;
					    	}
					    },
	   					 {
	   					    	col: 'SizeUnit',
	   					    	val:function(){
	   					    		var specSplit = this.SPEC.split("_");
	   					    		if(specSplit[1].match(/[a-z]+/i) != null)
	   					    			return specSplit[1].match(/[a-z]+/i)[0];
	   					    		else
	   					    			return 0;
	   					    	}
	   					    },
	   					 	{
	   					    	col: 'isDisplay',
	   					    	val:function(){
	   					    		var specSplit = this.SPEC.split("_");
	   					    		
	   					    		if(specSplit[0] == 'POST' ){
	   					    			var aaa  = 'aaa';
	   					    		}
	   					    		
	   					    	 	if(specSplit[0] == 'POST')
	   					    			return 'X';
	   					    		else if(this.FIELD == 'MBps')
	   					    			return 'O';
	   					    		else if(this.FIELD == 'IOPS')
	   					    			return 'O';
	   					    		else if(specSplit[0] == 'SUST' && this.FIELD == 'Consistency(%)')
	   					    			return 'O';
	   					    		else if(specSplit[0] == 'SUST' && this.isQoS && this.MEASURE > 0 )
	   					    			return 'O';
	   					    		else if(specSplit[0] == 'POST' && this.FIELD == 'Consistency(%)')
	   					    			return 'X';
	   					    		else if(specSplit[0] == 'POST' && this.isQoS && this.MEASURE > 0 )
	   					    			return 'X';
	   					    		else
	   					    			return 'X';
	   					    		
	   					    	}
	   					    },
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/Seq_Read/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/Rnd_Read/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/Seq_Write/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/Rnd_Write/gi) != null ){
											return 4;
										}else{
											return 100;
										}
									
								}
							},
							{
							   	col: 'essdSpec',
							   	val:function(){
							   		var specSplit = this.SPEC.split("_");
							   		var spec = "";
							   		
							   		// rnd seq
							   		var RS = "";
							   		if(specSplit[2] != undefined)
							   			RS = specSplit[2];
							   		if(RS.match(/rnd/gi)  != null)
							   			RS = "Rnd";
							   		else if(RS.match(/seq/gi)  != null)
							   			RS = "Seq";
							   		else
							   			RS = specSplit[2];
							   		
							   		// read write
							   		var RW = "";							   		
							   		if(specSplit[3] != undefined)
							   			RW = specSplit[3];
							   		if(RW.match(/read/gi)  != null)
							   			RW = "R";
							   		else if(RW.match(/write/gi)  != null)
							   			RW = "W";
							   		else
							   			RW = specSplit[3];
							   		
							   		if(this.isQoS && specSplit[3] == "RW70" && this.FIELD.match(/^read/gi) != null)
							   			spec = this.BlockSize + this.SizeUnit + "_" + RS  + "" +"R70" + "_QD"+ this.QUEUE_DEPTH;
							   		else if(this.isQoS && specSplit[3] == "RW70" && this.FIELD.match(/^write/gi) != null)
							   			spec = this.BlockSize + this.SizeUnit + "_" + RS  + "" +"W70" + "_QD"+ this.QUEUE_DEPTH;
							   		else
							   			spec = this.BlockSize + this.SizeUnit + "_" + RS  + "" +RW + "_QD"+ this.QUEUE_DEPTH;
							   		return spec;
							   	}
							 },
							 {
								   	col: 'rndSeq',
								   	val:function(){
								   		var specSplit = this.SPEC.split("_");
								   		var spec = "";
								   		
								   		// rnd seq
								   		var RS = "";
								   		if(specSplit[2] != undefined)
								   			RS = specSplit[2];
								   		if(RS.match(/rnd/gi)  != null)
								   			RS = "Rnd";
								   		else if(RS.match(/seq/gi)  != null)
								   			RS = "Seq";
								   		else
								   			RS = specSplit[2];
								   		
								   		return RS;
								   	}
							},
							 // y축 표시를 위해
							 {
	   					    	col: 'yAxisTitle',
	   					    	val:function(){
	   					    		if(this.isQoS)
	   					    			return this.QoS;
	   					    		else
	   					    			return this.FIELD;
	   					    		
	   					    	}
	   					    }
						
					],
					filters:[
						//{col:'FIELD',val:'MBps'},
						//{col:'FIELD',val:'IOPS'},
						//{col:'FIELD',val:'Consistency'}
						//{col:'isQoS',val:true},
						{col:'isDisplay',val: 'O'}
					],
					xOderbyCols:['FIRMWARE1','PreCond_Field',['QUEUE_DEPTH','desc'],'BlockSize','ORDER'],
					categoryCols:['PreCond_Field','essdSpec'],
					yCol:'MEASURE',
					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
					multichart:{
						enabled:true,
						splitCol:'PreCond_Field',
						orderBy : function(){
							if(this.PreCond_Field.match(/fob/gi) != null  ){
								return 10;
							}else if(this.PreCond_Field.match(/sust_iops/gi) != null  ){
								if(this.PreCond_Field.match(/_seq/gi) != null )
									return 20;
								else 
									return 21;
							}else if(this.PreCond_Field.match(/sust_mbps/gi) != null ){
								if(this.PreCond_Field.match(/_seq/gi) != null )
									return 30;
								else 
									return 31;
							}else if(this.PreCond_Field.match(/sust_consistency/gi) != null ){
								if(this.PreCond_Field.match(/_seq/gi) != null )
									return 40;
								else 
									return 41;
							}else if(this.PreCond_Field.match(/sust_/gi) != null ){
								if(this.PreCond_Field.match(/_seq/gi) != null )
									return 50;
								else 
									return 51;
							}else if(this.PreCond_Field.match(/post_iops/gi) != null  ){
								return 60;
							}else if(this.PreCond_Field.match(/post_mbps/gi) != null ){
								return 70;
							}else if(this.PreCond_Field.match(/post_consistency/gi) != null ){
								return 80;
							}else if(this.PreCond_Field.match(/post_/gi) != null ){
								return 90;
							}else{
								return 100;
							}
							
						},
						chartWidth: 50 , // percent 로 표시
						oneLineChatNum: 2,
						customStyle: [ //splitCol 정규식
							{
								name: 'FOB', 
								chartWidth: 50,
								oneLineChatNum: 2
							},
							{
								name: 'sust_(iops|mbps|Consistency)',
								chartWidth: 50,
								oneLineChatNum: 2
							},
							{
								name: 'sust_Qos',
								chartWidth: 100,
								oneLineChatNum: 1
							},
							{
								name: 'POST',
								chartWidth: 100,
								oneLineChatNum: 1
							}
						]
						             
					}
					,orderby: 10
			 }
     		//========= ESSD End ============//
	     		 
	     	];
	
		// 새롭게 추가된 PCI 2017년 9월 27일 수요일 오후 2:34:37
		$.each(category_new,function(i,ca){
			categoryInfo.push(ca);
		});
		
		// 새롭게 추가된 PCI 2017년 9월 27일 수요일 오후 2:34:37
		$.each(category_sustain,function(i,ca){
			categoryInfo.push(ca);
		});
		
	
	//공통적인 컬럼. 
	$.each(categoryInfo,function(){
		this.calculateCols.push(
			{
				col: 'FIRMWARE1',
				val: function(){
					
					var folder = dataFilter( multiSearchObj.analysisList,[{col:'FOLDER_NAME',val:this.FOLDER_NAME}]);
					var gubun = folder[0].target;
					if(folder.length > 0){
						if($.isNumeric(gubun)){
							return this.PRODUCT_NAME + '_' + this.FORM_FACTOR + '_' +  this.CAPACITY + '_' +  this.FIRMWARE + '_' + this.SERIAL_NUMBER;
						}else{
							return folder[0].target + '_' + this.PRODUCT_NAME + '_' + this.FORM_FACTOR + '_' +  this.CAPACITY + '_' +  this.FIRMWARE + '_' + this.SERIAL_NUMBER;
						}
						
					}
					else 
						return this.PRODUCT_NAME + '_' + this.FORM_FACTOR + '_' + this.CAPACITY + '_' +  this.FIRMWARE;
				}
			}
		);
		
		//add series compare
		if(this.addSeries == undefined)
			this.addSeries = [];
		var filters = dataFilter(this.addSeries,[{col:'name',val:'Compare'}]);
		if(filters.length == 0 && this.category.match(/Mixed_/gi) == null){			
			this.addSeries.push(
				{
					name: 'Compare',
					type: 'spline',
					yAxis : {
						title: 'increase rate',
						opposite: true,
						labels:{
							format:'{value:.1f}'
						},
						//EI-1057 No.2: (반영예정) 추세선의 기준선 위치 고정 : 중간을 0%로 해서 고정. 기준으로 오르락 변경되는데, 잘 못 이해할 수 있겠네요.
			            plotLines: [{
			                color: 'blue',
			                width: 2,
			                dashStyle: "Solid",
			                value: 0,
			                zIndex:3
			            }]
						, minRange: 2
						//, minorTickInterval: 2
					},
					seriesFunction: function(){
						var series = arguments;
						var addS = this;
						
						// EI-1057 No. 6. (반영예정) 2개 비교 여러 개로 확장
						if(series.length != 2)
							return false;
						$.each(series[0].data,function(dataIndex,d){
							
							var diff = series[1].data[dataIndex].y - d.y;
							var increase = 0;
							if(d.y > 0){
								increase = (diff/d.y) * 100;
							}
							addS.data[dataIndex] = {
								y : increase ,
								diff: diff 
							};
						});	
						var min = minValue(addS.data,'y');
						var max = maxValue(addS.data,'y');
						var max1 = Math.max(Math.abs(min),Math.abs(max));
						addS.yAxis.min = max1*-1;
						addS.yAxis.max = max1;
						
						addS.yAxis = 1;
						addS.dataLabels = {
							enabled:false,
							format:'{point.y:.2f}%({point.diff:.2f})'
						};
						addS.tooltip = {
							pointFormat:'{series.name}: <b>{point.y:.2f}%({point.diff:.2f})</b>'
						};
						addS.color = '#24CBE5';
						
						return true;
					}
				}
			);
		}
		//add series compare end
		//
		
	});
	
	Highcharts.setOptions({
        //colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
		colors: ['#058DC7', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
    });
	</script>
	
	<style type="text/css" title="main">
	
		html, body,form {
	        /* height: 100%; */
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
	    
	    
		
	</style>
</head>
<body  style="min-width:920px ">
<form name="form" id="form" class="">
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<%-- <input type="hidden" id="category" name="category" value="${param.category}"/> --%>
<input type="hidden" id="report" name="report" value="N"/>

<div id="searchContainer" align="left" class="dashboard-div container">
	<div id="searchCondition"></div>
	<div id="selectContainer" style="margin-top: 10px;">
	</div>
	<div id="jqgrid" style="width:100%;/* display:inline-block;float:left; */">
		<table id="jqgridTable"></table>
		<div id="jqgridPager"></div>
	</div>
</div>
<div  id="container" class="dashboard-div container">
	<ul class="nav nav-tabs"></ul>
	  <div class="tab-content"></div>
</div>
<div id="loader"></div>
</form>
<form name="formReport" id="formReport" class="">
<input type="hidden" id="searchJson" name="searchJson" value=""/>
</form>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</body>
 <div id="dialog-confirm"></div>
</html>
