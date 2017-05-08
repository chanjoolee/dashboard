<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>SSD Custom Chart</title>
	<!-- <link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css" /> -->
	
	
	<%-- 1. jquery --%>
    <!-- <script src="js/jquery/jquery-1.11.2.js"></script> -->
    <!-- <script src="js/jquery/jquery.form.js"></script> -->
    <!-- <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script> -->
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    <%-- jqgrid --%>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"> 
	<!-- <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script> -->
    
    <%-- 2. high charts --%>
	<!-- <script src="js/highcharts/src/highcharts.src.js"></script> -->
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	
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
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<script src="js/highcharts/grouped-categories.js"></script>
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<!-- <script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script> -->
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=1"></script>
	
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
	
	</style>
<script title="schema">

	var schema = {
			containerId:'contents',
			type:'Vertical',
			elements:[
				{
					label:'',
					type: 'HorizontalLayout',
					elements:[
	    	            {
	    	            	type:'chart',
	    	            	id: 'customer',
	    	            	label:'System Manufacturer',
	    	            	width: '49%',
	    	            	data: function(){
	    	            		return getDataCustomer();
	    	            	},
	    	            	options: function(){
	    	            		return getOptionCustomer();
	    	            	}
	    	            }
	    	            ,{
	    	            	type:'chart',
	    	            	id: 'platform',
	    	            	label:'Test Platform',
	    	            	width: '49%',
	    	            	data: function(){
	    	            		return getDataTestPlatform();
	    	            	},
	    	            	options: function(){
	    	            		return getOptionTestPlatform();
	    	            	}
	    	            }
						
					]
				} 
				,{
					label:'',
					type: 'HorizontalLayout',
					elements:[
						{
	    	            	type:'chart',
	    	            	id: 'product',
	    	            	label:'Product',
	    	            	width: '49%',
	    	            	data: function(){
	    	            		return getDataProduct();
	    	            	},
	    	            	options: function(){
	    	            		return getOptionProduct();
	    	            	}
    	            	}
						,{
	    	            	type:'chart',
	    	            	id: 'fwVersion',
	    	            	label:'FW Version',
	    	            	width: '49%',
	    	            	data: function(){
	    	            		return getDataFwVersion();
	    	            	},
	    	            	options: function(){
	    	            		return getOptionFwVersion();
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
		
		var makeInline = function(container,el){
			var cols = 3;
			if(_schema.cols != undefined)
				cols = _schema.cols;
			
			//tableCreate
			var table = $(document.createElement("table"));
			//table.addClass("table_hori m_bottom_20");
			table.addClass("table_hori");
			container.append(table);
			
			// colgroup
			var colgroup = $(document.createElement("colgroup"));
			table.append(colgroup);
			
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
			table.append(tbody); 
			var tr = null;
			$.each(el.items,function(i,item){
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
				td.text(el.data()[item.col]);
				
				tr.append(th);
				tr.append(td);
				
			});
			// --tbody
		};
		
		
		
		
		var makeGrid = function(container,el){
			//==grid create
			var gridContainer = $(document.createElement( "div" ));
			gridContainer.attr("id",el.id + 'Container');
			
			var containerType = container.attr("type");
			if(containerType == 'HorizontalLayout'){
				gridContainer.css("display","inline-block");
				if(container.children().length > 0)
					gridContainer.css("margin-left","10px");
			}
				
			container.append(gridContainer);
			//gridContainer.css("width","100%");
			//grid.addClass("chartContainerSub");
			
			
			//==table create
			var table = $(document.createElement( "table" ));
			table.attr("id",el.id);
			//table.css("width","100%");
			gridContainer.append(table);
			
			//== page create
			var pager = $(document.createElement( "div" ));
			pager.attr("id",el.id + 'Pager');
			gridContainer.append(pager);
			
			//== common option
			var opt = {
					datatype: 'local',
					styleUI : 'Bootstrap',
					colModel: el.items,
					//rowNum:10,
					rownumbers: true, // show row numbers
					caption: el.label,
					//width: '100%',
					//height: '100%',
					iconSet: "fontAwesome",
					sortable: false,
					//viewrecords: true,
					//pager : pager, 
					//data : el.data() 
			};
			if(el.data != undefined && typeof el.data == 'function')
				opt.data = el.data();
			
			if(el.gridOpt != undefined){
				$.extend(opt, el.gridOpt);
			}
			
			table.jqGrid(opt);
		};
		
		
		var makeChart = function(container,el){
			//==chart container create
			var chartContainer = $(document.createElement( "div" ));
			chartContainer.attr("id",el.id + 'Container');
			
			var containerType = container.attr("type");
			if(containerType == 'HorizontalLayout'){
				chartContainer.css("display","inline-block");
				if(el.width != undefined)
					chartContainer.css("width",el.width);
				if(container.children().length > 0)
					chartContainer.css("margin-left","10px");
			}
				
			container.append(chartContainer);
			
			if($(chartContainer).highcharts() != undefined) $(chartContainer).highcharts().destroy();
			var series = {};
			var options = el.options();
			if(el.data != undefined && typeof el.data == 'function'){
				var vData = el.data();
				series = vData.series;
				options.series = vData.series.series;
				options.xAxis = vData.xAxis;
			}
				
			$(chartContainer).highcharts(options,function(chart){
			 	chart.schema = el;
			});
			
		};
		
		
		// data process
		if(_schema.label != undefined){
			
			if(_schema.label != ""){
				var h3 = $(document.createElement("h3"));
				h3.addClass("cont_tit");
				h3.text(_schema.label);
				container.append(h3);
			}
			
			containerSub = $(document.createElement("div"));
			//상위 container type을 줘서 알아서 판단 할 수 있도록 한다.
			containerSub.attr("type", _schema.type);
			container.append(containerSub);
		}
		
		$.each(_schema.elements, function(i,el){
			if(el.type == 'inline'){
				makeInline(containerSub, el);
			}else if(el.type == 'grid'){
				makeGrid(containerSub , el );
			}else if(el.type == 'chart'){
				makeChart(containerSub , el );
			}else if(el.elements != undefined){
				
				makeHtml(container, el);
			}
		});
	}
	
	
	//system manufacture from customer. 2017.02.07
	function getDataCustomer(){
		var param = openerForm;
		param += "&groupbyCol=SYSTEM_MANUFACTURER";
		
		var dataList = [];
		var rtn = {};
		$.ajax({
    		url: "/dashboard/ssdCusMainAllJson.html",
    		data: param, 
    		async: false,
    		success:  function(response){
    			dataList = response.dataList;
    			rtn.dataList = dataList;
    		}
    	});
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				//['TEST_STATUS','CUSTOMER'] , //groupby를 안하므로 length:0
				['TEST_STATUS','SYSTEM_MANUFACTURER'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'CNT' , convert:'y',isnull:0}], //convert
				//'CUSTOMER' ,  //category
				'SYSTEM_MANUFACTURER' ,  //category
				//vCateInfo.categoryCols[0] ,
				'CNT',
				{cd:'TEST_STATUS', name:'TEST_STATUS'},
				{isGroupby: true}
		);
		// category start
		series.categoryOrigin = series.category;
		series.category = [];
		$.each(series.series[0].data,function(i,d){
			var colvalues = [];
			$.each(['SYSTEM_MANUFACTURER'],function(){
				colvalues.push(d[this]);
			});
			series.category.push(colvalues);
		});
		
		var category1 = [];
		$.each(series.category,function(index,c){
			category1.push(c);
		});	    	            		
		var category2 = makeGroupCategory(category1);
		series.category = category2;
		
		var xAxis = {
			categories: series.category,
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
		};
		rtn.xAxis = xAxis;
		// category end
		
		// return start
		rtn.series = series;
		
		
		
		return rtn;
		// return end
	}
	
	function getOptionCustomer(){
		var option = {
				
		        chart: {
		            type: 'column',
		            zoomType:'x',
		            height: 390
		            //,animation: false
		            //,width: 600
		        },
		        credits: {
	                enabled: false
	            },
		        title: {
		        	//text:pDataSrc.split(".")[0],
		        	//text:pDataSrc,
		        	text:'System Manufacturer',
	            	useHTML: true
		        },
		        subtitle: {
		            text: ''
		        },	     
		        legend:{
		        	enabled: false
		        },
		        
		        tooltip: {
		            valueDecimals: 0,
		          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
	                //headerFormat:'',
		            pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y:.0f}</b> <br/>',
		            shared: true,
		            enabled: true
		        },
		        //legend: legend,
		        plotOptions: {
		            column: {
		            	grouping: true,
		            	borderWidth: 0,
		            	cursor: 'pointer' ,
		            	stacking:'normal',
		            	point:{	                	
		                	events:{
		                		click: function(e){
		                			e.point.select(true,false);
		                			var chartId = "platformContainer";
		                			var chartContainer = $("#"+chartId);		                			
		                			var chartSchema = $(chartContainer).highcharts().schema;
		                			var series = {};
		                			var options = chartSchema.options();
		                			options.title.text = 'System Model';
		                			options.title.text += '<span style="color: blue">(' +e.point.SYSTEM_MANUFACTURER + ')</span>';
		                			if(chartSchema.data != undefined && typeof chartSchema.data == 'function'){
		                				var vData = getDataTestPlatform(e.point.SYSTEM_MANUFACTURER);
		                				series = vData.series;
		                				options.series = vData.series.series;
		                				options.xAxis = vData.xAxis;
		                			}
		                			if($(chartContainer).highcharts() != undefined) $(chartContainer).highcharts().destroy();
		                			$(chartContainer).highcharts(options,function(chart){
		                			 	chart.schema = chartSchema;
		                			});
		                			
		                			
		                			
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
	
	
	//syste model 2017.02.17
	function getDataTestPlatform(systemManufacturer){

		//var param ={groupbyCol: 'SYSTEM_MANUFACTURER'};
		//if(customer != undefined)
		//	param.customer = customer;
		 
		var param = openerForm;
		param += "&groupbyCol=SYSTEM_MODEL";
		if(systemManufacturer != undefined)
			param += "&systemManufacturer1=" + systemManufacturer;
		
		
		var dataList = [];
		var rtn = {};
		$.ajax({
    		url: "/dashboard/ssdCusMainAllJson.html",
    		data: param, 
    		async: false,
    		success:  function(response){
    			dataList = response.dataList;
    			rtn.dataList = dataList;
    		}
    	});
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				['TEST_STATUS','SYSTEM_MODEL'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'CNT' , convert:'y',isnull:0}], //convert
				'SYSTEM_MODEL' ,  //category
				//vCateInfo.categoryCols[0] ,
				'CNT',
				{cd:'TEST_STATUS', name:'TEST_STATUS'},
				{isGroupby: true}
		);
		// category start
		series.categoryOrigin = series.category;
		series.category = [];
		$.each(series.series[0].data,function(i,d){
			var colvalues = [];
			$.each(['SYSTEM_MODEL'],function(){
				colvalues.push(d[this]);
			});
			series.category.push(colvalues);
		});
		
		var category1 = [];
		$.each(series.category,function(index,c){
			category1.push(c);
		});	    	            		
		var category2 = makeGroupCategory(category1);
		series.category = category2;
		
		var xAxis = {
			categories: series.category,
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
		};
		rtn.xAxis = xAxis;
		// category end
		
		// return start
		rtn.series = series;
		
		return rtn;
		// return end
	}
	
	
	function getOptionTestPlatform(){
		var option = {
				
		        chart: {
		            type: 'column',
		            zoomType:'x',
		            height: 390
		            //,animation: false
		            //,width: 600
		        },
		        credits: {
	                enabled: false
	            },
		        title: {
		        	//text:pDataSrc.split(".")[0],
		        	//text:pDataSrc,
		        	text:'System Model<span style="color: blue">(All)</span>',
	            	useHTML: true
		        },
		        subtitle: {
		            text: ''
		        },	     
		        legend:{
		        	enabled: false
		        },
		        
		        tooltip: {
		            valueDecimals: 0,
		          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
	                //headerFormat:'',
		            pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y:.0f}</b> <br/>',
		            shared: true,
		            enabled: true
		        },
		        //legend: legend,
		        plotOptions: {
		            column: {
		            	grouping: true,
		            	borderWidth: 0,
		            	cursor: 'pointer' ,
		            	stacking:'normal',
		            	point:{	                	
		                	events:{
		                		click: function(e){
		                			
		                			
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
	
	function getDataProduct(){
		var param = openerForm;
		param += "&groupbyCol=DEVICE_TYPE";
		
		
		var dataList = [];
		var rtn = {};
		$.ajax({
    		url: "/dashboard/ssdCusMainAllJson.html",
    		data: param, 
    		async: false,
    		success:  function(response){
    			dataList = response.dataList;
    			rtn.dataList = dataList;
    		}
    	});
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				['TEST_STATUS','DEVICE_TYPE'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'CNT' , convert:'y',isnull:0}], //convert
				'DEVICE_TYPE' ,  //category
				//vCateInfo.categoryCols[0] ,
				'CNT',
				{cd:'TEST_STATUS', name:'TEST_STATUS'},
				{isGroupby: true}
		);
		// category start
		series.categoryOrigin = series.category;
		series.category = [];
		$.each(series.series[0].data,function(i,d){
			var colvalues = [];
			$.each(['DEVICE_TYPE'],function(){
				colvalues.push(d[this]);
			});
			series.category.push(colvalues);
		});
		
		var category1 = [];
		$.each(series.category,function(index,c){
			category1.push(c);
		});	    	            		
		var category2 = makeGroupCategory(category1);
		series.category = category2;
		
		var xAxis = {
			categories: series.category,
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
		};
		rtn.xAxis = xAxis;
		// category end
		
		// return start
		rtn.series = series;
		
		return rtn;
		// return end
	}
	
	
	function getOptionProduct(){
		var option = {
				
		        chart: {
		            type: 'column',
		            zoomType:'x',
		            height: 390
		            //,animation: false
		            //,width: 600
		        },
		        credits: {
	                enabled: false
	            },
		        title: {
		        	//text:pDataSrc.split(".")[0],
		        	//text:pDataSrc,
		        	text:'Product',
	            	useHTML: true
		        },
		        subtitle: {
		            text: ''
		        },	     
		        legend:{
		        	enabled: false
		        },
		        
		        tooltip: {
		            valueDecimals: 0,
		          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
	                //headerFormat:'',
		            pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y:.0f}</b> <br/>',
		            shared: true,
		            enabled: true
		        },
		        //legend: legend,
		        plotOptions: {
		            column: {
		            	grouping: true,
		            	borderWidth: 0,
		            	cursor: 'pointer' ,
		            	stacking:'normal',
		            	point:{	                	
		                	events:{
		                		click: function(e){
 		                			// 하위 FW version을 가져온다.
		                			e.point.select(true,false);
		                			var chartId = "fwVersionContainer";
		                			var chartContainer = $("#"+chartId);		                			
		                			var chartSchema = $(chartContainer).highcharts().schema;
		                			var series = {};
		                			var options = chartSchema.options();
		                			options.title.text = 'FW Version';
		                			options.title.text += '<span style="color: blue">(' +e.point.DEVICE_TYPE + ')</span>';
		                			if(chartSchema.data != undefined && typeof chartSchema.data == 'function'){
		                				var vData = getDataFwVersion(e.point.DEVICE_TYPE);
		                				series = vData.series;
		                				options.series = vData.series.series;
		                				options.xAxis = vData.xAxis;
		                			}
		                			if($(chartContainer).highcharts() != undefined) $(chartContainer).highcharts().destroy();
		                			$(chartContainer).highcharts(options,function(chart){
		                			 	chart.schema = chartSchema;
		                			});
		                			
		                			
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
	
	function getDataFwVersion(deviceType){

		//var param ={groupbyCol: 'FIRMWARE_VERSION'};
		//if(deviceType != undefined)
		//	param.deviceType = deviceType;
		
		var param = openerForm;
		param += "&groupbyCol=FIRMWARE_VERSION";
		if(deviceType != undefined)
			param += "&deviceType1=" + deviceType;
		
		var dataList = [];
		var rtn = {};
		$.ajax({
    		url: "/dashboard/ssdCusMainAllJson.html",
    		data: param, 
    		async: false,
    		success:  function(response){
    			dataList = response.dataList;
    			rtn.dataList = dataList;
    		}
    	});
		
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				['TEST_STATUS','FIRMWARE_VERSION'] , //groupby를 안하므로 length:0
				[], //filter
				[{col: 'CNT' , convert:'y',isnull:0}], //convert
				'FIRMWARE_VERSION' ,  //category
				//vCateInfo.categoryCols[0] ,
				'CNT',
				{cd:'TEST_STATUS', name:'TEST_STATUS'},
				{isGroupby: true}
		);
		// category start
		series.categoryOrigin = series.category;
		series.category = [];
		$.each(series.series[0].data,function(i,d){
			var colvalues = [];
			$.each(['FIRMWARE_VERSION'],function(){
				colvalues.push(d[this]);
			});
			series.category.push(colvalues);
		});
		
		var category1 = [];
		$.each(series.category,function(index,c){
			category1.push(c);
		});	    	            		
		var category2 = makeGroupCategory(category1);
		series.category = category2;
		
		var xAxis = {
			categories: series.category,
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
		};
		rtn.xAxis = xAxis;
		// category end
		
		// return start
		rtn.series = series;
		
		return rtn;
		// return end
	}
	
	
	function getOptionFwVersion(){
		var option = {
				
		        chart: {
		            type: 'column',
		            zoomType:'x',
		            height: 390
		            //,animation: false
		            //,width: 600
		        },
		        credits: {
	                enabled: false
	            },
		        title: {
		        	//text:pDataSrc.split(".")[0],
		        	//text:pDataSrc,
		        	text:'FW Version<span style="color: blue">(All)</span>',
	            	useHTML: true
		        },
		        subtitle: {
		            text: ''
		        },	     
		        legend:{
		        	enabled: false
		        },
		        
		        tooltip: {
		            valueDecimals: 0,
		          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
	                //headerFormat:'',
		            pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y:.0f}</b> <br/>',
		            shared: true,
		            enabled: true
		        },
		        //legend: legend,
		        plotOptions: {
		            column: {
		            	grouping: true,
		            	borderWidth: 0,
		            	cursor: 'pointer' ,
		            	stacking:'normal',
		            	point:{	                	
		                	events:{
		                		click: function(e){
// 		                			e.point.select(true,false);
//	 	                			if(this.drillSeries){
//	 	                				setChart(this.drillSeries);
//	 	                			}else{
//	 	                				//var phase = this.category.parent.parent.name;
//	 		                			//var cause = this.category.name;
//	 		                			//var data = "";
//	 		                			//$("#phase").val(phase);
//	 		                			//$("#discoveredFrom").val(cause);
//	 		                			gotoDetail(this.PHASE,this.DISCOVERED_FROM_PURE);
//	 	                			}
		                			
		                			
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
	
</script>
<script title="ui-schema">
	
	
	
</script>
<script type="text/javascript">
	var openerForm = "";
	//var spiderData = {};
	$(function () {
		//getDataByJson();
		openerForm = opener.$("#form").serialize();
		makeHtml('contents', schema);
		$("#productContainer").parent().css("border-top","2px");
		$("#productContainer").parent().css("border-style","dotted");
		$( window ).unload(function() {
			
		});
		
	});
	
	function fn_close(){
		window.close();
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
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<input type="hidden" id="testId" name="testId" value="${param.testId}"/>
	<div class="pop_window">
		<div class="pop_tit_wrap">
			<!-- <span class="baseline"></span> -->
			<h2 class="pop_tit" style="margin-top:10px;">Customer Platform Test Result Chart</h2>
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
    <!-- ## //PAGE CONTENTS ##--->	
</form>
</body>
<style>
	
</style>
<iframe id="file_iframe" style="display:none;"></iframe>
</html>