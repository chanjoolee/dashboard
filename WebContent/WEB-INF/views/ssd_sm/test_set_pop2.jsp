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
</style>

</head>
<body>
	<div id="lay_wrap" class="lay_col2 lay_100">
		<!-- <div id="lay_container"> -->
			<div id="lay_contents">
                <div class="contents_wrap" style="width:1024px;">
                    
                    <!-- Tab Type01 -->
                    <div class="tab_type01" id="contentsTab">
                        <ul class="tab_list">
                            <li class="tab_item selected">
                                <a class="tab_link" rel="contentsTab_01" onclick="javascript:tabClick('1');">MASTER</a>
                            </li>
                            <li class="tab_item">
                                <a class="tab_link" rel="contentsTab_02" onclick="javascript:tabClick('2');">PROJECT</a>
                            </li>
                        </ul>
                    </div>
                    <!-- //Tab Type01 -->
                    <!-- Tab Contents -->
                    <div class="tab_contents_wrap" rel="contentsTab" style="width:960px;">
                        <div class="tab_contents" id="contentsTab_01" >
                            <!-- Board List -->
                            <div class="board_list" style="width:100%;">
                                <!-- <div id="contentMain" style="margin-top: 10px;width: 100%;"></div> -->
                                <div id="excelTableList1" style="margin-top: 10px;"></div>
                            </div>
                            <!-- //Board List -->
                        </div>
                        <div class="tab_contents" id="contentsTab_02" >
                        	<!-- Board List -->
                            <div class="board_list" style="width:100%;">
                                <!-- <div id="contentMain" style="margin-top: 10px;width: 100%;"></div> -->
                                <div id="excelTableList2" style="margin-top: 10px;"></div>
                            </div>
                            <!-- //Board List -->
                        </div>
                        <!-- Button List -->
                            <div class="opt_tit" style="width:100%">
                                <div class="opt_tit_right" >
                                    <div class="elmt">
                                    	<!-- <a href="javascript:btnClick('copyBtn')" class="btn_txt btn_type_c btn_color_b">
                                            <span class="txt" id="copyBtn" style="vertical-align: text-top">COPY</span>
                                        </a> -->
                                        <a href="javascript:btnClick('closeBtn');" class="btn_txt btn_type_c btn_color_a">
                                            <span class="txt" id="closeBtn" style="vertical-align: text-top">CLOSE</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <!-- //Button List -->
                    </div>
                    <script>
                    $(document).ready(function(){
                        tab_view('#contentsTab', true, false);
                    })
                    </script>
                    <!-- //Tab Contents -->
                </div>
            </div>
		<!-- </div> -->
	</div>
	
