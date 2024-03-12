<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<%
	//참조사이트:  http://www.grsites.com/generate/group/8000/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Issue</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script type="text/javascript">
	$(function () {
		$('#issueUnresolvedPriority').on("load" , function(){
			$("#issueUnresolvedPriority").contents().find("#sProject").css("display", "none");			
		});
		
		$('#issueUnresolvedType').on("load" , function(){
			$("#issueUnresolvedType").contents().find("#sProject").css("display", "none");			
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
			url : "/dashboard/projectListByJson.do",
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
		$("#issueTrends").contents().find("#sProject").val(pjt_code); 
		$("#issueTrends").contents().find("#sProject").change();
		
		$("#issueUnresolvedPriority").contents().find("#sProject").val(pjt_code); 
		$("#issueUnresolvedPriority").contents().find("#sProject").change();
		
		$("#issueUnresolvedType").contents().find("#sProject").val(pjt_code); 
		$("#issueUnresolvedType").contents().find("#sPriority").val(""); 
		$("#issueUnresolvedType").contents().find("#sProject").change();
	}
	
	
	function drawChartJiraIssueByType(pjt_code,priority){		
		$("#issueUnresolvedType").contents().find("#sProject").val(pjt_code); 
		$("#issueUnresolvedType").contents().find("#sPriority").val(priority); 
		$("#issueUnresolvedType").contents().find("#sProject").change();	
	}
	
	</script>
	<style type="text/css">
		html, body,form {
	        /* height: 100%; */
	        /* width: 100%; */
	        padding: 10;
	        margin: 0;
	        /* border:0; */	        
	     }
	     
	    body{
	    	/* width:90%; */
	    	
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
			padding-bottom: 10px;
			width: 99%;
			height: auto;	
			margin-left: auto;
    		margin-right: auto;
    		margin-bottom: 20px;
    		/* margin-top: 20px;    		 */
    		/* background-color: gray; */
		}
		
		.dashboard-div ul {
		  margin: 0;
		 /*  margin-top:5px; */
		  padding: 0;
		  list-style-type: inherit;
		  /* for flex */
		  display: -webkit-box;
		  display: -moz-box;  
		  display: -ms-flexbox;   
		  display: -webkit-flex;   
		  display: flex;      
		  /* height: 50%; */
		}
		.dashboard-div ul #container11{
		  float: left;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 100%;
		 /*  height: 700px;		 */  	  
		}
		
		.dashboard-div > ul > split {
		  float: left;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 100%;
		  height : 10px;
		  /* height: 700px;		 */  	  
		}
		
		.dashboard-div ul #container21{
		  float: left;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 49%;
		  margin-left:0;
		  /* height: 400px;		  	 */  
		}
		
		.dashboard-div ul #container22{
		  float: left;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 50%;
		  margin-right:0;
		  /* height: 400px;		   */	  
		}
		
		/* .title { 
		    position: relative; 
		    top : -0.5em;
		    margin-left: 1em;
		    display: inline; 
		    background-color: white; 
		} */
		
		.result8001 {
			/* padding-top: 5px; */
			text-align: left;
			/* width: 160px; */
			position: relative;
			z-index: 1;
			/* margin: 0px 0 0 0px; */
			margin-left:auto;
			margin-right:auto;
		}
		
		.result8001 > div.content {
			
			/* border: 1px solid #000000; */
			/* box-shadow: 0px 0px 11px -1px #000; */
			/* -webkit-box-shadow: 0px 0px 11px -1px #000; */
			/* -moz-box-shadow: 0px 0px 11px -1px #000; */
			/* height: 100%; */
			font-family:"Malgun Gothic";
			/* padding-left: 5px; */
		}
		
		.result8001 > div.content > div.boxtitle {
		  margin: 0;
		  background-color: rgba(255,255,255,0.6);
		  border: 1px solid #000000;
		  box-shadow: 0px 0px 11px -1px #000;
		  -webkit-box-shadow: 0px 0px 11px -1px #000;
		  -moz-box-shadow: 0px 0px 11px -1px #000;
		  font-family:"Malgun Gothic";
		  height: 33px;
		  width: 300px;
		}
		
		.result8001 > div.content > div.boxtitle  > span{
			color: f333333;
		}
		
		.result8001 div.boxtitleinner {
		  padding: 5px 10px;
		}
		
		
		.result8001 > div.content > div.boxtext {
		  	margin: 0;
		  	/* padding: 5px 10px; */
		  	background-color: rgba(255,255,255,1);
		  	/* font-family:Arial,"Helvetica Neue",Helvetica,sans-serif; */
		  	/* height: 655px; */
		  	border: 1px solid #000000; 
			box-shadow: 0px 0px 11px -1px #000;
			-webkit-box-shadow: 0px 0px 11px -1px #000;
			-moz-box-shadow: 0px 0px 11px -1px #000;
			overflow: hidden;
		  }
		  
		  .result8001 > div.content > div#content11 {
		  	height: 440px;
		  }		  
		  
		  .result8001 > div.content > div#content21 {
		  	height: 400px;
		  	/* width: 49%; */
		  }
		  
		  .result8001 > div.content > div#content22 {
		  	height: 400px;
		  	/* width: 49%; */
		  }
		  
		
		  
		  
		  
		
		.result8001 h1,h2,h3,h4,h5,h6,ol,ul { display: block; margin: 0; }
		.result8001 h1,h2,h3,h4,h5,h6 { font-weight: bold;  }
		.result8001 p { margin:0; }
		.result8001 { letter-spacing: normal; word-spacing: 0px; white-space: normal; text-transform: none; }
		.result8001 { font-size: 16px; }
		
		
	</style>
	
