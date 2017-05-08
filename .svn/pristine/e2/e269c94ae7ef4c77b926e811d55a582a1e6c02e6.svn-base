<%--
자바스크립트에서 외부자원을 호출할 수 있도록 한다.
 --%>
<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>issueTrends</title>
    
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script type="text/javascript">
	$(function () {
		/* var jsname = "http://chanjoo.hynix.com:8080/dashboard/js/test/test1.js"
		var fileref=document.createElement('script');
		fileref.setAttribute("type","text/javascript");
		fileref.setAttribute("src", jsname); */
		
		$.ajax({
			url : "http://chanjoo.hynix.com:8080/dashboard/js/test/test.js",
			type: "post",
			data: {},
			dataType: "text" ,
			success : function(responseData){
				eval(responseData);
				
			}
		});	
	});
	
	</script>
	<style type="text/css">
		html,  body, form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	     }
	      
		
		#container {
			width: 100%;
			height: 100%;			
		}	
		
		
		
	</style>
</head>
<body>
<form name="form" id="form">
<div id="container"></div>
</form>
</body>
</html>
