<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>FWQ Coding Rule Pop</title>
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
	<script src="js/dashboard.js?version=2"></script>
	
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
	<script src="/dashboard/js/jointjs/lodash.min.js"></script>
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
		
		.table td[aria-describedby=funcParams_RULE]{
			padding-left: 30px;
		}
		
		.ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td.paddingRight8{
			padding-right: 8px;
		}
		
		.ui-jqgrid .ui-jqgrid-btable tbody tr.jqgroup td.paddingRight8{
			font-weight: bolder;
		}
		
		.ui-jqgrid .ui-jqgrid-htable .ui-th-div{
			height: 30px;
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
		    padding: 20px 30px;
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
	
		.cont_tit{font-size:15px; display:block; color:#000; text-align:left; padding-bottom:12px; position:relative; background:url(/nspim/images/board/bullet.gif) no-repeat left 1px; padding-left:18px}
		.cont_tit {float:none}
		
		<%--  table style--%>
		.table_hori {
		    width: 100%;
		    table-layout: fixed;
		    border-collapse: collapse;
		    border-top: 1px solid #fc5d57;
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
		}
		.cont_tit {
		    padding-bottom: 3px;
		}
		
		.txt_right {
		    text-align: right;
		}
		<%--//  table style--%>
		
		input[type="text"], input[type="password"]{
	    	height: 34px;
	    }
	
	</style>
<script title="schema">
// 	$.jgrid.defaults.width = 780;
// 	$.jgrid.defaults.responsive = true;
// 	$.jgrid.defaults.styleUI = 'Bootstrap';
	
	var funcParams = [];
	var pivotObject = {};
	var summaryObject = {};

	var schema = {
			containerId:'contents',
			type:'Vertical',
			label:'',
			elements:[
				{
					label:'Summary',
					type: 'Group',
					elements:[
						{
					    	type:'grid',
					    	id: 'summay',
					    	label:'',
					    	containerCss:[
					    		{code:'margin-top',value:'3px'}
					    		,{code:'margin-bottom',value:'10px'}
					    	],
					    	data: function(){ 
					    		return summaryObject.list;
					    	},
					    	items:function(){
					    		return getGridModelSummary();
					    	},
					    	gridOpt:{
					    		datatype:'local',
					    		//userdata: "rows",
					    		//pager: "#summayPager",
					    		viewrecords: true,
					    		rowNum:1000000,
					    		//rowList:[10,20,30,50,100],
					    		//url: '/dashboard/rest/fwq/codingRule/list/${param.project}/${param.measureDt1}/${param.measureDt2}',
					    		//closeAfterEdit: true,
					    		width: '100%',
					    		height: 150,
					    		//height: '100%',
					    		grouping: true,
					    		groupingView: {
									groupField: ["CATEGORY"],
									groupColumnShow: [false],
									groupText: ["<b>{0}</b>"],
									//groupOrder: ["asc"],
									groupSummary: [true],
									groupSummaryPos: ["header"],
									hideFirstGroupCol: true,
									groupCollapse: false,
									groupDataSorted: false
								},
					    		onCellSelect: function (rowId, iCol, content, event) {
									
							    },
							    loadComplete: function(){
							    	
							    },
							    gridComplete: function () {
							    	var grid = $(this).jqGrid();
							    	grid.navGrid('#summayPager', { edit: false, add: false, del: false, search: false, refresh: false, view: false, position: "left", cloneToTop: true  });
							    	//$('#funcParamsPager .ui-paging-pager').hide();
							    	
					 				$('#summayContainer .ui-jqgrid').css("width",'100%');
					 				$('#summayContainer .ui-jqgrid-view').css("width",'100%');
					 				$('#summayContainer .ui-jqgrid-hdiv').css("width",'100%');
					 				$('#summayContainer .ui-jqgrid-bdiv').css("width",'100%');
					 				$('#summayContainer .ui-jqgrid-pager').css("width",'100%');
					 				
					 				
							    }
					    	}
					    }
						
					]
				},
				{
					label:'List',
					type: 'Group',
					elements:[
						{
					    	type:'grid',
					    	id: 'funcParams',
					    	label:'',
					    	containerCss:[
					    		{code:'margin-top',value:'3px'}
					    	],
					    	data: function(){ 
					    		return pivotObject.list;
					    	},
					    	items:function(){
					    		return getGridModel();
					    	},
					    	gridOpt:{
					    		datatype:'local',
					    		//userdata: "rows",
					    		//pager: "#funcParamsPager",
					    		viewrecords: true,
					    		rowNum:1000000,
					    		rowList:[10,20,30,50,100],
					    		//url: '/dashboard/rest/fwq/codingRule/list/${param.project}/${param.measureDt1}/${param.measureDt2}',
					    		//closeAfterEdit: true,
					    		width: '100%',
					    		height: 520,
					    		//height: '100%',
					    		grouping: true,
					    		groupingView: {
									groupField: ["CATEGORY"],
									groupColumnShow: [false],
									groupText: ["<b>{0}</b>"],
									//groupOrder: ["asc"],
									groupSummary: [true],
									groupSummaryPos: ["header"],
									hideFirstGroupCol: true,
									groupCollapse: false,
									groupDataSorted: false
								},
					    		onCellSelect: function (rowId, iCol, content, event) {
									
							    },
							    loadComplete: function(){
							    	
							    },
							    gridComplete: function () {
							    	var grid = $(this).jqGrid();
							    	grid.navGrid('#funcParamsPager', { edit: false, add: false, del: false, search: false, refresh: false, view: false, position: "left", cloneToTop: true  });
							    	//$('#funcParamsPager .ui-paging-pager').hide();
							    	
					 				$('#funcParamsContainer .ui-jqgrid').css("width",'100%');
					 				$('#funcParamsContainer .ui-jqgrid-view').css("width",'100%');
					 				$('#funcParamsContainer .ui-jqgrid-hdiv').css("width",'100%');
					 				$('#funcParamsContainer .ui-jqgrid-bdiv').css("width",'100%');
					 				$('#funcParamsContainer .ui-jqgrid-pager').css("width",'100%');
					 				
					 				/* grid.jqGrid('filterToolbar',
				 						{
				 							defaultSearch:'cn' ,
				 			                // JSON stringify all data from search, including search toolbar operators
				 			                stringResult: true
				 			                // instuct the grid toolbar to show the search options
				 			                //searchOperators: false
				 			            }
				 					);	 */
					 				
							    }
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
			
			if(_schema.items != undefined && typeof _schema.items == 'function')
				opt.colModel = _schema.items();
			
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
			var defaultValue = "";
			if(mainControl != null  && _schema.value != undefined){
				if(typeof _schema.value == 'string')
					defaultValue = _schema.value;
				else if(typeof _schema.value == 'function')
					defaultValue = _schema.value();
			}
			$.each(vData,function(){
				var option = $(document.createElement( "option" ));
				
				option.val(this[_schema.options.cd]);
				option.text(this[_schema.options.name]);
				if(option.val() == defaultValue){
					//option.attr("checked",true);
					option.attr("selected","selected");
				}
					
				//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
				$.each(this,function(k,v){
					option.attr(k.toLowerCase(),v);
				});
				//sb.push("<option value='"+ this[_schema.options.cd] +"' "+''+">" + this[_schema.options.name] +"</option>");
				mainControl.append(option);
			});
			//$(vSelect).append(sb.join(""));
			var multiselectOpt = {
				//selectedList: 1,
				height:300,
				minWidth: 100,
				//selectedText: _schema.text + ' # selected',
				selectedText: function(numChecked, numTotal, checkedItems){
				     return numChecked + ' of ' + numTotal + ' checked';
				},
				noneSelectedText: 'Select ' + _schema.text
				
			};
			if(_schema.multiselectOpt != undefined)
				$.extend(multiselectOpt, _schema.multiselectOpt);
			var vMultiSelect = mainControl.multiselect(multiselectOpt).multiselectfilter();
			
			
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
			$.each(_schema.events,function(i,event){
				mainControl.on( event.name, event );
				
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
		getDataByJson();
		//makeHtml('contents', schema);
		$( window ).unload(function() {
			
		});
		
	});
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/rest/fwq/codingRule/list/${param.pjt_code}/${param.project}/${param.measureDt1}/${param.measureDt2}",
			//data: {measureDt:'${param.measureDt}'},
			async: false,
			success : function(responseData){
				funcParams = responseData.rows;
				
				//pivotObject =  pivot(responseData.rows,{col:'MEASURE_DT',name:'MEASURE_DT'},['CATEGORY','PJT_CODE','PROJECT','RULE','SEVERITY'],'CNT');
				pivotObject =  pivotMultiCol(responseData.rows,[{col:'PROJECT',name:'PROJECT'},{col:'MEASURE_DT',name:'MEASURE_DT'}],['CATEGORY','RULE','SEVERITY'],'CNT');
				$.each(pivotObject.list,function(i,v){
					this['order'] = i;
					var message = dataFilter(responseData.rows,[{col:'CATEGORY',val:this.CATEGORY},{col:'RULE',val:this.RULE},{col:'SEVERITY',val:this.SEVERITY}]);
					if(message.length>0)
						this['MESSAGE'] =  message[0].MESSAGE;
					
				});
				summaryObject = pivotMultiCol(responseData.rows,[{col:'PROJECT',name:'PROJECT'},{col:'MEASURE_DT',name:'MEASURE_DT'}],['CATEGORY','SEVERITY'],'CNT');
				makeHtml('contents', schema); 
				
				// function에 padding 추가
				var theGrid = $("#funcParams");
				theGrid.find("tr.jqgrow").each(function () {
				    var summaryrow = $(this);
				    //summaryrow.children(":eq(1)").css("padding-left","30px");
				});
				
				//$(".cont_tit").hide();

			}
		});
	}
	
	
	
	function fn_close(){
		window.close();
	}
	
	function getGridModel(){
		var gridModel = [
		     		    {label:'Category', name:'CATEGORY',width:200, sortable: false, editable: false, search:false,sorttype: fn_mysort},
		     		    {label:'Rule', name:'RULE',width:200, sortable: false, editable: false, search:false},
						{label:'Project', name:'PROJECT',width:100, sortable: false, editable: false, search:false, hidden: true}
		           	];
		
		$.each(pivotObject.columns,function(i,col){
			
			var columnName = "";
			$.each(pivotObject.colDef , function(di, colDef){
				if(di == 0)
					columnName = col[colDef.col];
				else
					columnName += ";" + col[colDef.col];
			});
			
			gridModel.push({
				label: columnName.replace(";","<br/>") , 
				name: columnName, 
				id: columnName, 
				width:120,
				align:'right', 
				textAlign:'right',
				sortable:false,
				hidden:false,
				summaryType: 'sum', 
				formatter:'integer',
				classes:"paddingRight8",
				search:false
			});
		});
		
		gridModel.push({label:'Severity', name:'SEVERITY',width:80, sortable: false, editable: false, search:false,align:'center', textAlign:'center'});
		gridModel.push({label:'MISRA-C Rule Summary', name:'MESSAGE',width:350, sortable: false, editable: false, search:true});
		
		
		return gridModel;
	}
	
	function getGridModelSummary(){
		var gridModel = [
						{label:'Category', name:'CATEGORY',width:300, sortable: false, editable: false, search:false,sorttype: fn_mysort},
						{label:'Severity', name:'SEVERITY',width:150, sortable: false, editable: false, search:false,align:'center', textAlign:'center'}
		           	];
		
		$.each(summaryObject.columns,function(i,col){
			
			var columnName = "";
			$.each(summaryObject.colDef , function(di, colDef){
				if(di == 0)
					columnName = col[colDef.col];
				else
					columnName += ";" + col[colDef.col];
			});
			
			gridModel.push({
				label: columnName.replace(";","<br/>") , 
				name: columnName, 
				id: columnName, 
				width:120,
				align:'right', 
				textAlign:'right',
				sortable:false,
				hidden:false,
				summaryType: 'sum', 
				formatter:'integer',
				classes:"paddingRight8",
				search:false
			});
		});
		
		return gridModel;
	}
	
	
	function fn_mysort(cellValue, obj){
		return obj.order;
	}
	
	function pivotMultiCol(datasrc,colDefs,groupbyColumns,targetColumn){
		var rtnObject = {};
		//var groupList = groupbyCount(datasrc,groupbyColumns);
		var groupList = groupbySum(datasrc,groupbyColumns, targetColumn);
		groupList = _.filter(groupList, function(item){
			return item[groupbyColumns[1]] != 'Undefined';
		});
		var cols = groupbyCount(datasrc, _.pluck(colDefs, 'col'));
		sortObjects(cols, _.pluck(colDefs, 'col'));
		
		$.each(groupList,function(i,group){
			$.each(cols,function(ci,col){
				var filter = [];	
				
				//filter1
				$.each(groupbyColumns,function(c,v){
					if(c != 'count'){
						filter.push({col: v, val: group[v] });
					}
				});
				//filter2
				$.each(colDefs,function(di,colDef){
					var colcd ="";
					var colname= "";					
					colcd = colDef.col;
					colname = colDef.name;
					
					filter.push({col: colcd ,val: col[colDef.col]});
				
				});
				
				
				//여러개의 컬럼이 존재하는 경우 ; 로 구분함
				var targets = dataFilter(datasrc,filter);
				//var target = {};
				var target = groupbySum(targets,[], targetColumn);
				var columnName = "";
				$.each(colDefs,function(di,colDef){
					if(di == 0)
						columnName = col[colDef.col];
					else
						columnName += ";" + col[colDef.col];
				});
				if(targets.length > 0){
					target = target[0];
					// customize
					if(target.isPlan != undefined && target.isPlan == true)
						group.isPlan = true;
				}else{
					group[columnName] = 0;
					return true;
				}
				
				var tval = 0;
				if(target[targetColumn] != undefined)
					tval = target[targetColumn];
				group[columnName] = tval;
				group[columnName] = tval;
				
			});
		});
		
		rtnObject.list = groupList;
		rtnObject.datasrc = datasrc;
		rtnObject.colDef = colDefs;
		rtnObject.columns = cols;
		rtnObject.groupbyColumns = groupbyColumns;
		rtnObject.targetColumn = targetColumn;
		
		return rtnObject ;
		
	}
	
	
</script>
<script comment="divPop">

(function($) {
    $.fn.popupWindow = function(instanceSettings) {

        return this.each(function() {

            $(this).click(function() {

                $.fn.popupWindow.defaultSettings = {
                    centerBrowser: 0, // center window over browser window? {1 (YES) or 0 (NO)}. overrides top and left
                    centerScreen: 0, // center window over entire screen? {1 (YES) or 0 (NO)}. overrides top and left
                    height: 500, // sets the height in pixels of the window.
                    left: 0, // left position when the window appears.
                    location: 0, // determines whether the address bar is displayed {1 (YES) or 0 (NO)}.
                    menubar: 0, // determines whether the menu bar is displayed {1 (YES) or 0 (NO)}.
                    resizable: 0, // whether the window can be resized {1 (YES) or 0 (NO)}. Can also be overloaded using resizable.
                    scrollbars: 0, // determines whether scrollbars appear on the window {1 (YES) or 0 (NO)}.
                    status: 0, // whether a status line appears at the bottom of the window {1 (YES) or 0 (NO)}.
                    width: 500, // sets the width in pixels of the window.
                    windowName: null, // name of window set from the name attribute of the element that invokes the click
                    windowURL: null, // url used for the popup
                    top: 0, // top position when the window appears.
                    toolbar: 0 // determines whether a toolbar (includes the forward and back buttons) is displayed {1 (YES) or 0 (NO)}.
                };

                settings = $.extend({}, $.fn.popupWindow.defaultSettings, instanceSettings || {});

                var windowFeatures = 'height=' + settings.height +
                    ',width=' + settings.width +
                    ',toolbar=' + settings.toolbar +
                    ',scrollbars=' + settings.scrollbars +
                    ',status=' + settings.status +
                    ',resizable=' + settings.resizable +
                    ',location=' + settings.location +
                    ',menuBar=' + settings.menubar;

                settings.windowName = this.name || settings.windowName;
                settings.windowURL = this.href || settings.windowURL;
                var centeredY, centeredX;

                if (settings.centerBrowser) {

                    if ($.browser.msie) { //hacked together for IE browsers
                        centeredY = (window.screenTop - 120) + ((((document.documentElement.clientHeight + 120) / 2) - (settings.height / 2)));
                        centeredX = window.screenLeft + ((((document.body.offsetWidth + 20) / 2) - (settings.width / 2)));
                    } else {
                        centeredY = window.screenY + (((window.outerHeight / 2) - (settings.height / 2)));
                        centeredX = window.screenX + (((window.outerWidth / 2) - (settings.width / 2)));
                    }
                    window.open(settings.windowURL, settings.windowName, windowFeatures + ',left=' + centeredX + ',top=' + centeredY).focus();
                } else if (settings.centerScreen) {
                    centeredY = (screen.height - settings.height) / 2;
                    centeredX = (screen.width - settings.width) / 2;
                    window.open(settings.windowURL, settings.windowName, windowFeatures + ',left=' + centeredX + ',top=' + centeredY).focus();
                } else {
                    window.open(settings.windowURL, settings.windowName, windowFeatures + ',left=' + settings.left + ',top=' + settings.top).focus();
                }
                return false;
            });

        });
    };
})(jQuery);

//position center
jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", ( $(window).height() - this.height() ) / 2+$(window).scrollTop() + "px");
    this.css("left", ( $(window).width() - this.width() ) / 2+$(window).scrollLeft() + "px");
    return this;
}
</script>

</head>
<body>
<form name="form1" id="form1" method="post" >
<input type="hidden" name="version" id="version"  value=""/>
<input type="hidden" name ="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="productName" name="productName" value="${param.productName}"  searchBinding="PRODUCT_NAME"/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<input type="hidden" id="testId" name="testId" value="${param.testId}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
	<div class="pop_window">
		<div class="pop_tit_wrap">
			<!-- <span class="baseline"></span> -->
			<h2 class="pop_tit" style="margin-top:10px;">Coding Rule Detailed Information</h2>
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
    <div id="dialog-confirm"></div>
    <!-- ## //PAGE CONTENTS ## -->	
</form>
</body>

<iframe id="file_iframe" style="display:none;"></iframe>
</html>