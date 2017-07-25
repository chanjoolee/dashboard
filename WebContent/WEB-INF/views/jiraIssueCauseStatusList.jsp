<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>JIRA Issue</title>
	
	<script src="js/jquery/jquery-1.11.2.js"></script>
    <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.2/jquery.min.js"></script> -->
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"/>
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	
	
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
    
    
    
    
    
	<!-- <script src="js/highcharts/src/highcharts.src.js"></script> -->
	<!-- <script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script> -->
	
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<!-- <script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script> -->
	
	<script src="/dashboard/js/Highstock-5.0.9/code/highstock.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/drilldown.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/highcharts-more.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/no-data-to-display.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/exporting.js"></script>
	
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	
		<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
		<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	 
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
	
<script type="text/javascript">

	var dataList = [];
	var groupCols = [];
	var groupRows = [];
	
	$(function () {
		getDataByJson();
		$( window ).resize(function() {
			adjustGrid();
		});
	});
	
	function getDataByJson() {
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/jiraIssueCauseStatusListJson.html",
			data: $("#form").serialize() ,
			success : function(responseData) {
				dataList = responseData.dataList;
				regacyList = responseData.regacyList;
				
				drawGrid();
			}
		});
	}
		
	function drawGrid() {		
		// 라벨: 너무 긴 경우 <br>
		var mapLabel = {
				
		};
		
		
		var fn_cellattr = function(rowId, val, rowObj, cm, rowData, isCustom){
			var grid = $(this).jqGrid();
			var result = ' style="';
			if(rowObj.PRESUMED_CAUSE != 'Total')
				result += "cursor:pointer;"
			if(cm.name == rowObj.PRESUMED_CAUSE){
				result +=" background-color: rgb(230, 230, 250);";		
				result +=" font-weight: bolder;";		
				
			}
				
			result += '" ';
			
			
			return result;
		};
		
		// model init
		var gridModel = [
    		    {label:'Phase', name:'PHASE', id:'PHASE', width:35, align:'center', sortable:false, resizable: false, cellattr: mergeRow},
    			{label:'Presumed', name:'PRESUMED_CAUSE', id:'PRESUMED_CAUSE', width:50, align:'center', sortable:false, resizable: false},
          		
    	];
		
		// columns
		groupCols = groupbySum(dataList,['CONFIRMED_CAUSE'],'CNT');
		sortObjects(groupCols,['CONFIRMED_CAUSE']);
		$.each(groupCols,function(i,g){
			
			var v_label = mapLabel[g.CONFIRMED_CAUSE];
			if(v_label == undefined)
				v_label =  g.CONFIRMED_CAUSE;
			var model = {
				label : v_label,
				name: g.CONFIRMED_CAUSE,
				id: g.CONFIRMED_CAUSE,
				width:35,
				align:'right',
				sortable:false, 
				resizable: false,
				cellattr: fn_cellattr
			};
			gridModel.push(model);
		});
         		
    	gridModel.push({label:'Unresolved', name:'ing', id:'ing', width:40, align:'right', sortable:false, resizable: false, cellattr: fn_cellattr});
    	gridModel.push({label:'Total', name:'total', id:'total', width:50, align:'right', sortable:false, resizable: false});
    			
		
		// rows
		groupRows = groupbySum(dataList,['PHASE','PRESUMED_CAUSE'],'CNT');				
		sortObjects(groupRows,['PHASE','PRESUMED_CAUSE']);
		var totalRow = {PHASE:groupRows[0].PHASE + ' Total', PRESUMED_CAUSE: 'Total' };
		$.each(groupRows,function(i,r){
			var rowTotal = 0;
			//resolution
			$.each(groupCols,function(j,c){
				var filters  = dataFilter(dataList,[{col:'PHASE',val:r.PHASE},{col:'PRESUMED_CAUSE',val:r.PRESUMED_CAUSE},{col:'CONFIRMED_CAUSE',val:c.CONFIRMED_CAUSE},{col:'ING_YN',val:'N'}]);
				rowTotal += filters.length;
				r[c.CONFIRMED_CAUSE] = filters.length;
				var cell = totalRow[c.CONFIRMED_CAUSE];
				if(cell == undefined)
					totalRow[c.CONFIRMED_CAUSE] = filters.length;
				else
					totalRow[c.CONFIRMED_CAUSE] += filters.length;
				
			});
			
			//ing
			var filtersIng  = dataFilter(dataList,[{col:'PHASE',val:r.PHASE},{col:'PRESUMED_CAUSE',val:r.PRESUMED_CAUSE},{col:'ING_YN',val:'Y'}]);
			r['ing'] = filtersIng.length;		
			if(totalRow['ing'] == undefined)
				totalRow['ing'] = filtersIng.length;
			else
				totalRow['ing'] += filtersIng.length;
			
			r.total = rowTotal + filtersIng.length;
		});	
		groupRows.push(totalRow);
		
		//total row의 total
		totalRow.total = 0;
		$.each(groupCols,function(j,c){
			totalRow.total += totalRow[c.CONFIRMED_CAUSE];
		});
		totalRow.total += totalRow['ing'];
		
		
		
		
		
		
		//jqgrid
		var options = {
			datatype: "local",
			styleUI : 'Bootstrap',
			data:groupRows,
			colModel: gridModel,
			viewrecords: true ,
			decimalSeparator: ',' ,
			autowidth:true,
			//shrinkToFit:true,
			//fixed: true,
			gridView: false,
			//scroll:false,
			//forceFit:true,
			//width:'100%',
			height:'100%',
			scrollOffset:15,
			iconSet: "fontAwesome",
			//rowNum: gridArrayData.length,
			loadComplete: function() {
				
			},
			gridComplete:function() {
				
				$("#jqGrid").jqGrid('setGroupHeaders', {
					useColSpanStyle: true, 
				  	groupHeaders:[{startColumnName: groupCols[0].CONFIRMED_CAUSE, numberOfColumns: groupCols.length , titleText: '<span>Confirmed</span>'}]
				});
				
				var headerRow = $("[role='columnheader']");
				headerRow.css({'color':'white', 'background':'#696969'});
				
				$("#jqGrid tbody td[title$=' Total']").attr("colspan","2");
				$("#jqGrid tbody td[title='Total']").css("display","none");
				
				
				
			},
			loadError:function(shr, status, error) {
				alert(error);
			},
			onCellSelect: function (rowId, iCol, content, event) {
				var cm = jQuery("#jqGrid").jqGrid("getGridParam", "colModel");
				var rowData = jQuery(this).getRowData(rowId);	
				if(rowData.PRESUMED_CAUSE == 'Total')
					return;
				
				
				var val = Number($('#jqGrid').jqGrid('getCell', rowId, iCol));
				if($.isNumeric( val )){
					
					var confirmedCause = cm[iCol].name;
					var rowData = jQuery(this).getRowData(rowId);	
					//var rawDataPre = [];
					var rawData = [];
					if(confirmedCause=='ing'){
						rawData = dataFilter(dataList,
								[{col:'PHASE',val:rowData.PHASE},
								 {col:'PRESUMED_CAUSE',val: rowData.PRESUMED_CAUSE},
								 {col:'ING_YN',val: 'Y' }
								 ]);
					}else{
						rawData = dataFilter(dataList,
								[{col:'PHASE',val:rowData.PHASE},
								 {col:'PRESUMED_CAUSE',val:rowData.PRESUMED_CAUSE},
								 {col:'CONFIRMED_CAUSE',val: cm[iCol].name},
								 {col:'ING_YN',val: 'N' }
								 ]);
					}
					
					/* $.each(rawDataPre,function(){
						if(this.PROJECT_KEY != 'SAF')
							rawData.push(this);
					}); */
					
					
					
					//var phaseId = rawData[0].PHASE_ID;
					var phaseNm = "";
					var phaseId = "";
					if(rawData.length > 0 ){
						phaseNm = rawData[0].PHASE;
						phaseId = rawData[0].PHASE_ID;
						if(phaseNm == undefined)
							return;
					}else{
						return;
					}
					
					
					var url = "http://jira.skhynix.com/issues/?jql=";
					//url += " type != Bug and ";
					url += "(";
					url += "(\"issue to\" is not EMPTY or \"Discovered from\" is not EMPTY)";
					url += " and \"Presumed cause\"=\"" + rowData.PRESUMED_CAUSE +"\"";
					
					url += " and (\"PMS Phase\"=\"" + phaseNm+"\" or \"PMS Phase\"=\"" + phaseId+"\"      )";
					
					if($("#cause").val() != ""){
						url += " and \"Discovered from\"  is not EMPTY ";
					}
					if($("#discoveredFrom").val() != ""){
						url += " and \"Discovered from\"=\"" + rawData[0].DISCOVERED_FROM +"\"";
					}
					if($("#issueFrom").val() != ""){
						url += " and \"issue to\"=\"" + rawData[0].ISSUE_FROM+"\"";
					}
					
					//1 projectList
					//1.1 검색조건
					var pjtCodes = $("[name=pjtCodeList]");
					var pjtSearch = [];
					
					
					var regacy = groupbyCount(rawData,['PROJECT','PROJECT_KEY']);
					url += " and ";
					url += " \"project\" in(";
					$.each(regacy,function(i){
						if(i>0)
							url += ",";
						if(this.PROJECT_KEY == "SAF")
							url += "\"SAFE\"";
						else
							url += "\"" + this.PROJECT + "\"";
					});
					url += ")";
					
					
					///////////////
					if(confirmedCause != 'ing'){
						if(confirmedCause != 'N/A')
							url += " and \"Confirmed cause\"=\"" +confirmedCause +"\"";
						else{
							
							/* url += " and issuetype not  in (Debug, \"Non Visual Defect\", \"FVT Fail\", \"Function Fail\", Bug,";
							url += "\"Trouble shooting\", \"Failure\", \"Defect Item\", BM, \"Verification Fail\", Fail, \"NAND Defect\", FA, \"Booting Fail\", \"Aging Fail\", ";
							url += "\"Develop F/A\", \"QVT Fail\", \"CS Test F/A\", \"Customer RMA\", \"Mass F/A\", \"Manufacture Fail\", \"DV_REPORT\", \"D/L Fail\", \"SPOR Fail\", \"Fault Injection Fail\")";
							url += " "; */
							// N/A이 경우 issue_num을 넘긴다.
							url += " and \"key\" in(";
							var keys = groupbyCount(rawData,['PROJECT_KEY','ISSUE_NUM']);
							$.each(keys,function(i){
								if(i>0)
									url += ",";
								url += "\"" + this.PROJECT_KEY +"-"+ this.ISSUE_NUM+ "\"";
							});
							url += ")";
						}
							
						
						url += " and \"resolution\"  is not EMPTY ";
					}else{
						// Unresolved
						url += " and \"resolution\"  is EMPTY ";
					}
					url += "	)";
					
					var isSafe = arrayContain(rawData,[{col:'PROJECT_KEY',val:'SAF'}]);
					if(isSafe){
						var safProjects = dataFilter(rawData,
								[{col:'PROJECT_KEY',val:'SAF'}]
						);
						url += " or  (\"key\" in(";
						$.each(safProjects,function(i){
							if(i>0)
								url += ",";
							url += "\"" + this.PROJECT_KEY +"-"+ this.ISSUE_NUM+ "\"";
						});
						url += "	))";
					}						
					
		    		hsClick(url,this);
				}
					
		      	
			    	  
		    }
		};

		$("#containerGrid").html('<table id="jqGrid" style="width: 100%;height: 100%"></table>');
		if($("#jqGrid").text()!=""){
			$('#jqGrid').jqGrid('clearGridData');
			$("#jqGrid").jqGrid('setGridParam', options ,true);
			$('#jqGrid').trigger('reloadGrid');
			
		}else{
			$("#jqGrid").jqGrid(options);
		}
		
		adjustGrid();		
	}
	
	function mergePhase(rowId, val, rowObj, cm, rowData) {
		var result = "";
		if(rowObj.presumed == 'GRAND_TOTAL' || rowObj.presumed == 'SUB_TOTAL') {
			result = ' colspan=2';
		} else {
			if (rowObj.GRP_START == 'Y') {
	            result = ' style="background:white" rowspan=' + causeCnt;
	        } else {
	        	result = ' style="display:none"';
	        }
		}
		return result;
	}
	
	function mergePresumed(rowId, val, rowObj, cm, rowData) {
		var result = "";
		if(rowObj.presumed == 'GRAND_TOTAL' || rowObj.presumed == 'SUB_TOTAL') {
			result = ' style="display:none"';
		}
		return result;
	}
	
	function adjustGrid() {
		$("#jqGrid").jqGrid('setGridWidth',$("#containerGrid").width() - 5 );
		$("#jqGrid").jqGrid('setGridHeight',$("#containerGrid").height() - 60 );
	}
	
	function cetattr(rowId, val, rowObj, cm, rowData, isCustom){
		var result = "";
		//result += "font-weight: bolder;cursor:pointer;"
		//var grid = $(this).jqGrid();
		
		return result;
	}
	
	function mergeRow(rowId, val, rowObj, cm, rowData, isCustom) {
		var result = "";
		var grid = $(this).jqGrid();
		var curRow = groupRows[parseInt(rowId)-1];
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
		
		var firstRow = fn_firstRow(groupRows,rowId,cm.name);
		var lastRow = fn_lastRow(groupRows,rowId,cm.name,0);
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
</script>

<style type="text/css">
	html, body,form {
		height: 100%;
	    width: 100%;
	    padding: 0;
	    margin: 0;
	    overflow:hidden;
	}
	     
	.containerGrid {
		position: relative;
		min-height: 1px;
		padding-left: 0;
		padding-right: 0;
		width: 100%;
		height: 100%;			
	}	
	
	.ui-jqgrid .ui-jqgrid-bdiv {
		position: relative; 
		margin: 0; 
		padding:0; 
		overflow: auto; 
		text-align:left;
		overflow-x: hidden;
	}
	
	.ui-jqgrid .ui-jqgrid-sortable {
		cursor:default;
	}
	
	.table > thead > tr > th,
	.table > tbody > tr > th,
	.table > tfoot > tr > th,
	.table > thead > tr > td,
	.table > tbody > tr > td,
	.table > tfoot > tr > td {
	  padding: 4px;	 
	}
	.ui-jqgrid-hdiv th {
	    text-align: center;
	}
</style>
</head>
<body>
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="jiraPjtCode" name="jiraPjtCode" value="${param.jiraPjtCode}"/>
<input type="hidden" id="pjtCode" name="pjtCode" value="${param.pjtCode}"/>
<input type="hidden" id="pjtName" name="pjtName" value=""/>
<input type="hidden" id="phase" name="phase" value="${param.phase}"/>
<input type="hidden" id="cause" name="cause" value="${param.cause}"/>
<input type="hidden" id="discoveredFrom" name="discoveredFrom" value="${param.discoveredFrom}"/>
<input type="hidden" id="issueFrom" name="issueFrom" value="${param.issueFrom}"/>
<%-- <c:forEach items="${searchVO.pjtCodeList}" var="pjtCode" varStatus="status"> --%>
<%-- <c:forEach items="${pageContext.request.parameterMap.pjtCodeList}" var="pjtCode" varStatus="status"> --%>
<c:forEach items="${paramValues.pjtCodeList}" var="pjtCode" varStatus="status">
	<input type="hidden" name="pjtCodeList" value="${pjtCode}"/>
</c:forEach>

<div id="containerGrid" class="containerGrid">
	<table id="jqGrid" style="width: 100%;height: 100%"></table>
</div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
