<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="txt/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<%@include file="include/ssd_top.jsp" %>
<title>2018</title>
<style>
	.handsontable table thead th{
        background-color: #eef3fd;
        font-weight:bold;
        font-size:12px;
    }
    .handsontable table td{
        background-color: #FFFFFF;
        font-weight:bold;
        font-size:12px;
    }
    
    .ht_master tr > td.foo {
	  background-color: #e0e2e5;
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
	
	/**progress circle */
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
</style>

</head>
<body>
	<div id="lay_wrap" class="lay_col2 lay_100">
		<div id="lay_container">
			<div id="lay_contents">
                <!-- Tab master -->
                <div class="tab_master">
					<div class="tab_master_wrap">
						<div class="tab_list_wrap">
                            <ul class="tab_list">
                                <li class="tab_item"> 
                                    <a href="#" class="tab_link" onclick="dashboardShow('_self','/dashboard/generic.html?viewName=ssd_sm/test_master_mgmt');">Test Mgmt. System - Master Mgmt.</a>
                                </li>
                                <li class="tab_item selected">
                                    <a href="#" class="tab_link">Test Mgmt. System - Test Set Mgmt.</a>
                                </li>
                                <li class="tab_item">
                                    <a href="#" class="tab_link" onclick="dashboardShow('_self','/dashboard/generic.html?viewName=ssd_sm/test_map_project_mgmt');">Map Test Project - Test Set.</a>
                                </li>
                            </ul>
                        </div>
					</div>
                </div>
				<script>
					$(document).ready(function(){
						tabMove('.tab_master');
                        tab_view('.tab_master', false, false);    
					})
				</script>
				<!--// Tab master -->
                <div class="contents_wrap">
                    <!-- Location Information -->
                    <!-- <div class="loc_info_basic">
                        <span class="location_box">
                            <a href="#" class="location"><span class="loc_info_ico loc_info_ico_home"></span>Home</a>
                        </span>
                        <span class="loc_info_ico loc_info_ico_arr_depth"></span>
                        <span class="location_box">
                            <a href="#" class="location">1Depth Menu</a>
                        </span>
                        <span class="loc_info_ico loc_info_ico_arr_depth"></span>
                        <span class="location_box">
                            <a href="#" class="location">2Depth Menu</a>
                        </span>
                        <span class="loc_info_ico loc_info_ico_arr_depth"></span>
                        <span class="location_box">
                            <span class="location">3Depth Menu</span>
                        </span>
                    </div> -->
                    <!-- //Location Information -->
                    <!-- Page Title -->
                    <table class="page_tit">
                        <tr>
                            <td class="tit_area">
                                <div class="tit">Test Management</div>
                            </td>
                        </tr>
                    </table>
                    <!-- //Page Title -->
                     <!-- Search Type01 -->
                    <div class="srch_type01">
                        <div class="condition_area">
                            <table class="condition_table" summary="검색조건 테이블">
                                <caption>검색조건 테이블</caption>
                                <tbody>
                                    <tr>
                                        <th scope="col" class="condition_t_head">Model Name</th>
                                        <td class="condition_t_data">
                                            <select class="jqForm" name="searchModelName" id="searchModelName" multiple="multiple" style="width:150px;" onkeydown="javascript:enterkeyDown();">
                                                <option value="">---ALL---</option>
                                            </select>
                                        </td>
                                        <th scope="col" class="condition_t_head">Test Type</th>
                                        <td class="condition_t_data">
                                            <!-- <input type="checkbox" class="jqForm" id="srch_chbox00" name="srch_group1" checked="checked" ><label for="srch_chbox00">checked</label>
                                            <input type="checkbox" class="jqForm" id="srch_chbox01" name="srch_group1"><label for="srch_chbox01">Unchecked</label> -->
                                            <select class="jqForm" name="searchTestType" id="searchTestType" multiple="multiple" style="width:150px;" onkeydown="javascript:enterkeyDown();">
                                                <option value="">---ALL---</option>
                                            </select>
                                        </td>
                                        <th scope="col" class="condition_t_head">Test Set</th>
                                        <td class="condition_t_data">
                                            <select class="jqForm" name="searchTestSet" id="searchTestSet" multiple="multiple" style="width:110px;" onkeydown="javascript:enterkeyDown();">
                                                <option value="">---ALL---</option>
                                            </select>
                                        </td>
                                        
                                    </tr>
                                   
                                </tbody>
                            </table>
                        </div>
                        <div class="btn_area" style="width:140px">
                            <a href="javascript:btnClick('clearBtn');" class="btn_txt btn_srch btn_color_c">
                                <span class="txt">Clear</span>
                            </a>
                            <a href="javascript:btnClick('searchBtn');" class="btn_txt btn_srch btn_color_d">
                                <span class="txt">Search</span>
                            </a>
                        </div>
                    </div>
                    <!-- //Search Type01 -->
                   
                    <!-- Tab Contents -->
                    <div class="tab_contents_wrap" rel="contentsTab">
                        <div class="tab_contents" id="contentsTab_01">
                            <!-- Sub Title -->
                            <div class="opt_tit">
                                <div class="opt_tit_left">
                                    <div class="elmt">
                                        <span class="opt_tit_bu opt_tit_bu_01"></span>
                                        <span class="txt">Test set</span>
                                    </div>
                                </div>
                                <div class="opt_tit_right">
                                    <div class="elmt">
                                        <a href="javascript:btnClick('addBtn');" class="btn_txt btn_type_c btn_color_a">
                                            <span class="txt" id="addBtn" style="vertical-align: text-top">ADD</span>
                                        </a>
                                        <a href="javascript:btnClick('editBtn1');" class="btn_txt btn_type_c btn_color_b">
                                            <span class="txt" id="editBtn1" style="vertical-align: text-top">EDIT</span>
                                        </a>
                                        
                                    </div>
                                </div>
                            </div>
                            <!-- //Sub Title -->
                            <!-- Board List 1 -->
                            <div class="board_list">
                                <!-- <div id="contentMain" style="margin-top: 10px;width: 100%;"></div> -->
                                <div id="excelTableList1" style="margin-top: 10px;width: 100%;"></div>
                            </div>
                            <!-- //Board List 1 -->
                            <!-- Page Navigation -->
                            <div class="nav_paging">
    							<div class="nav_paging_wrap" id="demo_page">
    							</div>
   							</div>
                            <!-- //Page Navigation -->
                            <!-- Button List 3 -->
                            <div class="opt_tit" style="margin-top:10px; display: none;"  id="cancelBlock">
                                <div class="opt_tit_right">
                                    <div class="elmt">
                                        <a href="javascript:btnClick('cancelBtn');" class="btn_txt btn_type_c btn_color_C">
                                            <span class="txt" id="cancelBtn" style="vertical-align: text-top">CANCEL</span>
                                        </a>
                                    </div>	
                                </div>
                            </div>
                            <!-- //Button List 3 -->
                        </div>
                    </div>
                    <script>
                    $(document).ready(function(){
                        tab_view('#contentsTab', true, false)
                    })
                    </script>
                    <!-- //Tab Contents -->
                </div>
            </div>
		</div>
	</div>
	
</form>
<script type="text/javascript">
	var testTypeCombo, modelNameSearch, testTypeSearch, testSetSearch = [];
	var totRowCnt = 0;
	var page = 1;
	var pageSize = 10;
	var rows = 50;
	var options;
	var loginUserId;
	
	$(document).ready(function(){
		var paramObj = ["00"];		//추후 다시 sql 에서 foreach가 안먹힘
		var searchObj = "Y";
		
		loginUserId = $('#userId').val()==''?'SYSTEM':$('#userId').val();
		
		/**
		* 그리드 내에 필요한 Combobox를 셋팅하기 위한 기본 코드 조회 
		*/
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_sm.commonComboSearch",
			data: { 
						filters: JSON.stringify({commCdType:paramObj}),
						testSetSearch:searchObj,
					},	
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			    var data = res.dataList;
			    selectboxSetting(data);
			},
			error : function(err){
				alert("Error : " + err.statusText);
			}
			
		});
		
		/**
		* search area Combobox를 셋팅하기 위한 코드 조회
		*/
		
		
		//Test set. 목록을 가져온다.
	    getTestSetList(1);
	});
	
	var selectboxSetting = function(data){
		var temp1 = new Array();
	    
	    for(var i = 0; i < data.length; i++){
	    	if( data[i].COMM_TYPE == '00' ){
	    		temp1.push(data[i].COMM_VALUE);	
	    	}
	    }
	    
	    testTypeCombo = temp1;
	    
	  //search 영역 그리기
	    drawSearchArea(data);
	}
	
	/**
	* HandsOnTable Grid 셋팅
	*/
	var hot1Element = document.querySelector('#excelTableList1');
	var hot1ElementContainer = hot1Element.parentNode;
	var hot1Settings = {
		data: hot1GridData,
		columns: [
		{
		  	data: 'ROW_STATUS',
		    type: 'text',
		    editor:false,
		    readOnly:true,
		    className:'htCenter htMiddle'
	    },
	    {
		  	data: 'TEST_SET_IDX',
		    type: 'text',
		    editor:false,
		    readOnly:true,
	    },
  		{
		  	data: 'MODEL_NAME',
		    type: 'text',
		    editor:false,
		    readOnly:true,
	    },
	    {
	      	data: 'TEST_TYPE',
	      	type: 'text',
	      	editor:false,
	      	readOnly:true,
	    },
	    {
	      	data: 'TEST_SET',
	      	type: 'text',
	      	editor:false,
	      	readOnly:true,
	    },
	    {
	      	data: 'TOTAL_TEST_COUNT',
	      	type: 'text',
	      	editor:false,
	      	readOnly:true,
	    },
	    {
	      	data: 'SET_DEFAULT',
	      	type: 'text',
	      	editor:false,
	      	readOnly:true,
	    },
		{
	    	data: 'STATUS',
	    	type: 'text',
	      	editor:false,
	      	readOnly:true,
	    },
	    {
	      	data: 'OWNER',
	      	type: 'text',
	      	editor:false,
	      	readOnly:true,
	    },
	    {
	      	data: 'CRT_BY',
	      	type: 'text',
	      	width:'150px',
	      	editor:false,
	      	readOnly:true,
	    },
	    {
	      	data: 'CRT_DT',
	      	type: 'text',
	      	editor:false,
	      	readOnly:true,
	    },
	    {
	      	data: 'MOD_BY',
	      	type: 'text',
	      	editor:false,
	      	readOnly:true,
	    },
	    {
	      	data: 'MOD_DT',
	      	type: 'text',
	      	editor:false,
	      	readOnly:true,
	    },
	],
	  stretchH: 'all',
	  width: '100%',
	  autoWrapRow: true,
	  height: 887,
	  //maxRows: 22,
	  startRows: 1,
	  startCols: 1,
	  //fixedRowsBottom: 1,
	  //minSpareRows: 1,
	  manualRowResize: true,
	  manualColumnResize: true,
	  rowHeaders: true,
	  colHeaders: [
		  	'Stat'
		  	,'Test Set Idx'
		  	,'Model Name'
			,'Test Type'
			,'Test Set'
			,'Total Test Count'
			,'Set Default'
			,'Status'
			,'Owner'
			,'Create by'
			,'Create date'
			,'Update By'
			,'Update date'
	  ],
	  manualRowMove: true,	//로우 드래그앤 드랍 위치이동
	  manualColumnMove: true, 	//컬럼 드래그앤 드랍 위치이동
	  contextMenu: true,	//우클릭시 컨텍스트. 컨텍스트 내용 추가, 제거 가능
	  filters: true,				//header의 필터내용 여부
	  //dropdownMenu: true,	//특정 col의 dropdown 허용
	  dropdownMenu: ['filter_by_condition', 'filter_action_bar', 'filter_by_value'],
	  allowInvalid:false,		//dropdown List 의 수정을 리스트내에서만 수정가능하게 함.
	  hiddenColumns : {
		  columns : [1],
		  indicators:false,
	  },
	  fillHandle: {
	  	  autoInsertRow: true,
	  },
	  copyPaste: { 
		  rowsLimit: 1000,
	  },
	  afterChange: function (change, source) {		//그리드 내 Cell 의 변경이 일어난 직후 호출 함수
		  	if (source == 'CopyPaste.paste') {			//Copy & Paste 시 로딩서클 숨김
		    	$("#loader").hide();
		    }
	  
		  	if(source == 'loadData' || source == 'editStat') {return;}
		  	
		  	var isDelArr = new Array();
	  		
		  	for(var i=0; i < change.length; i++){
		  		var isNull = true;		//행전체를 선택 후 Delete 버튼 누를 경우 I도 지움.
		  		var index = change[i][0];
		  		var nnKey = hot1.getDataAtCell(change[i][0], 'MODEL_NAME');
		  		
		  		if( '' != nnKey && null != nnKey  ){
		  			
		  			if( change[i][2] != change[i][3] && hot1.getDataAtCell(index, 0) != 'I' ){
				   		hot1.setDataAtCell(index, 0, 'U','editStat');
				   	}	
		  		}else if( '' == nnKey){
		  			
		  			if(change[i][2] == null){
	  					isNull = false;
	  				}
		  			
	  				if(!isNull){
	  					hot1.setDataAtCell(index, 0, 'I','editStat');		
	  				}else{
	  					/* hot1.setDataAtCell(index, 0, '','editStat');
	  					if(hot1.isEmptyRow(index)){
	  						isDelArr.push(index);
	  					}	 */
	  				}
		  		}
		  	}
		  	
		  	//행삭제
		  	var result = removeDuplicateArr(isDelArr);
			$.each(result, function (index, element){
			    hot1.alter('remove_row', element);
			});
			
		  	var currentRows = hot1.countRows();
		    $('#currentCnt').text(currentRows);
		},
		afterOnCellMouseDown: function(event, coords, td) {	//클릭시 이벤트(클릭의 타이밍을 체크하여 더블클릭시 로직 진행) - https://github.com/handsontable/handsontable/issues/4087 참조
			var now = new Date().getTime();
			// check if dbl-clicked within 1/5th of a second. change 200 (milliseconds) to other value if you want
			if(!(td.lastClick && now - td.lastClick < 200)) {
				td.lastClick = now;
			    return; // no double-click detected
			}

			// double-click code goes here
			//console.log('double clicked');
			// 기존 Data 에서 더블클릭시 Master 선택 Popup 
			var cells = hot1.getSelected();
			var selRow = cells[0][0];
			
			if( hot1.getDataAtCell(selRow, 2) != '' && hot1.getDataAtCell(selRow, 3) != '' && hot1.getDataAtCell(selRow, 4) != '' ){		// Model Name NN, Test Type NN, Test Set NN
				if( hot1.getDataAtCell(selRow, 0) != null ){
					alert("Save and proceed.");
					return;
				}else if( hot1.getDataAtCell(selRow, 8) != loginUserId && hot1.getDataAtCell(selRow, 7) == 'Editing' ){
					alert(hot1.getDataAtCell(selRow, 8) + " is editing.");
					return;
				}else{
					var newwin = window.open("", "SSD_TEST_SET_POP1", "width=1200px,height=820px,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
					var oFrm = document.getElementById("form1");
					oFrm.testSetIdx.value = hot1.getDataAtCell(selRow, 1);
					oFrm.modelName.value = hot1.getDataAtCell(selRow, 2);
					oFrm.testType.value = hot1.getDataAtCell(selRow, 3);
					oFrm.testSet.value = hot1.getDataAtCell(selRow, 4);
					//oFrm.menuAuthId.value = "MNU20150422131320740";
					//oFrm.action =  '/dashboard/generic.html?viewName=corona_manage_script';
					oFrm.action =  '/dashboard/generic.html?viewName=ssd_sm/test_set_pop1';
					oFrm.method = "post";
					oFrm.target = 'SSD_TEST_SET_POP1'; 
					oFrm.submit();
					newwin.focus();
				}
			}
			
		},
		afterCreateRow : function(index, amount, source){
			hot1.setDataAtCell(index, 0, 'I');
		},
		afterLoadData : function(firstTime){
			$("#loader").hide();
		},
		beforePaste : function(data, coords){		//Copy & Paste 시 로딩서클 로드
			$("#loader").show();
			/* var row = hot1.countRows();
			hot1.alter('insert_row', row, data.length); */
		},
	};

	var hot1 = new Handsontable(hot1Element, hot1Settings);
	
	var hot1GridData;
	
	/**
	* 전체 Test Set 리스트를 가지고 온다.
	*/
	var getTestSetList = function(pPage){
		var flagText = $('#editBtn1').text();
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_sm.testSet.all",
			data:{ 
						page:pPage, rows:rows, 
						filters: JSON.stringify({
													searchModelName : $('#searchModelName').val() == null ? [] : $('#searchModelName').val(),
													searchTestType : $('#searchTestType').val() == null ? []:$('#searchTestType').val(),
													searchTestSet : $('#searchTestSet').val() == null ? []:$('#searchTestSet').val(),
													}),
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			    var data = res.dataList;
			    /* if(flag == 'more'){
				    for(var j=0; j < data.length; j++){
				    	hot1GridData.push(data[j]);
				    }
				    hot1.updateSettings({data:hot1GridData});
			    }else{
			    	hot1GridData = data;
				    hot1.loadData(hot1GridData);
			    } */
			    hot1GridData = data;
			    hot1.loadData(hot1GridData);
			    
			    page = pPage;
			    totRowCnt = (res.dataList.length== 0 ? 0 : res.dataList[0].TOT_CNT);
			    
			    //paging
			    var page_viewList = Paging(
			    								(res.dataList.length== 0) ? 0 : res.dataList[0].TOT_CNT, 
			    								rows, 
			    								pageSize,
			    								page, 
			    								"getTestSetList"
			    							); 
			    $("#demo_page").empty().html(page_viewList);
			    
				//현재 Edit or Save 버튼에 따라 해당 모드로 그리드 상태 셋팅			    
			    gridUpdateSetting(hot1, getEditableParam(hot1, flagText.toLowerCase()));
			}
		});	
	}
	
	/**
	* 그리드의 셋팅을 업데이트 한다.
	*/
	var gridUpdateSetting = function(hContainer, param){
		hContainer.updateSettings(param);
	}
	
	/**
	* 화면상 버튼들 컨트롤
	*/
	var btnClick = function(btn){
		this.btnSetting(btn);	//버튼 문구 Toggle
	}
	
	/**선택한 그리드 삭제*/
	var gridDel = function(){
	    var selection = container.handsontable('getSelected');
	    container.handsontable('alter','remove_row',selection[0],selection[2]);
	}
	
	/**버튼 Toggle*/
	var btnSetting = function(btn){
		if( btn == 'addBtn'){
			gridUpdateSetting(hot1, getEditableParam(hot1, 'save'));
			var row = hot1.countRows();
			hot1.alter('insert_row', row);
			gridEditableSetting(hot1, row);
			$('#editBtn1').html('SAVE');
			$('#cancelBlock').show();
			/* hot1.alter('insert_row', row, 1500);
			for(var i = row; i < (1500+row); i++){
				hot1.setDataAtCell(row, 0, 'I','editStat');
			}
			rowEditableChange(hot1); */
			
			
		}else if( btn == 'editBtn1' ){
			if( $('#editBtn1').html() == 'EDIT' ) {
				if(hot1.countRows() == 0){
					alert("No rows to edit.");
					return;
				}
				$('#editBtn1').html('SAVE');
				$('#cancelBlock').show();
				gridUpdateSetting(hot1, getEditableParam(hot1, 'save'));
			}else {
				excelGridAllSave(hot1);	//save 완료가 되었다면, 화면의 btn toggle
			}
			
		}else if(btn == 'moreBtn' ){
			/* var compareTotCnt = totRowCnt;
			var compareCurCnt = hot1.countRows();
			if( compareTotCnt <=  compareCurCnt ){
				alert("Currently the last row.");
				return;
			}
			getTestSetList('more'); */
		}else if(btn == 'searchBtn'){
			page=1;
			getTestSetList(page);
		}else if(btn == 'cancelBtn'){
			if( !hot1.isEmptyCol(0) ){
				if(confirm("There are revised contents. Do you want to initialize?")){
					$('#editBtn').html('EDIT');
					$('#cancelBlock').hide();
					gridUpdateSetting(hot1, getEditableParam('edit'));
					page = 1;
					//page--;
					getTestSetList(page);
				}else{
					return;
				}
			}else{
				$('#editBtn').html('EDIT');
				$('#cancelBlock').hide();
				gridUpdateSetting(hot1, getEditableParam('edit'));
				page = 1;
				//page--;
				getTestSetList(page);
			}
		}else if(btn == 'clearBtn'){
			/* $('.condition_table').find(':input').each(function(){
				switch(this.type){
					case 'select-multiple' :
						$(this).selectedIndex = 0; 
		                break;
					case 'select-one':
				}
			}) */
			$("#searchModelName, #searchTestType, #searchTestSet").multiselect("uncheckAll");
		}
	}
	
	var gridEditableSetting = function(htContainer, row){
		htContainer.setDataAtCell(row, 0, 'I','editStat');
		rowEditableChange(htContainer);
	}
	
	var rowEditableChange = function(htContainer){
			htContainer.updateSettings({
				cells : function(row, col, prop){
					var cellProperties = {};
					if( htContainer.getDataAtCell(row, 0) == 'I' ){
						if( prop === 'MODEL_NAME' 
							|| prop === 'TEST_SET'
							){
							cellProperties.readOnly = false;
							cellProperties.editor = 'text';
							cellProperties.validator = notEmpty;
							cellProperties.allowInvalid = true;
							cellProperties.readOnly = false;
							cellProperties.className='';
						}else if(prop === 'TEST_TYPE'){
							cellProperties.type = 'dropdown';
							cellProperties.source = testTypeCombo;
							cellProperties.width = '100px';
							cellProperties.validator = notEmpty;
							cellProperties.allowInvalid = true;
							cellProperties.readOnly = false;
							cellProperties.className='';
						}else if ( prop === 'SET_DEFAULT' ){
							cellProperties.type = 'dropdown';
							cellProperties.source = ['Y','N'];
							cellProperties.readOnly = false;
						}else if(prop === 'CRT_DT' || prop === 'MOD_DT' || prop === 'TOTAL_TEST_COUNT' 
								|| prop === 'OWNER' || prop === 'CRT_BY'|| prop === 'MOD_BY' || prop ==='STATUS'){
							cellProperties.type = 'text';
							cellProperties.readOnly = true;
						}
					} else {
						if ( prop === 'SET_DEFAULT' ){
							cellProperties.type = 'dropdown';
							cellProperties.source = ['Y','N'];
							cellProperties.readOnly = false;
						}
					}
					
					return cellProperties;
				}
			});
	}
	
	/** 컨텍스트 메뉴(우버튼클릭 메뉴)에서 5줄 추가*/
	var fiveRowsAppend = function(){
		hot13.updateSettings({
		    contextMenu: {
		      items: {
		        "row_above": {
		          name: 'Add 5 rows above',
		          callback: function(key, options) {
		            hot13.alter('insert_row', hot13.getSelected()[0], 5)
		          }
		        },
		        "row_below": {
		          name: 'Add 5 rows below',
		          callback: function(key, options) {
		            hot13.alter('insert_row', hot13.getSelected()[0]+1, 5)
		          }
		        }
		      }
		    }
		  })
	}
	
	/**
	* 그리드의 모드 변환.
	*/
	var getEditableParam = function(hContainer, flag){
		var updateParam='';
		var today = getTodate();
		
		if(flag == 'save'){
			updateParam = {
					columnSorting: true,
					contextMenu:{
						callback: function (key, options) {
							if (key === 'about') {
								setTimeout(function () {
									// timeout is used to make sure the menu collapsed before alert is shown
						            alert("This is a context menu with default and custom options mixed");
								}, 100);
							}
						},
						items: {
							"row_above" : {
						        callback : function(key, options) {
						        	hot1.alter('insert_row', options[0].end.row, 1);
						        	rowEditableChange(hot1);
						        	$('#editBtn1').html('SAVE');
									$('#cancelBlock').show();
						        }
							},
							"row_below" : {
								callback : function(key, options) {
									hot1.alter('insert_row', options[0].end.row+1, 1);
									rowEditableChange(hot1);
									$('#editBtn1').html('SAVE');
									$('#cancelBlock').show();	
								}
							},
							"hsep1": "---------",
							"remove_row" : {
								callback : function(key, options) {
									var sRowIdx = options[0].start.row;
									var eRowIdx = options[0].end.row;
									var isDelArr = new Array();
									for(var i = sRowIdx; i <= eRowIdx; i++) {
										var statCd = hot1.getDataAtCell(i, 0);
										if(statCd == 'I'){
											isDelArr.push(i);		
										}
									}
									
									var result = removeDuplicateArr(isDelArr);
									$.each(result, function (index, element){
										hot1.alter('remove_row', element);
									});
						        },
							},
							"hsep2": "---------",
							"undo" : {},
							"redo" : {},
							"hsep3": "---------",
							"export" : {
								name: 'Export to CSV',
								callback: function(key, options) {
									hot1.getPlugin('exportFile').downloadFile('csv', {
										filename: 'Master Mgmt_'+today,
									});
								}
							},
							"about": {
								name: 'About this menu',
								callback: function(key, options) {
									
								}
							}
						}
					},
					columns: [
				  		{
						  	data: 'ROW_STATUS',
						    type: 'text',
						    editor:false,
						    readOnly:true,
						    className:'htCenter htMiddle foo'
					    },
					    {
						  	data: 'TEST_SET_IDX',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
				  		{
						  	data: 'MODEL_NAME',
						    type: 'text',
						    editor:false,
						    readOnly:true,
						    className:'foo',
					    },
					    {
					      	data: 'TEST_TYPE',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'TEST_SET',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'TOTAL_TEST_COUNT',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
						{
						  	data: 'SET_DEFAULT',
						  	type: 'dropdown',
						  	source: ['Y','N'],
						  	validator: notEmpty,
						  	allowInvalid:true,
					    },
					    {
					      	data: 'STATUS',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'OWNER',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'CRT_BY',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'CRT_DT',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'MOD_BY',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'MOD_DT',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					],
			}
		}else{
			updateParam = {
					columnSorting: true,
					contextMenu:
				    	['undo','redo'],
					columns: [
						{
						  	data: 'ROW_STATUS',
						    type: 'text',
						    editor:false,
						    readOnly:true,
						    className:'htCenter htMiddle foo'
					    },
					    {
						  	data: 'TEST_SET_IDX',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
				  		{
						  	data: 'MODEL_NAME',
						    type: 'text',
						    editor:false,
						    readOnly:true,
						    className:'foo',
					    },
					    {
					      	data: 'TEST_TYPE',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'TEST_SET',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'TOTAL_TEST_COUNT',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
						{
						  	data: 'SET_DEFAULT',
						  	type: 'dropdown',
						  	source: ['Y','N'],
						  	validator: notEmpty,
						  	allowInvalid:true,
						  	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'STATUS',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'OWNER',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'CRT_BY',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'CRT_DT',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'MOD_BY',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					    {
					      	data: 'MOD_DT',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	className:'foo',
					    },
					],
			}
		}
		return updateParam;		
	}
	
	/**
	* 그리드 모든 데이터 저장
	*/
	var excelGridAllSave = function(){
		//그리드내 변경이 없을때
		if( hot1.isEmptyCol(0) ){
			alert("There are no changes.");
			$('#editBtn1').html('EDIT');
			$('#cancelBlock').hide();
			gridUpdateSetting(hot1, getEditableParam(hot1, 'edit'));
 			return false;
		}
		
		hot1.validateCells(function(isPass){
			
			if(isPass){
				if(confirm("Do you want to save all?")){
					var data = hot1.getData();
					var paramObj = new Array();
					for(var i=0; i < data.length; i++){
						if(hot1.getDataAtCell(i, 0) != '' & hot1.getDataAtCell(i, 0) != null){
							var tempObj = new Object();
							tempObj.rStatus 			= nvl(data[i][0],'');
							tempObj.testSetIdx		= nvl(data[i][1],'');
							tempObj.modelName 		= nvl(data[i][2],'');
							tempObj.testType		= nvl(data[i][3],'');
							tempObj.testSet			= nvl(data[i][4],'');
							tempObj.totalTestCount= nvl(data[i][5],'');
							tempObj.setDefault		= nvl(data[i][6],'');
							tempObj.status	 		= nvl(data[i][7],'');
							tempObj.owner	 		= loginUserId;
							tempObj.crt_by			= loginUserId;
							tempObj.crt_dt				= nvl(data[i][10],'');
							tempObj.mod_by			= loginUserId;
							tempObj.mod_dt			= nvl(data[i][12],'');
							paramObj.push(tempObj);
						}
					}
					
					$.ajax({
		       			url: "/dashboard/genericAllSaveJson.html?sqlid=dashboard.ssd_sm.testSetGridSave",
		        		dataType: "json",
		        		type: "POST",
		        		async : true,
				        data: {
				        	autoJson: JSON.stringify(paramObj)
		           		}, 
		        		success: function (data) {
		        			alert("You have saved "+data.resultCnt+" cases in total.");
		        			// 정상 save 시 버튼 토글
		        			$('#editBtn1').html('EDIT');
		        			$('#cancelBlock').hide();
							gridUpdateSetting(hot1, getEditableParam(hot1, 'edit'));
							
							page = 1;
							getTestSetList(page);
		        		},
		        		error: function (err) {
		                    $('#container').html('Error: ' + err.statusText);
		                }
			      	});
				}else{
					return;
				}
				
			}else{
				alert("Please fill in the required fields");
				$('#cancelBlock').show();
				return;
			}
		});
		//$('#excelTableList').handsontable('render');
	}
	
	//null문자열을  '' 으로 변환
	function nvl(str, defaultStr){
        if(typeof str == "undefined" || str == null )
            str = defaultStr ;
        return str ;
    }

	var notEmpty = function(value, callback){
		if (!value || String(value).length === 0) {
	        callback(false);
	    } else {
	        callback(true);
	        //console.log(this.row);
	        //console.log(this.col);
	    }
	}
	
	var getTodate = function(){
		var today = new Date();
		var dd = today.getDate();
		var mm = today.getMonth()+1; //January is 0!
		var yyyy = today.getFullYear();

		if(dd<10) {
		    dd='0'+dd
		} 

		if(mm<10) {
		    mm='0'+mm
		} 

		today = mm+'/'+dd+'/'+yyyy;
		
		return today;
	}
	
	/**
	* Enter Key event
	*/
	var enterkeyDown = function(){
		if (window.event.keyCode == 13) {
			
	    }
	}
	 
	function dashboardShow(target,action){
		
		var oFrm = document.getElementById("form1");
		
		var target = target;
		oFrm.action =  action;
		oFrm.method = "post";
		oFrm.target = target; 
	    oFrm.submit();
		
	}
	
	/**
	* 중복된 배열을 삭제하고, 배열을 내림차순 정리하여 return. (삭제할 행들의 배열을 정리)
	*/
	var removeDuplicateArr = function(arr){
		var result = [];
		var resultText = '';
		$.each(arr, function (index, element){
		    if ($.inArray(element, result) == -1){
		        result.push(element);
		        resultText += element + '\r\n';
		    }
		});
		
		//배열 역순 정렬
		result.sort(function(a,b){return b-a});
		
		return result;
	}
	
	/**
	* Copy창을 close가 아닌 x로 닫았을때 상태 업데이트
	*/
	var closeStatUpdate = function(status, pTestSetIdx){
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericSaveJson.html?sqlid=dashboard.ssd_sm.testSet.statusUpdate",
			data:{ 
						status : status, 
						testSetIdx : nvl(pTestSetIdx,''),
						loginUserId : loginUserId,
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
		    	var data = res;
		    	getTestSetList(page);
			},
			error : function(err){
				alert("Error1 : " + err.statusText);
				setTestSetStatUpdate('Released');		//테스트 셋의 상태를 업데이트 한다.
			}
		});	
	}
	
	/**
	* 검색영역 select box 그리기
	*/
	var drawSearchArea = function(data){
		var html20 = '';
		var html21 = '';
		var html22 = '';
		
		for(var i=0; i < data.length; i++){
			if( data[i].COMM_TYPE == '20' ){
				html20 += '<option value="'+data[i].COMM_VALUE+'">'+data[i].COMM_VALUE+'</option>';	
			}else if( data[i].COMM_TYPE == '21' ){
				html21 += '<option value="'+data[i].COMM_VALUE+'">'+data[i].COMM_VALUE+'</option>';	
			}else if( data[i].COMM_TYPE == '22' ){
				html22 += '<option value="'+data[i].COMM_VALUE+'">'+data[i].COMM_VALUE+'</option>';	
			}
		}

		$('#searchModelName').html(html20);
		$('#searchTestType').html(html21);
		$('#searchTestSet').html(html22);
		
		var select = $("#searchModelName, #searchTestType, #searchTestSet").multiselect({
			selectedList: 1,
			height:100,
			width:'80%',
			selectedText: 'Item # selected',
			noneSelectedText: 'Select Items',
			minWidth:155
		});
	}
</script>
<form name="form1" id="form1">
<input type="hidden" name="testSetIdx" value=""/>
<input type="hidden" name="modelName" value=""/>
<input type="hidden" name="testType" value=""/>
<input type="hidden" name="testSet" value=""/>

<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>

<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
</form>
</body>
</html>
<div id="loader"></div>
<div id="dialog-confirm"></div>