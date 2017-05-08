<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>LicenseUsageDate</title>
    
    <link rel="stylesheet" type="text/css" href="/nspim/css/style_master_pop.css" />
    
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
    
    <script type="text/javascript" src="js/jqGrid/jquery.jqGrid.src.js"></script>
    <script type="text/javascript" src="js/jqGrid/i18n/grid.locale-kr.js"></script>
    
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/i18n/grid.locale-en.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/jquery.jqGrid-4.4.1/js/jquery.jqGrid.src.js"></script> -->
    <!-- <script type="text/javascript" src="http://www.ok-soft-gmbh.com/jqGrid/json2.js"></script> -->
    
    <%-- 2. high charts --%>
    
	
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
		
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=1"></script>
	
	<%-- 5. local --%>
	
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	<link rel="stylesheet" type="text/css" href="js/jqGrid/css/ui.jqgrid.css" />
	<script type="text/javascript">
	var dataList  = [];
	var dateList  = [];
	var dateTable = [];
	
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		$.ajax({
			url : "/dashboard/licenseUsagePopJson.html",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				dateList = responseData.dateList;
				dateTable = responseData.dateTable;
				drawchart();
				drawTable(dateList,dateTable);
			}
		});
	}
	
	function drawTable(dateList,dateTable) {
		var col  = "";
		var html = "";
		var body = "";
		
		col = " <col width='20%'>";
		
		$.each(dateList, function(i, data) {
			col += " <col width='10%'>";
		});
		
		$("#tblCol").append(col);
		
		html = "<tr>";
		html += "	<th> </th>";
		$.each(dateList, function(i, data) {
			html += "	<td class='txt_center'>"+data.USE_DATE_VAL + "	</td>";
		});
		html += "</tr>";
		
		$("#tblHead").append(html);
		
		$.each(dateTable, function(i, table) {
			body += "<tr>";		
			body += "	<td class='txt_left'>"+table.TYPE + "	</td>";
			body += "	<td class='txt_right'>"+table.D01 + "	</td>";
			body += "	<td class='txt_right'>"+table.D02 + "	</td>";
			body += "	<td class='txt_right'>"+table.D03 + "	</td>";
			body += "	<td class='txt_right'>"+table.D04 + "	</td>";
			body += "	<td class='txt_right'>"+table.D05 + "	</td>";
			body += "	<td class='txt_right'>"+table.D06 + "	</td>";
			body += "	<td class='txt_right'>"+table.D07 + "	</td>";
			body += "	<td class='txt_right'>"+table.D08 + "	</td>";
			body += "	<td class='txt_right'>"+table.D09 + "	</td>";
			body += "	<td class='txt_right'>"+table.D10 + "	</td>";
			body += "	<td class='txt_right'>"+table.D11 + "	</td>";
			body += "	<td class='txt_right'>"+table.D12 + "	</td>";
			body += "	<td class='txt_right'>"+table.D13 + "	</td>";
			body += "	<td class='txt_right'>"+table.D14 + "	</td>";
			body += "	<td class='txt_right'>"+table.D15 + "	</td>";
			body += "	<td class='txt_right'>"+table.D16 + "	</td>";
			body += "	<td class='txt_right'>"+table.D17 + "	</td>";
			body += "	<td class='txt_right'>"+table.D18 + "	</td>";
			body += "	<td class='txt_right'>"+table.D19 + "	</td>";
			body += "	<td class='txt_right'>"+table.D20 + "	</td>";
			body += "	<td class='txt_right'>"+table.D21 + "	</td>";
			body += "	<td class='txt_right'>"+table.D22 + "	</td>";
			body += "	<td class='txt_right'>"+table.D23 + "	</td>";
			body += "	<td class='txt_right'>"+table.D24 + "	</td>";
			body += "	<td class='txt_right'>"+table.D25 + "	</td>";
			body += "	<td class='txt_right'>"+table.D26 + "	</td>";
			body += "	<td class='txt_right'>"+table.D27 + "	</td>";
			body += "	<td class='txt_right'>"+table.D28 + "	</td>";
			body += "	<td class='txt_right'>"+table.D29 + "	</td>";
			body += "	<td class='txt_right'>"+table.D30 + "	</td>";
			body += "	<td class='txt_right'>"+table.D31 + "	</td>";			
			body += "</tr>";
		});
		
		$("#tblBody").append(body);
		
	}
	function drawchart(){
		
		/* alert($("#form").serialize()); */
		
		var avrGroupKeys = ['GBNM','TDATE'];
		
		var series = [];
		// 01 avg
		
		var avrSeries = getDrillDownDataSeries2(
				'',
				dataList ,
				avrGroupKeys ,
				[], //filter
				[{col:'AVR',convert:'y',isnull:null}], //convert
				'TDATE', 
				'AVR',
				{cd: 'GBNM', name:'GBNM'},
				{isGroupby:false}
		);
		
		$.each(avrSeries.series,function(i,s){
			if(s.name == 'PEAK')
				s.color = '#336688';
			
			if(s.name == 'DENIAL')
				s.color = '#616688';
			series.push(s);
		});
		
		var monthgroup = groupbyCount(dataList,['TDATE']);
		// 02 max
		var seriesmax = {
			data : [],
			id :'Max Avail',
			name: 'Max Avail',
			type: 'line',
			color: 'green'
		};
		
		$.each(monthgroup,function(i,month){
			var data = dataFilter(dataList,[{col:'TDATE',val: month.TDATE}]);
			var max = maxValue(data,'AVAIL');
			seriesmax.data.push({y: max});
		});
		series.push(seriesmax);
		
		// 03 min
		var seriesmin = {
			data : [],
			id : '%Used',
			name : '%Used',
			type: 'spline',
			color: 'red'
		};
		
		$.each(monthgroup,function(i,month){
			var data = dataFilter(dataList,[{col:'TDATE',val: month.TDATE}]);
			var max = maxValue(data,'USED');
			seriesmin.data.push({y: max});
		});
		series.push(seriesmin);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		$('#container').highcharts({
	        chart: {
	            type: 'column'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	text:'&nbsp;',
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },	        
	        xAxis:{
	        	categories: avrSeries.category
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }	            
	        },
	        
	        tooltip: {
	            //valueDecimals: 0,
	          	//headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}, {point.point.START_TIME.time:%y/%m/%e}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y:.1f}</b><br/>',
	            shared: true,
	            enabled: true
	        },
	        //legend: legend,
	        plotOptions: {
	            series: {
	            	cursor: 'pointer' ,
	                stacking: 'notmal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.1f}',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
//	                		gotoClassName(e.point.options.PROJECT);
                		} 
	                }
	                	
	            }
	        },	
	        
	        series: series
	    },function(chart){
	    		//after draw chart
		    }
		);
		
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
	     
	     #div-option{
	     	margin-left: 10px;
	     	height: 30px;
			display: block;	     	
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
<form name="form" id="form" >
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="siteNm" name="siteNm" value="${param.siteNm }"/>
<input type="hidden" id="licenseNm" name="licenseNm" value="${param.licenseNm }"/>
<input type="hidden" id="useMonth" name="useMonth" value="${param.useMonth }"/>
<div class="sub_cont">
    	<div class="wrap_a">
			<div id="container" class="container"></div>
		</div>
	</div>
 <!-- List -->
    <table class="sub_list" id='tblExport' style="border:none" >
    <!-- checkbox 영역의 최소폭 50-->
    	<colgroup id="tblCol">	                
	    	<%-- <col width="20%">
	        <col width="10%">
	        <col width="10%">
	        <col width="10%">  
	        <col width="10%"> 
	        <col width="10%"> 
	        <col width="10%">    
	        <col width="10%">   
	        <col width="10%">   
	        <col width="10%">  
	        <col width="10%">  
	        <col width="10%">  
	        <col width="10%">   
	        <col width="10%">   
	        <col width="10%">  
	        <col width="10%">  
	        <col width="10%">  
	        <col width="10%">
	        <col width="10%">
	        <col width="10%">
	        <col width="10%">
	        <col width="10%">  
	        <col width="10%"> 
	        <col width="10%"> 
	        <col width="10%">    
	        <col width="10%">   
	        <col width="10%">   
	        <col width="10%">  
	        <col width="10%">  
	        <col width="10%">  
	        <col width="10%"> 
	        <col width="10%">  --%>
      	</colgroup>
        	<thead id="tblHead">
            	<%-- <tr>
                	<th> </th>
                	<!--  -->
                    <c:if test="${! empty dateList}">
						<c:forEach var="result" items="${dateList}" varStatus="idx">		    	
				    		<td class="txt_center"><c:out value="${result.useDateVal}"/></td>				
						</c:forEach> 
					</c:if>
          			<!--  -->
               	</tr> --%>
       		</thead>
      	<tbody id="tblBody">
			<%-- <c:if test="${! empty licenseUsageSmonthList}">
				<c:forEach var="result" items="${licenseUsageSmonthList}" varStatus="idx">				
			    	<tr>
			    		<td class="txt_left"><c:out value="${result.type}"/></td> 
			    		<td class="txt_right"><c:out value="${result.d01}"/></td>
			    		<td class="txt_right"><c:out value="${result.d02}"/></td>
			    		<td class="txt_right"><c:out value="${result.d03}"/></td>
			    		<td class="txt_right"><c:out value="${result.d04}"/></td>
			    		<td class="txt_right"><c:out value="${result.d05}"/></td>
			    		<td class="txt_right"><c:out value="${result.d06}"/></td>
			    		<td class="txt_right"><c:out value="${result.d07}"/></td>	
			    		<td class="txt_right"><c:out value="${result.d08}"/></td>	
			    		<td class="txt_right"><c:out value="${result.d09}"/></td>	
			    		<td class="txt_right"><c:out value="${result.d10}"/></td>
			    		<td class="txt_right"><c:out value="${result.d11}"/></td>
			    		<td class="txt_right"><c:out value="${result.d12}"/></td>				
					</tr>
			</c:forEach> 
			</c:if>
			<c:if test="${empty licenseUsageSmonthList}">
				<tr class="txt_center"><td colspan="12">no data.</td></tr>
			</c:if> --%>
      	</tbody>
   	</table>
    <!-- // List --> 
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
