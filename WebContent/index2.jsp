<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>DashBoard</title>
<script src="js/jquery/jquery-1.11.2.min.js"></script>
<script src="js/jquery/jquery.popupWindow.js"></script>
<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>

	<!--<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">-->
    <!-- link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">  -->
	<!--<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>-->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" crossorigin="anonymous">
	
	
    
	<script type="text/javascript">

	
	$(function () {

		
		$('li.dropdown-submenu').on('click', function(event) {
		      event.stopPropagation(); 
		      if ($(this).hasClass('open')){
		          $(this).removeClass('open');
		      }else{
		          $('li.dropdown-submenu').removeClass('open');
		          $(this).addClass('open');
		     }
		});
	});
	
	function windowOpen(){
		var pop = window.open('dashboard.html','_blank',
				'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1024,height=768');
		//pop.moveTo(0,0);
		//pop.resizeTo(screen.width,screen.height-100);
		
		//$( "#dialog" ).dialog();
	}
	   
	function compare(target,obj1,obj2){	
		for( o in obj2){
			if(typeof obj2[o] != 'undefined' && typeof obj1[o] == 'undefined'){
				target[o] = {as:undefined,is:obj2[o]};
			}else if(typeof obj2[o] == 'object' && !isEqual(obj1[o] , obj2[o]) && isArray(obj2[o]) ){
				target[o] = compare([],obj1[o],obj2[o]);
			}else if(typeof obj2[o] == 'object' && !isEqual(obj1[o] , obj2[o]) && !isArray(obj2[o]) ){
				target[o] = compare({},obj1[o],obj2[o]);
			}else if(typeof obj2[o] == 'string' && obj1[o] != obj2[o]){
				target[o] = {was:obj1[o],is:obj2[o]};
			}
		}
		return target;
	}
//test
	function isEqual(obj1,obj2){
		var eq = true;
		for( item in obj2){
			if(typeof obj2[item] != 'undefined' && typeof obj1[item] == 'undefined'){
				eq = false;
			}else if(typeof obj2[item] == 'object'){
				eq = isEqual(obj1[item],obj2[item]);
			}else if(typeof obj2[item] == 'string' ){
				eq = (obj1[item] == obj2[item]);
			}else if(typeof obj2[o] == 'numbers' ){
				eq = (obj1[item] == obj2[item]);
			}
			if(!eq) break;
		}
		return eq;
	}
	
	function isArray(myArray) {
	    return myArray.constructor.toString().indexOf("Array") > -1;
	}
	
	
	function dashboardShow(target,action){
		
		var oFrm = document.getElementById("form1");
		
		var target = target;
		oFrm.action =  action;
		oFrm.method = "post";
		oFrm.target = target; 
	    oFrm.submit();
		
	}
	
	function gotoPhaseCauseList(){
	    window.open('/dashboard/jiraIssuePhaseCauseList.html?sender=confluence','_blank',
		'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=800,height=768');
		//var oFrm = document.getElementById("form1");
		
		//oFrm.action =  "/dashboard/jiraIssuePhaseCauseList.html";
		//oFrm.method = "post";
		//oFrm.target = "_blank"; 
	    //oFrm.submit();
	}
	
	function gotoCauseMatrixList(){
	    window.open('/dashboard/jiraIssueCauseMatrixList.html?sender=confluence','_blank',
		'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1000,height=320');
		//var oFrm = document.getElementById("form1");
		
		//oFrm.action =  "/dashboard/jiraIssuePhaseCauseList.html";
		//oFrm.method = "post";
		//oFrm.target = "_blank"; 
	    //oFrm.submit();
	}
	
	function gotoCauseStatusList(){
	    window.open('/dashboard/jiraIssueCauseStatusList.html?sender=confluence','_blank',
		'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1024,height=608');
		//var oFrm = document.getElementById("form1");
		
		//oFrm.action =  "/dashboard/jiraIssuePhaseCauseList.html";
		//oFrm.method = "post";
		//oFrm.target = "_blank"; 
	    //oFrm.submit();
	}
	
	</script>
	<style type="text/css">
		.dropdown-submenu {
		    position: relative;
		}

		.dropdown-submenu > .dropdown-menu {
		    top: 0;
		    left: 100%;
		    margin-top: -6px;
		    margin-left: -1px;
		    -webkit-border-radius: 0 6px 6px 6px;
		    -moz-border-radius: 0 6px 6px;
		    border-radius: 0 6px 6px 6px;
		}

		.dropdown-submenu .open  > .dropdown-menu {
		    display: block;
		}
		.dropdown-submenu > a:after {
		    display: block;
		    content: " ";
		    float: right;
		    width: 0;
		    height: 0;
		    border-color: transparent;
		    border-style: solid;
		    border-width: 5px 0 5px 5px;
		    border-left-color: #ccc;
		    margin-top: 5px;
		    margin-right: -10px;
		}

		.dropdown-submenu .open  > a:after {
		    border-left-color: #fff;
		}

		.dropdown-submenu.pull-left {
		    float: none;
		}

		.dropdown-submenu.pull-left > .dropdown-menu {
		    left: -100%;
		    margin-left: 10px;
		    -webkit-border-radius: 6px 0 6px 6px;
		    -moz-border-radius: 6px 0 6px 6px;
		    border-radius: 6px 0 6px 6px;
		}
	</style>
</head>
<body>
<form name="form1" id="form1">
<input type="hidden" name="sender" value="confluence"/>

<nav class="navbar navbar-default navbar-static-top">
      <div class="container-fluid">
	    <!-- Brand and toggle get grouped for better mobile display -->
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
	        <span class="sr-only">Toggle navigation</span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	        <span class="icon-bar"></span>
	      </button>
	      <a class="navbar-brand" href="#">
	      <img alt="JCR" src=""></a>
	    </div>

	    <!-- Collect the nav links, forms, and other content for toggling -->
	    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
	      <ul class="nav navbar-nav">
	      	<li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Opt1 Level 1 <span class="caret"></span></a>
	          <ul class="dropdown-menu">

	          	<li class="dropdown-submenu">
	                <a tabindex="-1" href="#">Opt1-1 Level 2</a>
	                <ul class="dropdown-menu">
	                  <li><a tabindex="-1" href="#">Op1-1 1</a></li>
	                  
	                  <li><a href="#">Opt1-1 2 </a></li>
	                  <li><a href="#">Opt1-1 3 </a></li>
	                </ul>
	              </li>
	            <li><a href="#">Opt1-2</a></li>
	            <li><a href="#">Opt1-3</a></li>
	            <li role="separator" class="divider"></li>
	            <li><a href="#">Opt1-last</a></li>
	          </ul>
	        </li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Opt2 Level 1 <span class="caret"></span></a>
	          <ul class="dropdown-menu ">
	            <li><a href="#">Opt2-1</a></li>
	            <li><a href="#">Opt2-2</a></li>
	            <li><a href="#">Opt2-3</a></li>
	            <li role="separator" class="divider"></li>
	            <li><a href="#">Opt2-last</a></li>
	          </ul>
	        </li>
	        <li class="dropdown">
	          <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Opt3 Level 1 <span class="caret"></span></a>
	          <ul class="dropdown-menu">
	            <li><a href="#">Op3-1</a></li>
	            <li><a href="#">Op3-2</a></li>
	            <li><a href="#">Op3-3</a></li>
	            <li role="separator" class="divider"></li>
	            <li><a href="#">Op3-last</a></li>
	          </ul>
	        </li>
	      </ul>
	    </div><!-- /.navbar-collapse -->
	  </div><!-- /.container-fluid -->
	</nav>
	
	
</nav>
</form>				
</body>
</html>