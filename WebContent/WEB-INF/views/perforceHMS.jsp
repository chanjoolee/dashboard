<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Jira Issue HMS Soct</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script> 
    <!-- <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script> -->

    <!-- <script src="js/Highstock-5.0.9/api/js/jquery-1.11.3.min.js"></script> -->
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script> -->
    <!-- <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script> -->
    <script src="js/Highstock-5.0.9/api/js/jquery-ui.min.js"></script>
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
	<!-- <script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script> -->
	
	<!-- <script src="https://code.highcharts.com/stock/highstock.js"></script>
	<script src="https://code.highcharts.com/stock/modules/exporting.js"></script> -->
	
	<script src="/dashboard/js/Highstock-5.0.9/code/highstock.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/drilldown.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/highcharts-more.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/no-data-to-display.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/exporting.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<!-- <script src="js/highcharts/src/highcharts-more.src.js"></script> -->
	<!-- <script src="js/highcharts/src/exporting.src.js"></script> -->
	<!-- <script src="js/Highstock-5.0.9/code/modules/exporting.src.js"></script> -->
	
	
	<%-- x축 그룹라벨 --%>
	<!-- <script src="/dashboard/js/highcharts/grouped-categories.js"></script> -->
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	
	<script type="text/javascript" src="/dashboard/js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="/dashboard/js/highslide/highslide.config.js" charset="utf-8"></script>
	 
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
	var vSearchConditions = {};
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
											id: 'pjtCodeHead',
											name: 'pjtCodeHead',
											label:'',
											text:'Project',
											width: '60px'
										},
										
										{
											type:'multiCombo',
											id: 'pjtCode',
											name: 'pjtCode',
											containerCss:[{code:'display',value:'none'}],
											label:'',
											text:'Project',
											width: '350px',
											data: function(){
												var rtnList = [];												
												return rtnList;
											},
											options: {
												isSingle: true
											},
											events: {
												change: function(){
													changePjtCode();
													
												}
											}
										},
										{
											type:'multiCombo',
											id: 'project',
											name: 'project',
											label:'',
											text:'Project',
											width: '350px',
											data: function(){
												var rtnList = [];	
												
												rtnList.push({project:'Sapphire'});
												rtnList.push({project:'Gemini '});
												rtnList.push({project:'Quartz (P3)'});
												rtnList.push({project:'Emerald'});		
												
												
												var vPjtCode = "";
												$.ajax({
										    		url: "/dashboard/projectListSubByJson.do",
										    		data: {PJT_CODE: '${param.pjtId}',division:'jira'	}, 
										    		async: false,
										    		success:  function(response){
										    			var projects  = response.projectList;
										    			$.each(projects,function(i,p){
										    				var rtnObj = dataFilter(rtnList,[{col:'project',val:p.SUB_PJT_CODE}]);
										    				if(rtnObj.length > 0){
										    					rtnObj[0].selected = 'selected';
										    					vPjtCode = p.SUB_PJT_CODE;
										    				}
										    					
										    			});											    			
										    		}
										    	});
												
												//-- start 검색조건유지
												/* $("#PJT_CODE").val(vPjtCode);
												$.ajax({
													type: "POST",
													async:false,
													url : "/dashboard/checkSearchConditionJson.do",
													data: $("#form").serialize() ,
													success : function(responseData){
														vSearchConditions  = responseData.searchCondition;															
													}
												
												}); */
												//-- end 검색조건유지
												
												return rtnList;
											},
											options: {
												isSingle: true,
												cd:'project',
												name:'project'					
											},
											events: {
												change: function(){
													//changeProject();
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
							    		{code:'height',value:'30px'},
							    		{code:'display',value:'none'}
							    	],
									elements:[
										{
											type:'SearchHeader',
											id: 'basedayHead',
											name: 'Baseday',
											label:'',
											text:'Base Day',
											width: '60px'
										},
										{
											type:'multiCombo',
											id: 'baseday',
											name: 'baseday',
											label:'',
											text:'Baseday',
											width: '160px',
											data: function(){
												var rtnList = [];									
												
												rtnList.push({cd:'2',name:'Mon'});
												rtnList.push({cd:'3',name:'Tue'});
												rtnList.push({cd:'4',name:'Wed'});
												rtnList.push({cd:'5',name:'Thu'});
												rtnList.push({cd:'6',name:'Fry'});
												rtnList.push({cd:'7',name:'Sat'});
												rtnList.push({cd:'1',name:'Sun'});
												
												// start 검색조건유지
								    			//if(vSearchConditions != null && vSearchConditions.basedayArr != undefined && vSearchConditions.basedayArr.length > 0){
								    			if(1==2){
								    				/* $.each(rtnList,function(){
								    					if($.inArray( this.cd, vSearchConditions.basedayArr) >= 0)
									    					this.selected = "selected";
									    			}); */
								    			}else{
								    				$.each(rtnList,function(){
									    				if(this.cd == '4')
									    					this.selected = "selected";
									    			});
								    			}
								    			// end 검색조건유지
												return rtnList;
											},
											options: {												
												isSingle: true,
												height: 200,
												cd:'cd',
												name:'name'		,
												selectedText : '#'
											},
											events: {
												change: function(){
													
												}
											}
										},										
										{
											type:'multiCombo',
											id: 'baseHour',
											name: 'baseHour',
											label:'',
											text:'BaseHour',
											width: '80px',
											data: function(){
												var rtnList = [];	
												for(var i=1; i <= 24;i++){
													var a = {cd: i + '' , name: i + ':00'};
													rtnList.push(a);
												}
												
												// start 검색조건유지
								    			//if(vSearchConditions != null && vSearchConditions.baseHourArr != undefined && vSearchConditions.baseHourArr.length > 0){
								    			if(1 == 2){
								    				/* $.each(rtnList,function(){
								    					if($.inArray( this.cd, vSearchConditions.baseHourArr) >= 0)
									    					this.selected = "selected";
									    			}); */
								    			}else{
								    				$.each(rtnList,function(){
									    				if(this.cd == '10')
									    					this.selected = "selected";
									    			});
								    			}
								    			// end 검색조건유지
												
												return rtnList;
											},
											options: {												
												isSingle: true,
												//height: 200,
												minWidth: 50,
												cd:'cd',
												name:'name'		,
												selectedText : '#'
											},
											events: {
												change: function(){
													
												}
											}
										}
									]
								}
								// end 2line
								
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
	
	function setGridAttr(rowId, val, rawObject, cm) {
		//var attr = rawObject.attr[cm.name], result;
		var rownum = parseInt(rowId,10) -1 ;
		var rowspan = 1; 
		var preVal = "";
		var postVal = "";
		//var attr = rawObject[cm.name];
		var result = "";
		var style = "";
		
		style += " cursor:pointer;";
		result +=" style=\""+style+";color:blue;\"";
		result +=" title=\""+val+"\"";
		
		if(rawObject != undefined){
			
			if(rawObject.COMPONENT != undefined){
				//result += " onclick = popHmsDetail('" + rawObject.PROJECT.replace(/\s/gi,'&nbsp;') + "','" + rawObject.CATEGORY + "','" + rawObject.COMPONENT.replace(/\s/gi,'&nbsp;') + "','" + cm.id + "');";
				//result += " onclick = popHmsDetail('" + rawObject.PROJECT.replace(/\s/gi,' ') + "','" + rawObject.CATEGORY + "','" + rawObject.COMPONENT.replace(/\s/gi,' ') + "','" + cm.id + "');";
			}				
			else{
				//result += " onclick = popHmsDetail('" + rawObject.PROJECT.replace(/\s/gi,'&nbsp;') + "','" + rawObject.CATEGORY + "',null','" + cm.id + "');";
				//result += " onclick = popHmsDetail('" + rawObject.PROJECT.replace(/\s/gi,' ') + "','" + rawObject.CATEGORY + "',null','" + cm.id + "');";
			}
				
		
		}else{
			result +=" ";
			
		}
			
		return result;
	}
		
	var schemaContents = {
			containerId:'contents',
			type:'Vertical',
			label:'',
			elements:[ 
				{
					type: 'Group',
					label: 'User',						
					elements:[
						{
							containerCss:[
								{code: 'display', value:''}
							],					
							type:'chart',
	    	            	id: 'user',
	    	            	label:'',
	    	            	width: '99%',
	    	            	data: function(){
	    	            		return getDataUser();
	    	            	},
	    	            	options: function(){
	    	            		return getOptionUser();
	    	            	}
	    	            }
						
					]
				}
				,{
					type: 'Group',
					label: 'Block',						
					elements:[
						{
							containerCss:[
								{code: 'display', value:'none'}
							],			
							type:'chart',
	    	            	id: 'block',
	    	            	label:'',
	    	            	width: '99%',
	    	            	data: function(){
	    	            		return getDataBlock();
	    	            	},
	    	            	options: function(){
	    	            		return getOptionBlock();
	    	            	}
	    	            }
						
					]
				}
				,{
					type: 'Group',
					label: 'Activity',						
					elements:[
						{
							containerCss:[
								{code: 'display', value:'none'}
							],		
							type:'chart',
	    	            	id: 'activity',
	    	            	label:'',
	    	            	width: '99%',
	    	            	data: function(){
	    	            		return getDataActivity();
	    	            	},
	    	            	options: function(){
	    	            		return getOptionActivity();
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
	var projectList = [];
	var dataListUser = []; var dataListUserOk = false;
	var dataListBlock = []; var dataListBlockOk = false;
	var dataListActivity = []; var dataListActivityOk = false;
	
	var chartUser = {};
	var chartBlock = {};
	var chartActivity = {};
	
	
	$(function () {	
		setTimeout(function(){		
			makeHtml('searchCondition', schemaSearch);
			//pmsProjectList();
			getDataByJson();
		},50);
		$( window ).resize(function() {
			adjustSize();
		});
	});
	
	function pmsProjectList(){
		$.ajax({
			//url : "/dashboard/dashboardProjectListJson.do",
			url : "/dashboard/pmsProjectListJson.do",
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
						if(this.PJT_CODE==$("#pjtId").val())
							selected = "selected";
						else 
							selected = "";
						sb.push("<option value='"+ d.PJT_CODE +"' "+selected+" status='"+d.PJT_STATE+"'>" + d.PJT_NAME +"</option>");
					});
					sb.push("</optgroup>");
				});
				
				$("select[name=pjtCode]").append(sb.join(""));
				
				$("select[name=pjtCode]").change(function(){
					//getGridData();
				});
				
				/* projectMultiSelect = $("select[name=pjtCode]").multiselect({
					height:400,
					selectedText: function(numChecked, numTotal, checkedItems){
					     return numChecked + ' of ' + numTotal + ' checked';
					},
					noneSelectedText: 'Select projects'
				}).multiselectfilter(); */
				
				
				$("select[name=pjtCode]").multiselect('refresh');
				//상태표시
				$.each(series.series,function(index,s){
					$.each(s.data,function(index1,d){
						var label = $("input[name=multiselect_pjtCode][value="+d.PJT_CODE+"]").parent();
						label.append("<span style='color: blue;float:right;'>"+ d.PJT_STATE_NAME +"</span>");
						
					});
				});
				
				//$("div.ui-multiselect-menu").css("width","500px");
				//$(".ui-multiselect-filter input").css("width","200px");
				
				
				
			}
		});
	}
	
	function getDataByJson(){
		if($("#project").val() == null && $("#pjtCode").val() == null){
			$("#loader").hide();
			return;
		}
			
		$("#loader").show();
		//setCalendarRsc();
		setTimeout(function(){
			
			// start 검색조건유지
			var vPjtCode = "";
			if($("#pjtCode").val() != null){
				vPjtCode = $("#pjtCode").val();
			}else if($("#project").val() != null ){
				vPjtCode = $("#project").val();
			}
			$("#PJT_CODE").val(vPjtCode);
			// end 검색조건유지
			
			/* $.ajax({
				url : "/dashboard/perforceHmsListJson.do",
				data: $("#form").serialize() ,
				async: false,
				success : function(responseData){
					dataListUser = responseData.dataListUser;
					dataListBlock = responseData.dataListBlock;
					dataListUser = responseData.dataListUser;
					dataListActivity = responseData.dataListActivity;
					
					$("#contents").html("");
					makeHtml('contents', schemaContents);						
					$("#contents h3").hide();
					adjustSize();
					
					$(".tab_2depth li").removeClass('on');
					$(".tab_2depth li").addClass('off');
					$("#tabUser").removeClass('off');
					$("#tabUser").addClass('on');
									
					$("#loader").hide();
					
				}
			}); */
			dataListUserOk = false;
			dataListBlockOk = false;
			dataListActivityOk = false;
			$.ajax({
				url : "/dashboard/perforceHmsListUserJson.do",
				data: $("#form").serialize() ,
				async: true,
				success : function(responseData){
					dataListUser = responseData.dataListUser;
					dataListUserOk = true;
					if(dataListUserOk && dataListBlockOk && dataListActivityOk){
						$("#contents").html("");
						makeHtml('contents', schemaContents);						
						$("#contents h3").hide();
						
						
						$(".tab_2depth li").removeClass('on');
						$(".tab_2depth li").addClass('off');
						$("#tabUser").removeClass('off');
						$("#tabUser").addClass('on');
						adjustSize();
										
						$("#loader").hide();
					}
					
				}
			});
			
			$.ajax({
				url : "/dashboard/perforceHmsListBlockJson.do",
				data: $("#form").serialize() ,
				async: true,
				success : function(responseData){
					dataListBlock = responseData.dataListBlock;
					dataListBlockOk = true;
					if(dataListUserOk && dataListBlockOk && dataListActivityOk){
						$("#contents").html("");
						makeHtml('contents', schemaContents);						
						$("#contents h3").hide();
						
						
						$(".tab_2depth li").removeClass('on');
						$(".tab_2depth li").addClass('off');
						$("#tabUser").removeClass('off');
						$("#tabUser").addClass('on');
						adjustSize();
										
						$("#loader").hide();
					}
				}
			});
			
			$.ajax({
				url : "/dashboard/perforceHmsListActivityJson.do",
				data: $("#form").serialize() ,
				async: true,
				success : function(responseData){
					dataListActivity = responseData.dataListActivity;
					dataListActivityOk = true;
					if(dataListUserOk && dataListBlockOk && dataListActivityOk){
						$("#contents").html("");
						makeHtml('contents', schemaContents);						
						$("#contents h3").hide();
						
						
						$(".tab_2depth li").removeClass('on');
						$(".tab_2depth li").addClass('off');
						$("#tabUser").removeClass('off');
						$("#tabUser").addClass('on');
						adjustSize();
										
						$("#loader").hide();
					}
				}
			});
			
			
			
		},50);
		
				
	}	
	
	
	// 프로젝트 선택이 바뀌면 Component 를 업데이트 한다.
	function changePjtCode(){
		$("#loader").show();
		var components = [];
		$.ajax({
    		url: "/dashboard/jiraIssueComponentJson.do",
    		data: {pjtCode: $("#pjtCode").val()[0]	}, 
    		async: false,
    		success:  function(response){
    			components = response.dataListCompoent;
    			$.each(components,function(){
    				this.selected = "selected";
    			});											    			
    		}
    	});
		
		$("#components").html("");
		
		var vData = components;
		var sb = [];
		mainControl = $("#components");
		
		$.each(vData,function(){
			var option = $(document.createElement( "option" ));
			option.val(this['CNAME']);
			option.text(this['CNAME']);
			//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
			$.each(this,function(k,v){
				option.attr(k.toLowerCase(),v);
			});
			mainControl.append(option);
		});
		
		
		$("#components").multiselect('refresh');
		$("#loader").hide();
		
	}
	
	function changeProject(){
		$("#loader").show();
		var components = [];
		$.ajax({
    		url: "/dashboard/jiraIssueComponentJson.do",
    		data: {project: $("#project").val()[0]	}, 
    		async: false,
    		success:  function(response){
    			components = response.dataListCompoent;
    			$.each(components,function(){
    				this.selected = "selected";
    			});											    			
    		}
    	});
		
		$("#components").html("");
		
		var vData = components;
		var sb = [];
		mainControl = $("#components");
		
		$.each(vData,function(){
			var option = $(document.createElement( "option" ));
			option.val(this['CNAME']);
			option.text(this['CNAME']);
			//모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
			$.each(this,function(k,v){
				option.attr(k.toLowerCase(),v);
			});
			mainControl.append(option);
		});
		
		
		$("#components").multiselect('refresh');
		$("#loader").hide();
		
	}
	
	function getDataUser(){
		var rtn = {};
		//var series = {series:[]};
		
		//01.
		var datas1 = $.extend(true,[],dataListUser);
		var series = getDrillDownDataSeries2(
				'',
				datas1 ,
				['ROW_NUM','DT'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'CHANGED_LINE' , convert:'y',isnull:0},{col:'DT', convert:'x', datatype:'date'}], //convert
				'DT' ,  //category
				'', // target
				{cd:'ROW_NUM', name:'ROW_NUM'},
				{isGroupby: false}
		);
		
		
		rtn.series = series;
		
		return rtn;
		// return end
	}
	
	function getDataBlock(){
		var rtn = {};
		//var series = {series:[]};
		
		//01.
		var datas1 = $.extend(true,[],dataListBlock);
		var series = getDrillDownDataSeries2(
				'',
				datas1 ,
				['ROW_NUM','DT'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'NET_CHANGED_LINE' , convert:'y',isnull:0},{col:'DT', convert:'x', datatype:'date'}], //convert
				'DT' ,  //category
				'', // target
				{cd:'ROW_NUM', name:'ROW_NUM'},
				{isGroupby: false}
		);
		
		
		rtn.series = series;
		
		return rtn;
	}
	
	function getDataActivity(){
		var rtn = {};
		//var series = {series:[]};
		
		//01.
		var datas1 = $.extend(true,[],dataListActivity);
		var datas2 = [];
		$.each(datas1,function(i,d){
			datas2.push({GUBUN:'LINE_ADD', DT: d.DT, COUNT: d.LINE_ADD});
			datas2.push({GUBUN:'LINE_DELETE', DT: d.DT, COUNT: d.LINE_DELETE});
			datas2.push({GUBUN:'CHANGED', DT: d.DT, COUNT: d.CHANGED});
		});
		var series = getDrillDownDataSeries2(
				'',
				datas2 ,
				['GUBUN','DT'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'COUNT' , convert:'y',isnull:0},{col:'DT', convert:'x', datatype:'date'}], //convert
				'DT' ,  //category
				'', // target
				{cd:'GUBUN', name:'GUBUN'},
				{isGroupby: false}
		);
		
		$.each(series.series,function(){
			if(this.name=='CHANGED'){
				this.yAxis = 1;
			}
		});		
		
		rtn.series = series;
		
		return rtn;
	}
	
	function getOptionUser(){
		var datas1 = $.extend(true,[],dataListUser);
		var series = getDrillDownDataSeries2(
				'',
				datas1 ,
				['DT','ROW_NUM'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'CHANGED_LINE' , convert:'y',isnull:0},{col:'DT', convert:'x', datatype:'date'}], //convert
				'DT' ,  //category
				'', // target
				{cd:'ROW_NUM', name:'ROW_NUM'},
				{isGroupby: false}
		);
		
		var datepositions = [];
		if(series.series.length > 0 ){
			$.each(series.category,function(i,d){
				var utcData = convertDateToUct(d);			
				datepositions.push(utcData);
			});		
		}
		
		var option = {
				
		        chart: {
		            type: 'column',
		            //zoomType:'x',
		            //height: 700
		            //,animation: false
		            //,width: 600
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
		        legend:{
		        	enabled: false
		        },
		        rangeSelector:{
		        	allButtonsEnabled: true
		        	,selected: 0
		        },
		        yAxis: {
		        	min: 0	
		        },
		        xAxis: {
		        	type: 'datetime'
		        	//, tickInterval: 24 * 3600 * 1000 * 7
		        	,dateTimeLabelFormats: { // don't display the dummy year
		        		week: '%y/%m/%e',
		        		day: '%m/%e',
		        		//month: '%y/%m/%e',
		        		month: '%y/%m',
		        		//year: '%y/%m/%e'
		        		year: '%y'
		            }
		            //,range: 1 * 30 * 24 * 3600 * 1000 // 3 months
		            ,tickPositions: datepositions
		            //,tickPositions: [Date.UTC(1970, 9, 27), Date.UTC(1970, 10, 1), Date.UTC(1970, 10, 12), Date.UTC(1970, 10, 27), Date.UTC(1970, 12, 27)]
		            //,startOnTick : true
		            //,tickmarkPlacement: 'on'
					,labels: {
						rotation : 310						
				        ,formatter: function () {
				        	return Highcharts.dateFormat('%y/%m/%e',this.value);
				            //some cleanup may be required, but this is the general form of the solution
// 				            if (this.value in datepositions) {
// 				                return this.value;
// 				            }
				        }
				    }
		            
		            
		        },
		        tooltip: {
		            valueDecimals: 0,
		          	//headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
	                //headerFormat:'',
		            pointFormat: '<span style="color:"#303030">{point.ROW_NUM}. {point.SUBMITTEDBY}</span>: <b>{point.y:##,###.0f}</b> <br/>',
		            shared: true,
		            enabled: true
		        },
		        //legend: legend,
		        plotOptions: {
		        	column: {
		            	grouping: true,
		            	borderWidth: 0,
		            	//cursor: 'pointer' ,
		            	//stacking:'normal',
		                dataLabels: {
		                    enabled: true
		                    //allowOverlap: true,
		                    //format:'{point.y:.0f} ({point.percentage:.0f}%)'
		                    //format:'{point.y:.0f}',
		                    //x: 10,
		                   /*  formatter:function(){
		                    	
		                    }, */
		                    //color: 'black'
		                },
		                //enableMouseTracking: true,
		                events:{
		                	click: function(e){
		                		//gotoDetail(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
	                		} 
		                }
		                	
		            }
		        }
		};
		return option;
	}
	
	function getOptionBlock(){
		var datas1 = $.extend(true,[],dataListBlock);
		var series = getDrillDownDataSeries2(
				'',
				datas1 ,
				['DT','ROW_NUM'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'NET_CHANGED_LINE' , convert:'y',isnull:0},{col:'DT', convert:'x', datatype:'date'}], //convert
				'DT' ,  //category
				'', // target
				{cd:'ROW_NUM', name:'ROW_NUM'},
				{isGroupby: false}
		);
		
		var datepositions = [];
		if(series.series.length > 0 ){
			$.each(series.category,function(i,d){
				var utcData = convertDateToUct(d);			
				datepositions.push(utcData);
			});		
		}
		
		var option = {
				
		        chart: {
		            type: 'column',
		            //zoomType:'x',
		            //height: 700
		            //,animation: false
		            //,width: 600
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
		        legend:{
		        	enabled: false
		        },
		        rangeSelector:{
		        	allButtonsEnabled: true
		        	,selected: 0
		        },
		        yAxis: {
		        	min: 0	
		        },
		        xAxis: {
		        	type: 'datetime'
		        	//, tickInterval: 24 * 3600 * 1000 * 7
		        	,dateTimeLabelFormats: { // don't display the dummy year
		        		week: '%y/%m/%e',
		        		day: '%m/%e',
		        		//month: '%y/%m/%e',
		        		month: '%y/%m',
		        		//year: '%y/%m/%e'
		        		year: '%y'
		            }
		            //,range: 1 * 30 * 24 * 3600 * 1000 // 3 months
		            ,tickPositions: datepositions
		            //,tickPositions: [Date.UTC(1970, 9, 27), Date.UTC(1970, 10, 1), Date.UTC(1970, 10, 12), Date.UTC(1970, 10, 27), Date.UTC(1970, 12, 27)]
		            //,startOnTick : true
		            //,tickmarkPlacement: 'on'
					,labels: {
						rotation : 310						
				        ,formatter: function () {
				        	return Highcharts.dateFormat('%y/%m/%e',this.value);
				            //some cleanup may be required, but this is the general form of the solution
// 				            if (this.value in datepositions) {
// 				                return this.value;
// 				            }
				        }
				    }
		            
		            
		        },
		        tooltip: {
		            valueDecimals: 0,
		          	//headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
	                //headerFormat:'',
		            pointFormat: '<span style="color:"#303030">{point.ROW_NUM}. {point.FILENM}</span>: <b>{point.y:##,###.0f}</b> <br/>',
		            shared: true,
		            enabled: true
		        },
		        //legend: legend,
		        plotOptions: {
		        	column: {
		            	grouping: true,
		            	borderWidth: 0,
		            	//cursor: 'pointer' ,
		            	//stacking:'normal',
		                dataLabels: {
		                    enabled: true
		                    //allowOverlap: true,
		                    //format:'{point.y:.0f} ({point.percentage:.0f}%)'
		                    //format:'{point.y:.0f}',
		                    //x: 10,
		                   /*  formatter:function(){
		                    	
		                    }, */
		                    //color: 'black'
		                },
		                //enableMouseTracking: true,
		                events:{
		                	click: function(e){
		                		//gotoDetail(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
	                		} 
		                }
		                	
		            }
		        }
		};
		return option;
	}
	
	
	
	function getOptionActivity(){
		
		//01.
		var datas1 = $.extend(true,[],dataListActivity);
		var datas2 = [];
		$.each(datas1,function(i,d){
			datas2.push({GUBUN:'LINE_ADD', DT: d.DT, COUNT: d.LINE_ADD});
			datas2.push({GUBUN:'LINE_DELETE', DT: d.DT, COUNT: d.LINE_DELETE});
			datas2.push({GUBUN:'CHANGED', DT: d.DT, COUNT: d.CHANGED});
		});
		
		var series = getDrillDownDataSeries2(
				'',
				datas2 ,
				['GUBUN','DT'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'COUNT' , convert:'y',isnull:0},{col:'DT', convert:'x', datatype:'date'}], //convert
				'DT' ,  //category
				'', // target
				{cd:'GUBUN', name:'GUBUN'},
				{isGroupby: false}
		);
		
		var datepositions = [];
		if(series.series.length > 0 ){
			$.each(series.category,function(i,d){
				var utcData = convertDateToUct(d);			
				datepositions.push(utcData);
			});		
		}
		
		
		
		var option = {
				
		        chart: {
		            type: 'line'
		            //,zoomType:'x'
		            //,height: 700
		            //,animation: false
		            //,width: 600
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
		        legend:{
		        	enabled: true
		        },
		        rangeSelector:{
		        	allButtonsEnabled: true
		        	,selected: 0
		        },
		        yAxis: [{
		        	min: 0,
		            title: {
		                text: 'Lines'
		            }
		            //,tickInterval:5
		        },{
		        	min: 0,
		            title: {
		                text: 'File Count'
		            },
		            opposite: false
		        }],
		        xAxis: {
		        	type: 'datetime'
		        	//, tickInterval: 24 * 3600 * 1000 * 7
		        	,dateTimeLabelFormats: { // don't display the dummy year
		        		week: '%y/%m/%e',
		        		day: '%m/%e',
		        		//month: '%y/%m/%e',
		        		month: '%y/%m',
		        		//year: '%y/%m/%e'
		        		year: '%y'
		            }
		            //,range: 1 * 30 * 24 * 3600 * 1000 // 3 months
		            ,tickPositions: datepositions
		            //,tickPositions: [Date.UTC(1970, 9, 27), Date.UTC(1970, 10, 1), Date.UTC(1970, 10, 12), Date.UTC(1970, 10, 27), Date.UTC(1970, 12, 27)]
		            //,startOnTick : true
		            //,tickmarkPlacement: 'on'
					,labels: {
						rotation : 310						
				        ,formatter: function () {
				        	return Highcharts.dateFormat('%y/%m/%e',this.value);
				            //some cleanup may be required, but this is the general form of the solution
// 				            if (this.value in datepositions) {
// 				                return this.value;
// 				            }
				        }
				    }
		            
		            
		        },
		        tooltip: {
		            valueDecimals: 0,
		          	//headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
	                //headerFormat:'',
		            //pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y:.0f}</b> <br/>',
		            shared: true,
		            enabled: true
		        },
		        //legend: legend,
		        plotOptions: {
		        	line: {
		            	//grouping: true,
		            	borderWidth: 0,
		            	//cursor: 'pointer' ,
		            	//stacking:'normal',
		                dataLabels: {
		                    enabled: true,
		                    //allowOverlap: true,
		                    //format:'{point.y:.0f} ({point.percentage:.0f}%)'
		                    format:'{point.y:.0f}',
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
		        }
		};
		return option;
	}
	
	
	function fnChgSystem(tab,container){
		
		$(".tab_2depth li").removeClass('on');
		$(".tab_2depth li").addClass('off');
		$("#"+tab).removeClass('off');
		$("#"+tab).addClass('on');
		$("#contents [id$=Container]").hide();
		$("#"+container+"Container").show();
		
		adjustSize();			
	}
	
	
	function popHmsDetail(project,category,component,field){
		var url = '/dashboard/jiraIssueHMSDetail.do';
		var newWin1 = window.open("", "HMSDetail", "width=1200,height=750, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		
		//var formData = new FormData($("#form")[0]);
		$("#dummy").html("");
		//var formData = $("#form").clone();
		
		var formData  = $(document.createElement("form"));
		
		formData.attr("name",'formdummy');
		formData.attr("id",'formdummy');
		
		$.each($("#form").find("input"),function(){
			/* var copyEl = $(document.createElement("input"));
			copyEl.attr('name',$(this).attrr("name"));
			copyEl.val($(this).val());
			formData.append(copyEl); */
			var copyEl = $(this).clone();		
			copyEl.val($(this).val());
			formData.append(copyEl);
		});
		
		$.each($("#form").find("select"),function(){
			var copyEl = $(this).clone();	
			copyEl.val($(this).val());
			formData.append(copyEl);
		});
			
		
		//project
		$(formData).find("[name=pjtCode]").remove();
		$(formData).find("[name=project]").remove();
		var inputProject = $(document.createElement("input"));
		inputProject.attr('name','project');
		inputProject.val(project);
		formData.append(inputProject);
		
		//group
		var inputComponentGroup = $(document.createElement("input"));
		inputComponentGroup.attr('name','componentGroup');
		inputComponentGroup.val(category);
		formData.append(inputComponentGroup);
		
		
		
		//component
		$(formData).find("[name=components]").remove();
			
		if(component != null){
			var inputComponent = $(document.createElement("input"));
			inputComponent.attr('name','components');
			inputComponent.val(component);
			formData.append(inputComponent);
			
		}else{
			var components = dataFilter(dataListForGrid,[{col:'category',val:category}]);
			$.each(components,function(){
				var inputComponent = $(document.createElement("input"));
				inputComponent.attr('name','components');
				inputComponent.val(this.component);
				formData.append(inputComponent);
			});
		}
		
		//field
		var inputField = $(document.createElement("input"));
		inputField.attr('name','field');
		inputField.val(field);
		formData.append(inputField);
		
		$("#dummy").append(formData);
		
		var oFrm = document.getElementById("formdummy");		
		oFrm.action =  url;
		oFrm.method = "post";
		oFrm.target = 'HMSDetail'; 
	    oFrm.submit();		 
	    newWin1.focus();
		
	}
	
	
	function adjustSize(){
		
		var target = $("#tabContainer li.on").attr("target");
		var chart = $("#" + target + "Container").highcharts();
		
		var a = window.innerHeight;
		var b = $("#searchCondition").height();
		var c = $(".tit_btn").height();
		
		var range = chart.rangeSelector.selected;		
		chart.update({chart:{width: $("#userContainer").width(),height: a-b-c-20}, rangeSelector:{selected: range+1}},true);
		chart.update({chart:{width: $("#userContainer").width(),height: a-b-c-20}, rangeSelector:{selected: range}},true);
		
		/* chartUser= $("#userContainer").highcharts();
		chartBlock= $("#blockContainer").highcharts();
		chartActivity= $("#activityContainer").highcharts();
		
		var a = window.innerHeight;
		var b = $("#searchCondition").height();
		var c = $(".tit_btn").height();
		
		
		
		chartUser.update({chart:{width: $("#userContainer").width(),height: a-b-c-20}},true);
		if(chartBlock != undefined)
			chartBlock.update({chart:{width: $("#blockContainer").width(), height: a-b-c-20}},true);
		if(chartActivity != undefined)
			chartActivity.update({chart:{width: $("#activityContainer").width(), height: a-b-c-20}},true); */
	}
	
	</script>
	<style type="text/css">
	
		html, body,form {
	        /* height: 100%; */
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        /* overflow-y: hidden;  */
	        /* overflow-x: hidden; */
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
		  top: 30%;
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
		
		
		.ui-jqgrid .ui-jqgrid-labels th.ui-th-column-header {
    	    background-color: #e5e5e5;
    	    background-image: none
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
		.ui-jqgrid .ui-jqgrid-btable tbody tr.jqgroup td { 
			padding-right: 7px;			
		}	
		.ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td { 
			padding-right: 7px;			
		}	
		.ui-jqgrid .ui-jqgrid-btable tbody tr.jqgrow td:hover{ 
			padding-right: 7px;			
			font-weight:bolder;
		}	
		
		th.ui-th-column div{
	        white-space:normal !important;
	        height:auto !important;
	        padding:2px;
	    }
	    input[type="text"], input[type="password"]{
	    	height: 34px;
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
			padding: 3px;
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
		
		
		.ui-jqgrid .ui-jqgrid-bdiv {
			overflow: auto;
		}
	    
	</style>
</head>
<body style="min-width:950px ">
<form name="form" id="form" class="">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/><%-- 검색조건 유지용 --%>
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjtId}"/>
<input type="hidden" id="PJT_CODE" name="PJT_CODE" value=""/><%-- 검색조건 유지용. project or pjtCode --%>
<input type="hidden" id="pjt_name" name="pjt_name" value=""/>

<input type="hidden" name="solution" value="pms"/><%-- 검색조건 유지용 --%>
<input type="hidden" name="url" value="perforceHMS.html"/><%-- 검색조건 유지용 --%>

<div id="searchCondition"></div>
<div id="tabContainer" class="tit_btn m_top_10" >
	<ul class="tab_2depth">
       	<li class="on" id="tabUser" target="user">
       		<a href="javascript:fnChgSystem('tabUser','user');" onclick="">User</a>
       	</li>
       	<li class="off" id="tabBlock" target="block">
       		<a href="javascript:fnChgSystem('tabBlock','block');" onclick="">Block</a>
       	</li>
       	<li class="off" id="tabActivity" target="activity">
       		<a href="javascript:fnChgSystem('tabActivity','activity');" onclick="">Activity</a>
       	</li>
	</ul>
</div>
<div id="contents" style="margin-top: 10px;width: 100%"></div>
<div id="loader"></div>

</form>
<div id="dummy" style="display: none;"></div>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
