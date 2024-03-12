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
                <div class="contents_wrap" style="width:560px;">
                    <!-- Page Title -->
                    <table class="page_tit">
                        <tr>
                            <td class="tit_area">
                                <div class="tit">Admin Code Management</div>
                            </td>
                        </tr>
                    </table>
                    <!-- //Page Title -->
                    <!-- Search Type01 -->
                    <div class="srch_type01" style="width:500px;">
                        <div class="condition_area">
                            <table class="condition_table" summary="검색조건 테이블">
                                <caption>검색조건 테이블</caption>
                                <tbody>
                                    <tr>
                                        <th scope="col" class="condition_t_head" style="width:100px;">Code Category</th>
                                        <td class="condition_t_data">
                                            <select class="jqForm" name="searchCode" id="searchCode" style="width:150px;" onchange="javascript:getCommCodeList();">
                                            </select>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <!-- //Search Type01 -->
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
                    <div class="tab_contents_wrap" rel="contentsTab" style="width:500px;">
                        <div class="tab_contents" id="contentsTab_01" >
                        	<!-- Sub Title -->
                            <div class="opt_tit">
                                <div class="opt_tit_right">
                                    <div class="elmt">
                                        <a href="javascript:btnClick('saveBtn');" class="btn_txt btn_type_c btn_color_b">
                                            <span class="txt" id="saveBtn" style="vertical-align: text-top">SAVE</span>
                                        </a>
                                        <a href="javascript:btnClick('closeBtn');" class="btn_txt btn_type_c btn_color_c">
                                            <span class="txt" id="closeBtn" style="vertical-align: text-top">CLOSE</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <!-- //Sub Title -->
                            <!-- Board List -->
                            <div class="board_list" style="width:100%;">
                                <!-- <div id="contentMain" style="margin-top: 10px;width: 100%;"></div> -->
                                <div id="excelTableList" style="margin-top: 10px;"></div>
                            </div>
                            <!-- //Board List -->
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
	var commCdComboList = [];
	var totRowCnt = 0;
	var page = 1;
	var rows = 100;
	var viewOption = 'latest';
	var options;
	var loginUserId;
	
	$(document).ready(function(){
		var paramObj = [];
		
		loginUserId = $('#userId').val()==''?'SYSTEM':$('#userId').val();
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.commonCodeSearch",
			data: { 
						filters: JSON.stringify({commCdType:paramObj})
					},	
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
			    var data = res.dataList;
			    
			    drawSearchArea(data);
			    
			    //Common Code 목록을 가져온다.
			    getCommCodeList();
			},
			error : function(err){
				console.log(err);
				alert("Error : " + err.statusText);
			}
			
		});
	});
	
	var selectboxSetting = function(data){
		var temp = new Array();
	    
	    for(var i = 0; i < data.length; i++){
    		temp.push(data[i].COMM_TYPE);
	    }
	    
	    commCdComboList = temp;
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
		columns: [
		{
		  	data: 'ROW_STATUS',
		    type: 'text',
		    width:50,
		    editor:false,
		    readOnly:true,
		    className:'htCenter htMiddle'
	    },
  		{
		  	data: 'COMM_CODE',
		    type: 'text',
		    editor:false,
		    readOnly:true,
	    },
	    {
	      	data: 'COMM_VALUE',
	      	type: 'text',
	      	validator: notEmpty,
		  	allowInvalid:true,
	    },
	    {
	      	data: 'COMM_SYMBOL',
	      	type: 'text',
	      	validator: notEmpty,
		  	allowInvalid:true,
	    },
	],
	  width: 450,
	  autoWrapRow: true,
	  height: 387,
	  //maxRows: 22,
	  startRows: 1,
	  startCols: 1,
	  //fixedRowsBottom: 1,
	  //minSpareRows: 1,
	  manualRowResize: true,
	  manualColumnResize: true,
	  rowHeaders: true,
	  colHeaders: [
		    'STATUS'
		  	,'CODE'
			,'VALUE'
			,'SYMBOL'
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
	  		
		  	var isDelArr = new Array();

		  	for(var i=0; i < change.length; i++){
		  		var isNull = true;
		  		var index = change[i][0];
		  		var commCode = hot.getDataAtCell(change[i][0], 'COMM_CODE');
		  		if( null != commCode ){
		  			
		  			if( change[i][2] != change[i][3] ){
				   		hot.setDataAtCell(index, 0, 'U','editStat');
				   	}	
		  		}else if( null == commCode ){
		  			
		  			if(change[i][2] == null){
	  					isNull = false;
	  				}
		  			
	  				if(!isNull){
	  					hot.setDataAtCell(index, 0, 'I','editStat');		
	  				}else{
	  					hot.setDataAtCell(index, 0, '','editStat');
	  					if(hot.isEmptyRow(index)){
	  						isDelArr.push(index);
	  						//hot.alter('remove_row', index);
	  					}	
	  				}
		  		}
		  	}
		  	//행삭제
		  	var result = removeDuplicateArr(isDelArr);
			$.each(result, function (index, element){
			    hot.alter('remove_row', element);
			});
			
		  	
		  } 
	};
	
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

	var hot = new Handsontable(hotElement, hotSettings);
	var hotGridData;
	
	/**
	* 해당 Common Code 리스트를 가지고 온다.
	*/
	var getCommCodeList = function(){
		
		$.ajax({		//loads data to Handsontable
			type: "POST",
			url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_sm.commonCodeList",
			data:{ 
						filters: JSON.stringify({
													searchCode:$('#searchCode').val() == null ? []:new Array($('#searchCode').val()),
													}),
					},
			dataType: 'json',
			success: function(res){
			    //$("#excelTableList").handsontable("loadData", JSON.parse(res.dataList));
		    	hotGridData = res.dataList;
			    hot.loadData(hotGridData);
			    
				// Context 메뉴 셋팅
			    gridUpdateSetting(getEditableParam());
			},
			error : function(err){
				console.log(err);
				alert("Error2 : " + err.statusText);
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
	
	/**버튼 Toggle*/
	var btnSetting = function(btn){
		if( btn == 'saveBtn' ){
			excelGridAllSave();	//save 완료가 되었다면, 화면의 btn toggle
			
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
							},
							"row_below" : {},
							"hsep1": "---------",
							"undo" : {},
							"redo" : {},
							"hsep2": "---------",
							/* "remove_row" : {
								callback:function(key,options){
									var arr = hot.getSelected();
									console.log(arr);
									
						            for(var i=arr[0][0]; i <= arr[0][2]; i++){
						            	console.log(hot.isEmptyRow(i));
						            	console.log(i);
						            	if(hot.isEmptyRow(i)){
						            		hot.alter('remove_row', i);
						            	}else{
						            		continue;
						            	}
						            }
								},
							}, */
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
						    width:50,
						    editor:false,
						    readOnly:true,
					    },
				  		{
						  	data: 'COMM_CODE',
						    type: 'text',
						    editor:false,
						    readOnly:true,
					    },
					    {
					      	data: 'COMM_VALUE',
					      	type: 'text',
					      	validator: notEmpty,
						  	allowInvalid:true,
					    },
					    {
					      	data: 'COMM_SYMBOL',
					      	type: 'text',
					    },
					 ],
			}
		return updateParam;		
	}
	
	
	/**
	* validate Cell(자동저장시 사용)
	*/
	/* var checkValidate = function(change){
		var $container = $("#excelTableList");
	  	var $parent = $container.parent();
	  	var autosaveNotification;
	  	var paramObj = new Array();
	  	
		hot.validateCells(function(isPass){
			
			if(isPass){
				for(var i=0; i < change.length; i++){
			  		change[i].push(change[i][1]+'_n');
			  		var tempObj = new Object();
			  		tempObj.index = change[i][0];
			  		tempObj.colum = change[i][1];
			  		tempObj.oriVal = change[i][2];
			  		tempObj.newVal = change[i][3];
			  		tempObj.commType = $('#searchCode').val();
			  		
			  		if( hot.getDataAtCell(change[i][0], 'COMM_CODE') != '' & hot.getDataAtCell(change[i][0], 'COMM_CODE') != null ){
			  			tempObj.commValue = '';
			  			tempObj.commSymbol = ''; 
			  			tempObj.commCode = hot.getDataAtCell(change[i][0], 'COMM_CODE');
			  			paramObj.push(tempObj);
			  		}else if( hot.getDataAtCell(change[i][0], 'COMM_VALUE') != '' & hot.getDataAtCell(change[i][0], 'COMM_VALUE') != null ){
			  			tempObj.commCode = 'Insert';
			  			tempObj.commValue = nvl(hot.getDataAtCell(change[i][0], 'COMM_VALUE'),'');
			  			tempObj.commSymbol = nvl(hot.getDataAtCell(change[i][0], 'COMM_SYMBOL'),'');
			  			paramObj.push(tempObj);
			  		}
			  	}
			  	
			  	clearTimeout(autosaveNotification);
			  	
			  	//COMM_CODE 가 없는 로우는 실시간 수정에서 제외
			  	if(paramObj.length == 0){
			  		return;
			  	}

			  	$.ajax({
		       			url: "/dashboard/genericAutoSaveJson.do?sqlid=dashboard.ssd_sm.commonCodeSave",
		        		dataType: "json",
		        		type: "POST",
				        data: {
				        	autoJson: JSON.stringify(paramObj)
	               		}, 
		        		success: function (data) {
		          			alert('Autosaved (' + change.length + ' cell' + (change.length > 1 ? 's' : '') + ')');
		          			autosaveNotification = setTimeout(function () {
		            		console.log('Changes will be autosaved');
		          			}, 1000);
		          			
		          			getCommCodeList();
		        		},
		        		error: function (err) {
		                    alert('Error: ' + err.statusText);
		                }
		      	});
			}else{
				alert("Please fill in the required fields");
				return false;
			}
		});
	} */
	
	/**
	* 그리드 모든 데이터 저장
	*/
	var excelGridAllSave = function(){
		//그리드내 변경이 없을때
		if( hot.isEmptyCol(0) ){
			alert("There are no changes.");
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
							tempObj.commCode 		= nvl(data[i][1],'');
							tempObj.commValue 		= nvl(data[i][2],'');
							tempObj.commSymbol	= nvl(data[i][3],'');
							tempObj.commType 		= $('#searchCode').val();
							tempObj.crtBy				= loginUserId;
							tempObj.modBy			= loginUserId;
							paramObj.push(tempObj);
						}
					}
					
					$.ajax({
		       			url: "/dashboard/genericAllSaveJson.do?sqlid=dashboard.ssd_sm.commCdGridSave",
		        		dataType: "json",
		        		type: "POST",
		        		async : true,
				        data: {
				        	autoJson: JSON.stringify(paramObj)
		           		}, 
		        		success: function (data) {
		        			alert("You have saved "+data.resultCnt+" cases in total.");

		        			getCommCodeList();
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
	 
</script>
<form name="form1" id="form1">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>

</form>
</body>
</html>
