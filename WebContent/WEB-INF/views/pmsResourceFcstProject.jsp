<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>pmsResourceFcstProject</title>
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
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
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
		  height: 80px;
		  white-space: nowrap;
		}
		
		th.rotate > div {
		  transform: 
		    /* Magic Numbers */
		   translate(-30px, -40px)
		    /* 45 is really 360 - 45 */
		    rotate(275deg);
		  width: 100px;
		  height: 50px;
		}
		th.rotate > div > span {
		  border-bottom: 1px solid #ccc;
		  padding: 5px 10px;
		}
	
	</style>
<script title="schema">
// 	$.jgrid.defaults.width = 780;
// 	$.jgrid.defaults.responsive = true;
// 	$.jgrid.defaults.styleUI = 'Bootstrap';
	
	var responseData = {};
	var dataList = [];
	var pivotObject = {};

	
	
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
		setTimeout(function(){			
			getDataByJson();
		},50);
		
		$( window ).unload(function() {
			
		});
		
		$( window ).resize(function() {
			adjustGrid();
		});
		
	});
	
	function getDataByJson(){
		//setCalendarRsc();
		$.ajax({
			url : "/dashboard/pmsResourceFcstProjectJson.html",
			data: $("#form1").serialize(),
			async: false,
			success : function(vResponseData){
				responseData = vResponseData;
				dataList = responseData.data;
				$.each(dataList,function(i,d){
					d.YYYYMM= d.YYYYMM.substr(0,6);
				});
				
				pivotObject = pivot(dataList,{col:'YYYYMM',name:'YYYYMM'},['UP_PJT_FUNC_ID','UP_PJT_FUNC_NAME'],'MM_RESULT');
				sortObjects(pivotObject.columns,['YYYYMM']);
				drawGrid();
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
			var sum = 0;
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
				sum += tval;
					
				
			});
			group['total'] = sum;
		});
		
		rtnObject.list = groupList;
		rtnObject.datasrc = datasrc;
		rtnObject.colDef = colDef;
		rtnObject.columns = cols;
		rtnObject.groupbyColumns = groupbyColumns;
		rtnObject.targetColumn = targetColumn;
		
		return rtnObject ;
		
	}
	
function drawGrid(){
		
		var gridModel = getGridModel();
		
		sortObjects(pivotObject.list,['UP_PJT_FUNC_NAME']);
		var theGrid = $("#jqgridTable");
		var opt ={
				datatype: 'local',
				styleUI : 'Bootstrap',
				colModel: gridModel,
				loadonce: true,
				rowNum:100000,
				sortable: false,
				viewrecords: true,
				emptyrecords: "No records to view",
				rownumbers: false, // show row numbers
		        multiSort: false,
		        multiselect: false,
		        //caption: 'Analysis List',
		        // width: '100%' ,
		        //autowidth:true,
		        scrollOffset:15,
		        forceFit : false ,
		        iconSet: "fontAwesome",
		        data: pivotObject.list,
		        height: '100%',
		        footerrow: true,
		        userDataOnFooter: true,
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
			    	
			    	var theGrid = $("#jqgridTable");
			    	
			    	$.each(pivotObject.columns,function(i,col){
			    		var colid = getColumnSrcIndexByName(theGrid,col[pivotObject.colDef.name]);
				    	var sum = theGrid.jqGrid('getCol',colid,false,'sum');
				    	var sumobj = {};
				    	sumobj[col[pivotObject.colDef.name]] = sum;
				    	theGrid.jqGrid('footerData','set',sumobj);
			    	});
			    	
			    	var colid = getColumnSrcIndexByName(theGrid,'total');
			    	var sum = theGrid.jqGrid('getCol',colid,false,'sum');
			    	var sumobj = {};
			    	sumobj['total'] = sum;
			    	theGrid.jqGrid('footerData','set',sumobj);
			    	
			    	
			    	
			    }, 
			    onCellSelect: function (rowId, iCol, content, event) {
			    	var test = "";
			    	var grid = $("#jqgridTable");
			    	var row = theGrid.jqGrid('getRowData',rowId);
			    	var cms = grid.jqGrid("getGridParam", "colModel");
					var cm = cms[iCol];
					
					
			    }
			    
		};
		
		//"use strict";		
		theGrid.jqGrid(opt);
		//$(".ui-jqgrid th.ui-th-column").css("vertical-align","top");
		//$(".ui-jqgrid th.ui-th-column div").css("text-align","left");
		$('.ui-jqgrid-hdiv th').each(function(){
			if($(this).find("div").text() != "Func"){
				$(this).css("vertical-align","bottom");				
				$(this).addClass("rotate");
				$(this).find("div").css("text-align","left");
				
			}
		});
		//$('.ui-jqgrid-hdiv th').addClass("rotate");
		$('.ui-jqgrid-hdiv th').css("overflow","visible");
		//theGrid.jqGrid('sortableRows');
		
