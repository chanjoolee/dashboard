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
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	<script type="text/javascript">
	$(function () {
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
		
		$("#codesonarDetailPriority").contents().find("#container").html("");
		$("#codesonarDetailClass").contents().find("#container").html("");
		$("#codesonarDetailClass").contents().find("#container").html("");
		$("#codesonarDetailFile").contents().find("#container").html("");
		$("#codesonarDetailFunction").contents().find("#container").html("");
		
		$("#codesonarDetailPriority").contents().find("#sProject").val(pjt_code); 
		$("#codesonarDetailPriority").contents().find("#sProject").change();
		
		$("#codesonarDetailClass").contents().find("#sProject").val(pjt_code); 
		$("#codesonarDetailClass").contents().find("#sPriority").val(''); 
		$("#codesonarDetailClass").contents().find("#sProject").change();	
		
		$("#codesonarDetailFile").contents().find("#sProject").val(pjt_code); 
		$("#codesonarDetailFile").contents().find("#sProject").change();	
	}
	
	function drawChartCodesonarClass(pjt_code,priority){		
		$("#codesonarDetailClass").contents().find("#sProject").val(pjt_code); 
		$("#codesonarDetailClass").contents().find("#sPriority").val(priority); 
		$("#codesonarDetailClass").contents().find("#sProject").change();	
	}
	
	function drawChartCodesonarFunction(pjt_code,file){		
		$("#codesonarDetailFunction").contents().find("#sProject").val(pjt_code); 
		$("#codesonarDetailFunction").contents().find("#sFile").val(file); 
		$("#codesonarDetailFunction").contents().find("#sProject").change();	
	}
	</script>
	<style type="text/css">
		html, body,form {
		    position: relative;
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        /* border:0; */
	     }      
		
		iframe {
		   border: none;
		   frameborder:0;
		   width: 100%;
		   height: 100%;
		 } 
		 
		 .dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 90%;			
		}
		.dashboard-div ul {
		  margin: 0;
		  padding: 0;
		  list-style-type: inherit;
		  /* for flex */
		  display: -webkit-box;      
		  display: -moz-box;  
		  display: -ms-flexbox;   
		  display: -webkit-flex;   
		  display: flex;      
		  height: 50%;
		}
		.dashboard-div ul li {
		  float: left;
		  height: 100%;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 49%;
		  height: 100%;		  	  
		}
	</style>
	
</head>
<body >
<form name="form" id="form" >
<input type="hidden" name="version" value=""/>
<select name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson()">
	<option>PROJECT SELECT</option>
</select>

<div class="dashboard-div">
	<ul>
		<li id="container11" ><iframe frameborder="0" id="codesonarDetailPriority" src="codesonarDetailPriority.html?pjt_code=${param.pjt_code}"></iframe></li>
		<li id="container12" ><iframe frameborder="0" id="codesonarDetailClass" src="codesonarDetailClass.html?pjt_code=${param.pjt_code}" ></iframe></li>
	</ul>	
	<ul>
		<li id="container21" ><iframe frameborder="0" id="codesonarDetailFile" src="codesonarDetailFile.html?pjt_code=${param.pjt_code}" ></iframe></li>
		<li id="container22" ><iframe frameborder="0" id="codesonarDetailFunction" src="codesonarDetailFunction.html?pjt_code=${param.pjt_code}" ></iframe></li>
	</ul>	
</div>
</form>
</body>
</html>

