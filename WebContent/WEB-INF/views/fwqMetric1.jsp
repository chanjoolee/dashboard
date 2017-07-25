<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<title>SSD Custom Pop</title>
	<!-- <link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css" /> -->
	
	
	<%-- 1. jquery --%>
    <!-- <script src="js/jquery/jquery-1.11.2.js"></script> -->
    <!-- <script src="js/jquery/jquery.form.js"></script> -->
    <!-- <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script> -->
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    
    <%-- 2. high charts --%>
    
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<!-- <script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script> -->
	
	<%-- jqgrid --%>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css"> 
	<!-- <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script> -->
	<%-- datetimepicker --%>
	<script src="/dashboard/js/datetimepicker-master/build/jquery.datetimepicker.full.min.js"></script>
	<link rel="stylesheet" href="/dashboard/js/datetimepicker-master/jquery.datetimepicker.css"> 
	
	
	<%-- http://swebdeveloper.com/apps/forms-plus-css/popup-form-comment.html --%>
	<!--  <link rel="stylesheet" href="/dashboard/css/bootstrap/font-awesome.min.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/modern-forms-plus.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/purple.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/cadetBlue.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/orange.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color4.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/steelBlue.css"> -->
  
	<!--  <link rel="stylesheet" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid.css" type="text/css" /> --> 
	<link rel="stylesheet" media="screen" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap.css" type="text/css" />
	<!-- <link rel="stylesheet" media="screen"  href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap-ui.css" type="text/css" /> -->
	<%--// jqgrid --%>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<!-- <script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script> -->
	
	<%-- x축 그룹라벨 --%>
	<!-- <script src="js/highcharts/grouped-categories.js"></script> -->
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<!-- <script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script> -->
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. local --%>
	<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
	
	
	<%-- multi select --%>
	<!-- <script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" /> -->
	
	<!-- <link rel="stylesheet" type="text/css" href="/dashboard/css/stylesheet-image-based.css" /> -->
	
	<!-- <script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script> -->
	<link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css">
	<style>
		html, body,form {
			padding: 0;
	        margin: 0;
	        font-size:11px;
	    }
	    
	    
		.wrap_a{width:100%; overflow:hidden}
		.wrap_b{width:100%; overflow:hidden}
		.wrap_b_1{width:49%; height:auto ;overflow:hidden; float:left; margin-top:30px}
		.wrap_b_2{width:49%; height:auto ;overflow:hidden; float:right; margin-top:30px}
		
		<%--.box_gray{background:#f5f6fa; border:1px solid #e1e2e6; padding:15px; text-align:center; margin-bottom:8px } --%>
		.dashboard_box{/* border:1px solid #e1e2e6;  */}
		
		iframe {
			   border: none;
			   frameborder:0;
			   
			   width: 100%;
			   height: 100%;
		}
		
		.radioDiv div{
			display:inline;
		}
		
		
		
		/***  jqgrid Header   ***/
		.ui-jqgrid-hdiv th {
			text-align: center;
		}
		
		.h1, .h2, .h3, .h4, .h5, .h6, h1, h2, h3, h4, h5, h6 {
		    font-weight: bold;
		    margin-bottom: 0px; */
		}
		
		
		
		.border_boxAll{
			border-color: #c0c0c0;
			border-style: solid;
			border-width: 1px;
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
		
		<%--  jqGrid에서 dialog가 뒤로 숨는 문제.--%>
		.ui-dialog { z-index: 1000 !important ;}
		
	</style>
	<style type="text/css" title="nspmstyle">
		
		
		.pop_window .pop_tit_wrap {
		    position: relative;
		    height: 50px;
		    padding: 0 15px 0 20px;
		    background-color: #2e3441;
		}
		
		.pop_window .pop_con_area {
		    padding: 20px 30px;
		    overflow: auto;
		    background-color: #ffffff;
		}
		
		.pop_window .pop_tit {
		    font-size: 18px;
		    font-weight: bold;
		    color: #ffffff;
		    line-height: 1.33em;
		    display: inline-block;
		    vertical-align: middle;
		}
	
		.cont_tit{font-size:15px; display:block; color:#000; text-align:left; padding-bottom:12px; position:relative; background:url(/nspim/images/board/bullet.gif) no-repeat left 1px; padding-left:18px}
		.cont_tit {float:none}
		
		<%--  table style--%>
		.table_hori {
		    width: 100%;
		    table-layout: fixed;
		    border-collapse: collapse;
		    border-top: 1px solid #fc5d57;
		    border-left: 1px solid #e1e2e6;
		    border-right: 1px solid #e1e2e6;
		}
		
		.table_hori th {
		    background: rgba(245,246,250,0.6);
		    color: #000;
		    /* background: #f5f6fa; */
		    height: 20px;
		    padding: 5px 10px;
		    overflow: hidden;
		    border: 1px solid #e1e2e6;
		    font-weight: normal;
		}
		
		.table_hori td {
		    height: 20px;
		    padding: 5px 10px;
		    border: 1px solid #e1e2e6;
		    word-wrap: break-word;
		    table-layout: fixed;
		    line-height: 160%;
		    color: #000;
		}
		.cont_tit {
		    padding-bottom: 3px;
		}
		
		.txt_right {
		    text-align: right;
		}
		<%--//  table style--%>
	
	</style>
<script title="schema">
// 	$.jgrid.defaults.width = 780;
// 	$.jgrid.defaults.responsive = true;
// 	$.jgrid.defaults.styleUI = 'Bootstrap';
	
	var testInformation = {};
	var testDisks = [];
	var testResults = [];
	var testFiles = [];

	var schema = {
			containerId:'contents',
			type:'Vertical',
			elements:[
				{
					label:'Test Result',
					type: 'Group',
					elements:[
						{
							type:'chart',
							id: 'chart',
							label:'Customer',
							width: '100%',
							data: function(){
								return getChartData();
							},
							options: function(){
								return getOptionCustomer();
							}
						},
					    {
					    	type:'grid',
					    	id: 'grid',
					    	label:'',
					    	//data: function(){ 
					    	//	return testResults;
					    	//},
					    	items:[
								{label:'TEST_ID', name:'TEST_ID', sortable: false , hidden:true, editable: true
									, editrules:{edithidden:false}
									, edittype:'custom' 
										, editoptions: {
									        //enctype: "multipart/form-data"
									        custom_element:function(value,options){
									        	var el = document.createElement("input");
									        	el.type="hidden";
									        	el.value = "${param.testId}";
									        	return el;
									        }
									        , custom_value: function(elem, operation, value){
									        	if(operation === 'get') {
								        	       return $(elem).val();
								        	    } else if(operation === 'set') {
								        	       $('input',elem).val("${param.testId}");
								        	    }
									        }
									    }
								},   
								{label:'DISPLAY_ORDER', name:'DISPLAY_ORDER',width:90, sortable: false, editable: false, hidden:true},
								{label:'Tool Name', name:'TOOL_NAME',width:90, sortable: false, editable: true
									, editrules:{required: true}
								},
								{label:'Tool Version', name:'TOOL_VERSION',width:90, sortable: false , editable: true},
								{label:'Script Name', name:'SCRIPT_NAME',width:110, sortable: false , editable: true},
								{label:'Start Time', name:'START_TIME',width:120, sortable: false , editable: true
									, edittype: 'text'
									// , formatter: 'date'
									// , editrules:{date: false, time: true}
									// , formatoptions: {
									//     srcformat: 'ISO8601Long',
									//     //newformat: 'm/d/Y',
									//     newformat: 'Y-m-d',
									//     defaultValue:null
									// }
									, editoptions: {
							              size: 12,
							              maxlengh: 12,
							              dataInit: function (element) {
							                  //$(element).datepicker({ dateFormat: 'yy-mm-dd', timepicker: true });
							            	  $(element).datetimepicker({ 
							            		  //formatDate: 'Y-m-d'
							            		  //, formatTime:'H:i'
							            		  format : 'Y-m-d H:i:s'
							            		  //format : 'H:i:s'
							            		  //, datepicker: false
							            		  , timepicker: true 
							            		  , step: 15
							            		  //, useSeconds: true //default true
							            		});
							              }
							          }
								},
								{label:'Elapsed Time', name:'ELAPSED_TIME',width:120, sortable: false , editable: true
									, edittype: 'text'
									// , formatter: 'date'
									// , editrules:{date: false, time: true}
									// , formatoptions: {
									//     srcformat: 'ISO8601Long',
									//     //newformat: 'm/d/Y',
									//     newformat: 'Y-m-d',
									//     defaultValue:null
									// }
									, editoptions: {
							              size: 12,
							              maxlengh: 12,
							              dataInit: function (element) {
							                  //$(element).datepicker({ dateFormat: 'yy-mm-dd', timepicker: true });
							            	  $(element).datetimepicker({ 
							            		  //formatDate: 'Y-m-d'
							            		  //, formatTime:'H:i'
							            		  format : 'Y-m-d H:i:s'
							            		  //format : 'H:i:s'
							            		  //, datepicker: false
							            		  , timepicker: true 
							            		  , step: 15
							            		  //, useSeconds: true //default true
							            		});
							              }
							          }
								},
								{label:'Total Time', name:'TOTAL_TIME',width:100, sortable: false , editable: true},
								{label:'Elapsed Cycle', name:'ELAPSED_CYCLE',width:110, sortable: false , editable: true},
								{label:'Total Cycle', name:'TOTAL_CYCLE',width:110, sortable: false , editable: true},
								{label:'Test Status', name:'TEST_STATUS',width:110, sortable: false, editable: true},
								{label:'Test Log', name:'TEST_LOG',width:110, sortable: false
									, editable: true
									, edittype:'custom' 
									, editoptions: {
								        //enctype: "multipart/form-data"
								        custom_element:function(value,options){
								        	var el = document.createElement("input");
								        	el.type="file";
								        	el.value = '';
								        	return el;
								        }
								        , custom_value: function(elem, operation, value){
								        	if(operation === 'get') {
							        	       return $(elem).val();
							        	    } else if(operation === 'set') {
							        	       $('input',elem).val(value);
							        	    }
								        }
								    }
									, cellattr: function(rowId, val, rowObj, cm, rowData) {
										var result = '';
										if(rowObj.TEST_LOG != undefined && rowObj.TEST_LOG != "")
											result = ' style="cursor:pointer;"';
										return result;
									}
								},
								{label:'Test Log Path', name:'FILE_PATH',sortable: false, hidden:true},
								{label:'JiraOrigin', name:'JIRA_ORIGIN',sortable: false, hidden:true},
								{label:'ConfluenceOrigin', name:'CONFLUENCE_ORIGIN',sortable: false, hidden:true},
								{label:'Jira', name:'JIRA',sortable: false, hidden:false, width:35, align: 'center'
									, editable: true
									, edittype:'custom' 
									, editoptions: {
								        //enctype: "multipart/form-data"
										custom_element:function(value,options){
								        	var el = document.createElement("input");
								        	el.type="text";
								        	var data = $(this).jqGrid('getRowData',options.rowId);
								        	el.value = data[options.name + '_ORIGIN'];
								        	//el.value = '';
								        	return el;
								        }
								        , custom_value: function(elem, operation, value){
								        	if(operation === 'get') {
							        	       return $(elem).val();
							        	       //return $(value).attr("alt");
							        	    } else if(operation === 'set') {
							        	       //$('input',elem).val(value);
							        	       elem.val($(value).attr("alt"));
							        	    }
								        }
								    }
									, formatter: function (cellval,opts,rwdat,_act) {
										if(rwdat.JIRA_ORIGIN != undefined && rwdat.JIRA_ORIGIN != ""){
											var alt = rwdat.JIRA_ORIGIN;
							                return "<a style='cursor:pointer' ><img src='/dashboard/images/link-2.png' style='height:12px;' title='"+alt+"'/></a>";
										}else{
											return "";
										}
										
						            }
									//, unformat: function (cellval,opts,rwdat,_act) {
									//	return cellval;
									//	
						            //}
									, cellattr: function(rowId, val, rowObj, cm, rowData) {
										var result = '';
										if(rowObj.JIRA != undefined && rowObj.JIRA != "")
											result = ' style="cursor:pointer;"';
										return result;
									}
								},
								{label:'Confluence', name:'CONFLUENCE',sortable: false, hidden:false, width:75, align: 'center'
									, editable: true
									, edittype:'custom' 
									, editoptions: {
								        //enctype: "multipart/form-data"
										custom_element:function(value,options){
								        	var el = document.createElement("input");
								        	el.type="text";
								        	var data = $(this).jqGrid('getRowData',options.rowId);
								        	el.value = data[options.name + '_ORIGIN'];
								        	//el.value= '';
								        	return el;
								        }
								        , custom_value: function(elem, operation, value){
								        	if(operation === 'get') {
							        	       return $(elem).val();
							        	       //return $(value).attr("alt");
							        	    } else if(operation === 'set') {
							        	       //$('input',elem).val(value);
							        	       elem.val($(value).attr("alt"));
							        	    }
								        }
								    }
									, formatter: function (cellval,opts,rwdat,_act) {
										if(rwdat.CONFLUENCE_ORIGIN != undefined && rwdat.CONFLUENCE_ORIGIN != ""){
											var alt = rwdat.CONFLUENCE_ORIGIN;
							                return "<a style='cursor:pointer' ><img src='/dashboard/images/link-2.png' style='height:12px;' title='"+alt+"'/></a>";
										}else{
											return "";
										}
						            }
									, cellattr: function(rowId, val, rowObj, cm, rowData) {
										var result = '';
										//if(rowObj.CONFLUENCE != undefined && rowObj.CONFLUENCE != "")
										//	result = ' style="cursor:pointer;"';
										return result;
									}
								}
					    	],
					    	gridOpt:{
					    		datatype:'json',
					    		pager: "#testResultsPager",
					    		viewrecords: true,
					    		url: '/dashboard/ssdCustomResultJson.html?testId=${param.testId}',
					    		editurl: '/dashboard/ssdCusDummySaveJson.html',
					    		//closeAfterEdit: true,
					    		width: '100%',
					    		//height: 600,
					    		height: '100%',
					    		onCellSelect: function (rowId, iCol, content, event) {
					    			var test = "";
							    	//var grid = $("#attachments");
							    	var grid = $(this).jqGrid();
							    	var row = grid.jqGrid('getRowData',rowId);
							    	var cms = grid.jqGrid("getGridParam", "colModel");
									var cm = cms[iCol];
									
									var oFrm = document.getElementById("form1");
									
									
									if(cm.name  == 'TEST_LOG'){
										var path = '/dashboard'+row.FILE_PATH;
										if((/\.(txt|config|pdf|jpg|jpeg|gif|png|log)$/i).test(row.TEST_LOG)){
											var newWin1 = window.open("", "filedownload", "width=1200,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
											
											oFrm.action =  path;
											oFrm.method = "post";
											oFrm.target = 'filedownload'; 
										    oFrm.submit();		
										    newWin1.focus();	
										}else if(row.TEST_LOG.match(/\.([\w]+)$/i) != null){
											//var src = "/dashboard/filedownloadJson.html";
											//src += "?filename=" + row.TEST_LOG;
											//src +="&path=" + row.FILE_PATH;
											
											var isIE = /*@cc_on!@*/false || !!document.documentMode; // At least IE6
											if (isIE){
												var fileData = ['\ufeff' + "${pageContext.request.contextPath}" + row.FILE_PATH];
									            var blobObject = new Blob(fileData);
									            window.navigator.msSaveOrOpenBlob(blobObject, row.FILE_NAME);

											}else{
												var link = document.createElement('a');
												link.download = row.FILE_NAME;
												link.href = "${pageContext.request.contextPath}" + row.FILE_PATH;
												//Firefox requires the link to be in the body
												document.body.appendChild(link);
												link.click();
												document.body.removeChild(link);
											}
											
											//document.getElementById('file_iframe').src =  src;
											/* var newWin1 = window.open("", "filedownload", "width=1200,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
											
											oFrm.action =  path;
											oFrm.method = "post";
											oFrm.target = 'filedownload'; 
										    oFrm.submit();		
										    newWin1.focus();	 */
										}
									}
									
									if(cm.name  == 'JIRA' || cm.name  == 'CONFLUENCE'){
										if(row[cm.name] == undefined || row[cm.name] == "")
											return;
										//var orgRow = dataFilter(testResults,[{col:'DISPLAY_ORDER',val:row.DISPLAY_ORDER}])[0];
										//if(orgRow == undefined)
										//	return;										
										//var path = orgRow[cm.name];
										
										var path = row[cm.name + '_ORIGIN'];
										if(path != undefined && path != ""){
											var link = document.createElement('a');
											link.target = "_blank";
											link.href = path;
											//Firefox requires the link to be in the body
											document.body.appendChild(link);
											link.click();
											document.body.removeChild(link);
										}
																					
									}
									
							    },
							    loadComplete: function(){
							    	$(window).scroll(function() {
							    		$('#alertmod_testResults').center();
							    	});
							    	
							    },
							    gridComplete: function () {
							    	var grid = $(this).jqGrid();
							    	grid.navGrid('#testResultsPager' ,
						                // the buttons to appear on the toolbar of the grid
						                { edit: true, add: true, del: true, search: false, refresh: false, view: false, position: "left", cloneToTop: false  },
						                // options for the Edit Dialog
						                {
						                    editCaption: "The Edit Dialog",
						                    modal: true,
						                    recreateForm: true,
						                    //closeAfterEdit: true,
						                    reloadAfterSubmit: false,
											//template: template,
						                    errorTextFormat: function (data) {
						                        return 'Error: ' + data.responseText
						                    },
						                    onInitializeForm : function(formid){
						                        $(formid).attr('method','POST');
						                        $(formid).attr('action','');
						                        $(formid).attr('enctype','multipart/form-data');
						                        
						                        $(formid).css("font-size","14px");
						                        //$(this).css("font-size","14px");
						                        
						                        
						                    },
										    afterSubmit: function(response, postdata) 
										    { 
										    	var row = $(this).jqGrid('getRowData',postdata.id);
										    	var formdata = this.ownerDocument.FormPost;
										    	//전체데이타를 json형태로
										    	var origindata = $(document.createElement("input"));
										    	origindata.attr("type","hidden");
										    	origindata.attr("name","origindata");
										    	origindata.val(JSON.stringify(row));
										    	$(formdata).append(origindata);
										    	
										    	//var modal = $(document.createElement("div"));
						                        //modal.attr("id","testResults_dialog");
						                        //modal.hide();
						                        //$(formdata).append(modal);
										    	
						                    	var fd = new FormData(formdata);  	
						                    	var response1 = {};
						                    	$.ajax({
						                    		url: "/dashboard/rest/ssdinsert/result/edit",
						                    		type: "POST",
						                    		data: fd, 
						                    		async: false,
						                    		cache: false,
						                    		contentType: false,
						                    		processData: false,
						                    		success:  function(data){
						                    			response1 = data;
						                    			if(response1.result == 'success'){
						                    				msg = "Save Success!";
							                    			$("#dialog-confirm").html(msg);
							                    			$("#dialog-confirm").dialog({
							                    			    resizable: false,
							                    			    modal: true,
							                    			    title: "Success",
							                    			    //height: 200,
							                    			    width: 200
							                    			  });
						                    			}						                    			
						                    		}
						                    	});
						                    	
										    	//return [success,message,new_id] ;
										    	if(response1.result == 'success'){
										    		if(response1.files != undefined){
										    			postdata.FILE_PATH = response1.files[0].filePath;
										    			postdata.TEST_LOG = response1.files[0].orgFileName;
										    		}else{
										    			postdata.TEST_LOG = row.TEST_LOG;
										    			postdata.FILE_PATH = row.FILE_PATH;
										    		}
										    		
										    		postdata.JIRA_ORIGIN = postdata.JIRA;
										    		postdata.CONFLUENCE_ORIGIN = postdata.CONFLUENCE;
										    		
										    		return [true, response1.result, ''];
										    	}
										    	else
										    		return [false, response1.result, ''];
										    		
										    }
						                },
						                // options for the Add Dialog
						                {
						                	modal:true,
						                    recreateForm: true,
						                    closeAfterAdd: true,
						                    reloadAfterSubmit: true,
											//template: template,
						                    errorTextFormat: function (data) {
						                        return 'Error: ' + data.responseText
						                    },
						                    onInitializeForm : function(formid){
						                        $(formid).attr('method','POST');
						                        $(formid).attr('action','');
						                        $(formid).attr('enctype','multipart/form-data');
						                        $(formid).css("font-size","14px");
						                    },
										    afterSubmit: function(response, postdata) 
										    { 
										    	var formdata = this.ownerDocument.FormPost;
						                    	var fd = new FormData(formdata);  	
						                    	var response1 = {};
						                    	$.ajax({
						                    		url: "/dashboard/rest/ssdinsert/result/add",
						                    		type: "POST",
						                    		data: fd, 
						                    		async: false,
						                    		cache: false,
						                    		contentType: false,
						                    		processData: false,
						                    		success:  function(data){
						                    			response1 = data;
						                    			if(response1.result == 'success'){
						                    				msg = "Add Success!";
							                    			$("#dialog-confirm").html(msg);
							                    			$("#dialog-confirm").dialog({
							                    			    resizable: false,
							                    			    modal: true,
							                    			    title: "Success",
							                    			    //height: 200,
							                    			    width: 200
							                    			  });
						                    			}
						                    			
						                    		}
						                    	});
						                    	
						                    	//return [success,message,new_id] ;
										    	if(response1.result == 'success'){
										    		if(response1.files != undefined){
										    			postdata.FILE_PATH = response1.files[0].filePath;
										    			postdata.TEST_LOG = response1.files[0].orgFileName;
										    		}else{
										    			
										    		}
										    		
										    		postdata.JIRA_ORIGIN = postdata.JIRA;
										    		postdata.CONFLUENCE_ORIGIN = postdata.CONFLUENCE;
										    		
										    		return [true, response1.result, ''];
										    	}
										    	else
										    		return [false, response1.result, ''];
										    		
										    }
						                },
						                // options for the Delete Dailog
						                {
						                	delData:{testId:"${param.testId}"},
						                	beforeShowForm : function(formid){
						                        $(formid).attr('method','POST');
						                        $(formid).attr('action','');
						                        $(formid).attr('enctype','multipart/form-data');
						                        $(formid).css("font-size","14px");
						       
						                    },
						                    errorTextFormat: function (data) {
						                        return 'Error: ' + data.responseText
						                    },
						                    afterSubmit: function(response, postdata) 
										    { 
						                    	var response1 = {};
						                    	var row = $(this).jqGrid('getRowData',postdata.id);					                    	
						                    	$.ajax({
						                    		url: "/dashboard/rest/ssdinsert/result/delete",
						                    		type: "POST",
						                    		data: JSON.stringify(row), 
						                    		async: false,
						                    		//cache: false,
						                    		contentType: "application/json",
						                    		//processData: false,
						                    		success:  function(data){
						                    			response1 = data;
						                    			if(response1.result == 'success'){
						                    				msg = "Delete Success!";
							                    			$("#dialog-confirm").html(msg);
							                    			$("#dialog-confirm").dialog({
							                    			    resizable: false,
							                    			    modal: true,
							                    			    title: "Success",
							                    			    //height: 200,
							                    			    width: 200
							                    			  });
						                    			}
						                    			
						                    		}
						                    	});
						                    	
						                    	//return [success,message,new_id] ;
										    	if(response1.result == 'success'){
										    		return [true, response1.result, ''];
										    	}
										    	else
										    		return [false, response1.result, ''];
										    		
										    }
						                }
						            );
							    	
							    	$('#testResultsPager .ui-paging-pager').hide();
							    	
					 				$('#testResultsContainer .ui-jqgrid').css("width",'100%');
					 				$('#testResultsContainer .ui-jqgrid-view').css("width",'100%');
					 				$('#testResultsContainer .ui-jqgrid-hdiv').css("width",'100%');
					 				$('#testResultsContainer .ui-jqgrid-bdiv').css("width",'100%');
					 				$('#testResultsContainer .ui-jqgrid-pager').css("width",'100%');
					 				
					 				
							    		
							    }
					    	}
					    }
						
					]
				}
			]
	};
	
	function makeHtml(container, _schema){
		var containerSub = null;
		if(container == null)
			container = _schema.containerId;
		if(typeof container == 'string')
			container = $("#" + container);
		
		var makeInline = function(container,el){
			var cols = 3;
			if(_schema.cols != undefined)
				cols = _schema.cols;
			
			//tableCreate
			var table = $(document.createElement("table"));
			//table.addClass("table_hori m_bottom_20");
			table.addClass("table_hori");
			container.append(table);
			
			// colgroup
			var colgroup = $(document.createElement("colgroup"));
			table.append(colgroup);
			
			for(var i=0; i< cols;i++){
				if(i == (cols - 1) ){
					colgroup.append("<col width=\"150\"/><col width=\"\"/>");
				}else{
					colgroup.append("<col width=\"150\"/><col width=\"180\"/>");
				}
			}
			// -- colgroup
			
			// tbody
			var tbody = $(document.createElement("tbody"));
			table.append(tbody); 
			var tr = null;
			$.each(el.items,function(i,item){
				if(i%cols == 0 ){
					tr =$(document.createElement("tr"));
					tbody.append(tr);
				}
				//header
				var th = $(document.createElement("th"));
				th.addClass("txt_right");
				th.text(item.label);
				//td value
				var td = $(document.createElement("td"));
				td.addClass("hori_t_data");
				td.text(el.data()[item.col]);
				
				tr.append(th);
				tr.append(td);
				
			});
			// --tbody
		};
		
		var makeGrid = function(container,el){
			//==grid create
			var gridContainer = $(document.createElement( "div" ));
			gridContainer.attr("id",el.id + 'Container');
			
			var containerType = container.attr("type");
			if(containerType == 'HorizontalLayout'){
				gridContainer.css("display","inline-block");
				if(container.children().length > 0)
					gridContainer.css("margin-left","10px");
			}
				
			container.append(gridContainer);
			//gridContainer.css("width","100%");
			//grid.addClass("chartContainerSub");
			
			
			//==table create
			var table = $(document.createElement( "table" ));
			table.attr("id",el.id);
			//table.css("width","100%");
			gridContainer.append(table);
			
			//== page create
			var pager = $(document.createElement( "div" ));
			pager.attr("id",el.id + 'Pager');
			gridContainer.append(pager);
			
			//== common option
			var opt = {
					datatype: 'local',
					styleUI : 'Bootstrap',
					colModel: el.items,
					//rowNum:10,
					rownumbers: true, // show row numbers
					caption: el.label,
					//width: '100%',
					//height: '100%',
					iconSet: "fontAwesome",
					sortable: false,
					//viewrecords: true,
					//pager : pager, 
					//data : el.data() 
			};
			if(el.data != undefined && typeof el.data == 'function')
				opt.data = el.data();
			
			if(el.gridOpt != undefined){
				$.extend(opt, el.gridOpt);
			}
			
			table.jqGrid(opt);
		};
		
		
		// data process
		if(_schema.label != undefined){
			var h3 = $(document.createElement("h3"));
			h3.addClass("cont_tit");
			h3.text(_schema.label);
			container.append(h3);
			
			containerSub = $(document.createElement("div"));
			//상위 container type을 줘서 알아서 판단 할 수 있도록 한다.
			containerSub.attr("type", _schema.type);
			container.append(containerSub);
		}
		
		$.each(_schema.elements, function(i,el){
			if(el.type == 'inline'){
				makeInline(containerSub, el);
			}else if(el.type == 'grid'){
				makeGrid(containerSub , el );
			}else if(el.elements != undefined){
				
				makeHtml(container, el);
			}
		});
	}
	
	
	function getChartData(){
		var param = openerForm;
		param += "&groupbyCol=CUSTOMER";
		
		var dataList = [];
		var rtn = {};
		
		$.ajax({
			url : "/dashboard/fwqMetricJson.html",
			data: $("#form").serialize() ,
			async: false,
			success : function(pResponseData){
				dataList = response.dataList;
    			rtn.dataList = dataList;
				
			}
		});
		
		var groupKeys = ['GUBUN','PJT_NAME'];
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[], //filter
				[{col:'POINT',convert:'y',isnull:0}], //convert
				'PJT_NAME', 
				'POINT',
				{cd: 'GUBUN', name:'GUBUN'},
				//{isGroupby:false,xSortColumn: 'PJT_NAME' 	}
				{isGroupby:false,xSortColumn: 'PJT_NAME' 	}
		);
		// category start
		series.categoryOrigin = series.category;
		series.category = [];
		$.each(series.series[0].data,function(i,d){
			var colvalues = [];
			$.each(['CUSTOMER'],function(){
				colvalues.push(d[this]);
			});
			series.category.push(colvalues);
		});
		
		var category1 = [];
		$.each(series.category,function(index,c){
			category1.push(c);
		});	    	            		
		var category2 = makeGroupCategory(category1);
		series.category = category2;
		
		var xAxis = {
			categories: series.category,
			labels:{
        		groupedOptions:[{
        			rotation: 0
        		},{
        			rotation: 0
        		}],
        		rotation:0,
        		//formatter: function() {
				//	
        		//}
        	}
		};
		rtn.xAxis = xAxis;
		// category end
		
		// return start
		rtn.series = series;
		
		
		
		return rtn;
		// return end
	}
	
	
</script>
<script title="ui-schema">
	
	
	
</script>
<script type="text/javascript">
	// form의 데이타를 object화 한다.
	$.fn.serializeObject = function()
	{
	    var o = {};
	    var a = this.serializeArray();
	    $.each(a, function() {
	        if (o[this.name] !== undefined) {
	            if (!o[this.name].push) {
	                o[this.name] = [o[this.name]];
	            }
	            o[this.name].push(this.value || '');
	        } else {
	            o[this.name] = this.value || '';
	        }
	    });
	    return o;
	};

	//var spiderData = {};
	$(function () {
		getDataByJson();
		$( window ).unload(function() {
			
		});
		
	});
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/ssdCusPopJson.html",
			data: $("#form1").serialize(),
			async: false,
			success : function(responseData){
				testInformation = responseData.testInformation;
				testDisks = responseData.testDisks;
				testResults = responseData.testResults;
				testFiles = responseData.testFiles;
				
				makeHtml('contents', schema);
			    	
// 				$('.ui-jqgrid').css("width",'100%');
// 				$('.ui-jqgrid-view').css("width",'100%');
// 				$('.ui-jqgrid-hdiv').css("width",'100%');
// 				$('.ui-jqgrid-bdiv').css("width",'100%');
// 				$('.ui-jqgrid-pager').css("width",'100%');
			}
		});
	}
	
	
	
	function fn_close(){
		window.close();
	}	
