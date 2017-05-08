<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!doctype html>
<html>
    <head>
	    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <title>Pivot Demo</title>
        <%-- jquery --%>
        <script src="js/jquery/jquery-1.11.2.js"></script>
		<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
		
		<%-- highcharts --%>
        <script type="text/javascript" src="https://www.google.com/jsapi"></script>
		<script src="js/highcharts/src/highcharts.src.js"></script>
		<script src="js/highcharts/modules/drilldown.src.js"></script>
		<script src="js/highcharts/src/highcharts-more.src.js"></script>
		<script src="js/highcharts/src/exporting.src.js"></script>
        

        <!-- PivotTable.js libs from ../dist -->
        <!-- external libs from cdnjs -->
        <link rel="stylesheet" type="text/css" href="/dashboard/js/pivottable/dist/pivot.css">
		<script type="text/javascript" src="/dashboard/js/pivottable/dist/pivot.js"></script>
		<script type="text/javascript" src="/dashboard/js/pivottable/dist/gchart_renderers.js"></script>
		<!-- <script type="text/javascript" src="/dashboard/js/pivottable/dist/highcharts_renderers.js"></script> -->
        
        <%-- dashboard --%>
        <script src="js/dashboard.js?version=1"></script>
        <script type="text/javascript">
        google.load("visualization", "1", {packages:["corechart", "charteditor"]});
        //$( document ).ready(function() {
        $(function () {        	
        	getDataByJson();
    	});
            
        function getDataByJson(){
    		//jQuery.support.cors = true;
    		
	        
    		$.ajax({
    			url : "/dashboard/performanceJson.html",
    			data: $("#form").serialize(),
    			//type: "POST",
    			//crossDomain: true,
    			//dataType: 'json',
    			success : function(responseData){
    				var derivers = $.pivotUtilities.derivers;
    		        var renderers = $.extend($.pivotUtilities.renderers, 
    		            $.pivotUtilities.gchart_renderers);
    		        
    				$("#output").pivotUI(responseData.dataList, {
    					renderers: renderers,
//     	                derivedAttributes: {
//     	                    "Age Bin": derivers.bin("Age", 10),
//     	                    "Gender Imbalance": function(mp) {
//     	                        return mp["Gender"] == "Male" ? 1 : -1;
//     	                    }
//     	                },
//     	                cols: ["Age Bin"], rows: ["Gender"],
    	                rendererName: "Bar Chart"
    					
    				});
    				
    				
    			}
    		});
    	
    	}
        	
    	
        </script>	
        <style>
            body {font-family: Verdana;}
            html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        
	     }
	     #output {
	     	height: 100%;
	        width: 100%;
	     }
        </style>
        
    </head>
    <body>
        

        <div id="output" style=""></div>

    </body>
    
</html>