</head>
<body style="padding: 0;background-color:rgba(204,204,204,0.4);">
<form name="form" id="form" >
<input type="hidden" name="version" value=""/>
<input type="hidden" name="division" value='jira'/>
<input type="hidden" name="sender" value="confluence"/>
<div class="dashboard-div">
<select name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson()" <c:if test="${param.pjt_code != null}"> style="display:none;"   </c:if> >
	<option>PROJECT SELECT</option>
</select>
	<ul><split></split></ul>
	<ul>
		<li id="container11" class="result8001">
			<div class="content pie">
				<div class="boxtitle">
					<div class="boxtitleinner">
						<p style="text-align: center;"><span><span style="font-weight: bold;"><span style="font-size: 16px;">Issue Trend</span></span></span></p>	
					</div>
				</div>		
				<div class="boxtext" id="content11">
					<iframe frameborder="0" id="issueTrends" src="issueTrends.html?pjt_code=${param.pjt_code}"></iframe>
				</div>
			</div>			
		</li>		
	</ul>
	<ul><split></split></ul>	
	<ul>
		<li id="container21" class="result8001" >
			<div class="content pie">
				<div class="boxtitle">
					<div class="boxtitleinner">
						<p style="text-align: center;"><span><span style="font-weight: bold;"><span style="font-size: 16px;">Unresolved Issue (by Priority)</span></span></span></p>	
					</div>
				</div>		
				<div class="boxtext" id="content21">
					<iframe frameborder="0" id="issueUnresolvedPriority" src="issueUnresolvedPriority.html?pjt_code=${param.pjt_code}&sender=confluence"></iframe>
				</div>
			</div>	
			
		</li>
		<li id="container22" class="result8001" >
			<div class="content pie">
				<div class="boxtitle">
					<div class="boxtitleinner">
						<p style="text-align: center;"><span><span style="font-weight: bold;"><span style="font-size: 16px;">Unresolved Issue (by issue type)</span></span></span></p>	
					</div>
				</div>		
				<div class="boxtext" id="content22">
					<iframe frameborder="0" id="issueUnresolvedType" src="issueUnresolvedType.html?pjt_code=${param.pjt_code}&sender=confluence"></iframe>
				</div>
			</div>	
			
		</li>
	</ul>	
	<ul><split></split></ul>
</div>
</form>
</body>
</html>

