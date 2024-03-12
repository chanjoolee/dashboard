<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="txt/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<%@include file="include/ssd_top.jsp" %>
<title>SK hynix 2018</title>
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
		<div id="lay_container">
			<div id="lay_contents">
                <!-- Tab master -->
                <div class="tab_master">
					<div class="tab_master_wrap">
						<div class="tab_list_wrap">
                            <ul class="tab_list">
                                <li class="tab_item"> 
                                    <a href="#" class="tab_link" onclick="dashboardShow('_self','/dashboard/generic.do?viewName=ssd_sm/test_master_mgmt');">Test Mgmt. System - Master Mgmt.</a>
                                </li>
                                <li class="tab_item">
                                    <a href="#" class="tab_link" onclick="dashboardShow('_self','/dashboard/generic.do?viewName=ssd_sm/test_set_mgmt');">Test Mgmt. System - Test Set Mgmt.</a>
                                </li>
                                <li class="tab_item selected">
                                    <a href="#" class="tab_link">Map Test Project - Test Set.</a>
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
                                <div class="tit">Map Test Project</div>
                            </td>
                        </tr>
                    </table>
                    <!-- //Page Title -->
                    
                    <!-- Tab Type01 -->
                    <!-- <div class="tab_type01" id="contentsTab">
                        <ul class="tab_list">
                            <li class="tab_item selected">
                                <a class="tab_link" rel="contentsTab_01">Tab Menu01</a>
                            </li>
                            <li class="tab_item">
                                <a class="tab_link" rel="contentsTab_02">Tab Menu02</a>
                            </li>
                            <li class="tab_item">
                                <a class="tab_link" rel="contentsTab_03">Tab Menu03</a>
                            </li>
                            <li class="tab_item">
                                <a class="tab_link" rel="contentsTab_04">Tab Menu04</a>
                            </li>
                        </ul>
                    </div> -->
                    <!-- //Tab Type01 -->
                    <!-- Tab Contents -->
                    <div class="tab_contents_wrap" rel="contentsTab">
                        <div class="tab_contents" id="contentsTab_01">
                            <!-- Sub Title2 -->
                            <div class="opt_tit">
                                <div class="opt_tit_left">
                                    <div class="elmt">
                                        <span class="opt_tit_bu opt_tit_bu_01"></span>
                                        <span class="txt">Map Test Project - Test Set.</span>
                                    </div>
                                </div>
                                <div class="opt_tit_right">
                                    <div class="elmt">
                                    	<!-- <a href="javascript:btnClick('addBtn');" class="btn_txt btn_type_c btn_color_a">
                                            <span class="txt" id="addBtn" style="vertical-align: text-top">ADD</span>
                                        </a> -->
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
                                <div id="excelTableList2" style="margin-top: 10px;width: 100%;"></div>
                            </div>
                            <!-- //Board List -->
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
	var testTypeCombo, testSetCombo = [];
	var totRowCnt = 0;
	var page = 1;
	var pageSize = 10;
	var rows = 500;
	var options;
	var loginUserId;
	
	$(document).ready(function(){
		var paramObj = ["00"];
		
		loginUserId = $('#userId').val()==''?'SYSTEM':$('#userId').val();
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.commonComboSearch",
			data: { 
						filters: JSON.stringify({commCdType:paramObj}) 
					},	
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			    var data = res.dataList;
			    
			    testTypeCombo = selectboxSetting(data, 'type');
			},
			error : function(err){
				alert("Error : " + err.statusText);
			}
			
		});
		
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.testSet.all",
			data: { 
						page:1, rows:999999
					},	
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			    var data = res.dataList;
			    
			    testSetCombo = selectboxSetting(data, 'set');
			},
			error : function(err){
				alert("Error : " + err.statusText);
			}
			
		});
		
		
		//Map Test project - Test set. 목록을 가져온다.
	    getTestMapProjectList(1);
		
	});
	
	var selectboxSetting = function(data, flag){
		var temp1 = new Array();
		
	    for(var i = 0; i < data.length; i++){
	    	if(flag == 'type'){
	    		temp1.push(data[i].COMM_VALUE);	
	    	}else{
	    		temp1.push(data[i].TEST_SET);
	    	}
	    	
	    }
	    
	    return temp1;
	    
	}
	
	/**
	* Map Project List settting
	*/
	var hotElement = document.querySelector('#excelTableList2');
	var hotElementContainer = hotElement.parentNode;
	var hotSettings = {
		data: hotGridData,
		columns: [
		{
		  	data: 'ROW_STATUS',
		    type: 'text',
		    editor:false,
		    readOnly:true,
		    className:'htCenter htMiddle'
	    },
  		{
		  	data: 'PROJECT_ID',
		    type: 'text',
		    editor:false,
		    readOnly:true,
	    },
	    {
		  	data: 'PJT_CODE',
		    type: 'text',
		    editor:false,
		    readOnly:true,
	    },
	    {
		  	data: 'PROJECT_NAME',
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
	      	width:'200px',
	    },
	],
	  stretchH: 'all',
	  width: '100%',
	  autoWrapRow: true,
	  height: 587,
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
		  	,'Test Project ID'
		  	,'Test Project Code'
		  	,'Test Project Name'
			,'Test Type'
			,'Test Set'
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
	  /* hiddenColumns : {
		  columns : [1],
		  indicators:false,
	  }, */
	  afterChange: function (change, source) {		//그리드 내 Cell 의 변경이 일어난 직후 호출 함수
		  	if(source == 'loadData' || source == 'editStat') {return;}
	  
		  	for(var i=0; i < change.length; i++){
		  		var isNull = true;		//행전체를 선택 후 Delete 버튼 누를 경우 I도 지움.
		  		var index = change[i][0];
		  		var nnKey = hot.getDataAtCell(change[i][0], 'PROJECT_ID');
		  		
				if( '' != nnKey && null != nnKey  ){
		  			
		  			if( change[i][2] != change[i][3] && hot.getDataAtCell(index, 0) != 'I'){
		  				hot.setDataAtCell(index, 0, 'U','editStat');
				   	}	
		  		}else if( null == nnKey){
		  			
		  			if(change[i][3] != ''){
	  					isNull = false;
	  				}
		  			
	  				if(!isNull){
	  					hot.setDataAtCell(index, 0, 'I','editStat');		
	  				}else{
	  					/* hot.setDataAtCell(index, 0, '','editStat');
	  					if(hot.isEmptyRow(index)){
	  						isDelArr.push(index);
	  					} */	
	  				}
		  		}
		  		
		  	}

		  	//행삭제
		  	/* var result = removeDuplicateArr(isDelArr);
			$.each(result, function (index, element){
			    hot.alter('remove_row', element);
			}); */
		  	
		  	var currentRows = hot.countRows();
		    $('#currentCnt').text(currentRows);
		  	
		  }
	};

	var hot = new Handsontable(hotElement, hotSettings);
	
	var hotGridData;
	
	/**
	* 전체 Test Set 리스트를 가지고 온다.
	*/
	var getTestMapProjectList = function(pPage){
		var flagText = $('#editBtn').text();
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.mapProject.all",
			data:{ 
						page:pPage, rows:rows, 
					},
			dataType: 'json',
			success: function(res){
			    hotGridData = res.dataList;
				hot.loadData(hotGridData);
				
				//paging
			    var page_viewList = Paging(
			    								(res.dataList.length== 0) ? 0 : res.dataList[0].TOT_CNT, 
			    								rows, 
			    								pageSize,
			    								page, 
			    								"getTestMapProjectList"
			    							); 
			    $("#demo_page").empty().html(page_viewList);
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
			var row = hot.countRows();
			hot.alter('insert_row', row);
			gridEditableSetting(hot, row);
			$('#editBtn').html('SAVE');
			
		}else if( btn == 'editBtn' ){
			if( $('#editBtn').html() == 'EDIT' ) {
				if(hot.countRows() == 0){
					alert("No rows to edit.");
					return;
				}
				$('#editBtn').html('SAVE');
				gridUpdateSetting(hot, getEditableParam(hot, 'save'));
				$('#cancelBlock').show();
			}else {
				excelGridAllSave(hot);	//save 완료가 되었다면, 화면의 btn toggle
			}
			
		}else if(btn == 'moreBtn' ){
			var compareTotCnt = $('#totalCnt').text();
			var compareCurCnt = hot.countRows();
			if( compareTotCnt <=  compareCurCnt ){
				alert("Currently the last row.");
				return;
			}
			getTestMapProjectList('more');
		}else if(btn == 'searchBtn'){
			page=1;
			getTestMapProjectList();
		}else if(btn == 'clearBtn'){
			/* $('.condition_table').find(':input').each(function(){
				switch(this.type){
					case 'select-multiple' :
						$(this).selectedIndex = 0; 
		                break;
					case 'select-one':
				}
			}) */
			$("#searchCate1, #searchCate2, #searchTool, #searchProtocol").multiselect("uncheckAll");
		}else if(btn == 'cancelBtn'){
			if( !hot.isEmptyCol(0) ){
				if(confirm("There are revised contents. Do you want to initialize?")){
					$('#editBtn').html('EDIT');
					$('#cancelBlock').hide();
					gridUpdateSetting(hot, getEditableParam(hot, 'edit'));
					page = 1;
					//page--;
					getTestMapProjectList(page);
				}else{
					return;
				}
			}else{
				$('#editBtn').html('EDIT');
				$('#cancelBlock').hide();
				gridUpdateSetting(hot, getEditableParam(hot, 'edit'));
				page = 1;
				//page--;
				getTestMapProjectList(page);
			}
		}
	}
	
	var gridEditableSetting = function(htContainer, row){
		htContainer.setDataAtCell(row, 0, 'I','editStat');
		rowEditableChange(htContainer, row);
	}
	
	var rowEditableChange = function(htContainer, rowNum){
		var rowStatus = htContainer.getDataAtCell(rowNum, 0);
		
		htContainer.updateSettings({
			cells : function(row, col, prop){
				var cellProperties = {};
				if( rowStatus == 'I' ){
					if( prop === 'PROJECT_ID' 
						|| prop === 'PJT_CODE'
						|| prop === 'PROJECT_NAME' ){
						cellProperties.editor = 'text';
						cellProperties.readOnly = true;
					
					}else if(prop === 'TEST_TYPE'){
						cellProperties.type = 'dropdown';
						cellProperties.source = testTypeCombo;
						cellProperties.width = '100px';
						cellProperties.readOnly = false;
					}else if(prop === 'TEST_SET'){
						cellProperties.type = 'dropdown';
						cellProperties.source = testSetCombo;
						cellProperties.width = '200px';
						cellProperties.readOnly = false;
					}
				}
				
				return cellProperties;
			}
		});
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
	var getEditableParam = function(hContainer, flag){
		var updateParam='';
		var today = getTodate();
		
		if(flag == 'save'){
			updateParam = {
					columns: [
				  		{
						  	data: 'ROW_STATUS',
						    type: 'text',
						    editor:false,
						    readOnly:true,
						    className:'htCenter htMiddle'
					    },
				  		{
						  	data: 'PROJECT_ID',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
						  	data: 'PJT_CODE',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
						  	data: 'PROJECT_NAME',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'TEST_TYPE',
					      	type: 'dropdown',
					      	source: testTypeCombo,
					      	width:'100px',
					    },
					    {
					      	data: 'TEST_SET',
					      	type: 'dropdown',
					      	source: testSetCombo,
					      	width:'200px',
					    },
					],
			}
		}else{
			updateParam = {
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
						  	data: 'PROJECT_ID',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
						  	data: 'PJT_CODE',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
						  	data: 'PROJECT_NAME',
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
					      	width:'200px'
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
		if( hot.isEmptyCol(0) ){
			alert("There are no changes.");
			$('#editBtn').html('EDIT');
			gridUpdateSetting(hot, getEditableParam(hot, 'edit'));
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
							tempObj.rStatus 			= nvl(data[i][0],'');
							tempObj.projectId 		= nvl(data[i][1],'');
							tempObj.pjtCode 			= nvl(data[i][2],'');
							tempObj.projectNm 		= nvl(data[i][3],'');
							tempObj.testType		= nvl(data[i][4],'');
							tempObj.testSet			= nvl(data[i][5],'');
							tempObj.modBy			= loginUserId;
							paramObj.push(tempObj);
						}
					}
					
					$.ajax({
		       			url: "/dashboard/genericAllSaveJson.do?sqlid=dashboard.ssd_sm.mapProjectGridSave",
		        		dataType: "json",
		        		type: "POST",
		        		async : true,
				        data: {
				        	autoJson: JSON.stringify(paramObj)
		           		}, 
		        		success: function (data) {
		        			alert("You have saved "+data.resultCnt+" cases in total.");

		        			// 정상 save 시 버튼 토글
		        			$('#editBtn').html('EDIT');
							gridUpdateSetting(hot, getEditableParam(hot, 'edit'));	
							
							getTestMapProjectList(1);
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
</script>
<form name="form1" id="form1">
<input type="hidden" name="sender" value="confluence"/>
<input type="hidden" name="testSetIdx" value=""/>
</form>
</body>
</html>
