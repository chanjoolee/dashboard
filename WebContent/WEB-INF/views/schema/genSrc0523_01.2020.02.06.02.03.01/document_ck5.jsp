<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>Title</title>
		<meta name="viewport" content="width=device-width" />
		
		<link rel="stylesheet" href="//static.jstree.com/latest/assets/dist/themes/default/style.min.css" />
		<style>
		html, body { background:#ebebeb; font-size:10px; font-family:Verdana; margin:0; padding:0; }
		#container { min-width:320px; margin:0px auto 0 auto; background:white; border-radius:0px; padding:0px; overflow:hidden; }
		#tree { float:left; min-width:319px; border-right:1px solid silver; overflow:auto; padding:0px 0; }
		#data { margin-left:320px;  overflow: scroll;}
		#data textarea { margin:0; padding:0; height:100%; width:100%; border:0; background:white; display:block; line-height:18px; }
		#data, #code { font: normal normal normal 12px/18px 'Consolas', monospace !important; }
		/* .ck.ck-editor__top { display: none;} */
		</style>
	</head>
	<body>
		<div id="container" role="main">
			<div id="tree"></div>
			<div id="data">
				<div class="content code" style="display:none;"><textarea id="code" readonly="readonly"></textarea></div>
				<div class="content folder" style="display:none;"></div>
				<div class="content image" style="display:none; position:relative;"><img src="" alt="" style="display:block; position:absolute; left:50%; top:50%; padding:0; max-height:90%; max-width:90%;" /></div>
				<div class="content default" style="text-align:center;"></div>
			</div>
		</div>

		<script src="//static.jstree.com/latest/assets/dist/libs/jquery.js"></script>
		<script src="//static.jstree.com/latest/assets/dist/jstree.min.js"></script>
		<!-- <script src="https://cdn.ckeditor.com/ckeditor5/16.0.0/classic/ckeditor.js"></script> -->
		<script src="./js/ckeditor5-build-classic-16.0.0/ckeditor5-build-classic/ckeditor.js"></script>
		<!-- <script src="./js/ckeditor5-build-classic-16.0.0/ckeditor5-build-classic/autosave.js"></script> -->

		<script src="./js/jointjs/lodash.4.17.10.js"></script>

		<script>
		
		var editors = [];
		var cur_editor = null;
		var vEditable = true;
		function get_language(){
			var language = "${locale_language}";
			if(parent.$("#language_head") != null)
				language = parent.$("#language_head:first-child").text();

			var document_postfix = "";
			if (language != "ko")
				document_postfix = "_en";
			return document_postfix;
		}
		function saveEditor( _id , _editor ){
			
			var blob = new Blob([_editor.getData()], {type: "text/plain;charset=utf-8"});
			//var blob = yourAudioBlobCapturedFromWebAudioAPI;// for example   
			var reader = new FileReader();
			// this function is triggered once a call to readAsDataURL returns
			reader.onload = function(event){
				var fd = new FormData();
				var fileOfBlob = new File([blob], _id + get_language() + ".txt");
				fd.append('file', fileOfBlob);
				fd.append('uploadBoard', 'manual_ck5');
				fd.append('useRealFileName', 'Y');
				$.ajax({
					type: 'POST',
					url: './fileTestJson.html',
					data: fd
					, processData: false
					, contentType: false
					, success:  function(data){

					} 
					
				});
				
			};
			// trigger the read from the reader...
			reader.readAsDataURL(blob); 

		}
		$(function () {
			$(window).resize(function () {
				var h = Math.max($(window).height() - 0, 420);
				$('#container, #data, #tree, #data .content').height(h).filter('.default').css('lineHeight', h + 'px');
			}).resize();
			
			$('#tree')
				.jstree({
					'core' : {
						'data' : {
							'url' : function(node) {
								return './jstreeJson.html?sqlid=jstree.doc';
							},
							'data' : function (node) {
								var v_node_id = node.id;
								return { 'id' : v_node_id };
							},
							'success' : function(nodes) {
								var validateChildrenArray = function(node) {
									
									// node.icon = "folder";
									if(node.children_cnt > 0){
										node.children = true;
									}else
										node.children = false;
									
								};

								for (var i = 0; i < nodes.length; i++) {
									validateChildrenArray(nodes[i]);
								}
							}
						},

						'force_text' : true,
						'check_callback' : true,
						'themes' : {
							'responsive' : false
						}
					},
					'plugins' : ['state','dnd','contextmenu','wholerow']
				})
				.on('delete_node.jstree', function (e, data) {
					var bind = {
						id : data.node.id ,
						text : data.text
					};
					$.ajax({
						url: "${pageContext.request.contextPath}/genericSaveJson.html?sqlid=jstree.delete",
						type: "POST",
						data: bind , 
						// async: false,			                    		
						success:  function(_response){
							if(_response.result != 'success'){
								data.instance.refresh();
							} 
							// Success
							else {
								
							}						                    			
						} 
						, error:function(request,status,error){
							data.instance.refresh();
							// alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
						}
					});
				})
				.on('create_node.jstree', function (e, data) {
					var bind = {
						id : data.node.id ,
						parent : data.node.parent, 
						position : data.position,
						text : data.node.text
					};
					$.ajax({
						url: "${pageContext.request.contextPath}/genericSaveJson.html?sqlid=jstree.create",
						type: "POST",
						data: bind , 
						// async: false,			                    		
						success:  function(_response){
							if(_response.result != 'success'){
								// var state = false;
								data.instance.refresh();
							} 
							// Success
							else {
								// data.instance.set_id(data.node, d.id);
							}						                    			
						} 
						, error:function(request,status,error){
							data.instance.refresh();
						}
					});

				})
				.on('rename_node.jstree', function (e, data) {
					var bind = {
						id : data.node.id ,
						text : data.text
					};
					$.ajax({
						url: "${pageContext.request.contextPath}/genericSaveJson.html?sqlid=jstree.update.title",
						type: "POST",
						data: bind , 
						// async: false,			                    		
						success:  function(_response){
							if(_response.result != 'success'){
								// var state = false;
								data.instance.refresh();
							} 
							// Success
							else {
								
							}						                    			
						} 
						, error:function(request,status,error){
							data.instance.refresh();
						}
					});
					
				})
				.on('move_node.jstree', function (e, data) {
					
					var parent = _.find(data.instance._model.data, {id : data.parent});
					$.each(parent.children , function(i,child){
						var bind = { 'id' : child, 'parent' : data.parent, 'position' : i };
						$.ajax({
							url: "${pageContext.request.contextPath}/genericSaveJson.html?sqlid=jstree.move",
							type: "POST",
							data: bind , 
							async: false ,			                    		
							success:  function(_response){
								if(_response.result != 'success'){
									// var state = false;
									data.instance.refresh();
								} 
								// Success
								else {
									// data.instance.set_id(data.node, d.id);
								}						                    			
							} 
							, error:function(request,status,error){
								data.instance.refresh();
							}
						});
					});
					
					
				})
				.on('copy_node.jstree', function (e, data) {
					// { 'id' : data.original.id, 'parent' : data.parent, 'position' : data.position }
					var bind = {
						id : data.node.id ,
						parent : data.node.parent, 
						position : data.position,
						text : data.node.text
					};

					$.ajax({
						url: "${pageContext.request.contextPath}/genericSaveJson.html?sqlid=jstree.copy",
						type: "POST",
						data: bind , 
						// async: false,			                    		
						success:  function(_response){
							if(_response.result != 'success'){
								// var state = false;
								data.instance.refresh();
							} 
							// Success
							else {
								// data.instance.set_id(data.node, d.id);
							}						                    			
						} 
						, error:function(request,status,error){
							data.instance.refresh();
						}
					});
					
				})
				.on('changed.jstree', function (e, data) {
					if(data && data.selected && data.selected.length) {
						// $.each( editors , function(i, edit){
						// 	$(edit.editor.ui.view.element).hide();
						// });
						// var v_edit = _.find(editors,{id: data.node.id});
						// if(v_edit == null){
							if (cur_editor != null)
								cur_editor.destroy();
							ClassicEditor
							.create( document.querySelector( '#data .default' ) ,{
								ckfinder: {
									uploadUrl  : "./ckfinderUploadJson.html"
								} 
								
							})
							.then( editor => {
								// editors.push({
								// 	id : data.node.id ,
								// 	editor : editor 
								// });
								cur_editor = editor;
								editor.isReadOnly = !vEditable;
								$(".ck.ck-button .ck.ck-tooltip").hide();
								// getfile
								$.ajax({
									url: "./upload/manual_ck5/" + data.node.id +  get_language() + ".txt",
									async: false,
									success: function (content){
										editor.setData(content);
									} ,
									error : function (){
										editor.setData("");
									},
									
								});
								

								editor.model.document.on( 'change:data', () => {
									// console.log( 'The data has changed!' );
									return saveEditor( data.node.id , editor );
								} );
							} )
							.catch( error => {
								// console.error( error );
							} );
						// }else{
						// 	$(v_edit.editor.ui.view.element).show();
						// }

					}
					else {
					
					}
				})
				;


		});
		</script>
	</body>
</html>

