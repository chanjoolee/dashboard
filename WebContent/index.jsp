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
	<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js" integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ" crossorigin="anonymous"></script>
	
    
	<script type="text/javascript">
	/* $(function () {		
		window.open('http://166.125.112.110:7070/dashboard/dashboard.html','winname','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=0,width=1024,height=800');
	}); */
	
	$(function () {
		$("ul li label").each(function(){
		    //$(this).parent().css("width",$(this).css("width"));
			$(this).parent().width($(this).width()+100);
		});
		
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

<nav class="navbar navbar-expand-lg navbar-light bg-light">
	
	<div class="collapse navbar-collapse" id="navbarSupportedContent">			
		<ul class="ul navbar-nav mr-auto" >
		<!--<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">-->
			<li class="nav-item dropdown show">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Schema
		        </a>	
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		          <a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=schema/entity_create_from_table');">Create Enity</a>
		          <a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=schema/workflow_create_from_enities');">Create WorkFlow by Enity</a>
		          <ul class="ul navbar-nav mr-auto" >
		          <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		          	<li>
			          <a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=schema/entity_create_from_table');">Create Enity</a>
			          <a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=schema/workflow_create_from_enities');">Create WorkFlow by Enity</a>
			        </div>
			        </li>
			      </ul>
		        </div> 
		        
		        
		          
				
			</li>
			
	          
	          
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Corona
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=corona_portal');">Corona All</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=corona_emmc/coronaSummary');">Corona EMMC Summary</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=coronaSummary');">Corona UFS Summary</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=corona_manage_script');">Corona Manage Script</a>
				</div>
			</li>
			<li class="nav-item dropdown ">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Regression
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=regression/regressionTabView');">Regression Tab View1</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/regressionTabView.html');">Regression Tab View</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          SSD
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/ssdCusMain.html');">고객실장</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/ssdCusMainChart.html');">고객실장차트</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/ssdReliabilityMain.html');">ssdReliabilityMain</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Preformance
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.html?viewName=performanceHigh1');">High charts1</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.html?viewName=performanceHigh2');">High charts2</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.html?viewName=performanceTabView');">Tab_View(CSSD)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.html?viewName=performanceTabView&category=ESSD');">Tab_View(ESSD)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performance.html');">Pivot table</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/js/WebPivotTable/public/index.htm');">Web Pivot table</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          FW Quality
		        </a> 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fwqDivision.html');">FW Quality Division</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fwqMetric.html');">FW Quality Metric</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fwqCodingRulePop.html?project=Columbus_FCPU&measureDt1=20160117&measureDt2=20170110');">FW Quality Coding Rule</a>
					
				</div>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#" onclick="dashboardShow('_blank','/dashboard/dashboard.html');" >Dashboard</a>
			</li>
			<li class="nav-item" >
				<a class="nav-link" href="#" onclick="windowOpen();">dashboard popup</a>
			</li>
			<li class="nav-item dropdown" >
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          CodeSonar
		        </a> 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="projectOneStackByPCntDate.html?version=test">CodeSonar project analysis(testData)</a>
					<a class="dropdown-item" href="projectOneStackByPCntDate.html">CodeSonar project analysis</a>
					<a class="dropdown-item" href="codesonarTrendGrid.html">CodeSonar project analysis With Grid</a>
					<a class="dropdown-item" href="projectMultiByPCnt.html?version=test">CodeSonar analysis(All project)(testData)</a>
					<a class="dropdown-item" href="projectMultiByPCnt.html">CodeSonar analysis(All project)</a>
					<a class="dropdown-item" href="codesonarAll.html">CodeSonar(All)</a>
					<a class="dropdown-item" href="codesonarProjectDetail.html">CodeSonar Detail</a>								
					<a class="dropdown-item" href="codesonarDetail.html?pjt_code=MercuryPlus">CodeSonar Detail(Component)</a>
						<ul>
							<li><a href="codesonarDetailPriority.html?pjt_code=Armstrong">CodeSonar Priority</a></li>
							<li><a href="codesonarDetailClass.html?pjt_code=Armstrong">CodeSonar Class</a></li>
							<li><a href="codesonarDetailFile.html?pjt_code=Armstrong">CodeSonar File</a></li>
							<li><a href="codesonarDetailFunction.html?pjt_code=Armstrong">CodeSonar Function</a></li>
						</ul>
				</div>
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Issue
		        </a> 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/issueTrends.html');">Issue Trends</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','issueUnresolvedPriority.html');">Issue UnresolvedPriority</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','issueUnresolvedType.html');">Issue UnresolvedType</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','issueUnresolved.html');">Issue Unresolved</a>
				</div>
			</li>
			
			<li class="nav-item" >
				<a class="nav-link" href="#" onclick="dashboardShow('_blank','/dashboard/projectOneComplex.html?pjt_code=MercuryPlus');">ProjectOneComplex</a>
			</li>
			<li class="nav-item" >
				<a class="nav-link" href="#" onclick="dashboardShow('_blank','/dashboard/regressionPng.html');">regression</a>
			</li>
			
			
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Pms TAT
		        </a> 
				 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsTatByModel.html');">Pms TAT(by model)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsTatByProject.html');">Pms TAT(by project)</a>
				</div>
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          PMS Resource
		        </a> 
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResourceFcst.html');">Pms Resource Forecast</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResource.html?category=project');">Pms Resource project </a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResource.html?category=function');">Pms Resource function </a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResource.html?category=site');">Pms Resource site </a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResourceProject.html?category=function&pjt_code=PJT_00021046&pjt_name=Armstrong');">Pms Resource project Armstrong function</a>
										
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Deliverables
		        </a> 
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/deliverableGeneral.html');">General</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          RegressionTest
		        </a> 
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/regressionTestProject.html');">Project</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Schedule
		        </a> 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsSchedule.html');">Schedule</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          codeComplexity
		        </a> 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/codeComplexity.html');">codeComplexity</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/codeComplexStatus.html');">codeComplexStatus</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/codeComplexHistory.html');">codeComplexHistory</a>
				</div>
			</li>
		</ul>
	</div>
