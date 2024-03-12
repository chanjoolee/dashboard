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
	<script src="js/dashboard.js?version=2017.10.01"></script>
	
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
	var dataSmart = {dataList:[]};
	var dataHostinfo = {dataList:[]};
	var dataPecount = {dataList:[],grid:{dataList:[],searchoptions:{firmware:{value:""},foldername:{value:""}}}};
	var dataErrorlog = {dataList:[]};
	var dataMain = {dataList:[]};
	
	var gridSearchOption = {
		firmware:{value:":[ALL]"},
		foldername:{value:":[ALL]"},
		testname:{value:":[ALL]"},
		slotname:{value:":[ALL]"},
	};
	
	var isDataSmart = true;
	var isDataHostinfo = true;
	var isDataHostInfoCnt1 = true;
	var isDataHostInfoCnt2 = true;
	var isDataHostInfoSize1 = true;
	var isDataHostInfoSize2 = true;
	var isDataHostInfoMaxAvg1 = true;
	var isDataHostInfoMaxAvg2 = true;
	var isDataHostInfoMinAvg1 = true;
	var isDataHostInfoMinAvg2 = true;
	var isDataHostInfoMaxTot1 = true;
	var isDataHostInfoMaxTot2 = true;
	var isDataHostInfoMinTot1 = true;
	var isDataHostInfoMinTot2 = true;
	
	
	
	var isDataPecount = true;
	var isDataErrorlog = true;
	var isDataMain = true;
	/**
	* filter 및 group by 가 없는 경우를 가정함.
	*
	**/
	function makeDataForChart(param){
		//rturns		
		var rtn_series = [];
		var rtn_keys = [];
		var rtn_category = {x:[],x1:[],xindex:{},y:[],y1:[],yindex:{}};
		var rtn = {
				series : rtn_series,
				keys: rtn_keys,
				category : rtn_category
		};
		
		// parameters
		var p_dataSrc = param.dataSrc;
		var p_sorts = param.sorts;
		var p_seriesKey = param.seriesKey;
		var p_seriesIndex = param.seriesIndex;
		//var p_filters = param.filters;
		var p_convertDefiines = param.convertDefiines;
		var p_xCategoryCol = param.xCategoryCol;
		var p_xCategoryColOrderbyStr = param.xCategoryColOrderbyStr;
		var p_xCategoryAddIfEmpty = param.xCategoryAddIfEmpty;
		var p_xCategoryIndex = param.xCategoryIndex;
		var p_xCategoryFn = param.xCategoryFn; // function을 쓰는 것은 추전하지 않음.
		var p_xCategoryIndicate = param.xCategoryIndicate; // xCategory 의 index를 지정할 것인지. bubble chart의 경우.
		var p_yCategoryCol = param.yCategoryCol;
		var p_yCategoryFn = param.yCategoryFn;
		var p_yCategoryIndicate = param.yCategoryIndicate;
		//var p_xCategoryIndicateIndex = param.xCategoryIndicateIndex; // xCategoryIndicate 가 true인경우.  x축 에서 x축을 지정하는 경우 필요한 index.
		var p_isGroupby = param.isGroupby; // group by를 안하는 것으로 가정한다. 
		
		
		// alasql table
		var v_tablename = param.tablename;
		
		//01. convertdata
		//02. xCategory
		//03. yCategory
		//04. makeSeries
		
		
		
		//02. xCategory
		if(p_xCategoryCol != undefined && p_xCategoryCol != ''){
			if(p_xCategoryColOrderbyStr != undefined && p_xCategoryColOrderbyStr != '')
				rtn_category.x = alasql('select distinct '+ p_xCategoryCol +' from  ' + v_tablename + ' order by ' + p_xCategoryColOrderbyStr) ;
			else
				rtn_category.x = alasql('select distinct '+ p_xCategoryCol +' from  ' + v_tablename + ' order by ' + p_xCategoryCol) ;
			
			rtn_category.x = _.map(rtn_category.x,function(m,i){
				var rtn ={idx:i};
				rtn_category.xindex[m[p_xCategoryCol]] = rtn;
				if(p_xCategoryFn != undefined){
					return p_xCategoryFn.call(m,rtn);
				}else{
					rtn[p_xCategoryCol] = m[p_xCategoryCol];
					return rtn;
				}
    				
    		});
			rtn_category.x1 = _.pluck(rtn_category.x,p_xCategoryCol);
			
			
			var v_sql = 'select ';
			v_sql += p_seriesKey.cd + ', ' + p_seriesKey.name;
			v_sql += ' from ' + v_tablename;
			v_sql += ' group by ' + p_seriesKey.cd + ', ' + p_seriesKey.name
			var v_group = alasql(v_sql);
			if(p_xCategoryAddIfEmpty != undefined && p_xCategoryAddIfEmpty){
				$.each(rtn_category.x,function(i,category){
					$.each(v_group,function(j , s){
						var v_data = [];
						if(p_xCategoryIndex != undefined){
							var index = category[p_xCategoryCol] + '`'+s[p_seriesKey.cd];
							var indexDef = alasql.tables[v_tablename].inddefs[p_xCategoryIndex];
							var indexTarget = alasql.tables[v_tablename].indices[indexDef.hh];
							v_data = indexTarget[index];			
							if(v_data == undefined)
								v_data = [];
						}else{
							v_sql = 'select * from ' + v_tablename ;
							v_sql += ' where ';
							v_sql += p_xCategoryCol + ' = "'+category[p_xCategoryCol]+'"';
							v_sql += ' and ' + p_seriesKey.cd + ' = "'+s[p_seriesKey.cd]+'"';
							v_data = alasql(v_sql);
						}
						
						if(v_data.length == 0 || v_data == undefined){
							var nilObj = {};
							$.each(alasql.tables[v_tablename].columns,function(j,col){
								nilObj[col.columnid] = null;
							});
							nilObj[p_seriesKey.cd] = s[p_seriesKey.cd];
							nilObj[p_seriesKey.name] = s[p_seriesKey.name];
							nilObj[p_xCategoryCol] = category[p_xCategoryCol];
							//nilObj['x'] = category['idx'];
							
							$.each(p_convertDefiines,function(index,col){
								if((nilObj[col.col]==null || nilObj[col.col] == undefined || isNaN(nilObj[col.col]) ) && col.hasOwnProperty('isnull'))
									nilObj[col.col] = col.isnull ;
							});

							v_sql = 'INSERT INTO '+ v_tablename +' VALUES (';
							var vcolumns = [];
							$.each(alasql.tables[v_tablename].columns,function(j,col){
								if(nilObj[col.columnid] ==  null){
									vcolumns.push('null');
								}
								else if(col.dbtypeid == 'STRING')
									vcolumns.push('"'+nilObj[col.columnid]+'"');
								else
									vcolumns.push(nilObj[col.columnid]);
							});
							v_sql += vcolumns.join(",");
							v_sql += ')';
							//alasql(v_sql);
							//alasql('INSERT INTO ' + v_tablename + ' SELECT * FROM ?',[nilObj]);
							p_dataSrc.push(nilObj);
						}
						
					});
				});
			}
			
			
		}
		
		//03. yCategory
		if(p_yCategoryCol != undefined && p_yCategoryCol != ''){
			rtn_category.y = alasql('select distinct '+ p_yCategoryCol +' from  ' + v_tablename + ' order by ' + p_yCategoryCol) ;
			
			rtn_category.y = _.map(rtn_category.y,function(m,i){
				var rtn ={idx:i};
				rtn_category.yindex[m[p_yCategoryCol]]=rtn;
				if(p_yCategoryFn != undefined){
					return p_yCategoryFn.call(m,rtn);
				}else{
					rtn[p_yCategoryCol] = m[p_yCategoryCol];
					return rtn;
				}
    				
    		});
			rtn_category.y1 = _.pluck(rtn_category.y,p_yCategoryCol);
		}
		
		//04. makeSeries
		alasql(p_seriesIndex.sql);
		var indexDef = alasql.tables[v_tablename].inddefs[p_seriesIndex.index];
		var indexTarget = alasql.tables[v_tablename].indices[indexDef.hh];
		$.each(indexTarget,function(k,v){
			sortObjects(v,[p_xCategoryCol]);
			rtn_series.push({name:k,id:k,data:v});
			
			if(p_xCategoryIndicate){
				$.each(v,function(i,d){
					//if(d[p_xCategoryCol] == '00022_[test_Host]_ncq_random_long')
					//	var aaa = "";
					//var index1 = d[p_xCategoryCol] + '`'+s[p_seriesKey.cd];
					//var indexDef1 = alasql.tables[v_tablename].inddefs[p_xCategoryIndex];
					//var indexTarget1 = alasql.tables[v_tablename].indices[indexDef.hh];
// 					var  targetCategory = alasql('select idx from ? where '+ p_xCategoryCol +' = "' + d[p_xCategoryCol]  + '"', [rtn_category.x]);
// 					if(targetCategory.length > 0)
// 						d.x = targetCategory[0].idx;
					d.x = rtn_category.xindex[d[p_xCategoryCol]].idx;
					
				});
			}
			
			if(p_yCategoryIndicate){
				$.each(v,function(i,d){
					//var  targetCategory = alasql('select idx from ? where '+ p_yCategoryCol +' = "' + d[p_yCategoryCol]  + '"', [rtn_category.y]);
					//if(targetCategory.length > 0)
					//	d.y = targetCategory[0].idx;
					d.y = rtn_category.yindex[d[p_yCategoryCol]].idx;
				});
			}
			
		});
		
		
		//01. convertdata
		$.each(rtn_series,function(i,s){
			$.each(s.data,function(j,d){
				$.each(p_convertDefiines,function(index,col){
					if((d[col.col]==null || d[col.col] == undefined || isNaN(d[col.col]) ) && col.hasOwnProperty('isnull'))
						d[col.col] = col.isnull ;
					
					if(col.datatype == 'date'){
						d[col.convert] = convertDateToUct(d[col.col]);
						
					}else if(col.datatype == 'int'){
						d[col.convert] = d[col.col]*1;
					}else{
						d[col.convert] = d[col.col];
					}
					
				});			
			});
		});
		
		return rtn;
	}
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
								}
								//2line
								,{
									label:'',
									type: 'HorizontalLayout',
									containerCss:[
							    		{code:'height',value:'30px'}
							    	],
									elements:[
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
												name:'FIRMWARE'
											},
											multiselectOpt:{
												//selectedList: 1
												selectedText: function(numChecked, numTotal, checkedItems){
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
													$("select[name=firmware] option").each(function(i,sel){
														var obj = $("select[name=revision] option[FIRMWARE ='"+$(this).val()+"'] ");
														obj.prop( "disabled", !$(this).is(':checked') );
														obj.prop( "selected", $(this).is(':checked') );
													});	
													// check uncheck multiselect
													$("select[name=revision] option").each(function(i,project){		
														var obj = $("input[name=multiselect_revision][value='"+$(this).val()+"']");
														obj.prop( "disabled", $(this).prop("disabled") );
														if($(this).prop('disabled')){
															obj.parent().addClass( "ui-state-disabled" );
															obj.attr("checked",false);
															
														}else{
															obj.parent().removeClass( "ui-state-disabled" );
															obj.attr("checked",true);
														}
													});
													
													
													$("select[name=revision]").multiselect('refresh');
													$("div.ui-multiselect-menu").css("width","400px");
													$(".ui-multiselect-filter input").css("width","150px");
													// end change events
												}
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
												name:'FIRMWARE_REVISION'
											},
											multiselectOpt:{
												//selectedList: 1
												selectedText: function(numChecked, numTotal, checkedItems){
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
													// unselect
													var chartPoints = $("#testNameRangeContainer").highcharts();
													if(chartPoints != undefined)
														unselectByClick.call(chartPoints);
													
													getGridData();
												}
											}
										},
										{
											type:'Button',
											id: 'btnRangeSelector',
											name: 'btnRangeSelector',
											label:'Range Select',
											//width: '50px',
											cls: 'btn_txt btn_type_e btn_color_a',
											containerCss:[
												{code: 'margin-right', value:'3px'}
											],
											events:{
												click : function(){
													chartMake_range();
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
														
													isDataSmart = false;
													isDataHostinfo = false;
													
													isDataHostInfoCnt1 = false;
													isDataHostInfoCnt2 = false;
													isDataHostInfoSize1 = false;
													isDataHostInfoSize2 = false;
													isDataHostInfoMaxAvg1 = false;
													isDataHostInfoMaxAvg2 = false;
													isDataHostInfoMinAvg1 = false;
													isDataHostInfoMinAvg2 = false;
													isDataHostInfoMaxTot1 = false;
													isDataHostInfoMaxTot2 = false;
													isDataHostInfoMinTot1 = false;
													isDataHostInfoMinTot2 = false;
													
													isDataPecount = false;
													isDataErrorlog = false;													
													$.each($("[id^=content]"),function(i,div){
														if($(div).attr('id') != 'contentHostinfo')
															$(div).html("");
													});
													
													theGrid.jqGrid('setGridState','hidden');
													$("#testNameSelector").hide();
													//fnChgSystem('tabSmart','Smart');
													fnChgSystem('tabContainer','tabMain','Main');
													
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
	
	
	var schemaSmart1 = {
			containerId:'contentSmart',
			type:'Vertical',
			label:'',
			elements:[ 
				{
					containerCss:[
						//{code: 'display', value:''},
						//,{code: 'float', value:'left'},
						{code: 'height', value:'1000px'}
					],					
					type:'chart',
   	            	id: 'smartHeat',
   	            	label:'',
   	            	width: '100%',
   	            	//height:'800px',
   	            	data: function(){
   	            	// searchGrid에서 선택된 folder
	            		var theGrid = $("#searchGridTable");
	        			var selIds = theGrid.jqGrid('getGridParam','selarrrow');
	        			var row = theGrid.jqGrid('getRowData',selIds[0]);
	        			
	        			var paramObj = {
	            				folderNames :[],
	            				selectedPoints :[]
	            		};
	            		var param = "";
	            		$.each(selIds,function(i,s){
	            			var row = theGrid.jqGrid('getRowData',s);
	            			if(i > 0)
	            				param +="&";
	            			param += "folderName="+ row.FOLDER_NAME;
	            			paramObj.folderNames.push(row.FOLDER_NAME);
	            		});
	            		
	            		var chartPoints = $("#testNameRangeContainer").highcharts();
	            		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
	            		if(chartPoints != undefined){
	            			$.each( chartPoints.getSelectedPoints(),function(){
		            			paramObj.selectedPoints.push(this.options);
		            		});
	            		}
	            		
	            		var rtn = {series:[]};
	            		$.ajax({
	            			type: "POST",
	            			url: "/dashboard/regressionTabViewSmartJson.do",
	                		data: {searchJson: JSON.stringify(paramObj)}, 
	                		async: false,
	                		success:  function(response){
	                			dataSmart.dataList = response.dataList;
	                			rtn.dataList = response.dataList;
	                			
	                			if(alasql.tables.smart == undefined && response.dataList.length >0){
	                				var v_sql = 'create table smart(';
	                    			var i = 0;
	                    			$.each(response.dataList[0],function(k,v){
	                    				if(i > 0)
	                    					v_sql += ',';
	                    				v_sql += k + ' ' + typeof v;
	            						i += 1;
	                    			});
	                    			v_sql += ')';
	                    			alasql(v_sql);
	                			}else if(dataSmart.dataList.length == 0 ){
                                	return; 
	                			}
	            			     
	                			
	                			alasql.tables['smart'].data = dataSmart.dataList;	
	                			alasql('create index idx_TESTNAME_SLOTNAME on smart(TESTNAME,SLOTNAME)');
	                			alasql('create index idx_TESTNAME on smart(TESTNAME)');
	                		}
	                	});
	            		
	            		if(dataSmart.dataList.length == 0 ){
                        	return rtn; 
            			}
	            		
	            		var chart_param = {
	            				dataSrc: dataSmart.dataList ,
	            				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
	            				seriesIndex:{sql:'create index idx_SLOTNAME on smart(SLOTNAME)', index : 'idx_SLOTNAME'},
	            				//filters: [] ,
	            				convertDefiines: [{col: 'VAL' , convert:'value',isnull:0}] ,
	            				xCategoryCol : 'TESTNAME',
	            				xCategoryAddIfEmpty: false ,
	            				xCategoryIndex :'idx_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
	            				xCategoryIndicate: true,
	            				yCategoryCol : 'ID',
	            				yCategoryIndicate: true,
	            				isGroupby : false,
	            				tablename : 'smart'
	            		};
	            		var series = makeDataForChart(chart_param);
	            		$.each(series.series, function(){
	            			//this.connectNulls =  true;
	            			//this.minSize = "4";
	            			//this.maxSize = "50";
	            			this.turboThreshold = this.data.length;
	            			this.dataLabels = {
	            				enabled: false,
            					color: '#000000'
	            			};
	            			this.showInLegend = true;
	            			//this.colorAxis = false;
	            		});
	            		
	            		//////////// xcategory?
	            		var xAxis = {
           			    	gridLineWidth: 1,
           			        title: {
           			            text: 'test name'
           			        }
//            			        ,labels: {
//            			            format: '{value}'
//            			        }
							,labels:{
								formatter:	function(){
									//var aaa = "";
									//console.log(arguments);
									if (typeof this.value == "string")
										return this.value;
								}
							}
           			        //,type:'category'
           			    };
	            		
	            		xAxis.categories = _.map(series.category.x1,function(x,i){
	             			var rtn = "";
	         		 		var matches = x.match(/(^[0-9]+)_\[([\w]+)\]_(.+$)?/i);
		         				if(matches != null){
		         					rtn = matches[1]+ '_' + matches[3];
		         				}else{
		         					rtn = x;
		         				}
		         				return rtn;
		         		});
	         			xAxis.categoriesOrigine = series.category.x;
	            		
	         			rtn.xAxis = xAxis;
	         			dataErrorlog.xAxis = xAxis;	  
	            		//////////// ycategory?
	            		var yAxis =  {
           			        startOnTick: false,
           			        endOnTick: false,
           			        title: {
           			            text: 'attribute'
           			        }
           			        ,labels: {
           			            format: '{value}'
           			        }
           			    };
	            		
	            		yAxis.categories = series.category.y1;
            			yAxis.categoriesOrigine =  series.category.y;
            			
	            		rtn.yAxis = yAxis;
	            		dataSmart.yAxis = yAxis;
	            		// category end
	            		
	            		// return start
	            		rtn.series = series;
	            		dataSmart.series = series;
	            		
	            		return rtn;
   	            	},
   	            	options: function(){
   	            		var option = {
	            				stockchart: false
	            				,chart:{
	            					type: 'heatmap'
	            					, plotBorderWidth: 1
	            			        , zoomType: 'xy'
	            				}
	            			    ,legend: {
							        align: 'right',
							        layout: 'vertical',
							        margin: 0,
							        verticalAlign: 'top',
							        y: 25,
							        symbolHeight: 750
							    }
	            				, title: {
	            			        text: ' '
	            			    },
	            			    colorAxis: {
							        min: 0,
							        minColor: '#FFFFFF',
							        maxColor: Highcharts.getOptions().colors[0]
							    },
							    plotOptions: {
							    	heatmap:{
							      		borderColor: Highcharts.getOptions().colors[0],
							      		borderWidth: 0.5
							      }
							    },
	            			    tooltip: {
	            			        useHTML: true,
	            			        headerFormat: '<table>',
	            			        pointFormat: '<tr><th>Slot Name:</th><td>{series.name}</td</tr>' +
	            			        	'<tr><th>Folder Name:</th><td>{point.FOLDER_NAME}</td></tr>' +
	            			            '<tr><th>Test Name:</th><td>{point.TESTNAME}</td></tr>' +
	            			            '<tr><th>Start Time:</th><td>{point.START_TIME_STR}</td></tr>' +
	            			            '<tr><th>Attribute:</th><td>{point.ID}. {point.NAME}</td></tr>' +
	            			            '<tr><th>Value:</th><td>{point.value}</td></tr>',
	            			        footerFormat: '</table>',
	            			        followPointer: true
	            			    }
	            				
	            		};
	            		
	            		return option;
	            	}
   	            	
   	            }
   	            
   	            ,{
					containerCss:[
						{code: 'height', value:'1000px'}
					],					
					type:'chart',
   	            	id: 'smart_polar',
   	            	label:'',
   	            	width: '100%',
   	            	//height:'430px',
   	            	data: function(){
  	            			var rtn = {series:[]};
  	            			
  	            			if(dataSmart.dataList.length == 0 ){
  	            				return rtn;
  	            			}
  	            			var chart_param = {
  		            				dataSrc: dataSmart.dataList ,
  		            				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
  		            				seriesIndex:{sql:'create index idx_SLOTNAME on smart(SLOTNAME)', index : 'idx_SLOTNAME'},
  		            				//filters: [] ,
  		            				convertDefiines: [{col: 'VAL' , convert:'y',isnull:0}] ,
  		            				xCategoryCol : 'ID_TESTNAME',
  		            				xCategoryColOrderbyStr : 'Number(mysplit(ID_TESTNAME,"`")),TESTNAME',
  		            				xCategoryAddIfEmpty: false ,
  		            				//xCategoryIndex :'idx_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
  		            				xCategoryIndicate: true,
  		            				//yCategoryCol : 'ID',
  		            				yCategoryIndicate: false,
  		            				isGroupby : false,
  		            				tablename : 'smart'
  		            		};
  	            			var series = makeDataForChart(chart_param);
  	            			$.each(series.series, function(){
		            			this.turboThreshold = 2000;
		            		});
  		            		
  		            		//////////// xcategory?
  		            		var xAxis = {};
   		            		
  		            		xAxis.categories = _.map(series.category.x1,function(m,i){
		            			return m.split("`")[0];
		            		});
  		            		xAxis.categoriesOrigine = series.category.x;
  		            		
  		            		var xTickPositions = [];
  		            		var pre = '';
  		            		var cur = '';
  		            		var j = 0;
  		            		var plotBands = [];
  		            		var plotBand = {};
  		            		$.each(series.category.x, function(i,c){
		            			var gubun = c.ID_TESTNAME.split("`")[0];
		            			cur = gubun;
		            			if(i == 0){
		            				
		            				xTickPositions.push(c.idx);
		            			}else if (i > 0 && pre != cur){
		            				
		            				xTickPositions.push(c.idx);
		            				//xTickPositions.push(i+ Math.floor(j/2));
		            				plotBand.to = i;
		            				j = 0;
		            			} else if(i > 0 && i == (series.category.x.length -1) ){
		            				xTickPositions.push(c.idx);
		            			}
		            			
		            			
		            			if(j==0 ){
		            				plotBand = {};
		            				plotBand.borderColor = "#e6e6e6";
		            				plotBand.borderWidth = 1;
		            				plotBand.from = c.idx;
		            				plotBand.label = {
		            					text : gubun
		            				};
		            				plotBands.push(plotBand);
		            			}
		            			
		            				
		            			pre = gubun;
		            			j++;
		            		});
		            		xAxis.tickPositions = xTickPositions;
		            		//xAxis.tickPositions = [];
		            		//xAxis.plotBands = plotBands;
		            		
		            		rtn.xAxis = xAxis;
  		            		
  		            		// return start
  		            		rtn.series = series;
  		            		return rtn;
   	            	},
   	            	options: function(){
   	            		var option = {
   	            				chart:{
   	            					polar: true
   	            					, backgroundColor: 'transparent'
   	            					, type: 'scatter'
   	            			        , zoomType: 'xy'
   	            				}
   	            				, legend: {
   	            			        enabled: true
   	            			    }
   	            				, title: {
   	            			        text: ' '
   	            			    }
   	            			    ,tooltip: {
   	            			        useHTML: true,
   	            			        headerFormat: '<table>',
   	            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
		   	            			     '<tr><th>Folder Name:</th><td>{point.FOLDER_NAME}</td></tr>' +
		         			            '<tr><th>Test Name:</th><td>{point.TESTNAME}</td></tr>' +
		         			            '<tr><th>Start Time:</th><td>{point.START_TIME_STR}</td></tr>' +
		         			            '<tr><th>Attribute:</th><td>{point.ID}. {point.NAME}</td></tr>' +
		         			            '<tr><th>Value:</th><td>{point.y}</td></tr>',
   	            			        footerFormat: '</table>',
   	            			        followPointer: true
   	            			    }
   	            				
   	            		};
   	            		
   	            		return option;
   	            	}
   	            		
   	            }
				
				,{
					containerCss:[
						{code: 'height', value:'1000px'}
					],					
					type:'chart',
   	            	id: 'smartPolarRemoveScroll',
   	            	label:'',
   	            	width: '100%',
   	            	//height:'430px',
   	            	data: function(){
            			var rtn = {series:[]};
            			
            			if(dataSmart.dataList.length == 0 ){
            				return rtn;
            			}
	            		var chart_param = {
	        				dataSrc: dataSmart.dataList ,
	        				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
	        				seriesIndex:{sql:'create index idx_SLOTNAME on smart(SLOTNAME)', index : 'idx_SLOTNAME'},
	        				//filters: [] ,
	        				convertDefiines: [{col: 'VAL' , convert:'y',isnull:0}] ,
	        				xCategoryCol : 'ID_TESTNAME',
	        				xCategoryColOrderbyStr : 'Number(mysplit(ID_TESTNAME,"`")),TESTNAME',
	        				xCategoryAddIfEmpty: false ,
	        				//xCategoryIndex :'idx_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
	        				xCategoryIndicate: true,
	        				//yCategoryCol : 'ID',
	        				yCategoryIndicate: false,
	        				isGroupby : false,
	        				tablename : 'smart'
		            	};
            			var series = makeDataForChart(chart_param);
	            		
	            		
	            		$.each(series.series, function(){
	            			this.turboThreshold = 2000;
	            		});
	            		
	            		//////////// xcategory?
	            		var xAxis = {
	            			range: 100
	            		};
			            		
		            	xAxis.categories = _.map(series.category.x1,function(m,i){
	            			return m.split("`")[0] + ":" + m.split("`")[1];
	            		});
	            		
	            		xAxis.categoriesOrigine = series.category.x;
	            		xAxis.labels = {
	            			rotation: 290,
	            			formatter: function () {
		        				return xAxis.categories[this.value];
		        			}
	            		};
	            		
	            		
	            		rtn.xAxis = xAxis;
		            		
	            		// return start
	            		rtn.series = series;
	            		return rtn;
   	            	},
   	            	options: function(){
   	            		var option = {
   	            			stockchart: true
	        				,chart:{
	        					polar: false
	        					, type: 'scatter'
	        			        , zoomType: 'xy'
	        				}
	        				, legend: {
	        			        enabled: true
	        			    }
	        				, title: {
	        			        text: ' '
	        			    }
	        			    , rangeSelector: {
					        	enabled:false
					        }
					        , navigator: {
					        	xAxis:{
					        		labels:{
					        			enabled:false
					        		}
					        	}
					        }
	        			    ,tooltip: {
	        			        useHTML: true,
	        			        headerFormat: '<table>',
	        			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
		            			     '<tr><th>Folder Name:</th><td>{point.FOLDER_NAME}</td></tr>' +
	     			            '<tr><th>Test Name:</th><td>{point.TESTNAME}</td></tr>' +
	     			            '<tr><th>Start Time:</th><td>{point.START_TIME_STR}</td></tr>' +
	     			            '<tr><th>Attribute:</th><td>{point.ID}. {point.NAME}</td></tr>' +
	     			            '<tr><th>Value:</th><td>{point.y}</td></tr>',
	        			        footerFormat: '</table>',
	        			        followPointer: true
	        			    }
   	            				
   	            		};
   	            		
   	            		return option;
   	            	}
   	            		
   	            }
				
				,{
					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
						,{code: 'width', value:'99%'}
					],			
			    	type:'grid',
			    	id: 'grid_smart',
			    	label:'Smart List',
			    	data: function(){ 
			    		var datalist = [];
			    		var theGrid = $("#searchGridTable");
			    		var selIds = theGrid.jqGrid('getGridParam','selarrrow');
			    		var row = theGrid.jqGrid('getRowData',selIds[0]);
			    		
			    		var paramObj = {
	            				folderNames :[],
	            				selectedPoints :[]
	            		};
	            		var param = "";
	            		$.each(selIds,function(i,s){
	            			var row = theGrid.jqGrid('getRowData',s);
	            			if(i > 0)
	            				param +="&";
	            			param += "folderName="+ row.FOLDER_NAME;
	            			paramObj.folderNames.push(row.FOLDER_NAME);
	            		});
	            		
	            		var chartPoints = $("#testNameRangeContainer").highcharts();
	            		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
	            		if(chartPoints != undefined){
	            			$.each( chartPoints.getSelectedPoints(),function(){
		            			paramObj.selectedPoints.push(this.options);
		            		});
	            		}	            		
			    		param += '&sqlid=dashboard.regresson.smartlist.raw';
			    		$.ajax({
			    			type: "POST",
			    			url: "/dashboard/genericlListJson.do",
			    			data: {searchJson: JSON.stringify(paramObj), sqlid: 'dashboard.regresson.smartlist.raw'}, 
			    			async: false,
			    			success:  function(response){
			    				datalist  = response.dataList;
			    				
			    			}
			    		});
			    		return datalist;
			    	},
			    	items:[
						{label:'Folder Name',name:'FOLDER_NAME', id:'FOLDER_NAME',width: 150
							//,stype: "select"
							//, searchoptions: gridSearchOption.foldername
						},
						{label:'Pjt Code',name:'PJT_CODE', id:'PJT_CODE',width: 90},
						{label:'Pjt Name',name:'PJT_NAME_PMS', id:'PJT_NAME_PMS',width: 200},
						{label:'Firmware',name:'FIRMWARE', id:'FIRMWARE',width: 130
							//, stype: "select"
							//, searchoptions: gridSearchOption.firmware 
						},
						{label:'Revision',name:'REVISION', id:'REVISION',width: 70},
						{label:'Test Name',name:'TESTNAME', id:'TESTNAME',width: 270 
							//, stype: "select"
							//, searchoptions: gridSearchOption.testname 
						},
						{label:'Slot Name',name:'SLOTNAME', id:'SLOTNAME',width: 100
							//, stype: "select"
							//, searchoptions: gridSearchOption.slotname 
						},
						{label:'Attribute Id',name:'ID', id:'ID', sorttype:'number', width: 100 },
						{label:'Attribute Name',name:'NAME', id:'NAME',width: 150 },
						{label:'Value',name:'VAL', id:'VAL',width: 110 
							,sorttype: 'number', formatter:'number', align:'right',formatoptions:{decimalSeparator:",", thousandsSeparator: ",", decimalPlaces: 0}
							,searchoptions : {
	                            // show search options
	                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
							}		
						},
						{label:'Normalized',name:'NORMALIZED', id:'NORMALIZED',width: 90 
							,sorttype: 'number', formatter:'number', align:'right',formatoptions:{decimalSeparator:",", thousandsSeparator: ",", decimalPlaces: 0}
							,searchoptions : {
	                            // show search options
	                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
							}		
						}
						
			    	],
			    	gridOpt:{
			    		datatype:'local',
			    		pager: "#grid_smartPager",
			    		viewrecords: true,
			    		width: '100%',
			    		height: '100%',
			    		sortable: true,
			    		multiSort:true,
			    		sortname: 'FIRMWARE, TESTNAME, SLOTNAME,ID ',
			    		rowNum: 20,
						rowList:[10,20,30,50,100],
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
	
	
	var schemaHostinfo = {
			containerId:'contentHostinfo',
			type:'HorizontalLayout',
			label:'',
			elements:[ 
				{
					containerCss:[
						{code: 'display', value:''}
						,{code: 'float', value:'left'}
						,{code: 'height', value:'1000px'}
					],					
					type:'chart',
   	            	id: 'hostinfo11',
   	            	label:'',
   	            	width: '49%',
   	            	//height:'800px',
   	            	data: function(){
   	            	// searchGrid에서 선택된 folder
	            		var theGrid = $("#searchGridTable");
	        			var selIds = theGrid.jqGrid('getGridParam','selarrrow');
	        			var row = theGrid.jqGrid('getRowData',selIds[0]);
	        			
	            		var param = {
	            				
	            		};
	            		
	            		var rtn = {};
	            		$.ajax({
	                		url: "/dashboard/regressionTabViewHostJson.do",
	                		data: param, 
	                		async: false,
	                		success:  function(response){
	                			dataHostinfo.dataList = response.dataList;
	                			rtn.dataList = response.dataList;
	                		}
	                	});
	            		
	            		var series = getDrillDownDataSeries2(
	            				'',
	            				dataHostinfo.dataList ,
	            				['SLOTNAME'] , //groupby
	            				[], //filter
	            				[{col: 'COUNT' , convert:'z',isnull:0}], //convert
	            				'TESTNAME' ,  //category
	            				'CNT',
	            				{cd:'SLOTNAME', name:'SLOTNAME'},
	            				{isGroupby: false}
	            		);
	            		
	            		$.each(series.series, function(){
	            			this.connectNulls =  true;
	            			this.minSize = "4";
	            			this.maxSize = "50";
	            		});
	            		
	            		//////////// xcategory?
	            		var xAxis = {
           			    	gridLineWidth: 1,
           			        title: {
           			            text: 'test name'
           			        }
//            			        ,labels: {
//            			            format: '{value}'
//            			        }
							,labels:{
								formatter:	function(){
									//var aaa = "";
									//console.log(arguments);
									if (typeof this.value == "string")
										return this.value;
								}
							}
           			        //,type:'category'
           			    };
	            		
	            		var xCategories = alasql('select distinct mysplit(TESTNAME,"_") as testname , TESTNAME as testnamefull from ?  order by 1' , [dataHostinfo.dataList]);	  
	            		xCategories = _.map(xCategories,function(m,i){
	            			return {idx:i ,testname:m.testname, testnamefull: m.testnamefull};
	            		});
	            		
	            		var xCategories1 =  _.pluck(xCategories,'testname');
	            		xAxis.categories = xCategories1;
	            		xAxis.categoriesOrigine = xCategories;
	            		dataHostinfo.xAxis = xAxis;
	            		rtn.xAxis = xAxis;
	            		
	            			// 각 데이타에 xCategories 를 지정한다.
	            			$.each(series.series, function(i,s){
	            				$.each(s.data,function(j,d){
	            					var  targetCategory = alasql('select idx from ? where testnamefull = "' + d.TESTNAME  + '"', [xCategories]);
	            					if(targetCategory.length > 0)
	            						d.x = targetCategory[0].idx;
	            				});
	            			});
	            		
	            		//////////// ycategory?
	            		var yAxis =  {
           			        startOnTick: false,
           			        endOnTick: false,
           			        title: {
           			            text: 'command'
           			        }
           			        ,labels: {
           			            format: '{value}'
           			        }
           			    };   	            		
	            		var yCategories = alasql('select distinct COMMAND command from ?  order by 1' , [dataHostinfo.dataList]);	  
	            		yCategories = _.map(yCategories,function(m,i){
	            			return {idx:i , command: m.command };
	            		});
	            		
	            		var yCategories1 =  _.pluck(yCategories,'command');
	            		yAxis.categories = yCategories1;
	            		yAxis.categoriesOrigine = yCategories;
	            		rtn.yAxis = yAxis;
	            		dataHostinfo.yAxis = yAxis;
	            		
	            			// 각 데이타에 xCategories 를 지정한다.
	            			$.each(series.series, function(i,s){
	            				$.each(s.data,function(j,d){
	            					var  targetCategory = alasql('select idx from ? where command = "' + d.COMMAND  + '" ', [yCategories]);
	            					if(targetCategory.length > 0)
	            						d.y = targetCategory[0].idx;
	            				});
	            			});
	            		
	            			    	            		
	            		// category end
	            		
	            		// return start
	            		rtn.series = series;
	            		dataHostinfo.series = series;
	            		
	            		return rtn;
   	            	},
   	            	options: function(){
   	            		var option = {
	            				chart:{
	            					type: 'bubble'
	            					, plotBorderWidth: 1
	            			        , zoomType: 'xy'
	            				}
	            				, legend: {
	            			        enabled: true
	            			    }
	            				, title: {
	            			        text: ' '
	            			    },
	            			    tooltip: {
	            			        useHTML: true,
	            			        headerFormat: '<table>',
	            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
	            			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
	            			            '<tr><th>command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
	            			            '<tr><th>count:</th><td>{point.z}</td></tr>',
	            			        footerFormat: '</table>',
	            			        followPointer: true
	            			    }
	            				
	            		};
	            		
	            		return option;
	            	}
   	            	
   	            }
				,{
					type: 'Vertical',
					label: '',	
					width:'49%',
					elements:[
						{	
							
							containerCss:[
								{code: 'height', value:'1000px'}
							],					
							type:'chart',
	    	            	id: 'host2',
	    	            	label:'',
	    	            	width: '99%',
	    	            	//height:'430px',
	    	            	data: function(){
    	            			var rtn = {};
    		            		
    	            			//var dataList = groupbyCount(dataSmart.dataList,['SLOTNAME','TESTNAME']);
    		            		var series = getDrillDownDataSeries2(
    		            				'',
    		            				dataHostinfo.dataList ,
    		            				['SLOTNAME','COMMAND','TESTNAME'] , //groupby
    		            				[], //filter
    		            				[{col: 'COUNT' , convert:'y',isnull:0}], //convert
    		            				'COMMAND' ,  //category
    		            				'CNT',
    		            				{cd:'SLOTNAME', name:'SLOTNAME'},
    		            				{isGroupby: false}
    		            		);
	    		            		
    		            		//////////// xcategory?
    		            		var xAxis = {
    	           			    
    		            		};
	    		            		
    		            		var xCategories = alasql('select distinct COMMAND id , COMMAND name, TESTNAME testname from ?  order by 1 , 3' , [dataHostinfo.dataList]);
    		            		xCategories = _.map(xCategories,function(m,i){
    		            			return {
    		            				idx:i , 
    		            				attribute_id: m.id, 
    		            				attribute_name: m.name,
    		            				testname: m.testname
    		            				};
    		            			
    		            		});
    		            		
    		            		var xTickPositions = [];
    		            		var pre = '';
    		            		var cur = '';
    		            		$.each(xCategories, function(i,c){
    		            			cur = c.attribute_id;
    		            			if(i == 0)
    		            				xTickPositions.push(c.idx);
    		            			if(i > 0 && pre != cur)
    		            				xTickPositions.push(c.idx);
    		            			pre = c.attribute_id;
    		            		} );
    		            		xAxis.tickPositions = xTickPositions;
	    		            		
    		            		var xCategories1 = _.pluck(xCategories,'attribute_id');
    		            		xAxis.categories = xCategories1;
    		            		xAxis.categoriesOrigine = xCategories;
    		            		rtn.xAxis = xAxis;
    		            		
    		            			// 각 데이타에 xCategories 를 지정한다.
    		            			$.each(series.series, function(i,s){
    		            				$.each(s.data,function(j,d){
    		            					var  targetCategory = alasql('select idx from ? where attribute_id = "' + d.COMMAND  + '" and testname="'+ d.TESTNAME+'"	', [xCategories]);
    		            					if(targetCategory.length > 0)
    		            						d.x = targetCategory[0].idx;
    		            				});
    		            			});
    		            			
    		            		
    		            		// return start
    		            		rtn.series = series;
    		            		return rtn;
	    	            	},
	    	            	options: function(){
	    	            		var option = {
	    	            				chart:{
	    	            					polar: true
	    	            					, type: 'scatter'
	    	            			        , zoomType: 'xy'
	    	            				}
	    	            				, legend: {
	    	            			        enabled: true
	    	            			    }
	    	            				, title: {
	    	            			        text: ' '
	    	            			    }
	    	            			    ,tooltip: {
	    	            			        useHTML: true,
	    	            			        headerFormat: '<table>',
	    	            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
	    	            			            '<tr><th>command:</th><td>{point.COMMAND}</td></tr>'  +
	    	            			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
	    	            			            '<tr><th>count:</th><td>{point.y}</td></tr>' ,
	    	            			        footerFormat: '</table>',
	    	            			        followPointer: true
	    	            			    }
	    	            				
	    	            		};
	    	            		
	    	            		return option;
	    	            	}
	    	            		
	    	            }
						
					]
				}
			]								
	};
	
	
	var schemaHostinfo1 = {
			containerId:'contentHostinfo',
			type:'Vertical',
			label:' By Count',
			elements:[
				{
					type:'HorizontalLayout',
					label:'',
					elements:[ 
						{
							containerCss:[
								{code: 'display', value:''}
								//,{code: 'float', value:'left'}
								,{code: 'height', value:'1000px'}
							],					
							type:'chart',
		   	            	id: 'hostinfo1',
		   	            	label:'',
		   	            	width: '99%',
		   	            	//height:'800px',
		   	            	data: function(){
		   	            	// searchGrid에서 선택된 folder
			            		var theGrid = $("#searchGridTable");
			        			var selIds = theGrid.jqGrid('getGridParam','selarrrow');
			        			var row = theGrid.jqGrid('getRowData',selIds[0]);
			        			
			        			var param = "";
			            		$.each(selIds,function(i,s){
			            			var row = theGrid.jqGrid('getRowData',s);
			            			if(i > 0)
			            				param +="&";
			            			param += "folderName="+ row.FOLDER_NAME;
			            		});
			            		
			            		var rtn = {};
			            		$.ajax({
			                		url: "/dashboard/regressionTabViewHostJson.do",
			                		data: param, 
			                		async: false,
			                		success:  function(response){
			                			dataHostinfo.dataList = response.dataList;
			                			rtn.dataList = dataHostinfo.dataList;
			                			
			                			if(alasql.tables.hostinfo == undefined && response.dataList.length > 0 ){
			                				var v_sql = 'create table hostinfo(';
				                			var i = 0;
				                			$.each(response.dataList[0],function(k,v){
				                				if(i > 0)
				                					v_sql += ',';
				                				v_sql += k + ' ' + typeof v;
												i += 1;
				                			});
				                			v_sql += ')';
				                			alasql(v_sql);
			                			}
			                			alasql.tables['hostinfo'].data = dataHostinfo.dataList;			                			
			                			
			                			alasql('create index idx_TESTNAME_SLOTNAME on hostinfo(TESTNAME,SLOTNAME)');
			                			//alasql('create index idx_TESTNAME on hostinfo(TESTNAME)');
			                			alasql('create index idx_COMMAND_TESTNAME_SLOTNAME on hostinfo(COMMAND_TESTNAME,SLOTNAME)');
			                			//alasql('create index idx_COMMAND_TESTNAME on hostinfo(COMMAND_TESTNAME)');
			                		}
			                	});
			            		
			            		var param_x =  param + '&sqlid=dashboard.regresson.hostlist.x';
			            		var xCategory = {x:[],x1:[]};
			            		$.ajax({
									url: "/dashboard/genericlListJson.do",
									data: param_x, 
									async: false,
									success:  function(response){
										xCategory.x = response.dataList;
										xCategory.x1 = _.pluck(xCategory.x, 'TESTNAME');
										
									}
								});
			            		
			            		var param_y =  param + '&sqlid=dashboard.regresson.hostlist.y';
			            		var yCategory = {y:[],y1:[]};
			            		$.ajax({
									url: "/dashboard/genericlListJson.do",
									data: param_y, 
									async: false,
									success:  function(response){
										yCategory.y = response.dataList;
										yCategory.y1 = _.pluck(yCategory.y, 'COMMAND');
										
									}
								});
			            		
			            		var chart_param = {
    		            				dataSrc: dataHostinfo.dataList ,
    		            				sorts: ['SLOTNAME','TESTNAME'] ,
    		            				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
    		            				seriesIndex:{sql:'create index idx_SLOTNAME on hostinfo(SLOTNAME)', index : 'idx_SLOTNAME'},
    		            				//filters: [] ,
    		            				convertDefiines: [{col: 'CNT' , convert:'z',isnull:0}] ,
    		            				//xCategoryCol : 'TESTNAME',
    		            				//xCategoryAddIfEmpty: false ,
    		            				xCategoryIndex :'idx_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
    		            				xCategoryIndicate: false,
    		            				//xCategoryIndicateIndex :'idx_TESTNAME', //xCategoryIndicate 가 true인경우. x축 에서 x축을 지정하는 경우 필요한 index. 
										// xCategoryFn: function(rtn){
										// 	var matches = this.TESTNAME.match(/(^[0-9]+)_\[([\w]+)\]_(.+$)?/i);
										// 	if(matches != null){
										// 		rtn.TESTNAME = matches[1]+ '_' + matches[2];
										// 		rtn.TESTNAMEFULL = matches[0]
										// 	}else{
										// 		rtn.TESTNAME = this.TESTNAME;
										// 	}
										// 	return rtn;
										// },
    		            				//yCategoryCol : 'COMMAND',
    		            				yCategoryIndicate: false,
    		            				isGroupby : false,
    		            				tablename : 'hostinfo'
    		            		};
			            		
			            		var series = makeDataForChart(chart_param);
			            		
			            		$.each(series.series, function(){
			            			this.connectNulls =  true;
			            			this.minSize = "4";
			            			this.maxSize = "50";
			            		});
			            		
			            		////////// xcategory
			            		var xAxis = {
		           			    	gridLineWidth: 1,
		           			        title: {
		           			            text: 'test name'
		           			        }
// 		           			        ,labels: {
// 		           			            format: '{value}'
// 		           			        }
									,labels:{
										formatter:	function(){
											//var aaa = "";
											//console.log(arguments);
											if (typeof this.value == "string")
												return this.value;
										}
									}
		           			        //,type:'category'
		           			    };
			     
			            		
			            		//xAxis.categories = series.category.x1;
// 			            		xAxis.categories = _.map(series.category.x1,function(x,i){
// 			            			var rtn = "";
// 			            		 	var matches = x.match(/(^[0-9]+)_\[([\w]+)\]_(.+$)?/i);
// 									if(matches != null){
// 										rtn = matches[1]+ '_' + matches[3];
// 									}else{
// 										rtn = x;
// 									}
// 									return rtn;
// 			            		});
// 			            		xAxis.categoriesOrigine = series.category.x1;
			            		//xAxis.categories = xCategory.x1;
			            		xAxis.categories = _.map(xCategory.x1,function(x,i){
			            			var rtn = "";
			            		 	var matches = x.match(/(^[0-9]+)_\[([\w]+)\]_(.+$)?/i);
									if(matches != null){
										rtn = matches[1]+ '_' + matches[3];
									}else{
										rtn = x;
									}
									return rtn;
			            		});
			            		xAxis.categoriesOrigine = xCategory.x;
			            		dataHostinfo.xAxis = xAxis;
			            		rtn.xAxis = xAxis;
			            		
			            		//////////// ycategory
			            		var yAxis =  {
		           			        startOnTick: false,
		           			        endOnTick: false,
		           			        title: {
		           			            text: 'command'
		           			        }
		           			        ,labels: {
		           			            format: '{value}'
		           			        }
		           			    };   	            		
			            		
			            		//yAxis.categories = series.category.y1;
			            		//yAxis.categoriesOrigine = series.category.y;
			            		yAxis.categories = yCategory.y1;
			            		yAxis.categoriesOrigine =  yCategory.y;
			            		rtn.yAxis = yAxis;
			            		dataHostinfo.yAxis = yAxis;
			            		// category end
			            		
			            		// return start
			            		rtn.series = series;
			            		dataHostinfo.series = series;
			            		dataHostinfo.rtn = {};
			            		dataHostinfo.rtn.left = $.extend(true,{},rtn);			            		 
			            		return rtn;
		   	            	},
		   	            	options: function(){
		   	            		var option = {
			            				chart:{
			            					type: 'bubble'
			            					, plotBorderWidth: 1
			            			        , zoomType: 'xy'
			            				}
			            				, legend: {
			            			        enabled: true
			            			    }
			            				, title: {
			            			        text: ' '
			            			    },
			            			    tooltip: {
			            			        useHTML: true,
			            			        headerFormat: '<table>',
			            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
			            			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
			            			            '<tr><th>command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
			            			            '<tr><th>count:</th><td>{point.z}</td></tr>',
			            			        footerFormat: '</table>',
			            			        followPointer: true
			            			    }
			            				
			            		};
			            		
			            		return option;
			            	}
		   	            	
		   	            }
						,{
							
							containerCss:[
								{code: 'height', value:'1000px'}
							],					
							type:'chart',
	    	            	id: 'hostinfo12',
	    	            	label:'',
	    	            	width: '99%',
	    	            	//height:'430px',
	    	            	data: function(){
    	            			var rtn = {};
    	            			
    	            			var chart_param = {
    		            				dataSrc: dataHostinfo.dataList ,
    		            				//sorts: ['SLOTNAME','TESTNAME'] ,
    		            				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
    		            				seriesIndex:{sql:'create index idx_SLOTNAME on hostinfo(SLOTNAME)', index : 'idx_SLOTNAME'},
    		            				//filters: [] ,
    		            				convertDefiines: [{col: 'CNT' , convert:'y',isnull:0}] ,
    		            				xCategoryCol : 'COMMAND_TESTNAME',
    		            				xCategoryAddIfEmpty: false ,
    		            				xCategoryIndex :'idx_COMMAND_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
    		            				xCategoryIndicate: true,
    		            				//xCategoryIndicateIndex :'idx_COMMAND_TESTNAME', // xCategoryIndicate 가 true인경우.  x축 에서 x축을 지정하는 경우 필요한 index.
    		            				//yCategoryCol : 'COMMAND',
    		            				yCategoryIndicate: false,
    		            				isGroupby : false,
    		            				tablename : 'hostinfo'
    		            		};
    	            			
    	            			var series = makeDataForChart(chart_param);
    		            		
    		            		//////////// xcategory
    		            		var xAxis = {};
    		            		//xAxis.categories = series.category.x1;
    		            		xAxis.categories = _.map(series.category.x1,function(m,i){
    		            			return m.split("`")[0];
    		            		});
			            		xAxis.categoriesOrigine = series.category.x;
    		            		
    		            		var xTickPositions = [];
    		            		var pre = '';
    		            		var cur = '';
    		            		$.each(series.category.x, function(i,c){
    		            			var command = c.COMMAND_TESTNAME.split("`")[0];
    		            			cur = command;
    		            			if(i == 0)
    		            				xTickPositions.push(c.idx);
    		            			if(i > 0 && pre != cur)
    		            				xTickPositions.push(c.idx);
    		            			pre = command;
    		            		} );
    		            		xAxis.tickPositions = xTickPositions;
    		            		rtn.xAxis = xAxis;	
    		            		
    		            		// return start
    		            		rtn.series = series;
    		            		dataHostinfo.rtn.right = $.extend(true,{},rtn);
    		            		return rtn;
	    	            	},
	    	            	options: function(){
	    	            		var option = {
	    	            				chart:{
	    	            					polar: true
	    	            					, type: 'scatter'
	    	            			        , zoomType: 'xy'
	    	            				}
	    	            				, legend: {
	    	            			        enabled: true
	    	            			    }
	    	            				, title: {
	    	            			        text: ' '
	    	            			    }
	    	            			    ,tooltip: {
	    	            			        useHTML: true,
	    	            			        headerFormat: '<table>',
	    	            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
	    	            			            '<tr><th>command:</th><td>{point.COMMAND}</td></tr>'  +
	    	            			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
	    	            			            '<tr><th>count:</th><td>{point.y}</td></tr>' ,
	    	            			        footerFormat: '</table>',
	    	            			        followPointer: true
	    	            			    }
	    	            				
	    	            		};
	    	            		
	    	            		return option;
	    	            	}
							
						}
					]
				}// end of line 1
				,{
					type:'HorizontalLayout',
					label:' By Data Size',
					elements:[ 
						{
							containerCss:[
								{code: 'display', value:''}
								//,{code: 'float', value:'left'}
								,{code: 'height', value:'1000px'}
							],					
							type:'chart',
		   	            	id: 'hostinfo21',
		   	            	label:'',
		   	            	width: '99%',
		   	            	//height:'800px',
		   	            	data: function(){
			            		var rtn = $.extend(true,{},dataHostinfo.rtn.left);
			            		$.each(rtn.series.series,function(i,s){
			            			$.each(s.data,function(j,d){
			            				d['z'] = d['SIZE'];
			            			});
			            		});
			            		
			            		return rtn;
		   	            	},
		   	            	options: function(){
		   	            		var option = {
			            				chart:{
			            					type: 'bubble'
			            					, plotBorderWidth: 1
			            			        , zoomType: 'xy'
			            				}
			            				, legend: {
			            			        enabled: true
			            			    }
			            				, title: {
			            			        text: ' '
			            			    },
			            			    tooltip: {
			            			        useHTML: true,
			            			        headerFormat: '<table>',
			            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
			            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
			            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
			            			            '<tr><th>Size:</th><td>{point.z}</td></tr>',
			            			        footerFormat: '</table>',
			            			        followPointer: true
			            			    }
			            				
			            		};
			            		
			            		return option;
			            	}
		   	            	
		   	            }
						,{
							
							containerCss:[
								{code: 'height', value:'1000px'}
							],					
							type:'chart',
	    	            	id: 'hostinfo22',
	    	            	label:'',
	    	            	width: '99%',
	    	            	//height:'430px',
	    	            	data: function(){
    	            			var rtn = {};
    	            			
    	            			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
			            		$.each(rtn.series.series,function(i,s){
			            			$.each(s.data,function(j,d){
			            				d['y'] = d['SIZE'];
			            			});
			            		});
    		            		
    	            			
    		            		return rtn;
	    	            	},
	    	            	options: function(){
	    	            		var option = {
	    	            				chart:{
	    	            					polar: true
	    	            					, type: 'scatter'
	    	            			        , zoomType: 'xy'
	    	            				}
	    	            				, legend: {
	    	            			        enabled: true
	    	            			    }
	    	            				, title: {
	    	            			        text: ' '
	    	            			    }
	    	            			    ,tooltip: {
	    	            			        useHTML: true,
	    	            			        headerFormat: '<table>',
	    	            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	    	            			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	    	            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	    	            			            '<tr><th>Size:</th><td>{point.y}</td></tr>' ,
	    	            			        footerFormat: '</table>',
	    	            			        followPointer: true
	    	            			    }
	    	            				
	    	            		};
	    	            		
	    	            		return option;
	    	            	}
							
						}
					]
				}// end of line 2
				/*,{
					type:'HorizontalLayout',
					label:' By Latency(max)_avg',
					elements:[ 
						{
							containerCss:[
								{code: 'display', value:''}
								,{code: 'float', value:'left'}
								,{code: 'height', value:'1000px'}
							],					
							type:'chart',
		   	            	id: 'hostinfo31',
		   	            	label:'',
		   	            	width: '49%',
		   	            	//height:'800px',
		   	            	data: function(){
			            		var rtn = {};
			            		var series = getDrillDownDataSeries2(
			            				'',
			            				$.extend(true, [], dataHostinfo.dataList) ,
			            				['SLOTNAME'] , //groupby
			            				[], //filter
			            				[{col: 'LATENCY_MAX_AVG' , convert:'z',isnull:0}], //convert
			            				'TESTNAME' ,  //category
			            				'CNT',
			            				{cd:'SLOTNAME', name:'SLOTNAME'},
			            				{isGroupby: false}
			            		);
			            		
			            		$.each(series.series, function(){
			            			this.connectNulls =  true;
			            			this.minSize = "4";
			            			this.maxSize = "50";
			            		});
			            		
			            		//////////// xcategory?
			            		var xAxis = {
		           			    	gridLineWidth: 1,
		           			        title: {
		           			            text: 'test name'
		           			        }
		//            			        ,labels: {
		//            			            format: '{value}'
		//            			        }
									,labels:{
										formatter:	function(){
											//var aaa = "";
											//console.log(arguments);
											if (typeof this.value == "string")
												return this.value;
										}
									}
		           			        //,type:'category'
		           			    };
			            		
			            		var xCategories = alasql('select distinct mysplit(TESTNAME,"_") as testname , TESTNAME as testnamefull from ?  order by 1' , [dataHostinfo.dataList]);	  
			            		xCategories = _.map(xCategories,function(m,i){
			            			return {idx:i ,testname:m.testname, testnamefull: m.testnamefull};
			            		});
			            		
			            		var xCategories1 =  _.pluck(xCategories,'testname');
			            		xAxis.categories = xCategories1;
			            		xAxis.categoriesOrigine = xCategories;
			            		dataHostinfo.xAxis = xAxis;
			            		rtn.xAxis = xAxis;
			            		
			            			// 각 데이타에 xCategories 를 지정한다.
			            			$.each(series.series, function(i,s){
			            				$.each(s.data,function(j,d){
			            					var  targetCategory = alasql('select idx from ? where testnamefull = "' + d.TESTNAME  + '"', [xCategories]);
			            					if(targetCategory.length > 0)
			            						d.x = targetCategory[0].idx;
			            				});
			            			});
			            		
			            		//////////// ycategory?
			            		var yAxis =  {
		           			        startOnTick: false,
		           			        endOnTick: false,
		           			        title: {
		           			            text: 'command'
		           			        }
		           			        ,labels: {
		           			            format: '{value}'
		           			        }
		           			    };   	            		
			            		var yCategories = alasql('select distinct COMMAND command from ?  order by 1' , [dataHostinfo.dataList]);	  
			            		yCategories = _.map(yCategories,function(m,i){
			            			return {idx:i , command: m.command };
			            		});
			            		
			            		var yCategories1 =  _.pluck(yCategories,'command');
			            		yAxis.categories = yCategories1;
			            		yAxis.categoriesOrigine = yCategories;
			            		rtn.yAxis = yAxis;
			            		dataHostinfo.yAxis = yAxis;
			            		
			            			// 각 데이타에 xCategories 를 지정한다.
			            			$.each(series.series, function(i,s){
			            				$.each(s.data,function(j,d){
			            					var  targetCategory = alasql('select idx from ? where command = "' + d.COMMAND  + '" ', [yCategories]);
			            					if(targetCategory.length > 0)
			            						d.y = targetCategory[0].idx;
			            				});
			            			});
			            		
			            			    	            		
			            		// category end
			            		
			            		// return start
			            		rtn.series = series;
			            		dataHostinfo.series = series;
			            		
			            		return rtn;
		   	            	},
		   	            	options: function(){
		   	            		var option = {
			            				chart:{
			            					type: 'bubble'
			            					, plotBorderWidth: 1
			            			        , zoomType: 'xy'
			            				}
			            				, legend: {
			            			        enabled: true
			            			    }
			            				, title: {
			            			        text: ' '
			            			    },
			            			    tooltip: {
			            			        useHTML: true,
			            			        headerFormat: '<table>',
			            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
			            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
			            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
			            			            '<tr><th>Latency(max)_avg:</th><td>{point.z}</td></tr>',
			            			        footerFormat: '</table>',
			            			        followPointer: true
			            			    }
			            				
			            		};
			            		
			            		return option;
			            	}
		   	            	
		   	            }
						,{
							
							containerCss:[
								{code: 'height', value:'1000px'}
							],					
							type:'chart',
	    	            	id: 'hostinfo32',
	    	            	label:'',
	    	            	width: '49%',
	    	            	//height:'430px',
	    	            	data: function(){
    	            			var rtn = {};
    		            		
    	            			//var dataList = groupbyCount(dataSmart.dataList,['SLOTNAME','TESTNAME']);
    		            		var series = getDrillDownDataSeries2(
    		            				'',
    		            				$.extend(true, [], dataHostinfo.dataList) ,
    		            				['SLOTNAME','COMMAND','TESTNAME'] , //groupby
    		            				[], //filter
    		            				[{col: 'LATENCY_MAX_AVG' , convert:'y',isnull:0}], //convert
    		            				'COMMAND' ,  //category
    		            				'CNT',
    		            				{cd:'SLOTNAME', name:'SLOTNAME'},
    		            				{isGroupby: false}
    		            		);
	    		            		
    		            		//////////// xcategory?
    		            		var xAxis = {
    	           			    
    		            		};
	    		            		
    		            		var xCategories = alasql('select distinct COMMAND id , COMMAND name, TESTNAME testname from ?  order by 1 , 3' , [dataHostinfo.dataList]);
    		            		xCategories = _.map(xCategories,function(m,i){
    		            			return {
    		            				idx:i , 
    		            				attribute_id: m.id, 
    		            				attribute_name: m.name,
    		            				testname: m.testname
    		            				};
    		            			
    		            		});
    		            		
    		            		var xTickPositions = [];
    		            		var pre = '';
    		            		var cur = '';
    		            		$.each(xCategories, function(i,c){
    		            			cur = c.attribute_id;
    		            			if(i == 0)
    		            				xTickPositions.push(c.idx);
    		            			if(i > 0 && pre != cur)
    		            				xTickPositions.push(c.idx);
    		            			pre = c.attribute_id;
    		            		} );
    		            		xAxis.tickPositions = xTickPositions;
	    		            		
    		            		var xCategories1 = _.pluck(xCategories,'attribute_id');
    		            		xAxis.categories = xCategories1;
    		            		xAxis.categoriesOrigine = xCategories;
    		            		rtn.xAxis = xAxis;
    		            		
    		            			// 각 데이타에 xCategories 를 지정한다.
    		            			$.each(series.series, function(i,s){
    		            				$.each(s.data,function(j,d){
    		            					var  targetCategory = alasql('select idx from ? where attribute_id = "' + d.COMMAND  + '" and testname="'+ d.TESTNAME+'"	', [xCategories]);
    		            					if(targetCategory.length > 0)
    		            						d.x = targetCategory[0].idx;
    		            				});
    		            			});
    		            			
    		            		
    		            		// return start
    		            		rtn.series = series;
    		            		return rtn;
	    	            	},
	    	            	options: function(){
	    	            		var option = {
	    	            				chart:{
	    	            					polar: true
	    	            					, type: 'scatter'
	    	            			        , zoomType: 'xy'
	    	            				}
	    	            				, legend: {
	    	            			        enabled: true
	    	            			    }
	    	            				, title: {
	    	            			        text: ' '
	    	            			    }
	    	            			    ,tooltip: {
	    	            			        useHTML: true,
	    	            			        headerFormat: '<table>',
	    	            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	    	            			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	    	            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	    	            			            '<tr><th>Latency(max)_avg:</th><td>{point.y}</td></tr>' ,
	    	            			        footerFormat: '</table>',
	    	            			        followPointer: true
	    	            			    }
	    	            				
	    	            		};
	    	            		
	    	            		return option;
	    	            	}
							
						}
					]
				}// end of line 3
				,{
					type:'HorizontalLayout',
					label:' By Latency(min)_avg',
					elements:[ 
						{
							containerCss:[
								{code: 'display', value:''}
								,{code: 'float', value:'left'}
								,{code: 'height', value:'1000px'}
							],					
							type:'chart',
		   	            	id: 'hostinfo41',
		   	            	label:'',
		   	            	width: '49%',
		   	            	//height:'800px',
		   	            	data: function(){
			            		var rtn = {};
			            		var series = getDrillDownDataSeries2(
			            				'',
			            				$.extend(true, [], dataHostinfo.dataList) ,
			            				['SLOTNAME'] , //groupby
			            				[], //filter
			            				[{col: 'LATENCY_MIN_AVG' , convert:'z',isnull:0}], //convert
			            				'TESTNAME' ,  //category
			            				'CNT',
			            				{cd:'SLOTNAME', name:'SLOTNAME'},
			            				{isGroupby: false}
			            		);
			            		
			            		$.each(series.series, function(){
			            			this.connectNulls =  true;
			            			this.minSize = "4";
			            			this.maxSize = "50";
			            		});
			            		
			            		//////////// xcategory?
			            		var xAxis = {
		           			    	gridLineWidth: 1,
		           			        title: {
		           			            text: 'test name'
		           			        }
		//            			        ,labels: {
		//            			            format: '{value}'
		//            			        }
									,labels:{
										formatter:	function(){
											//var aaa = "";
											//console.log(arguments);
											if (typeof this.value == "string")
												return this.value;
										}
									}
		           			        //,type:'category'
		           			    };
			            		
			            		var xCategories = alasql('select distinct mysplit(TESTNAME,"_") as testname , TESTNAME as testnamefull from ?  order by 1' , [dataHostinfo.dataList]);	  
			            		xCategories = _.map(xCategories,function(m,i){
			            			return {idx:i ,testname:m.testname, testnamefull: m.testnamefull};
			            		});
			            		
			            		var xCategories1 =  _.pluck(xCategories,'testname');
			            		xAxis.categories = xCategories1;
			            		xAxis.categoriesOrigine = xCategories;
			            		dataHostinfo.xAxis = xAxis;
			            		rtn.xAxis = xAxis;
			            		
			            			// 각 데이타에 xCategories 를 지정한다.
			            			$.each(series.series, function(i,s){
			            				$.each(s.data,function(j,d){
			            					var  targetCategory = alasql('select idx from ? where testnamefull = "' + d.TESTNAME  + '"', [xCategories]);
			            					if(targetCategory.length > 0)
			            						d.x = targetCategory[0].idx;
			            				});
			            			});
			            		
			            		//////////// ycategory?
			            		var yAxis =  {
		           			        startOnTick: false,
		           			        endOnTick: false,
		           			        title: {
		           			            text: 'command'
		           			        }
		           			        ,labels: {
		           			            format: '{value}'
		           			        }
		           			    };   	            		
			            		var yCategories = alasql('select distinct COMMAND command from ?  order by 1' , [dataHostinfo.dataList]);	  
			            		yCategories = _.map(yCategories,function(m,i){
			            			return {idx:i , command: m.command };
			            		});
			            		
			            		var yCategories1 =  _.pluck(yCategories,'command');
			            		yAxis.categories = yCategories1;
			            		yAxis.categoriesOrigine = yCategories;
			            		rtn.yAxis = yAxis;
			            		dataHostinfo.yAxis = yAxis;
			            		
			            			// 각 데이타에 xCategories 를 지정한다.
			            			$.each(series.series, function(i,s){
			            				$.each(s.data,function(j,d){
			            					var  targetCategory = alasql('select idx from ? where command = "' + d.COMMAND  + '" ', [yCategories]);
			            					if(targetCategory.length > 0)
			            						d.y = targetCategory[0].idx;
			            				});
			            			});
			            		
			            			    	            		
			            		// category end
			            		
			            		// return start
			            		rtn.series = series;
			            		dataHostinfo.series = series;
			            		
			            		return rtn;
		   	            	},
		   	            	options: function(){
		   	            		var option = {
			            				chart:{
			            					type: 'bubble'
			            					, plotBorderWidth: 1
			            			        , zoomType: 'xy'
			            				}
			            				, legend: {
			            			        enabled: true
			            			    }
			            				, title: {
			            			        text: ' '
			            			    },
			            			    tooltip: {
			            			        useHTML: true,
			            			        headerFormat: '<table>',
			            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
			            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
			            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
			            			            '<tr><th>Latency(min)_avg:</th><td>{point.z}</td></tr>',
			            			        footerFormat: '</table>',
			            			        followPointer: true
			            			    }
			            				
			            		};
			            		
			            		return option;
			            	}
		   	            	
		   	            }
						,{
							
							containerCss:[
								{code: 'height', value:'1000px'}
							],					
							type:'chart',
	    	            	id: 'hostinfo42',
	    	            	label:'',
	    	            	width: '49%',
	    	            	//height:'430px',
	    	            	data: function(){
    	            			var rtn = {};
    		            		
    	            			//var dataList = groupbyCount(dataSmart.dataList,['SLOTNAME','TESTNAME']);
    		            		var series = getDrillDownDataSeries2(
    		            				'',
    		            				$.extend(true, [], dataHostinfo.dataList) ,
    		            				['SLOTNAME','COMMAND','TESTNAME'] , //groupby
    		            				[], //filter
    		            				[{col: 'LATENCY_MIN_AVG' , convert:'y',isnull:0}], //convert
    		            				'COMMAND' ,  //category
    		            				'CNT',
    		            				{cd:'SLOTNAME', name:'SLOTNAME'},
    		            				{isGroupby: false}
    		            		);
	    		            		
    		            		//////////// xcategory?
    		            		var xAxis = {
    	           			    
    		            		};
	    		            		
    		            		var xCategories = alasql('select distinct COMMAND id , COMMAND name, TESTNAME testname from ?  order by 1 , 3' , [dataHostinfo.dataList]);
    		            		xCategories = _.map(xCategories,function(m,i){
    		            			return {
    		            				idx:i , 
    		            				attribute_id: m.id, 
    		            				attribute_name: m.name,
    		            				testname: m.testname
    		            				};
    		            			
    		            		});
    		            		
    		            		var xTickPositions = [];
    		            		var pre = '';
    		            		var cur = '';
    		            		$.each(xCategories, function(i,c){
    		            			cur = c.attribute_id;
    		            			if(i == 0)
    		            				xTickPositions.push(c.idx);
    		            			if(i > 0 && pre != cur)
    		            				xTickPositions.push(c.idx);
    		            			pre = c.attribute_id;
    		            		} );
    		            		xAxis.tickPositions = xTickPositions;
	    		            		
    		            		var xCategories1 = _.pluck(xCategories,'attribute_id');
    		            		xAxis.categories = xCategories1;
    		            		xAxis.categoriesOrigine = xCategories;
    		            		rtn.xAxis = xAxis;
    		            		
    		            			// 각 데이타에 xCategories 를 지정한다.
    		            			$.each(series.series, function(i,s){
    		            				$.each(s.data,function(j,d){
    		            					var  targetCategory = alasql('select idx from ? where attribute_id = "' + d.COMMAND  + '" and testname="'+ d.TESTNAME+'"	', [xCategories]);
    		            					if(targetCategory.length > 0)
    		            						d.x = targetCategory[0].idx;
    		            				});
    		            			});
    		            			
    		            		
    		            		// return start
    		            		rtn.series = series;
    		            		return rtn;
	    	            	},
	    	            	options: function(){
	    	            		var option = {
	    	            				chart:{
	    	            					polar: true
	    	            					, type: 'scatter'
	    	            			        , zoomType: 'xy'
	    	            				}
	    	            				, legend: {
	    	            			        enabled: true
	    	            			    }
	    	            				, title: {
	    	            			        text: ' '
	    	            			    }
	    	            			    ,tooltip: {
	    	            			        useHTML: true,
	    	            			        headerFormat: '<table>',
	    	            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	    	            			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	    	            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	    	            			            '<tr><th>Latency(min)_avg:</th><td>{point.y}</td></tr>' ,
	    	            			        footerFormat: '</table>',
	    	            			        followPointer: true
	    	            			    }
	    	            				
	    	            		};
	    	            		
	    	            		return option;
	    	            	}
							
						}
					]
				}// end of line 4
				,{
					type:'HorizontalLayout',
					label:' By Latency(max)_tot',
					elements:[ 
						{
							containerCss:[
								{code: 'display', value:''}
								,{code: 'float', value:'left'}
								,{code: 'height', value:'1000px'}
							],					
							type:'chart',
		   	            	id: 'hostinfo51',
		   	            	label:'',
		   	            	width: '49%',
		   	            	//height:'800px',
		   	            	data: function(){
			            		var rtn = {};
			            		var series = getDrillDownDataSeries2(
			            				'',
			            				$.extend(true, [], dataHostinfo.dataList) ,
			            				['SLOTNAME'] , //groupby
			            				[], //filter
			            				[{col: 'LATENCY_MAX_TOT' , convert:'z',isnull:0}], //convert
			            				'TESTNAME' ,  //category
			            				'CNT',
			            				{cd:'SLOTNAME', name:'SLOTNAME'},
			            				{isGroupby: false}
			            		);
			            		
			            		$.each(series.series, function(){
			            			this.connectNulls =  true;
			            			this.minSize = "4";
			            			this.maxSize = "50";
			            		});
			            		
			            		//////////// xcategory?
			            		var xAxis = {
		           			    	gridLineWidth: 1,
		           			        title: {
		           			            text: 'test name'
		           			        }
		//            			        ,labels: {
		//            			            format: '{value}'
		//            			        }
									,labels:{
										formatter:	function(){
											//var aaa = "";
											//console.log(arguments);
											if (typeof this.value == "string")
												return this.value;
										}
									}
		           			        //,type:'category'
		           			    };
			            		
			            		var xCategories = alasql('select distinct mysplit(TESTNAME,"_") as testname , TESTNAME as testnamefull from ?  order by 1' , [dataHostinfo.dataList]);	  
			            		xCategories = _.map(xCategories,function(m,i){
			            			return {idx:i ,testname:m.testname, testnamefull: m.testnamefull};
			            		});
			            		
			            		var xCategories1 =  _.pluck(xCategories,'testname');
			            		xAxis.categories = xCategories1;
			            		xAxis.categoriesOrigine = xCategories;
			            		dataHostinfo.xAxis = xAxis;
			            		rtn.xAxis = xAxis;
			            		
			            			// 각 데이타에 xCategories 를 지정한다.
			            			$.each(series.series, function(i,s){
			            				$.each(s.data,function(j,d){
			            					var  targetCategory = alasql('select idx from ? where testnamefull = "' + d.TESTNAME  + '"', [xCategories]);
			            					if(targetCategory.length > 0)
			            						d.x = targetCategory[0].idx;
			            				});
			            			});
			            		
			            		//////////// ycategory?
			            		var yAxis =  {
		           			        startOnTick: false,
		           			        endOnTick: false,
		           			        title: {
		           			            text: 'command'
		           			        }
		           			        ,labels: {
		           			            format: '{value}'
		           			        }
		           			    };   	            		
			            		var yCategories = alasql('select distinct COMMAND command from ?  order by 1' , [dataHostinfo.dataList]);	  
			            		yCategories = _.map(yCategories,function(m,i){
			            			return {idx:i , command: m.command };
			            		});
			            		
			            		var yCategories1 =  _.pluck(yCategories,'command');
			            		yAxis.categories = yCategories1;
			            		yAxis.categoriesOrigine = yCategories;
			            		rtn.yAxis = yAxis;
			            		dataHostinfo.yAxis = yAxis;
			            		
			            			// 각 데이타에 xCategories 를 지정한다.
			            			$.each(series.series, function(i,s){
			            				$.each(s.data,function(j,d){
			            					var  targetCategory = alasql('select idx from ? where command = "' + d.COMMAND  + '" ', [yCategories]);
			            					if(targetCategory.length > 0)
			            						d.y = targetCategory[0].idx;
			            				});
			            			});
			            		
			            			    	            		
			            		// category end
			            		
			            		// return start
			            		rtn.series = series;
			            		dataHostinfo.series = series;
			            		
			            		return rtn;
		   	            	},
		   	            	options: function(){
		   	            		var option = {
			            				chart:{
			            					type: 'bubble'
			            					, plotBorderWidth: 1
			            			        , zoomType: 'xy'
			            				}
			            				, legend: {
			            			        enabled: true
			            			    }
			            				, title: {
			            			        text: ' '
			            			    },
			            			    tooltip: {
			            			        useHTML: true,
			            			        headerFormat: '<table>',
			            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
			            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
			            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
			            			            '<tr><th>Latency(max)_tot:</th><td>{point.z}</td></tr>',
			            			        footerFormat: '</table>',
			            			        followPointer: true
			            			    }
			            				
			            		};
			            		
			            		return option;
			            	}
		   	            	
		   	            }
						,{
							
							containerCss:[
								{code: 'height', value:'1000px'}
							],					
							type:'chart',
	    	            	id: 'hostinfo52',
	    	            	label:'',
	    	            	width: '49%',
	    	            	//height:'430px',
	    	            	data: function(){
    	            			var rtn = {};
    		            		
    	            			//var dataList = groupbyCount(dataSmart.dataList,['SLOTNAME','TESTNAME']);
    		            		var series = getDrillDownDataSeries2(
    		            				'',
    		            				$.extend(true, [], dataHostinfo.dataList) ,
    		            				['SLOTNAME','COMMAND','TESTNAME'] , //groupby
    		            				[], //filter
    		            				[{col: 'LATENCY_MAX_TOT' , convert:'y',isnull:0}], //convert
    		            				'COMMAND' ,  //category
    		            				'CNT',
    		            				{cd:'SLOTNAME', name:'SLOTNAME'},
    		            				{isGroupby: false}
    		            		);
	    		            		
    		            		//////////// xcategory?
    		            		var xAxis = {
    	           			    
    		            		};
	    		            		
    		            		var xCategories = alasql('select distinct COMMAND id , COMMAND name, TESTNAME testname from ?  order by 1 , 3' , [dataHostinfo.dataList]);
    		            		xCategories = _.map(xCategories,function(m,i){
    		            			return {
    		            				idx:i , 
    		            				attribute_id: m.id, 
    		            				attribute_name: m.name,
    		            				testname: m.testname
    		            				};
    		            			
    		            		});
    		            		
    		            		var xTickPositions = [];
    		            		var pre = '';
    		            		var cur = '';
    		            		$.each(xCategories, function(i,c){
    		            			cur = c.attribute_id;
    		            			if(i == 0)
    		            				xTickPositions.push(c.idx);
    		            			if(i > 0 && pre != cur)
    		            				xTickPositions.push(c.idx);
    		            			pre = c.attribute_id;
    		            		} );
    		            		xAxis.tickPositions = xTickPositions;
	    		            		
    		            		var xCategories1 = _.pluck(xCategories,'attribute_id');
    		            		xAxis.categories = xCategories1;
    		            		xAxis.categoriesOrigine = xCategories;
    		            		rtn.xAxis = xAxis;
    		            		
    		            			// 각 데이타에 xCategories 를 지정한다.
    		            			$.each(series.series, function(i,s){
    		            				$.each(s.data,function(j,d){
    		            					var  targetCategory = alasql('select idx from ? where attribute_id = "' + d.COMMAND  + '" and testname="'+ d.TESTNAME+'"	', [xCategories]);
    		            					if(targetCategory.length > 0)
    		            						d.x = targetCategory[0].idx;
    		            				});
    		            			});
    		            			
    		            		
    		            		// return start
    		            		rtn.series = series;
    		            		return rtn;
	    	            	},
	    	            	options: function(){
	    	            		var option = {
	    	            				chart:{
	    	            					polar: true
	    	            					, type: 'scatter'
	    	            			        , zoomType: 'xy'
	    	            				}
	    	            				, legend: {
	    	            			        enabled: true
	    	            			    }
	    	            				, title: {
	    	            			        text: ' '
	    	            			    }
	    	            			    ,tooltip: {
	    	            			        useHTML: true,
	    	            			        headerFormat: '<table>',
	    	            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	    	            			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	    	            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	    	            			            '<tr><th>Latency(max)_tot:</th><td>{point.y}</td></tr>' ,
	    	            			        footerFormat: '</table>',
	    	            			        followPointer: true
	    	            			    }
	    	            				
	    	            		};
	    	            		
	    	            		return option;
	    	            	}
							
						}
					]
				}// end of line 5  latency(max)_tot
				,{ 
					type:'HorizontalLayout',
					label:' By Latency(min)_tot',
					elements:[ 
						{
							containerCss:[
								{code: 'display', value:''}
								,{code: 'float', value:'left'}
								,{code: 'height', value:'1000px'}
							],					
							type:'chart',
		   	            	id: 'hostinfo61',
		   	            	label:'',
		   	            	width: '49%',
		   	            	//height:'800px',
		   	            	data: function(){
			            		var rtn = {};
			            		var series = getDrillDownDataSeries2(
			            				'',
			            				$.extend(true, [], dataHostinfo.dataList) ,
			            				['SLOTNAME'] , //groupby
			            				[], //filter
			            				[{col: 'LATENCY_MIN_TOT' , convert:'z',isnull:0}], //convert
			            				'TESTNAME' ,  //category
			            				'CNT',
			            				{cd:'SLOTNAME', name:'SLOTNAME'},
			            				{isGroupby: false}
			            		);
			            		
			            		$.each(series.series, function(){
			            			this.connectNulls =  true;
			            			this.minSize = "4";
			            			this.maxSize = "50";
			            		});
			            		
			            		//////////// xcategory?
			            		var xAxis = {
		           			    	gridLineWidth: 1,
		           			        title: {
		           			            text: 'test name'
		           			        }
		//            			        ,labels: {
		//            			            format: '{value}'
		//            			        }
									,labels:{
										formatter:	function(){
											//var aaa = "";
											//console.log(arguments);
											if (typeof this.value == "string")
												return this.value;
										}
									}
		           			        //,type:'category'
		           			    };
			            		
			            		var xCategories = alasql('select distinct mysplit(TESTNAME,"_") as testname , TESTNAME as testnamefull from ?  order by 1' , [dataHostinfo.dataList]);	  
			            		xCategories = _.map(xCategories,function(m,i){
			            			return {idx:i ,testname:m.testname, testnamefull: m.testnamefull};
			            		});
			            		
			            		var xCategories1 =  _.pluck(xCategories,'testname');
			            		xAxis.categories = xCategories1;
			            		xAxis.categoriesOrigine = xCategories;
			            		dataHostinfo.xAxis = xAxis;
			            		rtn.xAxis = xAxis;
			            		
			            			// 각 데이타에 xCategories 를 지정한다.
			            			$.each(series.series, function(i,s){
			            				$.each(s.data,function(j,d){
			            					var  targetCategory = alasql('select idx from ? where testnamefull = "' + d.TESTNAME  + '"', [xCategories]);
			            					if(targetCategory.length > 0)
			            						d.x = targetCategory[0].idx;
			            				});
			            			});
			            		
			            		//////////// ycategory?
			            		var yAxis =  {
		           			        startOnTick: false,
		           			        endOnTick: false,
		           			        title: {
		           			            text: 'command'
		           			        }
		           			        ,labels: {
		           			            format: '{value}'
		           			        }
		           			    };   	            		
			            		var yCategories = alasql('select distinct COMMAND command from ?  order by 1' , [dataHostinfo.dataList]);	  
			            		yCategories = _.map(yCategories,function(m,i){
			            			return {idx:i , command: m.command };
			            		});
			            		
			            		var yCategories1 =  _.pluck(yCategories,'command');
			            		yAxis.categories = yCategories1;
			            		yAxis.categoriesOrigine = yCategories;
			            		rtn.yAxis = yAxis;
			            		dataHostinfo.yAxis = yAxis;
			            		
			            			// 각 데이타에 xCategories 를 지정한다.
			            			$.each(series.series, function(i,s){
			            				$.each(s.data,function(j,d){
			            					var  targetCategory = alasql('select idx from ? where command = "' + d.COMMAND  + '" ', [yCategories]);
			            					if(targetCategory.length > 0)
			            						d.y = targetCategory[0].idx;
			            				});
			            			});
			            		
			            			    	            		
			            		// category end
			            		
			            		// return start
			            		rtn.series = series;
			            		dataHostinfo.series = series;
			            		
			            		return rtn;
		   	            	},
		   	            	options: function(){
		   	            		var option = {
			            				chart:{
			            					type: 'bubble'
			            					, plotBorderWidth: 1
			            			        , zoomType: 'xy'
			            				}
			            				, legend: {
			            			        enabled: true
			            			    }
			            				, title: {
			            			        text: ' '
			            			    },
			            			    tooltip: {
			            			        useHTML: true,
			            			        headerFormat: '<table>',
			            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
			            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
			            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
			            			            '<tr><th>Latency(min)_tot:</th><td>{point.z}</td></tr>',
			            			        footerFormat: '</table>',
			            			        followPointer: true
			            			    }
			            				
			            		};
			            		
			            		return option;
			            	}
		   	            	
		   	            }
						,{
							
							containerCss:[
								{code: 'height', value:'1000px'}
							],					
							type:'chart',
	    	            	id: 'hostinfo62',
	    	            	label:'',
	    	            	width: '49%',
	    	            	//height:'430px',
	    	            	data: function(){
    	            			var rtn = {};
    		            		
    	            			//var dataList = groupbyCount(dataSmart.dataList,['SLOTNAME','TESTNAME']);
    		            		var series = getDrillDownDataSeries2(
    		            				'',
    		            				$.extend(true, [], dataHostinfo.dataList) ,
    		            				['SLOTNAME','COMMAND','TESTNAME'] , //groupby
    		            				[], //filter
    		            				[{col: 'LATENCY_MIN_TOT' , convert:'y',isnull:0}], //convert
    		            				'COMMAND' ,  //category
    		            				'CNT',
    		            				{cd:'SLOTNAME', name:'SLOTNAME'},
    		            				{isGroupby: false}
    		            		);
	    		            		
    		            		//////////// xcategory?
    		            		var xAxis = {
    	           			    
    		            		};
	    		            		
    		            		var xCategories = alasql('select distinct COMMAND id , COMMAND name, TESTNAME testname from ?  order by 1 , 3' , [dataHostinfo.dataList]);
    		            		xCategories = _.map(xCategories,function(m,i){
    		            			return {
    		            				idx:i , 
    		            				attribute_id: m.id, 
    		            				attribute_name: m.name,
    		            				testname: m.testname
    		            				};
    		            			
    		            		});
    		            		
    		            		var xTickPositions = [];
    		            		var pre = '';
    		            		var cur = '';
    		            		$.each(xCategories, function(i,c){
    		            			cur = c.attribute_id;
    		            			if(i == 0)
    		            				xTickPositions.push(c.idx);
    		            			if(i > 0 && pre != cur)
    		            				xTickPositions.push(c.idx);
    		            			pre = c.attribute_id;
    		            		} );
    		            		xAxis.tickPositions = xTickPositions;
	    		            		
    		            		var xCategories1 = _.pluck(xCategories,'attribute_id');
    		            		xAxis.categories = xCategories1;
    		            		xAxis.categoriesOrigine = xCategories;
    		            		rtn.xAxis = xAxis;
    		            		
    		            			// 각 데이타에 xCategories 를 지정한다.
    		            			$.each(series.series, function(i,s){
    		            				$.each(s.data,function(j,d){
    		            					var  targetCategory = alasql('select idx from ? where attribute_id = "' + d.COMMAND  + '" and testname="'+ d.TESTNAME+'"	', [xCategories]);
    		            					if(targetCategory.length > 0)
    		            						d.x = targetCategory[0].idx;
    		            				});
    		            			});
    		            			
    		            		
    		            		// return start
    		            		rtn.series = series;
    		            		return rtn;
	    	            	},
	    	            	options: function(){
	    	            		var option = {
	    	            				chart:{
	    	            					polar: true
	    	            					, type: 'scatter'
	    	            			        , zoomType: 'xy'
	    	            				}
	    	            				, legend: {
	    	            			        enabled: true
	    	            			    }
	    	            				, title: {
	    	            			        text: ' '
	    	            			    }
	    	            			    ,tooltip: {
	    	            			        useHTML: true,
	    	            			        headerFormat: '<table>',
	    	            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	    	            			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	    	            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	    	            			            '<tr><th>Latency(min)_tot:</th><td>{point.y}</td></tr>' ,
	    	            			        footerFormat: '</table>',
	    	            			        followPointer: true
	    	            			    }
	    	            				
	    	            		};
	    	            		
	    	            		return option;
	    	            	}
							
						}
					]
				}// end of line 6  latency(min)_tot
				*/
			]
	};
	
	var shemaHostinfoCount1 = {
		type:'Vertical',
		label:'',
		elements:[
			{
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
				],					
				type:'chart',
			   	id: 'hostinfo11',
			   	label:'',
			   	width: '99%',
			   	//height:'800px',
			   	data: function(){
			   		return dataHostinfo.rtn.left;
			   	},
			   	options: function(){
			   		var option = {
							chart:{
								type: 'bubble'
								, plotBorderWidth: 1
						        , zoomType: 'xy'
							}
							, legend: {
						        enabled: true
						    }
							, title: {
						        text: ' '
						    },
						    tooltip: {
						        useHTML: true,
						        headerFormat: '<table>',
						        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
						            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
						            '<tr><th>command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
						            '<tr><th>count:</th><td>{point.z}</td></tr>',
						        footerFormat: '</table>',
						        followPointer: true
						    }
							
					};
					
					return option;
				}
			   	
			 }
			, {
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
				],					
				type:'chart',
			   	id: 'hostinfo12',
			   	label:'',
			   	width: '99%',
			   	//height:'800px',
			   	data: function(){
			   		return dataHostinfo.rtn.right;
			   	},
			   	options: function(){
			   		var option = {
	          				chart:{
	          					polar: true
	          					, type: 'scatter'
	          			        , zoomType: 'xy'
	          				}
	          				, legend: {
	          			        enabled: true
	          			    }
	          				, title: {
	          			        text: ' '
	          			    }
	          			    ,tooltip: {
	          			        useHTML: true,
	          			        headerFormat: '<table>',
	          			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
	          			            '<tr><th>command:</th><td>{point.COMMAND}</td></tr>'  +
	          			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
	          			            '<tr><th>count:</th><td>{point.y}</td></tr>' ,
	          			        footerFormat: '</table>',
	          			        followPointer: true
	          			    }
	           		}
					
					return option;
				}
			   	
			 }
			, {
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
					,{code: 'width', value:'99%'}
				],			
		    	type:'grid',
		    	id: 'grid_hostinfo',
		    	label:'Hostinfo List',
		    	data: function(){ 
		    		var datalist = [];
		    		var theGrid = $("#searchGridTable");
		    		var selIds = theGrid.jqGrid('getGridParam','selarrrow');
		    		var row = theGrid.jqGrid('getRowData',selIds[0]);
		    		
		    		var paramObj = {
            				folderNames :[],
            				selectedPoints :[]
            		};
            		var param = "";
            		$.each(selIds,function(i,s){
            			var row = theGrid.jqGrid('getRowData',s);
            			if(i > 0)
            				param +="&";
            			param += "folderName="+ row.FOLDER_NAME;
            			paramObj.folderNames.push(row.FOLDER_NAME);
            		});
            		
            		var chartPoints = $("#testNameRangeContainer").highcharts();
            		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
            		if(chartPoints != undefined){
            			$.each( chartPoints.getSelectedPoints(),function(){
	            			paramObj.selectedPoints.push(this.options);
	            		});
            		}
		    		param += '&sqlid=dashboard.regresson.hostlist.raw';
		    		$.ajax({
		    			type: "POST",
		    			url: "/dashboard/genericlListJson.do",
		    			data: {searchJson: JSON.stringify(paramObj), sqlid: 'dashboard.regresson.hostlist.raw' }, 
		    			async: false,
		    			success:  function(response){
		    				datalist  = response.dataList;
		    				
		    			}
		    		});
		    		return datalist;
		    	},
		    	items:[
					{label:'Folder Name',name:'FOLDER_NAME', id:'FOLDER_NAME',width: 150
							,stype: "select"
							, searchoptions: gridSearchOption.foldername
					},
					{label:'Pjt Code',name:'PJT_CODE', id:'PJT_CODE',width: 90},
					{label:'Pjt Name',name:'PJT_NAME_PMS', id:'PJT_NAME_PMS',width: 200},
					{label:'Firmware',name:'FIRMWARE', id:'FIRMWARE',width: 130
						, stype: "select"
						, searchoptions: gridSearchOption.firmware 
					},
					{label:'Revision',name:'REVISION', id:'REVISION',width: 70},
					{label:'Test Name',name:'TESTNAME', id:'TESTNAME',width: 270 
						, stype: "select"
						, searchoptions: gridSearchOption.testname 
					},
					{label:'Slot Name',name:'SLOTNAME', id:'SLOTNAME',width: 100
						, stype: "select"
						, searchoptions: gridSearchOption.slotname 
					},
					{label:'Command',name:'COMMAND', id:'COMMAND',width: 100 },
					{label:'Count',name:'CNT', id:'CNT',sorttype: 'number',  formatter:'number', align:'right',formatoptions:{decimalSeparator:",", thousandsSeparator: ",", decimalPlaces: 0,}, width: 110 ,
						searchoptions : {
                            // show search options
                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
						}	
					},
					{label:'Size',name:'SIZE', id:'SIZE', sorttype: 'number', formatter:'number', align:'right',formatoptions:{decimalSeparator:",", thousandsSeparator: ",", decimalPlaces: 0},width: 110 ,
						searchoptions : {
                            // show search options
                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
						}		
					},
					{label:'Latency(min)',name:'LATENCY_MIN', id:'LATENCY_MIN',sorttype: 'number',  formatter:'number', align:'right',formatoptions:{decimalSeparator:",", thousandsSeparator: ",", decimalPlaces: 0},width: 110, 
						searchoptions : {
                            // show search options
                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
						}	
					},
					{label:'Latency(max)',name:'LATENCY_MAX', id:'LATENCY_MAX',sorttype: 'number',  formatter:'number', align:'right',formatoptions:{decimalSeparator:",", thousandsSeparator: ",", decimalPlaces: 0},width: 110, 
						searchoptions : {
                            // show search options
                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
						}		
					}
					
					
					
		    	],
		    	gridOpt:{
		    		datatype:'local',
		    		pager: "#grid_hostinfoPager",
		    		viewrecords: true,
		    		width: '100%',
		    		height: '100%',
		    		sortable: true,
		    		multiSort:true,
		    		sortname: 'FIRMWARE, TESTNAME, SLOTNAME, COMMAND',
		    		rowNum: 20,
					rowList:[10,20,30,50,100],
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
	
	
	var shemaHostinfoCount2 = {
		type:'Vertical',
		label:'',
		elements:[
			{
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
				],					
				type:'chart',
			   	id: 'hostinfo12',
			   	label:'',
			   	width: '99%',
			   	//height:'800px',
			   	data: function(){
			   		return dataHostinfo.rtn.right;
			   	},
			   	options: function(){
			   		var option = {
	          				chart:{
	          					polar: true
	          					, type: 'scatter'
	          			        , zoomType: 'xy'
	          				}
	          				, legend: {
	          			        enabled: true
	          			    }
	          				, title: {
	          			        text: ' '
	          			    }
	          			    ,tooltip: {
	          			        useHTML: true,
	          			        headerFormat: '<table>',
	          			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
	          			            '<tr><th>command:</th><td>{point.COMMAND}</td></tr>'  +
	          			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
	          			            '<tr><th>count:</th><td>{point.y}</td></tr>' ,
	          			        footerFormat: '</table>',
	          			        followPointer: true
	          			    }
	           		}
					
					return option;
				}
			   	
			 }
		]
	};
	
	var shemaHostinfoSize1 = {
		type:'Vertical',
		label:'',
		elements:[
			{
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
				],					
				type:'chart',
			   	id: 'HostinfoSize1',
			   	label:'',
			   	width: '99%',
			   	//height:'800px',
			   	data: function(){
			   		var rtn = $.extend(true,{},dataHostinfo.rtn.left);
            		$.each(rtn.series.series,function(i,s){
            			$.each(s.data,function(j,d){
            				d['z'] = d['SIZE'];
            			});
            		});
            		return rtn;
			   	},
			   	options: function(){
			   		var option = {
							chart:{
								type: 'bubble'
								, plotBorderWidth: 1
						        , zoomType: 'xy'
							}
							, legend: {
						        enabled: true
						    }
							, title: {
						        text: ' '
						    },
						    tooltip: {
						        useHTML: true,
						        headerFormat: '<table>',
						        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
            			            '<tr><th>Size:</th><td>{point.z}</td></tr>',
						        footerFormat: '</table>',
						        followPointer: true
						    }
							
					};
					
					return option;
				}
			   	
			 },
			 {
					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
					],					
					type:'chart',
				   	id: 'HostinfoSize2',
				   	label:'',
				   	width: '99%',
				   	//height:'800px',
				   	data: function(){
	        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
	            		$.each(rtn.series.series,function(i,s){
	            			$.each(s.data,function(j,d){
	            				d['y'] = d['SIZE'];
	            			});
	            		});
	            		return rtn;
				   	},
				   	options: function(){
				   		var option = {
		          				chart:{
		          					polar: true
		          					, type: 'scatter'
		          			        , zoomType: 'xy'
		          				}
		          				, legend: {
		          			        enabled: true
		          			    }
		          				, title: {
		          			        text: ' '
		          			    }
		          			    ,tooltip: {
		          			        useHTML: true,
		          			        headerFormat: '<table>',
		          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
		          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
		          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
		          			            '<tr><th>Size:</th><td>{point.y}</td></tr>' ,
		          			        footerFormat: '</table>',
		          			        followPointer: true
		          			    }
		           		}
						
						return option;
					}
				   	
				 }
		]
	};
		
		
	var shemaHostinfoSize2 = {
		type:'Vertical',
		label:'',
		elements:[
			{
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
				],					
				type:'chart',
			   	id: 'HostinfoSize2',
			   	label:'',
			   	width: '99%',
			   	//height:'800px',
			   	data: function(){
        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
            		$.each(rtn.series.series,function(i,s){
            			$.each(s.data,function(j,d){
            				d['y'] = d['SIZE'];
            			});
            		});
            		return rtn;
			   	},
			   	options: function(){
			   		var option = {
	          				chart:{
	          					polar: true
	          					, type: 'scatter'
	          			        , zoomType: 'xy'
	          				}
	          				, legend: {
	          			        enabled: true
	          			    }
	          				, title: {
	          			        text: ' '
	          			    }
	          			    ,tooltip: {
	          			        useHTML: true,
	          			        headerFormat: '<table>',
	          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	          			            '<tr><th>Size:</th><td>{point.y}</td></tr>' ,
	          			        footerFormat: '</table>',
	          			        followPointer: true
	          			    }
	           		}
					
					return option;
				}
			   	
			 }
		]
	};
	
	
	var shemaHostinfoLatencyMaxAvg1 = {
			type:'Vertical',
			label:'',
			elements:[
				{
					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
					],					
					type:'chart',
				   	id: 'Latency_max_avg1',
				   	label:'',
				   	width: '99%',
				   	//height:'800px',
				   	data: function(){
				   		var rtn = $.extend(true,{},dataHostinfo.rtn.left);
	            		$.each(rtn.series.series,function(i,s){
	            			$.each(s.data,function(j,d){
	            				d['z'] = d['LATENCY_MAX_AVG'];
	            			});
	            		});
	            		return rtn;
				   	},
				   	options: function(){
				   		var option = {
								chart:{
									type: 'bubble'
									, plotBorderWidth: 1
							        , zoomType: 'xy'
								}
								, legend: {
							        enabled: true
							    }
								, title: {
							        text: ' '
							    },
							    tooltip: {
							        useHTML: true,
							        headerFormat: '<table>',
							        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
	            			            '<tr><th>Latency(max)_avg:</th><td>{point.z}</td></tr>',
							        footerFormat: '</table>',
							        followPointer: true
							    }
								
						};
						
						return option;
					}
				   	
				 },
				 {
						containerCss:[
							//{code: 'display', value:''}
							//,{code: 'float', value:'left'}
							{code: 'height', value:'1000px'}
						],					
						type:'chart',
					   	id: 'Latency_max_avg2',
					   	label:'',
					   	width: '99%',
					   	//height:'800px',
					   	data: function(){
		        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
		            		$.each(rtn.series.series,function(i,s){
		            			$.each(s.data,function(j,d){
		            				d['y'] = d['LATENCY_MAX_AVG'];
		            			});
		            		});
		            		return rtn;
					   	},
					   	options: function(){
					   		var option = {
			          				chart:{
			          					polar: true
			          					, type: 'scatter'
			          			        , zoomType: 'xy'
			          				}
			          				, legend: {
			          			        enabled: true
			          			    }
			          				, title: {
			          			        text: ' '
			          			    }
			          			    ,tooltip: {
			          			        useHTML: true,
			          			        headerFormat: '<table>',
			          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
			          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
			          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
			          			            '<tr><th>Latency(max)_avg:</th><td>{point.y}</td></tr>' ,
			          			        footerFormat: '</table>',
			          			        followPointer: true
			          			    }
			           		}
							
							return option;
						}
					   	
					 }
			]
		};
			
			
	var shemaHostinfoLatencyMaxAvg2 = {
		type:'Vertical',
		label:'',
		elements:[
			{
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
				],					
				type:'chart',
			   	id: 'Latency_max_avg2',
			   	label:'',
			   	width: '99%',
			   	//height:'800px',
			   	data: function(){
        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
            		$.each(rtn.series.series,function(i,s){
            			$.each(s.data,function(j,d){
            				d['y'] = d['LATENCY_MAX_AVG'];
            			});
            		});
            		return rtn;
			   	},
			   	options: function(){
			   		var option = {
	          				chart:{
	          					polar: true
	          					, type: 'scatter'
	          			        , zoomType: 'xy'
	          				}
	          				, legend: {
	          			        enabled: true
	          			    }
	          				, title: {
	          			        text: ' '
	          			    }
	          			    ,tooltip: {
	          			        useHTML: true,
	          			        headerFormat: '<table>',
	          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	          			            '<tr><th>Latency(max)_avg:</th><td>{point.y}</td></tr>' ,
	          			        footerFormat: '</table>',
	          			        followPointer: true
	          			    }
	           		}
					
					return option;
				}
			   	
			 }
		]
	};
	
	var shemaHostinfoLatencyMinAvg1 = {
				type:'Vertical',
				label:'',
				elements:[
					{
						containerCss:[
							//{code: 'display', value:''}
							//,{code: 'float', value:'left'}
							{code: 'height', value:'1000px'}
						],					
						type:'chart',
					   	id: 'Latency_min_avg1',
					   	label:'',
					   	width: '99%',
					   	//height:'800px',
					   	data: function(){
					   		var rtn = $.extend(true,{},dataHostinfo.rtn.left);
		            		$.each(rtn.series.series,function(i,s){
		            			$.each(s.data,function(j,d){
		            				d['z'] = d['LATENCY_MIN_AVG'];
		            			});
		            		});
		            		return rtn;
					   	},
					   	options: function(){
					   		var option = {
									chart:{
										type: 'bubble'
										, plotBorderWidth: 1
								        , zoomType: 'xy'
									}
									, legend: {
								        enabled: true
								    }
									, title: {
								        text: ' '
								    },
								    tooltip: {
								        useHTML: true,
								        headerFormat: '<table>',
								        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
		            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
		            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
		            			            '<tr><th>Latency(min)_avg:</th><td>{point.z}</td></tr>',
								        footerFormat: '</table>',
								        followPointer: true
								    }
									
							};
							
							return option;
						}
					   	
					 },
					 {
							containerCss:[
								//{code: 'display', value:''}
								//,{code: 'float', value:'left'}
								{code: 'height', value:'1000px'}
							],					
							type:'chart',
						   	id: 'Latency_min_avg2',
						   	label:'',
						   	width: '99%',
						   	//height:'800px',
						   	data: function(){
			        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
			            		$.each(rtn.series.series,function(i,s){
			            			$.each(s.data,function(j,d){
			            				d['y'] = d['LATENCY_MIN_AVG'];
			            			});
			            		});
			            		return rtn;
						   	},
						   	options: function(){
						   		var option = {
				          				chart:{
				          					polar: true
				          					, type: 'scatter'
				          			        , zoomType: 'xy'
				          				}
				          				, legend: {
				          			        enabled: true
				          			    }
				          				, title: {
				          			        text: ' '
				          			    }
				          			    ,tooltip: {
				          			        useHTML: true,
				          			        headerFormat: '<table>',
				          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
				          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
				          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
				          			            '<tr><th>Latency(min)_avg:</th><td>{point.y}</td></tr>' ,
				          			        footerFormat: '</table>',
				          			        followPointer: true
				          			    }
				           		}
								
								return option;
							}
						   	
						 }
				]
			};
				
				
	var shemaHostinfoLatencyMinAvg2 = {
		type:'Vertical',
		label:'',
		elements:[
			{
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
				],					
				type:'chart',
			   	id: 'Latency_min_avg2',
			   	label:'',
			   	width: '99%',
			   	//height:'800px',
			   	data: function(){
        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
            		$.each(rtn.series.series,function(i,s){
            			$.each(s.data,function(j,d){
            				d['y'] = d['LATENCY_MIN_AVG'];
            			});
            		});
            		return rtn;
			   	},
			   	options: function(){
			   		var option = {
	          				chart:{
	          					polar: true
	          					, type: 'scatter'
	          			        , zoomType: 'xy'
	          				}
	          				, legend: {
	          			        enabled: true
	          			    }
	          				, title: {
	          			        text: ' '
	          			    }
	          			    ,tooltip: {
	          			        useHTML: true,
	          			        headerFormat: '<table>',
	          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	          			            '<tr><th>Latency(min)_avg:</th><td>{point.y}</td></tr>' ,
	          			        footerFormat: '</table>',
	          			        followPointer: true
	          			    }
	           		}
					
					return option;
				}
			   	
			 }
		]
	};
	
	var shemaHostinfoLatencyMaxTot1 = {
			type:'Vertical',
			label:'',
			elements:[
				{
					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
					],					
					type:'chart',
				   	id: 'Latency_max_tot1',
				   	label:'',
				   	width: '99%',
				   	//height:'800px',
				   	data: function(){
				   		var rtn = $.extend(true,{},dataHostinfo.rtn.left);
	            		$.each(rtn.series.series,function(i,s){
	            			$.each(s.data,function(j,d){
	            				d['z'] = d['LATENCY_MAX_TOT'];
	            			});
	            		});
	            		return rtn;
				   	},
				   	options: function(){
				   		var option = {
								chart:{
									type: 'bubble'
									, plotBorderWidth: 1
							        , zoomType: 'xy'
								}
								, legend: {
							        enabled: true
							    }
								, title: {
							        text: ' '
							    },
							    tooltip: {
							        useHTML: true,
							        headerFormat: '<table>',
							        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
	            			            '<tr><th>Latency(max)_tot:</th><td>{point.z}</td></tr>',
							        footerFormat: '</table>',
							        followPointer: true
							    }
								
						};
						
						return option;
					}
				   	
				 },
				 {
						containerCss:[
							//{code: 'display', value:''}
							//,{code: 'float', value:'left'}
							{code: 'height', value:'1000px'}
						],					
						type:'chart',
					   	id: 'Latency_max_tot2',
					   	label:'',
					   	width: '99%',
					   	//height:'800px',
					   	data: function(){
		        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
		            		$.each(rtn.series.series,function(i,s){
		            			$.each(s.data,function(j,d){
		            				d['y'] = d['LATENCY_MAX_TOT'];
		            			});
		            		});
		            		return rtn;
					   	},
					   	options: function(){
					   		var option = {
			          				chart:{
			          					polar: true
			          					, type: 'scatter'
			          			        , zoomType: 'xy'
			          				}
			          				, legend: {
			          			        enabled: true
			          			    }
			          				, title: {
			          			        text: ' '
			          			    }
			          			    ,tooltip: {
			          			        useHTML: true,
			          			        headerFormat: '<table>',
			          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
			          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
			          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
			          			            '<tr><th>Latency(max)_tot:</th><td>{point.y}</td></tr>' ,
			          			        footerFormat: '</table>',
			          			        followPointer: true
			          			    }
			           		}
							
							return option;
						}
					   	
					 }
			]
		};
			
					
	var shemaHostinfoLatencyMaxTot2 = {
		type:'Vertical',
		label:'',
		elements:[
			{
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
				],					
				type:'chart',
			   	id: 'Latency_max_tot2',
			   	label:'',
			   	width: '99%',
			   	//height:'800px',
			   	data: function(){
        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
            		$.each(rtn.series.series,function(i,s){
            			$.each(s.data,function(j,d){
            				d['y'] = d['LATENCY_MAX_TOT'];
            			});
            		});
            		return rtn;
			   	},
			   	options: function(){
			   		var option = {
	          				chart:{
	          					polar: true
	          					, type: 'scatter'
	          			        , zoomType: 'xy'
	          				}
	          				, legend: {
	          			        enabled: true
	          			    }
	          				, title: {
	          			        text: ' '
	          			    }
	          			    ,tooltip: {
	          			        useHTML: true,
	          			        headerFormat: '<table>',
	          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	          			            '<tr><th>Latency(max)_tot:</th><td>{point.y}</td></tr>' ,
	          			        footerFormat: '</table>',
	          			        followPointer: true
	          			    }
	           		}
					
					return option;
				}
			   	
			 }
		]
	};
	
	var shemaHostinfoLatencyMinTot1 = {
			type:'Vertical',
			label:'',
			elements:[
				{
					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
					],					
					type:'chart',
				   	id: 'Latency_min_tot1',
				   	label:'',
				   	width: '99%',
				   	//height:'800px',
				   	data: function(){
				   		var rtn = $.extend(true,{},dataHostinfo.rtn.left);
	            		$.each(rtn.series.series,function(i,s){
	            			$.each(s.data,function(j,d){
	            				d['z'] = d['LATENCY_MIN_TOT'];
	            			});
	            		});
	            		return rtn;
				   	},
				   	options: function(){
				   		var option = {
								chart:{
									type: 'bubble'
									, plotBorderWidth: 1
							        , zoomType: 'xy'
								}
								, legend: {
							        enabled: true
							    }
								, title: {
							        text: ' '
							    },
							    tooltip: {
							        useHTML: true,
							        headerFormat: '<table>',
							        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	            			            '<tr><th>Command:</th><td>{point.ID}: {point.COMMAND}</td></tr>' +
	            			            '<tr><th>Latency(min)_tot:</th><td>{point.z}</td></tr>',
							        footerFormat: '</table>',
							        followPointer: true
							    }
								
						};
						
						return option;
					}
				   	
				 },
				 {
						containerCss:[
							//{code: 'display', value:''}
							//,{code: 'float', value:'left'}
							{code: 'height', value:'1000px'}
						],					
						type:'chart',
					   	id: 'Latency_min_tot2',
					   	label:'',
					   	width: '99%',
					   	//height:'800px',
					   	data: function(){
		        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
		            		$.each(rtn.series.series,function(i,s){
		            			$.each(s.data,function(j,d){
		            				d['y'] = d['LATENCY_MIN_TOT'];
		            			});
		            		});
		            		return rtn;
					   	},
					   	options: function(){
					   		var option = {
			          				chart:{
			          					polar: true
			          					, type: 'scatter'
			          			        , zoomType: 'xy'
			          				}
			          				, legend: {
			          			        enabled: true
			          			    }
			          				, title: {
			          			        text: ' '
			          			    }
			          			    ,tooltip: {
			          			        useHTML: true,
			          			        headerFormat: '<table>',
			          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
			          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
			          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
			          			            '<tr><th>Latency(min)_tot:</th><td>{point.y}</td></tr>' ,
			          			        footerFormat: '</table>',
			          			        followPointer: true
			          			    }
			           		}
							
							return option;
						}
					   	
					 }
			]
		};
			
		
	var shemaHostinfoLatencyMinTot2 = {
		type:'Vertical',
		label:'',
		elements:[
			{
				containerCss:[
					//{code: 'display', value:''}
					//,{code: 'float', value:'left'}
					{code: 'height', value:'1000px'}
				],					
				type:'chart',
			   	id: 'Latency_min_tot2',
			   	label:'',
			   	width: '99%',
			   	//height:'800px',
			   	data: function(){
        			var rtn = $.extend(true,{},dataHostinfo.rtn.right);
            		$.each(rtn.series.series,function(i,s){
            			$.each(s.data,function(j,d){
            				d['y'] = d['LATENCY_MIN_TOT'];
            			});
            		});
            		return rtn;
			   	},
			   	options: function(){
			   		var option = {
	          				chart:{
	          					polar: true
	          					, type: 'scatter'
	          			        , zoomType: 'xy'
	          				}
	          				, legend: {
	          			        enabled: true
	          			    }
	          				, title: {
	          			        text: ' '
	          			    }
	          			    ,tooltip: {
	          			        useHTML: true,
	          			        headerFormat: '<table>',
	          			      pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	          			            '<tr><th>Command:</th><td>{point.COMMAND}</td></tr>'  +
	          			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	          			            '<tr><th>Latency(min)_tot:</th><td>{point.y}</td></tr>' ,
	          			        footerFormat: '</table>',
	          			        followPointer: true
	          			    }
	           		}
					
					return option;
				}
			   	
			 }
		]
	};

	var schemaPecount = {
			containerId:'contentPecount',
			type:'HorizontalLayout',
			label:'',
			elements:[ 
				{
					containerCss:[
						{code: 'display', value:''}
						,{code: 'float', value:'left'}
						,{code: 'height', value:'1000px'}
					],					
					type:'chart',
   	            	id: 'pecount1',
   	            	label:'',
   	            	width: '49%',
   	            	//height:'800px',
   	            	data: function(){
   	            	// searchGrid에서 선택된 folder
	            		var theGrid = $("#searchGridTable");
	        			var selIds = theGrid.jqGrid('getGridParam','selarrrow');
	        			var row = theGrid.jqGrid('getRowData',selIds[0]);
	        			
	            		var param = {
	            				
	            		};
	            		
	            		var rtn = {};
	            		$.ajax({
	                		url: "/dashboard/regressionTabViewPecountJson.do",
	                		data: param, 
	                		async: false,
	                		success:  function(response){
	                			dataPecount.dataList = response.dataList;
	                			rtn.dataList = response.dataList;
	                		}
	                	});
	            		
	            		var series = getDrillDownDataSeries2(
	            				'',
	            				dataPecount.dataList ,
	            				['SLOTNAME'] , //groupby
	            				[], //filter
	            				[{col: 'AVG' , convert:'z',isnull:0}], //convert
	            				'TESTNAME' ,  //category
	            				'CNT',
	            				{cd:'SLOTNAME', name:'SLOTNAME'},
	            				{isGroupby: false}
	            		);
	            		
	            		//////////// xcategory?
	            		var xAxis = {
           			    	gridLineWidth: 1,
           			        title: {
           			            text: 'test name'
           			        }
//            			        ,labels: {
//            			            format: '{value}'
//            			        }
							,labels:{
								formatter:	function(){
									//var aaa = "";
									//console.log(arguments);
									if (typeof this.value == "string")
										return this.value;
								}
							}
           			        //,type:'category'
           			    };
	            		
	            		var xCategories = alasql('select distinct mysplit(TESTNAME,"_") as testname , TESTNAME as testnamefull from ?  order by 1' , [dataPecount.dataList]);	  
	            		xCategories = _.map(xCategories,function(m,i){
	            			return {idx:i ,testname:m.testname, testnamefull: m.testnamefull};
	            		});
	            		
	            		var xCategories1 =  _.pluck(xCategories,'testname');
	            		xAxis.categories = xCategories1;
	            		xAxis.categoriesOrigine = xCategories;
	            		dataPecount.xAxis = xAxis;
	            		rtn.xAxis = xAxis;
	            		
	            			// 각 데이타에 xCategories 를 지정한다.
	            			$.each(series.series, function(i,s){
	            				$.each(s.data,function(j,d){
	            					var  targetCategory = alasql('select idx from ? where testnamefull = "' + d.TESTNAME  + '"', [xCategories]);
	            					if(targetCategory.length > 0)
	            						d.x = targetCategory[0].idx;
	            				});
	            			});
	            		
	            		//////////// ycategory?
	            		var yAxis =  {
           			        startOnTick: false,
           			        endOnTick: false,
           			        title: {
           			            text: 'group name'
           			        }
           			        ,labels: {
           			            format: '{value}'
           			        }
           			    };   	            		
	            		var yCategories = alasql('select distinct GROUP_NAME group_name from ?  order by 1' , [dataPecount.dataList]);	  
	            		yCategories = _.map(yCategories,function(m,i){
	            			return {idx:i , group_name: m.group_name };
	            		});
	            		
	            		var yCategories1 =  _.pluck(yCategories,'group_name');
	            		yAxis.categories = yCategories1;
	            		yAxis.categoriesOrigine = yCategories;
	            		rtn.yAxis = yAxis;
	            		dataPecount.yAxis = yAxis;
	            		
	            			// 각 데이타에 xCategories 를 지정한다.
	            			$.each(series.series, function(i,s){
	            				$.each(s.data,function(j,d){
	            					var  targetCategory = alasql('select idx from ? where group_name = "' + d.GROUP_NAME  + '" ', [yCategories]);
	            					if(targetCategory.length > 0)
	            						d.y = targetCategory[0].idx;
	            				});
	            			});
	            		
	            			    	            		
	            		// category end
	            		
	            		// return start
	            		rtn.series = series;
	            		dataPecount.series = series;
	            		
	            		return rtn;
   	            	},
   	            	options: function(){
   	            		var option = {
	            				chart:{
	            					type: 'bubble'
	            					, plotBorderWidth: 1
	            			        , zoomType: 'xy'
	            				}
	            				, legend: {
	            			        enabled: true
	            			    }
	            				, title: {
	            			        text: ' '
	            			    },
	            			    tooltip: {
	            			        useHTML: true,
	            			        headerFormat: '<table>',
	            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
	            			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
	            			            '<tr><th>group name:</th><td>{point.ID}: {point.GROUP_NAME}</td></tr>' +
										'<tr><th>min:</th><td>{point.ID}: {point.MIN}</td></tr>' +
										'<tr><th>max:</th><td>{point.ID}: {point.MAX}</td></tr>' +
	            			            '<tr><th>avg:</th><td>{point.z}</td></tr>',
	            			        footerFormat: '</table>',
	            			        followPointer: true
	            			    }
	            				
	            		};
	            		
	            		return option;
	            	}
   	            	
   	            }
				,{
					type: 'Vertical',
					label: '',	
					width:'49%',
					elements:[
						{	
							
							containerCss:[
								{code: 'height', value:'1000px'}
							],					
							type:'chart',
	    	            	id: 'pecount2',
	    	            	label:'',
	    	            	width: '99%',
	    	            	//height:'430px',
	    	            	data: function(){
    	            			var rtn = {};
    		            		
    		            		var series = getDrillDownDataSeries2(
    		            				'',
    		            				dataPecount.dataList ,
    		            				['SLOTNAME','GROUP_NAME','TESTNAME'] , //groupby
    		            				[], //filter
    		            				[{col: 'AVG' , convert:'y',isnull:0}], //convert
    		            				'GROUP_NAME' ,  //category
    		            				'CNT',
    		            				{cd:'SLOTNAME', name:'SLOTNAME'},
    		            				{isGroupby: false}
    		            		);
	    		            		
    		            		//////////// xcategory?
    		            		var xAxis = {
    	           			    
    		            		};
	    		            		
    		            		var xCategories = alasql('select distinct GROUP_NAME id , GROUP_NAME name, TESTNAME testname from ?  order by 1 , 3' , [dataPecount.dataList]);
    		            		xCategories = _.map(xCategories,function(m,i){
    		            			return {
    		            				idx:i , 
    		            				attribute_id: m.id, 
    		            				attribute_name: m.name,
    		            				testname: m.testname
    		            				};
    		            			
    		            		});
    		            		
    		            		var xTickPositions = [];
    		            		var pre = '';
    		            		var cur = '';
    		            		//xTickPositions.push(0);
    		            		$.each(xCategories, function(i,c){
    		            			cur = c.attribute_id;
    		            			//if(i == 0)
    		            			//	xTickPositions.push(c.idx);
    		            			if(i > 0 && pre != cur)
    		            				xTickPositions.push(c.idx - 1);
    		            			pre = c.attribute_id;
    		            		} );
    		            		xTickPositions.push(xCategories.length -1);
    		            		xAxis.tickPositions = xTickPositions;
	    		            		
    		            		var xCategories1 = _.pluck(xCategories,'attribute_id');
    		            		xAxis.categories = xCategories1;
    		            		xAxis.categoriesOrigine = xCategories;
    		            		rtn.xAxis = xAxis;
    		            		
    		            			// 각 데이타에 xCategories 를 지정한다.
    		            			$.each(series.series, function(i,s){
    		            				$.each(s.data,function(j,d){
    		            					var  targetCategory = alasql('select idx from ? where attribute_id = "' + d.GROUP_NAME  + '" and testname="'+ d.TESTNAME+'"	', [xCategories]);
    		            					if(targetCategory.length > 0)
    		            						d.x = targetCategory[0].idx;
    		            				});
    		            			});
    		            			
    		            		
    		            		// return start
    		            		rtn.series = series;
    		            		return rtn;
	    	            	},
	    	            	options: function(){
	    	            		var option = {
	    	            				chart:{
	    	            					polar: true
	    	            					, type: 'scatter'
	    	            			        , zoomType: 'xy'
	    	            				}
	    	            				, legend: {
	    	            			        enabled: true
	    	            			    }
	    	            				, title: {
	    	            			        text: ' '
	    	            			    }
	    	            			    ,tooltip: {
	    	            			        useHTML: true,
	    	            			        headerFormat: '<table>',
	    	            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
	    	            			            '<tr><th>group_name:</th><td>{point.GROUP_NAME}</td></tr>'  +
	    	            			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
												'<tr><th>min:</th><td>{point.MIN}</td></tr>' +
												'<tr><th>max:</th><td>{point.MAX}</td></tr>' +
	    	            			            '<tr><th>avg:</th><td>{point.y}</td></tr>' ,
	    	            			        footerFormat: '</table>',
	    	            			        followPointer: true
	    	            			    }
	    	            				
	    	            		};
	    	            		
	    	            		return option;
	    	            	}
	    	            		
	    	            }
						
					]
				}
			]								
	};
	
	
	var schemaPecount1 = {
			containerId:'contentPecount',
			type:'Vertical',
			label:'By Average',
			elements:[ 
				{
					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
						,{code: 'width', value:'100%'}
					],					
					type:'chart',
   	            	id: 'pecount1',
   	            	label:'',
   	            	width: '100%',
   	            	//height:'800px',
   	            	data: function(){
   	            	// searchGrid에서 선택된 folder
	            		var theGrid = $("#searchGridTable");
	        			var selIds = theGrid.jqGrid('getGridParam','selarrrow');
	        			var row = theGrid.jqGrid('getRowData',selIds[0]);
	        			
	        			var paramObj = {
            				folderNames :[],
            				selectedPoints :[]
            		};
            		var param = "";
            		$.each(selIds,function(i,s){
            			var row = theGrid.jqGrid('getRowData',s);
            			if(i > 0)
            				param +="&";
            			param += "folderName="+ row.FOLDER_NAME;
            			paramObj.folderNames.push(row.FOLDER_NAME);
            		});
            		
            		var chartPoints = $("#testNameRangeContainer").highcharts();
            		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
            		if(chartPoints != undefined){
            			$.each( chartPoints.getSelectedPoints(),function(){
	            			paramObj.selectedPoints.push(this.options);
	            		});
            		}
	            		
	            		var rtn = {};
	            		$.ajax({
	                		type: "POST",
                        url: "/dashboard/regressionTabViewPecountJson.do",
	                		data: {searchJson: JSON.stringify(paramObj)}, 
	                		async: false,
	                		success:  function(response){
	                			dataPecount.dataList = response.dataList;
	                			rtn.dataList = response.dataList;
	                			
	                			if(alasql.tables.pecount == undefined && response.dataList.length> 0 ){
	                				var v_sql = 'create table pecount(';
	                    			var i = 0;
	                    			$.each(response.dataList[0],function(k,v){
	                    				if(i > 0)
	                    					v_sql += ',';
	                    				v_sql += k + ' ' + typeof v;
	            						i += 1;
	                    			});
	                    			v_sql += ')';
	                    			alasql(v_sql);
	                			}
	                			
	                			alasql.tables['pecount'].data = dataPecount.dataList;	
	                			alasql('create index idx_TESTNAME_GROUPNAME on pecount(TESTNAME,GROUP_NAME)');
	                			
	                		}
	                	});
	            		
	            		var series = {series: []};
	            		var chart_param = {
	            				dataSrc: dataPecount.dataList ,
	            				sorts: ['GROUP_NAME','TESTNAME'] ,
	            				seriesKey: {cd:'GROUP_NAME', name:'GROUP_NAME'},
	            				seriesIndex:{sql:'create index idx_GROUPNAME on pecount(GROUP_NAME)', index : 'idx_GROUPNAME'},
	            				//filters: [] ,
	            				convertDefiines: [{col: 'Average' , convert:'y',isnull:0}] ,
	            				xCategoryCol : 'TESTNAME',
	            				xCategoryAddIfEmpty: true ,
	            				xCategoryIndex :'idx_TESTNAME_GROUPNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
	            				xCategoryIndicate: false,
	            				//xCategoryIndicateIndex :'idx_TESTNAME', //xCategoryIndicate 가 true인경우. x축 에서 x축을 지정하는 경우 필요한 index. 
	            				//yCategoryCol : 'COMMAND',
	            				yCategoryIndicate: false,
	            				isGroupby : false,
	            				tablename : 'pecount'
	            		};
	            		var series1 = makeDataForChart(chart_param);
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
	            		
						var series2 = $.extend(true,{},series1);
						$.each(series2.series,function(i,s){
	            			$.each(s.data,function(j,d){
	            				d['low'] = d['MIN'];
	            				d['high'] = d['MAX'];
	            			});
	            		});
	            		
	            		
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
           			    	gridLineWidth: 1,
           			        title: {
           			            text: 'test name'
           			        }
//            			        ,labels: {
//            			            format: '{value}'
//            			        }
							,labels:{
								formatter:	function(){
									//var aaa = "";
									//console.log(arguments);
									if (typeof this.value == "string")
										return this.value;
								}
							}
           			        //,type:'category'
           			    };
	            		
	             		xAxis.categories = _.map(series1.category.x1,function(x,i){
	             			var rtn = "";
	         		 		var matches = x.match(/(^[0-9]+)_\[([\w]+)\]_(.+$)?/i);
		         				if(matches != null){
		         					rtn = matches[1]+ '_' + matches[3];
		         				}else{
		         					rtn = x;
		         				}
		         				return rtn;
		         		});
	         			xAxis.categoriesOrigine = series1.category.x;
	            		rtn.xAxis = xAxis;
	            		//////////// ycategory?
	            		
	            		
	            			    	            		
	            		// category end
	            		
	            		// return start
	            		rtn.series = series;
	            		dataPecount.series = series;
	            		
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
// 	            			        useHTML: true,
	            			        headerFormat: '',
// 	            			        pointFormat: '<tr><th>slot name:</th><td>{series.name}</td</tr>' +
// 	            			            '<tr><th>test name:</th><td>{point.TESTNAME}</td></tr>' +
// 	            			            '<tr><th>group name:</th><td>{point.ID}: {point.GROUP_NAME}</td></tr>' +
// 										'<tr><th>min:</th><td>{point.MIN}</td></tr>' +
// 										'<tr><th>max:</th><td>{point.MAX}</td></tr>' +
// 	            			            '<tr><th>avg:</th><td>{point.y}</td></tr>',
// 	            			        footerFormat: '</table>',
									pointFormatter: function(){
										if(this.series.type=='line'){
											var rtn = '';
											rtn += '<br><b>Slot Name:</b>' + this.SLOTNAME ;
											rtn += '<br><b>Test Name:</b>' + this.TESTNAME ;
											rtn += '<br><b>Group Name:</b>' + this.GROUP_NAME;
											rtn += '<br><b>Average:</b>' + Highcharts.numberFormat(this.Average ,0,'.',',') ;
											rtn +=  '<br><b>Min:</b> ' +  Highcharts.numberFormat(this.MIN ,0,'.',',');
											rtn +=  '<br><b>Max:</b> ' + Highcharts.numberFormat(this.MAX ,0,'.',',');
											return rtn;
										}else if(this.series.type == 'arearange'){
											var rtn = '';
											
											rtn += '<br><b>Slot Name:</b>' + this.SLOTNAME ;
											rtn += '<br><b>Test Name:</b>' + this.TESTNAME ;
											rtn += '<br><b>Group Name:</b>' + this.GROUP_NAME;
											rtn += '<br><b>Average:</b>' + Highcharts.numberFormat(this.Average ,0,'.',',') ;
											rtn +=  '<br><b>Min:</b> ' +  Highcharts.numberFormat(this.MIN ,0,'.',',');
											rtn +=  '<br><b>Max:</b> ' + Highcharts.numberFormat(this.MAX ,0,'.',',');
												
											return rtn;
										}
									},
	            			        followPointer: true
	            			    }
	            				
	            		};
	            		
	            		return option;
	            	}
   	            	
   	            }
				,{

					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
						,{code: 'width', value:'99%'}
					],			
			    	type:'grid',
			    	id: 'grid_pecount',
			    	label:'Pecount List',
			    	data: function(){ 
			    		var datalist = [];
			    		var theGrid = $("#searchGridTable");
			    		var selIds = theGrid.jqGrid('getGridParam','selarrrow');
			    		var row = theGrid.jqGrid('getRowData',selIds[0]);
			    		
			    		var paramObj = {
            				folderNames :[],
            				selectedPoints :[]
            		};
            		var param = "";
            		$.each(selIds,function(i,s){
            			var row = theGrid.jqGrid('getRowData',s);
            			if(i > 0)
            				param +="&";
            			param += "folderName="+ row.FOLDER_NAME;
            			paramObj.folderNames.push(row.FOLDER_NAME);
            		});
            		
            		var chartPoints = $("#testNameRangeContainer").highcharts();
            		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
            		if(chartPoints != undefined){
            			$.each( chartPoints.getSelectedPoints(),function(){
	            			paramObj.selectedPoints.push(this.options);
	            		});
            		}
                  
			    		$.ajax({
			    			type: "POST",
                     url: "/dashboard/genericlListJson.do",
			    			data: {searchJson: JSON.stringify(paramObj),sqlid:'dashboard.regresson.pecountlist.raw' }, 
			    			async: false,
			    			success:  function(response){
			    				datalist  = response.dataList;
			    				//dataPecount.grid = {dataList:[],searchoptions:{firmware:{value:""}}};
			    				//dataPecount.grid.dataList = datalist;
			    			}
			    		});
			    		return datalist;
			    	},
			    	items:[
						{label:'Folder Name',name:'FOLDER_NAME', id:'FOLDER_NAME',width: 150
							,stype: "select"
							, searchoptions: gridSearchOption.foldername
						},
						{label:'Pjt Code',name:'PJT_CODE', id:'PJT_CODE',width: 90},
						{label:'Pjt Name',name:'PJT_NAME_PMS', id:'PJT_NAME_PMS',width: 200},
						{label:'Firmware',name:'FIRMWARE', id:'FIRMWARE',width: 130
							, stype: "select"
							, searchoptions: gridSearchOption.firmware 
						},
						{label:'Revision',name:'REVISION', id:'REVISION',width: 70},
						{label:'Test Name',name:'TESTNAME', id:'TESTNAME',width: 270 
							, stype: "select"
							, searchoptions: gridSearchOption.testname 
						},
						{label:'Slot Name',name:'SLOTNAME', id:'SLOTNAME',width: 100
							, stype: "select"
							, searchoptions: gridSearchOption.slotname 
						},
						{label:'Group Name',name:'GROUP_NAME', id:'GROUP_NAME',width: 100},
						{label:'Min',name:'MIN', id:'MIN',sorttype: 'number',  formatter:'number', align:'right',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 0,}, width: 110 ,
							searchoptions : {
	                            // show search options
	                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
							}	
						},
						{label:'Max',name:'MAX', id:'MAX', sorttype: 'number', formatter:'number', align:'right',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 0},width: 110 ,
							searchoptions : {
	                            // show search options
	                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
							}		
						},
						{label:'Average',name:'AVERAGE', id:'AVERAGE',sorttype: 'number',  formatter:'number', align:'right',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 0},width: 110, 
							searchoptions : {
	                            // show search options
	                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
							}	
						}
						
						
						
			    	],
			    	gridOpt:{
			    		datatype:'local',
			    		pager: "#grid_pecountPager",
			    		viewrecords: true,
			    		width: '100%',
			    		height: '100%',
			    		sortable: true,
			    		multiSort:true,
			    		sortname: 'FIRMWARE, TESTNAME, SLOTNAME',
			    		rowNum: 20,
						rowList:[10,20,30,50,100],
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
	
	
	var schemaErrorlog = {
			containerId:'contentErrorlog',
			type:'Vertical',
			label:'By last test time',
			elements:[ 
				{
					containerCss:[
						//{code: 'display', value:''},
						//{code: 'float', value:'left'},
						{code: 'height', value:'1000px'}
					],					
					type:'chart',
   	            	id: 'Errorlog1',
   	            	label:'',
   	            	width: '99%',
   	            	//height:'800px',
   	            	data: function(){
   	            	// searchGrid에서 선택된 folder
	            		var theGrid = $("#searchGridTable");
	        			var selIds = theGrid.jqGrid('getGridParam','selarrrow');
	        			var row = theGrid.jqGrid('getRowData',selIds[0]);
	        			
	        			var paramObj = {
	            				folderNames :[],
	            				selectedPoints :[]
	            		};
	            		var param = "";
	            		$.each(selIds,function(i,s){
	            			var row = theGrid.jqGrid('getRowData',s);
	            			if(i > 0)
	            				param +="&";
	            			param += "folderName="+ row.FOLDER_NAME;
	            			paramObj.folderNames.push(row.FOLDER_NAME);
	            		});
	            		
	            		var chartPoints = $("#testNameRangeContainer").highcharts();
	            		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
	            		if(chartPoints != undefined){
	            			$.each( chartPoints.getSelectedPoints(),function(){
		            			paramObj.selectedPoints.push(this.options);
		            		});
	            		}
	            		
	            		var rtn = {series:[]};
	            		$.ajax({
	                		type: "POST",
                        url: "/dashboard/regressionTabViewErrologJson.do",
	                		data: {searchJson: JSON.stringify(paramObj)}, 
	                		async: false,
	                		success:  function(response){
	                			dataErrorlog.dataList = response.dataList;
	                			rtn.dataList = response.dataList;
	                			
	                			if(alasql.tables.errorlog == undefined && response.dataList.length > 0){
	                				var v_sql = 'create table errorlog(';
	                    			var i = 0;
	                    			$.each(response.dataList[0],function(k,v){
	                    				if(i > 0)
	                    					v_sql += ',';
	                    				v_sql += k + ' ' + typeof v;
	            						i += 1;
	                    			});
	                    			v_sql += ')';
	                    			alasql(v_sql);
	                			}
	                			
                           if(response.dataList.length > 0){
                              alasql.tables['errorlog'].data = dataErrorlog.dataList;	
   	                			alasql('create index idx_TESTNAME_SLOTNAME on errorlog(TESTNAME,SLOTNAME)');
   	                			alasql('create index idx_TESTNAME on errorlog(TESTNAME)');
                           }
	                			
	                			
	                		}
	                	});
	            		if(dataErrorlog.dataList.length == 0 )
	            			return rtn;
	            		var chart_param = {
	            				dataSrc: dataErrorlog.dataList ,
	            				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
	            				seriesIndex:{sql:'create index idx_SLOTNAME on errorlog(SLOTNAME)', index : 'idx_SLOTNAME'},
	            				//filters: [] ,
	            				convertDefiines: [{col: 'CNT' , convert:'z',isnull:0}] ,
	            				xCategoryCol : 'TESTNAME',
	            				xCategoryAddIfEmpty: false ,
	            				xCategoryIndex :'idx_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
	            				xCategoryIndicate: true,
	            				xCategoryIndicateIndex :'idx_TESTNAME', //xCategoryIndicate 가 true인경우. x축 에서 x축을 지정하는 경우 필요한 index. 
	            				yCategoryCol : 'ERROR_TYPE',
	            				yCategoryIndicate: true,
	            				isGroupby : false,
	            				tablename : 'errorlog'
	            		};
	            		var series = makeDataForChart(chart_param);
	            		$.each(series.series, function(){
	            			this.connectNulls =  true;
	            			this.minSize = "4";
	            			this.maxSize = "50";
	            		});
	            		
	            		//////////// xcategory?
	            		var xAxis = {
           			    	gridLineWidth: 1,
           			        title: {
           			            text: 'test name'
           			        }
//            			        ,labels: {
//            			            format: '{value}'
//            			        }
							,labels:{
								formatter:	function(){
									//var aaa = "";
									//console.log(arguments);
									if (typeof this.value == "string")
										return this.value;
								}
							}
           			        //,type:'category'
           			    };
	            		
	            		xAxis.categories = _.map(series.category.x1,function(x,i){
	             			var rtn = "";
	         		 		var matches = x.match(/(^[0-9]+)_\[([\w]+)\]_(.+$)?/i);
		         				if(matches != null){
		         					rtn = matches[1]+ '_' + matches[3];
		         				}else{
		         					rtn = x;
		         				}
		         				return rtn;
		         		});
	         			xAxis.categoriesOrigine = series.category.x;
	         			rtn.xAxis = xAxis;
	            		//////////// ycategory?
	            		var yAxis =  {
           			        startOnTick: false,
           			        endOnTick: false,
           			        title: {
           			            text: 'Error Type'
           			        }
           			        ,labels: {
           			            format: '{value}'
           			        }
           			    };   	 
	            		
            			yAxis.categories = series.category.y1;
            			yAxis.categoriesOrigine =  series.category.y;
            			
            			rtn.yAxis = yAxis;
            			dataHostinfo.yAxis = yAxis;	    	            		
	            		// category end
	            		
	            		// return start
	            		rtn.series = series;
	            		dataErrorlog.series = series;
	            		
	            		return rtn;
   	            	},
   	            	options: function(){
   	            		var option = {
	            				chart:{
	            					type: 'bubble'
	            					, plotBorderWidth: 1
	            			        , zoomType: 'xy'
	            				}
	            				, legend: {
	            			        enabled: true
	            			    }
	            				, title: {
	            			        text: ' '
	            			    },
	            			    tooltip: {
	            			        useHTML: true,
	            			        headerFormat: '<table>',
	            			        pointFormat:'<tr><th>Slot Name:</th><td>{series.name}</td</tr>' +
            			        		'<tr><th>Folder Name:</th><td>{point.FOLDER_NAME}</td></tr>' +
            			           	 	'<tr><th>Test Name:</th><td>{point.TESTNAME}</td></tr>' +
            			            	'<tr><th>Start Time:</th><td>{point.START_TIME_STR}</td></tr>' +
	            			            '<tr><th>Error Type:</th><td>{point.ID}: {point.ERROR_TYPE}</td></tr>' +
	            			            '<tr><th>Count:</th><td>{point.z}</td></tr>',
	            			        footerFormat: '</table>',
	            			        followPointer: true
	            			    }
	            				
	            		};
	            		
	            		return option;
	            	}
   	            	
   	            }
				,{	
					containerCss:[
						{code: 'height', value:'1000px'}
					],					
					type:'chart',
   	            	id: 'Errorlog2',
   	            	label:'',
   	            	width: '99%',
   	            	//height:'430px',
   	            	data: function(){
  	            			var rtn = {series:[]};
  		            		
                        if(dataErrorlog.dataList.length == 0 )
	            			  return rtn;
  	            			var chart_param = {
  		            				dataSrc: dataErrorlog.dataList ,
  		            				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
  		            				seriesIndex:{sql:'create index idx_SLOTNAME on errorlog(SLOTNAME)', index : 'idx_SLOTNAME'},
  		            				//filters: [] ,
  		            				convertDefiines: [{col: 'CNT' , convert:'y',isnull:0}] ,
  		            				xCategoryCol : 'ERRORTYPE_TESTNAME',
  		            				xCategoryAddIfEmpty: false ,
  		            				xCategoryIndex :'idx_ERRORTYPE_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
  		            				xCategoryIndicate: true,
  		            				//yCategoryCol : 'ERROR_TYPE',
  		            				yCategoryIndicate: false,
  		            				isGroupby : false,
  		            				tablename : 'errorlog'
  		            		};
  	            			var series = makeDataForChart(chart_param);
   		            		
  		            		//////////// xcategory?
  		            		var xAxis = {};
   		            		
  		            		xAxis.categories = _.map(series.category.x1,function(m,i){
  		            			return m.split("`")[0];
  		            		});
  		            		xAxis.categoriesOrigine = series.category.x;
  		            		
  		            		var xTickPositions = [];
  		            		var pre = '';
  		            		var cur = '';
  		            		$.each(series.category.x, function(i,c){
  		            			var gubun = c.ERRORTYPE_TESTNAME.split("`")[0];
  		            			cur = gubun;
  		            			if(i == 0)
  		            				xTickPositions.push(c.idx);
  		            			if(i > 0 && pre != cur)
  		            				xTickPositions.push(c.idx);
  		            			pre = gubun;
  		            		});
  		            		xAxis.tickPositions = xTickPositions;
  		            		rtn.xAxis = xAxis;
  		            		
  		            		// return start
  		            		rtn.series = series;
  		            		return rtn;
   	            	},
   	            	options: function(){
   	            		var option = {
   	            				chart:{
   	            					polar: true
   	            					, type: 'scatter'
   	            			        , zoomType: 'xy'
   	            				}
   	            				, legend: {
   	            			        enabled: true
   	            			    }
   	            				, title: {
   	            			        text: ' '
   	            			    }
   	            			    ,tooltip: {
   	            			        useHTML: true,
   	            			        headerFormat: '<table>',
   	            			        pointFormat:'<tr><th>Slot Name:</th><td>{series.name}</td</tr>' +
           			        			'<tr><th>Folder Name:</th><td>{point.FOLDER_NAME}</td></tr>' +
           			           	 		'<tr><th>Test Name:</th><td>{point.TESTNAME}</td></tr>' +
           			            		'<tr><th>Start Time:</th><td>{point.START_TIME_STR}</td></tr>' +
            			            	'<tr><th>Error Type:</th><td>{point.ID}: {point.ERROR_TYPE}</td></tr>' +						
   	            			            '<tr><th>Count:</th><td>{point.y}</td></tr>' ,
   	            			        footerFormat: '</table>',
   	            			        followPointer: true
   	            			    }
   	            				
   	            		};
   	            		
   	            		return option;
   	            	}
   	            		
   	            }
				,{

					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
						,{code: 'width', value:'99%'}
					],			
			    	type:'grid',
			    	id: 'grid_errorlog',
			    	label:'Error log List',
			    	data: function(){ 
			    		var datalist = [];
			    		var theGrid = $("#searchGridTable");
			    		var selIds = theGrid.jqGrid('getGridParam','selarrrow');
			    		var row = theGrid.jqGrid('getRowData',selIds[0]);
			    		
			    		var paramObj = {
	            				folderNames :[],
	            				selectedPoints :[]
	            		};
	            		var param = "";
	            		$.each(selIds,function(i,s){
	            			var row = theGrid.jqGrid('getRowData',s);
	            			if(i > 0)
	            				param +="&";
	            			param += "folderName="+ row.FOLDER_NAME;
	            			paramObj.folderNames.push(row.FOLDER_NAME);
	            		});
	            		
	            		var chartPoints = $("#testNameRangeContainer").highcharts();
	            		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
	            		if(chartPoints != undefined){
	            			$.each( chartPoints.getSelectedPoints(),function(){
		            			paramObj.selectedPoints.push(this.options);
		            		});
	            		}
                     
			    		$.ajax({
			    			type: "POST",
                     url: "/dashboard/genericlListJson.do",
			    			data:  {searchJson: JSON.stringify(paramObj), sqlid: 'dashboard.regresson.errologlist.raw' }, 
			    			async: false,
			    			success:  function(response){
			    				datalist  = response.dataList;
			    				//dataPecount.grid = {dataList:[],searchoptions:{firmware:{value:""}}};
			    				//dataPecount.grid.dataList = datalist;
			    			}
			    		});
			    		return datalist;
			    	},
			    	items:[
						{label:'Folder Name',name:'FOLDER_NAME', id:'FOLDER_NAME',width: 150
							,stype: "select"
							, searchoptions: gridSearchOption.foldername
						},
						{label:'Pjt Code',name:'PJT_CODE', id:'PJT_CODE',width: 90},
						{label:'Pjt Name',name:'PJT_NAME_PMS', id:'PJT_NAME_PMS',width: 200},
						{label:'Firmware',name:'FIRMWARE', id:'FIRMWARE',width: 120
							, stype: "select"
							, searchoptions: gridSearchOption.firmware 
						},
						{label:'Revision',name:'REVISION', id:'REVISION',width: 70},
						{label:'Test Name',name:'TESTNAME', id:'TESTNAME',width: 270 
							, stype: "select"
							, searchoptions: gridSearchOption.testname 
						},
						{label:'Slot Name',name:'SLOTNAME', id:'SLOTNAME',width: 100
							, stype: "select"
							, searchoptions: gridSearchOption.slotname 
						},
						{label:'Start Time',name:'START_TIME_STR', id:'START_TIME_STR',align:'center', width: 130},
						{label:'Error Type',name:'ERROR_TYPE', id:'ERROR_TYPE',align:'center', width: 100},
						{label:'Block',name:'BLOCK', id:'BLOCK',align:'center', width: 100},
						{label:'Status',name:'STATUS', id:'STATUS',align:'center', width: 100},
						{label:'Channel',name:'CHANNEL', id:'CHANNEL',align:'center', width: 100},
						{label:'Die',name:'DIE', id:'DIE',align:'center', width: 100},
						{label:'ISRType',name:'ISRTYPE', id:'ISRTYPE',align:'center', width: 100},
						{label:'Page',name:'PAGE', id:'PAGE',align:'center', width: 100}
						
			    	],
			    	gridOpt:{
			    		datatype:'local',
			    		pager: "#grid_errorlogPager",
			    		viewrecords: true,
			    		width: '100%',
			    		height: '100%',
			    		sortable: true,
			    		multiSort:true,
			    		sortname: 'FIRMWARE, TESTNAME, SLOTNAME',
			    		rowNum: 20,
						rowList:[10,20,30,50,100],
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
	
	var schemaMain = {
			containerId:'contentMain',
			type:'HorizontalLayout',
			label:'',
			elements:[ 
				{
					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
						,{code: 'width', value:'100%'}
					],					
					type:'chart',
   	            	id: 'main',
   	            	label:'',
   	            	width: '99%',
   	            	//height:'800px',
      	            data: function(){
      	            	// searchGrid에서 선택된 folder
   	            		var theGrid = $("#searchGridTable");
   	        			   var selIds = theGrid.jqGrid('getGridParam','selarrrow');
   	        			   var row = theGrid.jqGrid('getRowData',selIds[0]);
   	        			
   	        			   var paramObj = {
   	            				folderNames :[],
   	            				selectedPoints :[]
   	            		};
   	            		var param = "";
   	            		$.each(selIds,function(i,s){
   	            			var row = theGrid.jqGrid('getRowData',s);
   	            			if(i > 0)
   	            				param +="&";
   	            			param += "folderName="+ row.FOLDER_NAME;
   	            			paramObj.folderNames.push(row.FOLDER_NAME);
   	            		});
   	            		
   	            		var chartPoints = $("#testNameRangeContainer").highcharts();
   	            		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
   	            		if(chartPoints != undefined){
   	            			$.each( chartPoints.getSelectedPoints(),function(){
   		            			paramObj.selectedPoints.push(this.options);
   		            		});
   	            		}
   	            		
   	            		var rtn = {series:[]};
   	            		$.ajax({
   	            			type: "POST",
   	                		url: "/dashboard/regressionTabViewMainJson.do",
   	                		data: {searchJson: JSON.stringify(paramObj)}, 
   	                		async: false,
   	                		success:  function(response){
   	                			dataMain.dataList = response.dataList;
   	                			rtn.dataList = response.dataList;
   	                		}
   	                	});
   	            		
   	            		$.each(dataMain.dataList, function(){
   	            			var duration = this.DURATION;
   	            			var dSplit = duration.split(":");
   // 	            			var hh = Number(dSplit[0])*60*60;
   // 	            			var mm = Number(dSplit[1])*60;
   // 	            			var ss = Number(dSplit[2]);
   // 	            			var duration_ss = hh + mm + ss;
   	            			
   	            			var hh = Number(dSplit[0]);
   	            			var mm = Number(dSplit[1])/60;
   	            			var ss = Number(dSplit[2])/60/60;
   	            			var duration_ss = hh + mm + ss;
   	            			
   	            			this.duration_ss = duration_ss;
   	            			//this.duration_ss = 0;
   	            			
   	            			var dateSplit = this.START_TIME.split("/");
   	            			var utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2],dateSplit[3],dateSplit[4],dateSplit[5]);
   	            			this.startTimeUtc = utcdt;	   
   // 	            			this.marker = {
   // 	            				width: duration_ss	
   // 	            			};
   	            		});
   	            		
   	            		if(alasql.tables.main == undefined && dataMain.dataList.length > 0 ){
               				var v_sql = 'create table main(';
                   			var i = 0;
                   			$.each(dataMain.dataList[0],function(k,v){
                   				if(i > 0)
                   					v_sql += ',';
                   				v_sql += k + ' ' + typeof v;
           						i += 1;
                   			});
                   			v_sql += ')';
                   			alasql(v_sql);
               			}
   	            		
   	            		if(dataMain.dataList.length == 0 )
   	            			return rtn;
   	            			
   	            		
   	            		alasql.tables['main'].data = dataMain.dataList;	
               			alasql('create index idx_CATEGORY_SLOTNAME on main(CATEGORY,SLOTNAME)');
   	            		
               			var chart_param = {
   	            				dataSrc: dataMain.dataList ,
   	            				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
   	            				seriesIndex:{sql:'create index idx_SLOTNAME on main(SLOTNAME)', index : 'idx_SLOTNAME'},
   	            				//filters: [] ,
   	            				convertDefiines: [{col: 'startTimeUtc' , convert:'y'},{col: 'duration_ss' , convert:'z'}] ,
   	            				xCategoryCol : 'CATEGORY',
   	            				xCategoryAddIfEmpty: false ,
   	            				//xCategoryIndex :'idx_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
   	            				xCategoryIndicate: true,
   	            				//yCategoryCol : 'ID',
   	            				yCategoryIndicate: false,
   	            				isGroupby : false,
   	            				tablename : 'main'
   	            		};
   	            		var series = makeDataForChart(chart_param);
   	            		
   	            		$.each(series.series, function(){
   	            			this.connectNulls =  true;
   	            			this.minSize = "3";
   	            			this.maxSize = "20";
   	            		});
   	            		//////////// xcategory?
   	            		var xAxis = {};
   	            		xAxis.categories =	 series.category.x1;
   	            		xAxis.categoriesOrigine = series.category.x;
   	            		
   	            		xAxis.tickAmount =  series.category.x1.length;
   	            		rtn.xAxis = xAxis;
   	            			
   	            		var yAxis =  {
   	            				type: 'datetime'	
   	            				,labels:{
   	            		            formatter:function(){
   	            		                return Highcharts.dateFormat('%Y:%m:%d:%H:%M:%S', this.value);
   	            		            }
   	            				}
   	            		};
   	            		rtn.yAxis = yAxis;
   	            		dataMain.yAxis = yAxis;
   	            		
   	            		// return start
   	            		rtn.series = series;
   	            		return rtn;
   	            	},
   	            	options: function(){
   	            		var option = {
	            				chart:{
	            					polar: true,
	            					type: 'bubble',
	            			        zoomType: 'xy'
	            				}
	            				, legend: {
	            			        enabled: true
	            			    }
	            				, title: {
	            			        text: ' '
	            			    }
	            			    ,tooltip: {
	            			        useHTML: true,
	            			        headerFormat: '<table>',
	            			        pointFormat: '<tr><th>Slot name:</th><td>{series.name}</td</tr>' +
	            			            '<tr><th>Category:</th><td>{point.CATEGORY}</td></tr>'  +
	            			            '<tr><th>Test name:</th><td>{point.TESTNAME}</td></tr>' +
	            			            '<tr><th>Start time:</th><td>{point.START_TIME_STR}</td></tr>' +
	            			            '<tr><th>Duration:</th><td>{point.DURATION}</td></tr>' ,
// 	 								pointFormat:'{point.y:%Y:%m:%d:%H:%M:%S}',	            			            
	            			        footerFormat: '</table>',
	            			        followPointer: true
	            			    }
	            				
	            		};
	            		
	            		return option;
	            	}
   	            	
   	            }
				,{
					containerCss:[
						//{code: 'display', value:''}
						//,{code: 'float', value:'left'}
						{code: 'height', value:'1000px'}
						,{code: 'width', value:'99%'}
					],			
			    	type:'grid',
			    	id: 'grid_main',
			    	label:'Main List',
			    	data: function(){ 
                  		var dataList = [];
            		                  // searchGrid에서 선택된 folder
            			var theGrid = $("#searchGridTable");
        			   	var selIds = theGrid.jqGrid('getGridParam','selarrrow');
        			   	var row = theGrid.jqGrid('getRowData',selIds[0]);
        			
        			   	var paramObj = {
	            				folderNames :[],
	            				selectedPoints :[]
	            		};
	            		var param = "";
	            		$.each(selIds,function(i,s){
	            			var row = theGrid.jqGrid('getRowData',s);
	            			if(i > 0)
	            				param +="&";
	            			param += "folderName="+ row.FOLDER_NAME;
	            			paramObj.folderNames.push(row.FOLDER_NAME);
	            		});
	            		
	            		var chartPoints = $("#testNameRangeContainer").highcharts();
	            		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
	            		if(chartPoints != undefined){
	            			$.each( chartPoints.getSelectedPoints(),function(){
		            			paramObj.selectedPoints.push(this.options);
		            		});
	            		}
	            		
	            		var rtn = {series:[]};
	            		$.ajax({
	            			type: "POST",
	                		url: "/dashboard/genericlListJson.do",
	                		data: {searchJson: JSON.stringify(paramObj), ignoreTime: "Y", sqlid: "dashboard.regresson.mainlist.all" }, 
	                		async: false,
	                		success:  function(response){
	                			dataList = response.dataList;
	                		}
	                	});

                  		$.each(dataList, function(){
			            	var duration = this.DURATION;
		                    if( duration == undefined){
		                       return true;
		                    }
		        			var dSplit = duration.split(":");
		        			
		        			var hh = Number(dSplit[0]);
		        			var mm = Number(dSplit[1])/60;
		        			var ss = Number(dSplit[2])/60/60;
		        			var duration_ss = hh + mm + ss;
		        			
		        			this.duration_ss = duration_ss;
			            			
		                    if( this.START_TIME == undefined){
		                       return true;
		                    }
	                    
	            			var dateSplit = this.START_TIME.split("/");
	            			var utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2],dateSplit[3],dateSplit[4],dateSplit[5]);
	            			this.startTimeUtc = utcdt;	   
		            	});
                  
                		return dataList;
               
               		},
			    	items:[
						
						{label:'Firmware',name:'FIRMWARE', id:'FIRMWARE',width: 130
							//, stype: "select"
							//, searchoptions: gridSearchOption.firmware 
						},
						{label:'Revision',name:'REVISION', id:'REVISION',width: 70},
						{label:'Pjt Code',name:'PJT_CODE', id:'PJT_CODE',width: 90},
						{label:'Pjt Name',name:'PJT_NAME_PMS', id:'PJT_NAME_PMS',width: 200},
						{label:'Folder Name',name:'FOLDER_NAME', id:'FOLDER_NAME',width: 150
							//,stype: "select"
							//, searchoptions: gridSearchOption.foldername
						},
						
						{label:'Slot Name',name:'SLOTNAME', id:'SLOTNAME',width: 100
							//, stype: "select"
							//, searchoptions: gridSearchOption.slotname 
						},
						{label:'No',name:'LINE_NO', id:'LINE_NO',sorttype:'number',align:'center', search: false,width: 60},
						{label:'Category',name:'CATEGORY', id:'CATEGORY',width: 90 },
	              		{label:'Test Name',name:'TESTNAME_FULL', id:'TESTNAME_FULL',width: 270 
							//, stype: "select"
							//, searchoptions: gridSearchOption.testname 
						},
						{label:'Status',name:'STATUS', id:'STATUS',width: 70 },
						{label:'Error Message',name:'ERROR_MESSAGE', id:'ERROR_MESSAGE' ,width: 120},
						{label:'Comment',name:'COMMENT', id:'COMMENT' ,width: 80},
						{label:'Start time',name:'START_TIME_STR', id:'START_TIME_STR',width: 150 },
						{label:'Duration',name:'DURATION', id:'DURATION' ,width: 70}, 
						{label:'Duration/s',name:'duration_ss', id:'duration_ss' ,width: 70
							,sorttype: 'number',  formatter:'number', align:'right',formatoptions:{decimalSeparator:".", thousandsSeparator: ",", decimalPlaces: 3}
							,searchoptions : {
	                            // show search options
	                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
							}	
						}, 
						{label:'Parameters',name:'PARAMETERS', id:'PARAMETERS',width: 80 }
						
			    	],
			    	gridOpt:{
			    		datatype:'local',
			    		pager: "#grid_mainPager",
			    		viewrecords: true,
			    		width: '100%',
			    		height: '100%',
			    		sortable: true,
			    		multiSort:true,
		    		   sortname: 'FIRMWARE, PJT_CODE, FOLDER_NAME, LINE_NO,TESTNAME_FULL',
			    		rowNum: 20, 
						rowList:[10,20,30,50,100],
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
	
	
	
	var shemaTestnameSelector = {
			containerId:'testnameSelector',
			type:'Vertical',
			label:'',
			elements:[ 
				{
					containerCss:[
						//{code: 'display', value:''},
						//,{code: 'float', value:'left'},
						{code: 'height', value:'400px'}
					],					
					type:'chart',
   	            	id: 'testNameRange',
   	            	label:'',
   	            	width: '100%',
   	            	//height:'800px',
   	            	data: function(){
   	            	// searchGrid에서 선택된 folder
	            		var theGrid = $("#searchGridTable");
	        			var selIds = theGrid.jqGrid('getGridParam','selarrrow');
	        			var row = theGrid.jqGrid('getRowData',selIds[0]);
	        			
	        			var param = "";
	            		$.each(selIds,function(i,s){
	            			var row = theGrid.jqGrid('getRowData',s);
	            			if(i > 0)
	            				param +="&";
	            			param += "folderName="+ row.FOLDER_NAME;
	            		});
	            		param += "&sqlid=dashboard.regression.meta.testname.range";
	            		
	            		var rtn = {series:[]};
	            		$.ajax({
	                		url: "/dashboard/genericlListJson.do",
	                		data: param, 
	                		async: false,
	                		success:  function(response){
	                			rtn.dataList = response.dataList;
	                		}
	                	});
	            		
	            		$.each(rtn.dataList, function(){
	            			var duration = this.DURATION;
	            			var dSplit = duration.split(":");
// 	            			var hh = Number(dSplit[0])*60*60;
// 	            			var mm = Number(dSplit[1])*60;
// 	            			var ss = Number(dSplit[2]);
// 	            			var duration_ss = hh + mm + ss;
	            			
	            			var hh = Number(dSplit[0]);
	            			var mm = Number(dSplit[1])/60;
	            			var ss = Number(dSplit[2])/60/60;
	            			var duration_ss = hh + mm + ss;
	            			
	            			this.duration_ss = duration_ss;
	            			//this.duration_ss = 0;
	            			
	            			var dateSplit = this.START_TIME.split("/");
	            			var utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2],dateSplit[3],dateSplit[4],dateSplit[5]);
	            			this.startTimeUtc = utcdt;	   
// 	            			this.marker = {
// 	            				width: duration_ss	
// 	            			};
	            		});
	            		
	            		
	            		if(alasql.tables.range_testname == undefined && rtn.dataList.length > 0 ){
            				var v_sql = 'create table range_testname(';
                			var i = 0;
                			$.each(rtn.dataList[0],function(k,v){
                				if(i > 0)
                					v_sql += ',';
                				v_sql += k + ' ' + typeof v;
        						i += 1;
                			});
                			v_sql += ')';
                			alasql(v_sql);
            			}
	            		
	            		if(rtn.dataList.length == 0 )
	            			return rtn;
	            		
	            		alasql.tables['range_testname'].data = rtn.dataList;	
            			alasql('create index idx_CATEGORY_SLOTNAME on range_testname(CATEGORY,SLOTNAME)');
            			
	            		var chart_param = {
	            				dataSrc: rtn.dataList ,
	            				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
	            				seriesIndex:{sql:'create index idx_SLOTNAME on range_testname(SLOTNAME)', index : 'idx_SLOTNAME'},
	            				//filters: [] ,
	            				convertDefiines: [{col: 'startTimeUtc' , convert:'x'},{col: 'duration_ss' , convert:'y'}] ,
	            				//xCategoryCol : 'CATEGORY',
	            				//xCategoryAddIfEmpty: false ,
	            				//xCategoryIndex :'idx_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
	            				xCategoryIndicate: false,
	            				//yCategoryCol : 'ID',
	            				yCategoryIndicate: false,
	            				isGroupby : false,
	            				tablename : 'range_testname'
	            		};
	            		var series = makeDataForChart(chart_param);
	            		rtn.series = series;
	            		var xAxis =  {
	            				type: 'datetime'	
	            				,labels:{
	            		            formatter:function(){
	            		                return Highcharts.dateFormat('%Y:%m:%d:%H:%M:%S', this.value);
	            		            }
	            				}
	            		};
	            		rtn.xAxis = xAxis;
	            		return rtn;
   	            	},
   	            	options: function(){
   	            		var option = {
	            				
   	            				chart:{
	            					type: 'scatter'
	            					, plotBorderWidth: 1
	            			        , zoomType: 'xy'
            			        	, events: {
            			                selection: selectPointsByDrag,
            			                selectedpoints: selectedPoints,
            			                click: unselectByClick
            			            }
	            				}
   	            				, yAxis: {
   	            					title: {
   	            			            text: 'Duration'
   	            			        }
   	            				}
	            				, legend: {
	            			        enabled: true
	            			    }
	            				, title: {
	            			        text: 'Select Test Name By Drag '
	            			    },
	            			    tooltip: {
	            			        useHTML: true,
	            			        headerFormat: '<table>',
	            			        pointFormat: '<tr><th>Slot Name:</th><td>{series.name}</td</tr>' +
	            			        	'<tr><th>Folder Name:</th><td>{point.FOLDER_NAME}</td></tr>' +
	            			        	'<tr><th>Category:</th><td>{point.CATEGORY}</td></tr>'  +	
	            			            '<tr><th>Test Name:</th><td>{point.TESTNAME}</td></tr>' +
	            			            '<tr><th>Start Time:</th><td>{point.START_TIME_STR}</td></tr>' ,
	            			        footerFormat: '</table>',
	            			        followPointer: true
	            			    }
	            				
	            		};
	            		
	            		return option;
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
	<script type="text/javascript" id="script_main">
	
	
	
	$(function () {
		
		createDB();
		makeHtml('searchCondition',schemaSearch);
		gridInit();
		getGridData();
		$( window ).resize(function() {
			//console.log("aaaaa");
		});
	});
	
	function makeSearchOption(){
		var theGrid = $("#searchGridTable");
		var selIds = theGrid.jqGrid('getGridParam','selarrrow');
		var row = theGrid.jqGrid('getRowData',selIds[0]);
		
		var param = "";
		$.each(selIds,function(i,s){
			var row = theGrid.jqGrid('getRowData',s);
			if(i > 0)
				param +="&";
			param += "folderName="+ row.FOLDER_NAME;
		});
		//search option
//		$.ajax({
//    		url: "/dashboard/genericlListJson.do",
//    		data: param + "&sqlid=dashboard.regresson.distinct.field&field=FOLDER_NAME", 
//    		async: false,
//    		success:  function(response){
//    			gridSearchOption.foldername.value = ":[ALL]";
//    			$.each(response.dataList,function(i,m){
//    				gridSearchOption.foldername.value += ";"+ m.col + ":" +m.col; 
//				});
//    		}
//    	});
		
//		$.ajax({
//    		url: "/dashboard/genericlListJson.do",
//    		data: param + "&sqlid=dashboard.regresson.distinct.field&field=FIRMWARE", 
//    		async: false,
//    		success:  function(response){
//    			gridSearchOption.firmware.value = ":[ALL]";
//    			$.each(response.dataList,function(i,m){
//    				gridSearchOption.firmware.value += ";"+ m.col + ":" +m.col; 
//				});
//    		}
//    	});
		
//		$.ajax({
//    		url: "/dashboard/genericlListJson.do",
//    		data: param + "&sqlid=dashboard.regresson.distinct.field&field=TESTNAME", 
//    		async: false,
//    		success:  function(response){
//    			gridSearchOption.testname.value = ":[ALL]";
//    			$.each(response.dataList,function(i,m){
//    				gridSearchOption.testname.value += ";"+ m.col + ":" +m.col; 
//				});
//    		}
//    	});
		
//		$.ajax({
//    		url: "/dashboard/genericlListJson.do",
//    		data: param + "&sqlid=dashboard.regresson.distinct.field&field=SLOTNAME", 
//    		async: false,
//    		success:  function(response){
//    			gridSearchOption.slotname.value = ":[ALL]";
//    			$.each(response.dataList,function(i,m){
//    				gridSearchOption.slotname.value += ";"+ m.col + ":" +m.col; 
//				});
//    		}
//    	});
		// search option end
	}
	
	function createDB(){
		//alasql('create table smart(DATA_SRC string , FIELD string, MEASURE string ,ROWKEY string, ROWVALUE string , SLOTNAME string , TESTNAME string, TOOL string)');
		//alasql('create index idxSmart on smart(FIELD,SLOTNAME,TESTNAME)');
	}
	
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
	
	
	
	function getDataSmart(){
		
		if(!isDataSmart){
			$("#loader").show();
			
			
			setTimeout( function(){
				if (window.console){
					var starttime = new Date();
					console.log('make smart');
					console.log('start time:' + starttime.toString());
				}
				$("#contentSmart").html("");
				makeHtml('contentSmart',schemaSmart1);		
				$("#loader").hide();
				isDataSmart = true;
				
				var containers = $("#contentSmart").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined){
						chart.reflow();
						var line = $("#contentSmart #smart_polarContainer svg .highcharts-grid.highcharts-xaxis-grid .highcharts-grid-line")[0];
						$(line).hide();
					}
						
				});
				
				if (window.console){
					var vEndtime = new Date();
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
		
		
	}
	
	function getDataHostinfo(){
		if(!isDataHostinfo){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('make data contentHostInfo');
					console.log('start time:' + starttime.toString());
				}
				
				//
				makeHostinfo1();
				makeHostinfo2();
				isDataHostinfo = true;
				$("#loader").hide();
				fnChgSystem('tabContainer_host','tabHostInfoCnt1','HostInfoCnt1');
		            
// 	            var plist = [
// 					getDataHostInfoCnt2 
// 					, getDataHostInfoSize1
// 					, getDataHostInfoSize2
// 					, getDataHostInfoLatencyMaxAvg1
// 					, getDataHostInfoLatencyMaxAvg2
// 					, getDataHostInfoLatencyMinAvg1
// 					, getDataHostInfoLatencyMinAvg2
// 					, getDataHostInfoLatencyMaxTot1
// 					, getDataHostInfoLatencyMaxTot2
// 				];
	            
				// 
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
		}
		
	}
	
	
	function getDataHostInfoCnt1(){
		if(!isDataHostInfoCnt1){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoCnt');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoCnt1").html("");
				makeHtml('contentHostInfoCnt1',shemaHostinfoCount1);		
				$("#loader").hide();
				isDataHostInfoCnt1 = true;
				
				var containers = $("#contentHostInfoCnt1").find("[id$=Container]");
				$.each(containers,function(){
					chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
		
		
		
	}
	
	function getDataHostInfoCnt2(){
		if(!isDataHostInfoCnt2){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoCnt2');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoCnt2").html("");
				makeHtml('contentHostInfoCnt2',shemaHostinfoCount2);		
				$("#loader").hide();
				isDataHostInfoCnt2 = true;
				
				var containers = $("#contentHostInfoCnt2").find("[id$=Container]");
				$.each(containers,function(){
					chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
		
		
	}
	
	function getDataHostInfoSize1(){
		if(!isDataHostInfoSize1){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoSize1');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoSize1").html("");
				makeHtml('contentHostInfoSize1',shemaHostinfoSize1);		
				$("#loader").hide();
				isDataHostInfoSize1 = true;
				
				var containers = $("#contentHostInfoSize1").find("[id$=Container]");
				$.each(containers,function(){
					chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	function getDataHostInfoSize2(){
		if(!isDataHostInfoSize2){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoSize2');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoSize2").html("");
				makeHtml('contentHostInfoSize2',shemaHostinfoSize2);		
				$("#loader").hide();
				isDataHostInfoSize2 = true;
				
				var containers = $("#contentHostInfoSize2").find("[id$=Container]");
				$.each(containers,function(){
					chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	function getDataHostInfoLatencyMaxAvg1(){
		if(!isDataHostInfoMaxAvg1){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoLatencyMaxAvg1');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoLatencyMaxAvg1").html("");
				makeHtml('contentHostInfoLatencyMaxAvg1',shemaHostinfoLatencyMaxAvg1);		
				$("#loader").hide();
				isDataHostInfoMaxAvg1 = true;
				
				var containers = $("#contentHostInfoLatencyMaxAvg1").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	function getDataHostInfoLatencyMaxAvg2(){
		if(!isDataHostInfoMaxAvg2){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoLatencyMaxAvg2');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoLatencyMaxAvg2").html("");
				makeHtml('contentHostInfoLatencyMaxAvg2',shemaHostinfoLatencyMaxAvg2);		
				$("#loader").hide();
				isDataHostInfoMaxAvg2 = true;
				
				var containers = $("#contentHostInfoLatencyMaxAvg2").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	function getDataHostInfoLatencyMinAvg1(){
		if(!isDataHostInfoMinAvg1){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoLatencyMinAvg1');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoLatencyMinAvg1").html("");
				makeHtml('contentHostInfoLatencyMinAvg1',shemaHostinfoLatencyMinAvg1);		
				$("#loader").hide();
				isDataHostInfoMinAvg1 = true;
				
				var containers = $("#contentHostInfoLatencyMinAvg1").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	function getDataHostInfoLatencyMinAvg2(){
		if(!isDataHostInfoMinAvg2){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoLatencyMinAvg2');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoLatencyMinAvg2").html("");
				makeHtml('contentHostInfoLatencyMinAvg2',shemaHostinfoLatencyMinAvg2);		
				$("#loader").hide();
				isDataHostInfoMinAvg2 = true;
				
				var containers = $("#contentHostInfoLatencyMinAvg2").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	
	function getDataHostInfoLatencyMaxTot1(){
		if(!isDataHostInfoMaxTot1){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoLatencyMaxTot1');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoLatencyMaxTot1").html("");
				makeHtml('contentHostInfoLatencyMaxTot1',shemaHostinfoLatencyMaxTot1);		
				$("#loader").hide();
				isDataHostInfoMaxTot1 = true;
				
				var containers = $("#contentHostInfoLatencyMaxTot1").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	function getDataHostInfoLatencyMaxTot2(){
		if(!isDataHostInfoMaxTot2){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoLatencyMaxTot2');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoLatencyMaxTot2").html("");
				makeHtml('contentHostInfoLatencyMaxTot2',shemaHostinfoLatencyMaxTot2);		
				$("#loader").hide();
				isDataHostInfoMaxTot2 = true;
				
				var containers = $("#contentHostInfoLatencyMaxTot2").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	
	function getDataHostInfoLatencyMinTot1(){
		if(!isDataHostInfoMinTot1){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoLatencyMinTot1');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoLatencyMinTot1").html("");
				makeHtml('contentHostInfoLatencyMinTot1',shemaHostinfoLatencyMinTot1);		
				$("#loader").hide();
				isDataHostInfoMinTot1 = true;
				
				var containers = $("#contentHostInfoLatencyMinTot1").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	function getDataHostInfoLatencyMinTot2(){
		if(!isDataHostInfoMinTot2){
			$("#loader").show();
			
			setTimeout( function(){
				var starttime = new Date();
				if (window.console){
					console.log('draw chart contentHostInfoLatencyMinTot2');
					console.log('start time:' + starttime.toString());
				}
				$("#contentHostInfoLatencyMinTot2").html("");
				makeHtml('contentHostInfoLatencyMinTot2',shemaHostinfoLatencyMinTot2);		
				$("#loader").hide();
				isDataHostInfoMinTot2 = true;
				
				var containers = $("#contentHostInfoLatencyMinTot2").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
				var vEndtime = new Date();
				if (window.console){
					console.log('end time:' + vEndtime.toString());
					console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
				}
				
			},0);
			
		}
	}
	
	
	
	function getDataPecount(){
		if(!isDataPecount){
			$("#loader").show();
			setTimeout( function(){
				$("#contentPecount").html("");
				makeHtml('contentPecount',schemaPecount1);		
				$("#loader").hide();
				isDataPecount = true;
				
				var containers = $("#contentPecount").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
			},0);
			
		}
	}
	
	function getDataErrorlog(){
		if(!isDataErrorlog){
			$("#loader").show();
			setTimeout( function(){
				$("#contentErrorlog").html("");
				makeHtml('contentErrorlog',schemaErrorlog);		
				$("#loader").hide();
				isDataErrorlog = true;
				
				var containers = $("#contentErrorlog").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined)
						chart.reflow();
				});
				
			},0);
			
		}
		
		var containers = $("#contentErrorlog").find("[id$=Container]");
		$.each(containers,function(){
			var chart = $(this).highcharts();
			if(chart != undefined)
				chart.reflow();
		});
	}
	
	function getDataMain(){
		if(!isDataErrorlog){
			$("#loader").show();
			setTimeout( function(){
				$("#contentMain").html("");
				makeSearchOption();
				makeHtml('contentMain',schemaMain);		
				$("#loader").hide();
				isDataMain = true;
				
				var containers = $("#contentMain").find("[id$=Container]");
				$.each(containers,function(){
					var chart = $(this).highcharts();
					if(chart != undefined){
						chart.reflow();
						var line = $("#contentMain #mainContainer svg .highcharts-grid.highcharts-xaxis-grid .highcharts-grid-line")[0];
						$(line).hide();
					}
						
				});
				
			},0);
			
		}
		
		
	}
	
	function fnChgSystem(div,tab,container){
		
		$("#" +div+" .tab_2depth li").removeClass('on');
		$("#" +div+" .tab_2depth li").addClass('off');
		$("#"+tab).removeClass('off');
		$("#"+tab).addClass('on');
		$("[id^=content]").hide();
		if(container.match(/^Hostinfo[\w]+/i) != null){
			$("#contentHostinfo").attr("ontab_id",container);
			$("#contentHostinfo").show();
		}
		
		$("#content"+container).show();		
		if(container == 'Hostinfo'){
			var cur = $("#contentHostinfo").attr("ontab_id");
			$("#content"+cur).show();
			var chartcontainers = $("#content"+cur).find("[id$=Container]");
			$.each(chartcontainers,function(){
				var chart = $(this).highcharts();
				if(chart != undefined)
					chart.reflow();
			});			
		}
		
		eval('getData' + container+'()');
		var chartcontainers = $("#content"+container).find("[id$=Container]");
		$.each(chartcontainers,function(){
			var chart = $(this).highcharts();
			if(chart != undefined)
				chart.reflow();
		});			
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
	
	
	//여러개의 row를 하나의 row로 합친다.
	/*param:  {
		fieldName :'FIELD',	    	            				
		filter: [{col:'FIELD', val: 'id'}],
		filterCols: ['SLOTNAME','TESTNAME','TOOL','DATA_SRC','ROWVALUE'],
		convertVals: [' value',' name',' normalized'],
		targetColumn : 'MEASURE'
	} */
	function fn_rowToMap(datasrc, param){
		
		/* alasql.tables[param.tablename].deleteall();
		$.each(datasrc,function(i,d){
			alasql.tables[param.tablename].insert(d);	
		}); */
		
		//alasql.tables[param.tablename].data = datasrc;
		//alasql('create index idxSmart on smart(FIELD,SLOTNAME,TESTNAME,TOOL,DATA_SRC,ROWVALUE)');
		if(param.tablename == 'smart'){
			//alasql('create table smart(DATA_SRC string , FIELD string, MEASURE string ,ROWKEY string, ROWVALUE string , SLOTNAME string , TESTNAME string, TOOL string)');
			alasql.tables[param.tablename].data = datasrc;	
			alasql('create index idxSmart on smart(FIELD,SLOTNAME,TESTNAME)');
		}
		//alasql.tables[param.tablename].data = datasrc;	
		
		var rtnObject = {};
		var groupList = dataFilter(datasrc, param.filter);	
		
		var promises = [];
		
		$.each(groupList,function(i,group){
			//setTimeout(function(){
			$.each(param.convertVals,function(ci,col){
				
					var filter = [];
					filter.push({col: param.fieldName ,val: col});
					$.each( param.filterCols,function(c,v){
						filter.push({col: v, val: group[v] });
					});		
					//var targets = dataFilter(datasrc,filter);
					var filterSql = ' where ';
					$.each(filter,function(i,f){
						
						if(i > 0)
							filterSql += ' and ';
						filterSql += f.col + ' = "' + f.val + '"';
					});
					
					//var targets = alasql('select * from ? ' + filterSql ,[datasrc]);
					var sql = 'select * from ' + param.tablename + filterSql;
					var targets = alasql( sql );
					var target = {};
					if(targets.length > 0){
						target = targets[0];
					}else{
						group[col.trim()] = 0;
						return true;
					}
					
					var tval = 0;
					if(target[param.targetColumn] != undefined){
						if($.isNumeric(target[param.targetColumn]))
							tval = Number(target[param.targetColumn]);
						else
							tval = target[param.targetColumn];
						
					}
					group[col.trim()] = tval;
				
					/* group.isDone = 'ok';
					var dones = alasql('select count(*) cnt from ?  where isDone = "ok" ',[groupList]);
					if(dones.length == groupList.length  )
						rtnObject.list  = groupList;
						//rtnObject.list  = rtnList;
						rtnObject.datasrc = datasrc;
						rtnObject.param = param;
						console.log(group);
						return rtnObject ; */
			});
			
			//},500);
		});


// 		var rtnList = $.map(groupList,function(group,i){
	
// 			$.each(param.convertVals,function(ci,col){
				
// 				var filter = [];
// 				filter.push({col: param.fieldName ,val: col});
// 				$.each( param.filterCols,function(c,v){
// 					filter.push({col: v, val: group[v] });
// 				});		
// 				//var targets = dataFilter(datasrc,filter);
// 				var filterSql = 'where ';
// 				$.each(filter,function(i,f){
					
// 					if(i > 0)
// 						filterSql += ' and ';
// 					filterSql += f.col + ' = "' + f.val + '"';
// 				});
				
// 				var targets = alasql('select * from ? ' + filterSql ,[datasrc]);
// 				var target = {};
// 				if(targets.length > 0){
// 					target = targets[0];
// 				}else{
// 					group[col.trim()] = 0;
// 					return true;
// 				}
				
// 				var tval = 0;
// 				if(target[param.targetColumn] != undefined){
// 					if($.isNumeric(target[param.targetColumn]))
// 						tval = Number(target[param.targetColumn]);
// 					else
// 						tval = target[param.targetColumn];
					
// 				}
// 				group[col.trim()] = tval;
				
// 			});
			
// 			return group;
			
// 		});
		
		rtnObject.list  = groupList;
		//rtnObject.list  = rtnList;
		rtnObject.datasrc = datasrc;
		rtnObject.param = param;
		
		return rtnObject ;
		
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
	
	function makeHostinfo1(){
   		// searchGrid에서 선택된 folder
		var theGrid = $("#searchGridTable");
		var selIds = theGrid.jqGrid('getGridParam','selarrrow');
		var row = theGrid.jqGrid('getRowData',selIds[0]);
		
		var paramObj = {
				folderNames :[],
				selectedPoints :[]
		};
		var param = "";
		$.each(selIds,function(i,s){
			var row = theGrid.jqGrid('getRowData',s);
			if(i > 0)
				param +="&";
			param += "folderName="+ row.FOLDER_NAME;
			paramObj.folderNames.push(row.FOLDER_NAME);
		});
		
		var chartPoints = $("#testNameRangeContainer").highcharts();
		//paramObj.selectedPoints = chartPoints.getSelectedPoints();
		if(chartPoints != undefined){
			$.each( chartPoints.getSelectedPoints(),function(){
    			paramObj.selectedPoints.push(this.options);
    		});
		}
		
		var rtn = {series:[]};
		$.ajax({
			type: "POST",
			url: "/dashboard/regressionTabViewHostJson.do",
    		data: {searchJson: JSON.stringify(paramObj)}, 
    		async: false,
    		success:  function(response){
    			dataHostinfo.dataList = response.dataList;
    			rtn.dataList = dataHostinfo.dataList;
    			
    			if(alasql.tables.hostinfo == undefined){
    				var v_sql = 'create table hostinfo(';
        			var i = 0;
        			$.each(response.dataList[0],function(k,v){
        				if(i > 0)
        					v_sql += ',';
        				v_sql += k + ' ' + typeof v;
						i += 1;
        			});
        			v_sql += ')';
        			alasql(v_sql);
    			}
    			alasql.tables['hostinfo'].data = dataHostinfo.dataList;			                			
    			
    			alasql('create index idx_TESTNAME_SLOTNAME on hostinfo(TESTNAME,SLOTNAME)');
    			alasql('create index idx_TESTNAME on hostinfo(TESTNAME)');
    			alasql('create index idx_COMMAND_TESTNAME_SLOTNAME on hostinfo(COMMAND_TESTNAME,SLOTNAME)');
    			//alasql('create index idx_COMMAND_TESTNAME on hostinfo(COMMAND_TESTNAME)');
    		}
    	});
		
		var param_x =  param + '&sqlid=dashboard.regresson.hostlist.x';
		var xCategory = {x:[],x1:[]};
		$.ajax({
			type: "POST",
			url: "/dashboard/genericlListJson.do",
			data: {searchJson: JSON.stringify(paramObj) , sqlid: 'dashboard.regresson.hostlist.x' }, 
			async: false,
			success:  function(response){
				xCategory.x = response.dataList;
				xCategory.x1 = _.pluck(xCategory.x, 'TESTNAME');
				
			}
		});
		
		var param_y =  param + '&sqlid=dashboard.regresson.hostlist.y';
		var yCategory = {y:[],y1:[]};
		$.ajax({
			type: "POST",
			url: "/dashboard/genericlListJson.do",
			data: {searchJson: JSON.stringify(paramObj) , sqlid: 'dashboard.regresson.hostlist.y' }, 
			async: false,
			success:  function(response){
				yCategory.y = response.dataList;
				yCategory.y1 = _.pluck(yCategory.y, 'COMMAND');
				
			}
		});
		
		var chart_param = {
				dataSrc: dataHostinfo.dataList ,
				sorts: ['SLOTNAME','TESTNAME'] ,
				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
				seriesIndex:{sql:'create index idx_SLOTNAME on hostinfo(SLOTNAME)', index : 'idx_SLOTNAME'},
				//filters: [] ,
				convertDefiines: [{col: 'CNT' , convert:'z',isnull:0}] ,
				xCategoryCol : 'TESTNAME',
				xCategoryAddIfEmpty: false ,
				xCategoryIndex :'idx_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
				xCategoryIndicate: true,
				xCategoryIndicateIndex :'idx_TESTNAME', //xCategoryIndicate 가 true인경우. x축 에서 x축을 지정하는 경우 필요한 index. 
				// xCategoryFn: function(rtn){
				// 	var matches = this.TESTNAME.match(/(^[0-9]+)_\[([\w]+)\]_(.+$)?/i);
				// 	if(matches != null){
				// 		rtn.TESTNAME = matches[1]+ '_' + matches[2];
				// 		rtn.TESTNAMEFULL = matches[0]
				// 	}else{
				// 		rtn.TESTNAME = this.TESTNAME;
				// 	}
				// 	return rtn;
				// },
				yCategoryCol : 'COMMAND',
				yCategoryIndicate: true,
				isGroupby : false,
				tablename : 'hostinfo'
		};
		
		var series = makeDataForChart(chart_param);
		
		$.each(series.series, function(){
			this.connectNulls =  true;
			this.minSize = "4";
			this.maxSize = "50";
		});
		
		////////// xcategory
		var xAxis = {
		    	gridLineWidth: 1,
		        title: {
		            text: 'test name'
		        }
//		        ,labels: {
//		            format: '{value}'
//		        }
			,labels:{
				formatter:	function(){
					//var aaa = "";
					//console.log(arguments);
					if (typeof this.value == "string")
						return this.value;
				}
			}
		        //,type:'category'
		    };

		
		//xAxis.categories = series.category.x1;
// 		xAxis.categories = _.map(series.category.x1,function(x,i){
// 			var rtn = "";
// 		 	var matches = x.match(/(^[0-9]+)_\[([\w]+)\]_(.+$)?/i);
// 				if(matches != null){
// 					rtn = matches[1]+ '_' + matches[3];
// 				}else{
// 					rtn = x;
// 				}
// 				return rtn;
// 		});
// 		xAxis.categoriesOrigine = series.category.x;
		
		xAxis.categories = _.map(xCategory.x1,function(x,i){
			var rtn = "";
		 	var matches = x.match(/(^[0-9]+)_\[([\w]+)\]_(.+$)?/i);
			if(matches != null){
				rtn = matches[1]+ '_' + matches[3];
			}else{
				rtn = x;
			}
			return rtn;
		});
		xAxis.categoriesOrigine = xCategory.x;
		
		dataHostinfo.xAxis = xAxis;
		rtn.xAxis = xAxis;
		
		//////////// ycategory
		var yAxis =  {
		        startOnTick: false,
		        endOnTick: false,
		        title: {
		            text: 'command'
		        }
		        ,labels: {
		            format: '{value}'
		        }
		    };   	            		
		
		//yAxis.categories = series.category.y1;
		//yAxis.categoriesOrigine = series.category.y;
		yAxis.categories = yCategory.y1;
		yAxis.categoriesOrigine =  yCategory.y;
		rtn.yAxis = yAxis;
		dataHostinfo.yAxis = yAxis;
		// category end
		
		// return start
		rtn.series = series;
		dataHostinfo.series = series;
		dataHostinfo.rtn = {};
		dataHostinfo.rtn.left = $.extend(true,{},rtn);			            		 
	}
	
	function makeHostinfo2(){
		var rtn = {};
		
		var chart_param = {
				dataSrc: dataHostinfo.dataList ,
				//sorts: ['SLOTNAME','TESTNAME'] ,
				seriesKey: {cd:'SLOTNAME', name:'SLOTNAME'},
				seriesIndex:{sql:'create index idx_SLOTNAME on hostinfo(SLOTNAME)', index : 'idx_SLOTNAME'},
				//filters: [] ,
				convertDefiines: [{col: 'CNT' , convert:'y',isnull:0}] ,
				xCategoryCol : 'COMMAND_TESTNAME',
				xCategoryAddIfEmpty: false ,
				xCategoryIndex :'idx_COMMAND_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
				xCategoryIndicate: true,
				//yCategoryCol : 'COMMAND',
				yCategoryIndicate: false,
				isGroupby : false,
				tablename : 'hostinfo'
		};
		
		var series = makeDataForChart(chart_param);
		
		//////////// xcategory
		var xAxis = {};
		//xAxis.categories = series.category.x1;
		xAxis.categories = _.map(series.category.x1,function(m,i){
			return m.split("`")[0];
		});
		xAxis.categoriesOrigine = series.category.x;
		
		var xTickPositions = [];
		var pre = '';
		var cur = '';
		$.each(series.category.x, function(i,c){
			var command = c.COMMAND_TESTNAME.split("`")[0];
			cur = command;
			if(i == 0)
				xTickPositions.push(c.idx);
			if(i > 0 && pre != cur)
				xTickPositions.push(c.idx);
			pre = command;
		} );
		xAxis.tickPositions = xTickPositions;
		rtn.xAxis = xAxis;	
		
		// return start
		rtn.series = series;
		dataHostinfo.rtn.right = $.extend(true,{},rtn);
	}
	
	
	function chartMake_range(){
		var theGrid = $("#searchGridTable");
		var selIds = theGrid.jqGrid('getGridParam','selarrrow');													
		if(selIds.length == 0){
			alert("select more than one item!");
			return;
		}
		
		$("#loader").show();
		
		setTimeout( function(){
			var starttime = new Date();
			if (window.console){
				console.log('draw chart Range');
				console.log('start time:' + starttime.toString());
			}
			$("#testNameSelector").html("");
			makeHtml('testNameSelector',shemaTestnameSelector);		
			$("#loader").hide();
			
			var containers = $("#testNameSelector").find("[id$=Container]");
			$.each(containers,function(){
				chart = $(this).highcharts();
				if(chart != undefined)
					chart.reflow();
			});
			
			var vEndtime = new Date();
			if (window.console){
				console.log('end time:' + vEndtime.toString());
				console.log('dataLoadingTime:' + (vEndtime.getTime() - starttime.getTime()) );
			}
			
		},0);
	}
	
	
	/**
	 * Display a temporary label on the chart
	 */
	function toast(chart, text) {
	    chart.toast = chart.renderer.label(text, 100, 120)
	        .attr({
	            fill: Highcharts.getOptions().colors[0],
	            padding: 10,
	            r: 5,
	            zIndex: 8
	        })
	        .css({
	            color: '#FFFFFF'
	        })
	        .add();

	    setTimeout(function () {
	        chart.toast.fadeOut();
	    }, 2000);
	    setTimeout(function () {
	        chart.toast = chart.toast.destroy();
	    }, 2500);
	}

	
	function selectPointsByDrag(e) {
	    // Select points
	    Highcharts.each(this.series, function (series) {
	        Highcharts.each(series.points, function (point) {
	            if (point.x >= e.xAxis[0].min && point.x <= e.xAxis[0].max &&
	                    point.y >= e.yAxis[0].min && point.y <= e.yAxis[0].max) {
	                point.select(true, true);
	                
	            }
	        });
	    });

	    // Fire a custom event
	    //Highcharts.fireEvent(this, 'selectedpoints', { points: this.getSelectedPoints() });

	    return false; // Don't zoom
	}

	function selectedPoints(e) {
	    // Show a label
	    toast(this, '<b>' + e.points.length + ' points selected.</b>' +
	        '<br>Click on empty space to deselect.');
	}

	
	function unselectByClick() {
	    var points = this.getSelectedPoints();
	    if (points.length > 0) {
	        Highcharts.each(points, function (point) {
	            point.select(false);
	        });
	    }
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
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<%-- <input type="hidden" id="category" name="category" value="${param.category}"/> --%>
<input type="hidden" id="report" name="report" value="N"/>

<div id="searchCondition"></div>
<div id="searchGrid" style="width:100% ;margin-top: 10px;/* display:inline-block;float:left; */">
	<table id="searchGridTable"></table>
	<div id="searchGridPager"></div>
</div>
<div id="testNameSelector"></div>
<div id="tabContainer" class="tit_btn m_top_10" >
	<ul class="tab_2depth">
		<li class="on" id="tabMain" target="main">
       		<a href="javascript:fnChgSystem('tabContainer','tabMain','Main');" onclick="">Main</a>
       	</li>
       	<li class="off" id="tabSmart" target="smart">
       		<a href="javascript:fnChgSystem('tabContainer','tabSmart','Smart');" onclick="">Smart</a>
       	</li>
       	<li class="off" id="tabHostinfo" target="block">
       		<a href="javascript:fnChgSystem('tabContainer','tabHostinfo','Hostinfo');" onclick="">HostInfo</a>
       	</li>
       	<li class="off" id="tabPecount" target="pecount">
       		<a href="javascript:fnChgSystem('tabContainer','tabPecount','Pecount');" onclick="">PECount</a>
       	</li>
       	<li class="off" id="tabErrorlog" target="errorlog">
       		<a href="javascript:fnChgSystem('tabContainer','tabErrorlog','Errorlog');" onclick="">Error log</a>
       	</li>
	</ul>
</div>
<div id="contentMain" style="margin-top: 10px;width: 100%;display: none;"></div>
<div id="contentSmart" style="margin-top: 10px;width: 100%"></div>
<div id="contentHostinfo" style="margin-top: 10px;width: 100%;display: none;">
	<div id="tabContainer_host" class="tit_btn m_top_10" >
		<ul class="tab_2depth">
			<li class="on" id="tabHostInfoCnt1" target="HostInfoCnt1">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoCnt1','HostInfoCnt1');" onclick="">Count Sum</a>
	       	</li>
	       	<!-- <li class="off" id="tabHostInfoCnt2" target="HostInfoCnt2">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoCnt2','HostInfoCnt2');" onclick="">Count2</a>
	       	</li> -->
	       	<li class="off" id="taHostInfoSize1" target="HostInfoSize1">
	       		<a href="javascript:fnChgSystem('tabContainer_host','taHostInfoSize1','HostInfoSize1');" onclick="">Size Sum</a>
	       	</li>
	       <!-- 	<li class="off" id="tabHostInfoSize2" target="HostInfoSize2">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoSize2','HostInfoSize2');" onclick="">Size2</a>
	       	</li> -->
	       	<li class="off" id="tabHostInfoLatencyMaxAvg1" target="HostInfoLatencyMaxAvg1">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoLatencyMaxAvg1','HostInfoLatencyMaxAvg1');" onclick="">Max Average</a>
	       	</li>
	       	<!-- <li class="off" id="tabHostInfoLatencyMaxAvg2" target="HostInfoLatencyMaxAvg2">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoLatencyMaxAvg2','HostInfoLatencyMaxAvg2');" onclick="">Max Average 2</a>
	       	</li> -->
	       	<li class="off" id="tabHostInfoLatencyMinAvg1" target="HostInfoLatencyMinAvg1">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoLatencyMinAvg1','HostInfoLatencyMinAvg1');" onclick="">Min Average</a>
	       	</li>
	       	<!-- <li class="off" id="tabHostInfoLatencyMinAvg2" target="HostInfoLatencyMinAvg2">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoLatencyMinAvg2','HostInfoLatencyMinAvg2');" onclick="">Min Average</a>
	       	</li> -->
	       	<li class="off" id="tabHostInfoLatencyMaxTot1" target="HostInfoLatencyMaxTot1">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoLatencyMaxTot1','HostInfoLatencyMaxTot1');" onclick="">Max Tot</a>
	       	</li>
	       	<!-- <li class="off" id="tabHostInfoLatencyMaxTot2" target="HostInfoLatencyMaxTot2">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoLatencyMaxTot2','HostInfoLatencyMaxTot2');" onclick="">Max Tot 2</a>
	       	</li> -->
	       	<li class="off" id="tabHostInfoLatencyMinTot1" target="HostInfoLatencyMinTot1">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoLatencyMinTot1','HostInfoLatencyMinTot1');" onclick="">Min Tot</a>
	       	</li>
	       	<!-- <li class="off" id="tabHostInfoLatencyMinTot2" target="HostInfoLatencyMinTot2">
	       		<a href="javascript:fnChgSystem('tabContainer_host','tabHostInfoLatencyMinTot2','HostInfoLatencyMinTot2');" onclick="">Min Tot 2</a>
	       	</li> -->
		</ul>
	</div>
	<div id="contentHostInfoCnt1" style="margin-top: 10px;width: 100%;display: none;"></div>
	<!-- <div id="contentHostInfoCnt2" style="margin-top: 10px;width: 100%;display: none;"></div> -->
	<div id="contentHostInfoSize1" style="margin-top: 10px;width: 100%;display: none;"></div>
	<!-- <div id="contentHostInfoSize2" style="margin-top: 10px;width: 100%;display: none;"></div> -->
	<div id="contentHostInfoLatencyMaxAvg1" style="margin-top: 10px;width: 100%;display: none;"></div>
	<!-- <div id="contentHostInfoLatencyMaxAvg2" style="margin-top: 10px;width: 100%;display: none;"></div> -->
	<div id="contentHostInfoLatencyMinAvg1" style="margin-top: 10px;width: 100%;display: none;"></div>
	<!-- <div id="contentHostInfoLatencyMinAvg2" style="margin-top: 10px;width: 100%;display: none;"></div> -->
	<div id="contentHostInfoLatencyMaxTot1" style="margin-top: 10px;width: 100%;display: none;"></div>
	<!-- <div id="contentHostInfoLatencyMaxTot2" style="margin-top: 10px;width: 100%;display: none;"></div> -->
	<div id="contentHostInfoLatencyMinTot1" style="margin-top: 10px;width: 100%;display: none;"></div>
	<!-- <div id="contentHostInfoLatencyMinTot2" style="margin-top: 10px;width: 100%;display: none;"></div> -->
</div>
<div id="contentPecount" style="margin-top: 10px;width: 100%;display: none;"></div>
<div id="contentErrorlog" style="margin-top: 10px;width: 100%;display: none;"></div>

<div id="loader"></div>
</form>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</body>
 <div id="dialog-confirm"></div>
</html>
