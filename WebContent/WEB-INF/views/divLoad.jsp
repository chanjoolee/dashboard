<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
    <title>issueTrends</title>
    
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
	<script type="text/javascript">
	
	
	</script>
	<style type="text/css">
		html,  body, form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
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
			height: 100%;			
		}	
		
		
		
	</style>
</head>
<body>
<form name="form" id="form">
<div id="resultTop" class="dashboard-div"></div>
<script>
	$( "#resultTop" ).load( "/dashboard/projectOneStackByPCntDate.do",{pjt_code:'MercuryPlus'});
	
</script>
<div id="resultDown" class="dashboard-div"></div>
<script>
	/* $( "#resultDown" ).load( "/dashboard/codesonarProjectDetail.do",{pjt_code:'MercuryPlus'},function(response, status, xhr){
		//alert($("#sProject").val());
		//alert(status);
	}); */
	
</script>
</form>

</body>
</html>