</nav>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	
	<div class="collapse navbar-collapse" id="navbarSupportedContent">			
		<ul class="ul navbar-nav mr-auto" >
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Summary Dashboard
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/summaryDashboard.html');">Summary Dashboard</a>
				</div> 
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Code Revew
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/codeReview.html');">Code Revew</a>
				</div> 
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          socDesign
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchSocDesignJson.html');">new barch</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/socDesignCsv.html');">socDesignCsv</a>
					
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/socDesignChart.html?project=Columbus');">socDesignChart</a>
					
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/socDesinTestCaseChart.html');">socDesinTestCaseChart</a>
					
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          BATCH
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchPjtnameMappingJson.html');">PjtnameMapping(pms의 pjtName과 dashboard pjtName parsing)</a>
					
					
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchMappingSchedulePmsWithDashboard.html');">MappingSchedule(pms의 schedule 데이타를 dashboard schedule로 update)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchJiraProjectMappingJson.html');">JiraProjectMapping(pms의 project와  dashboard jira project mapping)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchCodesonarProjectMappingJson.html');">CodesonarProjectMapping(pms의 project와  dashboard codesonar project mapping)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchFileFvt.html');">Fvt batch</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fvtPassByDt.html');">Fvt Chart(Progress)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fvtPhaseCount.html');">Fvt Chart(phase count)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchFwqJson.html');">FW Quality Index</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchFwqLinkCheckJson.html');">FW Quality Link check</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchSsdCustomMigrationJson.html');">SSD Custom Test Migration</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Jira
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraIssueFromResolution.html');">jiraIssueFromResolution(불량별 해결현황)</a>
					
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraDiscoveredResolution.html');">DiscoveredResolution(테스트종류별해결현황)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraPresumedCause.html');">PresumedCause(추정원인대비확정원인)</a>
					<a class="dropdown-item" href="#" onclick="gotoCauseStatusList();">JIRA Issue List</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/retrieveJiraIssueRootCauseTat.html');">Root Cause별 TAT</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/retrieveJiraIssuePhaseTat.html');">Phase별 TAT</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/retrieveJiraIssueProjectDefect.html');">Project별 불량현황</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraIssueHMS.html?pjtId=PJT_00049942');">Jiraissue HMS Gemini</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/perforceHMS.html?pjtId=PJT_00049942');">Perforce HMS Gemini</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/perforceHMS.html?pjtId=PJT_00049499');">Perforce HMS Sapphire</a>
				</div>
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Bamboo
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/bambooTestProject.html');">bambooTestProjectt</a>
				</div>
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          PMS Controller
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/relevant.html');">PMS Controller Map</a>
				</div>
				
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          RMS
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchRMSJson.html');">RMS Batch</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/rmsVirtual.html?pjt_code=PJT_00021073');">RMS : Jade(Quasar 64Gb MLC )</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/rms.html?pjt_code=Columbus');">RMS : Columbus</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/rms.html?pjt_code=SampleProject1');">RMS : Jade(SampleProject #1 )</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/rms.html?pjt_code=SampleProject2');">RMS : Jade(SampleProject #2 )</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Jsonforms
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jsonforms.html');">jsonforms</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          fileUpload
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fileTest.html');">fileTest</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          ETC
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/googleSearch.html');">googleSearch</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/retrieveIarLicenseUse.html');">IAR License</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/systemUsageSummary.html?systemId=SolutionPMS');">systemUsageSummary</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/systemUsage.html?systemId=SolutionPMS&useMonth=201610');">systemUsage</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraConfUsage.html');">jira confluence Usage</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Diagram
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jointjs.html');">jointJs</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/backboneEx.html');">backbone 연습</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram01_blog.html');">01. diagram layout Blog sample</a>		
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram01_1_blogMy.html');">01-1. diagram layout my</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_webpage.html');">02. diagram layout Webpage sample</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_1_webpageMy.html');">02-1. diagram layout Webpage my</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_2_dragAndDrop.html');">02-2. diagram drag and drop sample</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_3_joint.html');">02-3. diagram joint</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_4_joint.html');">02-4. diagram joint: template</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewname=diagram/diagram02_5_joint');">02-5. diagram joint: template</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/diagram02_6_joint');">02-6. diagram joint: template</a>		
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/diagram_erd');">diagram: erd</a>	
							
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Joint/Rappid
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/jointjs/demos/rappid/apps/QAD/qad');">Qad</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Web Search
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=websearch/webSearch');">Web Search</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=websearch/webSearch2');">Web Search2</a>
				</div>
			</li>
		</ul>
	</div>
</nav>
</form>				
</body>
</html>