<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="/dashboard/js/jointjs/joint.css" />
  <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="/dashboard/js/jointjs/lodash.min.js"></script>
  <script src="/dashboard/js/jointjs/backbone.js"></script>
    <script src="/dashboard/js/jointjs/joint.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 100%}
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 100%;
    }
    
    /* Set black background color, white text and some padding */
    footer {
      background-color: #555;
      color: white;
      padding: 15px;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
  </style>
  <script type="text/javascript">
  
		$(function() {
			// drag & drop
			$("#center ul li div").draggable({
				helper:"clone"  	,
				start: function(event,ui) {
					$(this).attr("clonable",true);
					
				}
				
			});
			$("#canvas").droppable({
				drop: function(event,ui) {
					if($(ui.draggable).attr("clonable")=="true"){
						var clone = $(ui.draggable).clone();
						clone.attr("clonable",false);
						clone.css("width","100px");
						clone.draggable();
						
						var droppableOffset = $(this).offset();
						var x = droppableOffset.left  ;
						var y = droppableOffset.top ;						
						//clone.offset({ top: event.offsetY - parseInt($(this).css("padding-top")) , left: event.offsetX  - parseInt($(this).css("padding-left")) });			
						
						clone.appendTo($(this));  
						
					}
					
					
					
				}
			});
			// drag & drop end
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
		
		
	</script>
</head>
<body>

<nav class="navbar navbar-inverse" id="nav">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Logo</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="#">Home</a></li>
        <li><a href="#">About</a></li>
        <li><a href="#">Projects</a></li>
        <li><a href="#">Contact</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
      </ul>
    </div>
  </div>
</nav>
  
<div class="container-fluid text-center" id="center">    
  <div class="row content text-left">
    <div class="col-sm-2 sidenav">
      <ul class="nav nav-pills nav-stacked">
        <li><div id="shapeStart">shapeStart</div></li>
        <li><div id="shapeTask">shapeTask</div></li>
        <li><div id="shapeSubTask">shapeSubTask</div></li>
      </ul><br>
    </div>
    <div class="col-sm-8 text-left" id="canvas" style="height: 100%"></div>
    <div class="col-sm-2 sidenav">
      <div class="well">
        <p>ADS</p>
      </div>
      <div class="well">
        <p>ADS</p>
      </div>
    </div>
  </div>
</div>

<footer id="footer" class="container-fluid text-center">
  <p>Footer Text</p>
</footer>

</body>
</html>
