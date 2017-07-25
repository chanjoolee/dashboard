<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>JIRA Issue</title>
</head>

<%-- 1. jquery --%>
<script src="js/jquery/jquery-1.11.2.js"></script>
<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
<script src="js/jquery.csv-0.71.js"></script>    
<script type="text/javascript" src="js/jqGrid/jquery.jqGrid.src.js"></script>
<script type="text/javascript" src="js/jqGrid/i18n/grid.locale-kr.js"></script>
   
<%-- 2. high charts --%>
<script src="js/highcharts/src/highcharts.src.js"></script>
<script src="js/highcharts/modules/drilldown.src.js"></script>
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
<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	
<script type="text/javascript">

	var existDataYn;
	var causeCnt = 10;
	var presumedCauseCnt = 10;
	var ingColIndex = 12;//Unresolved Colomn
	var causeArr = ['fwBug', 'fwPolicy', 'nand', 'simulatorEmulator', 'soc', 'testScript', 'hwPcb', 'hostCompliance', 'unidentified', 'na', 'ing'];
	var dataList = [];
	var rowList = [];
	var regacyList = [];// pms_mapping jira project list
	
	var gridModel = [
		    {label:'Phase', name:'phase', id:'phase', width:35, align:'center', sortable:false, resizable: false, cellattr:mergePhase},
			{label:'Presumed', name:'presumed', id:'presumed', width:50, align:'center', sortable:false, resizable: false, cellattr:mergePresumed},
      		{label:'FW bug', name:'fwBug', id:'fwBug', width:35, align:'right', sortable:false, resizable: false},
      		{label:'FW policy', name:'fwPolicy', id:'fwPolicy', width: 35 ,align:'right', sortable:false, resizable: false},
      		{label:'NAND', name:'nand', id:'nand', width:35 , align:'right', sortable:false, resizable: false},
      		{label:'Simulator / <br>Emulator', name:'simulatorEmulator', id:'simulatorEmulator', width:40, align:'right', sortable:false, resizable: false},
      		{label:'SoC', name:'soc', id:'soc', width:35, align:'right', sortable:false, resizable: false},
      		{label:'Test Script', name:'testScript', id:'testScript', width:40, align:'right', sortable:false, resizable: false},
      		{label:'HW (PCB)', name:'hwPcb', id:'hwPcb', width:40, align:'right', sortable:false, resizable: false},
      		{label:'Host Compliance', name:'hostCompliance', id:'hostCompliance', width:55, align:'right', sortable:false, resizable: false},
      		{label:'Unidentified', name:'unidentified', id:'unidentified', width:40, align:'right', sortable:false, resizable: false},
      		{label:'N/A', name:'na', id:'na', width:40, align:'right', sortable:false, resizable: false},
      		{label:'Unresolved', name:'ing', id:'ing', width:40, align:'right', sortable:false, resizable: false},
      		{label:'Total', name:'total', id:'total', width:50, align:'right', sortable:false, resizable: false},
      		{label:'', name:'grpIndex', id:'grpIndex', width:50, align:'right', hidden:true},
      		{label:'', name:'rowIndex', id:'rowIndex', width:50, align:'right', hidden:true},
      		{label:'', name:'colIndex', id:'colIndex', width:50, align:'right', hidden:true}
      	];
	
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
				
				initRowData();
			}
		});
	}
	
	function mergeHeader() {
		$("#jqGrid").jqGrid('setGroupHeaders', {
			useColSpanStyle: true, 
		  	groupHeaders:[{startColumnName: 'fwBug', numberOfColumns: 10, titleText: '<span>Confirmed</span>'}]
		});
	}
	
	function mergePhase(rowId, val, rowObj, cm, rowData) {
		var result = "";
		if(existDataYn == "Y") {
			if(rowObj.presumed == 'GRAND_TOTAL' || rowObj.presumed == 'SUB_TOTAL') {
				result = ' colspan=2';
			} else {
				if (rowObj.GRP_START == 'Y') {
		            result = ' style="background:white" rowspan=' + causeCnt;
		        } else {
		        	result = ' style="display:none"';
		        }
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
	
	function initRowData() {		
		var phase;
		var grpSeq, grpCnt, totCnt, totSeq, grpIndex;
		
		var stdRowData = [	{"presumed":"FW bug", "GRP_START":"Y"}
					  	  , {"presumed":"FW policy"}
					  	  , {"presumed":"NAND"}
					  	  , {"presumed":"Simulator / <br>Emulator"}
					  	  , {"presumed":"SoC"}
					  	  , {"presumed":"Test Script"}							  	  
					  	  , {"presumed":"HW (PCB)"}
					  	  , {"presumed":"Host Compliance"}
					  	  , {"presumed":"Unidentified"}
					  	  , {"presumed":"N/A"}
	  					];
		
		if(dataList.length > 0) {
			existDataYn = "Y";
			
			$.each(dataList, function(index, row) {
				phase = row.PHASE;
				grpSeq = row.GRP_SEQ;
				grpCnt = row.GRP_CNT;
				totCnt = row.TOT_CNT;
				totSeq = row.TOT_SEQ;
				grpIndex = row.GRP_INDEX;
				
				if(grpSeq == 1) {
					$.each(stdRowData, function(index, stdRow) {
						var newRow = $.extend({}, stdRow);
						newRow.phase = phase;	
						newRow.grpIndex = grpIndex;
						rowList.push(newRow);
					});
				}
				
				if(grpCnt == grpSeq) {
					var newRow = {};
					newRow.phase = phase + " Total";
					newRow.presumed = "SUB_TOTAL";
					newRow.grpIndex = grpIndex;
					rowList.push(newRow);
				}
				
				if(totCnt == totSeq) {
					var newRow = {};
					newRow.phase = "Total";
					newRow.presumed = "GRAND_TOTAL";
					rowList.push(newRow);
				}
			});
			
		} else {
			existDataYn = "N";
			
			var noData = [{"phase":"", "presumed":""}];
			$.each(noData, function(index, stdRow) {
				var newRow = $.extend({}, stdRow);
				rowList.push(newRow);
			});
		}
		
		drawGrid(rowList, gridModel);
	}
	
	function setCellData () {
		var rowIndex, colIndex, oldVal, newVal;
		var ingYn, ingOldVal, ingNewVal;
		
		$.each(dataList, function(index, row) {
			ingYn = row.ING_YN;
			rowIndex = (row.GRP_INDEX * (presumedCauseCnt + 1)) + row.ROW_INDEX ;//Y좌표값 보정
			colIndex = row.COL_INDEX + 1;//X좌표값 보정
			
			if(ingYn == 'N') {
				oldVal = Number($('#jqGrid').jqGrid('getCell', rowIndex, colIndex));
				newVal = oldVal + 1;
				$('#jqGrid').jqGrid('setCell', rowIndex, colIndex, newVal, '');
			} else if(ingYn == 'Y') {
				oldVal = Number($('#jqGrid').jqGrid('getCell', rowIndex, ingColIndex));
				newVal = oldVal + 1;
				$('#jqGrid').jqGrid('setCell', rowIndex, ingColIndex, newVal, '');
			}
		});
	}
	
	function setTotData() {
		var ids = $('#jqGrid').jqGrid('getDataIDs');
		var gridData = $('#jqGrid').jqGrid('getRowData');
		for(var i=0; i<gridData.length; i++) {
			if(gridData[i].presumed == 'SUB_TOTAL') {
				var keyArr = gridData[0];
				for(var key in keyArr) {
					$('#jqGrid').jqGrid('setCell', ids[i], key, '', {'background-color':'#d3d3d3','font-weight':'bold'});
				}
			} else if(gridData[i].presumed == 'GRAND_TOTAL') {
				var keyArr = gridData[0];
				for(var key in keyArr) {
					$('#jqGrid').jqGrid('setCell', ids[i], key, '', {'background-color':'#a9a9a9','font-weight':'bold'});
				}
			} else {
				var total=0;
				for(var key in causeArr) {
					total += Number($('#jqGrid').jqGrid('getCell', ids[i], causeArr[key]));
				}
				
				$('#jqGrid').jqGrid('setCell', ids[i], 'total', (total == 0 ? '' : total), {'font-weight':'bold'});
			}
		}
		
		gridData = $('#jqGrid').jqGrid('getRowData');
		var subTotArr = [];
		var grandTotArr = [];	
		var fwBug=0, fwPolicy=0, nand=0, simulatorEmulator=0, soc=0, testScript=0, hwPcb=0, hostCompliance=0, unidentified=0, na=0, ing=0, total=0;
		var fwBugTot=0, fwPolicyTot=0, nandTot=0, simulatorEmulatorTot=0, socTot=0, testScriptTot=0, hwPcbTot=0, hostComplianceTot=0, unidentifiedTot=0, naTot=0, ingTot=0, totalTot=0;
		for(var i=0; i<gridData.length; i++) {
			var dt = gridData[i];

			fwBug += Number(dt.fwBug);
			fwPolicy += Number(dt.fwPolicy);
			nand += Number(dt.nand);
			simulatorEmulator += Number(dt.simulatorEmulator);
			soc += Number(dt.soc);
			testScript += Number(dt.testScript);
			hwPcb += Number(dt.hwPcb);
			hostCompliance += Number(dt.hostCompliance);
			unidentified += Number(dt.unidentified);
			na += Number(dt.na);
			ing += Number(dt.ing);
			total += Number(dt.total);
			
			if(dt.presumed == 'SUB_TOTAL') {
				subTotArr.push(fwBug);
				subTotArr.push(fwPolicy);
				subTotArr.push(nand);
				subTotArr.push(simulatorEmulator);
				subTotArr.push(soc);
				subTotArr.push(testScript);
				subTotArr.push(hwPcb);
				subTotArr.push(hostCompliance);
				subTotArr.push(unidentified);
				subTotArr.push(na);
				subTotArr.push(ing);
				subTotArr.push(total);
				for(var key in subTotArr) {					
					$('#jqGrid').jqGrid('setCell', ids[i], Number(key) + 2, subTotArr[key] == 0 ? '' : subTotArr[key], {'font-weight':'bold'});
				}
				
				fwBugTot += fwBug;
				fwPolicyTot += fwPolicy;
				nandTot += nand;
				simulatorEmulatorTot += simulatorEmulator;
				socTot += soc;
				testScriptTot += testScript;
				hwPcbTot += hwPcb;
				hostComplianceTot += hostCompliance;
				unidentifiedTot += unidentified;
				naTot += na;
				ingTot += ing;
				totalTot += total;
				
				fwBug=0, fwPolicy=0, nand=0, simulatorEmulator=0, soc=0, testScript=0, hwPcb=0, hostCompliance=0, unidentified=0, na=0, ing=0, total=0;
				subTotArr = [];
				
			} else if(gridData[i].presumed == 'GRAND_TOTAL') {
				grandTotArr.push(fwBugTot);
				grandTotArr.push(fwPolicyTot);
				grandTotArr.push(nandTot);
				grandTotArr.push(simulatorEmulatorTot);
				grandTotArr.push(socTot);
				grandTotArr.push(testScriptTot);
				grandTotArr.push(hwPcbTot);
				grandTotArr.push(hostComplianceTot);
				grandTotArr.push(unidentifiedTot);
				grandTotArr.push(naTot);
				grandTotArr.push(ingTot);
				grandTotArr.push(totalTot);
				
				for(var key in grandTotArr) {					
					$('#jqGrid').jqGrid('setCell', ids[i], Number(key) + 2, grandTotArr[key] == 0 ? '' : grandTotArr[key], {'font-weight':'bold'});
				}
			}
		}
		
	}
	
	function drawGrid(pData,pModel) {
		var gridArrayData = pData;
		
		for(var i=0;i<gridArrayData.length;i++) {
			gridArrayData[i].id= i+1;
		}
		
		
		var options = {
			datatype: "local",
			data:gridArrayData,
			colModel: pModel,
			viewrecords: true ,
			decimalSeparator: ',' ,
			autowidth:true,
			//shrinkToFit:true,
			//fixed: true,
			gridView: false,
			//scroll:false,
			//forceFit:true,
			//width:'100%',
			//height:'100%',
			scrollOffset:15,
			rowNum: gridArrayData.length,
			loadComplete: function() {
				
				if(existDataYn == "Y") {
					var colArr = [2,3,4,5,6,7,8,9,10,11];
					var ids = $('#jqGrid').jqGrid('getDataIDs');
					var gridData = $('#jqGrid').jqGrid('getRowData');
					var grpIndex;
					for(var i=0; i<gridData.length; i++) {
						grpIndex = gridData[i].grpIndex;
						
						if(gridData[i].presumed != 'SUB_TOTAL' && gridData[i].presumed != 'GRAND_TOTAL') {
							$('#jqGrid').jqGrid('setCell', i+1, 0, '', {'color':'#00008b'});//Phase Color
							$('#jqGrid').jqGrid('setCell', i+1, 1, '', {'color':'#800000'});//Presumed Color
							
							//if(gridData[i].presumed != 'N/A') {
								//console.log(grpIndex+":"+i+":"+gridData[i].presumed);
								$('#jqGrid').jqGrid('setCell', i+1, colArr[i-(grpIndex*(causeCnt+1))], '', {'background-color':'#e6e6fa','font-weight':'bold'});
							//}
							
							//resolved
							$.each(colArr,function(j,col){
								var val = Number($('#jqGrid').jqGrid('getCell', i+1, col));
								var cursor = val > 0 ? 'pointer': '';
								$('#jqGrid').jqGrid('setCell', i+1, col, '', {cursor: cursor});
							});
							
							//unresolved
							var val = Number($('#jqGrid').jqGrid('getCell', i+1, 12));
							var cursor = val > 0 ? 'pointer': '';
							$('#jqGrid').jqGrid('setCell', i+1, 12, '', {cursor: cursor});
							
						}
					}
				}
			},
			gridComplete:function() {
				
				mergeHeader();
				
				var headerRow = $("[role='columnheader']");
				headerRow.css({'color':'white', 'background':'#696969'});
				
				//var presumedCol = $('#jqGrid_presumed');
				//presumedCol.css('color','#800000');
				
				if(existDataYn == "Y") {
					setCellData();
					setTotData();
				} else {
					var td = $('td[role=gridcell]').remove();
					var tr = $('[role=row][id=1]').append('<td role="gridcell" colspan=' + (causeCnt+4) + ' style="text-align:center;" title="" aria-describedby="jqGrid_phase">No Data</td>');
				}
			},
			loadError:function(shr, status, error) {
				alert(error);
			},
			onCellSelect: function (rowId, iCol, content, event) {
			 	
				if(  iCol >= 2 && iCol <= 12){
					var val = Number($('#jqGrid').jqGrid('getCell', rowId, iCol));
					if(val > 0){
						var cm = jQuery("#jqGrid").jqGrid("getGridParam", "colModel");
						var confirmedCause = cm[iCol].label.replace('<br>','');
						var rowData = jQuery(this).getRowData(rowId);	
						//var rawDataPre = [];
						var rawData = [];
						if(confirmedCause=='Unresolved'){
							rawData = dataFilter(dataList,
									[{col:'PHASE',val:rowData.phase},
									 {col:'PRESUMED_CAUSE',val:rowData.presumed.replace('<br>','')},
									 {col:'ING_YN',val: 'Y' }
									 ]);
						}else{
							rawData = dataFilter(dataList,
									[{col:'PHASE',val:rowData.phase},
									 {col:'PRESUMED_CAUSE',val:rowData.presumed.replace('<br>','')},
									 {col:'CONFIRMED_CAUSE',val: cm[iCol].label.replace('<br>','')},
									 {col:'ING_YN',val: 'N' }
									 ]);
						}
						
						/* $.each(rawDataPre,function(){
							if(this.PROJECT_KEY != 'SAF')
								rawData.push(this);
						}); */
						
						
						
						var phaseId = rawData[0].PHASE_ID;
						var phaseNm = rawData[0].PHASE;
						var url = "http://jira.skhynix.com/issues/?jql=";
						url += "(";
						url += "(\"issue to\" is not EMPTY or \"Discovered from\" is not EMPTY)";
						url += " and \"Presumed cause\"=\"" + rowData.presumed.replace('<br>','') +"\"";
						
						if(confirmedCause == 'N/A'){
							// N/A이 경우 issue_num을 넘긴다.
							url += " and \"key\" in(";
							var keys = groupbyCount(rawData,['PROJECT_KEY','ISSUE_NUM']);
							$.each(keys,function(i){
								if(i>0)
									url += ",";
								url += "\"" + this.PROJECT_KEY +"-"+ this.ISSUE_NUM+ "\"";
							});
							url += "))";
						}							
						else{
							url += " and \"PMS Phase\"=\"" + phaseNm+"\"";
							
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
							if(confirmedCause != 'Unresolved'){
								url += " and \"Confirmed cause\"=\"" +confirmedCause +"\"";
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
							
						}
							
						
			    		hsClick(url,this);
					}
					
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
	
	function adjustGrid() {
		$("#jqGrid").jqGrid('setGridWidth',$("#containerGrid").width() - 5 );
		$("#jqGrid").jqGrid('setGridHeight',$("#containerGrid").height() - 60 );
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
</style>

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
