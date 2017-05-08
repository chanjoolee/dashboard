<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>pms Resource Forecast</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script> -->
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    <%-- jqgrid --%>
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	
	<%-- http://swebdeveloper.com/apps/forms-plus-css/popup-form-comment.html --%>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/font-awesome.min.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/modern-forms-plus.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/purple.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/cadetBlue.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/orange.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color3.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color4.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css"/>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/steelBlue.css"/>
  
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
	
	
	<script src="/dashboard/js/jointjs/lodash.min.js"></script>
	<script type="text/javascript" title="schema">
	Date.prototype.yyyymmdd = function() {
	  var mm = this.getMonth() + 1; // getMonth() is zero-based
	  var dd = this.getDate();

	  return [this.getFullYear(),
	          (mm>9 ? '' : '0') + mm,
	          (dd>9 ? '' : '0') + dd
	         ].join('');
	};
	Date.prototype.yyyymmdd1 = function() {
		  var mm = this.getMonth() + 1; // getMonth() is zero-based
		  var dd = this.getDate();

		  return [this.getFullYear(),
		          '-',		          
		          (mm>9 ? '' : '0') + mm,
		          '-',
		          (dd>9 ? '' : '0') + dd
		         ].join('');
		};
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
											id: 'siteHead',
											name: 'siteHead',
											label:'',
											text:'Site',
											width: '50px'
										},
										{
											type:'multiCombo',
											id: 'site',
											name: 'site',
											label:'',
											text:'Site',
											width: '120px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/pmsCodeListJson.html",
										    		data: {codeName: 'National_Cd'}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'CODE_ID',
												name:'CODE_VALUE_EN'
											},
											events:{
												change : function(){
													//getGridData();
													
												}
												// end change events
											}
										},	
										{
											type:'SearchHeader',
											id: 'modelNameHead',
											name: 'modelNameHead',
											label:'',
											text:'Function',
											width: '50px'
										},
										{
											type:'multiCombo',
											id: 'function',
											name: 'function',
											label:'',
											text:'Function',
											width: '130px',
											data: function(){
												var rtnList = [];
												$.ajax({
										    		url: "/dashboard/pmsCodeListJson.html",
										    		data: {codeName: 'Function'}, 
										    		async: false,
										    		success:  function(response){
										    			rtnList = response.dataList;
										    			
										    		}
										    	});
												return rtnList;
											},
											options: {
												cd:'CODE_ID',
												name:'CODE_VALUE_EN'
													
											},
											events: {
												change: function(){
													//getGridData();
												}
											}
										},
										{
											type:'SearchHeader',
											id: 'pjtCodeHead',
											name: 'pjtCodeHead',
											label:'',
											text:'Project',
											width: '30px'
										},
										{
											type:'multiCombo',
											id: 'pjtStatus',
											name: 'pjtStatus',
											label:'',
											text:'Project Status',
											width: '120px',
											data: function(){
												var rtnList = [];												
												return rtnList;
											},
											options: {
												
											},
											events: {
												change: function(){
													//getGridData();
												}
											}
										},
										{
											type:'multiCombo',
											id: 'pjtCode',
											name: 'pjtCode',
											label:'',
											text:'Project',
											width: '160px',
											data: function(){
												var rtnList = [];												
												return rtnList;
											},
											options: {
												
											},
											events: {
												change: function(){
													//getGridData();
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
										{code:'display',value:'visible'}	
									],
									elements:[
										{
											type:'SearchHeader',
											id: 'testDateHead',
											name: 'testDateHead',
											label:'',
											text:'DateFrom',
											width: '50px'
										},
										{
											type: 'multiCombo',
											id: 'estStartDate',
											name: 'estStartDate',
											label:'',
											text:'StartDate',
											width:'120px',
											data: function(){
												var rtnList = [];
												var today = new Date();
										    	var year = today.getFullYear();
										    	var month = today.getMonth();
										    	var date = today.getDate();
										    	
										    	for(var i=0;i <= 12 ;i++){
										    		var vDt = new Date(year,month - i,1);
										    		var vCd = vDt.yyyymmdd1();
										    		var vNm = vDt.yyyymmdd1().substr(0,7);
										    		var data = {date: vCd, dateNm: vNm};
										    		if(i == 1)
										    			data.selected = "selected";
										    		rtnList.push(data);
										    	}
												
												return rtnList;
											},
											options: {
												cd:'date',
												name:'dateNm',
												isSingle: true
											},
											events:{
												click : function(){
													//getGridData();
												}
											}
											
										},
										{
											type:'SearchHeader',
											id: 'testDateHead1',
											name: 'testDateHead1',
											label:'',
											text:'DateEnd',
											width: '50px'
										},
										{
											type: 'multiCombo',
											id: 'estEndDate',
											name: 'estEndDate',
											label:'',
											text:'EndDate',
											width:'130px',
											data: function(){
												var rtnList = [];
												var today = new Date();
										    	var year = today.getFullYear();
										    	var month = today.getMonth();
										    	var date = today.getDate();
										    	for(var i = -1;i <= 5 ;i++){
										    		var vDt = new Date(year,month - i,1);
										    		var vCd = vDt.yyyymmdd1();
										    		var vNm = vDt.yyyymmdd1().substr(0,7);
										    		var data = {date: vCd, dateNm: vNm};
										    		if(i == -1)
										    			data.selected = "selected";
										    		rtnList.push(data);
										    	}
												return rtnList;
											},
											options: {
												cd:'date',
												name:'dateNm',
												isSingle: true
											},
											events:{
												click : function(){
													//getGridData();
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
													setCalendarRsc();
													$("#searchCondition select option:selected").prop("selected", false);
													$("#searchCondition select").multiselect('refresh');
													
													$("div.ui-multiselect-menu").css("width","500px");
													$(".ui-multiselect-filter input").css("width","200px");
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
					sortable: false
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
				mainControl.attr("name",_schema.name);
			if(_schema.id != undefined)
				mainControl.attr("id",_schema.id);
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
			if(_schema.options.isSingle != undefined && _schema.options.isSingle == true){
				var vMultiSelect = $(mainControl).multiselect({
					selectedList: 1,
					multiple: false,
					height:300,
					minWidth: 100,
					//selectedText: _schema.text + ' # selected',
					noneSelectedText: 'Select ' + _schema.text
				});
			}else{
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
			}
			
			
			
			
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
	var projectList = [];
	var dataList = [];
	var planList = [];
	var pivotObject = {};
	var searchs = [];
	var pivotList = [];
	var responseData = {};
	
	$(function () {	
		setTimeout(function(){			
			makeHtml('searchCondition', schema);
			//dafault select
			$('#site option').attr('selected', 'selected');
			$('#site').multiselect('refresh');
			
			$('#function option').attr('selected', 'selected');
			$('#function').multiselect('refresh');
			
			
			pmsProjectList();
			getDataByJson();
			drawGrid();
		},50);
		
		
		
		$( window ).resize(function() {
			adjustGrid();
		});
	});
	
	function pmsProjectList(){
		$.ajax({
			//url : "/dashboard/dashboardProjectListJson.html",
			url : "/dashboard/pmsProjectListJson.html",
			data: {division:'jira'},
			async : false,
			success : function(pResponseData){
				projectList =pResponseData.dataList;
				
				var groupKeys = ['DISPLAY_ORDER','PJT_NAME'];
				var series = getDrillDownDataSeries2(
						'',
						projectList ,
						groupKeys ,
						[], //filter
						[], //convert
						'', //xAxis
						'CNT',
						{cd: 'APPLICATION_ID', name:'APPLICATION_NAME'},
						{isGroupby: false}
				);
				
				var selected ="";
				var sb = [];
				$.each(series.series,function(index,s){
					sb.push("<optgroup label=\""+s.name+" (Click)\">");
					$.each(s.data,function(index1,d){
						if(this.APPLICATION_NAME=="Mobile Solution")
							selected = "selected";
						else 
							selected = "selected";
						sb.push("<option value='"+ d.PJT_CODE +"' "+selected+" status='"+d.PJT_STATE+"'>" + d.PJT_NAME +"</option>");
					});
					sb.push("</optgroup>");
				});
				
				$("select[name=pjtCode]").append(sb.join(""));
				
				$("select[name=pjtCode]").change(function(){
					getGridData();
				});
				
				/* projectMultiSelect = $("select[name=pjtCode]").multiselect({
					height:400,
					selectedText: function(numChecked, numTotal, checkedItems){
					     return numChecked + ' of ' + numTotal + ' checked';
					},
					noneSelectedText: 'Select projects'
				}).multiselectfilter(); */
				$("div.ui-multiselect-menu").css("width","500px");
				$(".ui-multiselect-filter input").css("width","200px");
				
				$("select[name=pjtCode]").multiselect('refresh');
				//상태표시
				$.each(series.series,function(index,s){
					$.each(s.data,function(index1,d){
						var label = $("input[name=multiselect_pjtCode][value="+d.PJT_CODE+"]").parent();
						label.append("<span style='color: blue;float:right;'>"+ d.PJT_STATE_NAME +"</span>");
						
					});
				});
				
				pjtStatus();
			}
		});
	}
	
	function pjtStatus(){
		var status = groupbyCount(projectList,['PJT_STATE','PJT_STATE_NAME']);
		
		var selected ="";
		var sb = [];
		$.each(status,function(){
			if(this.PJT_STATE_NAME=="Proceeding")
				selected = "selected";
			else 
				selected = "";
			sb.push("<option value='"+ this.PJT_STATE +"' "+selected+">" + this.PJT_STATE_NAME +"</option>");
		});
		
		$("select[name=pjtStatus]").append(sb.join(""));
		$("select[name=pjtStatus]").change(function(){
			filterByStatus();
			
		});
		/* var select = $("select[name=pjtStatus]").multiselect({
			//selectedList: 1,
			height:400,
			selectedText: 'Project # selected',
			noneSelectedText: 'Select Status'
		}).multiselectfilter(); */
		$("select[name=pjtStatus]").multiselect('refresh');
		filterByStatus();
		
		$("div.ui-multiselect-menu").css("width","500px");
		$(".ui-multiselect-filter input").css("width","200px");
	}
	
	
	function filterByStatus(){
		$("select[name=pjtStatus] option").each(function(i,sel){
			if($(this).is(':selected')){
				$("select[name=pjtCode] option[status="+$(this).val()+"]").prop( "disabled", false );
				//$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", true );
			}else{
				$("select[name=pjtCode] option[status="+$(this).val()+"]").prop( "disabled", true );
				//$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", false );
			}
		});
		$("select[name=pjtCode] option").each(function(i,project){			
			$("input[name=multiselect_pjtCode][value="+$(this).val()+"]").prop( "disabled", $(this).prop("disabled") );
			if($(this).prop("disabled")){
				$("input[name=multiselect_pjtCode][value="+$(this).val()+"]").parent().addClass( "ui-state-disabled" );
				$("input[name=multiselect_pjtCode][value="+$(this).val()+"]").attr("checked",false);
				
			}else{
				$("input[name=multiselect_pjtCode][value="+$(this).val()+"]").parent().removeClass( "ui-state-disabled" );
			}
			
		});
		
		$("input[name=multiselect_pjtCode]").each(function(){
			$("select[name=pjtCode] option[value="+$(this).val()+"]").prop( "selected", $(this).is(":checked") );
		});
		
		//projectMultiSelect.multiselect('refresh');
				
		/* var groupKeys = ['DISPLAY_ORDER','PJT_NAME'];
		var series = getDrillDownDataSeries2(
				'',
				projectList ,
				groupKeys ,
				[], //filter
				[], //convert
				'', //xAxis
				'CNT',
				{cd: 'APPLICATION_ID', name:'APPLICATION_NAME'},
				{isGroupby: false}
		); */
		
		projectMultiSelect = $("select[name=pjtCode]").multiselect({
			height:400,
			selectedText: function(numChecked, numTotal, checkedItems){
			     return numChecked + ' of ' + numTotal + ' checked';
			},
			noneSelectedText: 'Select projects'
		}).multiselectfilter();
		//getGridData();
		//$("select[name=pjtCode]").multiselect('refresh');
		//$("div.ui-multiselect-menu").css("width","500px");
		//$(".ui-multiselect-filter input").css("width","200px");
		
		//상태표시
		/* $.each(series.series,function(index,s){
			$.each(s.data,function(index1,d){
				var label = $("input[name=multiselect_pjtCodeList][value="+d.PJT_CODE+"]").parent();
				label.append("<span style='color: blue;float:right;'>"+ d.PJT_STATE_NAME +"</span>");
				
			});
		}); */
		
	}
	
	function setCalendarRsc(){
    	var today = new Date();
    	var year = today.getFullYear();
    	var month = today.getMonth();
    	var date = today.getDate();
    	
    	var startDate = new Date(year, month -1, 2);
    	var endDate = new Date(year, month + 1, 1);
    	
    	$("#estStartDate").val(startDate.toISOString('YYYY-MM-DD').substr(0,10));
    	$("#estEndDate").val(endDate.toISOString('YYYY-MM-DD').substr(0,10));
    }
	
	function getDataByJson(){
		//setCalendarRsc();
		$.ajax({
			url : "/dashboard/pmsResourceFcstJson.html",
			data: $("#form").serialize()+ "&site=xxx&function=xxx&pjtCode=xxx",
			async: false,
			success : function(vResponseData){
				responseData = vResponseData;
				dataList = responseData.data;
				$.each(dataList,function(i,d){
					d.YYYYMM= d.YYYYMM.substr(0,6);
				});
				//planList = groupbySum(responseData.plan,['YYYYMM','UP_PJT_FUNC_ID','UP_PJT_FUNC_NAME'],'MM_PLAN');
				planList = responseData.plan;
				//var planListG = groupbySum
				//01. merge 
				$.each(planList,function(i,plan){
					//plan.isPlan = true;
					plan.MM_RESULT = plan.MM_PLAN;
					dataList.push(plan);
					plan.YYYYMM= plan.YYYYMM.substr(0,6) + ' Fcst';
				});
				
				//searchs = responseData.searchs;			
				pivotObject = pivot(dataList,{col:'PJT_ID',name:'PJT_NAME'},['YYYYMM','UP_PJT_FUNC_ID','UP_PJT_FUNC_NAME'],'MM_RESULT');
				sortObjects(pivotObject.columns,['PJT_NAME']);
				//drawGrid();
				$("#loader").hide();
			}
		});
		
		
				
	}
	
	
	function pivot(datasrc,colDef,groupbyColumns,targetColumn){
		var rtnObject = {};
		//var groupList = groupbyCount(datasrc,groupbyColumns);
		var groupList = groupbySum(datasrc,groupbyColumns, targetColumn);
		groupList = _.filter(groupList, function(item){
			return item[groupbyColumns[1]] != 'Undefined';
		});
		var cols = groupbyCount(datasrc,[colDef.col,colDef.name]);
		
		$.each(groupList,function(i,group){
			$.each(cols,function(ci,col){
				var filter = [];
				filter.push({col: colDef.col ,val: col[colDef.col]});
				$.each(groupbyColumns,function(c,v){
					if(c != 'count'){
						filter.push({col: v, val: group[v] });
					}
				});
				
				if(col[colDef.col] == 'PJT_00059012' && group.YYYYMM=='201702' && group.UP_PJT_FUNC_ID =='NPM_00000004')
					var xxx = 'xxx';
				
				var targets = dataFilter(datasrc,filter);
				var targets1 = groupbySum(targets,groupbyColumns, targetColumn);
				var target = {};
				if(targets1.length > 0){
					target = targets1[0];
					
					// customize
					if(target.isPlan != undefined && target.isPlan == true)
						group.isPlan = true;
				}else{
					group[col[colDef.col]] = 0;
					group[col[colDef.name]] = 0;
					return true;
				}
				
// 				$.each(target,function(c,v){
// 					group[c] = v;
// 				});				
				
				var tval = 0;
				if(target[targetColumn] != undefined)
					tval = target[targetColumn];
				
				group[col[colDef.col]] = tval;
				group[col[colDef.name]] = tval;
					
				
			});
		});
		
		rtnObject.list = groupList;
		rtnObject.datasrc = datasrc;
		rtnObject.colDef = colDef;
		rtnObject.columns = cols;
		rtnObject.groupbyColumns = groupbyColumns;
		rtnObject.targetColumn = targetColumn;
		
		return rtnObject ;
		
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
	
	function getGridData(){
		$("#loader").show();		
		setTimeout(function(){
			//var theGrid = $("#jqgridTable");
			//theGrid.jqGrid('clearGridData');
			$("#pjt_code").val('');
			$("#pjt_name").val('');
			getDataByJson();
			$("#container").html("");
			$("#container").html('<div id="jqgrid" style="width:100%;"><table id="jqgridTable"></table><div id="jqgridPager"></div></div>');
			
			setTimeout(function(){
				//var theGrid = $("#jqgridTable");
				//var colModel = getGridModel();
				//theGrid.jqGrid('setGridParam', {colModel:colModel});
				//theGrid.jqGrid('setGridParam', {data: pivotObject.list});
				//theGrid.trigger('reloadGrid');
				drawGrid();
				$("#loader").hide();
			},50);
			
		},50);
		
	}
	
	function drawGrid(){
		
		var gridModel = getGridModel();
		
		sortObjects(pivotObject.list,['YYYYMM','UP_PJT_FUNC_NAME']);
		var theGrid = $("#jqgridTable");
		var opt ={
				datatype: 'local',
				styleUI : 'Bootstrap',
				colModel: gridModel,
				rowNum:100000,
				sortable: false,
				viewrecords: true,
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
		        data: pivotObject.list,
		        height: '100%',
		    	grouping: true,
				groupingView: {
					groupField: ["YYYYMM"],
					groupColumnShow: [false],
					groupText: ["<b>{0}</b>"],
					groupOrder: ["asc"],
					groupSummary: [true],
					groupSummaryPos: ["header"],
					hideFirstGroupCol: true,
					groupCollapse: true
				},
		        
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
			    	$("#jqgrid th div").click(function() {
			    		var pjtCode = $(this).parent().prev().find('div').text();
			    		var pjtObjects =  dataFilter(pivotObject.columns,[{col: 'PJT_ID', val: pjtCode}]);
			    		var pjtObject = {};
			    		
			    		if(pjtObjects.length > 0){
			    			pjtObject = pjtObjects[0];
			    			var newWin1 = window.open("", "ResourceFcstProject", "width=1000,height=600, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
			    			
			    			var oFrm = document.getElementById("form");
			    			oFrm.pjt_code.value = pjtObject.PJT_ID;
		    				oFrm.pjt_name.value = pjtObject.PJT_NAME;
			    			
			    			oFrm.action =  '/dashboard/pmsResourceFcstProject.html';
			    			oFrm.method = "post";
			    			oFrm.target = 'ResourceFcstProject'; 
			    		    oFrm.submit();		
			    		    newWin1.focus();
			    		}
			    		
			    	});
			    	
			    }, 
			    onCellSelect: function (rowId, iCol, content, event) {
			    	var test = "";
			    	var grid = $("#jqgridTable");
			    	var row = theGrid.jqGrid('getRowData',rowId);
			    	var cm = grid.jqGrid("getGridParam", "colModel");
					//var cm = cms[iCol];
					
					
					
			    }
			    
		};
		
		//"use strict";		
		theGrid.jqGrid(opt);
		//$(".ui-jqgrid th.ui-th-column").css("vertical-align","top");
		//$(".ui-jqgrid th.ui-th-column div").css("text-align","left");
		$('.ui-jqgrid-hdiv th').each(function(){
			switch($(this).find("div").text()) {
				case 'Func':
			        break;
			    case 'Sum':
			        break;
			    default:
			    	$(this).css("vertical-align","bottom");				
					$(this).addClass("rotate");
					$(this).find("div").css("text-align","left");
					break;
			}
			/* if($(this).find("div").text() != "Func"){
				$(this).css("vertical-align","bottom");				
				$(this).addClass("rotate");
				$(this).find("div").css("text-align","left");
				
			} */
		});
		//$('.ui-jqgrid-hdiv th').addClass("rotate");
		$('.ui-jqgrid-hdiv th').css("overflow","visible");
		//theGrid.jqGrid('sortableRows');


		// is refered by "http://stackoverflow.com/questions/23238912/summary-in-header-with-grouping-option"
		theGrid.find("tr.jqgroup").each(function () {
		    var summaryrow = $(this);
		    summaryrow.children(":gt(0)").css("font-weight","bolder");
		    // 첫번째 행이 밀리는 현상 방지
		    summaryrow.children(":eq(1)").css("display","none");
		    //summaryrow.children(":eq(2)").css("display","none");
		    //summaryrow.children(":eq(3)").css("display","none");
		});
		
		// function에 padding 추가
		theGrid.find("tr.jqgrow").each(function () {
		    var summaryrow = $(this);
		    summaryrow.children(":eq(2)").css("padding-left","30px");
		});
		
		adjustGrid();
		$("#loader").hide();	
	}
	
	
	function popPmsRsc(upFuncId,pjtId,yyyymm){
		//var url = '/nspim/pjt/pjt/retrieveResourceInfo.do?fnCode=' + upFuncId +'&searchPjtId='+pjtId;
		var url = '/nspim/pjt/pjt/retrieveDetailMResourceInfo.do?fnCode=' + upFuncId +'&searchPjtId='+pjtId +'&yyyymm='+yyyymm +'&cj=y ' ;
		var newWin1 = window.open("", "ResourceForeCast", "width=1280,height=350, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		var oFrm = document.getElementById("form");
		
		oFrm.pjtId.value = pjtId;
		oFrm.action =  url;
		oFrm.method = "post";
		oFrm.target = 'ResourceForeCast'; 
	    oFrm.submit();		 
	    newWin1.focus();
	}
	
	function getGridModel(){
		var setAttr = function(rowId, val, rawObject, cm) {
		    //var attr = rawObject.attr[cm.name], result;
			var rownum = parseInt(rowId,10) -1 ;
			var rowspan = 1; 
			var preVal = "";
			var postVal = "";
			//var attr = rawObject[cm.name];
			var result = "";
			var style = "";
			
			if(rawObject != undefined){
				style += " cursor:pointer;";
				result +=" style=\""+style+";color:blue;\"";
				result +=" title=\""+val+"\"";
				result += " onclick = popPmsRsc('"+rawObject.UP_PJT_FUNC_ID+"','"+cm.id+"','"+rawObject.YYYYMM+"');";
			}
				
			return result;
			
		};
		var theGrid = $("#jqgridTable");
		var gridModel = [
		     		    {label:'Month', name:'YYYYMM', id:'YYYYMM', width:130, align:'center', textAlign:'center',sortable:false, hidden:true
//		      		    	,formatter:function(cellval,opts,rwdat,_act){ 
//		      		    		var rtn;
//		      		    		if(rwdat.isPlan != undefined && rwdat.isPlan == true)
//		      		    			rtn = cellval.substr(0,6) + ' Fcst';
//		      		    		else
//		      		    			rtn =  cellval.substr(0,6);
//		      		    		return rtn;
//		      		    	}
		     		    },
		     		    {label:'UP_PJT_FUNC_ID', name:'UP_PJT_FUNC_ID', id:'UP_PJT_FUNC_ID',sortable:false, hidden:true},
		     		    {label:'Func', name:'UP_PJT_FUNC_NAME', id:'UP_PJT_FUNC_NAME', width:200, align:'left', textAlign:'left',sortable:false}
		     		    ,{label:'Sum', name:'MM_RESULT', id:'MM_RESULT', width:50,sortable:false, align:'right', textAlign:'right',summaryType: 'sum', formatter:'number' }
		           	];
		
		$.each(pivotObject.columns,function(i,col){
			gridModel.push({ 
				label: col[pivotObject.colDef.col] , 
				name:col[pivotObject.colDef.col], 
				id:col[pivotObject.colDef.col], 
				width:130,
				align:'center', 
				textAlign:'center',
				sortable:false,
				hidden:true,
				summaryType: 'sum', formatter:'number'
			});
			gridModel.push({
				label: col[pivotObject.colDef.name] , 
				name:col[pivotObject.colDef.name], 
				id:col[pivotObject.colDef.col], 
				width:50,
				align:'right', 
				textAlign:'right',
				sortable:false,
				summaryType: 'sum', formatter:'number',
				cellattr: setAttr
			});
		});
		return gridModel;
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
		
		<%-- 테이블헤더 45--%>
		th.rotate {
		  /* Something you can count on */
		  height: 170px;
		  white-space: nowrap;
		}
		
		th.rotate > div {
		  transform: 
		    /* Magic Numbers */
		   translate(-60px, -60px)
		    /* 45 is really 360 - 45 */
		    rotate(90deg);
		  width: 150px;
		  height: 50px;
		}
		th.rotate > div > span {
		  border-bottom: 1px solid #ccc;
		  padding: 5px 10px;
		}
	    
	</style>
</head>
<body style="min-width:950px ">
<form name="form" id="form" class="">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value=""/>
<input type="hidden" id="pjt_name" name="pjt_name" value=""/>
<!-- <input type="hidden" id="estStartDate" name="estStartDate" value=""/>
<input type="hidden" id="estEndDate" name="estEndDate" value=""/> -->
<div id="searchCondition"></div>
<div align="left" id="container" class="dashboard-div container" >
	<div id="jqgrid" style="width:100%;">
		<table id="jqgridTable"></table>
		<div id="jqgridPager"></div>
	</div>
</div>
<div id="loader"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
