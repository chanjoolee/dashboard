<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/include/include.toolbox.pmstable.jsp"></jsp:include>
<script type="text/javascript">
	
	$(function () {
		var h_navbar = $(".navbar").height();
		var h_iframe = Math.max($(window).height() - h_navbar -10 );
		$("#frame_content").height(h_iframe);

	});
	
	function windowOpen(){
		var pop = window.open('dashboard.html','_blank',
				'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1024,height=768');
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
		if(target != "_blank"){
			$("#navbar-first li").removeClass("active");
			$(window.event.target).parent().addClass("active");
		}

		

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

	.dropdown-submenu>.dropdown-menu {
		top: 0;
		left: 100%;
		margin-top: -6px;
		margin-left: -1px;
		-webkit-border-radius: 0 6px 6px 6px;
		-moz-border-radius: 0 6px 6px;
		border-radius: 0 6px 6px 6px;
	}

	.dropdown-submenu:hover>.dropdown-menu {
		display: block;
	}

	.dropdown-submenu>a:after {
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

	.dropdown-submenu:hover>a:after {
		border-left-color: #fff;
	}

	.dropdown-submenu.pull-left {
		float: none;
	}

	.dropdown-submenu.pull-left>.dropdown-menu {
		left: -100%;
		margin-left: 10px;
		-webkit-border-radius: 6px 0 6px 6px;
		-moz-border-radius: 6px 0 6px 6px;
		border-radius: 6px 0 6px 6px;
	}
</style>
</head>
<body style="overflow: hidden;">
<form name="form1" id="form1">
<input type="hidden" name="sender" value="confluence"/>
<div class="navbar navbar-default navbar-fixed-top" role="navigation" style="margin-bottom: 0px;">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <!-- <a class="navbar-brand" href="#">NavBar</a> -->
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="https://github.com/chanjoolee/dashboard" target="_blank">GitHub Project</a></li>
            </ul>
            <ul id="navbar-first" class="nav navbar-nav">
				<li class="active"><a class="dropdown-item" href="#" onclick="dashboardShow('frame_content','/dashboard/generic.html?sender=xxx&viewName=schema/genSrc0523_01.2020.02.06.02.03.01/document_home');">Home</a></li>
				<li><a class="dropdown-item" href="#" onclick="dashboardShow('frame_content','/dashboard/generic.html?sender=xxx&viewName=schema/genSrc0523_01.2020.02.06.02.03.01/document_ck5');">Document</a></li>
				<li class=""><a href="#">Demo</a></li>
				<li><a class="dropdown-item" href="#" onclick="dashboardShow('frame_content','/dashboard/generic.html?sender=xxx&viewName=schema/genSrc0523_01.2020.02.06.02.03.01/main');">Generate-Source</a></li>
				

			</ul>
        </div><!--/.nav-collapse -->
    </div>
</div>
<div style="margin-top: 52px;"><iframe id="frame_content" src="/dashboard/generic.html?sender=xxx&viewName=schema/genSrc0523_01.2020.02.06.02.03.01/document_home" name="frame_content" style="width: 100%; height: 1000px;"></iframe></div>

</form>				
</body>
</html>
