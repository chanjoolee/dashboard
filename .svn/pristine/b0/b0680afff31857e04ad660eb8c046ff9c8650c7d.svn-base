<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>pmsProgress</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	
	<!-- Additional files for the Highslide popup effect -->
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	
	<script type="text/javascript">
	$(document).ready(function(){
		//$("#makeitmove").draggable( {containment: "#containerPie", scroll: false} );
	});
	
	$(function () {
		//projectListByAjax();
		//drawChart();
		getDataByJson();
	});
		
	var responseDataG = {};
	var responseDataPieG = {};
	var projectListG = {};
	var projectListRawG = {};
	var projectMapG = {};
	var projectInfoG = {};
	
	var total = 0;
	
	/**
	*@param: changeOption boolean 검색옵션변경여부
	*/
	
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/codesonarProjectDetailProjectListJson.html",
			data: {},
			success : function(responseData){
				//01. 전역변수설정
				projectInfoG = responseData;
				projectListG = responseData.projectList;
				projectMapG = responseData.projectMap
				var paramPjtcode = "${param.pjt_code}" ;
				var selected ="";
				
				
				var projectList1 = $.csv2Dictionary(responseData.projectList1);
				$.each(projectList1,function(index,val){
					val.server = responseData.server1;
				});
				var projectList2 = $.csv2Dictionary(responseData.projectList2);
				$.each(projectList2,function(index,val){
					val.server = responseData.server2;
				});
				
				var projectList = [];
				$.merge(projectList,projectList1);
				$.merge(projectList,projectList2);
				
				projectList.sort(function(a, b){
					var project1 = a.project.toUpperCase();
					var project2 = b.project.toUpperCase();
					if(project1 == project2)
						return 0;
					return project1> project2? 1: -1;
					//return a.project >  b.project;
				});						
				projectListRawG = projectList;
				
				
				if(paramPjtcode != "")
					getDataByJson(true);
			}
		});
	}
	
	function getDataByJson(){
		//if( $("#sProject").val() == "")
		//	return;
		 
		var parameter = {};
		//parameter.PJT_CODE = $("#sProject").val();		
		//parameter.url = getUrlByPjtcode(parameter.PJT_CODE,"url");
		//parameter.server = getUrlByPjtcode(parameter.PJT_CODE,"server");
		
		$.ajax({
			//type: "POST",
			async: true,
			url : "/dashboard/pmsProgressJson.html",
			data: parameter,
			//modelAttribute:"searchVO",
			success : function(responseData){
				drawChart(responseData);
			}
		});
	}
	
	function getUrlByPjtcode(pjtcode,pCol){
		//01. projectList
		for(var i=0;i<projectListG.length;i++){
			var project = projectListG[i];
			if(project.PJT_CODE == pjtcode){
				//02. mapping list
				var rtnArr = [];
				var mapList = $.grep(projectMapG, function (map) {
					if(map.PJT_CODE_MAP == project.PJT_CODE)
						return true;
				});
				
				$.each(mapList,function(index,map){
					$.grep(projectListRawG,function(raw){
						if(raw.project == map.PJT_CODE_RAW && raw.state == "Finished")
							rtnArr.push(raw[pCol]);
					});
				});
				return rtnArr;
			}
				
		}
	}
	
	/** codesonar link  priority **/
	function getCodesonarPriorityCsvLink(pjtCode,priority){
		var linkUrl = "";
		linkUrl += "<span style=\"cursor: pointer;\" onclick=\"htmlExpandPriority('"+pjtCode+ "','" +priority+  "')\">"+priority+"</span>";
		return linkUrl;
	}
	
	function htmlExpandPriority(pjtCode,priority){
		var linkUrl = "";
		$.ajax({
			url : "/dashboard/codesonarPriorityCsvLinkJson.html",
			async: false,
			data: {PJT_CODE: pjtCode },
			//data: $("#form").serialize(),
			success : function(responseData){
				var list = responseData.data;
				for(var i=0;i<list.length;i++){
					var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
					var csvnum = list[i].CSV_NUM;
					var priority1 = "\""+priority+"\"";
					var link = "http://"+ svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=priority=&#34;"+priority+"&#34;";
					linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">"+list[i].PJT_CODE + ": "+priority +"</span>";
					linkUrl +="<br/>";
				}
			}
		});
		
		// hs.Expand 두번뜨는것 방지
		for(var i=0 ;i<hs.expanders.length;i++){
			if(hs.expanders[i] == null)
				continue;
			else
				hs.expanders[i].close();
			//if(hs.expanders[i].maincontentText ==  linkUrl)
			//	hs.expanders[i].close(); //return;
		}
		
		var e = this.event;
		hs.htmlExpand(null, {
            pageOrigin: {
                x: e.pageX || e.clientX,
                y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
            },
            headingText: 'codesonar link',
            maincontentText: linkUrl,
            width: 230
        })
	}
	
	/** hsClick **/
	function hsClick(url,obj){
		window.open(url, '_blank');
		//window.focus();
		//hs.close(obj);
	}
	
	function drawChart(responseData){				
		var series = [];
		var model = responseData.pmsModel;
		var project = responseData.pmsProject;
		var fulldata = [];
		$.merge(fulldata,model);
		$.merge(fulldata,project);
		
		
		//01. category.  pjt_code
		var projects = [];
		for(var i=0;i<model.length;i++){
			projects.push(model[i].PJT_CODE);
		}
		for(var i=0;i<project.length;i++){
			projects.push(project[i].PJT_CODE);
		}
		var category = jQuery.unique(projects);
		
		//02. series. phase
		//02.01 series compose
		var phaseList = [];
		var series = [];
		for(var i=0;i<model.length;i++){
			series.push({
				name: model[i].PHASE
			});
		}		
		//02.02 series data push
		$.each(series,function(indexs,s){			
			s.data=[];
			$.each(category,function(indexc,c){
				var cat = $.grep(fulldata,function(d){
					if(s.name == d.PHASE && c == d.PJT_CODE )
						return true;
				});
				if(cat.length > 0){
					var d = cat[0];
					var dateSplit = d.ACTUAL_START_DATE.split('/');			
					var utcDate = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]);
					d.low = utcDate;	
					
					var dateSplit1 = d.ACTUAL_END_DATE.split('/');			
					var utcDate1 = Date.UTC(dateSplit1[0], dateSplit1[1] -1 , dateSplit1[2]);
					d.y = utcDate1;
					s.data.push(d);
				}
			});
			
			
			
		});	
		
		//03. min	,max
		var min = null;
		var max = null;
		$.each(fulldata,function(index,d){
			if(d.low){
				if(min == null)
					min = d.low;
				else if(min > d.low){
					min = d.low;
				}
				
				if(max == null)
					max = d.y;
				else if (max < d.y)
					max = d.y;
			}
		});
		
		//04. plotLines
		var plotLines = [];
		$.each(model,function(indexs,s){			
			//02.03 plotBand
			var plotLine = {
					color:'red',
					width:1.5,
					value: 0 ,
					dashStyle: 'Solid'//'ShortDash'			
			};
			
			var dateSplit = s.ACTUAL_END_DATE.split('/');			
			var utcDate = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]);
			
			plotLine.value = utcDate;
			plotLines.push(plotLine);	
			
		});	
		
		$('#container').highcharts({
			chart: {
                type: 'bar'
            },
            credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
    
            title: {
                text: ''
            },
    
            xAxis: {
               categories: category 
              
            },
            
    
            yAxis: {
                type: 'datetime'
                ,min: min //Date.UTC(2014, 0, 1)
                ,max:max
               /*  ,labels: {
	                rotation: -45,
	                style: {
	                    fontSize: '13px',
	                    fontFamily: 'Verdana, sans-serif'
	                }
	            } */
	            ,plotLines: plotLines
	            ,dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            },
	            title:{
	            	text:''
	            }
            },
    
            tooltip: {
                formatter: function() {
                    //console.log(this.point);
                    var point = this.point;
                    return '<b>'+ point.category +'</b><br/>'+
                        Highcharts.dateFormat('%y/%m/%e', point.low) + ' - ' +
                        Highcharts.dateFormat('%y/%m/%e', point.y);
                } 
            },
    
            plotOptions: {
                series: {
                    //stacking: 'normal',
                    connectNulls: true // by default
                },
                bar: {
                	grouping:false
                	//,edgeWidth: 0
                	//,groupZPadding: 0
                	//,groupPadding: 0
                	,dataLabels: {
	                    enabled: true,
	                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'black',
	                    inside:true,
	                    format:'{point.options.PHASE}'
                	}
                }
            },
            series: series
	    },function(){
	    	//$("#containerPie").preppend('<div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="legentControl()"  value="all" /></div>')
	    	/* <div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="legentControl()"  value="all" /></div> */
	    	//drawChart12('',responseData);
	    	Highcharts.setOptions(Highcharts.theme);
	    });		
	}
		
	
	
	function groupby(json,pkey){
		var abcArr = json;

		var items = {}, base, key,val ;
		for (var i = 0; i < abcArr.length; i++) {
		    base = abcArr[i];
		   // key = base['priority'];
		    key = base[pkey];
		    //val = 'cnt';
		    // if not already present in the map, add a zeroed item in the map
		    if (!items[key]) {
			items[key] = 0;
		    }
		    // add new item to the map entry
		    items[key]++;
		}

		// Now, generate new array
		var outputArr = [], temp;
		for (key in items) {
		    // create array entry for the map value
		    temp = [key, items[key]]
		    // put array entry into the output array
		    outputArr.push(temp);
		}
		
		return outputArr;
	}
	
	
	</script>
	<style type="text/css">
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
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
<input type="hidden" id="sProject" name="sProject" value="${param.pjt_code}" onchange="getDataByJson();"/>
<div id="container" class="container">
</div>
</form>
</body>
<!-- <script src="js/highcharts/themes/dark-unica.js"></script> -->
<!-- <script src="js/highcharts/themes/sand-signika.js"></script> -->
<script src="js/highcharts/themes/grid-light-pms.js"></script>
</html>
