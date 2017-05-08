<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>batchMappingSchedulePmsWithDashboard</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<!-- Additional files for the Highslide popup effect -->
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<script src="js/dashboard.js?version=1"></script>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	
	<script type="text/javascript">	
	$(function () {
		batch();
	});
	
	function batch(pUrlList){
		//var param = '{"voList":'+JSON.stringify(pUrlList)+'}';
		$.ajax({
			//type: "post",
			url : "/dashboard/batchMappingSchedulePmsWithDashboardJson.html",
			//data: {voList : pUrlList} ,
			//data: {urlList : JSON.stringify(pUrlList)},
			datatype:'json',
			contentType: 'application/json',
			success : function(pResponseData){
				var responseData = pResponseData;
				//eval('responseData = ' + pResponseData );
				//var jsondata = $.csv2Dictionary(responseData.data);		
				//var test = "";
				var result = responseData.result;
				$("#container").html(result);
			}
		});	
	}
	
	
	</script>
	<style type="text/css">
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow:hidden;
	     }
	      
		.container{
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
<div id="container" class="container">
</div>
</form>
</body>
</html>