// 		theGrid.jqGrid('filterToolbar',
// 			{
// 				defaultSearch:'cn' ,
//                 // JSON stringify all data from search, including search toolbar operators
//                 stringResult: true
//                 // instuct the grid toolbar to show the search options
//                 //searchOperators: false
//             }
// 		);
		
		adjustGrid();
		$("#loader").hide();	
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
				result += " onclick = popPmsRsc('"+rawObject.UP_PJT_FUNC_ID+"','${param.pjt_code}','"+cm.id+"');";
			}
				
			return result;
			
		};
		
		var theGrid = $("#jqgridTable");
		var gridModel = [
		     		    {label:'UP_PJT_FUNC_ID', name:'UP_PJT_FUNC_ID', id:'UP_PJT_FUNC_ID', hidden:true},
		     		    {label:'Func', name:'UP_PJT_FUNC_NAME', id:'UP_PJT_FUNC_NAME', width:200, align:'left', textAlign:'left',sortable:false}
		           	];
		
		$.each(pivotObject.columns,function(i,col){
			/* gridModel.push({
				label: col[pivotObject.colDef.col] , 
				name:col[pivotObject.colDef.col], 
				id:col[pivotObject.colDef.col], 
				width:130,
				align:'center', 
				textAlign:'center',
				sortable:false,
				hidden:true
			}); */
			gridModel.push({
				label: col[pivotObject.colDef.name] , 
				name:col[pivotObject.colDef.name], 
				id:col[pivotObject.colDef.name], 
				width:60,
				//align:'left', 
				//textAlign:'left',
				sortable:false,
				formatter:'number',
				summaryType:'sum',
				cellattr: setAttr
			});
		});
		
		gridModel.push({
			label: 'Total' , 
			name:'total', 
			id: 'total', 
			width:50,
			//align:'left', 
			//textAlign:'left',
			sortable:false,
			formatter:'number',
			summaryType:'sum'
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
	
	function adjustGrid() {
		$("#jqgridTable").jqGrid('setGridWidth',$("#contents").width() - 5 );
		//$("#jqgridTable").jqGrid('setScrollOffset',15 );
		//$("#jqgridTable").jqGrid('setGridHeight',$("#container").height() - 60 );
		
		$('.ui-jqgrid').css("width",'100%');
		$('.ui-jqgrid-view').css("width",'100%');
		$('.ui-jqgrid-hdiv').css("width",'100%');
		$('.ui-jqgrid-bdiv').css("width",'100%');
		$('.ui-jqgrid-pager').css("width",'100%');
	}
	
	function fn_close(){
		window.close();
	}	
	
	function getColumnSrcIndexByName(grid,columnName) {
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
	
	function popPmsRsc(upFuncId,pjtId,yyyymm){
		//var url = '/nspim/pjt/pjt/retrieveResourceInfo.do?fnCode=' + upFuncId +'&searchPjtId='+pjtId;
		var url = '/nspim/pjt/pjt/retrieveDetailMResourceInfo.do?fnCode=' + upFuncId +'&searchPjtId='+pjtId +'&yyyymm='+yyyymm +'&cj=y';
		var parameter ="&natlCdList=xxx";
		$("[name=site]").each(function(){
			parameter +="&natlCdList=" + $(this).val();
		});
		
		var newWin1 = window.open("", "DetailMResourceInfo", "width=1280,height=350, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
		var oFrm = document.getElementById("form1");
		
		oFrm.pjtId.value = pjtId;
		oFrm.action =  url + parameter;
		oFrm.method = "post";
		oFrm.target = 'DetailMResourceInfo'; 
	    oFrm.submit();		 
	    newWin1.focus();
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
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<input type="hidden" id="pjt_code" name="pjt_code" value="${param.pjt_code}"/>
<input type="hidden" id="pjt_name" name="pjt_name" value="${param.pjt_name}"/>
<c:forEach items="${paramValues.site}" var="natl_cd" varStatus="status">
	<input type="hidden" name="site" value="${natl_cd}"/>
</c:forEach>
	<div class="pop_window">
		<div class="pop_tit_wrap">
			<!-- <span class="baseline"></span> -->
			<h2 class="pop_tit" style="margin-top:10px;">${param.pjt_name}</h2>
		</div>
		
       <div class="pop_con_area" style="padding-top: 3px;"> 
			<div id="contents" class="wrap_a" >
       	   		<div id="jqgrid" style="width:100%;">
					<table id="jqgridTable"></table>
					<div id="jqgridPager"></div>
				</div>
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
    <div id="loader"></div>
</form>
</body>

<iframe id="file_iframe" style="display:none;"></iframe>
</html>