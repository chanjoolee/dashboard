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
    
    .ht_master tr > td.foo {
	  background-color: #fff1ea;
	}
	
	.ht_master tr > td.foo2 {
	  background-color: #e3f3f7;
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
	
	/**progress circle  start*/
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
	/**progress circle end */
	
	
	/* The snackbar - position it at the bottom and in the middle of the screen */
	#snackbar {
	    visibility: hidden; /* Hidden by default. Visible on click */
	    min-width: 250px; /* Set a default minimum width */
	    margin-left: -125px; /* Divide value of min-width by 2 */
	    background-color: #333; /* Black background color */
	    color: #fff; /* White text color */
	    text-align: center; /* Centered text */
	    border-radius: 2px; /* Rounded borders */
	    padding: 16px; /* Padding */
	    position: fixed; /* Sit on top of the screen */
	    z-index: 1; /* Add a z-index if needed */
	    left: 50%; /* Center the snackbar */
	    bottom: 30px; /* 30px from the bottom */
	}
	
	/* Show the snackbar when clicking on a button (class added with JavaScript) */
	#snackbar.show {
	    visibility: visible; /* Show the snackbar */
	
	/* Add animation: Take 0.5 seconds to fade in and out the snackbar. 
	However, delay the fade out process for 2.5 seconds */
	    -webkit-animation: fadein 0.5s, fadeout 0.5s 2.5s;
	    animation: fadein 0.5s, fadeout 0.5s 2.5s;
	}
	
	/* Animations to fade the snackbar in and out */
	@-webkit-keyframes fadein {
	    from {bottom: 0; opacity: 0;} 
	    to {bottom: 30px; opacity: 1;}
	}
	
	@keyframes fadein {
	    from {bottom: 0; opacity: 0;}
	    to {bottom: 30px; opacity: 1;}
	}
	
	@-webkit-keyframes fadeout {
	    from {bottom: 30px; opacity: 1;} 
	    to {bottom: 0; opacity: 0;}
	}
	
	@keyframes fadeout {
	    from {bottom: 30px; opacity: 1;}
	    to {bottom: 0; opacity: 0;}
	}
</style>

