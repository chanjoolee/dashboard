<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Drag & Drop</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script src="http://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>
<style>
	#images > div, #boards > div {float:left;width:100px;height:100px;border:1px solid #000;margin:5px;}
	#images div img {width:100px;height:100px;}
	#boards {clear:both;}
	#boards > div {font-size:2em;line-height:100px;text-align:center;}
</style>
</head>
<body>
<div id="images">
	<div><img src="http://lorempixel.com/100/100/food" id="food"></div>
	<div><img src="http://lorempixel.com/100/100/city" id="city"></div>
	<div><img src="http://lorempixel.com/100/100/sports" id="sports"></div>
	<div><img src="http://lorempixel.com/100/100/animals" id="animals"></div>
</div>
<div id="boards">
	<div title="sports">sports</div>
	<div title="food">food</div>
	<div title="animals">animals</div>
	<div title="city">city</div>
</div>
<script>
	$(function(){
		$("#images div img").draggable({
			start: function(event,ui) {
				$(this).draggable( "option", "revert", true );
				$("#images div img").css("zIndex",10);
				$(this).css("zIndex",100);
			}
		});
		$("#boards div").droppable({
			drop: function(event,ui) {
				var droptitle = $(this).attr("title");
				var drophtml = $(this).html();
				var dragid = ui.draggable.attr("id");
				if( dragid == droptitle ) {
					ui.draggable.draggable( "option", "revert", false );
					var droppableOffset = $(this).offset();
					var x = droppableOffset.left + 1;
					var y = droppableOffset.top + 1;
					ui.draggable.offset({ top: y, left: x });
				}
			}
		});
	});
	$(document).ready(function(){
		$("#images div").sort(function(){
			return Math.random()*10 > 5 ? 1 : -1;
		}).each(function(){
			$(this).appendTo( $(this).parent() );    
		});
		$("#boards div").sort(function(){
			return Math.random()*10 > 5 ? 1 : -1;
		}).each(function(){
			$(this).appendTo( $(this).parent() );    
		});
	});
</script>
</body>
</html>