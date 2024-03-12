<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<%@include file="include/ssd_top.jsp" %>
<title>SK hynix 2018</title>
<style>
	html, body,form {
		/* height: 100%; */
	    width: 100%;
	    padding: 0;
	    margin: 0;
	    /* overflow-y: auto; */
	    /*  overflow-x: hidden; */
	    overflow: hidden;
	     font-size:11px;
	}
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
<style>
    /* CSS추가 */
	#mw,
	.pop_alert,
	.pop_layer_s,
	.pop_contents {display:none;}
</style>

</head>
<!-- <body onbeforeunload = "javascript:beforeClosePop();"> -->
<body onbeforeunload="javascript:fn_removeLocalStorage('openchatwait');">
	<div id="lay_wrap" class="lay_col2 lay_100">
		<!-- <div id="lay_container"> -->
			<div id="lay_contents">
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
                                <div class="tit">Test Set Management // <span id="modelNameT"></span> - <span id="testTypeT"></span> - <span id="testSetT"></span></div>
                            </td>
                        </tr>
                    </table>
                    <!-- //Page Title -->
                   
                    <!-- //Tab Type01 -->
                    <!-- Tab Contents -->
                    <div class="tab_contents_wrap" rel="contentsTab">
                        <div class="tab_contents" id="contentsTab_01">
                            <!-- Sub Title -->
                            <div class="opt_tit">
                                <div class="opt_tit_right">
                                    <div class="elmt">
                                    	<a href="javascript:btnClick('csvBtn');" class="btn_txt btn_type_c btn_color_c">
                                            <span class="txt" id="csvBtn" style="vertical-align: text-top">CSV</span>
                                        </a>
                                        <a href="javascript:btnClick('jsonBtn');" class="btn_txt btn_type_c btn_color_c" >
                                            <span class="txt" id="jsonBtn" style="vertical-align: text-top">JSON</span>
                                        </a>
                                        <a href="javascript:btnClick('copyBtn');" class="btn_txt btn_type_c btn_color_a">
                                            <span class="txt" id="copyBtn" style="vertical-align: text-top">COPY</span>
                                        </a>
                                        <a href="javascript:btnClick('editBtn');" class="btn_txt btn_type_c btn_color_b">
                                            <span class="txt" id="editBtn" style="vertical-align: text-top">EDIT</span>
                                        </a>
                                        
                                    </div>
                                </div>
                            </div>
                            <!-- //Sub Title -->
                            <!-- Board List -->
                            <div class="board_list">
                                <!-- <div id="contentMain" style="margin-top: 10px;width: 100%;"></div> -->
                                <div id="excelTableList" style="margin-top: 10px;width: 100%;"></div>
                            </div>
                            <!-- //Board List -->
                            <!-- Page Navigation -->
                            <div class="nav_paging">
    							<div class="nav_paging_wrap" id="demo_page">
    							</div>
   							</div>
                            <!-- //Page Navigation -->
                            <!-- Button List -->
                            <div class="opt_tit" style="margin-top:10px;">
                                <div class="opt_tit_right">
                                    <div class="elmt">
                                        <a href="javascript:btnClick('cancelBtn');" class="btn_txt btn_type_c btn_color_C" id="cancelBlock" style="display: none;">
                                            <span class="txt" id="cancelBtn" style="vertical-align: text-top">CANCEL</span>
                                        </a>
                                        <a href="javascript:btnClick('closeBtn');" class="btn_txt btn_type_c btn_color_a">
                                            <span class="txt" id="closeBtn" style="vertical-align: text-top">CLOSE</span>
                                        </a>
                                    </div>	
                                </div>
                            </div>
                            <!-- //Button List -->
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
		<!-- </div> -->
	</div>
	
