<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>대시보드</title>
<!-- <link rel="stylesheet" href="css/style.css"> -->
<link rel="stylesheet" href="css/jdb_popup.min.css">
<script src="js/jquery/jquery-1.11.2.min.js"></script>
<script src="js/jquery/jquery.popupWindow.js"></script>
<script src="js/jdb_popup.min.js"></script>
<script type="text/javascript">
	var selectedProject = "";
	var selectedTab = "tab2";
	var projects = {};
	var projectList = [];
	$(function () {		
		$(".gary_box").click(function(){
			location.reload();
		});
		<c:forEach items="${projectList}" var="list" varStatus="status">
			projects.${list.PJT_CODE} = "${list.PJT_NAME}";
			projectList.push({code:"${list.PJT_CODE}",name:"${list.PJT_NAME}"});
    		<c:if test="${status.index == 0 }">
    			//drawchart("${list.PJT_CODE}","tab2");
    		</c:if>
   	 	</c:forEach>	
   	 loadCodsonarAll();
	   	$( window ).resize(function() {
	   	  adjustHeight();
	   	});
	   	
	   	adjustHeight();
	});
	
	
	function loadCodsonarAll(){
		$("#tab1").attr("class","off");
		$("#tab2").attr("class","on");
		$("#tab3").attr("class","off");
		
		//var targetHtml = "codesonarAll.html";
		var targetHtml = "projectMultiByPCnt.html";
		$("#dashboardContent").attr("src",targetHtml);
	}
	
	function drawchart(pjtCode){
		
		selectedProject = pjtCode;
		var projectName =  "";
		
			
		var targetHtml = $("#"+selectedTab).attr("target") + ".html?pjt_code=" + selectedProject;
		if(selectedTab=='tab3'){
			targetHtml += "&pjt_name="+projects[selectedProject];
		}
		var p = "";
		$("#dashboardContent").attr("src",targetHtml);
		<c:forEach items="${projectList}" var="list" varStatus="status">
			p = "${list.PJT_CODE}".replace(/[()]/g,"\\\\$&");
			$("#project"+p).attr("class","off");
	 	</c:forEach>	
	 	$("#project"+pjtCode.replace(/[()]/g,"\\\\$&")).attr("class","on");
		
		
		$("#tab1").attr("class","off");
		$("#tab2").attr("class","off");
		$("#tab3").attr("class","off");
		$("#"+selectedTab).attr("class","on");
		//imageOriginal();
	}
	
	function selectTab(tab){		
		selectedTab = tab;
		if(selectedProject == ""){
			selectedProject = projectList[0].code;
			$("#project"+selectedProject).attr("class","on");
		}
		var targetHtml = $("#"+tab).attr("target") + ".html?pjt_code=" + selectedProject;
		if(selectedTab=='tab3'){
			targetHtml += "&pjt_name="+projects[selectedProject];
		}
		$("#dashboardContent").attr("src",targetHtml);
		
		$("#tab1").attr("class","off");
		$("#tab2").attr("class","off");
		$("#tab3").attr("class","off");
		$("#"+selectedTab).attr("class","on");
		//imageOriginal();
	}
	
	function imageOriginal(obj){
		/* if(selectedTab == 'tab3'){
			$($("#dashboardContent").contents().find("#codeComplexHistory").contents().find("img")).colorbox({rel:'group1'});
		} */
		//$(obj).colorbox({rel:'group1'});
		//$("#imageLink").attr("href",obj.attr("src"));
		//$("#image").attr("src",obj.attr("src"));
		$(obj).jdbpopup({ effect: "fade" });
		//$("#imageLink").jdbpopup({ effect: "fade" });
		
	}
	
	function adjustHeight(){
		var width = $(window).width();
		var windowH = $(window).outerHeight();
		
		// body margin 10 
		var bodyMargin = 10;
		var hGary = $(".gary_box").outerHeight();
		//wrap margin-top 10
		var wrapMargin = 10;
		//.content padding 10
		var contentPadding = 10;
		//.tab height 
		var tabHeight = $(".tab").outerHeight();		
		
		var tarHeight = windowH - bodyMargin - hGary - wrapMargin - contentPadding*2 - tabHeight -20;
		$(".cont_wrap").css("height",tarHeight + "px");
	}
</script>
<style>
/* 이찬주 */
iframe {
		   border: none;
		   frameborder:0;
		   width: 100%;
		   height: 100%;
} 

/* 공통 */
body, html {padding:0; margin: 0 ; width:100%; height:100%}
body{margin-top:10px;overflow:hidden;}


#wrap{width:1000px; margin-top:10px ;margin-left:auto;margin-right:auto; background:url(img/bg01.gif) repeat-y left}
#wrap:after {content:""; display:block; clear:both;}

