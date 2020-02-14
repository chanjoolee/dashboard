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
		#container { width: 100% ;min-width:320px; margin:0px auto 0 auto; background:white; border-radius:0px; padding:0px; overflow:scroll; }
		.ck.ck-editor__top { display: none;}
		</style>
	</head>
	<body>
		<div id="container" role="main">
			
		</div>

		<script src="//static.jstree.com/latest/assets/dist/libs/jquery.js"></script>
		<script src="./js/ckeditor5-build-classic-16.0.0/ckeditor5-build-classic/ckeditor.js"></script>
		<script src="./js/jointjs/lodash.4.17.10.js"></script>
		<script>
		var editors = [];
		var vEditable = false;
		function saveEditor( _id , _editor ){
			
			var blob = new Blob([_editor.getData()], {type: "text/plain;charset=utf-8"});
			//var blob = yourAudioBlobCapturedFromWebAudioAPI;// for example   
			var reader = new FileReader();
			// this function is triggered once a call to readAsDataURL returns
			reader.onload = function(event){
				var fd = new FormData();
				var fileOfBlob = new File([blob], _id + ".txt");
				fd.append('file', fileOfBlob);
				fd.append('uploadBoard', 'manual_ck5');
				fd.append('useRealFileName', 'Y');
				$.ajax({
					type: 'POST',
					url: '${pageContext.request.contextPath}/fileTestJson.html',
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
				var h = Math.max($(window).height() - 0);
				$('#container').height(h);
			}).resize();
			
			ClassicEditor
			.create( document.querySelector( '#container' ) ,{
				ckfinder: {
					uploadUrl  : "${pageContext.request.contextPath}/ckfinderUploadJson.html"
				}
				// , removePlugins :'toolbar'
			})
			.then( editor => {
				var nodeId = "j1_11";
				editor.isReadOnly = !vEditable;
				$(".ck.ck-button .ck.ck-tooltip").hide();
				// getfile
				$.ajax({
					url: "./upload/manual_ck5/" + nodeId + ".txt",
					async: false,
					success: function (content){
						editor.setData(content);
					}
				});

				editor.model.document.on( 'change:data', () => {
					// console.log( 'The data has changed!' );
					return saveEditor( nodeId , editor );
				} );
			} )
			.catch( error => {
				// console.error( error );
			} );

		});
		</script>
	</body>
</html>

