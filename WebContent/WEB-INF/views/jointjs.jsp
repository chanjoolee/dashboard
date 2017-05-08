<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/dashboard/js/jointjs/joint.css" />
    <script src="/dashboard/js/jointjs/jquery.min.js"></script>
    <script src="/dashboard/js/jointjs/lodash.min.js"></script>
    <!-- <script src="/dashboard/js/jointjs/backbone-min.js"></script> -->
    <script src="/dashboard/js/jointjs/backbone.js"></script>
    <script src="/dashboard/js/jointjs/joint.js"></script>
    <script src="/dashboard/js/test/test.js"></script>
</head>
<body>
	<div id="myholder"></div>
	<div id="myholder-small"></div>
	<script type="text/javascript">
	var graph = new joint.dia.Graph;
// 	graph.on('all', function(eventName, cell) {
// 	    console.log(arguments);
// 	});

    var paper = new joint.dia.Paper({
        el: $('#myholder'),
        width: 1000,
        height: 700,
        model: graph,
        gridSize: 1
    });
    
    var paperSmall = new joint.dia.Paper({
        el: $('#myholder-small'),
        width: 1000,
        height: 700,
        model: graph,
        gridSize: 1
    });
    paperSmall.scale(.5);
    paperSmall.$el.css('pointer-events', 'none');

    var rect = new joint.shapes.basic.Rect({
        position: { x: 100, y: 30 },
        size: { width: 100, height: 30 },
        attrs: { rect: { fill: 'blue' }, text: { text: 'my box', fill: 'white' } }
    });
    
//     rect.on('change:position', function(element) {
//         console.log(element.id, ':', element.get('position'));
//     });

    var rect2 = rect.clone();
    rect2.translate(300);

    var link = new joint.dia.Link({
        source: { id: rect.id },
        target: { id: rect2.id }
    });
    

    graph.addCells([rect, rect2, link]);
    
    
    
   
    
	</script>
</body>
</html>