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
										    		url: "/dashboard/pmsModelListJson.do",
										    		data: {}, 
										    		async: false,
										    		success:  function(response){
										    			pmsModels  = response.dataList;				
										    			
										    		}
										    	});
												
												$.ajax({
										    		url: "/dashboard/reliabilityModelListJson.do",
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
										    		url: "/dashboard/reliabilityTestTypeListJson.do?searchProduct=xxx",
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
										    		url: "/dashboard/reliabilityFWVersionListJson.do?searchProduct=xxx&searchTestType=xxx",
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
										    		url: "/dashboard/reliabilityCapacityListJson.do?searchProduct=xxx&searchTestType=xxx&searchFWversion=xxx",
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
	
	var schemaContent = {
			containerId:'contentSmart',
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
			    	label:'Corona Summary',
			    	data: function(){ 
			    		dataList = [];
			    		
			    		$.ajax({
			    			type: "POST",
			    			url: "/dashboard/genericlListJson.do?sqlid=dashboard.corona.summary",
			    			//data: {searchJson: JSON.stringify(paramObj), sqlid: 'dashboard.regresson.smartlist.raw'}, 
			    			data: $("#form").serialize(), 
			    			async: false,
			    			success:  function(response){
			    				dataList  = response.dataList;
			    				
			    			}
			    		});
			    		
			    		$.each(dataList,function(){
			    			
			    			if(this.COMPUTE_CRETERIA == undefined){
			    				this.COMPUTE_CRETERIA  = "";
			    			}
			    			var total = this.TOTAL_COUNT;
			    			var pass = this.PASS_COUNT;
			    			var fail = total - pass;
			    			var progress = pass/total;
			    			var progress1 = progress * 100;
			    			var progress2 = progress1.toFixed(2);
			    			this.progress = progress;
			    			this.progressStr = progress2 + '%' + ' ( ' + pass + ' / ' + total + ' )';
			    			
			    			this.failRateStr = fail + ' / ' + total ;
			    		});
			    		
			    		return dataList;
			    	},
			    	items:[
			    		{label:'sample', name:'SAMPLE', id:'SAMPLE',width: 100, hidden: true, sortable: false
			    			, editable: false
			    			, editrules:{edithidden:true}
			    		},
			    		{label:'firmware', name:'FIRMWARE', id:'FIRMWARE',width: 100, hidden: true, sortable: false
			    			, editable: false
			    			, editrules:{edithidden:true}
			    		},
			    		{label:'Category',name:'CATEGORY', id:'CATEGORY',width: 150 , cellattr: mergeRow , sortable: false
							//,stype: "select"
							//, searchoptions: gridSearchOption.foldername
							, editable: false
							, editrules:{edithidden:true}
						},
			    		{label:'Test Item', name:'TEST_ITEM', id:'TEST_ITEM',width: 100, sortable: false
			    			, editable: false
			    			, editrules:{edithidden:false}
			    		},
						{label:'Test state', name:'testState', id:'testState',width: 100, sortable: false
							,formatter: function (cellvalue,col,row) {
								var total = row.TOTAL_COUNT;
				    			var pass = row.PASS_COUNT;
				    			var fail = total - pass;
				    			var progress = 0;
				    			var progress1 = 0;
				    			var progress2 = "";

								if(pass == 0 && row.COMPUTE_CRETERIA != undefined && row.COMPUTE_CRETERIA != "" && row.COMPUTE_CRETERIA != "normal" ){
									pass = row.COMPUTE_VALUE;
									if(pass != undefined)
										pass = 0;
										
									if(row.COMPUTE_CRETERIA == "hrs"){
										total = 96;										
									}else if(row.COMPUTE_CRETERIA == "sec"){
										total = 86400;	
									}else if(row.COMPUTE_CRETERIA == "step"){
										total = 868;	
									}else if(row.COMPUTE_CRETERIA == "min"){
										total = 10000;	
									}									
								}
								progress = pass/total;
				    			progress1 = progress * 100;
				    			progress2 = progress1.toFixed(2);
				    			
				    			var status = "";
				    			if(progress2 == "100.00")
				    				status = "PASS";
				    			else
				    				status = "On-going";
				    			return status;
	                        }
	                        , editable: false
	                        , editrules:{edithidden:true}
						
						},
						{label:'Total',name:'TOTAL_COUNT', id:'TOTAL_COUNT',width: 110 , sortable: false
							,sorttype: 'number', formatter:'number', align:'right',formatoptions:{decimalSeparator:",", thousandsSeparator: ",", decimalPlaces: 0}
							,searchoptions : {
	                            // show search options
	                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
							}
							, editable: false
							, editrules:{edithidden:true}		
						},
						{label:'Pass',name:'PASS_COUNT', id:'PASS_COUNT',width: 110 , sortable: false
							,sorttype: 'number', formatter:'number', align:'right',formatoptions:{decimalSeparator:",", thousandsSeparator: ",", decimalPlaces: 0}
							,searchoptions : {
	                            // show search options
	                            sopt: ["ge","le","eq"] // ge = greater or equal to, le = less or equal to, eq = equal to  							
							}
							, editable: false
							, editrules:{edithidden:true}		
						},
						{label:'Test progress',name:'progressStr', id:'progressStr', align:'center', width: 110, sortable: false
							,formatter: function (cellvalue,col,row) {
								var total = row.TOTAL_COUNT;
				    			var pass = row.PASS_COUNT;
				    			var fail = total - pass;
				    			var progress = 0;
				    			var progress1 = 0;
				    			var progress2 = "";

								if(pass == 0 && row.COMPUTE_CRETERIA != undefined && row.COMPUTE_CRETERIA != "" && row.COMPUTE_CRETERIA != "normal" ){
									pass = row.COMPUTE_VALUE;
									if(pass == undefined)
										pass = 0;
										
									if(row.COMPUTE_CRETERIA == "hrs"){
										total = 96;										
									}else if(row.COMPUTE_CRETERIA == "sec"){
										total = 86400;	
									}else if(row.COMPUTE_CRETERIA == "step"){
										total = 868;	
									}else if(row.COMPUTE_CRETERIA == "min"){
										total = 10000;	
									}									
								}
								progress = pass/total;
				    			progress1 = progress * 100;
				    			progress2 = progress1.toFixed(2);
								return gradientNumberFormat(progress2, "gradient2", 0, 100, 0, 100);
	                        }
	                        , editrules:{edithidden:true}
						},
						{label:'Fail Rate',name:'failRateStr', id:'failRateStr', align:'center', width: 110, sortable: false
							, editable: false
							, editrules:{edithidden:true}
						},
						{label:'Weight',name:'WEIGHT', id:'WEIGHT', align:'center', width: 60, sortable: false
							, editable: true
							, formatter: 'integer'
						},
						{label:'Creteria',name:'COMPUTE_CRETERIA', id:'COMPUTE_CRETERIA', align:'center', width: 110, sortable: false
							, editable: true
							, edittype: "select"
							, formatter:"select"
							
							, editoptions: {
								value: {
									"":"None",
									"normal":"normal",
									"sec": "sec (Max: 86,400)",
									"step": "step (Max: 868)",
									"min": "min (Max: 10,000)"
								}
							}
												
							//"[Select];normal:normal;sec:sec;step:step;min:min"
						},
// 						{label:'Max Value',name:'MAX_VALUE', id:'MAX_VALUE', align:'center', width: 110
// 							, formatter: 'integer'
// 							, hidden: true							
// 							, editable: true
// 							, editrules:{edithidden:true}
// 							, edittype: 'text'
// 							, editoptions: {
// 								readonly: 'readonly'
// 							}
							
			
// 						},
						{label:'Progress Value',name:'COMPUTE_VALUE', id:'COMPUTE_VALUE', align:'center', width: 110, sortable: false
							, editable: true
							, formatter: 'integer'
						}, 
						{
							label: " ",
							search: false,
							name: "actions",
							align:'center',
							width: 50,
							formatter: "actions",	
							formatoptions: {
		                        keys: true
		                        ,delbutton:false
		                        ,editformbutton: false
		                        ,editOptions: {} // editformbutton 가 true 인경우
		                        ,addOptions: {}
		                        ,delOptions: {}
		                        ,afterSave : function(rowid,res) {
		                        	var grid = $(this).jqGrid();
		                        	var row = grid.jqGrid('getRowData',rowid);
		                        	row.sqlid = "dashboard.corona.testitem.master.update";
		                        	row.origindata = JSON.stringify(beforEditRow);
		                        	
		                        	var response1 = {};
		                        	$.ajax({
			                    		url: "/dashboard/genericSaveJson.do",
			                    		type: "POST",
			                    		data: row, 
			                    		async: false,			                    		
			                    		success:  function(data){
			                    			response1 = data;
			                    			if(response1.result == 'success'){
			                    				msg = "Save Success!";
				                    			$("#dialog-confirm").html(msg);
				                    			$("#dialog-confirm").dialog({
				                    			    resizable: false,
				                    			    modal: true,
				                    			    title: "Success",
				                    			    //height: 200,
				                    			    width: 200,
				                    			    dialogClass: 'no-close',
				                    			    closeOnEscape: false,
				                    			    buttons: [
			                    			              {
			                    			                text: "OK",
			                    			                click: function() {
			                    			                  $( this ).dialog( "close" );
			                    			                  grid.trigger( "reloadGrid" );
			                    			                }
			                    			              }
		                    			            ]
				                    			});
				                    			
				                    			totalProgress();
				                    			  
			                    			}						                    			
			                    		}
			                    	});
		                        	
		                        }
		                        ,afterRestore : function(rowid) {
		                        	
		                        }
		                        ,onEdit :function(rowid,actop){
		                        	var grid = $(this).jqGrid();
		                        	beforEditRow = grid.jqGrid('getRowData',rowid);
		    					}
		                        
		                    } 
		                    
		                	
						}
						
			    	],
			    	gridOpt:{
			    		datatype:'local',
			    		//pager: "#grid_summaryPager",
			    		editurl: '/dashboard/ssdCusDummySaveJson.do',
			    		viewrecords: true,			    		
			    		width: '100%',
			    		height: '100%',
			    		sortable: false,
			    		multiSort:false,
			    		//sortname: 'CATEGORY, TEST_ITEM ',
			    		rowNum: 30,
						rowList:[10,20,30],
			    		//forceFit : false ,
			    		gridComplete: function () {
			    			var grid = $(this).jqGrid();
			    			//$('#testDisksContainer .ui-jqgrid-titlebar').css("background","rgba(245,246,250,0.6)");
			    			
//			    			grid.jqGrid('filterToolbar',
//		    					{
//		    						defaultSearch:'cn' ,
//		    		                // JSON stringify all data from search, including search toolbar operators
//		    		                stringResult: true
//		    		                // instuct the grid toolbar to show the search options
//		    		                ,searchOperators: true
//		    		            }
//		    				);
		    				
		    				// Edit
		    				grid.navGrid('#grid_summaryPager' ,
			                // the buttons to appear on the toolbar of the grid
			                { edit: false, add: false, del: false, search: false, refresh: false, view: false, position: "left", cloneToTop: false  },
			                // options for the Edit Dialog
			                {
			                    editCaption: "The Edit Dialog",
			                    modal: true,
			                    recreateForm: true,
			                    closeAfterEdit: true,
			                    reloadAfterSubmit: false,
								//template: template,
								viewPagerButtons: false,
			                    errorTextFormat: function (data) {
			                        return 'Error: ' + data.responseText
			                    },
			                    onInitializeForm : function(formid){
			                        $(formid).attr('method','POST');
			                        $(formid).attr('action','');
			                        $(formid).attr('enctype','multipart/form-data');
			                        
			                        $(formid).css("font-size","14px");
			                        //$(this).css("font-size","14px");
			                        
			                        
			                    },
							    afterSubmit: function(response, postdata) 
							    { 
							    	
							    	var grid = $(this).jqGrid();
							    	var row = $(this).jqGrid('getRowData',postdata.id);
							    	var formdata = this.ownerDocument.FormPost;
							    	
							    	//전체데이타를 json형태로
							    	var origindata = $(document.createElement("input"));
							    	origindata.attr("type","hidden");
							    	origindata.attr("name","origindata");
							    	origindata.val(JSON.stringify(row));
							    	$(formdata).append(origindata);
							    	
							    	//userId
							    	var userId =  $(document.createElement("input"));
			                    	userId.attr("type","hidden");
			                    	userId.attr("name","userId");
			                    	userId.val($("#userId").val());
			                    	$(formdata).append(userId);
			                    	
			                    	//sqlid
							    	var sqlid =  $(document.createElement("input"));
			                    	sqlid.attr("type","hidden");
			                    	sqlid.attr("name","sqlid");
			                    	sqlid.val("dashboard.corona.testitem.master.update");
			                    	$(formdata).append(sqlid);
							    	
			                    	var fd = new FormData(formdata);  	
			                    	var response1 = {};
			                    	$.ajax({
			                    		url: "/dashboard/genericSaveJson.do",
			                    		type: "POST",
			                    		data: fd, 
			                    		async: false,
			                    		cache: false,
			                    		contentType: false,
			                    		processData: false,
			                    		success:  function(data){
			                    			response1 = data;
			                    			if(response1.result == 'success'){
			                    				msg = "Save Success!";
				                    			$("#dialog-confirm").html(msg);
				                    			$("#dialog-confirm").dialog({
				                    			    resizable: false,
				                    			    modal: true,
				                    			    title: "Success",
				                    			    //height: 200,
				                    			    width: 200,
				                    			    dialogClass: 'no-close',
				                    			    closeOnEscape: false,
				                    			    buttons: [
			                    			              {
			                    			                text: "OK",
			                    			                click: function() {
			                    			                  $( this ).dialog( "close" );
			                    			                  grid.trigger( 'reloadGrid' );
			                    			                }
			                    			              }
		                    			            ]
				                    			});
				                    			
				                    			totalProgress();
				                    			  
			                    			}						                    			
			                    		}
			                    	});
			                    	
							    	//return [success,message,new_id] ;
							    	if(response1.result == 'success'){
							    		//$(this).jqGrid("setGridParam", {datatype: 'json'});
							    		return [true, response1.result, ''];
							    		//return [true];
							    	}
							    	else
							    		return [false, response1.result, ''];
							    		
							    }
			                }
			             
			            );
		    				
		    				// total progress
		    				var grid = $("#grid_summary").jqGrid();
		    				var captionBar = $("#grid_summaryContainer").find(".ui-jqgrid-caption");
		    				var totalDiv = $(document.createElement( "div" ));
		    				totalDiv.attr("id","total_progress");
		    				totalDiv.css("display","inline-block");
		    				totalDiv.css("margin-left","10px");
		    				totalDiv.css("font-size","12px");
		    				totalDiv.css("font-weight","bold");
		    				totalDiv.css("color","red");
		    				captionBar.find("span.ui-jqgrid-title").css("font-size","12px");
		    				captionBar.find("span.ui-jqgrid-title").css("font-weight","bold");
		    				totalDiv.text("");
		    				captionBar.append(totalDiv);
		    				totalProgress();
			    			
			    		}
				    	
				    	, onCellSelect: function (rowId, iCol, content, event) {
					    	var test = "";
					    	var theGrid = $(this).jqGrid();
					    	var row = theGrid.jqGrid('getRowData',rowId);
					    	var cms = theGrid.jqGrid("getGridParam", "colModel");
							var cm = cms[iCol];
							
							var ispop = false;
							var oFrm = document.getElementById("form");
							oFrm.category.value = "";
							
							if(cm.name  == "CATEGORY"){
								ispop = true;
								oFrm.category.value = row.CATEGORY;
							}
							
							if(ispop){
								var newWin1 = window.open("", "coronaDetail", "width=1300,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
								
								oFrm.action =  '/dashboard/generic.do?viewName=coronaDetail';
								oFrm.method = "post";
								oFrm.target = "coronaDetail"; 
							    oFrm.submit();		
							    newWin1.focus();	
							}
							
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
	
	var dataList = [];
	
	$(function () {
		
		makeHtml('searchCondition', schemaSearch);
		makeHtml('contents', schemaContents);
		$( window ).resize(function() {
			adjustGrid();
		});
	});
	
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
	
	function changeProduct(){
		var components = [];
		var rtnList = [];	
		var vPjtCode = "";
		var rndModels = [];
		var pmsModels = [];
		
		$.ajax({
    		url: "/dashboard/pmsModelListJson.do",
    		data: {}, 
    		async: false,
    		success:  function(response){
    			pmsModels  = response.dataList;				
    			
    		}
    	});
		
		$.ajax({
    		url: "/dashboard/reliabilityModelListJson.do",
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
    		url: "/dashboard/reliabilityTestTypeListJson.do?searchProduct=xxx",
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
    		url: "/dashboard/reliabilityFWVersionListJson.do?searchProduct=xxx&searchTestType=xxx",
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
    		url: "/dashboard/reliabilityCapacityListJson.do?searchProduct=xxx&searchTestType=xxx&searchFWversion=xxx",
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
<div id="contents"></div>
<div id="loader"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
