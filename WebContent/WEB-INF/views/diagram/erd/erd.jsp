<!DOCTYPE html>
<html lang="en">
<head>
	<title>Bootstrap Example</title>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		
		<script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
		<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
		<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
		<script src="/dashboard/js/maxcdn/bootstrap/3.3.6/js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="/dashboard/js/maxcdn/bootstrap/3.3.6/css/bootstrap.min.css">
		
		
		<link rel="stylesheet" href="/dashboard/js/jointjs/joint.min.css" />
		
		<link rel="stylesheet" type="text/css" href="/dashboard/js/jointjs/demos/rappid/build/rappid.css">
		<link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/header.css" rel="stylesheet"/>
		<link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/toolbar.css" rel="stylesheet"/>
		<link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/statusbar.css" rel="stylesheet"/>
		<link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/paper.css" rel="stylesheet"/>
		<link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/preview.css" rel="stylesheet"/>
		<link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/tooltip.css" rel="stylesheet"/>
		<link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/snippet.css" rel="stylesheet"/>
		<link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/dialog.css" rel="stylesheet"/>
		<link href="/dashboard/js/jointjs/demos/rappid/apps/QAD/css/index.css" rel="stylesheet"/>

		<script src="/dashboard/js/jointjs/lodash.4.17.5.js"></script>
		<script src="/dashboard/js/jointjs/demos/rappid/node_modules/backbone/backbone.js"></script>
		<script src="/dashboard/js/jointjs/demos/rappid/build/rappid.src.18.01.js"></script>

		<!-- File Saver -->
		<script type="text/javascript" src="/dashboard/js/FileSaver.js/FileSaver.js" charset="utf-8"></script>
		<script type="text/javascript" src="/dashboard/js/jquery-zclip-master/jquery.zclip.js"></script>
		
		<!-- recat -->
		<script  src="/dashboard/js/react-0.14.3/build/react.js"></script>
		<script  src="/dashboard/js/react-0.14.3/build/react-dom.js"></script>
		<script  src="/dashboard/js/react-0.14.3/build/react-with-addons.js"></script>
		<script  src="/dashboard/js/react-0.14.3/browser.js" ></script>
  
  
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
	    /* background: #3498DB; */
	    /* Make sure events are propagated to the JointJS element so, e.g. dragging works.*/
	    pointer-events: none;
	    -webkit-user-select: none;
	    border-radius: 4px;
	    border: 2px solid #2980B9;
	    /* box-shadow: inset 0 0 5px black, 2px 2px 1px gray; */
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
	    left: -5px;
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

	.html-element button.add {
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
	    right: -5px;
	    padding: 0;
	    margin: 0;
	    font-weight: bold;
	    cursor: pointer;
	}
	.html-element button.add:hover {
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
	.html-element .entity-title {
		height: 30px;
		padding: 6px 8px;
		color: #2D2D2D;
		text-align: center;
		border-bottom: 1px solid #8AA0AA;
		box-sizing: border-box;
		-moz-box-sizing: border-box;
		-webkit-box-sizing: border-box;
		border-top-left-radius: 3px;
		border-top-right-radius: 3px;
		background: #CBE6FD linear-gradient(to bottom, #F4FAFF 0%, #CBE6FD 100%);
		filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0, startColorstr=#F4FAFF, endColorstr=#CBE6FD);
		-moz-transition: border-color linear 200ms;
		-o-transition: border-color linear 200ms;
		-webkit-transition: border-color linear 200ms;
		transition: border-color linear 200ms;
	}
	.html-element label {
	    color: #333;
	    text-shadow: 1px 0 0 lightgray;
	    font-weight: bold;
	}
	.html-element span {
	    /* position: absolute; */
	    /* top: 2px; */
	    /* right: 9px; */
	    color: rgb(20, 130, 233);
	    font-size: 10px;
	}
	.joint-paper.joint-theme-default {
	    background-color: transparent;
	}
  </style>
  <style title="custom">
	
  </style>
  <script type="text/javascript">
		var schema = {}  ;
		var schema_str = "";
		  _.templateSettings = {
		    interpolate: /\<\@\=(.+?)\@\>/gim,
		    evaluate: /\<\@(.+?)\@\>/gim,
		    escape: /\<\@\-(.+?)\@\>/gim
		};
	  // custom 
	 	joint.shapes.html = {};
	    joint.shapes.html.Element = joint.shapes.basic.Rect.extend({
			// markup: '<rect class="body"/><text class="question-text"/><g class="options"></g><path class="btn-add-option" d="M5,0 10,0 10,5 15,5 15,10 10,10 10,15 5,15 5,10 0,10 0,5 5,5z"/>',
    		// markupMinus: '<g class="option"><rect class="option-rect"/><path class="btn-remove-option" d="M0,0 15,0 15,5 0,5z"/><text class="option-text"/></g>',
	        defaults: joint.util.deepSupplement({
	            type: 'html.Element',
	            attrs: {
	                rect: { stroke: 'none', 'fill-opacity': 0 }
	            }
	        }, joint.shapes.basic.Rect.prototype.defaults)
	    });
	  
	    joint.shapes.html.ElementView = joint.dia.ElementView.extend({
			template: [
	            '<div class="html-element">',
	            '<button class="delete">x</button>',
	            '<button class="add">+</button>',
				// '<input class="title" type="text" value="" />',
				'<div class="entity-title" style="overflow:hidden">',
				// '<span>Table Name</span>',
				'</div>',	
	            '<div class="entity-container" style="overflow:hidden">',	            
	            '</div>',
	            '</div>'
	        ].join(''),
			initialize: function() {
	            _.bindAll(this, 'updateBox');
	            joint.dia.ElementView.prototype.initialize.apply(this, arguments);
				
				this.expand = false;
				this.expandPosition = null;
				this.$box = $(_.template(this.template)());
				var model = this.model;

				if(this.model.get("column_names") == undefined)
	            	this.model.set('column_names', []);
				else{
					// load from json
					var v_model = this.model;
					var $box = this.$box;
					$.each(this.model.get("column_names"),function(i,col){
						var el = $(document.createElement("div"));
						el.attr("id",col.col_index);
						el.addClass("column-contents");
						$box.find("div.entity-container").append(el);

						var colOption = col;
						col.fn_submit = function(){
							var v_cols = v_model.get("column_names");
							col.column_name = this.state.column_name;
							v_model.set("column_names" , v_cols );
						};
						col.fn_delete = function(){
							var v_cols = v_model.get("column_names");
							var removed = _.remove(v_cols,function(c){
								return c.col_index == col.col_index;
							});
							v_model.set("column_names" , v_cols );
							var node = ReactDOM.findDOMNode(this);
							ReactDOM.unmountComponentAtNode(el[0]);
							el.remove();
						}
						var react = window.fn_column(el[0], colOption );
						colOption.react = react;
						colOption.el = el[0];

						// var cols = v_model.get("column_names");
						// cols.push(colOption);
						// v_model.set("column_names",cols);
					});
				}
	            
				
				this.$box.find(".entity-container").sortable(
					{
						revert: true
						, update: function( event, ui ) {
							var column_names = $(this).find(".column-contents");
							var cols = model.get("column_names");
							var cols1 = [];
							$.each(column_names,function(i,col){
								var col_model = _.find(cols, {col_index: $(col).attr("id")} );
								cols1.push(col_model);
							});
							model.set("column_names",cols1);
						}
					}
				);
	            //// Prevent paper from handling pointerdown.
	            //this.$box.find('input,select').on('mousedown click', function(evt) {
	            //    evt.stopPropagation();
	            //});
	            this.$box.find('div[name=div_column_name]').on('mousedown click dblclick', function(evt) {
	                evt.stopPropagation();
	            });

				// table_name Start
				// var elHeader = $(document.createElement("div"));
				var elHeader = this.$box.find("div.entity-title");
				var reactHeaderOption = {
					// markupMinus : this.model.markupMinus,
					table_name : this.model.get('table_name') != undefined ? this.model.get('table_name') : 'TableName',
					editable: true,
					mode: "read",
					edit_style: {
						width: "100%",
						height: "20px"
					},
					fn_submit: function(){
						model.set("table_name" , this.state.table_name );
					}
				};
				var reactHeader = window.fn_tableHeader(elHeader[0], reactHeaderOption );
				reactHeaderOption.react = reactHeader;
				reactHeaderOption.el = elHeader[0];
				//this.$box.find("div.entity-title").append(elHeader);
				this.model.set('table_name', reactHeaderOption.table_name);
				// table_name End


	            //this.$box.find('select').on('change', _.bind(function(evt) {
	            //    this.model.set('select', $(evt.target).val());
	            //}, this));
	            //this.$box.find('select').val(this.model.get('select'));
	            this.$box.find('button.delete').on('click', _.bind(this.model.remove, this.model));
	            this.$box.find('button.add').on('click', _.bind(function(evt) {
	                var el = $(document.createElement("div"));	                
	                el.attr("name","div_column_name");
					var col_index_max = _.maxBy(this.model.get("column_names"),function(o){
						// return o.col_index;
						return parseInt(o.col_index.match(/_([\d]+)\b/)[1])
					});
					var col_index1 = 0;
					if(col_index_max == undefined)
						col_index1 = 1;
					else
						col_index1 = parseInt(col_index_max.col_index.match(/_([\d]+)\b/)[1]) +1;

	                // index
					// var col_index = this.$box.find("[name=div_column_name]").length + 1;
	                var col_index = "column_" + col_index1;
	                el.attr("id",col_index);
	                //el.css("cursor","pointer");
	                
	                //var column_names = this.model.get("column_names");
	                //column_names.push({
	                //	column_name: "",
	                //	column_id : col_index
	                //});
	                
	                el.addClass("column-contents");
	                this.$box.find("div.entity-container").append(el);
	                el.dblclick(function(){
						// console.log("dblclick");
					});
	                
	                el.click(function(){
						// console.log("dblclick");
					});
					// start. react
					var v_model = this.model;
	                var colOption = {
						// markupMinus : this.model.markupMinus,
						column_name : col_index,
	                	col_index : col_index,
	                	editable: true,
	                	mode: "read",
	                	edit_style: {
	                		width: "90px"
						},
						fn_submit: function(){
							var v_cols = v_model.get("column_names");
							var v_col = _.find(v_cols,{col_index: col_index});
							v_col.column_name = this.state.column_name;
							v_model.set("column_names" , v_cols );
						},
						fn_delete: function(){
							var v_cols = v_model.get("column_names");
							var v_col = _.find(v_cols,{col_index: col_index});
							var removed = _.remove(v_cols,function(c){
								return c.col_index == v_col.col_index;
							});
							v_model.set("column_names" , v_cols );
							var node = ReactDOM.findDOMNode(this);
							ReactDOM.unmountComponentAtNode(el[0]);
							el.remove();
						}
	                	
					};
					
					
					var react = window.fn_column(el[0], colOption );
					colOption.react = react;
					colOption.el = el[0];
					

					var cols = this.model.get("column_names");
					cols.push(colOption);
	                this.model.set("column_names",cols);
					

	                // end. react
	                
	                //// size
	                //var bbox = this.model.getBBox();
	                //var boxW = bbox.width;
	                //var boxH = bbox.height;
	                //var newH = 0;
	                //this.$box.find("div.column-contents").each(function(i,el){
	                //	var h = parseInt($(el).css("height").match(/[\d]+/g)[0]);
	                //	newH += h +4;
	                //});
	                //this.$box.find("div.entity-container").css("height",newH+"px");
	                //this.model.set({"size":{width:boxW,  height:Math.max(newH, boxH )}});	                
	                //this.updateBox();
	                
					// var h = parseInt(this.$box.css("height").match(/[\d]+/g)[0])-20;
					var h_title = this.$box.find("div.entity-title").outerHeight();
					var h = this.$box.outerHeight() -  h_title -5 ;
	                this.$box.find("div.entity-container").css("height", h + "px");
	                
	                
	                el.on('focusin', _.bind(function(evt) {
	                	// $(evt.target).data('old_val', $(evt.target).val());
	                	// console.log("focusin");
		            }, this));
		            el.on('change', _.bind(function(evt) {
		            	//var oldval = $(evt.target).data('val');
		                //var newval = $(evt.target).val();
		                
		            	//var col_id = $(evt.target).attr("id");
		            	//var column_names = this.model.get("column_names");
		            	//var filters = column_names.filter(function(col){
		                //	return col.column_id == col_id;
		                //});
		                //if(filters.length > 0){
		                //	filters[0].column_name = newval;
		                //}
		                
		            }, this));
		            
	               
	            }, this));
	            //// Update the box position whenever the underlying model changes.
	            this.model.on('change', this.updateBox, this);
	            //// Remove the box when the model gets removed from the graph.
	            this.model.on('remove', this.removeBox, this);
				this.model.on('add', this.addInput, this);
				


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
				$.each(this.model.get("column_names"),function(i,col){
					ReactDOM.unmountComponentAtNode(col.el);
				});
				ReactDOM.unmountComponentAtNode(this.$box.find("div.entity-title")[0]);
				this.$box.remove();
				
	        },
	        addInput: function(evt) {
	            var a = "aaa";
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
					var h_title = this.$box.find("div.entity-title").outerHeight();
					this.$box.find("div.entity-container").css("height", ( (mod_h - h_title - 3 )  + "px"));	
						
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


			$("#btn_file_open").change(function(){
				
				var file = this.files[0];
				var _schemaStr = "";
				var reader = new FileReader();
				reader.onload = function(progressEvent){
					var lines = this.result.split('\n');
					for(var line = 0; line < lines.length; line++){
						//console.log(lines[line]);
						_schemaStr += lines[line];
					}
					_schema = JSON.parse(_schemaStr);
					graph.fromJSON(_schema);
				};
				reader.readAsText(file);
				
			});
		});
		function resize() {
			var height = window.innerHeight
				- $("#nav").height() 
				- parseInt($("#nav").css("padding-top"))
				- parseInt($("#nav").css("padding-bottom"))
				
				// - $("#footer").height()
				- 30
				- parseInt($("#footer").css("padding-top"))
				- parseInt($("#footer").css("padding-bottom"))
				- 5
				;			
			$("#center").height(height);
			
			var contentWidth = $(".content").width();
			// $(".col-sm-2").css("width","150px");
			//$(".col-sm-10").width( contentWidth - 150 - 30 );
			$(".col-sm-2").css("width","150px");
			$(".col-sm-10").css("width", (contentWidth - 150 - 30) + 'px' );
			// console.log("resize");

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
			
			$("#canvas").keydown(function(e){
				if(paper.currentBox != undefined){
					// shot-cut key ==> add column
				}
			});
			
			// paper = new joint.dia.Paper({graph.on('all', function(eventName, cell) {
		 	    // console.log(arguments);
		 	// });
	  	        
			paper.on('cell:pointerdblclick', 
				function(cellView, evt, x,y ) {
					console.log('cell view ' + cellView.model.id + ' was clicked'); 
					//evt.stopPropagation();
				}
			);
			paper.on('cell:pointerdown', function(cellView, evt, x, y) {
			    var bbox = cellView.getBBox();
				var strokeWidth = cellView.model.attr('rect/stroke-width') || 1;
				
				paper.currentBox = cellView.$box;
				// console.log(isBorderClicked(bbox, x, y, strokeWidth))
				// console.log(strokeWidth);
			    
			
			    // cellView.highlight(
		   		// null ,//defaults to cellView.el  
		   		// {
		        // highlighter: {
		        //     name: 'stroke',
		        //     options: {
		        //         //padding: 10,
		        //         //rx: 5,
		        //         //ry: 5,
		        //         attrs: {
		        //             'stroke-width': 3,
		        //             stroke: '#FF0000'
		        //         }
		        //     }
				// }
				
			}); 
			    
		}
		
		function initShapeMenu(){
			// // 01. start
			// var start_graph = new joint.dia.Graph;
			// var start_paper = new joint.dia.Paper({
	  	    //     el: $('#shapeStart'),
	  	    //     width: 100,
	  	    //     height: 40,
	  	    //     model: start_graph,
	  	    //     gridSize: 1
	  	    // });
			
			// var start_rect = new joint.shapes.basic.Ellipse({
		    //     position: { x: 0, y: 0 },
		    //     size: { width: 30, height: 30 },
		    //     attrs: { ellipse: { fill: 'green' }, text: { text: 'start', fill: 'white' } }
		        
		    // });
			
			// start_graph.addCells([start_rect]);
			
			// // 02. task
			// var task_graph = new joint.dia.Graph;
			// var task_paper = new joint.dia.Paper({
	  	    //     el: $('#shapeTask'),
	  	    //     width: 100,
	  	    //     height: 40,
	  	    //     model: task_graph,
	  	    //     gridSize: 1
	  	    // });
			
			// var task_rect = new joint.shapes.basic.Rect({
		    //     position: { x: 0, y: 0 },
		    //     size: { width: 60, height: 30 },
		    //     attrs: { rect: { fill: 'skyblue' }, text: { text: 'task', fill: 'black' } }
		    // });
			
			// task_graph.addCells([task_rect]);
			
			// // 03. subTask
			// var subTask_graph = new joint.dia.Graph;
			// var subTask_paper = new joint.dia.Paper({
	  	    //     el: $('#shapeSubTask'),
	  	    //     width: 100,
	  	    //     height: 40,
	  	    //     model: subTask_graph,
	  	    //     gridSize: 1
	  	    // });
			
			// var subTask_rect = new joint.shapes.basic.Rect({
		    //     position: { x: 0, y: 0 },
		    //     size: { width: 60, height: 30 },
		    //     attrs: { rect: { fill: 'skyblue' }, text: { text: 'subTask', fill: 'black' } }
		    // });
			
			// subTask_graph.addCells([subTask_rect]);
			
			// // 04. link
			// var link_graph = new joint.dia.Graph;
			// var link_paper = new joint.dia.Paper({
	  	    //     el: $('#shapeLink'),
	  	    //     width: 100,
	  	    //     height: 40,
	  	    //     model: link_graph,
	  	    //     gridSize: 1
	  	    // });
			
			// var link_rect = new joint.shapes.basic.Rect({
		    //     position: { x: 0, y: 0 },
		    //     size: { width: 60, height: 30 },
		    //     attrs: { rect: { fill: 'green' }, text: { text: 'link', fill: 'white' } }
		    // });
			
			// link_graph.addCells([link_rect]);
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
			
			
			//var vx = event.screenX;
			//var vy = event.screenY;
			
			var vx = event.clientX - $(".col-sm-2.sidenav").outerWidth();
			var vy = event.clientY - $("#myNavbar").outerHeight();
			
			
			var rect = new joint.shapes.html.Element({
		        //position: { x: 80, y: 80 },
		        position: { x: vx, y: vy },
		        size: { width: 170, height: 100 }
		        //label: 'I am HTML',
		        //select: 'one'
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
			var vx = event.clientX - $(".col-sm-2.sidenav").outerWidth();
			var vy = event.clientY - $("#myNavbar").outerHeight();
			var link = new joint.dia.Link({
			    position: { x: vx, y: vy },
				// source: { x: 170, y: 20 },
				source: { x: vx, y: vy },  
				target: { x: vx + 200 , y: vy },
				router: { name: 'manhattan' },
				connector: { name: 'rounded' },
				attrs: {
					'.marker-target': {
						d: 'M 10 0 L 0 5 L 10 10 z',
						fill: '#6a6c8a',
						stroke: '#6a6c8a'
					},
					'.connection': {
						stroke: '#6a6c8a',
						strokeWidth: 2
					}
				}
			    // , attrs: {
			    //     // Define a filter for the whole link (special selector '.' means the root element )
			    //     '.': { filter: { name: 'dropShadow', args: { dx: 1, dy: 1, blur: 2 } } },
			    //     '.connection': {
			    //         'stroke-width': 5, stroke: '#34495E'
			    //     },
			    //     //'.marker-source': { stroke: '#E74C3C', fill: '#E74C3C', d: 'M 10 0 L 0 5 L 10 10 z' },
			    //     '.marker-target': { stroke: '#E74C3C', fill: '#E74C3C', d: 'M 10 0 L 0 5 L 10 10 z' }
			    // }
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
		
		function fn_save(){
			schema = graph.toJSON();
			schemaStr = JSON.stringify(schema,function(k,v){
				// console.log(k);
				// console.log(v);
				// if( typeof v == 'function'){
				// 	return v + '';
				// }
				if(["el","react"].includes(k))
					return undefined;

				return v;
			});
			
			var filename = "schema";
			var blob = new Blob([schemaStr], {type: "text/plain;charset=utf-8"});
			saveAs(blob, filename+".json");

		}

		function fn_fromJson(){
			graph.fromJSON(schema);
			
		}

		function fn_file_open(){
			$("#btn_file_open").val("");
			$("input#btn_file_open").trigger("click");
		}

		function fn_clear_canvas(){
			graph.clear();
		}

		
		
	</script>
</head>
<body>
<form name="form" id="form" class="">
	<input type="file" id="btn_file_open" name="btn_file_open" style="display: none" />
</form>
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
			<li><a href="#" onclick="fn_save();">Save</a></li>
			<li><a href="#" onclick="fn_file_open();">Open</a></li>
			<li><a href="#" onclick="fn_clear_canvas();">Clear</a></li>
			
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

		<ul class="nav nav-pills nav-stacked" style="text-align: right;">
			<!-- <li><div id="shapeStart" style="width: 22px;display: inline-flex;"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABjklEQVR42mNgQAWMKjkuDsYTI9tslqRvsV+XdxWEQWzTydFtKpmO9iA1DNiAfIytpMnU2BbHzQVP/S61/A+60w3EPVDc/R8k5rAp/4nxtNhG8UA9MRTNKqG2ouazExe6Hqj4F3Cz8z8+DFIDUgvSA3e2wcSIBqc9pf98r7X9JwaD1IL0gL0D8pfNmqzHXpea/5OCrddkPQGHiV57cJfzkcr/7ufqScIgPXqdIW0MRtOit7ucqvnvepo0DNJjNDNmC4PJ3PhrTscr/5ODQXoZjGfFXbM/XPbf/giJGKgHpJdBd3LYFpv9Rf9tDhSThoF6QHoZ1Br92sy3ZP233FNAEgbp0WjwbWdQSLW115kV+cRsZ85/UrAuUA9ILyT9N/o06C6K+2e8NfM/MRikFqQHni9AyVKj3X+h9vyYfwYb0/7jw9rzo/+B1CInZbghSnUeDeqTg5/oLIv/r7s26b/uumQIBrJBYiA5kBqVUENRBhyAUSHR0l6p0q1dqd13i1p34DUQVgayQWIKibYY2RkAos/yw+96Nd0AAAAASUVORK5CYII=" width="16px" draggable="false"></div></li> -->
			<li>
				<div id="shapeTask" style="width: 22px;display: inline-flex;margin-right: 30px;cursor: pointer;">
					<img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABd0lEQVR42s2Ty0sCYRRH/Z/btmpRQbSxKCKhMirTpNTsaY1WjKbma2pyrCYFzZwcbdG7sdOQBS1msGU/OHz3XvjO4sJ1OH5F0/V0U297e+Gwi9PtJV4oEpdKiCZx6QIxf45YULqY9VFWJhg5wFKwEBZov0JVLVGrXFORs7TMvt7QuG3coT+D9thh6/DYWjAXjqEWz0i6B0lM93MqrJEPz5NaGOF4ZgAp4qf2ABsxG4ErIFC5N5CzKdSqxnXziXLrhfLdI1c3OlfmTG0bhKI2gslVgct7SKk6iyEB8bxGIJr+IlNuoegGStMgICSsBWP+fWQdjpQGU551nLM+xt1+ppbWGRidRNIMCg2D1X0bwejyLif19y63xnfdfTNmn755I1l9wRexEfQNOfHtHOLdPrDFsxljZiVoLQhFovRK5+MDQbRZYnBX6CkwOp3/LAjvxfhLovGktWB4wkUqL5HMFWxJZHJ4gpvWArl0yalywVkP6uZh/fz5BNGUa4KrplC7AAAAAElFTkSuQmCC" width="16px" draggable="false">
					<span><i>E</i>ntity</span>
				</div>
			</li>
			<!-- <li><div id="shapeSubTask"></div></li> -->
			<li>
				<div id="shapeLink" style="width: 22px; display: inline-flex;margin-right: 30px;cursor: pointer;">
					<img src="data:image/gif;base64,R0lGODlhEAAQAKIAALDH2fD0+ABLhaC80v///wAAAAAAAAAAACH5BAEAAAQALAAAAAAQABAAAAMiSLrc/gQE2IYAdNmR1e7E14kZSZkQ+qgO2wACBwYYaN9MAgA7" width="16px" draggable="false">
					<span><i>L</i>ink</span>
				</div>
			</li>
		</ul><br>
		</div>
		<div class="col-sm-10 text-left" id="canvas" style="height: 100%"></div>
		<!-- <div class="col-sm-2 sidenav"> -->
		<!-- <div class="well">
			<p></p>
		</div> -->
		<!-- <div class="well">
			<p></p>
		</div> -->
		</div>
	</div>
	</div>
	<footer id="footer" class="container-fluid text-center">
	<p>Footer Text</p>
	</footer>
</body>
<script type="text/babel">
	
	
	
	
	class Td extends React.Component {
		
		constructor(props) {
	        super(props);
	        // Configure default state
			this.state = this.props.options;
			//this.dblclick.bind(this);
			this.changeHandler = this.changeHandler.bind(this);
	    }
	    
	    dblclick(){
	    	//if(this.state.editable == true)
	    	//	this.setState({mode: "edit"});
	    }
	    
	    confirm(){
	    	this.props.options.fn_submit.call(this);
	    	this.setState({mode: "read"});
	    }
	    
	    cancel(){
	    	this.setState({value: this.props.options.value});
	    	this.setState({mode: "read"});
	    }
	    
	    changeHandler(e){
	    	//alert("changeHandler");
	    	this.setState({value: e.target.value });	    	
	    }
	    
	   
	    
	    render(){
	    	
	    	if(this.props.options.editable == false || this.state.mode == "read"){
	    		return(
				<div style={{width:"100%",height:"100%"}} onDoubleClick={this.dblclick.bind(this)}>
					{this.state.value}
				</div>
	        	);
	    	}else if(this.state.mode == "edit") {	  
	    		if(this.state.edit_tag == "textarea"){
	    			return (
			    		<div>
							<textarea style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value }/>;
						</div>
					);
	    		}else {
	    			return (
			    		<div>
							<input style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value}></input>
						</div>
					);
	    		}		
				
	    	}
	        
	            
	    }
	    
	}
	
	window.fn_td = function(cell, options){
		return ReactDOM.render(<Td options={options}/>, cell);
	}
	
	
	class Column extends React.Component {
		
		constructor(props,container) {
	        super(props);
	        // Configure default state
			this.state = this.props.options;
			//this.dblclick.bind(this);
			this.changeHandler = this.changeHandler.bind(this);
			this.container = container;
	    }
	    
	    dblclick(){
	    	// alert('aaaaa');
	    	if(this.state.editable == true){
	    		this.setState({mode: "edit"});
	    		
	    	}
	    		
	    }
		
		handleKeyPress(event){
			if(event.key == 'Enter'){
				//this.setState({mode: "read"});
				this.confirm();
			}
		}
		blurHandler(event){
			this.confirm();
			// console.log('blur');
		}

	    confirm(){
	    	this.props.options.fn_submit.call(this);
	    	this.setState({mode: "read"});
		}
		
		fn_delete(){
			this.props.options.fn_delete.call(this);
			// this.remove();
	    }
	    
	    cancel(){
	    	this.setState({column_name: this.props.options.column_name});
	    	this.setState({mode: "read"});
	    }
	    
	    changeHandler(e){
	    	//alert("changeHandler");
	    	this.setState({column_name: e.target.value });	    	
	    }
	    
	    
	    
	    render(){
	    	
	    	if(this.props.options.editable == false || this.state.mode == "read"){
	    		return(
						
						<div className="widget-contents" style={{width:"fit-content",height:"100%", cursor:"pointer", pointerEvents:"auto"}} onDoubleClick={this.dblclick.bind(this)} >
							<span className="glyphicon glyphicon-minus" 
								onClick={this.fn_delete.bind(this)} 
							></span>
							<img className="gwt-Image typeIcon"
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAxElEQVR42mNgoDZY9f8/86lrD/5jwyA5vJovvv6vDlN8+fU/FAwTB6khWTNBQ5Cd3T533X+H0DSsuLhjFnbvINsMUhSQWv6/bc76/55xBWCNIHZMYdP/uOJWFJegGABzZl7ztP/pNX1gdmh2DdgAELtu8rL/4Xn1KN7BasDcLcf+T19/EMOAFfsv/u9dvI2wAcgY2QBsAUpdA5ANWXngEkYgztl8FCM6sUYjOCY6Z2NEISgWkDVjpEqKEhJVkjJVMhM5AADzgio+6KAFDwAAAABJRU5ErkJggg=="
								style={{width:"16", height:"16"}}
							/>
							<img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABOklEQVR42mNgGN7gfz0D062ZBp0PV7udvj1VJ5lkA25M0ix4czL//+/PJ/8/3xX+9my7sgfRmm9O0017dTD27+8Pi/9/uNLw/83xuv93Fwd83Z6rFEmUAXcXWK3/+W7l/x/P6v7/eDHr/4eLdf+/PWr4f3OG/QeiDLg9w7jty93O/98eZP3//qj4/7f78f+/3Qr9f7be4jN+f0/WMXm4yvXU0x0B9z7djPv/7bbf/+93o/9/vQHU3KD3fXGkQiQeW/Vj7s2zOvft0cz/X+8E//920+3/mQnmX843m7641GL2Ylm8fDBe2x+udj//49nC/58uWfz/ds39/9kp1l9nRSslbfQT4T2SJMJL0N+P13mc/Pmy7f/Xm77/z0yy+jwnQSWWpHg/2WfSenW+68vTvVYPlmWohDGMDAAAQwSrOupcdgsAAAAASUVORK5CYII="
								className="keyIcon" 
								aria-hidden="true"
								style={{display:"none",width:"16", height:"16"}}
							/>
							<img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAQCAQAAACFdibLAAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQffBhcNNSocYAbvAAAAq0lEQVQY062PPQ4BQQCFv8GyN9Bu6EjcwA2UFBLRqPQSF9jGCTRbcACJQu0GIpGoNiq9YnfszP7M0kyoJV755eXLe/D/CFh2GfJwAl/Netko2e9OFVhdmZQtX4EI9SA8QwUgT7UECFR8v5RQA9Dk1vYUYGFCZqHkC4vUsdCAdcptNO43wZuqw6ep1nE92Xg6PZrA7oROW6ZRnlE4pmFutsmiql0EL4zL/Jfvb9WyP8r8UM2lAAAAAElFTkSuQmCC"
								className="uniqueIcon" 
								aria-hidden="true"
								style={{display:"none",width:"16", height:"16"}}
							/>
							<div 
								className="ebox feature-box widget-name"
								style={{display:"inline-block"}}
							>
								<div className="gwt-Label">{this.state.column_name}</div>
							</div>
	        			</div>
	        	);					

	    	}else if(this.state.mode == "edit") {	  
	    		return(
					<div style={{width:"100%",height:"100%"}} >
						<div className="widget-contents" >
							<img className="gwt-Image typeIcon"
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAxElEQVR42mNgoDZY9f8/86lrD/5jwyA5vJovvv6vDlN8+fU/FAwTB6khWTNBQ5Cd3T533X+H0DSsuLhjFnbvINsMUhSQWv6/bc76/55xBWCNIHZMYdP/uOJWFJegGABzZl7ztP/pNX1gdmh2DdgAELtu8rL/4Xn1KN7BasDcLcf+T19/EMOAFfsv/u9dvI2wAcgY2QBsAUpdA5ANWXngEkYgztl8FCM6sUYjOCY6Z2NEISgWkDVjpEqKEhJVkjJVMhM5AADzgio+6KAFDwAAAABJRU5ErkJggg=="
								style={{width:"16", height:"16"}}
							/>
							<img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABOklEQVR42mNgGN7gfz0D062ZBp0PV7udvj1VJ5lkA25M0ix4czL//+/PJ/8/3xX+9my7sgfRmm9O0017dTD27+8Pi/9/uNLw/83xuv93Fwd83Z6rFEmUAXcXWK3/+W7l/x/P6v7/eDHr/4eLdf+/PWr4f3OG/QeiDLg9w7jty93O/98eZP3//qj4/7f78f+/3Qr9f7be4jN+f0/WMXm4yvXU0x0B9z7djPv/7bbf/+93o/9/vQHU3KD3fXGkQiQeW/Vj7s2zOvft0cz/X+8E//920+3/mQnmX843m7641GL2Ylm8fDBe2x+udj//49nC/58uWfz/ds39/9kp1l9nRSslbfQT4T2SJMJL0N+P13mc/Pmy7f/Xm77/z0yy+jwnQSWWpHg/2WfSenW+68vTvVYPlmWohDGMDAAAQwSrOupcdgsAAAAASUVORK5CYII="
								className="keyIcon" 
								aria-hidden="true"
								style={{display:"none",width:"16", height:"16"}}
							/>
							<img
								src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAoAAAAQCAQAAACFdibLAAAAAmJLR0QA/4ePzL8AAAAJcEhZcwAACxMAAAsTAQCanBgAAAAHdElNRQffBhcNNSocYAbvAAAAq0lEQVQY062PPQ4BQQCFv8GyN9Bu6EjcwA2UFBLRqPQSF9jGCTRbcACJQu0GIpGoNiq9YnfszP7M0kyoJV755eXLe/D/CFh2GfJwAl/Netko2e9OFVhdmZQtX4EI9SA8QwUgT7UECFR8v5RQA9Dk1vYUYGFCZqHkC4vUsdCAdcptNO43wZuqw6ep1nE92Xg6PZrA7oROW6ZRnlE4pmFutsmiql0EL4zL/Jfvb9WyP8r8UM2lAAAAAElFTkSuQmCC"
								className="uniqueIcon" 
								aria-hidden="true"
								style={{display:"none",width:"16", height:"16"}}
							/>
							<div 
								className="ebox feature-box widget-name"
								style={{display:"inline-block"}}
							>
								<input style={this.props.options.edit_style} 
									onChange={this.changeHandler.bind(this)} 
									value={this.state.column_name}
									onKeyPress={this.handleKeyPress.bind(this)} 
									onBlur={this.blurHandler.bind(this)} 
								></input>
							</div>
						</div>
					</div>
	        	);
				
	    	}
	        
	            
	    }
	    
	}
	
	window.fn_column = function(cell, options){
		return ReactDOM.render(<Column options={options}/>, cell);
	}
	

	class TableHeader extends React.Component {
		
		constructor(props,container) {
	        super(props);
	        // Configure default state
			this.state = this.props.options;
			//this.dblclick.bind(this);
			this.changeHandler = this.changeHandler.bind(this);
			this.container = container;
	    }
	    
	    dblclick(){
	    	// alert('aaaaa');
	    	if(this.state.editable == true){
	    		this.setState({mode: "edit"});
	    	}
	    }
		
		handleKeyPress(event){
			if(event.key == 'Enter'){
				//this.setState({mode: "read"});
				this.confirm();
			}
		}
		blurHandler(event){
			this.confirm();
			// console.log('blur');
		}

	    confirm(){
	    	this.props.options.fn_submit.call(this);
	    	this.setState({mode: "read"});
		}		
	    
	    cancel(){
	    	this.setState({table_name: this.props.options.table_name});
	    	this.setState({mode: "read"});
	    }
	    
	    changeHandler(e){
	    	//alert("changeHandler");
	    	this.setState({table_name: e.target.value });	    	
	    }    
	    
		componentDidMount(){
			//this.nameInput.focus(); 
			var aaa = "aaaa";
		}
		componentDidUpdate(prevProps, prevState){
			//var aaa = "aaaa";
			//console.log("componentDidUpdate");
			if(this.nameInput != null && prevState.mode == "read"){
				this.nameInput.focus();
				this.nameInput.select();
			}
				
		}
	    
	    render(){
	    	
	    	if(this.props.options.editable == false || this.state.mode == "read"){
	    		return(
					<div className="widget-contents" style={{width:"",height:"100%", cursor:"pointer", pointerEvents:"auto"}} onDoubleClick={this.dblclick.bind(this)} >
					<div className="gwt-Label">{this.state.table_name}</div>
					</div>
	        	);					

	    	}else if(this.state.mode == "edit") {	  
	    		return(
					<div style={{width:"100%"}} >
						<input style={this.props.options.edit_style} 
							onChange={this.changeHandler.bind(this)} 
							value={this.state.table_name}
							onKeyPress={this.handleKeyPress.bind(this)} 
							onBlur={this.blurHandler.bind(this)} 
							ref={(input) => { this.nameInput = input; }} 
						></input>
					</div>
	        	);
				
	    	}
	        
	            
	    }
	    
	}
	window.fn_tableHeader = function(cell, options){
		return ReactDOM.render(<TableHeader options={options}/>, cell);
	}
	
</script>
</html>
<%--
graph.attributes.cells.models
--%>