<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>IAR License</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
    
    <script type="text/javascript" src="js/jqGrid/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="js/jqGrid/i18n/grid.locale-kr.js"></script>
    
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/i18n/grid.locale-en.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/jquery.jqGrid.src.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/json2.js"></script> -->
    
    <%-- 2. high charts --%>
    
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. local --%>
	<script src="js/pms/resourceBySite.js"></script>
	<script src="js/pms/resourceByFunc.js"></script>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	
	<%-- jqgrid --%>
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <!-- link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">  -->
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
	
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
    
	
	<script type="text/javascript">
	var schemaContent = {
			containerId:'gridContainer',
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
			    	id: 'grid_summary',
			    	label:'Data List',
			    	data: function(){ 
			    		dataList = [];
			    		
			    		$.ajax({
			    			type: "POST",
			    			url: "/dashboard/genericlListJson.do?sqlid=license.selectIarLicenseUseList.grid",
			    			//data: {searchJson: JSON.stringify(paramObj), sqlid: 'dashboard.regresson.smartlist.raw'}, 
			    			data: {fromDt:'${searchVO.fromDt}', toDt:'${searchVO.toDt}'}, 
			    			async: false,
			    			success:  function(response){
			    				dataList  = response.dataList;
			    			}
			    		});
			    		
			    		
			    		return dataList;
			    	},
			    	items:[
						{label:'Date',name:'LOG_FULL_DATE', id:'LOG_FULL_DATE',width: 100
							//,stype: "select"
							//, searchoptions: gridSearchOption.foldername
						},
						{label:'Type', name:'TRANS_TYPE', id:'TRANS_TYPE',width: 90, align: 'center'},
						{label:'Feature Name', name:'FEATURE_NAME', id:'FEATURE_NAME',width: 200, align: 'left'},
						{label:'Feature Version', name:'FEATURE_VERSION', id:'FEATURE_VERSION',width: 130, align: 'center'},
						{label:'User Num', name:'USER_NUM', id:'USER_NUM',width: 90, align: 'center'},
						{label:'Host Name', name:'HOST_NAME', id:'HOST_NAME',width: '', align: 'center'}
						
			    	],
			    	gridOpt:{
			    		datatype:'local',
			    		pager: "#grid_summaryPager",
			    		viewrecords: true,
			    		width: '100%',
			    		height: '100%',
			    		sortable: true,
			    		multiSort:true,
			    		sortname: 'LOG_FULL_DATE, TRANS_TYPE, FEATURE_NAME ',
			    		rowNum: 20,
						rowList:[10,20],
			    		//forceFit : false ,
			    		gridComplete: function () {
			    			var grid = $(this).jqGrid();
			    			//$('#testDisksContainer .ui-jqgrid-titlebar').css("background","rgba(245,246,250,0.6)");
			    			
			    			grid.jqGrid('filterToolbar',
			    					{
			    						defaultSearch:'cn' ,
			    		                // JSON stringify all data from search, including search toolbar operators
			    		                stringResult: true
			    		                // instuct the grid toolbar to show the search options
			    		                ,searchOperators: true
			    		            }
			    				);
			    			
			    		}
				    	
			    	}
					
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
				mainContainer.find(".ui-jqgrid-pager").css("width","100%");
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
//		    	
// 	 		});
			
			if(options.stockchart != undefined && options.stockchart){
				$(mainContainer).highcharts('StockChart',options,function(chart){
				});
			}else{
				$(mainContainer).highcharts(options,function(chart){
		    	
			 	});
			}
			
			 
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
			if(_schema.multiselectOpt != undefined && _schema.multiselectOpt.multiple != undefined && _schema.multiselectOpt.multiple == true )
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
			
		}else if(_schema.type == 'monthInput'){
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
			//mainControl.MonthPicker();
			//mainControl.MonthPicker('option','MonthFormat', 'yymm');
			mainContainer.append(mainControl);			
			
			container.append(mainContainer);
			mainControl.MonthPicker();
			mainControl.MonthPicker('option','MonthFormat', 'yymm');
			$("#MonthPicker_" + _schema.id).css("width","160px");   
			
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

	
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson() {	
		$.ajax({
			type: "POST",
			url : "/dashboard/iarLicenseUseJson.do",
			data: {fromDt:'${searchVO.fromDt}', toDt:'${searchVO.toDt}'},
			success : function(responseData){
				drawchart(responseData);
				
				$("#gridContainer").html("");
				//makeHtml('gridContainer',schemaContent);
			}
		});
	}
	
	function drawchart(responseData) {
		
		var groupKeys = ['USE_DATE'];
		var series = getDrillDownDataSeries2(
				'',
				responseData.dataList , 									// 데이타원본
				groupKeys , 										// grouping, sorting 순서
				[], 												// filter
				[{col:'USE_DATE', convert:'x', datatype:'date'},{col:'USE_CNT', convert:'y', isnull:0}], 
				'', 										// x축
				'', 												// y값이 되는 컬럼, groupby시 에만 의미있음
				{cd: 'IMSI', name:'IMSI'},			// series 없으므로 가상의 Column 정의
				{isGroupby:false}
		);
		
		if($('#container').highcharts() != undefined) {
			$('#container').highcharts().destroy();
		}
		
		var maxVal = 7;
		var dataObj;
		for(var i=0; i<series.series[0].data.length; i++) {
			dataObj = series.series[0].data[i];
			if(dataObj.y >= 7) {
				dataObj.color = '#BF0B23';
			}
			
			if(dataObj.y > maxVal) {
				maxVal = dataObj.y;
			}
		}
		
		$('#container').highcharts('StockChart',{
	        chart: {
	            type: 'column',
	            height: 300,
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'',
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	type: 'datetime',
	        	dateTimeLabelFormats: { 
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            }
	        },
	        yAxis: {
	        	min: 0,
	        	max: maxVal,
	        	tickInterval: 1,
	            title: {
	            	enabled: true,
	                text: '<b>Count</b>',
	                align: 'high',
	                style: {
	                    fontWeight: 'normal'
	                }
	            },
	            plotLines: [{
                    value: 6,
                    color: 'red',
                    dashStyle: 'shortdash',
                    width: 2,
                    label: {
                        text: 'Limit',
                        style: {
                            color: 'red',
                            fontWeight: 'bold'
                        }
                    }
                }],
	            visible: false,
	            opposite: false
	        },
	        legend: {
	        	enabled: false
	        },
	        plotOptions : {	        	
	        	series : {
	        		dataLabels: {
	        			enabled: true,
	        			color: '#966124'
	        		}
	        	}
	        },
	        rangeSelector: {
                inputEnabled: false,
                enabled:false
            },
            exporting: {
            	enabled: false
            },
	        series: series.series
	    },function(chart){
	    		//after draw chart
		    }
		);
	}

	</script>
	<style type="text/css">
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow:hidden;
	     }
	      
		.container{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 100%;			
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
	    .table>tbody>tr>td {
		    padding: 3px;
		}
	</style>
</head>
<body style="height: 100%;width: 100%">
<form name="form" id="form">

<div id="container" class=""></div>
<div id="gridContainer" class=""></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
