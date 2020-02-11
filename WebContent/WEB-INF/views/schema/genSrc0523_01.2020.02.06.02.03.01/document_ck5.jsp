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
		<script src="./js/ckeditor5-build-classic-16.0.0/ckeditor5-build-classic/ckeditor.formatted.js"></script>

		<script src="./js/jointjs/lodash.4.17.10.js"></script>
		<script>
			var editors = [];
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
								return '/dashboard/jstreeJson.html?sqlid=jstree.doc';
							},
							// 'url' : '/dashboard/genericlListJson.html?sqlid=jstree.doc',
							'data' : function (node) {
								var v_node_id = node.id;
								// if (node.id == "#")
								// 	v_node_id = "1";
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
					$.get('?operation=delete_node', { 'id' : data.node.id })
						.fail(function () {
							data.instance.refresh();
						});
				})
				.on('create_node.jstree', function (e, data) {
					$.get('?operation=create_node', { 'id' : data.node.parent, 'position' : data.position, 'text' : data.node.text })
						.done(function (d) {
							data.instance.set_id(data.node, d.id);
						})
						.fail(function () {
							data.instance.refresh();
						});
				})
				.on('rename_node.jstree', function (e, data) {
					$.get('?operation=rename_node', { 'id' : data.node.id, 'text' : data.text })
						.fail(function () {
							data.instance.refresh();
						});
				})
				.on('move_node.jstree', function (e, data) {
					$.get('?operation=move_node', { 'id' : data.node.id, 'parent' : data.parent, 'position' : data.position })
						.fail(function () {
							data.instance.refresh();
						});
				})
				.on('copy_node.jstree', function (e, data) {
					$.get('?operation=copy_node', { 'id' : data.original.id, 'parent' : data.parent, 'position' : data.position })
						.always(function () {
							data.instance.refresh();
						});
				})
				.on('changed.jstree', function (e, data) {
					if(data && data.selected && data.selected.length) {
						$.each( editors , function(i, edit){
							$(edit.editor.ui.view.element).hide();
						});
						var v_edit = _.find(editors,{id: data.node.id});
						if(v_edit == null){
							ClassicEditor
							.create( document.querySelector( '#data .default' ) ,{
								ckfinder: {
									uploadUrl  : "${pageContext.request.contextPath}/ckfinderUploadJson.html"
								}
							})
							.then( editor => {
								editors.push({
									id : data.node.id ,
									editor : editor 
								});
							} )
							.catch( error => {
								console.error( error );
							} );
						}else{
							$(v_edit.editor.ui.view.element).show();
						}

						// $.get('/dashboard/jstreeJson.html?sqlid=jstree.doc&id=' + data.selected.join(':'), function (d) {
						// 	$('#data .default').text(d.content).show();
						// });
					}
					else {
						// $('#data .content').hide();
						// $('#data .default').text('Select a file from the tree.').show();
					}
				})
				;


		});
		</script>
	</body>
</html>