</script>
<script comment="divPop">

(function($) {
    $.fn.popupWindow = function(instanceSettings) {

        return this.each(function() {

            $(this).click(function() {

                $.fn.popupWindow.defaultSettings = {
                    centerBrowser: 0, // center window over browser window? {1 (YES) or 0 (NO)}. overrides top and left
                    centerScreen: 0, // center window over entire screen? {1 (YES) or 0 (NO)}. overrides top and left
                    height: 500, // sets the height in pixels of the window.
                    left: 0, // left position when the window appears.
                    location: 0, // determines whether the address bar is displayed {1 (YES) or 0 (NO)}.
                    menubar: 0, // determines whether the menu bar is displayed {1 (YES) or 0 (NO)}.
                    resizable: 0, // whether the window can be resized {1 (YES) or 0 (NO)}. Can also be overloaded using resizable.
                    scrollbars: 0, // determines whether scrollbars appear on the window {1 (YES) or 0 (NO)}.
                    status: 0, // whether a status line appears at the bottom of the window {1 (YES) or 0 (NO)}.
                    width: 500, // sets the width in pixels of the window.
                    windowName: null, // name of window set from the name attribute of the element that invokes the click
                    windowURL: null, // url used for the popup
                    top: 0, // top position when the window appears.
                    toolbar: 0 // determines whether a toolbar (includes the forward and back buttons) is displayed {1 (YES) or 0 (NO)}.
                };

                settings = $.extend({}, $.fn.popupWindow.defaultSettings, instanceSettings || {});

                var windowFeatures = 'height=' + settings.height +
                    ',width=' + settings.width +
                    ',toolbar=' + settings.toolbar +
                    ',scrollbars=' + settings.scrollbars +
                    ',status=' + settings.status +
                    ',resizable=' + settings.resizable +
                    ',location=' + settings.location +
                    ',menuBar=' + settings.menubar;

                settings.windowName = this.name || settings.windowName;
                settings.windowURL = this.href || settings.windowURL;
                var centeredY, centeredX;

                if (settings.centerBrowser) {

                    if ($.browser.msie) { //hacked together for IE browsers
                        centeredY = (window.screenTop - 120) + ((((document.documentElement.clientHeight + 120) / 2) - (settings.height / 2)));
                        centeredX = window.screenLeft + ((((document.body.offsetWidth + 20) / 2) - (settings.width / 2)));
                    } else {
                        centeredY = window.screenY + (((window.outerHeight / 2) - (settings.height / 2)));
                        centeredX = window.screenX + (((window.outerWidth / 2) - (settings.width / 2)));
                    }
                    window.open(settings.windowURL, settings.windowName, windowFeatures + ',left=' + centeredX + ',top=' + centeredY).focus();
                } else if (settings.centerScreen) {
                    centeredY = (screen.height - settings.height) / 2;
                    centeredX = (screen.width - settings.width) / 2;
                    window.open(settings.windowURL, settings.windowName, windowFeatures + ',left=' + centeredX + ',top=' + centeredY).focus();
                } else {
                    window.open(settings.windowURL, settings.windowName, windowFeatures + ',left=' + settings.left + ',top=' + settings.top).focus();
                }
                return false;
            });

        });
    };
})(jQuery);

