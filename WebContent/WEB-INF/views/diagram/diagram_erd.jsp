<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  
  <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  
  <script src="http://resources.jointjs.com/tutorials/joint/node_modules/jquery/dist/jquery.js"></script>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script> -->
  
  <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
  
  <!--<link rel="stylesheet" href="/dashboard/js/jointjs/joint.css" />-->
  
  <script src="http://resources.jointjs.com/tutorials/joint/node_modules/lodash/index.js"></script>
  <script src="http://resources.jointjs.com/tutorials/joint/node_modules/backbone/backbone.js"></script>
  <!--<script src="http://resources.jointjs.com/tutorials/joint/build/joint.min.js"></script>-->
  <script src="/dashboard/js/jointjs/joint.src.js"></script>
  
  <!-- <script src="/dashboard/js/jointjs/lodash.min.js"></script>
  <script src="/dashboard/js/jointjs/backbone.js"></script>
  <script src="/dashboard/js/jointjs/joint.js"></script> -->
  <!-- <script src="/dashboard/js/jointjs/rappid.js"></script> -->
  
  <!-- 
  <script src="http://resources.jointjs.com/tutorials/joint/node_modules/lodash/index.js"></script>
  <script src="http://resources.jointjs.com/tutorials/joint/node_modules/backbone/backbone.js"></script>
  <link rel="stylesheet" href="http://resources.jointjs.com/tutorials/joint/build/joint.min.css" />
  <script src="http://resources.jointjs.com/tutorials/joint/build/joint.min.js"></script> 
  -->
 <link rel="stylesheet" href="http://resources.jointjs.com/tutorials/joint/build/joint.min.css" />
  
  
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
  <style title="htmlElement">
 #paper-html-elements {
    position: relative;
    border: 1px solid gray;
    display: inline-block;
    background: transparent;
    overflow: hidden;
}
#paper-html-elements svg {
    background: transparent;
}
#paper-html-elements svg .link {
    z-index: 2;
}
.html-element {
    position: absolute;
    background: #3498DB;
    /* Make sure events are propagated to the JointJS element so, e.g. dragging works.*/
    pointer-events: none;
    -webkit-user-select: none;
    border-radius: 4px;
    border: 2px solid #2980B9;
    box-shadow: inset 0 0 5px black, 2px 2px 1px gray;
    /*padding: 5px;*/
    padding: 0;
    
    box-sizing: border-box;
    z-index: 2;
}
.html-element select,
.html-element input,
.html-element button {
    /* Enable interacting with inputs only. */
    pointer-events: auto;
}
.html-element button.delete {
    color: white;
    border: none;
    background-color: #C0392B;
    border-radius: 20px;
    width: 15px;
    height: 15px;
    line-height: 15px;
    text-align: middle;
    position: absolute;
    top: -15px;
    left: -15px;
    padding: 0;
    margin: 0;
    font-weight: bold;
    cursor: pointer;
}
.html-element button.delete:hover {
    width: 20px;
    height: 20px;
    line-height: 20px; 
}
.html-element select {
    position: absolute;
    right: 2px;
    bottom: 28px;
}
.html-element input.title {
    position: relative;
    /*top: 0;*/
    /*left: 0;*/
    /*right: 0;*/
    border: none;
    color: #333;
    padding: 5px;
    height: 16px;
    width: 100%;
}
.html-element label {
    color: #333;
    text-shadow: 1px 0 0 lightgray;
    font-weight: bold;
}
.html-element span {
    position: absolute;
    top: 2px;
    right: 9px;
    color: white;
    font-size: 10px;
}
.joint-paper.joint-theme-default {
    background-color: transparent;
}
  </style>
  <script type="text/javascript">
  		_.templateSettings = {
		    interpolate: /\<\@\=(.+?)\@\>/gim,
		    evaluate: /\<\@(.+?)\@\>/gim,
		    escape: /\<\@\-(.+?)\@\>/gim
		};
	  // custom 
	 	joint.shapes.html = {};
	    joint.shapes.html.Element = joint.shapes.basic.Rect.extend({
	        defaults: joint.util.deepSupplement({
	            type: 'html.Element',
	            attrs: {
	                rect: { 
						stroke: 'none', 'fill-opacity': 0 						
					}
	            }
	        }, joint.shapes.basic.Rect.prototype.defaults)
	    });
	  
	    joint.shapes.html.ElementView = joint.dia.ElementView.extend({
	        template: [
	            '<div class="html-element">',
	            '<button class="delete">x</button>',
	            '<input class="title" type="text" value="" />',
	            '</div>'
	        ].join(''),
	        initialize: function() {
	            _.bindAll(this, 'updateBox');
	            joint.dia.ElementView.prototype.initialize.apply(this, arguments);
				this.expand = false;
				this.expandPosition = null;
				this.$box = $(_.template(this.template)());
	            //// Prevent paper from handling pointerdown.
	            //this.$box.find('input,select').on('mousedown click', function(evt) {
	            //    evt.stopPropagation();
	            //});
	            //// This is an example of reacting on the input change and storing the input data in the cell model.
	            this.$box.find('input').on('change', _.bind(function(evt) {
	                this.model.set('input', $(evt.target).val());
	            }, this));
	            //this.$box.find('select').on('change', _.bind(function(evt) {
	            //    this.model.set('select', $(evt.target).val());
	            //}, this));
	            //this.$box.find('select').val(this.model.get('select'));
	            this.$box.find('.delete').on('click', _.bind(this.model.remove, this.model));
	            //// Update the box position whenever the underlying model changes.
	            this.model.on('change', this.updateBox, this);
	            //// Remove the box when the model gets removed from the graph.
	            this.model.on('remove', this.removeBox, this);
	            this.updateBox();
	        },
	        render: function() {
	            joint.dia.ElementView.prototype.render.apply(this, arguments);
	            this.paper.$el.prepend(this.$box);
	            this.updateBox();
	            return this;
	        },
	        updateBox: function() {
	            // Set the position and dimension of the box so that it covers the JointJS element.
	            var bbox = this.model.getBBox();
	            // Example of updating the HTML with a data stored in the cell model.
	            //this.$box.find('label').text(this.model.get('label'));
	            //this.$box.find('span').text(this.model.get('select'));
	            this.$box.css({
	                width: bbox.width,
	                height: bbox.height,
	                left: bbox.x,
	                top: bbox.y,
	                transform: 'rotate(' + (this.model.get('angle') || 0) + 'deg)'
	            });
	        },
	        removeBox: function(evt) {
	            this.$box.remove();
	        },
	        
	        pointerdown: function(evt, x, y) {
		        // var position = this.model.get('position');
		        // var size = this.model.get('size');
		        // var center = g.rect(position.x, position.y, size.width, size.height).center();
		        // var intersection = constraint.intersectionWithLineFromCenterToPoint(center);
		        // joint.dia.ElementView.prototype.pointerdown.apply(this, [evt, intersection.x, intersection.y]);
				var box = this.getBBox();
				var mouseSection = g.rect(x - 2,y - 2,10,10);
				var cornerSection = g.rect(box.corner().x - 1,box.corner().y - 2,10,10);
				var intersection = cornerSection.intersect(mouseSection);
				if(intersection != null){
					this.expand = true;
					this.expandPosition = 2;
				}else{
					this.expand = false;	
				}
					
				// console.log("intersection: " + intersection); 
				
				joint.dia.ElementView.prototype.pointerdown.apply(this, [evt, x, y]);
		    },
			
			
			pointermove: function(evt, x, y) {
				// console.log("pointermove x:" + x + ", y:" + y);
				var box = this.getBBox();
				var corner = box.corner();
				var diff_x = x - corner.x;
				var diff_y = y - corner.y;
				var origin_h = this.model.attributes.size.height;
				var origin_w = this.model.attributes.size.width;
				var mod_h = origin_h + diff_y;
				var mod_w = origin_w + diff_x;
				if(this.expand && this.expandPosition == 2){
					this.model.set({size:{width: mod_w ,height: mod_h }}) ;				
				}else {
					joint.dia.ElementView.prototype.pointermove.apply(this, [evt, x, y]);
				}
				
				
			},
			
			// mouseover: function(evt) {
				// //this.$box.position();
				// // console.log("mouseover x:" + evt.clientX + ", y:" + evt.clientY);
				// joint.dia.ElementView.prototype.mouseover.apply(this, [evt]);
			// }
	        
	    });
  	
  		var graph;
  		var paper;
  
		$(function() {
			initShapeMenu();
			initPaper();
			initDragible();
			
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
		
		
		function initPaper(){
			graph = new joint.dia.Graph;
			// 
			paper = new joint.dia.Paper({
	  	        el: $('#canvas'),
	  	        width: '100%',
	  	        height: '100%',
	  	        model: graph,
	  	        gridSize: 1
	  	    });
			
			// paper = new joint.dia.Paper({graph.on('all', function(eventName, cell) {
		 	    // console.log(arguments);
		 	// });
	  	        
			
			// paper.on('cell:pointerdown', function(cellView, evt, x, y) {
			    // var bbox = cellView.getBBox();
			    // var strokeWidth = cellView.model.attr('rect/stroke-width') || 1;
			    // // console.log(isBorderClicked(bbox, x, y, strokeWidth))
				// // console.log(strokeWidth);
			    
			
			    // /* cellView.highlight(
		   		// null ,//defaults to cellView.el  
		   		// {
		        // highlighter: {
		            // name: 'stroke',
		            // options: {
		                // //padding: 10,
		                // //rx: 5,
		                // //ry: 5,
		                // attrs: {
		                    // 'stroke-width': 3,
		                    // stroke: '#FF0000'
		                // }
		            // }
		        // }
		    // }); */
			    
			    
			    
			// });
		}
		
		function initShapeMenu(){
			// 01. start
			var start_graph = new joint.dia.Graph;
			var start_paper = new joint.dia.Paper({
	  	        el: $('#shapeStart'),
	  	        width: 100,
	  	        height: 40,
	  	        model: start_graph,
	  	        gridSize: 1
	  	    });
			
			var start_rect = new joint.shapes.basic.Ellipse({
		        position: { x: 0, y: 0 },
		        size: { width: 30, height: 30 },
		        attrs: { ellipse: { fill: 'green' }, text: { text: 'start', fill: 'white' } }
		        
		    });
			
			start_graph.addCells([start_rect]);
			
			// 02. task
			var task_graph = new joint.dia.Graph;
			var task_paper = new joint.dia.Paper({
	  	        el: $('#shapeTask'),
	  	        width: 100,
	  	        height: 40,
	  	        model: task_graph,
	  	        gridSize: 1
	  	    });
			
			var task_rect = new joint.shapes.basic.Rect({
		        position: { x: 0, y: 0 },
		        size: { width: 60, height: 30 },
		        attrs: { rect: { fill: 'skyblue' }, text: { text: 'task', fill: 'black' } }
		    });
			
			task_graph.addCells([task_rect]);
			
			// 03. subTask
			var subTask_graph = new joint.dia.Graph;
			var subTask_paper = new joint.dia.Paper({
	  	        el: $('#shapeSubTask'),
	  	        width: 100,
	  	        height: 40,
	  	        model: subTask_graph,
	  	        gridSize: 1
	  	    });
			
			var subTask_rect = new joint.shapes.basic.Rect({
		        position: { x: 0, y: 0 },
		        size: { width: 60, height: 30 },
		        attrs: { rect: { fill: 'skyblue' }, text: { text: 'subTask', fill: 'black' } }
		    });
			
			subTask_graph.addCells([subTask_rect]);
			
			// 04. link
			var link_graph = new joint.dia.Graph;
			var link_paper = new joint.dia.Paper({
	  	        el: $('#shapeLink'),
	  	        width: 100,
	  	        height: 40,
	  	        model: link_graph,
	  	        gridSize: 1
	  	    });
			
			var link_rect = new joint.shapes.basic.Rect({
		        position: { x: 0, y: 0 },
		        size: { width: 60, height: 30 },
		        attrs: { rect: { fill: 'green' }, text: { text: 'link', fill: 'white' } }
		    });
			
			link_graph.addCells([link_rect]);
		}
		
		function createStart(){
			
			var start = new joint.shapes.basic.Ellipse({
		        position: { x: 0, y: 0 },
		        size: { width: 50, height: 50 },
		        attrs: { ellipse: { fill: 'green' }, text: { text: '', fill: 'white' } }
		    });
			
			graph.addCells([start]);
		}
		
		function createTask(){
			
			/* var rect = new joint.shapes.basic.Rect({
		        position: { x: 0, y: 0 },
		        size: { width: 100, height: 50 },
		        attrs: { rect: { fill: 'skyblue' }, text: { text: '', fill: 'white' } }
		    }); */
			
			var rect = new joint.shapes.html.Element({
		        position: { x: 80, y: 80 },
		        size: { width: 170, height: 100 }
		        //label: 'I am HTML',
		        //select: 'one'
		    });
			
			rect.attr('rect/fill', {
				type: 'linearGradient',
				stops: [
					{ offset: '0%', color: '#E67E22' },
					{ offset: '20%', color: '#D35400' },
					{ offset: '40%', color: '#E74C3C' },
					{ offset: '60%', color: '#C0392B' },
					{ offset: '80%', color: '#F39C12' }
				]
			});
			
			graph.addCells([rect]);
		}
		
		function createSubTask(){
			
			var rect = new joint.shapes.basic.Rect({
		        position: { x: 0, y: 0 },
		        size: { width: 100, height: 50 },
		        attrs: { rect: { fill: 'skyblue' }, text: { text: '', fill: 'white' } }
		    });
			
			graph.addCells([rect]);
		}
		
		function createLink(){
			
			var link = new joint.dia.Link({
			    source: { x: 170, y: 20 }, 
			    target: { x: 480, y: 20 }
				
			    , attrs: {
			        // Define a filter for the whole link (special selector '.' means the root element )
			        '.': { filter: { name: 'dropShadow', args: { dx: 1, dy: 1, blur: 2 } } },
			        '.connection': {
			            'stroke-width': 5, stroke: '#34495E'
			        },
			        //'.marker-source': { stroke: '#E74C3C', fill: '#E74C3C', d: 'M 10 0 L 0 5 L 10 10 z' },
			        '.marker-target': { stroke: '#E74C3C', fill: '#E74C3C', d: 'M 10 0 L 0 5 L 10 10 z' }
			    }
			});
			
			graph.addCells([link]);
		}
		
		function initDragible(){
			$("#center ul li div").draggable({
				helper:"clone"  	,
				start: function(event,ui) {
					$(this).attr("clonable",true);
					//$(this).draggable( "option", "revert", false );					
				}
				
			});
			$("#canvas").droppable({
				drop: function(event,ui) {
					if($(ui.draggable).attr("clonable")=="true"){
						/* var clone = $(ui.draggable).clone();
						clone.attr("clonable",false);
						clone.css("width","100px");
						clone.draggable();
						
						var droppableOffset = $(this).offset();
						var x = droppableOffset.left  ;
						var y = droppableOffset.top ;						
						//clone.offset({ top: event.offsetY - parseInt($(this).css("padding-top")) , left: event.offsetX  - parseInt($(this).css("padding-left")) });			
						
						clone.appendTo($(this));   */
						
						if($(ui.draggable).attr("id") == "shapeStart")
							createStart();
						
						if($(ui.draggable).attr("id") == "shapeTask")
							createTask();
						
						if($(ui.draggable).attr("id") == "shapeSubTask")
							createSubTask();
						
						if($(ui.draggable).attr("id") == "shapeLink")
							createLink();
						
					}					
				}
			
			});
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
        <li><div id="shapeStart"></div></li>
        <li><div id="shapeTask"></div></li>
        <li><div id="shapeSubTask"></div></li>
        <li><div id="shapeLink"></div></li>
      </ul><br>
    </div>
    <div class="col-sm-8 text-left" id="canvas" style="height: 100%"></div>
    <div class="col-sm-2 sidenav">
      <div class="well">
        <p></p>
      </div>
      <div class="well">
        <p></p>
      </div>
    </div>
  </div>
</div>
<footer id="footer" class="container-fluid text-center">
  <p>Footer Text</p>
</footer>
</body>
</html>