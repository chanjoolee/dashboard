<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  
 <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
 <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
 <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
  
  
  <style>
    
  </style>
  <script type="text/javascript">
  		var json = {};
  		
  
		$(function() {			
			jsoncall();
			resize();
			$(window).resize(function() {
				resize();
			});
		});
		function resize() {
			var height = window.innerHeight
				- $("#nav").height() 
				- parseInt($("#nav").css("padding-top"))
				- parseInt($("#nav").css("padding-bottom"))
				
				- $("#footer").height()
				- parseInt($("#footer").css("padding-top"))
				- parseInt($("#footer").css("padding-bottom"))
				- 5
				;			
			$("#center").height(height);
		}
		
		function jsoncall(){
			$.getJSON( "json/testSchema.json", function( data ) {
				 console.log(data);
			});
		}
		
		function jsoncall1(){
			$.getJSON( "json/test.json", function( data ) {
				  var items = [];
				  $.each( data, function( key, val ) {
				    items.push( "<li id='" + key + "'>" + val + "</li>" );
				  });
				 
				  $( "<ul/>", {
				    "class": "my-new-list",
				    html: items.join( "" )
				  }).appendTo( "body" );
				});
		}
		
		
		
		
	</script>
</head>
<body>

</body>
</html>