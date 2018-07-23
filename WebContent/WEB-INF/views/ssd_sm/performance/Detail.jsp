<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>	
	<title>SSD summary</title>
	<%@include file="../include/ssd_top.jsp" %>
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
	
	<script type="text/javascript" id="script_schemaSearchCondition">
		//그리드 편집전 데이타
		var beforEditRow = {};
		
		var EfContextPath = "";
		
		var schemaSearch = {
				containerId:'searchCondition',
				type:'Vertical',
				label:'',
				cls: 'srch_type01',
				elements:[
					{
						label:'',
						type: 'HorizontalLayout',
						elements:[
							{
								containerCss:[
									
								],
								label:'',
								type:'Vertical',
								elements:[
									
									
								]
							},
							//검색버튼
							{
								label:'',
								type: 'VerticalLayout',
								// cls: 'btn_txt',
								containerCss:[
									{code: 'margin-left', value:'10px'}
									, {code: 'float', value:'right'}
								]
								, elements:[
									{
										label:'',
										type: 'HorizontalLayout',
										cls: 'btn_area',
										containerCss:[
											{code: 'margin-left', value:'10px'},
											{code: 'width', value:'160px'}
										],
										elements:[

											{
												type:'Button',
												id: 'btnSearch',
												name: 'btnSearch',
												label:'Search',
												//width: '50px',
												cls: 'btn_txt btn_srch btn_color_d',
												containerCss:[
													{code: 'margin-right', value:'3px'}
												],
												events:{
													click : function(){
														fn_search();
													}
												}
											},
											{
												type:'Button',
												id: 'btnManage',
												name: 'btnManage',
												label:'Management',
												//width: '50px',
												cls: 'btn_txt btn_type_e btn_color_a',
												containerCss:[
													{code: 'margin-right', value:'3px'}
												],
												events:{
													click : function(){
														fn_management();
													}
												}
											}
										
										]
									}
											
								]
								
							}
						]
					}
				
					
				
				]
				
		};
		
		
		
	
	</script>
	<script type="text/javascript" id="script_main">
		var hot ,hotElement, hotSettings , hotEditMode,  hotGridData = [] , hotColumns = [];
		hotEditMode = false;
		$(function () {
			//$("#loader").show();
			setTimeout( function(){
				// createDB();
				// fn_makeHtml('searchCondition',schemaSearch);
				// $("button.ui-multiselect").css("padding-bottom","8px");
				// fn_set_testCase();
				//fn_makeHtml('contentMain',schemaContent);
				fn_make_table();
				
				$( window ).resize(function() {
					//console.log("aaaaa");
				});
				$("#loader").hide();
			},50);
			
			parent.$("body").css("overflow","");
			$(".btn_txt").click(btnClick);
		});
		
		function btnClick(){
			var _this = this;
			var btn = $(this).text().trim();
			if(btn == "EDIT"){
				hotEditMode = true;
				$(".btn_txt").show();
				$(this).hide();
				fn_setEdit();
				// var columns = _.cloneDeep(hotColumns);
				// var colStatus = _.find(columns,{data:'STATUS'});
				// colStatus.type = "dropdown";
				// _.merge(colStatus, {
				// 	editor : 'dropdown',
				// 	type: 'dropdown',
				// 	source: ['Success','Fail','Null','Stopped','Abort','Breakdown','Running','Skipped'] ,
				// 	readOnly: false
				// });
				// hot.updateSettings({"columns": columns});
				

			}else if(btn == "SAVE"){
				fn_save();
				
			}else if(btn == "CANCEL"){
				$(".btn_txt").hide();
				$(".btn_txt:contains('EDIT')").show();
				fn_search($("#page").val());
				// $(this).parent().hide();
				var columns = _.cloneDeep(hotColumns);
				hot.updateSettings({"columns": columns});
				hotEditMode = false;
				
			}
		}

		function fn_setEdit(){
			if (hotEditMode){
				var columns = _.cloneDeep(hotColumns);
				var colStatus = _.find(columns,{data:'STATUS'});
				var rows = hot.getData();
				$.each(rows,function(i,cur_row){
					var itemCode = cur_row[0];
					// var src_row = instance.getSourceDataAtRow(row);
					var src_row = _.find(hot.getSourceData(), {"ITEM_CODE" : itemCode });
					if(src_row.STATUS != "Blank"){
						_.merge(colStatus, {
							editor : 'dropdown',
							type: 'dropdown',
							source: ['Success','Fail','Null','Stopped','Abort','Breakdown','Running','Skipped'] ,
							readOnly: false
						});
						hot.setCellMetaObject(i,1,colStatus);
					}
				});
			}

		}		

		function fn_make_table(){
			$.each($(".tit_area").find("span:gt(0)"), function () {  
				var txt = $(this).text();
				$(this).text( _.capitalize(_.lowerCase(txt))  ); 
			});
			hotColumns = [
				// {
				// 	data: 'PJT_CODE',
				// 	type: 'text'
				// },
				
				{
					data: 'ITEM_CODE',					
					type: 'text'
				},
				{
					data: 'STATUS',					
					type: 'text',
					renderer: fn_render
				},
				{
					data: 'CATEGORY1',
					type: 'text'
				},
				{
					data: 'CATEGORY2',
					type: 'text'
				},
				{
					data: 'START_TIME',
					type: 'text'
				},
				{
					data: 'DURATION',
					type: 'text'
				},
				{
					data: 'COMMENTARY',
					type: 'text'
				},
				{
					data: 'ERROR_MESSAGE',
					type: 'text'
				},
				{
					data: 'PARAMETERS',
					type: 'text'
				}
				
			];
			$.each(hotColumns, function(){
				this.editor = false;
				this.readOnly = true;
			});
			hotSettings = {
				data: hotGridData,
				columns : _.cloneDeep(hotColumns) , 			
				columnSorting: true,
  				sortIndicator: true,
				stretchH: 'all',
				width: '100%',
				// autoWrapRow: true,
				height: 500,
				// maxRows: 22,
				manualRowResize: true,
				manualColumnResize: true,
				rowHeaders: true,
				colHeaders: _.map(_.cloneDeep(hotColumns), function(col){ 
					if ( col.label != undefined)
						return col.label;
					return _.capitalize(_.upperCase(col.data));
				}),
				manualRowMove: true,
				manualColumnMove: true,
				contextMenu: false,
				filters: true,
				dropdownMenu: true,
				afterChange: function (change, source) {
					
					if (_.includes(["loadData","edit_status"],source) )
						return;
					for(var i=0; i < change.length; i++){
						var row = change[i][0];
						var prop = change[i][1];
						
						// oldVal
						var oldVal = change[i][2];
						var cur_row = hot.getDataAtRow(row);
						var itemCode = hot.getDataAtRow(row)[0]
						var src_row = _.find(hot.getSourceData(), {"ITEM_CODE" : itemCode });
						oldVal = src_row[prop + "_origin"];
						var newVal = change[i][3];
						if(oldVal != newVal){
							hot.setDataAtRowProp(row,'edit_status','U','edit_status');
							// hot.setCellMetaObject(row,prop,{className: 'foo'});
						}else{
							hot.setDataAtRowProp(row,'edit_status','','edit_status');
						}
						
					}
				}
			};
			hotElement = document.querySelector('#excelTableList');
			hot = new Handsontable(hotElement, hotSettings);
			fn_search('1');
		}

		function fn_render(instance, td, row, col, prop, value, cellProperties){
			$(td).text(value);
			var cur_row = instance.getDataAtRow(row);
			var itemCode = cur_row[0];
			// var src_row = instance.getSourceDataAtRow(row);
			var src_row = _.find(hot.getSourceData(), {"ITEM_CODE" : itemCode })
			if(src_row == null ) 
				return;

			if(src_row.edit_status != undefined){
				if(src_row.edit_status == "U"){
					$(td).addClass("foo");
				}
			}
		}
		function fn_search(page){
			$("#page").val(page);
			$("#loader").show();
			setTimeout( function(){
				dataList = [];						
				$.ajax({
					type: "POST",
					// url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_test.summary.all.1",
					url: "/dashboard/genericlListPageJson.html?" + $("#form").serialize() + "&sqlid=dashboard.ssd_test.detail.paging&paging_sqlid=dashboard.ssd_test.detail.paging.page" ,
					//data: {searchJson: JSON.stringify(paramObj), sqlid: 'dashboard.regresson.smartlist.raw'}, 
					data: $("#form").serialize(), 
					async: false,
					success:  function(response){
						dataList  = response.rows;
						$.each(dataList,function(i,data){
							$.each(data,function(k,v){
								data[k + '_origin'] = v;
							});
						});
						hot.loadData(dataList);
						fn_setEdit();
						var currentRows = (response.page -1 ) * 20 + hot.countRows();
		   				$('#currentCnt').text(currentRows);
						$('#totalCnt').text(response.records);

						//paging
						var page_viewList = Paging(
							response.records, 
							20, 
							response.total,
							response.page, 
							"fn_search"
						); 
			    		$("#demo_page").empty().html(page_viewList);
						$("#loader").hide();
					}
				});
				
				
				
				
			},50);
		}
		function fn_save(){
			$("#loader").show();
			setTimeout( function(){
				dataList = [];
				var paramObj = {
					selectedlist : _.filter(hot.getSourceData()	,{edit_status:'U'}) ,
					loop_id : 'selectedlist'
				};
				$.ajax({
					type: "POST",
					// url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_test.summary.all.1",
					url: "/dashboard/genericSaveJson.html" ,
					//data: {searchJson: JSON.stringify(paramObj), sqlid: 'dashboard.regresson.smartlist.raw'}, 
					data: {
						searchJson: JSON.stringify(paramObj),
						sqlid: "dashboard.ssd_test.regression.detail.status.update"
					},
					async: false,
					success:  function(response){
						response1 = response;
						var update_ok;
						if(response1.result == 'success'){
							update_ok = true;
						}else {
							update_ok = false;
							$("#dialog-confirm").html(response1.message);
							$("#dialog-confirm").dialog({
								resizable: false,
								modal: true,
								title: "Success",
								//height: 200,
								width: 300,
								dialogClass: 'no-close',
								closeOnEscape: false,
								buttons: [
									{
										text: "OK",
										click: function() {
										$( this ).dialog( "close" );											                    			                  
										}
									}
								]
							});
						}
						$("#loader").hide();
						if(update_ok)
							fn_search($("#page").val());
					}
				});
				
				
				
				
			},50);
		}
		function fn_management(){
			var newwin = window.open("scriptManagement", "scriptManagement", "width=1300,height=900,screenY=20, top=20, screenX=100,left=100,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
			var oFrm = document.getElementById("form");
			//oFrm.menuAuthId.value = "MNU20150422131320740";
			//oFrm.action =  '/dashboard/generic.html?viewName=corona_manage_script';
			oFrm.action =  '/dashboard/generic.html?viewName=ssd_sm/test_master_mgmt';
			oFrm.method = "post";
			oFrm.target = 'scriptManagement'; 
			oFrm.submit();
			newwin.focus();
		}
		
		
	</script>
	
</head>


<body  style="min-width:920px" >
<form name="form" id="form" class="">
	<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
	<input type="hidden" name="cookieName" value="${param.cookieName}"/>
	<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
	<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
	
	<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
	<input type="hidden" id="search_project" name="search_project" value="${param.search_project}"/>
	<input type="hidden" id="search_project_name" name="search_project_name" value="${param.search_project_name}"/>
	<input type="hidden" id="search_prop" name="search_prop" value="${param.search_prop}"/>

	<input type="hidden" id="rows" name="rows" value="20"/>
	<input type="hidden" id="page" name="page" value="1"/>

	<div id="lay_wrap" class="lay_col2 lay_100">
		<div id="lay_contents">
			<div class="contents_wrap">
				<div id="searchCondition"></div>
				<!-- Grid Header -->
				<!-- Page Title -->
				<table class="page_tit">
					<tr>
						<td class="tit_area">
							<div class="tit"><span id="">${param.search_project}</span> - <span id="">${param.search_prop}</span> </div>
						</td>
					</tr>
				</table>
				<div class="opt_tit">
					<div class="opt_tit_left">
						<div class="elmt">
							<span class="opt_tit_bu opt_tit_bu_01"></span>
							<span class="txt">Project Summary</span>
							<span class="total" id="totalSpan">Current / Total : <b id="currentCnt"></b> / <b id="totalCnt"></b></span>
						</div>
					</div>
					<div class="opt_tit_right">
						<div class="elmt">									
							<a href="#" class="btn_txt btn_type_c btn_color_b">
								<span class="txt" style="vertical-align: text-top">EDIT</span>
							</a>
							<a href="#" class="btn_txt btn_type_c btn_color_b" style="display: none">
								<span class="txt" style="vertical-align: text-top">SAVE</span>
							</a>
							<a href="#" class="btn_txt btn_type_c btn_color_b" style="display: none">
								<span class="txt" style="vertical-align: text-top">CANCEL</span>
							</a>	
						</div>
					</div>
				</div>

				<!-- Grid -->
				<div class="board_list">
					<div id="excelTableList" style="margin-top: 10px;width: 100%;"></div>
				</div>
				<!-- //Grid -->
				<!-- Page Navigation -->
				<div style="width:100%;position:relative">
					<div class="nav_paging">
						<div class="nav_paging_wrap" id="demo_page">
						</div>
					</div>
				</div>
				<!-- //Page Navigation -->
			</div>
		</div>
	</div>

	<div id="loader"></div>
	<div id="dialog-confirm"></div>

</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
