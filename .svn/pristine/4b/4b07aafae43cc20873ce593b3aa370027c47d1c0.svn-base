<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>projectOneStackByPCnt</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script type="text/javascript">
	$(function () {
		$('#issueUnresolved').on("load" , function(){
			$("#issueUnresolved").contents().find("#sProject").css("display", "none");			
		});
		$('#codesonar').on("load" , function(){
			$("#codesonar").contents().find("#sProject").css("display", "none");			
		});
		$('#issueTrends').on("load" , function(){
			$("#issueTrends").contents().find("#sProject").css("display", "none");			
		});
		
		
		projectListByAjax();
	});
	
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/projectListByJson.html",
			//data: {},
			data: $("#form").serialize(),			
			success : function(responseData){
				var projectList = responseData.projectList;
				var selected="";
				var paramPjtcode = "${param.pjt_code}" ;
				for(var i=0; i<projectList.length ; i++){
					var pjt_code = projectList[i].PJT_CODE;
					var pjt_code = projectList[i].PJT_CODE;
					selected ="";
					if(paramPjtcode==pjt_code)
						selected = "selected";
					$("#sProject").append("<option value=\""+ projectList[i].PJT_CODE +"\"  "+ selected+">" + projectList[i].PJT_CODE +"</option>" );
				}		
			}
		});
	}
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		var pjt_code= $("#sProject").val();
		//$("#issueUnresolved").attr("src","issueUnresolved.html?pjt_code="+pjt_code);
		//$("#codesonar").attr("src","projectOneStackByPCntDate.html?version=test&pjt_code="+pjt_code);
		$("#issueUnresolved").contents().find("#sProject").val(pjt_code); 
		$("#issueUnresolved").contents().find("#sProject").change();
		
		$("#issueTrends").contents().find("#sProject").val(pjt_code); 
		$("#issueTrends").contents().find("#sProject").change();
		
		$("#codesonar").contents().find("#sProject").val(pjt_code); 
		$("#codesonar").contents().find("#sProject").change();
	}
	</script>
	<style type="text/css">
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        /* border:0; */
	     }      
		
		iframe {
		   border: none;
		   frameborder:0;
		 } 
	</style>
	
</head>
<body >
<form name="form" id="form" >
<input type="hidden" name="version" value=""/>
<select name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson()">
	<option>PROJECT SELECT</option>
</select>
<iframe frameborder="0" id="issueUnresolved" src="issueUnresolved.html?pjt_code=${param.pjt_code}" style="width: 100%;height: 40%;"></iframe>
<iframe frameborder="0" id="issueTrends" src="issueTrends.html?pjt_code=${param.pjt_code}" style="width: 49%;height: 45%;"></iframe>
<iframe frameborder="0" id="codesonar" src="projectOneStackByPCntDate.html?pjt_code=${param.pjt_code}" style="width: 49%;height: 45%;"></iframe>
</form>
</body>
</html>

