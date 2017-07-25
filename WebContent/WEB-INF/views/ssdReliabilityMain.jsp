<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>ssd Reliability</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script> -->
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    <%-- datetimepicker --%>
    <script type="text/javascript" src="/dashboard/js/datetimepicker-master/jquery.datetimepicker.js" ></script>
    <link rel="stylesheet" href="/dashboard/js/datetimepicker-master/jquery.datetimepicker.css">
    
    
    
    
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
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
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
	<script type="text/javascript">
	calendar.calendar_set_date = function (set_date){
	    // FMT 변경 (YYYY-MM-DD)
	    if(calendar.calendar_targetObj) {
	        var year  = set_date.substring(0,4);
	        var month = set_date.substring(4,6);
	        var day   = set_date.substring(6,8);
	        
	        var calendar_value = calendar.calendar_fmt;
	        calendar_value = calendar_value.replace(/yyyy/i, year);
	        calendar_value = calendar_value.replace(/mm/i, month);
	        calendar_value = calendar_value.replace(/dd/i, day);
	        
	        calendar.calendar_targetObj.value = calendar_value + calendar.calendar_hhmm; 
	        //chanjoo 주석제거한 것.
			$(calendar.calendar_targetObj).trigger("change");
	    }
	    
	    calendar.calendar_close();
	    
	    // add callback method, 2012.09.25
	    if(typeof fxf_afterDateSelect == "function"){
	    	window.setTimeout("fxf_afterDateSelect(calendar.calendar_targetId)", 300);
	    }
	    
	    // tab focus
	    // if(typeof(calendar.calendar_srcObj) == "object")
	    if(calendar.calendar_srcObj) {
	    	calendar.calendar_srcObj.focus();
	    }
	};
	
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
											
											events:{
												click : function(){
													getDataByJson();
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
			
			$(mainContainer).highcharts('StockChart',options,function(chart){
		    	
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
	<script type="text/javascript">
	
	var dataList = [];
	
	$(function () {
		
		makeHtml('searchCondition', schemaSearch);
		initGrid();
		getDataByJson();
		$( window ).resize(function() {
			
			adjustGrid();
		});
	});
	
	function getDataByJson(){
		$("#loader").show();
		setTimeout(function(){
			$.ajax({
				url : "/dashboard/ssdReliabilityMainJson.html?searchProduct=xxx&searchTestType=xxx&searchFWversion=xxx&searchCapacity=xxx",
				data: $("#form").serialize(),
				success : function(responseData){
					dataList = responseData.dataList;
					makeFWSum();
					drawGrid();
					$("#loader").hide();
				}
			});
		},50);
		
	}
	
	function adjustGrid() {
		$("#jqgridTable").jqGrid('setGridWidth',$("#container").width() - 5 );
		//$("#jqgridTable").jqGrid('setScrollOffset',15 );
		
		//var h = $("#searchCondition").height();
		//$("#jqgridTable").jqGrid('setGridHeight',$('body').height() - h -50 );
		
		$('.ui-jqgrid').css("width",'100%');
		$('.ui-jqgrid-view').css("width",'100%');
		$('.ui-jqgrid-hdiv').css("width",'100%');
		$('.ui-jqgrid-bdiv').css("width",'100%');
		$('.ui-jqgrid-pager').css("width",'100%');
	}
	
	function initGrid(){
		var gridModel = [
		 				{label:'PRODUCT_CATEGORY', name:'PRODUCT_CATEGORY', id:'PRODUCT_CATEGORY', width:100, hidden: true},
		     		    {label:'Product Name', name:'PRODUCT_NAME', id:'PRODUCT_NAME', width:100, align:'center', textAlign:'center',sortable:false, cellattr: mergeRow},
		     		    {label:'Test Type', name:'TEST_NAME', id:'TEST_NAME', width:100, align:'left',sortable:false, cellattr: mergeRow},
		     		    {label:'Start date', name:'START_DATE', id:'START_DATE', formatter: 'date', formatoptions:{ newformat : 'Y-m-d'}, width:100, align:'center', sortable:false,  cellattr: mergeRow},
		     		    {label:'FW Version', name:'FW_VERSION', id:'FW_VERSION', width:100, align:'center',sortable:false, cellattr: mergeRow},
		     		    {label:'Tonum', name:'TONUM', id:'TONUM', width:100, align:'center' , sortable:false, cellattr: mergeRow},
		     		    {label:'Capacity', name:'CAPACITY', id:'CAPACITY', width:100, align:'center',  sortable:false},
		     		    {label:'Yield', name:'YIELD', id:'YIELD', formatter: 'number', width:100 ,  align:'center', sortable:false},
		     		    {label:'Total Yield', name:'fw_sum', id:'fw_sum', width:'',  formatter: 'number', align:'center',cellattr: mergeToal , sortable:false}
		           	];
		 		var theGrid = $("#jqgridTable");
		 		var opt ={
		 				datatype: 'local',
		 				styleUI : 'Bootstrap',
		 				colModel: gridModel,
		 				rowNum: 100000000,
		 				sortable: false,
		 				//viewrecords: true,
		 				emptyrecords: "No records to view",
		 				rownumbers: false, // show row numbers
		 		        multiSort: false,
		 		        multiselect: false,
		 		        //caption: 'Analysis List',
		 		        //width: '100%' ,
		 		        autowidth:true,
		 		        scrollOffset:15,
		 		        //forceFit : false ,
		 		        iconSet: "fontAwesome",
		 		        height: '100%',
		 		        //height: '500px',
		 				onInitGrid: function () {
		 			        var p = $(this).jqGrid("getGridParam");
		 			        // save names of columns in custom option of jqGrid
		 			        p.originalColumnOrder = $.map(p.colModel, function (cm) {
		 			            return cm.name;
		 			        });
		 			        //alert(JSON.stringify(p.originalColumnOrder));
		 			    },
		 			    gridComplete: function () {
		 			    	var test = "";
		 			    	if(dataList.length == 0){
//		  			    		var grid = $("#jqgridTable");
//		  			    		//var emptyText = grid.getGridParam('emptyDataText'); // get the empty text
//		  			    		var emptyText = 'No data';
//		  			    	    var container = grid.parents('.ui-jqgrid-view'); // find the grid's container
		 			    	    
//		  			    	    container.find('.ui-jqgrid-hdiv, .ui-jqgrid-bdiv').hide(); // hide the column headers and the cells below
//		  			            container.find('.ui-jqgrid-titlebar').after('' + emptyText + ''); // insert the empty data text
		 			            
		 			    	    //container.find('.ui-jqgrid-hdiv, .ui-jqgrid-bdiv').show(); // show the column headers
		 		    	        //container.find('#EmptyData' + dataObject).remove(); // remove the empty data text
		 		    	        
		 			            //var td = $('td[role=gridcell]').remove();
		 						//$('.ui-jqgrid-bdiv [role=row]').append('<td role="gridcell" colspan=8  style="text-align:center;" title="" aria-describedby="jqGrid_phase">No Data</td>');
		 						//$('.ui-jqgrid-bdiv').css("overflow","hidden");
		 			    	}
		 			    		
		 			    },
		 			    onCellSelect: function (rowId, iCol, content, event) {
		 			    	var test = "";
		 			    	var grid = $("#jqgridTable");
		 			    	var row = theGrid.jqGrid('getRowData',rowId);
		 			    	var cms = grid.jqGrid("getGridParam", "colModel");
		 					var cm = cms[iCol];
		 					
		 					var ispop = false;
		 					var oFrm = document.getElementById("form");
		 					oFrm.productName.value = "";
		 					oFrm.testType.value = "";
		 					oFrm.fwVersion.value = "";
		 					
		 					var query = "";
		 					//var url = "/dashboard/ssdReliabilityChartPop.html";
		 					// productName
		 					if(cm.name == 'PRODUCT_NAME'){
		 						ispop = true;
		 						oFrm.productName.value = row.PRODUCT_NAME;
		 						//query += "productName="+row.PRODUCT_NAME;
		 					}
		 					// TestType
		 					else if(cm.name  == 'TEST_NAME'){
		 						ispop = true;
		 						//query += "productName="+row.PRODUCT_NAME;
		 						//query += "&testType="+ row.TEST_NAME;
		 						oFrm.productName.value = row.PRODUCT_NAME;
		 						oFrm.testType.value = row.TEST_NAME;
		 					}
		 					// FW version
		 					else if(cm.name  == 'FW_VERSION'){
		 						ispop = true;
		 						//query += "productName="+row.PRODUCT_NAME;
		 						//query += "&testType="+ row.TEST_NAME;
		 						//query += "&fwVersion=" + row.FW_VERSION;
		 						oFrm.productName.value = row.PRODUCT_NAME;
		 						oFrm.testType.value = row.TEST_NAME;
		 						oFrm.fwVersion.value = row.FW_VERSION;
		 					}
		 					
		 					if(ispop){
		 						var newWin1 = window.open("", "ssdReliabilityChartPop", "width=1000,height=870, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		 						
		 						//oFrm.pjt_code.value = this.options.dataraw.PJT_CODE;
		 						//oFrm.pjt_name.value = this.options.dataraw.PJT_NAME_PMS;
		 						oFrm.productCategory.value = row.PRODUCT_CATEGORY;
		 						oFrm.action =  '/dashboard/ssdReliabilityChartPop.html';
		 						oFrm.method = "post";
		 						oFrm.target = 'ssdReliabilityChartPop'; 
		 					    oFrm.submit();		
		 					    newWin1.focus();	
		 					}
		 					
		 			    },
		 			    afterInsertRow: function(rowId, aData)
		                 {   
		                  	$(this).jqGrid('setRowData', rowId, false, 'font-weight:bold');
		                 },
		 			    data: []
		 		};
		 		
		 		//"use strict";
		 		theGrid.jqGrid(opt);
		 		adjustGrid();
		 		//$("#loader").hide();
	}
	
	function drawGrid(){
		var h = $("#searchCondition").height();
		var theGrid = $("#jqgridTable");
		theGrid.jqGrid('clearGridData')
		.jqGrid('setGridParam',
	        { 
	            datatype: 'local',
	            data: dataList
	            
	        })
    	.trigger("reloadGrid");
		
		
		adjustGrid();
		
	}
	
	function mergeToal(rowId, val, rowObj, cm, rowData) {
		var grid = $(this).jqGrid();
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
		//var colid = getColumnSrcIndexByName("FW_VERSION");
		var colid = getColumnSrcIndexByName("TEST_NAME");
		var cm1 = colModel[colid];
		
		return mergeRow.call(grid,rowId, val, rowObj, cm1, rowData, true);
	}
	
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
		var parentCols = colModel.slice(0,colid + 1);
		
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
		
		var firstRow = fn_firstRow(dataList,rowId,cm.name);
		var lastRow = fn_lastRow(dataList,rowId,cm.name,0);
		if(curRow == firstRow){
			result = ' style="background:white;vertical-align: middle;';
			if(!isCustom){
				switch(cm.name) {
				    case 'PRODUCT_NAME':
				    case 'TEST_NAME':
				    case 'FW_VERSION':
				    	result += "color: rgba(6, 89, 203, 0.93);font-weight: bolder;cursor:pointer;"
				        break;
				    
				    default:
				}
			}
			
			result += '" ';
			result += 'rowspan=' + lastRow.span;
		}else{
			result = ' style="display:none;"';
			result += '" ';
			
		}
		
		
		
		return result;
	}
	
	function makeFWSum(){
// 		var list = groupbyCount(dataList,['PRODUCT_NAME','TEST_NAME','FW_VERSION']);
// 		$.each(list,function(i,d){
// 			var fw_list = dataFilter(dataList,[{col:'PRODUCT_NAME', val:d.PRODUCT_NAME},{col:'TEST_NAME',val:d.TEST_NAME},{col:'FW_VERSION',val:d.FW_VERSION}]);
// 			var sum = 0;
			
// 			$.each(fw_list,function(j,fw){
// 				sum += fw.YIELD;
// 			});
// 			var fw_sum =  sum/fw_list.length;
// 			$.each(fw_list,function(j,fw){
// 				fw.fw_sum = fw_sum;
// 			});
// 		});
		
		var list = groupbyCount(dataList,['PRODUCT_NAME','TEST_NAME']);
		$.each(list,function(i,d){
			var fw_list = dataFilter(dataList,[{col:'PRODUCT_NAME', val:d.PRODUCT_NAME},{col:'TEST_NAME',val:d.TEST_NAME}]);
			var sum = 0;
			
			$.each(fw_list,function(j,fw){
				sum += fw.YIELD;
			});
			var fw_sum =  sum/fw_list.length;
			$.each(fw_list,function(j,fw){
				fw.fw_sum = fw_sum;
			});
		});
	}
	
	function changeProduct(){
		var components = [];
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
		
		var mainControl = $("#searchProduct");
		mainControl.html("");
		
		var vData = rtnList;
		var sb = [];
		
		
		$.each(vData,function(){
			var option = $(document.createElement( "option" ));
			option.val(this['MODEL_NM']);
			option.text(this['MODEL_NM']);
			//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
			$.each(this,function(k,v){
				option.attr(k.toLowerCase(),v);
			});
			mainControl.append(option);
		});		
		mainControl.multiselect('refresh');
		$('div.ui-multiselect-menu').css("width","400px");
		$('.ui-multiselect-filter input').css("width","150px");
		$("#loader").hide();
	}
	
	function changeProductTestType(){
		var components = [];
		$.ajax({
    		url: "/dashboard/reliabilityTestTypeListJson.html?searchProduct=xxx",
    		data: $('form').serialize(), 
    		async: false,
    		success:  function(response){
    			components = response.dataList;
    			$.each(components,function(){
    				this.selected = "selected";
    			});											    			
    		}
    	});
		
		var mainControl = $("#searchTestType");
		mainControl.html("");
		
		var vData = components;
		var sb = [];
		
		
		$.each(vData,function(){
			var option = $(document.createElement( "option" ));
			option.val(this['TESTNM']);
			option.text(this['TESTNM']);
			//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
			$.each(this,function(k,v){
				option.attr(k.toLowerCase(),v);
			});
			mainControl.append(option);
		});		
		mainControl.multiselect('refresh');
		$('div.ui-multiselect-menu').css("width","400px");
		$('.ui-multiselect-filter input').css("width","150px");
		$("#loader").hide();
	}
	
	function changeProductFw(){
		var components = [];
		$.ajax({
    		url: "/dashboard/reliabilityFWVersionListJson.html?searchProduct=xxx&searchTestType=xxx",
    		data: $('form').serialize(), 
    		async: false,
    		success:  function(response){
    			components = response.dataList;
    			$.each(components,function(){
    				this.selected = "selected";
    			});											    			
    		}
    	});
		
		var mainControl = $("#searchFWversion");
		mainControl.html("");
		
		var vData = components;
		var sb = [];
		
		
		$.each(vData,function(){
			var option = $(document.createElement( "option" ));
			option.val(this['FIRMWARE']);
			option.text(this['FIRMWARE']);
			//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
			$.each(this,function(k,v){
				option.attr(k.toLowerCase(),v);
			});
			mainControl.append(option);
		});		
		mainControl.multiselect('refresh');
		$('div.ui-multiselect-menu').css("width","400px");
		$('.ui-multiselect-filter input').css("width","150px");
		$("#loader").hide();
	}
	
	function changeProductCapacity(){
		var components = [];
		$.ajax({
    		url: "/dashboard/reliabilityCapacityListJson.html?searchProduct=xxx&searchTestType=xxx&searchFWversion=xxx",
    		data: $('form').serialize(), 
    		async: false,
    		success:  function(response){
    			components = response.dataList;
    			$.each(components,function(){
    				this.selected = "selected";
    			});											    			
    		}
    	});
		
		var mainControl = $("#searchCapacity");
		mainControl.html("");
		
		var vData = components;
		var sb = [];
		
		
		$.each(vData,function(){
			var option = $(document.createElement( "option" ));
			option.val(this['CAPACITY']);
			option.text(this['CAPACITY']);
			//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
			$.each(this,function(k,v){
				option.attr(k.toLowerCase(),v);
			});
			mainControl.append(option);
		});		
		mainControl.multiselect('refresh');
		$('div.ui-multiselect-menu').css("width","400px");
		$('.ui-multiselect-filter input').css("width","150px");
		$("#loader").hide();
	}
		
	</script>
	<style type="text/css">
	
		html, body,form {
	        /* height: 100%; */
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow-y: auto;
	        overflow-x: hidden;
	        font-size:11px;
	      }
		
		.dashboard-div{
			/* position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0; */
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
		.ui-jqgrid {
			border : 0;
			border-left: 1px solid #ddd; 
		}
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
		
		/***     ***/
		.ui-jqgrid-hdiv th {
			text-align: center;
		}
		
		.container{
			padding-left: 0px;
			padding-right: 0px;
		}
	</style>
</head>
<body>
<form name="form" id="form" class="">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<input type="hidden" id="productCategory" name="productCategory" value=""/>
<input type="hidden" id="productName" name="productName" value=""/>
<input type="hidden" id="testType" name="testType" value=""/>
<input type="hidden" id="fwVersion" name="fwVersion" value=""/>
<div id="searchCondition"></div>
<div align="left" id="container" class="dashboard-div container">
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
