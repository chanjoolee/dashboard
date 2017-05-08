<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>대시보드</title>
<script src="js/jquery/jquery-1.11.2.min.js"></script>
<script type="text/javascript">
	var selectedProject = "";
	var selectedTab = "tab1";
	$(function () {
		<c:forEach items="${projectList}" var="list" varStatus="status">
    		<c:if test="${status.index == 0 }">
    			drawchart("${list.PJT_CODE}","tab1");
    		</c:if>
   	 	</c:forEach>	
	});
	
	function drawchart(pjtCode){
		
		selectedProject = pjtCode;
		var targetHtml = $("#"+selectedTab).attr("target") + ".html?pjt_code=" + selectedProject;
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
	}
	
	function selectTab(tab){		
		selectedTab = tab;
		var targetHtml = $("#"+tab).attr("target") + ".html?pjt_code=" + selectedProject;
		$("#dashboardContent").attr("src",targetHtml);
		
		$("#tab1").attr("class","off");
		$("#tab2").attr("class","off");
		$("#tab3").attr("class","off");
		$("#"+selectedTab).attr("class","on");
	}
</script>
<style>

/* 공통 */
html, body,form {
	        height: 98%;
	        width: 100%;
	        padding: 10;
	        margin: 0;
	        /* border:0; */	
	       /*  overflow: hidden;       */  
	     }
	     


iframe {
		   border: none;
		   frameborder:0;
		   width: 100%;
		   height: 100%;
} 

#wrap{
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			/* padding-bottom: 10px; */
			width: 98%;
			height: 88%;
			margin-left: auto;
    		margin-right: auto;
    		margin-bottom: 20px;
    		/* margin-top: 20px;    		 */
    		/* background-color: gray; */
    		background:url(img/bg01.gif) repeat-y left}


.gary_box{width:98%; height:10%;border:1px solid #c5c9d0; background:#e1e5eb url(img/bg02.gif) no-repeat left; position:relative; margin: auto;margin-left: auto;margin-right: auto;}
.gary_box .txt_box{width:450px; position:absolute; text-align:left; color:#333; font-size:12px; right:10px; top:25px; line-height:22px}
/* .gary_box {display:none;} */


#contents{width:auto;height:100%; background:#f3f3f3; float:left; position: relative;margin-right: auto;}
.content{width:100%; height:100%;margin-left:0px; padding:0px 0}

/* .content:after {content:""; display:block; clear:both;}  */

/* LNB */
#lnb{width:200px; background:#354052; float:left; font-weight:bold}

#lnb .menu{margin:10px 0 10px 22px}

#lnb ul, li	{list-style:none; margin:0; padding:0}
#lnb li{padding:9px 0; background:url(img/left_bg.gif) repeat-x  bottom; font-size:14px; font-weight:bold}

#lnb .off a:link, a:visited, a:active {text-decoration:none; color:#8d95a1;}
#lnb .off a{display:inline-block; width:100%}
#lnb .off a:hover{color:#fff;cursor: pointer;}

#lnb .on{background-color:#263246;}
#lnb .on a{text-decoration:none; color:#fff; display:block; width:100%; background:url(img/left_arrow.gif) no-repeat; background-position:120px 8px;  }


body{font-family:'Malgun Gothic', arial, dotum, gulim; color:#676767; line-height:1.3em;}
/*a:link, a:visited, a:active {font-family:'Malgun Gothic', arial, gulim, dotum; text-decoration:none;}
a:hover {text-decoration:none;}*/
a img, fieldset {border:0;}

/* 탭 */
.content table{width:100%; }

.content table, th, td, tr, a{border-collapse:collapse}

.tab {margin-bottom:0px}
.tab td{text-align:center; font-size:13px; font-weight:bold}

.tab .on a{text-decoration:none; color:#3174c2; width:100%; display:block; padding:15px 0; border-top:1px solid #3174c2; border-right:1px solid #3174c2; border-left:1px solid #3174c2; border-bottom:1px solid #f3f3f3}
.tab .off a{text-decoration:none; color:#fff; width:100%; display:block; padding:15px 0; background:#578fd9; color:#fff; border:1px solid #3174c2; }
.tab .off a:hover{background:none; color:#3174c2; border-top:1px solid #3174c2; border-right:1px solid #3174c2; border-left:1px solid #3174c2; border-bottom:1px solid #f3f3f3;cursor: pointer;}


/* 내용 */
.div-tab{height:10%}
.cont_wrap{width:100%; height: 90%;  border:1px solid #6f7e95}
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
      <!-- 코멘트가 들어가는 자리입니다. -->
    </div>
</div>
<div id="wrap">
	
    <div id="lnb">
        <ul>
        	<c:forEach items="${projectList}" var="list" varStatus="status">
            	<li class="off" id="project${list.PJT_CODE}"><a  onclick="drawchart('${list.PJT_CODE}')"><span class="menu">${list.PJT_CODE}</span></a></li>            
            </c:forEach> 
        </ul>
    </div>
    
    <div id="contents">
        <div class="content">        
            <!-- ## 탭 ## -->
            <div class="div-tab">
            <table class="tab">
                <colgroup>
                    <col width="33%" />
                    <col width="" />
                    <col width="33%" />
                </colgroup>
                <tr>
                  <td class="on" id="tab1" target="issue"><a onclick="selectTab('tab1')" >Issue<br />(by JIRA)</a></td>
                  <td class="off" id="tab2" target="codesonar"><a onclick="selectTab('tab2')">SW Warings<br />(by CodeSonar)</a></td>
                  <td class="off" id="tab3" target="codeComplexity"><a onclick="selectTab('tab3')">Code Complexity<br />(by Perforce)</a></td>
                </tr>
            </table>
            </div>
            <!-- // ## 탭 ## -->
            
            <!-- ## Issue Trend ## -->
            <div class="cont_wrap">
            	<iframe frameborder="0" id="dashboardContent" src=""></iframe>     
            </div>
        
        </div>
    </div>
    
</div>

</body>
</html>

