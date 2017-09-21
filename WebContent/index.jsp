<%@ page contentType="text/html;charset=utf-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>DashBoard</title>
<script src="js/jquery/jquery-1.11.2.min.js"></script>
<script src="js/jquery/jquery.popupWindow.js"></script>
<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
	<script type="text/javascript">
	/* $(function () {		
		window.open('http://166.125.112.110:7070/dashboard/dashboard.html','winname','directories=no,titlebar=no,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=0,width=1024,height=800');
	}); */
	
	$(function () {
		$("ul li label").each(function(){
		    //$(this).parent().css("width",$(this).css("width"));
			$(this).parent().width($(this).width()+100);
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
		/* .ul{
			list-style: circle;
			display: block;
			float: left;
		}
		
		.ul li{
			float: none;
		}
		 */
		 
		 .ul li label{
		 	cursor: pointer;
		 }
	
	</style>
</head>
<body>
<form name="form1" id="form1">
<input type="hidden" name="sender" value="confluence"/>
				<ul class="ul">
					<li class="">
						Corona
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=corona_portal');">Corona All</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=corona_emmc/coronaSummary');">Corona EMMC Summary</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=coronaSummary');">Corona UFS Summary</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=corona_manage_script');">Corona Manage Script</a></label>
							</li>
						</ul>
					</li>
					<li class="">
						Regression
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/regressionTabView.html');">Regression Tab View</a></label>
							</li>
						</ul>
					</li>
					<li class="">
						SSD
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/ssdCusMain.html');">고객실장</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/ssdCusMainChart.html');">고객실장차트</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/ssdReliabilityMain.html');">ssdReliabilityMain</a></label>
							</li>
						</ul>
					</li>
					<li class="">
						Preformance
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.html?viewName=performanceHigh1');">High charts1</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.html?viewName=performanceHigh2');">High charts2</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.html?viewName=performanceTabView');">Tab_View(CSSD)</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/performanceHigh.html?viewName=performanceTabView&category=ESSD');">Tab_View(ESSD)</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/performance.html');">Pivot table</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/js/WebPivotTable/public/index.htm');">Web Pivot table</a></label>
							</li>
						</ul>
					</li>
					<li class="">
						FW Quality 
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/fwqDivision.html');">
								<label>FW Quality Division</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/fwqMetric.html');">
								<label>FW Quality Metric</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/fwqCodingRulePop.html?project=Columbus_FCPU&measureDt1=20160117&measureDt2=20170110');">
								<label>FW Quality Coding Rule</label>
							</li>
						</ul>
					</li>
					<li class="" onclick="dashboardShow('_blank','/dashboard/dashboard.html');">
						<label>Dashboard </label>
					</li>
					<li class="" style="cursor:pointer;">
						<a onclick="windowOpen();">dashboard popup</a>
					</li>
					<li><a href="codesonar.html">CodeSonar</a>
						<ul>
							<li class="">
								<a href="projectOneStackByPCntDate.html?version=test">CodeSonar project analysis(testData)</a>
							</li>
							<li class="">
								<a href="projectOneStackByPCntDate.html">CodeSonar project analysis</a>
							</li>
							<li class="">
								<a href="codesonarTrendGrid.html">CodeSonar project analysis With Grid</a>
							</li>
							<li class="">
								<a href="projectMultiByPCnt.html?version=test">CodeSonar analysis(All project)(testData)</a>
							</li>
							<li class="">
								<a href="projectMultiByPCnt.html">CodeSonar analysis(All project)</a>
							</li>
							<li class="">
								<a href="codesonarAll.html">CodeSonar(All)</a>
							</li>
							<li class="">
								<a href="codesonarProjectDetail.html">CodeSonar Detail</a>								
							</li>
							<li class="">
								<a href="codesonarDetail.html?pjt_code=MercuryPlus">CodeSonar Detail(Component)</a>
								<ul>
									<li><a href="codesonarDetailPriority.html?pjt_code=Armstrong">CodeSonar Priority</a></li>
									<li><a href="codesonarDetailClass.html?pjt_code=Armstrong">CodeSonar Class</a></li>
									<li><a href="codesonarDetailFile.html?pjt_code=Armstrong">CodeSonar File</a></li>
									<li><a href="codesonarDetailFunction.html?pjt_code=Armstrong">CodeSonar Function</a></li>
								</ul>
							</li>
							
						</ul>
					</li>
					
					<li class="">
						<a href="issue.html">Issue</a>
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/issueTrends.html');">
								<label>Issue Trends </label>
							</li>
							<li class="">
								<a href="issueUnresolvedPriority.html">Issue UnresolvedPriority</a>
							</li>
							<li class="">
								<a href="issueUnresolvedType.html">Issue UnresolvedType</a>
							</li>
							<li class="">
								<a href="issueUnresolved.html">Issue Unresolved</a>
							</li>
						</ul>
					</li>
					<li class="">
						<a href="projectOneComplex.html?pjt_code=MercuryPlus">ProjectOneComplex</a>
					</li>
					<li class="">
						<a href="regressionPng.html">regression</a>
					</li>
					<li class="">
						Pms TAT 
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsTatByModel.html');">
								<label>Pms TAT(by model)</label>
							</li>
							<li class=""  onclick="dashboardShow('_blank','/dashboard/pmsTatByProject.html');">
								<label>Pms TAT(by project)</label>
							</li>
						</ul>
					</li>
					
					<li class="">
						PMS Resource
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResourceFcst.html');">
								<label>Pms Resource Forecast </label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResource.html?category=project');">
								<label>Pms Resource project </label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResource.html?category=function');">
								<label>Pms Resource function </label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResource.html?category=site');">
								<label>Pms Resource site </label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResourceProject.html?category=function&pjt_code=PJT_00021046&pjt_name=Armstrong');">
								<label>Pms Resource project Armstrong function </label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResourceProject.html?category=site&pjt_code=PJT_00021046&pjt_name=Armstrong');">
								<label>Pms Resource project Armstrong site </label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResourceProject.html?category=function&pjt_code=PJT_00023241&pjt_name=Jade R + ZU 128G TLC');">
								<label>Pms Resource project Jade R + ZU 128G TLC function </label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResourceProject.html?category=site&pjt_code=PJT_00023241&pjt_name=Jade R + ZU 128G TLC');">
								<label>Pms Resource project Jade R + ZU 128G TLC site </label>
							</li>
							
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResourceProject.html?category=function&pjt_code=PJT_00024160&pjt_name=[TEST Project] EDU_001');">
								<label>Pms Resource project [TEST Project] EDU_001 function </label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsResourceProject.html?category=site&pjt_code=PJT_00024160&pjt_name=[TEST Project] EDU_001');">
								<label>Pms Resource project [TEST Project] EDU_001 site </label>
							</li>
							
						</ul>
					</li>
					<li class="">
						Deliverables
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/deliverableGeneral.html');">
								<label>General</label>
							</li>
							
						</ul>
					</li>
					<li class="">
						RegressionTest
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/regressionTestProject.html');">
								<label>Project</label>
							</li>
							
						</ul>
					</li>
					<li class="">
						Schedule
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/pmsSchedule.html');">
								<label>Schedule</label>
							</li>
							
						</ul>
					</li>
					<li class="">
						<a href="codeComplexity.html">codeComplexity </a>
						<ul>
							<li class="">
								<a href="codeComplexTrends.html">codeComplexTrends </a>
							</li>
							<li class="">
								<a href="codeComplexStatus.html">codeComplexStatus </a>
							</li>
							<li class="">
								<a href="codeComplexHistory.html">codeComplexHistory </a>
							</li>
						</ul>
					</li>
					<li class="" onclick="dashboardShow('_blank','/dashboard/summaryDashboard.html');">
						<label>Summary Dashboard</label>
					</li>
					<li class="">
						<a href="codeReview.html">Code Revew</a>
					</li>
					<li class="">
						socDesign
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/batchSocDesignJson.html');">new barch</a></label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/socDesignCsv.html');">
								<label>socDesignCsv</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/socDesignChart.html?project=Columbus');">
								<label>socDesignChart</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/socDesinTestCaseChart.html');">
								<label>socDesinTestCaseChart</label>
							</li>
						</ul>
					</li>
					<li class="">
						BATCH
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/batchPjtnameMappingJson.html');">
								<label>PjtnameMapping(pms의 pjtName과 dashboard pjtName parsing)</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/batchMappingSchedulePmsWithDashboard.html');">
								<label>MappingSchedule(pms의 schedule 데이타를 dashboard schedule로 update)</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/batchJiraProjectMappingJson.html');">
								<label>JiraProjectMapping(pms의 project와  dashboard jira project mapping)</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/batchCodesonarProjectMappingJson.html');" style="display: none;">
								<label>CodesonarProjectMapping(pms의 project와  dashboard codesonar project mapping)</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/batchFileFvt.html');">
								<label>Fvt batch</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/fvtPassByDt.html');">
								<label>Fvt Chart(Progress)</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/fvtPhaseCount.html');">
								<label>Fvt Chart(phase count)</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/batchFwqJson.html');">
								<label>FW Quality Index</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/batchFwqLinkCheckJson.html');">
								<label>FW Quality Link check</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/batchSsdCustomMigrationJson.html');">
								<label>SSD Custom Test Migration</label>
							</li>
						</ul>
					</li>
					<li class="">
						Jira
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/jiraIssueFromResolution.html');">
								<label>jiraIssueFromResolution(불량별 해결현황)</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/jiraDiscoveredResolution.html');">
								<label>DiscoveredResolution(테스트종류별해결현황)</label>
							</li>
							<li class="" onclick="dashboardShow('_blank','/dashboard/jiraPresumedCause.html');">
								<label>PresumedCause(추정원인대비확정원인)</label>
							</li>
							<li class="">
								<label><a href="#" onclick="gotoCauseStatusList();">JIRA Issue List</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/nspim/dash/retrieveJiraIssueRootCauseTat.do');">Root Cause별 TAT</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/nspim/dash/retrieveJiraIssuePhaseTat.do');">Phase별 TAT</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/nspim/dash/retrieveJiraIssueProjectDefect.do');">Project별 불량현황</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/jiraIssueHMS.html?pjtId=PJT_00049942');">Jiraissue HMS Gemini</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/perforceHMS.html?pjtId=PJT_00049942');">Perforce HMS Gemini</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/perforceHMS.html?pjtId=PJT_00049499');">Perforce HMS Sapphire</a></label>
							</li>
						</ul>
					</li>
					
					<li class="">
						Bamboo
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/bambooTestProject.html');">bambooTestProjectt</a></label>
							</li>
						</ul>
					</li>
					
					<li class="">
						PMS Controller
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/relevant.html');">PMS Controller Map</a></label>
							</li>
						</ul>
					</li>
					<li class="">
						RMS
						<ul>
							<li class="" onclick="dashboardShow('_blank','/dashboard/batchRMSJson.html');">
								<label>RMS Batch</label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/rmsVirtual.html?pjt_code=PJT_00021073');">RMS : Jade(Quasar 64Gb MLC ) </a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/rms.html?pjt_code=Columbus');">RMS : Columbus </a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/rms.html?pjt_code=SampleProject1');">RMS : Jade(SampleProject #1 ) </a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/rms.html?pjt_code=SampleProject2');">RMS : Jade(SampleProject #2 ) </a></label>
							</li>
						</ul>
					</li>
					<li class="">
						Jsonforms
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/jsonforms.html');">jsonforms</a></label>
							</li>							
						</ul>
					</li>
					<li class="">
						fileUpload
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/fileTest.html');">fileTest</a></label>
							</li>							
						</ul>
					</li>
					<li class="">
						ETC
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/googleSearch.html');">googleSearch</a></label>
							</li>	
							<li class="">
								<label><a onclick="dashboardShow('_blank','/nspim/dash/retrieveIarLicenseUse.do');">IAR License</a></label>
							</li>	
							<li class="">
								<label><a onclick="dashboardShow('_blank','/dashboard/systemUsageSummary.html?systemId=SolutionPMS');">systemUsageSummary</a></label>
							</li>
							<li class="">
								<label><a onclick="dashboardShow('_blank','/dashboard/systemUsage.html?systemId=SolutionPMS&useMonth=201610');">systemUsage</a></label>
							</li>	
							<li class="">
								<label><a onclick="dashboardShow('_blank','/dashboard/jiraConfUsage.html');">jira confluence Usage</a></label>
							</li>	
						</ul>
					</li>
					<li class="">
						Diagram
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/jointjs.html');">jointJs</a></label>
							</li>	
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/backboneEx.html');">backbone 연습</a></label>
							</li>		
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/diagram01_blog.html');">01. diagram layout Blog sample</a></label>
							</li>	
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/diagram01_1_blogMy.html');">01-1. diagram layout my</a></label>
							</li>	
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_webpage.html');">02. diagram layout Webpage sample </a></label>
							</li>	
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_1_webpageMy.html');">02-1. diagram layout Webpage my</a></label>
							</li>	
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_2_dragAndDrop.html');">02-2. diagram drag and drop sample</a></label>
							</li>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_3_joint.html');">02-3. diagram joint</a></label>
							</li>	
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/diagram02_4_joint.html');">02-4. diagram joint: template</a></label>
							</li>		
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/diagramGeneral.html?viewname=diagram02_5_joint');">02-5. diagram joint: template</a></label>
							</li>		
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram02_6_joint');">02-6. diagram joint: template</a></label>
							</li>		
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=diagram/diagram_erd');">diagram: erd</a></label>
							</li>		
									
						</ul>
					</li>
					<li>
						<li class="">
						Search
						<ul>
							<li class="">
								<label><a href="#" onclick="dashboardShow('_blank','/dashboard/generic.html?viewName=webSearch');">Web Search</a></label>
							</li>
						</ul>
					</li>
					</li>
				</ul>
</form>				
</body>
</html>