</form>
<script type="text/javascript">
	var allSaveFlag = '';
	var pTestSetIdx, options, newwin, loginUserId;		//;
	var cate1ComList, cate2ComList, toolComList, protoComList, typeComList = [];
	var totRowCnt = 0;
	var page = 1;
	var pageSize = 10;
	var rows = 100;
	var Browser = {
		chk : navigator.userAgent.toLowerCase()
	}
	Browser = {
	    ie : Browser.chk.indexOf('msie') != -1,
	    ie6 : Browser.chk.indexOf('msie 6') != -1,
	    ie7 : Browser.chk.indexOf('msie 7') != -1,
	    ie8 : Browser.chk.indexOf('msie 8') != -1,
	    ie9 : Browser.chk.indexOf('msie 9') != -1,
	    ie10 : Browser.chk.indexOf('msie 10') != -1,
	    opera : !!window.opera,
	    safari : Browser.chk.indexOf('safari') != -1,
	    safari3 : Browser.chk.indexOf('applewebkir/5') != -1,
	    mac : Browser.chk.indexOf('mac') != -1,
	    chrome : Browser.chk.indexOf('chrome') != -1,
	    firefox : Browser.chk.indexOf('firefox') != -1
	}
	
	if(Browser.chrome) {
		 $(window).bind("beforeunload", function() {
			 opener.closeStatUpdate('Released', pTestSetIdx);
			//실행할 함수를 리턴해야한다.
		  	//return fn_removeLocalStorage("openchatwait");
		});
	}
	$(document).ready(function(){
		var oFrm = document.getElementById("form1");
		pTestSetIdx = oFrm.testSetIdx.value;
		$('#modelNameT').text(oFrm.modelName.value);
		$('#testTypeT').text(oFrm.testType.value);
		$('#testSetT').text(oFrm.testSet.value);
		
		loginUserId = $('#userId').val()==''?'SYSTEM':$('#userId').val();
		
		var paramObj = ["01","02","03","05","00"];
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.commonComboSearch",
			data: { 
						filters: JSON.stringify({commCdType:paramObj}) 
					},	
			dataType: 'json',
			success: function(res){
			    var data = res.dataList;
			    selectboxSetting(data);
			},
			error : function(err){
				alert("Error : " + err.statusText);
			}
			
		});
		
		getTestSetDtlList(page);
	});
	
	/**
	* 그리드 내 select box 내용 설정
	*/
	var selectboxSetting = function(data){
		var temp1 = new Array();
	    var temp2 = new Array();
	    var temp3 = new Array();
	    var temp5 = new Array();
	    var temp0 = new Array();
	    
	    for(var i = 0; i < data.length; i++){
	    	switch(data[i].COMM_TYPE){
	    	case "01" :		//category1
	    		temp1.push(data[i].COMM_VALUE);
	    		break;
	    	case "02" :		//category2
	    		temp2.push(data[i].COMM_VALUE);
	    		break;
	    	case "03" :		//tool
	    		temp3.push(data[i].COMM_VALUE);
	    		break;
	    	case "05" :		//protocol
	    		temp5.push(data[i].COMM_VALUE);
	    		break;
	    	case "00" :		//test type
	    		temp0.push(data[i].COMM_VALUE);
	    		break;
	    	default:
	    	}
	    }
	    
	    cate1ComList = temp1;
	    cate2ComList = temp2;
	    toolComList = temp3;
	    protoComList = temp5;
	    typeComList = temp0;
	}
	
	/**
	* HandsOnTable Grid 셋팅
	*/
	var hotElement = document.querySelector('#excelTableList');
	var hotElementContainer = hotElement.parentNode;
	var hotSettings = {
		data: hotGridData,
	  width: '100%',
	  autoWrapRow: true,
	  height: 587,
	  //maxRows: 22,
	  startRows: 1,
	  startCols: 1,
	  //fixedRowsBottom: 1,
	  //fixedColumnsLeft: 4,
	  //minSpareRows: 1,
	  manualRowResize: true,
	  manualColumnResize: true,
	  rowHeaders: true,
	  colHeaders: [
		  	'STAT'
		  	,'VARIATION'
		  	,'ITEM_CODE'
		  	,'TEST_CASE_ID'
			,'SEQ'
			,'REV'
			,'TEST_TYPE'
			,'TOOL'
			,'PROTOCOL'
			,'CATEGORY1'
			,'CATEGORY2'
			,'SUB1'
			,'SUB2'
			,'TEST_NAME'
			,'COMMAND_LINE'
			,'ARG_00'
			,'ARG_01'
			,'ARG_02'
			,'ARG_03'
			,'ARG_04'
			,'ARG_05'
			,'ARG_06'
			,'ARG_07'
			,'ARG_08'
			,'ARG_09'
			,'DELETED'
			,'CREATED BY'
			,'CATE DATE'
			,'EDITED BY'
			,'UPDATE DATE'
			,'MAX SEQ'
			,'TCI ORG'
	  ],
	  manualRowMove: true,	//로우 드래그앤 드랍 위치이동
	  manualColumnMove: true, 	//컬럼 드래그앤 드랍 위치이동
	  contextMenu: true,	//우클릭시 컨텍스트. 컨텍스트 내용 추가, 제거 가능
	  filters: true,				//header의 필터내용 여부
	  //dropdownMenu: true,	//특정 col의 dropdown 허용
	  dropdownMenu: ['filter_by_condition', 'filter_action_bar', 'filter_by_value'],
	  allowInvalid:false,		//dropdown List 의 수정을 리스트내에서만 수정가능하게 함.
	  fillHandle: {
	  	autoInsertRow: true,
	  },
	  hiddenColumns : {
		  columns : [30, 31],
		  indicators:false,
	  },
	  beforeChange : function(change, source){
		  
		  	if(source == 'loadData' || source == 'editStat') {return;}
		  	
		  	if(change[0][2] == 'ROW_STATUS') {
		  		return false;
		  	}
		  	
		  	if(source == 'Autofill.fill'){
	  			return false;
	  		}
		  	var ad = hot.getData();
		  	
		  	for(var i=0; i < change.length; i++){
		  		if(change[i][1] == "SEQ"){
		  			//seq의 최대값을 넘었을때 무효
		  			if( hot.getDataAtCell(change[i][0], 2) != null && hot.getDataAtCell(change[i][0], 3) != null ){
				  		if( hot.getDataAtCell(change[i][0], 1) == 'public' ){
				  			if( hot.getDataAtCell(change[i][0], 30) < change[i][3] ){
					  			alert("Can not be greater than the maximum value of SEQ.");
					  			return false;
					  		}	
				  		}
			  		}
		  			
		  		}
		  	}
		  	
		  	for(var j=0; j < change.length; j++){
		  		if(change[j][1] == "SEQ"){
		  			//seq를 바꿨을때 상대되는 seq를 가진 row의 seq와 교체
		  			if( hot.getDataAtCell(change[j][0], 2) != null && hot.getDataAtCell(change[j][0], 3) != null ){
		  				if( hot.getDataAtCell(change[j][0], 1) == 'public' ){
		  					if(change[j][3] != change[j][2]){
					  			for(var k=0; k < ad.length; k++){
						  			if(ad[k][31] == hot.getDataAtCell(change[j][0], 31)){
						  				if(ad[k][4] == change[j][3]){
						  					hot.setDataAtCell(k, 4, change[j][2]);
						  				}
						  			}
						  		}	
					  		}	
		  				}
		  			}
		  		}
		  	}
		  		
	  },
	  afterChange: function (change, source) {		//그리드 내 Cell 의 변경이 일어난 직후 호출 함수
			/* if (source == 'CopyPaste.paste') {			//Copy & Paste 시 로딩서클 숨김
		    	$("#loader").hide();
		    } */
	  
		  	if(source == 'loadData' || source == 'editStat') {return;}
	  		
		  	var isDelArr = new Array();
		  	
		  	for(var i=0; i < change.length; i++){
		  		var isNull = true;
		  		var index = change[i][0];
		  		var itemCode = hot.getDataAtCell(change[i][0], 'ITEM_CODE');
		  		if( null != itemCode ){
		  			if( change[i][2] != change[i][3] ){
		  				if( hot.getDataAtCell(index, 0) != 'I' ){
		  					hot.setDataAtCell(index, 0, 'U','editStat');	
		  				}/* else if( hot.getDataAtCell(index, 0) == 'I' ){
		  					isDelArr.push(index);
		  				} */
				   	}	
		  		}else if( null == itemCode ){
		  			//행전체를 선택 후 Delete 버튼 누를 경우 I도 지움.
		  			if(change[i][2] == null ){
	  					isNull = false;
	  				}
		  			
	  				if(!isNull){
	  					hot.setDataAtCell(index, 0, 'I','editStat');
	  					hot.setDataAtCell(index, 1, 'private','editStat');
	  				}else{
	  					/* hot.setDataAtCell(index, 0, '','editStat');	
	  					if(hot.isEmptyRow(index)){
	  						isDelArr.push(index);
	  					}	 */
	  				}
		  		}
		  	}
		  	
		  //행삭제
		  	var result = removeDuplicateArr(isDelArr);
			$.each(result, function (index, element){
			    hot.alter('remove_row', element);
			});
		  	
		  	var currentRows = hot.countRows();
		    $('#currentCnt').text(currentRows);
		  	
		},
		afterOnCellMouseDown: function(event, coords, td) {
			var now = new Date().getTime();
			if(!(td.lastClick && now - td.lastClick < 200)) {
				td.lastClick = now;
			    return; // no double-click detected
			}
			
			if( hot.getDataAtCell(coords.row, 1) != 'private' ){
				if( coords.col == '5' && $('#editBtn').text() == 'SAVE' ){
					if(hot.getDataAtCell(coords.row, 'ROW_STATUS') == 'I'){
						alert("Save it First.");
						return;
					}else{
						fn_owner_delegate(coords);	
					}
				}	
			}
		},
		afterCreateRow : function(index, amount, source){
			hot.setDataAtCell(index, 0, 'I');
			hot.setDataAtCell(index, 1, 'private');
		},
		/* afterLoadData : function(firstTime){
			$("#loader").hide();
		},
		beforePaste : function(data, coords){		//Copy & Paste 시 로딩서클 로드
			$("#loader").show();
		}, */
		afterPaste : function(data, coords){
			rowEditableChange(hot);
		}
	};

	var hot = new Handsontable(hotElement, hotSettings);
	var hotGridData, hotGridData2;
	
	/**
	* 전체 Master 리스트를 가지고 온다.
	*/
	var getTestSetDtlList = function(pPage){
		var flagText = $('#editBtn').text();
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.testSet.dtl",
			data:{ 
						page:pPage, 
						rows:rows, 
						testSetIdx : nvl(pTestSetIdx,''),
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			    var data = res.dataList;
			    /* if(flag == 'more'){
				    for(var j=0; j < data.length; j++){
				    	hotGridData.push(data[j]);
				    }
				    hot.updateSettings({data:hotGridData});
			    }else{
			    	hotGridData = data;
				    hot.loadData(hotGridData);
			    } */
			    hotGridData = data;
			    hot.loadData(hotGridData);
			    
			    page = pPage;
			    totRowCnt = (res.dataList.length== 0 ? 0 : res.dataList[0].TOT_CNT);
			    
			    //paging
			    var page_viewList = Paging(
			    								(res.dataList.length== 0) ? 0 : res.dataList[0].TOT_CNT, 
			    								rows, 
			    								pageSize,
			    								page, 
			    								"getTestSetDtlList"
			    							); 
			    $("#demo_page").empty().html(page_viewList);
			    
			    //현재 Edit or Save 버튼에 따라 해당 모드로 그리드 상태 셋팅			    
			    gridUpdateSetting(getEditableParam(flagText.toLowerCase()));
			    
			}
		});	
	}
	
	//rev 전환을 dropdown 말고 layer나 팝업으로 하는건 어떤지? 드래그 copy를 막을 수가 없고, 각 cell 별로 다른 list 를 넣기가 시간이 많아질것 같다.
	/* var gridRevSetting = function(param){
		for(var j=0; j < param.length; j++){
	    	var arr = data[j].rev_all.split(',');
	    }
	} */
	/**
	* 그리드의 셋팅을 업데이트 한다.
	*/
	var gridUpdateSetting = function(param){
		hot.updateSettings(param);
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
		if( btn == 'csvBtn' ){
			if( hot.getData().length == 0 ){
				alert("No Data.");
				return;
			}
			/* hot.getPlugin('exportFile').downloadFile('csv', {
				filename: 'TestSet Mgmt_'+pModelName+'_'+pTestSet+'_'+today,
			}); */
			fileExport('csv');
		}else if( btn == 'jsonBtn' ){
			if( hot.getData().length == 0 ){
				alert("No Data.");
				return;
			}
			/* hot.getPlugin('exportFile').downloadFile('json', {
				filename: 'TestSet Mgmt_'+pModelName+'_'+pTestSet+'_'+today,
			}); */
			fileExport('json');
		}else if( btn == 'editBtn' ){
			if( $('#editBtn').html() == 'EDIT' ) {
				$('#editBtn').html('SAVE');
				$('#cancelBlock').show();
				gridUpdateSetting(getEditableParam('save'));
				allSaveFlag = 'NoCopy';
				setTestSetStatUpdate('Editing');		//테스트 셋의 상태를 업데이트 한다.
			}else {
				excelGridAllSave();	//save 완료가 되었다면, 화면의 btn toggle
			}
			
		}else if( btn == 'saveBtn' ){
			excelGridAllSave();	//save 완료가 되었다면, 화면의 btn toggle
		}else if(btn == 'moreBtn' ){
			var compareTotCnt = totRowCnt;
			var compareCurCnt = hot.countRows();
			if( compareTotCnt <=  compareCurCnt ){
				alert("Currently the last row.");
				return;
			}
			getTestSetDtlList('more');
		}else if(btn == 'closeBtn'){
			//창 닫기 전 Test Set 의 status 를 변경한다.
			$.ajax({		//loads data to Handsontable
				type: "POST",
				url: "/dashboard/genericSaveJson.do?sqlid=dashboard.ssd_sm.testSet.statusUpdate",
				data:{ 
							status : 'Released', 
							testSetIdx : nvl(pTestSetIdx,''),
							loginUserId : loginUserId,
						},
				dataType: 'json',
				success: function(res){
				    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			    	var data = res;
			    	opener.location.reload();
			    	self.close();
				},
				error : function(err){
					setTestSetStatUpdate('Released');		//테스트 셋의 상태를 업데이트 한다.
				}
			});
		}else if(btn == 'copyBtn'){
			setTestSetStatUpdate('Editing');		//테스트 셋의 상태를 업데이트 한다.
			newwin = window.open("", "SSD_TEST_SET_COPY", "width=1024px,height=768px,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
			var oFrm = document.getElementById("form1");
			oFrm.action =  '/dashboard/generic.do?viewName=ssd_sm/test_set_pop2';
			oFrm.method = "post";
			oFrm.target = 'SSD_TEST_SET_COPY'; 
			oFrm.submit();
			newwin.focus();
		}else if( btn == 'okBtn' ) { 
			if( selIndex != '' && selRev != '' ){
				var selCode = hot.getDataAtCell(selIndex, 'ITEM_CODE');
				$.ajax({		//loads data to Handsontable
					type: "POST",
					url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.testSet.revDtl",
					data:{ 
								rev : selRev, 
								testSetIdx : nvl(pTestSetIdx,''),
								itemCode : selCode,
							},
					dataType: 'json',
					success: function(res){
					    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
				    	var data = res.dataList[0];
			    		hot.setDataAtCell(selIndex, 1, data.VARIATION);
			    		hot.setDataAtCell(selIndex, 2, data.ITEM_CODE);
			    		hot.setDataAtCell(selIndex, 5, data.REV);
			    		hot.setDataAtCell(selIndex, 6, data.TEST_TYPE);
			    		hot.setDataAtCell(selIndex, 7, data.TOOL);
			    		hot.setDataAtCell(selIndex, 8, data.PROTOCOL);
			    		hot.setDataAtCell(selIndex, 9, data.CATEGORY1);
			    		hot.setDataAtCell(selIndex, 10, data.CATEGORY2);
			    		hot.setDataAtCell(selIndex, 11, data.SUB_CATEGORY1);
			    		hot.setDataAtCell(selIndex, 12, data.SUB_CATEGORY2);
			    		hot.setDataAtCell(selIndex, 13, data.TEST_NAME);
			    		hot.setDataAtCell(selIndex, 14, data.COMMAND_LINE);
			    		hot.setDataAtCell(selIndex, 15, data.ARG_00);
			    		hot.setDataAtCell(selIndex, 16, data.ARG_01);
			    		hot.setDataAtCell(selIndex, 17, data.ARG_02);
			    		hot.setDataAtCell(selIndex, 18, data.ARG_03);
			    		hot.setDataAtCell(selIndex, 19, data.ARG_04);
			    		hot.setDataAtCell(selIndex, 20, data.ARG_05);
			    		hot.setDataAtCell(selIndex, 21, data.ARG_06);
			    		hot.setDataAtCell(selIndex, 22, data.ARG_07);
			    		hot.setDataAtCell(selIndex, 23, data.ARG_08);
			    		hot.setDataAtCell(selIndex, 24, data.ARG_09);
			    		hot.setDataAtCell(selIndex, 25, data.DELETE_YN);
			    		hot.setDataAtCell(selIndex, 26, data.CRT_BY);
			    		hot.setDataAtCell(selIndex, 27, data.CRT_DT);
			    		hot.setDataAtCell(selIndex, 28, data.MOD_BY);
			    		hot.setDataAtCell(selIndex, 29, data.MOD_DT);
			    		
			    		$('#mw').fadeOut();
			    		$('#popup22').fadeOut();
			    		//e.preventDefault();
					},
					error : function(err){
						alert("ERROR : " + err.statusText);
						//setTestSetStatUpdate('Released');		//테스트 셋의 상태를 업데이트 한다.
					}
				});
			}else{
				$('#mw').fadeOut();
	    		$('#popup22').fadeOut();
			}
		}else if(btn == 'cancelBtn'){
			if( !hot.isEmptyCol(0) ){
				if(confirm("There are revised contents. Do you want to initialize?")){
					$('#editBtn').html('EDIT');
					$('#cancelBlock').hide();
					gridUpdateSetting(getEditableParam('edit'));
					page = 1;
					//page--;
					getTestSetDtlList(page);
				}else{
					return;
				}
			}else{
				$('#editBtn').html('EDIT');
				$('#cancelBlock').hide();
				gridUpdateSetting(getEditableParam('edit'));
				page = 1;
				//page--;
				getTestSetDtlList(page);
			}
		}
		
	}
	
	/** 컨텍스트 메뉴(우버튼클릭 메뉴)에서 5줄 추가*/
	var fiveRowsAppend = function(){
		hot3.updateSettings({
		    contextMenu: {
		      items: {
		        "row_above": {
		          name: 'Add 5 rows above',
		          callback: function(key, options) {
		            hot3.alter('insert_row', hot3.getSelected()[0], 5)
		          }
		        },
		        "row_below": {
		          name: 'Add 5 rows below',
		          callback: function(key, options) {
		            hot3.alter('insert_row', hot3.getSelected()[0]+1, 5)
		          }
		        }
		      }
		    }
		  })
	}
	
	/**
	* 그리드의 모드 변환.
	*/
	var getEditableParam = function(flag){
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
								disabled: function () {
						            // if first row, disable this option
						        	return hot.getSelected()[0] === 0;
						        },
						        callback : function(key, options) {
						        	hot.alter('insert_row', options[0].end.row, 1);
						        	hot.setDataAtCell(options[0].end.row, 1, 'private');
						        	hot.setDataAtCell(options[0].end.row, 5, '1');
						        	rowEditableChange(hot);
						        },
							},
							"row_below" : {
								callback : function(key, options) {
									hot.alter('insert_row', options[0].end.row+1, 1);
									hot.setDataAtCell(options[0].end.row+1, 1, 'private');
									hot.setDataAtCell(options[0].end.row+1, 5, '1');
									rowEditableChange(hot);
						        },
							},
							"hsep1": "---------",
							"remove_row" : {
								callback : function(key, options) {
									var sRowIdx = options[0].start.row;
									var eRowIdx = options[0].end.row;
									var isDelArr = new Array();
									for(var i = sRowIdx; i <= eRowIdx; i++) {
										var itemCd = hot.getDataAtCell(i, 2);
										if(itemCd == null){
											isDelArr.push(i);		
										}
									}
									
									var result = removeDuplicateArr(isDelArr);
									$.each(result, function (index, element){
										hot.alter('remove_row', element);
									});
						        },
							},
							"hsep2": "---------",
							"undo" : {},
							"redo" : {},
							"hsep3": "---------",
							"export1" : {
								name: 'Export to CSV',
								callback: function(key, options) {
									var exportPlugin = hot.getPlugin('exportFile');
									/* hot.getPlugin('exportFile').downloadFile('csv', {
										filename: 'Master Mgmt_'+today,
									}); */
									exportPlugin.downloadFile('csv', {
										exportHiddenRows: false,     // default false, exports the hidden rows
									    exportHiddenColumns: false,  // default false, exports the hidden columns
									    columnHeaders: true,        // default false, exports the column headers
									    rowHeaders: true,           // default false, exports the row headers
										filename: 'Test Set Mgmt_'+today,
									});
								}
							},
							"export2" : {
								name: 'Export to JSON',
								callback: function(key, options) {
									var exportObj = hot.getData();
									var exportName = 'Test Set Mgmt_'+today;
									
									var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(exportObj));
								    var downloadAnchorNode = document.createElement('a');
								    downloadAnchorNode.setAttribute("href",     dataStr);
								    downloadAnchorNode.setAttribute("download", exportName + ".json");
								    document.body.appendChild(downloadAnchorNode); // required for firefox
								    downloadAnchorNode.click();
								    downloadAnchorNode.remove();
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
						    className:'htCenter htMiddle'
					    },
					    {
					      	data: 'VARIATION',
					      	type: 'dropdown',
					      	source:['public','private'],
					      	value:'public',
					      	editor:false,
						    readOnly:true,
					    },
				  		{
						  	data: 'ITEM_CODE',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
						  	data: 'TEST_CASE_ID',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'SEQ',
					      	type: 'numeric',
					    },
					    {
					      	data: 'REV',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					      	validator: notEmpty,
						  	allowInvalid:true,
					    },
					    {
					      	data: 'TEST_TYPE',
					      	type: 'text',
					      	/* type: 'dropdown',
					      	source: typeComList,
					      	width:'100px',
						  	validator: notEmpty,
						  	allowInvalid:true, */
						  	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'TOOL',
					      	/* type: 'dropdown',
					      	source: toolComList,
					      	width:'100px',
						  	validator: notEmpty,
						  	allowInvalid:true, */
						  	type: 'text',
						  	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'PROTOCOL',
					      	/* type: 'dropdown',
					      	source: protoComList,
						  	validator: notEmpty,
						  	allowInvalid:true, */
						  	type: 'text',
						  	editor:false,
						    readOnly:true,
					    },
						{
						  	data: 'CATEGORY1',
						  	/* type: 'dropdown',
						  	source: cate1ComList,
						  	validator: notEmpty,
						  	allowInvalid:true, */
						  	type: 'text',
						  	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'CATEGORY2',
					      	/* type: 'dropdown',
						  	source: cate2ComList,
						  	
						  	validator: notEmpty,
						  	allowInvalid:true, */
						  	width:'180px',
						  	type: 'text',
						  	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'SUB_CATEGORY1',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'SUB_CATEGORY2',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'TEST_NAME',
							//renderer: flagRenderer
					      	type: 'text',
					      	validator: notEmpty,
						  	allowInvalid:true,
						  	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'COMMAND_LINE',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_00',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_01',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_02',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_03',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_04',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_05',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_06',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_07',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_08',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'ARG_09',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'DELETE_YN',
					      	/* type: 'dropdown',
					      	source:['Y','N'], */
					      	type: 'text',
					      	value:'N',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'CRT_BY',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'CRT_DT',
					      	/* type: 'date',
					      	dateFormat: 'YYYY-MM-DD', */
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
					      	/* type: 'date',
					      	dateFormat: 'YYYY-MM-DD', */
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'MAX_SEQ',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'TEST_CASE_ID_ORG',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					],
				
			}
			//private 인 경우는 전부 수정 가능하게...
			gridPrivateSetting();
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
						    className:'htCenter htMiddle'
					    },
					    {
					      	data: 'VARIATION',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
						  	data: 'ITEM_CODE',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
				  		{
						  	data: 'TEST_CASE_ID',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'SEQ',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'REV',
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
					      	data: 'TOOL',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'PROTOCOL',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
						{
						  	data: 'CATEGORY1',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'CATEGORY2',
					      	type: 'text',
					      	width:'180px',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'SUB_CATEGORY1',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'SUB_CATEGORY2',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'TEST_NAME',
							//renderer: flagRenderer
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'COMMAND_LINE',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_00',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_01',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_02',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_03',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_04',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_05',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_06',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_07',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_08',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'ARG_09',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'DELETE_YN',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'CRT_BY',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'CRT_DT',
					      	type: 'date',
					      	dateFormat: 'YYYY-MM-DD',
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
					      	type: 'date',
					      	dateFormat: 'YYYY-MM-DD',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'MAX_SEQ',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'TEST_CASE_ID_ORG',
					      	type: 'text',
					      	editor:false,
						    readOnly:true,
					    },
					],
			}
			gridDefaultSetting();
		}
		return updateParam;		
	}
	
	var jsonToCsvConvertor = function(JSONData, colHeaders){
		var 
	    arrData = typeof JSONData != 'object' ? JSON.parse(JSONData) : JSONData,
	    CSV = '',   
	    row = '',
	    fileName = 'Test Set Mgmt_'+getTodate()+'.csv';

	    // Put the header (based on the colHeaders of my table in my example)
	    for (var index in colHeaders) {
	        row += colHeaders[index] + ';';
	    }
	    row = row.slice(0, -1);
	    CSV += row + '\r\n';

	    // Adding each rows of the table
	    for (var i = 0; i < arrData.length; i++) {
	        var row = "";
	        for (var index in arrData[i]) {
	            row += arrData[i][index] + ';';
	        }
	        row = row.slice(0, -1);
	        CSV += row + '\r\n';
	    }

	    if (CSV == '') {
	        alert("Invalid data");
	        return;
	    }        

	    // Downloading the new generated csv.
	    // For IE >= 9
	    if(window.navigator.msSaveOrOpenBlob) {
	        var fileData = [CSV];
	        blobObject = new Blob(fileData);
	        window.navigator.msSaveOrOpenBlob(blobObject, fileName);
	    } else { 
	    // For Chome/Firefox/Opera
	        var uri = 'data:text/csv;charset=utf-8,' + escape(CSV);

	        var link = document.createElement("a");    
	        link.href = uri;

	        link.style = "visibility:hidden";
	        link.download = fileName;

	        document.body.appendChild(link);
	        link.click();
	        document.body.removeChild(link);
	    }
	}
	
	/**
	* CSV, JSON Export
	*/
	var fileExport = function(flag){
		var today = getTodate();
		if(flag == 'csv'){
			var exportPlugin = hot.getPlugin('exportFile');
			
			exportPlugin.downloadFile('csv', {
				exportHiddenRows: false,     // default false, exports the hidden rows
			    exportHiddenColumns: false,  // default false, exports the hidden columns
			    columnHeaders: true,        // default false, exports the column headers
			    rowHeaders: true,           // default false, exports the row headers
				filename: 'Test Set Mgmt_'+today,
			});
		}else{
			var exportObj = hot.getData();
			var exportName = 'Test Set Mgmt_'+today;
			
			//var dataStr = "data:text/json;charset=utf-8;," + encodeURIComponent(JSON.stringify(exportObj));
			var dataStr = new Blob(["\ufeff"+JSON.stringify(exportObj)], {type: 'text/json;charset=utf-8;'});
			var url = URL.createObjectURL(dataStr);
		    var downloadAnchorNode = document.createElement('a');
		    downloadAnchorNode.setAttribute("href",     url);
		    downloadAnchorNode.setAttribute("download", exportName + ".json");
		    document.body.appendChild(downloadAnchorNode); // required for firefox
		    downloadAnchorNode.click();
		    downloadAnchorNode.remove();
		}
	}
	
	
	/**
	* Edit 모드 중 variation이 private 이면 모두 수정가능하게....
	*/
	var gridPrivateSetting = function(){
		rowEditableChange(hot);
	}
	
	/**
	* Save 후 grid의 cellProperties를 초기화한다.
	*/
	var gridDefaultSetting = function(){
		hot.updateSettings({
			cells : function(row, col, prop){
				var cellProperties = {};
				
				return cellProperties;
			}
		});
	}
	
	var rowEditableChange = function(htContainer){
		
			htContainer.updateSettings({
				cells : function(row, col, prop){
					var cellProperties = {};
					if( htContainer.getDataAtCell(row, 1) == 'private' ){
							if( prop === 'TEST_NAME'
								){
								cellProperties.readOnly = false;
								cellProperties.editor = 'text';
								cellProperties.validator = notEmpty;
								cellProperties.allowInvalid = true;
							
							}else if( prop === 'SUB_CATEGORY1'
								|| prop === 'SUB_CATEGORY2'
								|| prop === 'COMMAND_LINE'
								|| prop === 'ARG_00' || prop === 'ARG_01' || prop === 'ARG_02' || prop === 'ARG_03' 
								|| prop === 'ARG_04' || prop === 'ARG_05' || prop === 'ARG_06'  
								|| prop === 'ARG_07' || prop === 'ARG_08' || prop === 'ARG_09' 
								){
								cellProperties.readOnly = false;
								cellProperties.editor = 'text';
							}else if(prop === 'TEST_TYPE'){
								cellProperties.type = 'dropdown';
								cellProperties.source = typeComList;
								cellProperties.width = '100px';
								cellProperties.validator = notEmpty;
								cellProperties.allowInvalid = true;
								cellProperties.readOnly = false;
								//cellProperties.editor = false;
							}else if(prop ==='TOOL'){
								cellProperties.type = 'dropdown';
								cellProperties.source = toolComList;
								cellProperties.width = '100px';
								cellProperties.validator = notEmpty;
								cellProperties.allowInvalid = true;
								cellProperties.readOnly = false;
							}else if(prop ==='PROTOCOL'){
								cellProperties.type = 'dropdown';
								cellProperties.source = protoComList;
								cellProperties.validator = notEmpty;
								cellProperties.allowInvalid = true;
								cellProperties.readOnly = false;
							}else if(prop ==='CATEGORY1'){
								cellProperties.type = 'dropdown';
								cellProperties.source = cate1ComList;
								cellProperties.validator = notEmpty;
								cellProperties.allowInvalid = true;
								cellProperties.readOnly = false;
							}else if(prop ==='CATEGORY2'){
								cellProperties.type = 'dropdown';
								cellProperties.source = cate2ComList;
								cellProperties.width = '180px';
								cellProperties.validator = notEmpty;
								cellProperties.allowInvalid = true;
								cellProperties.readOnly = false;
							}else if(prop ==='SEQ'){
								cellProperties.type = 'numeric';
								cellProperties.readOnly = false;
							}
							
						}
					
					return cellProperties;
				}
			});
		
	}
	
	/**
	* 그리드 모든 데이터 저장
	*/
	var excelGridAllSave = function(){
		//그리드내 변경이 없을때
		if( hot.isEmptyCol(0) ){
			alert("There are no changes.");
			$('#editBtn').html('EDIT');
			$('#cancelBlock').hide();
			gridUpdateSetting(getEditableParam('edit'));
 			return false;
		}
		
		hot.validateCells(function(isPass){
			
			if(isPass){
				if(confirm("Do you want to save all?")){
					var data = hot.getData();
					var paramObj = new Array();
					for(var i=0; i < data.length; i++){
						if(hot.getDataAtCell(i, 0) != '' & hot.getDataAtCell(i, 0) != null){
							var tempObj = new Object();
							tempObj.status 			= nvl(data[i][0],'');
							tempObj.variation 		= nvl(data[i][1],'');
							tempObj.item_code 		= nvl(data[i][2],'');	
							tempObj.test_case_id	= nvl(data[i][6],'')+'-'+nvl(data[i][7],'')+'-'+nvl(data[i][8],'')+'-'+nvl(data[i][9],'');//+((nvl(data[i][4],'') == '') ? '-0':'-'+nvl(data[i][4],''));
							tempObj.seq				= nvl(data[i][4],'');
							tempObj.rev 				= nvl(data[i][5],'');
							tempObj.test_type		= nvl(data[i][6],'');
							tempObj.tool 				= nvl(data[i][7],'');
							tempObj.protocol 			= nvl(data[i][8],'');
							tempObj.category1 		= nvl(data[i][9],'');
							tempObj.category2 		= nvl(data[i][10],'');
							tempObj.sub_category1	= nvl(data[i][11],'');
							tempObj.sub_category2 = nvl(data[i][12],'');
							tempObj.test_name		= nvl(data[i][13],'');
							tempObj.command_line	= nvl(data[i][14],'');
							tempObj.arg00				= nvl(data[i][15],'');
							tempObj.arg01				= nvl(data[i][16],'');
							tempObj.arg02				= nvl(data[i][17],'');
							tempObj.arg03				= nvl(data[i][18],'');
							tempObj.arg04				= nvl(data[i][19],'');
							tempObj.arg05				= nvl(data[i][20],'');
							tempObj.arg06				= nvl(data[i][21],'');
							tempObj.arg07				= nvl(data[i][22],'');
							tempObj.arg08				= nvl(data[i][23],'');
							tempObj.arg09				= nvl(data[i][24],'');
							tempObj.delete_yn		= nvl(data[i][25],'');
							tempObj.crt_by			= nvl(data[i][26],'');
							tempObj.crt_dt			= nvl(data[i][27],'');
							tempObj.mod_by			= loginUserId;
							tempObj.mod_dt			= nvl(data[i][29],'');
							tempObj.testSetIdx		= pTestSetIdx;
							paramObj.push(tempObj);
						}
					}
					
					$.ajax({
		       			url: "/dashboard/genericAllSaveJson.do?sqlid=dashboard.ssd_sm.testSetDtlGridSave",
		        		dataType: "json",
		        		type: "POST",
		        		async : true,
				        data: {
				        	autoJson: JSON.stringify(paramObj),
				        	allSaveFlag : allSaveFlag,
		           		}, 
		        		success: function (data) {
		        			alert("You have saved "+data.resultCnt+" cases in total.");

		        			// 정상 save 시 버튼 토글
		        			page = 1;
		        			getTestSetDtlList(page);
		        			opener.location.reload();
		        			
		        			$('#editBtn').html('EDIT');
		        			$('#cancelBlock').hide();
							gridUpdateSetting(getEditableParam('edit'));
							
							setTestSetStatUpdate('Released');		//테스트 셋의 상태를 업데이트 한다.
		        		},
		        		error: function (err) {
		                    $('#container').html('Error: ' + err.statusText);
		    				setTestSetStatUpdate('Released');		//테스트 셋의 상태를 업데이트 한다.
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
        if(typeof str == "undefined" || str == null)
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
	
	var drawSearchArea = function(data){
		var html1 = '';
		var html2 = '';
		var html3 = '';
		var html5 = '';
		
		for(var i=0; i < data.length; i++){
			if( data[i].COMM_TYPE == '01' ){
				html1 += '<option value="'+data[i].COMM_IDX+'">'+data[i].COMM_VALUE+'</option>';	
			}else if( data[i].COMM_TYPE == '02' ){
				html2 += '<option value="'+data[i].COMM_IDX+'">'+data[i].COMM_VALUE+'</option>';	
			}else if( data[i].COMM_TYPE == '03' ){
				html3 += '<option value="'+data[i].COMM_IDX+'">'+data[i].COMM_VALUE+'</option>';	
			}else if( data[i].COMM_TYPE == '05' ){
				html5 += '<option value="'+data[i].COMM_IDX+'">'+data[i].COMM_VALUE+'</option>';	
			}
		}

		$('#searchCate1').html(html1);
		$('#searchCate2').html(html2);
		$('#searchTool').html(html3);
		$('#searchProtocol').html(html5);
		
		var select = $("#searchCate1, #searchCate2, #searchTool, #searchProtocol").multiselect({
			selectedList: 1,
			height:100,
			width:'80%',
			selectedText: 'Item # selected',
			noneSelectedText: 'Select Items',
			minWidth:155
		});
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
	* 중복된 배열을 삭제하고, 배열을 내림차순 정리하여 return. (그리드내에서 delete 키 조작시 삭제할 행들의 배열을 정리)
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
	
	var getMasterCopyList = function(copyList){
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.master.all",
			data:{ 
						page:1, 
						rows:999999, 
						filters: JSON.stringify({
													searchTool: [],
													searchProtocol : [],
													searchCate1 : [],
													searchCate2 : [],
													copyList : copyList,
													}),
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			    
		    	var data = res.dataList;
		    	hotGridData = new Array();
		    	
			    for(var j=0; j < data.length; j++){
			    	hotGridData.push(data[j]);
			    }
			    hot.updateSettings({data:hotGridData});
			    //setTestSetStatUpdate('Editing');		//테스트 셋의 상태를 업데이트 한다.
			    
				//현재 Edit or Save 버튼에 따라 해당 모드로 그리드 상태 셋팅			    
			    //gridUpdateSetting(getEditableParam('edit'));
			    
			    $('#editBtn').html('SAVE');
			    $('#cancelBlock').show();
				gridUpdateSetting(getEditableParam('save'));
			    allSaveFlag = 'Copy';
			    newwin.callAlertFromParent(true);
			}
		});	
	}
	
	var getTestSetCopyList = function(copyList){
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.testSet.dtl",
			data:{ 
						page:1, 
						rows:999999, 
						filters: JSON.stringify({
													testSetIdx : '',
													copyList : copyList,
													}),
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			    
		    	var data = res.dataList;
		    	hotGridData = new Array();
		    	
			    for(var j=0; j < data.length; j++){
			    	hotGridData.push(data[j]);
			    }
			    hot.updateSettings({data:hotGridData});
			    
			    //setTestSetStatUpdate('Editing');		//테스트 셋의 상태를 업데이트 한다.
			    
				//현재 Edit or Save 버튼에 따라 해당 모드로 그리드 상태 셋팅			    
			    //gridUpdateSetting(getEditableParam('edit'));
			    $('#editBtn').html('SAVE');
			    $('#cancelBlock').show();
				gridUpdateSetting(getEditableParam('save'));
			    allSaveFlag = 'Copy';
			    newwin.callAlertFromParent(true);
			},
			error : function(err){
				alert("Error1 : " + err.statusText);
			}
		});	
	}
	
	var setTestSetStatUpdate = function(status){
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericSaveJson.do?sqlid=dashboard.ssd_sm.testSet.statusUpdate",
			data:{ 
						status : status, 
						testSetIdx : nvl(pTestSetIdx,''),
						loginUserId : loginUserId,
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
		    	var data = res;
		    	opener.location.reload();
			},
			error : function(err){
				alert("Error1 : " + err.statusText);
				setTestSetStatUpdate('Released');		//테스트 셋의 상태를 업데이트 한다.
			}
		});	
	}
	
	function fn_owner_delegate(coords){
	    var index = coords.row;
	    var selCode = hot.getDataAtCell(index, 'ITEM_CODE');
	    var selVal = hot.getDataAtCell(index, 'REV').replace('*','');
	    var selVariation = hot.getDataAtCell(index, 'VARIATION');
	    
		$('#layerItemCode').text(selCode);
		
		if(selVariation != 'public'){
			return;
		}
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.testSet.revList",
			data:{ 
						status : status, 
						testSetIdx : nvl(pTestSetIdx,''),
						itemCode : selCode,
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
		    	var data = res.dataList;
			    
		    	var html = '<select class="jqForm" style="width:150px;" onchange="javascript:revSelChange(this.value, \''+index+'\');">';
		    	for(var i=0; i<data.length; i++){
		    		if( selVal == data[i].REV ){
		    			html+='<option value="'+data[i].REV+'" selected>'+data[i].REV+'</option>';	
		    		}else{
		    			html+='<option value="'+data[i].REV+'">'+data[i].REV+'</option>';
		    		}
		    		
		    	}
		    	html+='</select>';
		    	$('.desc_area').html(html);
			},
			error : function(err){
				alert("Error : " + err.statusText);
			}
		});
		
	    layer_open('popup22');
	}
	
	var selIndex='';
	var selRev='';
	var revSelChange = function(rev, idx){
		selIndex = idx;
		selRev = rev;
	}
</script>
<form name="form1" id="form1">
<input type="hidden" name="sender" value="confluence"/>
<input type="hidden" name="testSetIdx" id="testSetIdx" value="${param.testSetIdx}"/>
<input type="hidden" name="modelName" id="modelName" value="${param.modelName}"/>
<input type="hidden" name="testType" id="testType" value="${param.testType}"/>
<input type="hidden" name="testSet" id="testSet" value="${param.testSet}"/>

<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
</form>
</body>
</html>

 <!-- Modal Window -->
    <div id="mw">
        <div class="pop_bg"></div>

        <!-- Layer Popup -->
        <div id="popup22" class="pop_layer_s">
            <div class="pop_tit_wrap">
                <h2 class="pop_tit">[<span id="layerItemCode"></span>]&nbsp;&nbsp;REV. Select Layer</h2>
                <a href="#" class="close_area">
                    <span class="pop_layer_btn pop_layer_btn_close">
                        <span class="blind">팝업 닫기</span>
                    </span>
                </a>
            </div>
            <div class="pop_con_fix">
                <span class="baseline"></span>
                <div class="pop_con_area">
                    <div class="tit_area">Selectable REV.</div>
                    <div class="desc_area">
						
                	</div>
                	<!-- Button List -->
                    <div class="opt_tit" style="margin-top:10px;">
                        <div class="opt_tit_right">
                            <div class="elmt">
                                <a href="javascript:btnClick('okBtn');" class="btn_txt btn_type_c btn_color_b">
                                    <span class="txt" id="saveBtn" style="vertical-align: text-top">OK</span>
                                </a>
                            </div>	
                        </div>
                    </div>
                    <!-- //Button List -->
                </div>
            </div>
        </div>
        <!-- //Layer Popup -->
    </div>
    <!-- //Modal Window -->
<!-- <div id="loader"></div>
<div id="dialog-confirm"></div>     -->