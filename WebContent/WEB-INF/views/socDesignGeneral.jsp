<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
	
    <title>socDesignGeneral</title>
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
    
	<!-- <script src="js/highcharts/src/highcharts.src.js"></script> -->
	<script src="js/Highstock-2.1.7/js/highstock.src.js"></script>
	<script src="js/highcharts/modules/drilldown.src.js"></script>
	<script src="js/Highstock-2.1.7/js/highcharts-more.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	
	<!-- <script src="js/highcharts/multi-drilldown.js"></script> -->
	
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<script src="js/highcharts/grouped-categories.js"></script>
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.05.26"></script>
	
	<%-- 5. local --%>
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" />
	<script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script>
	<script type="text/javascript">
	var dataList = [];
	var categoryInfo = [
 		      {
 					category:'xxx',
 					calculateCols:[
 						{
 							col:'CATEGORY1',
 							val: function(){
 								return this.PARENT_CATEGORY + '_'+ this.CATEGORY;
 								
 							}
 						}
 					],
 					filters:[
 					         
 					],
 					xOderbyCols:['CATEGORY1','PJT_CODE','PJT_NAME'],
 					groupbyCols:['CATEGORY1','PJT_CODE','PJT_NAME'],
 					groupbyTarget:'CASES',
 					categoryCols:['PJT_NAME'],
 					yCol:'CASES',
 					seriesCol:{cd:'CATEGORY1',name:'CATEGORY1'},
 					multichart:{
 						enabled:false,
 						cols:[]
 					},
 					isGroupby:false
 			 }
	 ]
	$(function () {
		getDataByJson();
	});
	
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		$.ajax({
			url : "/dashboard/socDesignGeneralJson.do",
			data: $("#form").serialize() ,
			success : function(responseData){
				dataList = responseData.dataList;
				drawchart();
			}
		});
	}
	
	function drawchart(){
		
		//01. 데이타필터링
		var vCateInfos = dataFilter(categoryInfo,[{col:'category',val: 'xxx'}]);
	    var vCateInfo ={};
	    var filters = [];
	    if(vCateInfos.length> 0 ){
	    	vCateInfo = vCateInfos[0];
	    	//계산된컬럼	    	
    		$.each(vCateInfo.calculateCols,function(j,c){
    			$.each(dataList,function(i,m){
    				m[c.col] =  c.val.apply(m);
    			});
	    	});
	    	
	    	$.each(vCateInfo.filters,function(i,f){
	    		filters.push(f);
	    	});
	    	
	    }else{
	    	alert('category 정보가 없습니다.' );
	    }
	    
	    var filteredData = dataFilter(dataList, filters);
	    var groupbyData  = groupbySum(filteredData,vCateInfo.groupbyCols,vCateInfo.groupbyTarget);
	    var series = getDrillDownDataSeries2(
				'',
				groupbyData ,
				vCateInfo.xOderbyCols , 
				[], //filter
				[{col:vCateInfo.yCol , convert:'y',isnull:0}], //convert
				vCateInfo.categoryCols[vCateInfo.categoryCols.length-1] , 
				//vCateInfo.categoryCols[0] ,
				'CNT',
				vCateInfo.seriesCol,
				{isGroupby: vCateInfo.isGroupby}
		);
	    
	    series.category = [];
		$.each(series.series[0].data,function(i,d){
			var colvalues = [];
			$.each(vCateInfo.categoryCols,function(){
				colvalues.push(d[this]);
			});
			series.category.push(colvalues);
		});
		
		//카테고리 만들기
		var category1 = [];
		$.each(series.category,function(index,c){
			category1.push(c);
		});
		var category2 = makeGroupCategory(category1);
		series.category = category2;
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		
		$('#container').highcharts({
	        chart: {
	            type: 'column',
	            zoomType: 'xy'
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
	        	categories: series.category
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }	            
	        },
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:{series.color}">{series.name}</span>: <b>{point.y}</b><br/>',
	            shared: true,
	            enabled: true,
	            formatter: function () {
	                var s = '<b>' + this.x + '</b>';

	                $.each(this.points, function () {
	                	if(this.y > 0){
	                		s += '<br/>' + '<span style="color:' + this.series.color + '">' +this.series.name + '</span>: ' + this.y + '';
	                	}
	                });

	                return s;
	            }
	        },
	        //legend: legend,
	        plotOptions: {
	            column: {
	            	cursor: 'pointer' ,
	                stacking: 'normal',
	                marker: {
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f}',
	                    color: 'black'
	                },
	                //enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		var aaa = "";
	                		if(parent != window && parent.goProject)
	                			parent.goProject(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
                		} 
	                }
	                	
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		//after draw chart
		    }
		);
		
	}
	
	
function makeGroupCategory(incoming){
	    
	    function recurseKeys(o) {
	        var arr = [],
	            k = Object.getOwnPropertyNames(o),
	            i, c;
	        for (i = 0; i < k.length; ++i) {
	            if (Object.getOwnPropertyNames(o[k[i]]).length)
	                c = {name: k[i]}, c['categories'] = recurseKeys(o[k[i]]);
	            else
	                c = k[i];
	            arr.push(c);
	        }
	        return arr;
	    }
	    
	    var i, j, o = {}, c, k;

	    for (i = 0; i < incoming.length; ++i) {
	        c = o;
	        for (j = 0; j < incoming[i].length; ++j) {
	            k = incoming[i][j];
	            if (!c[k]) c[k] = {};
	            c = c[k];
	        }
	    }

	    o = recurseKeys(o);
	    
	    return o;
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
<form name="form" id="form" method="post" >
<input type="hidden" name="menuAuthId" id="menuAuthId" value=""/>
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" name="userId" id="userId" value="${param.login_id}"/>
<input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="pjtId" name="pjtId" value=""/>
<input type="hidden" id="pjt_code" name="pjt_code" value=""/>
<input type="hidden" id="pjt_name" name="pjt_name" value=""/>
<div id="container" class="container"></div>
<c:forEach items="${paramValues.pjtCodeList}" var="pjtCode" varStatus="status">
	<input type="hidden" name="pjtCodeList" value="${pjtCode}"/>
</c:forEach>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
