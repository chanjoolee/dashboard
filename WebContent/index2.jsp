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
		window.open('http://166.125.112.110:7070/dashboard/dashboard.do','winname','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=0,width=1024,height=800');
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
	    window.open('/dashboard/jiraIssuePhaseCauseList.do?sender=confluence','_blank',
		'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=800,height=768');
		//var oFrm = document.getElementById("form1");
		
		//oFrm.action =  "/dashboard/jiraIssuePhaseCauseList.do";
		//oFrm.method = "post";
		//oFrm.target = "_blank"; 
	    //oFrm.submit();
	}
	
	function gotoCauseMatrixList(){
	    window.open('/dashboard/jiraIssueCauseMatrixList.do?sender=confluence','_blank',
		'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1000,height=320');
		//var oFrm = document.getElementById("form1");
		
		//oFrm.action =  "/dashboard/jiraIssuePhaseCauseList.do";
		//oFrm.method = "post";
		//oFrm.target = "_blank"; 
	    //oFrm.submit();
	}
	
	function gotoCauseStatusList(){
	    window.open('/dashboard/jiraIssueCauseStatusList.do?sender=confluence','_blank',
		'directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,width=1024,height=608');
		//var oFrm = document.getElementById("form1");
		
		//oFrm.action =  "/dashboard/jiraIssuePhaseCauseList.do";
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
		          <a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=schema/entity_create_from_table');">Create Enity</a>
		          <a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=schema/workflow_create_from_enities');">Create WorkFlow by Enity</a>
		        </div> 
		        
		        
		          
				
			</li>
			
	          
	        <li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          SSD Script Management
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=ssd_sm/manage_tabs');">Manage Script</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=ssd_sm/SummaryAll');">Summary ALL</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Corona
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=corona_portal');">Corona All</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=corona_emmc/coronaSummary');">Corona EMMC Summary</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=coronaSummary');">Corona UFS Summary</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=corona_manage_script');">Corona Manage Script</a>
				</div>
			</li>
			<li class="nav-item dropdown ">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Regression
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=regression/regressionTabView');">Regression Tab View1</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/regressionTabView.do');">Regression Tab View</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          SSD
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/ssdCusMain.do');">고객실장</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/ssdCusMainChart.do');">고객실장차트</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/ssdReliabilityMain.do');">ssdReliabilityMain</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Preformance
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.do?viewName=performanceHigh1');">High charts1</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.do?viewName=performanceHigh2');">High charts2</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.do?viewName=performanceTabView');">Tab_View(CSSD)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.do?viewName=performanceTabView&category=ESSD');">Tab_View(ESSD)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/performance.do');">Pivot table</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/js/WebPivotTable/public/index.htm');">Web Pivot table</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          FW Quality
		        </a> 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fwqDivision.do');">FW Quality Division</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fwqMetric.do');">FW Quality Metric</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fwqCodingRulePop.do?project=Columbus_FCPU&measureDt1=20160117&measureDt2=20170110');">FW Quality Coding Rule</a>
					
				</div>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="#" onclick="dashboardShow('_blank','/dashboard/dashboard.do');" >Dashboard</a>
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
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/issueTrends.do');">Issue Trends</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','issueUnresolvedPriority.html');">Issue UnresolvedPriority</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','issueUnresolvedType.html');">Issue UnresolvedType</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','issueUnresolved.html');">Issue Unresolved</a>
				</div>
			</li>
			
			<li class="nav-item" >
				<a class="nav-link" href="#" onclick="dashboardShow('_blank','/dashboard/projectOneComplex.do?pjt_code=MercuryPlus');">ProjectOneComplex</a>
			</li>
			<li class="nav-item" >
				<a class="nav-link" href="#" onclick="dashboardShow('_blank','/dashboard/regressionPng.do');">regression</a>
			</li>
			
			
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Pms TAT
		        </a> 
				 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsTatByModel.do');">Pms TAT(by model)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsTatByProject.do');">Pms TAT(by project)</a>
				</div>
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          PMS Resource
		        </a> 
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResourceFcst.do');">Pms Resource Forecast</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResource.do?category=project');">Pms Resource project </a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResource.do?category=function');">Pms Resource function </a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResource.do?category=site');">Pms Resource site </a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsResourceProject.do?category=function&pjt_code=PJT_00021046&pjt_name=Armstrong');">Pms Resource project Armstrong function</a>
										
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Deliverables
		        </a> 
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/deliverableGeneral.do');">General</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          RegressionTest
		        </a> 
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/regressionTestProject.do');">Project</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Schedule
		        </a> 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/pmsSchedule.do');">Schedule</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          codeComplexity
		        </a> 
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/codeComplexity.do');">codeComplexity</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/codeComplexStatus.do');">codeComplexStatus</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/codeComplexHistory.do');">codeComplexHistory</a>
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
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/summaryDashboard.do');">Summary Dashboard</a>
				</div> 
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Code Revew
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/codeReview.do');">Code Revew</a>
				</div> 
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          socDesign
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchSocDesignJson.do');">new barch</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/socDesignCsv.do');">socDesignCsv</a>
					
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/socDesignChart.do?project=Columbus');">socDesignChart</a>
					
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/socDesinTestCaseChart.do');">socDesinTestCaseChart</a>
					
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          BATCH
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchPjtnameMappingJson.do');">PjtnameMapping(pms의 pjtName과 dashboard pjtName parsing)</a>
					
					
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchMappingSchedulePmsWithDashboard.do');">MappingSchedule(pms의 schedule 데이타를 dashboard schedule로 update)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchJiraProjectMappingJson.do');">JiraProjectMapping(pms의 project와  dashboard jira project mapping)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchCodesonarProjectMappingJson.do');">CodesonarProjectMapping(pms의 project와  dashboard codesonar project mapping)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchFileFvt.do');">Fvt batch</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fvtPassByDt.do');">Fvt Chart(Progress)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fvtPhaseCount.do');">Fvt Chart(phase count)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchFwqJson.do');">FW Quality Index</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchFwqLinkCheckJson.do');">FW Quality Link check</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchSsdCustomMigrationJson.do');">SSD Custom Test Migration</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Jira
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraIssueFromResolution.do');">jiraIssueFromResolution(불량별 해결현황)</a>
					
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraDiscoveredResolution.do');">DiscoveredResolution(테스트종류별해결현황)</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraPresumedCause.do');">PresumedCause(추정원인대비확정원인)</a>
					<a class="dropdown-item" href="#" onclick="gotoCauseStatusList();">JIRA Issue List</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/retrieveJiraIssueRootCauseTat.do');">Root Cause별 TAT</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/retrieveJiraIssuePhaseTat.do');">Phase별 TAT</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/retrieveJiraIssueProjectDefect.do');">Project별 불량현황</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraIssueHMS.do?pjtId=PJT_00049942');">Jiraissue HMS Gemini</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/perforceHMS.do?pjtId=PJT_00049942');">Perforce HMS Gemini</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/perforceHMS.do?pjtId=PJT_00049499');">Perforce HMS Sapphire</a>
					
				</div>
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Bamboo
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/bambooTestProject.do');">bambooTestProjectt</a>
				</div>
			</li>
			
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          PMS Controller
		        </a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/relevant.do');">PMS Controller Map</a>
				</div>
				
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          RMS
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/batchRMSJson.do');">RMS Batch</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/rmsVirtual.do?pjt_code=PJT_00021073');">RMS : Jade(Quasar 64Gb MLC )</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/rms.do?pjt_code=Columbus');">RMS : Columbus</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/rms.do?pjt_code=SampleProject1');">RMS : Jade(SampleProject #1 )</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/rms.do?pjt_code=SampleProject2');">RMS : Jade(SampleProject #2 )</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Jsonforms
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jsonforms.do');">jsonforms</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          fileUpload
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/fileTest.do');">fileTest</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          ETC
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/googleSearch.do');">googleSearch</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/retrieveIarLicenseUse.do');">IAR License</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/systemUsageSummary.do?systemId=SolutionPMS');">systemUsageSummary</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/systemUsage.do?systemId=SolutionPMS&useMonth=201610');">systemUsage</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jiraConfUsage.do');">jira confluence Usage</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				  Diagram
				  
				</a>
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/jointjs.do');">jointJs</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/backboneEx.do');">backbone 연습</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram01_blog.do');">01. diagram layout Blog sample</a>		
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram01_1_blogMy.do');">01-1. diagram layout my</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_webpage.do');">02. diagram layout Webpage sample</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_1_webpageMy.do');">02-1. diagram layout Webpage my</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_2_dragAndDrop.do');">02-2. diagram drag and drop sample</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_3_joint.do');">02-3. diagram joint</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_4_joint.do');">02-4. diagram joint: template</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewname=diagram/diagram02_5_joint');">02-5. diagram joint: template</a>	
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=diagram/diagram02_6_joint');">02-6. diagram joint: template</a>		
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=diagram/diagram_erd');">diagram: erd</a>	
				</div>
				
					
				
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Joint/Rappid
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=diagram/jointjs/demos/rappid/apps/QAD/qad');">Qad</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=diagram/jointjs/myqad/2018.010/qad');">MyQad.1</a>
				</div>
			</li>
			<li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		          Web Search
		        </a>
				
				<div class="dropdown-menu" aria-labelledby="navbarDropdown">
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=websearch/webSearch');">Web Search</a>
					<a class="dropdown-item" href="#" onclick="dashboardShow('_blank','/dashboard/generic.do?viewName=websearch/webSearch2');">Web Search2</a>
				</div>
			</li>
		</ul>
	</div>
</nav>

</form>				
</body>
</html>