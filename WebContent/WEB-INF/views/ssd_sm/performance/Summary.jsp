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
		var hot ,hotElement, hotSettings , hotGridData = [] , hotColumns = [];
	
		$(function () {
			//$("#loader").show();
			setTimeout( function(){
				// createDB();
				fn_makeHtml('searchCondition',schemaSearch);
				$("button.ui-multiselect").css("padding-bottom","8px");
				// fn_set_testCase();
				//fn_makeHtml('contentMain',schemaContent);
				fn_make_table();
				
				$( window ).resize(function() {
					//console.log("aaaaa");
				});
				$("#loader").hide();
			},50);
			
			parent.$("body").css("overflow","");
		});
		
		function fn_make_table(){
			hotColumns = [
				// {
				// 	data: 'PJT_CODE',
				// 	type: 'text'
				// },
				{
					data: 'PROJECT',					
					type: 'text'
				},
				{
					data: 'PROJECT_NAME',
					type: 'text'
				},
				{
					data: 'TEST_SET',
					type: 'text',
					htmlColor: 'blue' 
					// renderer: fn_render
				},
				{
					data: 'PROJECT_TOT',
					type: 'numeric',
					label: 'TOT',
					renderer: fn_render
				},				
				{
					data: 'SUCCESS',
					type: 'numeric' ,
					dropdownMenu: false ,
					htmlColor: 'blue' ,
					renderer: fn_render
				},
				{
					data: 'FAIL',
					type: 'numeric' ,
					htmlColor: 'red' ,
					renderer: fn_render
				},
				{
					data: 'NULL',
					type: 'numeric',
					label: "Null" ,
					renderer: fn_render
				},				
				{
					data: 'STOPPED',
					type: 'numeric' ,
					renderer: fn_render
				},
				{
					data: 'ABORT',
					type: 'numeric' ,
					renderer: fn_render
				},
				{
					data: 'BREAKDOWN',
					type: 'numeric' ,
					renderer: fn_render
				},
				{
					data: 'RUNNING',
					type: 'numeric' ,
					renderer: fn_render
				},
				{
					data: 'SKIPPED',
					type: 'numeric' ,
					renderer: fn_render
				},
				{
					data: 'BLANK',
					type: 'numeric',
					htmlColor: 'grey',
					renderer: fn_render
				}
			];
			$.each(hotColumns, function(){
				this.editor = false;
				this.readOnly = true;
			});
			hotSettings = {
				data: hotGridData,
				columns : hotColumns , 			
				columnSorting: true,
  				sortIndicator: true,
				stretchH: 'all',
				width: '100%',
				// autoWrapRow: true,
				height: 687,
				// maxRows: 22,
				manualRowResize: true,
				manualColumnResize: true,
				rowHeaders: true,
				colHeaders: _.map(hotColumns, function(col){ 
					if ( col.label != undefined)
						return col.label;
					return _.capitalize(_.upperCase(col.data));
				}),
				manualRowMove: true,
				manualColumnMove: true,
				contextMenu: false,
				filters: true,
				dropdownMenu: true
			};
			hotElement = document.querySelector('#excelTableList');
			hot = new Handsontable(hotElement, hotSettings);
			fn_search();
		}

		function fn_render(instance, td, row, col, prop, value, cellProperties){
			var htmlValue , htmlRatio, htmlColor ;
			if (cellProperties.__proto__.htmlColor != undefined)
				htmlColor = cellProperties.__proto__.htmlColor;
			else
				htmlColor = '';

			$(td).html("");
			$(td).css("vertical-align", "middle");	
			$(td).css("text-align", "center");					
			

			htmlValue = $(document.createElement("font"));
			htmlValue.text(value);
			htmlValue.attr("size","4");

			htmlValue.attr("color",htmlColor);
			htmlValue.attr("prop",prop);
			htmlValue.css("font-weight", "bold");	
			htmlValue.css("cursor", "pointer");
					
			$(td).append(htmlValue);
			$(td).append("<br>");

			
			var cur_row = instance.getDataAtRow(row);

			var project = cur_row[0];
			// var src_row = instance.getSourceDataAtRow(row);
			var src_row = _.find(hot.getSourceData(), {"PROJECT" : project })
			if(src_row == null ) 
				return;

			htmlValue.click(function(){
				// console.log(prop + " Clicked : " + value);
				// console.log(src_row);
				$("#search_project").val(src_row.PROJECT);
				$("#search_project_name").val(src_row.PROJECT_NAME);
				$("#search_prop").val(_.capitalize(prop));	

				fn_pop_detail();
			});		

			if( _.includes(["PROJECT_TOT","TEST_SET"],prop) )
				return ;
			htmlRatio = $(document.createElement("span"));
			htmlRatio.text("(" + ( src_row[prop +'_RATIO'] * 100 ).toFixed(1) + '%' +  ")");
			htmlRatio.css("color","black");
			htmlRatio.css("font-weight","normal");						
			$(td).append(htmlRatio);

				
			
		}

		function fn_search(){
			$("#loader").show();
			setTimeout( function(){
				dataList = [];						
				$.ajax({
					type: "POST",
					url: "/dashboard/genericlListJson.do?sqlid=dashboard.ssd_test.summary.all.1",
					//data: {searchJson: JSON.stringify(paramObj), sqlid: 'dashboard.regresson.smartlist.raw'}, 
					data: $("#form").serialize(), 
					async: false,
					success:  function(response){
						dataList  = response.dataList;
						
						hot.loadData(dataList);
						var currentRows = hot.countRows();
		   				$('#currentCnt').text(currentRows);
						totRowCnt = dataList.length== 0 ? 0 : dataList[0].TOT_CNT;
						$('#totalCnt').text(totRowCnt);
						$("#loader").hide();
					}
				});
				
				
				
				
			},50);
		}
		function fn_management(){
			var newwin = window.open("scriptManagement", "scriptManagement", "width=1300,height=1000,screenY=20, top=20, screenX=100,left=100,resizable=yes, scrollbars=yes, status=yes,menubar=yes");
			var oFrm = document.getElementById("form");
			//oFrm.menuAuthId.value = "MNU20150422131320740";
			//oFrm.action =  '/dashboard/generic.do?viewName=corona_manage_script';
			oFrm.action =  '/dashboard/generic.do?viewName=ssd_sm/test_master_mgmt';
			oFrm.method = "post";
			oFrm.target = 'scriptManagement'; 
			oFrm.submit();
			newwin.focus();
		}
		
		function negativeValueRenderer(instance, td, row, col, prop, value, cellProperties) {

		} 
	
		function fn_pop_detail(){
			var newWin1 = window.open("", "Detail_ssd_test", "width=1300,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
			var oFrm = document.getElementById("form");				
			oFrm.action =  '/dashboard/generic.do?viewName=ssd_sm/performance/Detail';
			oFrm.method = "post";
			oFrm.target = "Detail_ssd_test"; 
			oFrm.submit();		
			newWin1.focus();	
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
	<input type="hidden" id="search_project" name="search_project" value=""/>
	<input type="hidden" id="search_project_name" name="search_project_name" value=""/>
	<input type="hidden" id="search_prop" name="search_prop" value=""/>
	

	<div id="lay_wrap" class="lay_col2 lay_100">
		<div id="lay_contents">
			<div class="contents_wrap">
				<div id="searchCondition"></div>
				<!-- Grid Header -->
				<div class="opt_tit">
					<div class="opt_tit_left">
						<div class="elmt">
							<span class="opt_tit_bu opt_tit_bu_01"></span>
							<span class="txt">Project Summary</span>
							<span class="total" id="totalSpan">Current / Total : <b id="currentCnt"></b> / <b id="totalCnt"></b></span>
						</div>
					</div>
					<!-- <div class="opt_tit_right">
						<div class="elmt">									
							<a href="javascript:btnClick('editBtn');" class="btn_txt btn_type_c btn_color_b">
								<span class="txt" id="editBtn" style="vertical-align: text-top">EDIT</span>
							</a>	
						</div>
					</div> -->
				</div>

				<!-- Grid -->
				<div class="board_list">
					<div id="excelTableList" style="margin-top: 10px;width: 100%;"></div>
				</div>
			</div>
		</div>
	</div>

	<div id="loader"></div>
	<div id="dialog-confirm"></div>

</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