.gary_box{width:1000px; height:40px;border:1px solid #c5c9d0; background:#e1e5eb url(img/bg02.gif) no-repeat left; position:relative; margin:0 auto;cursor: pointer;}
.gary_box .txt_box{width:500px; position:relative; text-align:left; color:#333; font-size:13px; right:10px; top:2px; line-height:14px;float:right;}


#contents{width:860px; height: auto; background:#f3f3f3; float:left; }
.content{width:830px; height: auto; margin-left:10px; padding:10px 0}
.content:after {content:""; display:block; clear:both;}

/* LNB */
#lnb{width:140px; background:#354052; float:left; font-weight:bold;}

#lnb .menu{margin:10px 0 10px 22px}

#lnb ul, li	{list-style:none; margin:0; padding:0}
#lnb li{padding:9px 0; background:url(img/left_bg.gif) repeat-x  bottom; font-size:9px; font-weight:bold}

#lnb .off a:link, a:visited, a:active {text-decoration:none; color:#8d95a1;}
#lnb .off a{display:inline-block; width:100%}
#lnb .off a:hover{color:#fff;cursor: pointer;}

#lnb .on{background-color:#263246;}
#lnb .on a{text-decoration:none; color:#fff; display:block; width:100%; background:url(img/left_arrow.gif) no-repeat; background-position:120px 8px }


body{font-family:'Malgun Gothic', arial, dotum, gulim; color:#676767; line-height:1.3em;}
/*a:link, a:visited, a:active {font-family:'Malgun Gothic', arial, gulim, dotum; text-decoration:none;}
a:hover {text-decoration:none;}*/
a img, fieldset {border:0;}

/* 탭 */
.content table{width:100%; }

.content table, th, td, tr, a{border-collapse:collapse}

.tab {margin-bottom:10px}
.tab td{text-align:center; font-size:13px; font-weight:bold}

.tab .on a{text-decoration:none; color:#3174c2; width:100%; display:block; padding:5px 0; border-top:1px solid #3174c2; border-right:1px solid #3174c2; border-left:1px solid #3174c2; border-bottom:1px solid #f3f3f3}
.tab .off a{text-decoration:none; color:#fff; width:100%; display:block; padding:5px 0; background:#578fd9; color:#fff; border:1px solid #3174c2; }
.tab .off a:hover{background:none; color:#3174c2; border-top:1px solid #3174c2; border-right:1px solid #3174c2; border-left:1px solid #3174c2; border-bottom:1px solid #f3f3f3; cursor:pointer;}


/* 내용 */
.cont_wrap{height:595px;width:100%; border:1px solid #6f7e95}
.cont_wrap2{width:100%;}
.cont_wrap2:before{content:""; display:bolck; clear:both}

.cont_tit{width:100%; background:#6f7e95;}
.cont_tit h3{display:block; font-size:14px; color:#fff; padding:15px 0 15px 20px; overflow:hidden; margin:0}

.cont_small{width:48%; margin-top:30px; border:1px solid #6f7e95;}

.f_left{float:left}
.f_right{float:right}
</style>

</head>

<body>
<div class="gary_box">
    <div class="txt_box">    
    This is 1st release of Engineering dashboard.
 	And 2nd release will be in June.
	<br/>In June, we can provide management dashboard and engineering dashboard.
    </div>
</div>



<div id="wrap">

    <div id="lnb">
        <ul>
        	<c:forEach items="${projectList}" var="list" varStatus="status">
            	<li class="off" id="project${list.PJT_CODE}"><a  onclick="drawchart('${list.PJT_CODE}')"><span class="menu">${list.PJT_NAME}</span></a></li>            
            </c:forEach> 
        </ul>
    </div>
    
    <div id="contents">
        <div class="content">
        
            <!-- ## 탭 ## -->
            <table class="tab">
                <colgroup>
                    <col width="33%" />
                    <col width="" />
                    <col width="33%" />
                </colgroup>
                <tr>
                  <td class="on" id="tab1" target="issue"><a onclick="selectTab('tab1')" >Issue&nbsp;(by JIRA)</a></td>
                  <td class="off" id="tab2" target="codesonar"><a onclick="selectTab('tab2')">SW Warnings&nbsp;(by CodeSonar)</a></td>
                  <td class="off" id="tab3" target="codeComplexity"><a onclick="selectTab('tab3')">Code Complexity&nbsp;(by Perforce)</a></td>
                </tr>
            </table>
            
            <div class="cont_wrap">
               <iframe frameborder="0" id="dashboardContent" src=""></iframe>     
            </div>         
        
        </div>
    </div>
    
</div>
<div style="display: none;"><a id="imageLink"><img id="image"></img></a></div>
</body>
</html>