</head>
<body>
	<div id="lay_wrap" class="lay_col2 lay_100">
		<!-- <div id="lay_container"> -->
			<div id="lay_contents">
                <!-- Tab master -->
                <div class="tab_master">
					<div class="tab_master_wrap">
						<div class="tab_list_wrap">
                            <ul class="tab_list">
                                <li class="tab_item selected"> 
                                    <a href="#" class="tab_link">Test Mgmt. System - Master Mgmt.</a>
                                </li>
                                <li class="tab_item">
                                    <a href="#" class="tab_link" onclick="dashboardShow('_self','/dashboard/generic.do?viewName=ssd_sm/test_set_mgmt');">Test Mgmt. System - Test Set Mgmt.</a>
                                </li>
                                <li class="tab_item">
                                    <a href="#" class="tab_link" onclick="dashboardShow('_self','/dashboard/generic.do?viewName=ssd_sm/test_map_project_mgmt');">Map Test Project - Test Set.</a>
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
                                        <th scope="col" class="condition_t_head">Tool</th>
                                        <td class="condition_t_data">
                                            <select class="jqForm" name="searchTool" id="searchTool" multiple="multiple" style="width:150px;" onkeydown="javascript:enterkeyDown();">
                                                <option value="">---ALL---</option>
                                            </select>
                                        </td>
                                        <th scope="col" class="condition_t_head">Protocol</th>
                                        <td class="condition_t_data">
                                            <!-- <input type="checkbox" class="jqForm" id="srch_chbox00" name="srch_group1" checked="checked" ><label for="srch_chbox00">checked</label>
                                            <input type="checkbox" class="jqForm" id="srch_chbox01" name="srch_group1"><label for="srch_chbox01">Unchecked</label> -->
                                            <select class="jqForm" name="searchProtocol" id="searchProtocol" multiple="multiple" style="width:150px;" onkeydown="javascript:enterkeyDown();">
                                                <option value="">---ALL---</option>
                                            </select>
                                        </td>
                                        <th scope="col" class="condition_t_head">Category1</th>
                                        <td class="condition_t_data">
                                            <select class="jqForm" name="searchCate1" id="searchCate1" multiple="multiple" style="width:110px;" onkeydown="javascript:enterkeyDown();">
                                                <option value="">---ALL---</option>
                                            </select>
                                        </td>
                                        <th scope="col" class="condition_t_head">Category2</th>
                                        <td class="condition_t_data">
                                        	<select class="jqForm" name="searchCate2" id="searchCate2" multiple="multiple" style="width:150px;" onkeydown="javascript:enterkeyDown();">
                                                <option value="">---ALL---</option>
                                            </select>
                                            <!-- <input type="radio" class="jqForm" id="srch_radio00" name="srch_group2" value="checked" checked="checked"><label for="srch_radio00">checked</label>
                                            <input type="radio" class="jqForm" id="srch_radio01" name="srch_group2" value="unchecked" ><label for="srch_radio01">unchecked</label> -->
                                            <!-- <!-- jquery : datepicker -->
                                            <!-- <input type="text" class="inp_date" id="datepicker" value="2015.12.31" />
                                            <script>
                                                $(document).ready(function(){
                                                    $( "#datepicker" ).datepicker({
                                                        showOn: "button",
                                                        buttonImage: "images/ssd/form/calendar.jpg",
                                                        buttonImageOnly: true,
                                                        buttonText: "Select date",
                                                        dateFormat: "yy.mm.dd",
                                                        changeMonth: true,
                                                        changeYear: true,
                                                        showButtonPanel: true
                                                    });
                                                });
                                              </script>
                                            //jquery : datepicker -->
                                        </td>
                                    </tr>
                                    <!-- <tr>
                                        <th scope="col" class="condition_t_head">검색조건</th>
                                        <td class="condition_t_data">
                                            jquery : datepicker
                                            <input type="text" class="inp_date" id="from" value="from" />
                                            <span class="name">~</span>
                                            <input type="text" class="inp_date" id="to" value="to" />
                                            <script>
                                                $(document).ready(function(){
                                                    $( "#from" ).datepicker({
                                                        onClose: function( selectedDate ) {
                                                            $( "#to" ).datepicker( "option", "minDate", selectedDate );
                                                        },
                                                        showOn: "button",
                                                        buttonImage: "images/ssd/form/calendar.jpg",
                                                        buttonImageOnly: true,
                                                        buttonText: "Select date",
                                                        dateFormat: "yy.mm.dd",
                                                        changeMonth: true,
                                                        changeYear: true,
                                                        showButtonPanel: true
                                                    });
                                                    $( "#to" ).datepicker({
                                                        defaultDate: "+1w",
                                                        onClose: function( selectedDate ) {
                                                            $( "#from" ).datepicker( "option", "maxDate", selectedDate );
                                                        },
                                                        showOn: "button",
                                                        buttonImage: "images/ssd/form/calendar.jpg",
                                                        buttonImageOnly: true,
                                                        buttonText: "Select date",
                                                        dateFormat: "yy.mm.dd",
                                                        changeMonth: true,
                                                        changeYear: true,
                                                        showButtonPanel: true
                                                    });
                                                });
                                              </script>
                                            //jquery : datepicker
                                        </td>
                                        <th scope="col" class="condition_t_head">검색조건</th>
                                        <td class="condition_t_data">
                                            <input type="text" class="" value="검색어 입력" />
                                            <a href="#" class="btn_form sep"><span class="form_ico form_ico_srch"><span class="blind">검색버튼</span></span></a>
                                        </td>
                                    </tr> -->
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
                                        <span class="txt">Master Mgmt.</span>
                                        <span class="total" id="totalSpan">Current / Total : <b id="currentCnt"></b> / <b id="totalCnt"></b></span>
                                    </div>
                                </div>
                                <div class="opt_tit_right">
                                    <div class="elmt">
                                    	<a href="javascript:btnClick('adminBtn');" class="btn_txt btn_type_c btn_color_b">
                                            <span class="txt" id="adminBtn" style="vertical-align: text-top">ADMIN</span>
                                        </a>
                                        <a href="javascript:btnClick('viewBtn');" class="btn_txt btn_type_c btn_color_a" >
                                            <span class="txt" id="viewBtn" style="vertical-align: text-top">VIEW - LATEST</span>
                                        </a>
                                        <a href="javascript:btnClick('editBtn');" class="btn_txt btn_type_c btn_color_b">
                                            <span class="txt" id="editBtn" style="vertical-align: text-top">EDIT</span>
                                        </a>
                                        <a href="javascript:btnClick('exportBtn');" class="btn_txt btn_type_c btn_color_c">
                                            <span class="txt" id="exportBtn" style="vertical-align: text-top">EXPORT</span>
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
                            <!-- Button List -->
                            <!-- Page Navigation -->
                            <div style="width:100%;position:relative">
	                           	<div class="nav_paging">
	    							<div class="nav_paging_wrap" id="demo_page">
	    							</div>
	   							</div>
                            </div>
                            <!-- //Page Navigation -->
                            <!-- Button List 3 -->
							<div class="opt_tit" id="cancelBlock" style="display: none;">
                                <div class="opt_tit_right">
                                    <div class="elmt">
                                        <a href="javascript:btnClick('cancelBtn');" class="btn_txt btn_type_c btn_color_C">
                                            <span class="txt" id="cancelBtn" style="vertical-align: text-top;">CANCEL</span>
                                        </a>
                                    </div>	
                                </div>
                            </div>                            
                            <!-- //Button List 3 -->
                            <!-- //Button List -->
                            
                        </div>
                    </div>
                    <script>
                    $(document).ready(function(){
                        tab_view('#contentsTab', true, false)
                    });
                    </script>
                    <!-- //Tab Contents -->
                </div>
            </div>
		<!-- </div> -->
	</div>
	