//position center
jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", ( $(window).height() - this.height() ) / 2+$(window).scrollTop() + "px");
    this.css("left", ( $(window).width() - this.width() ) / 2+$(window).scrollLeft() + "px");
    return this;
}
</script>

</head>
<body>
<form name="form1" id="form1" method="post" >
<input type="hidden" name="version" id="version"  value=""/>
<input type="hidden" name ="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="productName" name="productName" value="${param.productName}"  searchBinding="PRODUCT_NAME"/>
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<input type="hidden" id="testId" name="testId" value="${param.testId}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
	<div class="pop_window">
		<div class="pop_tit_wrap">
			<!-- <span class="baseline"></span> -->
			<h2 class="pop_tit" style="margin-top:10px;">Detailed Information</h2>
		</div>
		
       <div class="pop_con_area" style="padding-top: 3px;"> 
			<div id="contents" class="wrap_a" >
       	   		
       	   </div>  
       	  
       	   <div class="btn_section">
	            <div class="right_section">
	            	
	                  <a href="#"  id="goDatail" class="btn_txt btn_type_e btn_color_c" onclick="fn_close();return false;">
	                      <span class="name">
	                          <span class="txt">Close</span>
	                      </span>
	                  </a>	                  
	            </div>
        	</div>         
       </div> 
       
    </div>
    <div id="dialog-confirm"></div>
    <!-- ## //PAGE CONTENTS ## -->	
</form>
</body>

<iframe id="file_iframe" style="display:none;"></iframe>
</html>