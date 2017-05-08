<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>HTML5 Canvas</title>
<!--[if IE]><script src="excanvas.js"></script><![endif]-->
<script>
 
window.onload = function() {
 
    // Get the canvas element and its drawing context
    var canvas = document.getElementById('c');
    var context = canvas.getContext('2d');
 
    /*
    |---------------------
    | Origin: Top Left
    | End: Bottom Right
    |---------------------
    */
 
    context.beginPath();
    context.moveTo(0, 0);
    context.lineTo(200, 200);
    context.stroke();
 
    /*
    |---------------------
    | Origin: Top Middle
    | End: Bottom Middle
    |---------------------
    */
 
    context.save();
    context.beginPath();
    context.moveTo(100, 0);
    context.lineTo(100, 200);
    context.stroke();
    context.restore();
 
    /*
    |---------------------
    | Origin: Top Right
    | End: Bottom Left
    |---------------------
    */
 
    context.save();
    context.beginPath();
    context.moveTo(200, 0);
    context.lineTo(0, 200);
    context.stroke();
    context.restore();
 
    /*
    |---------------------
    | Origin: Middle Left
    | End: Middle Right
    |---------------------
    */
 
    context.save();
    context.beginPath();
    context.moveTo(0, 100);
    context.lineTo(200, 100);
    context.stroke();
    context.restore();
 
};
 
</script>
</head>
<body>
<canvas id="c" style="border: 1px solid #F00;" width="200" height="200"></canvas>
</body>
</html>