<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>DashBoard</title>
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> -->
<script src="/dashboard/js/cdnjs/jquery/2.1.3/jquery.min.js"></script>
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script> -->
<script src="/dashboard/js/maxcdn/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"> -->
<link rel="stylesheet" href="/dashboard/js/maxcdn/bootstrap/3.2.0/css/bootstrap.min.css">
<script type="text/javascript">
	
	$(function () {

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
<body>
<form name="form1" id="form1">
<input type="hidden" name="sender" value="confluence"/>
<div class="navbar navbar-default navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">NavBar</a>
        </div>
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="https://github.com/fontenele/bootstrap-navbar-dropdowns" target="_blank">GitHub Project</a></li>
            </ul>
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">Home</a></li>
                <li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Menu Sample <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="#">Action</a></li>
                        <li><a href="#">Another action</a></li>
                        <li><a href="#">Something else here</a></li>
                        <li class="divider"></li>
                        <li><a href="#">Separated link</a></li>
                        <li class="divider"></li>
                        <li><a href="#">One more separated link</a></li>
                        <li class="dropdown-submenu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown</a>
                            <ul class="dropdown-menu">
                                <li><a href="#">Action</a></li>
                                <li><a href="#">Another action</a></li>
                                <li><a href="#">Something else here</a></li>
                                <li class="divider"></li>
                                <li><a href="#">Separated link</a></li>
                                <li class="divider"></li>
                                <li class="dropdown-submenu">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown</a>
                                    <ul class="dropdown-menu">
                                        <li class="dropdown-submenu">
                                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown</a>
                                            <ul class="dropdown-menu">
                                                <li><a href="#">Action</a></li>
                                                <li><a href="#">Another action</a></li>
                                                <li><a href="#">Something else here</a></li>
                                                <li class="divider"></li>
                                                <li><a href="#">Separated link</a></li>
                                                <li class="divider"></li>
                                                <li><a href="#">One more separated link</a></li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </li>
                    </ul>
				</li>
				<li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Exercise <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li class="dropdown-submenu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Schema</a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=schema/entity_create_from_table');">Create Enity</a></li>
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=schema/workflow_create_from_enities');">Create WorkFlow by Enity</a></li>
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=schema/generate_from_bpmn2');">Generate source by BPMN2</a></li>
                                
                            </ul>
						</li>						
						<li class="dropdown-submenu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Diagram</a>
                            <ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/erd/erd');">Erd</a></li>
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/bpmn/bpmn');">BPMN</a></li>
								<li class="dropdown-submenu">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown">Joint/Rappid</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/jointjs/demos/rappid/apps/QAD/qad');">Qad</a></li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/jointjs/myqad/2018.010/qad');">MyQad.1</a></li>
										
									</ul>
								</li>
								<li class="dropdown-submenu">
									<a href="#" class="dropdown-toggle" data-toggle="dropdown">prototype</a>
									<ul class="dropdown-menu">
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jointjs.html');">jointJs</a></li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/backboneEx.html');">backbone 연습</a></li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram01_blog.html');">01. diagram layout Blog sample</a></li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram01_1_blogMy.html');">01-1. diagram layout my</a></li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_webpage.html');">02. diagram layout Webpage sample</a>	</li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_1_webpageMy.html');">02-1. diagram layout Webpage my</a></li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_2_dragAndDrop.html');">02-2. diagram drag and drop sample</a></li>	
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_3_joint.html');">02-3. diagram joint</a></li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_4_joint.html');">02-4. diagram joint: template</a>	</li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewname=diagram/diagram02_5_joint');">02-5. diagram joint: template</a></li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/diagram02_6_joint');">02-6. diagram joint: template</a></li>
										<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/diagram_erd');">diagram: erd</a></li>
										
									</ul>
								</li>
                                
                            </ul>
						</li>

						<li class="dropdown-submenu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">WebSearch</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=websearch/webSearch');">Web Search</a></li>
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=websearch/webSearch2');">Web Search2</a></li>
								
							</ul>
						</li>

						<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/summaryDashboard.html');">Summary Dashboard</a></li>
						<li><a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">fileUpload</a></li>
					
					</ul>
				</li>
				<li>
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dashboard <b class="caret"></b></a>
                    <ul class="dropdown-menu">
						<li class="dropdown-submenu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">SCript Management</a>
                            <ul class="dropdown-menu">
                            	<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=ssd_sm/test_master_mgmt');">SSD Mgmt</a></li>
                            	<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=ssd_sm/performance/Summary');">SSD Summary</a></li>
                            	<li class="dropdown-submenu">
                            		<a href="#" class="dropdown-toggle" data-toggle="dropdown">Prototype</a>
                            		 <ul class="dropdown-menu">
                            		 	<li class="dropdown-submenu">
                            		 		<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=ssd_sm/SummaryAll');">SSD Summary</a></li>
                            		 	</li>
                            		 </ul>
                            	</li>
								
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=coronaSummary');">Corona UFS Summary</a></li>
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=corona_emmc/coronaSummary');">Corona EMMC Summary</a></li>
                                
                            </ul>
						</li>
						<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=regression/regressionTabView');">Regression Tab View1</a></li>
						<li class="dropdown-submenu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">SSD</a>
                            <ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/ssdCusMain.html');">고객실장</a></li>
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/ssdCusMainChart.html');">고객실장차트</a></li>
                                <li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/ssdReliabilityMain.html');">ssdReliabilityMain</a></li>
                            </ul>
						</li>
						<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.html?viewName=performanceTabView');">Performance</a></li>
						<li class="dropdown-submenu">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">FW Quality</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fwqDivision.html');">FW Quality Division</a></li>
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fwqMetric.html');">FW Quality Metric</a></li>
								<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fwqCodingRulePop.html?project=Columbus_FCPU&measureDt1=20160117&measureDt2=20170110');">FW Quality Coding Rule</a></li>
								
							</ul>
						</li>
					</ul>
					
                </li>
				<li>
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">Generate<b class="caret"></b></a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?sender=xxx&viewName=schema/genSrc0523_01.2020.02.06.02.03.01/main');">Generate Source</a></li>
						<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','https://www.jstree.com/demo_sitebrowser/index.php');">Jstree Demo DataBase (JsTree Site)</a></li>
						<li><a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?sender=xxx&viewName=schema/genSrc0523_01.2020.02.06.02.03.01/document_ck5');">Manual Ck5(MySite)</a></li>

					</ul>
					
				</li>
			</ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

</form>				
</body>
</html>