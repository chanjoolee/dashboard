<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<title>Generate Source By BPMN2</title>
<head>
<jsp:include page="/WEB-INF/views/include/include.toolbox.pmstable.jsp"></jsp:include>
	<script id="script_schema">
		var beforEditRow = {};
		var EfContextPath = "";
		var schemaTab = {
			"type": "tab_list",
			"id": "tabListTabList",
			"name": "tabListTabList",
			"label": "",
			"text": "tabList",
			"elements": [
				
				// {
				// 	"type": "tab_iframe",
				// 	"id": "gensrcListIframe",
				// 	"name": "gensrcListIframe",
				// 	"label": "Generate list",
				// 	"text": "Generate list",
				// 	"connected_content": {
				// 		"viewName": "gensrc/genSrcCustom/gensrcList",
				// 		"form_id": "form"
				// 	},
				// 	"iframe_css": [
				// 		{
				// 			"code": "height",
				// 			"value": "1000px"
				// 		}
				// 	]
				// },
				// {
				// 	"type": "tab_iframe",
				// 	"id": "cmmCdIframe",
				// 	"name": "cmmCdIframe",
				// 	"label": "Common Code",
				// 	"text": "Common Code",
				// 	"connected_content": {
				// 		"viewName": "gensrc/genSrcCustom/gensrcCmmCd",
				// 		"form_id": "form"
				// 	},
				// 	"iframe_css": [
				// 		{
				// 			"code": "height",
				// 			"value": "1000px"
				// 		}
				// 	]
				// },
				// {
				// 	"type": "tab_iframe",
				// 	"id": "gensrcCmmUseIframe",
				// 	"name": "gensrcCmmUseIframe",
				// 	"label": "Cmm Use",
				// 	"text": "Cmm Use",
				// 	"connected_content": {
				// 		"viewName": "gensrc/genSrcCustom/gensrcCmmUse",
				// 		"form_id": "form"
				// 	},
				// 	"iframe_css": [
				// 		{
				// 			"code": "height",
				// 			"value": "1000px"
				// 		}
				// 	]
				// },
				// {
				// 	"type": "tab_iframe",
				// 	"id": "gensrcTabColsIframe",
				// 	"name": "gensrcTabColsIframe",
				// 	"label": "Tables",
				// 	"text": "Tables",
				// 	"connected_content": {
				// 		"viewName": "gensrc/genSrcCustom/gensrcTabCols",
				// 		"form_id": "form"
				// 	},
				// 	"iframe_css": [
				// 		{
				// 			"code": "height",
				// 			"value": "1000px"
				// 		}
				// 	]
				// }
				
			]
		};
	</script>
	<script  id="script_main">
		$(function () {
			$("#loader").show();
			setTimeout( function(){
				$('#schemaTabContainer').html('')
				fn_makeHtml('schemaTabContainer',schemaTab);
				$("#loader").hide();
			},50);
			// modal show
			$(document).on('shown.bs.modal', function (event) {
				var backdrops = $('.modal-backdrop.fade.in');
				$.each(backdrops, function(i, backdrop){
					if(i>0)
						$(backdrop).css("opacity",0);
				} );
			});
			// modal Close
			$(document).on('hidden.bs.modal', function (event) {
				
				$('.modal:visible').length && $(document.body).addClass('modal-open');
				 
				// $("#modal_2019-5-31-11-38-56").remove();
				var _this = $(this);
				var target = $(event.target);
				if(target.attr("isCloned") != null)
					target.remove();
			});
		});
		function fn_search(){
			$("#loader").show();
			setTimeout( function(){
				$("#loader").hide();
			},50);
		};
	</script>
</head>
<body  style="min-width:920px">
<form name="form" id="form" class="">
	<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
	<div id="schemaTabContainer" class="" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>
</form>
<!-- Stacked  Modal -->
<div name="infiniteLogModal_bootstrap4" class="modal fade" aria-hidden="true" style="display: none;">
	<div class="modal-dialog modal-dialog-vertical-center" role="document">
	  <div class="modal-content bd-0 tx-14">
		<div class="modal-header pd-y-20 pd-x-25">
		  <h6 class="tx-14 mg-b-0  tx-inverse tx-bold"><span id="popFailMode"></span> </h6>
		  <button type="button" class="close csr-ptr" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">x</span>
		  </button>
		</div>
		<div class="modal-body pd-25" style="padding: 10px;"> 
		  <div class="infiniteLogContainer" style="width: 100%"></div>
		</div>
	  </div>
	</div><!-- modal-dialog -->
</div>
<div name="infiniteLogModal" class="modal fade" tabindex="-1" role="dialog">
	<div class="modal-dialog" role="document" style=" width: 1020px; ">
	  <div class="modal-content" >
		<div class="modal-header">
		  <h6 class="tx-14 mg-b-0  tx-inverse tx-bold"><span id="popFailMode"></span> </h6>
		  <button type="button" class="close csr-ptr" data-dismiss="modal" aria-label="Close">
		  <span aria-hidden="true">x</span>
		  </button>
		</div>
		<div class="modal-body">
		  <div class="infiniteLogContainer" style="width: 100%"></div>
		</div>      
	  </div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
</body>
<jsp:include page="/WEB-INF/views/include/includeReactComponent.jsp"></jsp:include>