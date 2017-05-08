<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Insert title here</title>
	<link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css" />
	
	<%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
    
    <script type="text/javascript" src="js/jqGrid/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="js/jqGrid/i18n/grid.locale-kr.js"></script>
    
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/i18n/grid.locale-en.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/jquery.jqGrid.src.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/json2.js"></script> -->
    
    <%-- 2. high charts --%>
    
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=1"></script>
	
	<%-- 5. local --%>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />

	<style>
		.wrap_a{width:100%; overflow:hidden}
		.wrap_b{width:100%; overflow:hidden}
		.wrap_b_1{width:49%; height:auto ;overflow:hidden; float:left; margin-top:30px}
		.wrap_b_2{width:49%; height:auto ;overflow:hidden; float:right; margin-top:30px}
		
		.box_gray{background:#f5f6fa; border:1px solid #e1e2e6; padding:15px; text-align:center; margin-bottom:8px }
		.cont_tit {float:none}
		iframe {
			   border: none;
			   frameborder:0;
			   
			   width: 100%;
			   height: 100%;
		}
	</style>
<script type="text/javascript">
	$(function () {
		//makeSearch();
		//getJiraPjtCode();
		getDataByJson();
		
	});
		
	
	function getDataByJson(){
		
		dashboardShow("bambooTestClassName","/dashboard/bambooTestClassName.html");
	}
	
	function dashboardShow(target,action){
	
		var oFrm = document.getElementById("form1");
		
		var target = target;
		oFrm.action =  action;
		oFrm.method = "post";
		oFrm.target = target; 
	    oFrm.submit();
		
	}
	
	function gotoClassTime(project,className){		
		var frm = document.form1;
	    //frm.menuAuthId.value = "MNU20150422131320740";
	    //frm.pjtId.value = pjtId;
	    frm.project.value = project;
	    frm.className.value = className;
	    //frm.revision.value = revision;
	    frm.action = "/dashboard/bambooTestClassNameTime.html";
	    frm.target = "bambooTestClassNameTime";
	    frm.submit();
		
	}
	
	function gotoList(category){
		var newwin = window.open("", "testList", "resizable=yes, scrollbars=yes, status=yes,menubar=yes");
		var oFrm = document.getElementById("form1");
		oFrm.category.value = category;
		oFrm.action =  '/dashboard/bambooTestClassNameTimeList.html';
		oFrm.method = "post";
		oFrm.target = 'testList'; 
	    oFrm.submit();
	    newwin.focus();
	}
	
	function makeSearch(){
		/* if($("[name=select]").length > 0){
			var options = issueTrends.$("#sProject option");
			$.each(options,function(index,option){
				$("[name=select]").append("<option value='"+ $(option).val()+"'>" + $(option).text() +"</option>");
			});
			$("[name=select]").change(function(){
				$("#sProject").val(this.value);
				getDataByJson();
			});
		} */
		
		$.ajax({
			url : "/dashboard/dashboardProjectListJson.html",
			data: {division:'jira'},
			success : function(responseData){
				var projectList = responseData.projectList;
				//var paramPjtcode = $("#sProject").val() ;
				var paramPjtcode ="${pjtId}";
				var selected ="";
				
				for(var i=0; i<projectList.length ; i++){
					var pjt_code = projectList[i].PJT_CODE;
					//var pjt_code = "${pjtId}";
					selected ="";
					
					if(paramPjtcode==pjt_code)
						selected = "selected";
					
					$("[name=select]").append("<option value='"+ projectList[i].PJT_CODE +"' "+selected+">" + projectList[i].PJT_NAME +"</option>" );
				}
				
				$("[name=select]").change(function(){
					$("#sProject").val(this.value);
					$("#pjt_name").val($("#select option:selected").text());
					
					if($("#sProject").val() != "")
						getDataByJson();
				});
				
				//getDataByJson();
				
			}
		});
		
	}
	
	
	

	
	
	
</script>
</head>
<body>
<form name="form1" id="form1" method="post" >
<input type="hidden" name="version" id="version"  value=""/>
<input type="hidden" name ="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" name ="chartType" value="${param.chartType}"/>

<input type="hidden" name="project" id="project" value="${param.project}"/>
<input type="hidden" name="className" id="className" value=""/>
<input type="hidden" name="pjt_code" id="sProject" value="${param.pjt_code}"/>
<input type="hidden" name="pjt_name" id="pjt_name" value="${param.pjt_name}"/>
<input type="hidden" name="userId" value="${login_id}"/>
<input type="hidden" name="solution" value="pms"/>


<input type="hidden" name="revision" id="revision"  value=""/>
<input type="hidden" name="category" id="category"  value=""/>
		
       <div class="sub_cont" style="padding-top: 3px;">
           <div class="wrap_a">
               <h3 class="cont_tit">Class List</h3>
               <div class="box_gray" style="height:350px"><iframe frameborder="0" id="bambooTestClassName" name="bambooTestClassName"></iframe></div>
           </div>
           <div class="wrap_a">
               <h3 class="cont_tit">Class Timeline</h3>
               <div class="box_gray" style="height:350px"><iframe frameborder="0" id="bambooTestClassNameTime" name="bambooTestClassNameTime"></iframe></div>
           </div>
       </div> 
    <!-- ## //PAGE CONTENTS ##--->	
</form>	
</body>
</html>