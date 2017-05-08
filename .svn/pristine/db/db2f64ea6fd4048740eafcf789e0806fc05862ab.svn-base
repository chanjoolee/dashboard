<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>codeComplexTrends</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script src="js/dashboard.js?version=1"></script>
	<script type="text/javascript">
	$(function () {
		//projectListByAjax();
		getDataByJson();
		
	});
	
	//document.domain = 'abc.com';
	var responseDataG = {};
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/projectListByJson.html",
			data: {},
			success : function(responseData){
				var projectList = responseData.projectList;
				var paramPjtcode = "${param.pjt_code}" ;
				var selected ="";
				
				for(var i=0; i<projectList.length ; i++){
					var pjt_code = projectList[i].PJT_CODE;
					selected ="";
					if(paramPjtcode==pjt_code)
						selected = "selected";
					
					$("#sProject").append("<option value='"+ projectList[i].PJT_CODE +"' "+selected+">" + projectList[i].PJT_CODE +"</option>" );
					
				}	
				
				setProjectNameList(responseData.projectNameList);
				
				if(paramPjtcode != "")
					getDataByJson(true);
			}
		});
	}
	
	
	/**
	*@param: changeOption boolean 검색옵션변경여부
	*/
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		var parameter = {};
		//var parameter = {PJT_CODE: $("#sProject").val()}
		
		//var parameter = $("#form").serialize();
		parameter.PJT_CODE = $("#sProject").val();
		parameter.pjt_name = $("#pjt_name").val();
		//parameter.pjt_name = getPjtName($("#sProject").val());
		
		$.ajax({
			type: "POST",
			url : "/dashboard/codeComplexTrendsJson.html",
			data: parameter,
			//modelAttribute:"searchVO",
			success : function(responseData){
				responseDataG = responseData;
				drawChart(responseData);
			}
		});
	}
	
	
	function drawChart(responseData){				
		var imagePath = responseData.imagePath;	
		//var imgPath = new String(); 
        //imgPath = document.getElementById("container").style.backgroundImage; 
        //document.getElementById("container").style.backgroundImage = "url("+pngPath+")"; 
        //document.getElementById("container").style.backgroundImage = "url(http://localhost:8080/regression/chart.png)";
        
        try{
        	$("#imagePath").attr("src",imagePath);
            $("#imagePath").attr("href",imagePath);
            $("#imagePath").attr("style","display:block");
        }catch(e){
        	
        }	
        
        
      //$("#imagePath").colorbox({rel:'group1'});
		/* if(parent){
			if(parent.parent){
				if(parent.parent.parent){
					if(parent.parent.parent.imageOriginal){
						//alert();
						parent.parent.parent.imageOriginal($("img"));
					}
				}
			}
		} */
		
	}
	
	
	
	function noData(){
		if(parent != window && parent.noData)
			parent.noData();
	}

	
	</script>
	<style type="text/css">
		html,  body, form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow: hidden;
	     }
	      
		.div-priority{
			/* width: 100%; */
			height: 19px;			
		}
		
		.dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 95%;	
			border: none;
		}	
		.dashboard-div #imagePath{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 100%;	
			border: none;
			display: none;
		}
			
		
	</style>
</head>
<body>
<form name="form" id="form">
<input type="hidden" name="pjt_name" id="pjt_name"  value="${param.pjt_name}"/>
<input type="hidden" name="PJT_CODE" id="sProject" onchange="getDataByJson()" value="${param.pjt_code}"/>
<%-- <select name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson(true)" <c:if test="${param.pjt_code != null}"> style="display:none;"   </c:if> >
	<option>PROJECT SELECT</option>
</select> --%>
<div id="container" class="dashboard-div">
	<img id="imagePath" onerror="noData();">
</div>
</form>
</body>
</html>
