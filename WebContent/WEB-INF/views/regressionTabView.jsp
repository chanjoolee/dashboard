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
	
	<%-- File Saver --%>
	<script type="text/javascript" src="/dashboard/js/FileSaver.js/FileSaver.js" charset="utf-8"></script>
	<script type="text/javascript" src="/dashboard/js/jquery-zclip-master/jquery.zclip.js"></script>
	<script type="text/javascript" title="schemaSearchCondition">
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
											id: 'testDateHead',
											name: 'testDateHead',
											label:'',
											text:'Test Date',
											width: '60px'
										}
										,{
											type: 'dateInput',
											id: 'dateFrom',
											name: 'dateFrom',
											label:'',
											value:'',
											//width:'100px',
										//		cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												
											],
											controlCss:[
												{code: 'text-align', value:'center'},
												{code: 'height', value:'22px'},
												{code: 'margin-left', value:'10px'},
												{code: 'width', value:'100px'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												},
												change: function(){
													//alert($(this).val());
													changeProduct();
													changeProductTestType();
													changeProductFw();
													changeProductCapacity();
													getDataByJson();
												}
											},
											value: function(){
												var today = new Date();
										    	var year = today.getFullYear();
										    	var month = today.getMonth();
										    	var date = today.getDate();
										    	
										    	var startDate = new Date(year,month-6,date+1);
										    	
										    	return startDate.toISOString('YYYY-MM-DD').substr(0,10);
										    	//$("#dateButtonFrom").val(startDate.toISOString('YYYY-MM-DD').substr(0,10));
										    	//$("#dateButtonFrom").val(today.toISOString('YYYY-MM-DD').substr(0,10));
											}
										}
										,{
											type: 'dateButton',
											id: 'dateButtonFrom',
											name: 'dateButtonFrom',
											label:'',
											parentContainerId:'dateFromContainer',
											value: function(){
												
											},
											//width:'100px',
											cls: 'btn_date',
											containerCss:[
											              
											],
											controlCss:[
												{code: 'margin-left', value:'0'}
												//,{code: 'margin-top', value:'-4px'}
											],
											events:{
												click : function(){
													calendar.calendar_show(event, this, 'dateFrom');
												}
											}
										}
										,{
											type:'SearchHeader',
											id: 'testDateBetweenHead',
											name: 'testDateBetweenHead',
											label:'',
											text:' ~ ',
											width: '10px',
											containerCss:[
												{code: 'margin-left', value:'0'}       
											],
											controlCss:[
												{code: 'width', value:'10px'}
												
											]
										}
										,{
											type: 'dateInput',
											id: 'dateTo',
											name: 'dateTo',
											label:'',
											value:'',
											//width:'100px',
										//		cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												{code: 'margin-left', value:'4px'},
											],
											controlCss:[
												{code: 'text-align', value:'center'},
												{code: 'height', value:'22px'},
												{code: 'width', value:'100px'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												},
												change: function(){
													//alert($(this).val());
													changeProduct();
													changeProductTestType();
													changeProductFw();
													changeProductCapacity();
													getDataByJson();
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
										}
										,{
											type: 'dateButton',
											id: 'dateButtonTo',
											name: 'dateButtonTo',
											label:'',
											value:'',
											parentContainerId:'dateToContainer',
											//width:'100px',
											cls: 'btn_date',
											containerCss:[
											],
											controlCss:[
												{code: 'margin-left', value:'0'}
												//,{code: 'margin-top', value:'-4px'}
											],
											events:{
												click : function(){
													calendar.calendar_show(event, this, 'dateTo');
												}
											}
										}
										
									]
								},
								//2line
								{
									label:'',
									type: 'HorizontalLayout',
									containerCss:[
							    		{code:'height',value:'30px'}
							    	],
									elements:[
										{
											type:'SearchHeader',
											id: 'productHead',
											name: 'productHead',
											label:'',
											text:'Product',
											width: '60px'
										},
										{
											type:'multiCombo',
											id: 'searchProduct',
											name: 'searchProduct',
											label:'',
											text:'product',
											width: '150px',
											data: function(){
												
												var rtnList = [];	
												var vPjtCode = "";
												var rndModels = [];
												var pmsModels = [];
												
												$.ajax({
										    		url: "/dashboard/pmsModelListJson.html",
										    		data: {}, 
										    		async: false,
										    		success:  function(response){
										    			pmsModels  = response.dataList;				
										    			
										    		}
										    	});
												
												$.ajax({
										    		url: "/dashboard/reliabilityModelListJson.html",
										    		data: $('form').serialize(), 
										    		async: false,
										    		success:  function(response){
										    			rndModels  = response.dataList;	
										    			$.each(rndModels,function(){
										    				var pmsModel = dataFilter(pmsModels,[{col:'MODEL_NM',val:this.MODEL_NM}]);
										    				if(pmsModel.length > 0 ){
										    					var o = pmsModel[0];
										    					this.PJT_ID = o.PJT_ID;
										    				}
										    			});
										    			rtnList = rndModels;
										    			
										    		}
										    	});
												
												var pjtId = $("#pjtId").val();
												$.each(rtnList,function(){													
													if(pjtId != '' && this.PJT_ID == pjtId){
														this.selected = 'selected';	
													}else if(pjtId == ''){
														this.selected = 'selected';	
													}
													
												});
												
												
												return rtnList;
											},
											options: {
												isSingle: false,
												cd:'MODEL_NM',
												name:'MODEL_NM'					
											},
											events: {
												change: function(){
													$("#loader").show();													
													setTimeout( function(){
														changeProductTestType();
														changeProductFw();
														changeProductCapacity();
														getDataByJson();
														
													
													},0);
												}
											}
										}
										
									]
								},
								//3line
								{
									label:'',
									type: 'HorizontalLayout',
									containerCss:[
							    		{code:'height',value:'30px'}
							    	],
									elements:[
										{
											type:'SearchHeader',
											id: 'testTypeHead',
											name: 'testTypeHead',
											label:'',
											text:'Test Type',
											width: '60px'
										}
										,{
											type:'multiCombo',
											id: 'searchTestType',
											name: 'searchTestType',
											label:'',
											text:'testType',
											width: '150px',
											data: function(){
												var rtnList = [];	
												var vPjtCode = "";
												$.ajax({
										    		url: "/dashboard/reliabilityTestTypeListJson.html?searchProduct=xxx",
										    		data: $('form').serialize(), 
										    		async: false,
										    		success:  function(response){
										    			rtnList  = response.dataList;										    				
										    		}
										    	});
												
												$.each(rtnList,function(){
													this.selected = 'selected';	
												})
												
												
												return rtnList;
											},
											options: {
												isSingle: false,
												cd:'TESTNM',
												name:'TESTNM'					
											},
											events: {
												change: function(){
													changeProductFw();
													changeProductCapacity();
													getDataByJson();
												}
											}
										} 
										,{
											type:'SearchHeader',
											id: 'FWversionHead',
											name: 'FWversionHead',
											label:'',
											text:'FW Version',
											width: '70px'
										}
										,{
											type:'multiCombo',
											id: 'searchFWversion',
											name: 'searchFWversion',
											label:'',
											text:'FW Version',
											width: '150px',
											data: function(){
												var rtnList = [];	
												var vPjtCode = "";
												$.ajax({
										    		url: "/dashboard/reliabilityFWVersionListJson.html?searchProduct=xxx&searchTestType=xxx",
										    		data: $('form').serialize(), 
										    		async: false,
										    		success:  function(response){
										    			rtnList  = response.dataList;										    				
										    		}
										    	});
												
												$.each(rtnList,function(){
													this.selected = 'selected';	
												})
												
												
												return rtnList;
											},
											options: {
												isSingle: false,
												cd:'FIRMWARE',
												name:'FIRMWARE'					
											},
											events: {
												change: function(){
													changeProductCapacity();
													getDataByJson();
												}
											}
										} 
										,{
											type:'SearchHeader',
											id: 'capacityHead',
											name: 'capacityHead',
											label:'',
											text:'Capacity',
											width: '50px'
										}
										,{
											type:'multiCombo',
											id: 'searchCapacity',
											name: 'searchCapacity',
											label:'',
											text:'Capacity',
											width: '150px',
											data: function(){
												var rtnList = [];	
												var vPjtCode = "";
												$.ajax({
										    		url: "/dashboard/reliabilityCapacityListJson.html?searchProduct=xxx&searchTestType=xxx&searchFWversion=xxx",
										    		data: $('form').serialize(), 
										    		async: false,
										    		success:  function(response){
										    			rtnList  = response.dataList;										    				
										    		}
										    	});
												
												$.each(rtnList,function(){
													this.selected = 'selected';	
												})
												
												
												return rtnList;
											},
											options: {
												isSingle: false,
												cd:'CAPACITY',
												name:'CAPACITY'					
											},
											events: {
												change: function(){
													getDataByJson();
												}
											}
										}
										
									]
								}
								// end 3line
								
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
													var theGrid = $("#searchGridTable");
													var selIds = theGrid.jqGrid('getGridParam','selarrrow');													
													if(selIds.length == 0){
														alert("select more than one item!");
														return;
													}
														
													isDataSmart = false;
													isDataHostinfo = false;
													isDataPecount = false;
													isDataErrolog = false;													
													$("[id^=content]").html("");
													
													theGrid.jqGrid('setGridState','hidden');													
													fnChgSystem('tabSmart','Smart');
													
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
	
	var schemaSmart = {
			containerId:'contentSmart',
			type:'HorizontalLayout',
			label:'',
			elements:[ 
				{
					containerCss:[
						{code: 'display', value:''},
						{code: 'float', value:'left'},
						{code: 'height', value:'600px'},
					],					
					type:'chart',
   	            	id: 'user',
   	            	label:'',
   	            	width: '49%',
   	            	height:'600px',
   	            	data: function(){
   	            		return dummydata();
   	            	},
   	            	options: function(){
   	            		return dummyoption();
   	            	}
   	            }
				,{
					type: 'Vertical',
					label: '',	
					width:'49%',
					elements:[
						{							
							type:'chart',
	    	            	id: 'block',
	    	            	label:'',
	    	            	width: '99%',
	    	            	data: function(){
	    	            		return dummydata();
	    	            	},
	    	            	options: function(){
	    	            		return dummyoption();
	    	            	}
	    	            },
	    	            {							
							type:'chart',
	    	            	id: 'block1',
	    	            	label:'',
	    	            	width: '99%',
	    	            	data: function(){
	    	            		return dummydata();
	    	            	},
	    	            	options: function(){
	    	            		return dummyoption();
	    	            	}
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
			var series = {};
			var options = _schema.options();
			if(_schema.data != undefined && typeof _schema.data == 'function'){
				var vData = _schema.data();
				series = vData.series;
				options.series = vData.series.series;
				if(vData.xAxis != undefined)
					options.xAxis = vData.xAxis;
			}
// 			var chartUser = Highcharts.stockChart($(mainContainer).attr('id') ,options,function(chart){
		    	
// 	 		});
			
			$(mainContainer).highcharts(options,function(chart){
		    	
			 });
			
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
	
	var folderList = [];	
	var dataSmart = [];
	var dataHostinfo = [];
	var dataPecount = [];
	var dataErrorlog = [];
	var dataSmart = [];
	
	var isDataSmart = false;
	var isDataHostinfo = false;
	var isDataPecount = false;
	var isDataErrolog = false;
	
	$(function () {
		
		makeHtml('searchCondition',schemaSearch);
		gridInit();
		getGridData();
	});
	
	function gridInit(){
		var theGrid = $("#searchGridTable");
		var vColModel = [
			{name: 'FOLDER_NAME', index: 'FOLDER_NAME', width: '600px', editable: false}
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
		        multiboxonly:true,
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
			url : "/dashboard/regressionTabViewFolderListJson.html",
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
	
	
	
	function getDataSmart(){
		
		if(!isDataSmart){
			makeHtml('contentSmart',schemaSmart);
			isDataSmart = true;
		}
		
	}
	
	function getDataHostinfo(){
		
	}
	
	function getDataPecount(){
		
	}
	
	function getDataErrorlog(){
		
	}
	
	function fnChgSystem(tab,container){
		
		$(".tab_2depth li").removeClass('on');
		$(".tab_2depth li").addClass('off');
		$("#"+tab).removeClass('off');
		$("#"+tab).addClass('on');
		$("[id^=content]").hide();
		$("#content"+container).show();
		
		eval('getData' + container+'()');
		
	}
	
	
	
	
	function getSimpleArray(arr,searchArr,col){
		var rtn = [];
		var filtered = dataFilter(arr,searchArr);
		$.each(filtered,function(i,val){
			rtn.push(val[col]);
		});
		return rtn;
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
	
	function dummydata(){
		var rtn = {};
		
		var series = {};
		series.series = [{
	        name: 'Installation',
	        data: [43934, 52503, 57177, 69658, 97031, 119931, 137133, 154175]
	    }, {
	        name: 'Manufacturing',
	        data: [24916, 24064, 29742, 29851, 32490, 30282, 38121, 40434]
	    }, {
	        name: 'Sales & Distribution',
	        data: [11744, 17722, 16005, 19771, 20185, 24377, 32147, 39387]
	    }, {
	        name: 'Project Development',
	        data: [null, null, 7988, 12169, 15112, 22452, 34400, 34227]
	    }, {
	        name: 'Other',
	        data: [12908, 5948, 8105, 11248, 8989, 11816, 18274, 18111]
	    }];
		
		
		rtn.series = series;
		
		return rtn;
	}
	
	function dummyoption(){
		var opt = {
			
			    title: {
			        text: 'Solar Employment Growth by Sector, 2010-2016'
			    },

			    subtitle: {
			        text: 'Source: thesolarfoundation.com'
			    },

			    yAxis: {
			        title: {
			            text: 'Number of Employees'
			        }
			    },
			    legend: {
			        layout: 'vertical',
			        align: 'right',
			        verticalAlign: 'middle'
			    },

			    plotOptions: {
			        series: {
			            pointStart: 2010
			        }
			    }
		}
		return opt;
	}
	
	
	
	Highcharts.setOptions({
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

<div id="searchCondition"></div>
<div id="searchGrid" style="width:100% ;margin-top: 10px;/* display:inline-block;float:left; */">
	<table id="searchGridTable"></table>
	<div id="searchGridPager"></div>
</div>
<div id="tabContainer" class="tit_btn m_top_10" >
	<ul class="tab_2depth">
       	<li class="on" id="tabSmart" target="smart">
       		<a href="javascript:fnChgSystem('tabSmart','Smart');" onclick="">Smart</a>
       	</li>
       	<li class="off" id="tabHostinfo" target="block">
       		<a href="javascript:fnChgSystem('tabHostinfo','Hostinfo');" onclick="">HostInfo</a>
       	</li>
       	<li class="off" id="tabPecount" target="pecount">
       		<a href="javascript:fnChgSystem('tabPecount','Pecount');" onclick="">PECount</a>
       	</li>
       	<li class="off" id="tabErrorlog" target="errorlog">
       		<a href="javascript:fnChgSystem('tabErrorlog','Errorlog');" onclick="">Error log</a>
       	</li>
	</ul>
</div>
<div id="contentSmart" style="margin-top: 10px;width: 100%"></div>
<div id="contentHostinfo" style="margin-top: 10px;width: 100%;display: none;"></div>
<div id="contentPecount" style="margin-top: 10px;width: 100%;display: none;"></div>
<div id="contentErrorlog" style="margin-top: 10px;width: 100%;display: none;"></div>
<div id="loader"></div>
</form>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</body>
 <div id="dialog-confirm"></div>
</html>
