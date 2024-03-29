<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>codesonar</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script type="text/javascript">
	$(function () {
		$('#codeComplexTrends').on("load" , function(){
			$("#codeComplexTrends").contents().find("#sProject").css("display", "none");			
		});
		
		$('#codeComplexStatus').on("load" , function(){
			$("#codeComplexStatus").contents().find("#sProject").css("display", "none");			
		});
		
		$('#codeComplexHistory').on("load" , function(){
			$("#codeComplexHistory").contents().find("#sProject").css("display", "none");			
		});
				
		projectListByAjax();
	});
	
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/dashboardProjectListJson.do",
			data: {division:'jira'},
			success : function(responseData){
				var projectList = responseData.projectList;
				//var paramPjtcode = $("#sProject").val() ;
				var paramPjtcode ="${param.pjt_code}";
				var selected ="";
				
				for(var i=0; i<projectList.length ; i++){
					var pjt_code = projectList[i].PJT_CODE;
					//var pjt_code = "${pjtId}";
					selected ="";
					
					if(paramPjtcode==pjt_code)
						selected = "selected";
					
					$("[name=PJT_CODE]").append("<option value='"+ projectList[i].PJT_CODE +"' "+selected+">" + projectList[i].PJT_NAME +"</option>" );
				}
				
				// 15-07-03. 임시추가
				$("[name=PJT_CODE]").append("<option value='Peregrine' >" + 'Peregrine' +"</option>" );
				$("[name=PJT_CODE]").append("<option value='Venus' >" + 'Venus' +"</option>" );
				
				
				$("[name=PJT_CODE]").change(function(){
					$("#sProject").val(this.value);
					$("#pjt_name").val($("#sProject option:selected").text());
					
					if($("#sProject").val() != "")
						getDataByJson();
				});
				
				//getDataByJson();
				
			}
		});
	}
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		var pjt_code= $("#sProject").val();
		var pjt_name= $("#pjt_name").val();
				
		//$("#codeComplexTrends").contents().find("#container").html("");
		//$("#codeComplexStatus").contents().find("#container").html("");
		//$("#codeComplexHistory").contents().find("#container").html("");
		
		
		$("#codeComplexTrends").contents().find("#sProject").val(pjt_code);
		$("#codeComplexTrends").contents().find("#pjt_name").val(pjt_name);
		$("#codeComplexTrends").contents().find("#sProject").change();
		
		$("#codeComplexStatus").contents().find("#sProject").val(pjt_code); 
		$("#codeComplexStatus").contents().find("#pjt_name").val(pjt_name);
		$("#codeComplexStatus").contents().find("#sProject").change();	
		
		$("#codeComplexHistory").contents().find("#sProject").val(pjt_code); 
		$("#codeComplexHistory").contents().find("#pjt_name").val(pjt_name);
		$("#codeComplexHistory").contents().find("#sProject").change();	
				
		/* $("#codesonarDetailFunction").contents().find("#sProject").val(pjt_code); 
		$("#codesonarDetailFunction").contents().find("#sFile").val(''); 
		$("#codesonarDetailFunction").contents().find("#sProject").change(); */
		
	}
	
	function drawChartCodesonarClass(pjt_code,priority){		
		/* $("#codesonarDetailClass").contents().find("#sProject").val(pjt_code); 
		$("#codesonarDetailClass").contents().find("#sPriority").val(priority); 
		$("#codesonarDetailClass").contents().find("#sProject").change();	 */
	}
	
	function drawChartCodesonarFunction(pjt_code,file){		
		/* $("#codesonarDetailFunction").contents().find("#sProject").val(pjt_code); 
		$("#codesonarDetailFunction").contents().find("#sFile").val(file); 
		$("#codesonarDetailFunction").contents().find("#sProject").change();	 */
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
		
		.dashboard-div > ul > split {
		  float: left;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 100%;
		  height : 10px;
		  /* height: 700px;		 */  	  
		}
		
		
		.dashboard-div ul #container11{
		  float: left;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 100%;
		  /* height: 700px;		 */  	  
		}
		
		.dashboard-div ul #container21{
		  float: left;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 100%;
		  /* height: 420px;  */
		}
		
		
		
		.dashboard-div ul #container31{
		  float: left;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 100%;
		  /* height: 400px;		  	   */
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
		  /* display: inline-block;	 */	
		}
		
		.result8001 div.boxtitleinner {
		  padding: 5px 10px;
		}
		
		.result8001 > div.content > div.boxtitle  > span{
			color: f333333;
		}
		
		.result8001 div.boxlinkinner {
		  width: 300px;
		  margin-right: 0;
		  float:left;
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
		  	height: 400px;
		  }		  
		  
		  .result8001 > div.content > div#content21 {
		  	height: 600px;
		  	/* width: 49%; */
		  }
		  
		  
		  
		  .result8001 > div.content > div#content31 {
		  	height: 930px;
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
<input type="hidden" name="pjt_name" id="pjt_name"  value="${parma.pjt_name}"/>
<div class="dashboard-div">
<select name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson()" <c:if test="${param.pjt_code != null}"> style="display:none;"   </c:if>>
	<option>PROJECT SELECT</option>
</select>
	<ul><split></split></ul>
	<ul>
		<li id="container11" class="result8001">
			<div class="content pie">
				<div class="boxtitle">
					<div class="boxtitleinner">
						<p style="text-align: center;"><span><span style="font-weight: bold;"><span style="font-size: 16px;">Code Complexity Trends</span></span></span></p>	
					</div>
				</div>		
				<div class="boxtext" id="content11">
					<iframe frameborder="0" id="codeComplexTrends" src="codeComplexTrends.html?pjt_code=${param.pjt_code}&pjt_name=${param.pjt_name}"></iframe>
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
						<p style="text-align: center;"><span><span style="font-weight: bold;"><span style="font-size: 16px;">Current File Status</span></span></span></p>	
					</div>
				</div>		
				<div class="boxtext" id="content21">
					<iframe frameborder="0" id="codeComplexStatus" src="codeComplexStatus.html?pjt_code=${param.pjt_code}&pjt_name=${param.pjt_name}"></iframe>
				</div>
			</div>	
			
		</li>
	</ul>
	<ul><split></split></ul>
	<ul>
		<li id="container31" class="result8001" >
			<div class="content pie">
				<div class="boxtitle">
					<div class="boxtitleinner">
						<p style="text-align: center;"><span><span style="font-weight: bold;"><span style="font-size: 16px;">Risky File History</span></span></span></p>	
					</div>
				</div>		
				<div class="boxtext" id="content31">
					<iframe frameborder="0" id="codeComplexHistory" src="codeComplexHistory.html?pjt_code=${param.pjt_code}&pjt_name=${param.pjt_name}" ></iframe>
				</div>
			</div>	
			
		</li>
		
	</ul>
	<ul><split></split></ul>
</div>
</form>
</body>
</html>