</form>
<script type="text/javascript">
	var pTestSetIdx;
	var totRowCnt = 0;
	var page = 1;
	var rows = 100;
	var viewOption = 'latest';
	var options;
	var loginUserId;
	
	$(document).ready(function(){
		var paramObj = [];
		var oFrm = document.getElementById("form1");
		pTestSetIdx = oFrm.testSetIdx.value;
		loginUserId = $('#userId').val();
		
		tabClick('1');
	});
	
	var tabClick = function(index){
		if( index == '1' ){
			getMasterPopList();			
		}else{
			getTestSetPopList();
		}
	}
	/**
	* HandsOnTable Grid 셋팅
	*/
	var hotElement = document.querySelector('#excelTableList1');
	var hotElementContainer = hotElement.parentNode;
	var hotSettings = {
		data: hotGridData,
		columnSorting: true,
		columns: [
  		{
		  	data: 'ITEM_CODE',
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
	      	data: 'TEST_NAME',
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
	  width: 965,
	  autoWrapRow: true,
	  height: 620,
	  //maxRows: 22,
	  startRows: 1,
	  startCols: 1,
	  //fixedRowsBottom: 1,
	  //minSpareRows: 1,
	  manualRowResize: true,
	  manualColumnResize: true,
	  rowHeaders: true,
	  colHeaders: [
		    'ITEM CODE'
		  	,'TEST TYPE'
			,'TEST NAME'
			,'CATEGORY1'
			,'CATEGORY2'
			,'UPDATE DATE'
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
	  afterChange: function (change, source) {		//그리드 내 Cell 의 변경이 일어난 직후 호출 함수
		if(source == 'loadData' || source == 'editStat') {return;}
	  } 
	};
	
	
	var hotElement2 = document.querySelector('#excelTableList2');
	var hotElementContainer2 = hotElement2.parentNode;
	var hotSettings2 = {
		data: hotGridData2,
		columnSorting: true,
		columns: [
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
	      	data: 'MOD_DT',
	      	type: 'text',
	      	editor:false,
		    readOnly:true,
	    },
	],
	  width: 965,
	  autoWrapRow: true,
	  height: 620,
	  //maxRows: 22,
	  startRows: 1,
	  startCols: 1,
	  //fixedRowsBottom: 1,
	  //minSpareRows: 1,
	  manualRowResize: true,
	  manualColumnResize: true,
	  rowHeaders: true,
	  colHeaders: [
		  	'Test Set Idx'
		    ,'Model Name'
		  	,'Test Type'
			,'Test Set'
			,'Total Test Count'
			,'Update Date'
	  ],
	  manualRowMove: true,	//로우 드래그앤 드랍 위치이동
	  manualColumnMove: true, 	//컬럼 드래그앤 드랍 위치이동
	  contextMenu: true,	//우클릭시 컨텍스트. 컨텍스트 내용 추가, 제거 가능
	  filters: true,				//header의 필터내용 여부
	  dropdownMenu: true,	//특정 col의 dropdown 허용
	  allowInvalid:false,		//dropdown List 의 수정을 리스트내에서만 수정가능하게 함.
	  fillHandle: {
	  	autoInsertRow: true,
	  },
	  hiddenColumns : {
		  columns : [0],
		  indicators:false,
	  },
	  afterChange: function (change, source) {		//그리드 내 Cell 의 변경이 일어난 직후 호출 함수
		if(source == 'loadData' || source == 'editStat') {return;}
	  } 
	};
	
	var hot = new Handsontable(hotElement, hotSettings);
	var hot2 = new Handsontable(hotElement2, hotSettings2);
	var hotGridData, hotGridData2;
	
	/**
	* 해당 Master 리스트를 가지고 온다.
	*/
	var getMasterPopList = function(){
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_sm.master.all",
			data:{ 
						page:1, rows:999999, 
						filters: JSON.stringify({
													searchTool:[],
													searchProtocol : [],
													searchCate1 : [],
													searchCate2 : [],
													copyList : [],
													}),
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
		    	hotGridData = res.dataList;
				    hot.loadData(hotGridData);
			    
				// Context 메뉴 셋팅
			    gridUpdateSetting(getEditableParam(), hot);
			},
			error : function(err){
				alert("Error : " + err.statusText);
				console.log(err);
			}
		});	
	}
	
	/**
	* 해당 TestSet 리스트를 가지고 온다.
	*/
	var getTestSetPopList = function(){
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_sm.testSet.others",
			data:{ 
						page:1, rows:999999, 
						testSetIdx : nvl(pTestSetIdx,''),
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
		    	hotGridData2 = res.dataList;
				    hot2.loadData(hotGridData2);
			    
				// Context 메뉴 셋팅
			    gridUpdateSetting(getEditableParam2(), hot2);
			},
			error : function(err){
				alert("Error : " + err.statusText);
				console.log(err);
			}
		});	
	}
	
	/**
	* 그리드의 셋팅을 업데이트 한다.
	*/
	var gridUpdateSetting = function(param, htContainer){
		htContainer.updateSettings(param);
	}
	
	/**
	* 화면상 버튼들 컨트롤
	*/
	var btnClick = function(btn){
		this.btnSetting(btn);	//버튼 문구 Toggle
	}
	
	/**버튼 Toggle*/
	var btnSetting = function(btn){
		if( btn == 'copyBtn' ){
			excelGridAllCopy();	//save 완료가 되었다면, 화면의 btn toggle
			
		}else if(btn == 'closeBtn'){
			self.close();
		}
		
	}
	
	/**선택한 그리드 삭제*/
	var gridDel = function(){
	    var selection = container.handsontable('getSelected');
	    container.handsontable('alter','remove_row',selection[0],selection[2]);
	}
	
	/**
	* 그리드의 모드 변환.
	*/
	var getEditableParam = function(){
		var updateParam='';
		var today = getTodate();
		
			updateParam = {
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
							"copy" : {
								name: 'Copy to TestSet',
								callback: function(key, options) {
									if( hot.getSelected().length == 0 ){
										alert("There are no Selected.");
							 			return false;
									}
									
									var copyList = new Array();
									var arr = hot.getSelected();
									
									for(var i = arr[0][0]; i <= arr[0][2]; i++){
										copyList.push(hot.getDataAtCell(i, 0));
									}
									
									var isOk = checkOpenerData();
									if(isOk){
										if(confirm("Existing data will be deleted. Do you still want to add it?")){
											opener.getMasterCopyList(copyList);	
										}else{
											return;
										}
									}else{
										opener.getMasterCopyList(copyList);
									}
								}
							},
						}
					},
			}
		return updateParam;		
	}
	
	/**
	* 그리드의 모드 변환.
	*/
	var getEditableParam2 = function(){
		var updateParam='';
		var today = getTodate();
		
			updateParam = {
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
							"copy" : {
								name: 'Copy to TestSet',
								callback: function(key, options) {
									if( hot2.getSelected().length == 0 ){
										alert("There are no Selected.");
							 			return false;
									}
									
									var copyList = new Array();
									var arr = hot2.getSelected();
									
									for(var i = arr[0][0]; i <= arr[0][2]; i++){
										copyList.push(hot2.getDataAtCell(i, 0));
									}
									
									var isOk = checkOpenerData();
									if(isOk){
										if(confirm("Existing data will be deleted. Do you still want to add it?")){
											opener.getTestSetCopyList(copyList);	
										}else{
											return;
										}
									}else{
										opener.getTestSetCopyList(copyList);
									}
								}
							},
						}
					},
			}
		return updateParam;		
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
	
	var drawSearchArea = function(data){
		var html = '';
		for(var i=0; i < data.length; i++){
			html += '<option value="'+data[i].COMM_TYPE+'">'+data[i].COMM_TYPE_VALUE+'</option>';
		}

		$('#searchCode').append(html);
		
		/* var select = $("#searchCode, #searchCate2, #searchTool, #searchProtocol").multiselect({
			selectedList: 1,
			height:100,
			width:'80%',
			selectedText: 'Item # selected',
			noneSelectedText: 'Select Items',
			minWidth:155
		}); */
	}
	
	/**
	* Enter Key 이벤트
	*/
	var enterkeyDown = function(){
		if (window.event.keyCode == 13) {
			page = 1;
			getCommCodeList();	         
	    }
	}
	
	/**
	* Data 를 카피하기 전 그리드에 Data가 존재하는지 체크(기존데이터를 지우고 입력하기 때문)
	*/
	var checkOpenerData = function(){
		if(opener.hot.countRows() > 0){
			return true;
		}else{
			return false;
		}
	}
	 
	var callAlertFromParent = function(flag){
		if(flag){
			alert("Copy Complete!");
		}else{
			
		}
	}
</script>
<form name="form1" id="form1">
<input type="hidden" name="sender" value="confluence"/>
<input type="hidden" name="testSetIdx" value="${param.testSetIdx}"/>
</form>
</body>
</html>