</form>
<script type="text/javascript">
	var cate1ComList, cate2ComList, toolComList, protoComList, typeComList = [];
	var totRowCnt = 0;
	var page = 1;
	var pageSize = 10;
	var rows = 100;
	var viewOption = 'latest';
	var options;
	var loginUserId;
	
	$(document).ready(function(){
		var paramObj = ["00","01","02","03","05"];		//추후 다시 sql 에서 foreach가 안먹힘
		
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
			    
			    selectboxSetting(data);
			    
			    //master 목록을 가져온다.
			    getMasterList(1);
			},
			error : function(err){
				alert("Error : " + err.statusText);
			}
			
		});
	});
	
	/**
	* 그리드 내 select box 내용 설정. & search 영역 설정
	*/
	var selectboxSetting = function(data){
		var temp0 = new Array();
		var temp1 = new Array();
	    var temp2 = new Array();
	    var temp3 = new Array();
	    var temp5 = new Array();
	    
	    for(var i = 0; i < data.length; i++){
	    	switch(data[i].COMM_TYPE){
	    	case "00" :		//category1
	    		temp0.push(data[i].COMM_VALUE);
	    		break;
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
	    	default:
	    	}
	    }
	    
	    typeComList = temp0;
	    cate1ComList = temp1;
	    cate2ComList = temp2;
	    toolComList = temp3;
	    protoComList = temp5;
	    
	    //search 영역 그리기
	    drawSearchArea(data);		
	}
	
	var beforeItemCode;
	var rowColorChange = function(htContainer){
		htContainer.updateSettings({
			cells : function(row, col, prop){
				var cellProperties = {};
				if( viewOption == 'history' ){
					if( htContainer.getDataAtCell(row, 28) == 'Y' ){
						cellProperties.className='foo';
					}else{
						cellProperties.className='';
					}
				}
				
				return cellProperties;
			}
		});
	}
	/* function customDropdownRenderer(instance, td, row, col, prop, value, cellProperties)
	{
	    var selectedId;
	    for (var index = 0; index < cate1ComList.length; index++)
	    {
	        if (parseInt(value) === cate1ComList[index].id)
	        {
	            selectedId = cate1ComList[index].id;
	            value = cate1ComList[index].text;            
	        }
	    }
	    Handsontable.TextCell.renderer.apply(this, arguments);
	    // you can use the selectedId for posting to the DB or server
	    $('#selectedId').text(selectedId);
	} */

	/**
	* HandsOnTable Grid 셋팅
	*/
	var hotElement = document.querySelector('#excelTableList');
	var hotElementContainer = hotElement.parentNode;
	var hotSettings = {
		data: hotGridData,
	  	width: '100%',
	  	autoWrapRow: true,
	  	height: 687,
	  	//maxRows: 22,
		startRows: 1,
	  	startCols: 1,
	  	//fixedRowsBottom: 1,
	  	//minSpareRows: 1,
	  	manualRowResize: true,
	  	manualColumnResize: true,
	  	rowHeaders: true,
	  	colHeaders: [
		  	'STAT'
		  	,'ITEM_CODE'
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
			,'CREATED DATE'
			,'UPDATE BY'
			,'UPDATE DATE'
			,'VARIATION'
			,'FINAL REV'
	  	],
	  	manualRowMove: true,	//로우 드래그앤 드랍 위치이동
	  	manualColumnMove: true, 	//컬럼 드래그앤 드랍 위치이동
	  	contextMenu: true,	//우클릭시 컨텍스트. 컨텍스트 내용 추가, 제거 가능
	  	filters: true,				//header의 필터내용 여부
	  	dropdownMenu: true,	//특정 col의 dropdown 허용. dropdownMenu: ['filter_by_condition', 'filter_action_bar']
	  	dropdownMenu: ['filter_by_condition', 'filter_action_bar', 'filter_by_value'],
	  	allowInvalid:false,		//dropdown List 의 수정을 리스트내에서만 수정가능하게 함.
	  	fillHandle: {
	  		autoInsertRow: true,
	  	},
	  	hiddenColumns : {
			columns : [28],
		  	indicators:false,
	  	},
	  	copyPaste: { 
			  rowsLimit: 500,
		  },
	  	afterChange: function (change, source) {		//그리드 내 Cell 의 변경이 일어난 직후 호출 함수
	  		if (source == 'CopyPaste.paste') {			//Copy & Paste 시 로딩서클 숨김
		    	$("#loader").hide();
		    }
	  	
		  	if(source == 'loadData' || source == 'editStat') {return;}
	  		
		  	var isDelArr = new Array();
			
		  	for(var i=0; i < change.length; i++){
		  		var isNull = true;
		  		var index = change[i][0];
		  		var itemCode = hot.getDataAtCell(change[i][0], 'ITEM_CODE');
		  		if( null != itemCode ){
		  			
		  			if( change[i][2] != change[i][3] && hot.getDataAtCell(index, 0) != 'I'){
				   		hot.setDataAtCell(index, 0, 'U','editStat');
				   	}	
		  		}else if( null == itemCode ){
		  			//행전체를 선택 후 Delete 버튼 누를 경우 I도 지움.
		  			if(change[i][2] == null){
	  					isNull = false;
	  				}
		  			
	  				if(!isNull){
	  					hot.setDataAtCell(index, 0, 'I','editStat');		
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
		  	
		  /**
		  * 실시간 수정
		  */
		  	/* var $container = $("#excelTableList");
		  	var $parent = $container.parent();
		  	var autosaveNotification;
		  	var paramObj = new Array();
		  	if(source === 'loadData') {return;}
		  
		  	for(var i=0; i < change.length; i++){
		  		change[i].push(change[i][1]+'_n');
		  		var tempObj = new Object();
		  		tempObj.index = change[i][0];
		  		tempObj.colum = change[i][1];
		  		tempObj.oriVal = change[i][2];
		  		tempObj.newVal = change[i][3];
		  		tempObj.itemCode = hot.getDataAtCell(change[i][0], 'ITEM_CODE');
		  		if( hot.getDataAtCell(change[i][0], 'ITEM_CODE') != '' & hot.getDataAtCell(change[i][0], 'ITEM_CODE') != null){
		  			paramObj.push(tempObj);
		  		}
		  	}
		  	
		  	//ITEM_CODE 가 없는 로우는 실시간 수정에서 제외
		  	if(paramObj.length == 0){
		  		return;
		  	}

			clearTimeout(autosaveNotification);
			console.log(change);
		  	console.log(JSON.stringify(paramObj));
	       	$.ajax({
	       			url: "/dashboard/genericAutoSaveJson.do?sqlid=dashboard.ssd_sm.commonGridSave",
	        		dataType: "json",
	        		type: "POST",
			        data: {
			        	autoJson: JSON.stringify(paramObj)
               		}, 
	        		success: function (data) {
	          			console.log('Autosaved (' + change.length + ' cell' + (change.length > 1 ? 's' : '') + ')');
	          			autosaveNotification = setTimeout(function () {
	            		console.log('Changes will be autosaved');
	          			}, 1000);
	        		},
	        		error: function (err) {
	                    $('#container').html('Error: ' + err.statusText);
	                }
	      	}); */
		  	},
		  	afterLoadData : function(firstTime){
				$("#loader").hide();
			},
			beforePaste : function(data, coords){		//Copy & Paste 시 로딩서클 로드 & 복사가 500개 이상일시에 toast 로 경고.
				// Get the snackbar DIV
			    var x = document.getElementById("snackbar");
				if(data.length > 1){
					// Add the "show" class to DIV
				    x.className = "show";
					x.innerText ="Up to 500 lines can be entered.";
				    // After 3 seconds, remove the show class from DIV
				    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 5000);					
				}

				$("#loader").show();
			},
			
		};

	var hot = new Handsontable(hotElement, hotSettings);
	var hotGridData;
	
	/**
	* 전체 Master 리스트를 가지고 온다.
	*/
	var getMasterList = function(pPage){
		var flagText = $('#editBtn').text();
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.master.all",
			data:{ 
						listType:viewOption, 
						page:pPage, rows:rows, 
						filters: JSON.stringify({
													searchTool:$('#searchTool').val() == null ? []:$('#searchTool').val(),
													searchProtocol : $('#searchProtocol').val() == null ? []:$('#searchProtocol').val(),
													searchCate1 : $('#searchCate1').val() == null ? []:$('#searchCate1').val(),
													searchCate2 : $('#searchCate2').val() == null ? []:$('#searchCate2').val(),
													copyList : [],
													}),
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			   /*  if(flag == 'more'){
			    	var data = res.dataList;
				    for(var j=0; j < data.length; j++){
				    	hotGridData.push(data[j]);
				    }
				    hot.updateSettings({data:hotGridData});
			    }else{
			    	hotGridData = res.dataList;
				    hot.loadData(hotGridData);
			    } */
			    hotGridData = res.dataList;
			    hot.loadData(hotGridData);
			    
			    page = pPage;
			    totRowCnt = res.dataList.length== 0 ? 0 : res.dataList[0].TOT_CNT;
			    $('#totalCnt').text(totRowCnt);
			    $('#currentCnt').text( (totRowCnt < page*rows) ? totRowCnt : page*rows );
			    
			    //paging
			    var page_viewList = Paging(
			    								(res.dataList.length== 0) ? 0 : res.dataList[0].TOT_CNT, 
			    								rows, 
			    								pageSize,
			    								page, 
			    								"getMasterList"
			    							); 
			    $("#demo_page").empty().html(page_viewList);
			    
				if( viewOption == 'history' ){
					rowColorChange(hot);
				}
			    
			    //현재 Edit or Save 버튼에 따라 해당 모드로 그리드 상태 셋팅			    
			    gridUpdateSetting(getEditableParam(flagText.toLowerCase()));
				
			},
			error : function(err){
				alert("Error : " + err.statusText);
			}
		});	
	}
	
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
	
	/**선택한 row 삭제*/
	var gridDel = function(){
	    var selection = container.handsontable('getSelected');
	    container.handsontable('alter','remove_row',selection[0],selection[2]);
	}
	
	/**버튼 Toggle*/
	var btnSetting = function(btn){
		if( btn == 'viewBtn'){
			
			if( $('#viewBtn').html() == 'VIEW - LATEST' ) {
				$('#viewBtn').html('VIEW - HISTORY');
				viewOption = 'history';
			}else {
				$('#viewBtn').html('VIEW - LATEST');
				viewOption = 'latest';
			}
			page = 1;
			getMasterList(page);
			/* $.ajax({		//loads data to Handsontable
				type: "POST",
				url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.master.all",
				data:{
							listType:viewOption, page:1,rows:rows,
							filters: JSON.stringify({
								searchTool:$('#searchTool').val() == null ? []:$('#searchTool').val(),
								searchProtocol : $('#searchProtocol').val() == null ? []:$('#searchProtocol').val(),
								searchCate1 : $('#searchCate1').val() == null ? []:$('#searchCate1').val(),
								searchCate2 : $('#searchCate2').val() == null ? []:$('#searchCate2').val(),
								}),
						},
				dataType: 'json',
				success: function(res){
				    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
				    var data = res.dataList;
				    hotGridData= new Array();
				    for(var j=0; j < data.length; j++){
				    	//hot.alter('insert_row', currentRows+j, 1);
				    	//hot.spliceRow(new Number(currentRows)+new Number(j), data[j], 0);
				    	hotGridData.push(data[j]);
				    }
				    hot.updateSettings({data:hotGridData});
				    //hot.render();
				    var currentRows = hot.countRows();
				    $('#totalCnt').text(res.dataList.length== 0 ? 0 : res.dataList[0].TOT_CNT);
				    $('#currentCnt').text(currentRows);
				    page++;
				}
			}); */
			
		}else if( btn == 'editBtn' ){
			if( $('#editBtn').html() == 'EDIT' ) {
				$('#editBtn').html('SAVE');
				gridUpdateSetting(getEditableParam('save'));
				$('#totalSpan').hide();
				$('#cancelBlock').show();
			} else {
				excelGridAllSave();	//save 완료가 되었다면, 화면의 btn toggle
			}
			
		}else if(btn == 'moreBtn' ){
			var compareTotCnt = $('#totalCnt').text();
			var compareCurCnt = hot.countRows();
			if( compareTotCnt <=  compareCurCnt ){
				alert("Currently the last row.");
				return;
			}
			getMasterList('more');
		}else if(btn == 'searchBtn'){
			getMasterList(1);
		}else if(btn == 'clearBtn'){
			$("#searchCate1, #searchCate2, #searchTool, #searchProtocol").multiselect("uncheckAll");
		}else if(btn == 'adminBtn'){
			var newwin = window.open("", "SSD_TEST_MASTER_ADMIN", "width=560px,height=570px,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
			var oFrm = document.getElementById("form1");
			//oFrm.menuAuthId.value = "MNU20150422131320740";
			oFrm.action =  '/dashboard/generic.do?viewName=ssd_sm/test_admin_mgmt';
			oFrm.method = "post";
			oFrm.target = 'SSD_TEST_MASTER_ADMIN'; 
			oFrm.submit();
			newwin.focus();
		}else if(btn == 'cancelBtn'){
			if( !hot.isEmptyCol(0) ){
				if(confirm("There are revised contents. Do you want to initialize?")){
					$('#editBtn').html('EDIT');
					$('#cancelBlock').hide();
					gridUpdateSetting(getEditableParam('edit'));
					page = 1;
					//page--;
					getMasterList(page);
				}else{
					return;
				}
			}else{
				$('#editBtn').html('EDIT');
				$('#cancelBlock').hide();
				gridUpdateSetting(getEditableParam('edit'));
				page = 1;
				//page--;
				getMasterList(page);
			}
		}else if( btn == 'exportBtn' ){
			if( hot.countRows() <= 0  ){
				alert("There's no Data.");
				return;
			}
		
			$.ajax({		//loads data to Handsontable
				type: "POST",
				url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.master.all",
				data:{ 
					listType:viewOption, 
					page:1, rows:999999, 
					filters: JSON.stringify({
												searchTool:$('#searchTool').val() == null ? []:$('#searchTool').val(),
												searchProtocol : $('#searchProtocol').val() == null ? []:$('#searchProtocol').val(),
												searchCate1 : $('#searchCate1').val() == null ? []:$('#searchCate1').val(),
												searchCate2 : $('#searchCate2').val() == null ? []:$('#searchCate2').val(),
												copyList : [],
												}),
				},
				dataType: 'json',
				success: function(res){
				    var exportObj = res.dataList;
					var exportName = 'Master Mgmt_ALL_'+getTodate();
					
					var dataStr = "data:text/json;charset=utf-8," + encodeURIComponent(JSON.stringify(exportObj));
				    var downloadAnchorNode = document.createElement('a');
				    downloadAnchorNode.setAttribute("href",     dataStr);
				    downloadAnchorNode.setAttribute("download", exportName + ".json");
				    document.body.appendChild(downloadAnchorNode); // required for firefox
				    downloadAnchorNode.click();
				    downloadAnchorNode.remove();
				}
			});
		}
	
	}
	
	/**
	* 컨텍스트 메뉴(우버튼클릭 메뉴)에서 5줄 추가
	*/
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
	* 그리드의 컬럼의 속성 셋팅. 모드 변환.(edit, save)
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
								/* disabled: function () {
						            // if first row, disable this option
						        	return hot.getSelected()[0] === 0;
						        }, */
								callback : function(key, options) {
						        	hot.alter('insert_row', options[0].end.row, 1);
						        	hot.setDataAtCell(options[0].end.row, 0, 'I','editStat');
						        	//rowEditableChange(hot);
						        	gridUpdateSetting(getEditableParam('save'));
						        },
							},
							"row_below" : {
								callback : function(key, options) {
									hot.alter('insert_row', options[0].end.row+1, 1);
									hot.setDataAtCell(options[0].end.row+1, 0, 'I','editStat');
									gridUpdateSetting(getEditableParam('save'));
						        },
							},
							"hsep1": "---------",
							"remove_row" : {
								callback : function(key, options) {
									var sRowIdx = options[0].start.row;
									var eRowIdx = options[0].end.row;
									var isDelArr = new Array();
									for(var i = sRowIdx; i <= eRowIdx; i++) {
										var itemCd = hot.getDataAtCell(i, 1);
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
							"export" : {
								name: 'Export to CSV',
								callback: function(key, options) {
									hot.getPlugin('exportFile').downloadFile('csv', {
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
						    className:'htCenter htMiddle'
					    },
				  		{
						  	data: 'ITEM_CODE',
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
					      	type: 'dropdown',
					      	source: typeComList,
					      	width:'100px',
						  	validator: notEmpty,
						  	allowInvalid:true,
					      	
					    },
					    {
					      	data: 'TOOL',
					      	type: 'dropdown',
					      	source: toolComList,
					      	width:'100px',
						  	validator: notEmpty,
						  	allowInvalid:true,
					      	
					    },
					    {
					      	data: 'PROTOCOL',
					      	type: 'dropdown',
					      	source: protoComList,
						  	validator: notEmpty,
						  	allowInvalid:true,
					    },
						{
						  	data: 'CATEGORY1',
						  	type: 'dropdown',
						  	source: cate1ComList,
						  	validator: notEmpty,
						  	allowInvalid:true,
					    },
					    {
					      	data: 'CATEGORY2',
					      	type: 'dropdown',
						  	source: cate2ComList,
						  	width:'150px',
						  	validator: notEmpty,
						  	allowInvalid:true,
					    },
					    {
					      	data: 'SUB_CATEGORY1',
					      	type: 'text',
					    },
					    {
					      	data: 'SUB_CATEGORY2',
					      	type: 'text',
					    },
					    {
					      	data: 'TEST_NAME',
							//renderer: flagRenderer
					      	type: 'text',
					      	validator: notEmpty,
						  	allowInvalid:true,
					    },
					    {
					      	data: 'COMMAND_LINE',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_00',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_01',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_02',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_03',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_04',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_05',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_06',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_07',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_08',
					      	type: 'text',
					    },
					    {
					      	data: 'ARG_09',
					      	type: 'text',
					    },
					    {
					      	data: 'DELETE_YN',
					      	type: 'dropdown',
					      	source:['Y','N'],
					    },
					    {
					      	data: 'CRT_BY',
					      	type: 'text',
					    },
					    {
					      	data: 'CRT_DT',
					      	type: 'date',
					      	dateFormat: 'YYYY-MM-DD',
					    },
					    {
					      	data: 'MOD_BY',
					      	type: 'text',
					    },
					    {
					      	data: 'MOD_DT',
					      	type: 'date',
					      	dateFormat: 'YYYY-MM-DD',
					    },
					    {
					      	data: 'VARIATION',
					      	type: 'dropdown',
					      	source:['public'],
					      	value:'public',
					    },
					    {
					      	data: 'COLOR_CHECK',
					      	type: 'text',
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
						    className:'htCenter htMiddle'
					    },
				  		{
						  	data: 'ITEM_CODE',
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
					      	width:'150px',
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
					      	data: 'VARIATION',
					      	type: 'text',
					      	editor:false,
					      	readOnly:true,
					    },
					    {
					      	data: 'COLOR_CHECK',
					      	type: 'text',
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
			emptyRowRemove();
			$('#editBtn').html('EDIT');
			gridUpdateSetting(getEditableParam('edit'));
			$('#cancelBlock').hide();
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
							tempObj.item_code 		= nvl(data[i][1],'');
							tempObj.rev 				= nvl(data[i][2],'');
							tempObj.test_type		= nvl(data[i][3],'');
							tempObj.tool 				= nvl(data[i][4],'');
							tempObj.protocol 			= nvl(data[i][5],'');
							tempObj.category1 		= nvl(data[i][6],'');
							tempObj.category2 		= nvl(data[i][7],'');
							tempObj.sub_category1	= nvl(data[i][8],'');
							tempObj.sub_category2 = nvl(data[i][9],'');
							tempObj.test_name		= nvl(data[i][10],'');
							tempObj.command_line	= nvl(data[i][11],'');
							tempObj.arg00				= nvl(data[i][12],'');
							tempObj.arg01				= nvl(data[i][13],'');
							tempObj.arg02				= nvl(data[i][14],'');
							tempObj.arg03				= nvl(data[i][15],'');
							tempObj.arg04				= nvl(data[i][16],'');
							tempObj.arg05				= nvl(data[i][17],'');
							tempObj.arg06				= nvl(data[i][18],'');
							tempObj.arg07				= nvl(data[i][19],'');
							tempObj.arg08				= nvl(data[i][20],'');
							tempObj.arg09				= nvl(data[i][21],'');
							tempObj.delete_yn		= nvl(data[i][22],'');
							tempObj.crt_by			= nvl(loginUserId,'');
							tempObj.crt_dt			= nvl(data[i][24],'');
							tempObj.mod_by			= nvl(loginUserId,'');
							tempObj.mod_dt			= nvl(data[i][26],'');
							tempObj.variation			= nvl(data[i][27],'');
							paramObj.push(tempObj);
						}
					}
					
					$.ajax({
		       			url: "/dashboard/genericAllSaveJson.do?sqlid=dashboard.ssd_sm.masterGridSave",
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
							gridUpdateSetting(getEditableParam('edit'));	
							$('#totalSpan').show();
							$('#cancelBlock').hide();
		        			page = 1;
		        			getMasterList(page);
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
				$('#totalSpan').hide();
				$('#cancelBlock').show();
				return;
			}
		});
		//$('#excelTableList').handsontable('render');
	}
	
	/**
	* null문자열을  '' 으로 변환
	*/
	var nvl = function(str, defaultStr){
        if(typeof str == "undefined" || str == null )
            str = defaultStr ;
        return str ;
    }

	/**
	* str null check
	*/
	var notEmpty = function(value, callback){
		if (!value || String(value).length === 0) {
	        callback(false);
	    } else {
	        callback(true);
	    }
	}
	
	/**
	* 오늘 날짜 가져오기
	*/
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
	* Search 영역 그리기
	*/
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
	
	/**
	* 엔터키 이벤트
	*/
	var enterkeyDown = function(){
		if (window.event.keyCode == 13) {
			page = 1;
			getMasterList(page);	         
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
	var emptyRowRemove = function(){
		var allRow = hot.countRows();
		var arr = new Array();
		for(var i=0; i<allRow; i++){
			if(hot.isEmptyRow(i)){
				arr.push(i);
			}
		}
		$.each(arr, function (index, element){
			hot.alter('remove_row', element);
		});
	}
</script>
<form name="form1" id="form1">
	<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
	<input type="hidden" name="cookieName" value="${param.cookieName}"/>
	<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
	<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
</form>
</body>
</html>

<!-- progress circle -->
<div id="loader"></div>
<div id="dialog-confirm"></div>

<!-- The actual snackbar -->
<div id="snackbar"></div>