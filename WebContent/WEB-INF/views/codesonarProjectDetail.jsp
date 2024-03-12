<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>codesonarProjectDetail</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <script src="js/jquery.csv-0.71.js"></script>
	<script src="js/highcharts/src/highcharts.src.js"></script>
	<script src="js/highcharts/src/highcharts-more.src.js"></script>
	<script src="js/highcharts/src/exporting.src.js"></script>
	<script src="js/highcharts/modules/no-data-to-display.src.js"></script>
	
	<!-- Additional files for the Highslide popup effect -->
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	
	<script type="text/javascript">
	$(document).ready(function(){
		//$("#makeitmove").draggable( {containment: "#containerPie", scroll: false} );
	});
	
	$(function () {
		projectListByAjax();
	});
	
	function testMessage(){
		alert("ggg");
	}
	
	var responseDataG = {};
	var responseDataPieG = {};
	var projectListG = {};
	var projectListRawG = {};
	var projectMapG = {};
	var projectInfoG = {};
	
	var total = 0;
	
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/codesonarProjectDetailProjectListJson.do",
			data: {},
			success : function(responseData){
				//01. 전역변수설정
				projectInfoG = responseData;
				projectListG = responseData.projectList;
				projectMapG = responseData.projectMap
				var paramPjtcode = "${param.pjt_code}" ;
				var selected ="";
				
				//02. 프로젝트리스트표시
				for(var i=0; i<projectListG.length ; i++){
					var pjt_code = projectListG[i].PJT_CODE;
					selected ="";
					if(paramPjtcode==pjt_code){
						//alert($("#sProject").val());
						selected = "selected";
					}
					
					$("#sProject").append("<option value='"+ projectListG[i].PJT_CODE +"' "+selected+">" + projectListG[i].PJT_CODE +"</option>" );
					
				}
				
				
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
	
	function projectListByAjaxBack1(){
		$.ajax({
			url : "/dashboard/codesonarProjectDetailProjectListJson.do",
			data: {},
			success : function(responseData){
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
				projectListG = projectList;
				var paramPjtcode = "${param.pjt_code}" ;
				var selected ="";
				
				projectList.sort(function(a, b){
					var project1 = a.project.toUpperCase();
					var project2 = b.project.toUpperCase();
					if(project1 == project2)
						return 0;
					return project1> project2? 1: -1;
					//return a.project >  b.project;
				});
				for(var i=0; i<projectList.length ; i++){
					if(projectList[i].state != "Finished")
						continue;
					var pjt_code = projectList[i].project;
					selected ="";
					if(paramPjtcode==pjt_code)
						selected = "selected";
					
					$("#sProject").append("<option value='"+ projectList[i].project +"' "+selected+">" + projectList[i].project +"</option>" );
					
				}	
				if(paramPjtcode != "")
					getDataByJson(true);
			}
		});
	}
	
	
	function projectListByAjaxBack(){
		$.ajax({
			url : "/dashboard/projectListByJson.do",
			data: {},
			success : function(responseData){
				var projectList = responseData.projectList;
				var projectListG = projectList;
				var paramPjtcode = "${param.pjt_code}" ;
				var selected ="";
				
				for(var i=0; i<projectList.length ; i++){
					var pjt_code = projectList[i].PJT_CODE;
					selected ="";
					if(paramPjtcode==pjt_code)
						selected = "selected";
					
					$("#sProject").append("<option value='"+ projectList[i].PJT_CODE +"' "+selected+">" + projectList[i].PJT_CODE +"</option>" );
					
				}	
				if(paramPjtcode != "")
					getDataByJson(true);
			}
		});
	}
	
	
	/**
	*@param: changeOption boolean 검색옵션변경여부
	*/
	function getDataByJson(){
		if( $("#sProject").val() == "")
			return;
		 
		var parameter = {};
		parameter.PJT_CODE = $("#sProject").val();		
		parameter.url = getUrlByPjtcode(parameter.PJT_CODE,"url");
		parameter.server = getUrlByPjtcode(parameter.PJT_CODE,"server");
		
		$.ajax({
			//type: "POST",
			url : "/dashboard/codesonarProjectDetailJson.do",
			data: parameter,
			//modelAttribute:"searchVO",
			success : function(responseData){
				var jsondata = $.csv2Dictionary(responseData.data);				
				responseDataG = jsondata;
				drawChart11(jsondata);
				drawChart21(jsondata);
				$("#container22").html("");
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
	
	function getUrlByPjtcodeBack(pjtcode,pCol){
		for(var i=0;i<projectListG.length;i++){
			var project = projectListG[i];
			if(project.project == pjtcode)
				return project[pCol];
		}
	}
	
	function getDataByJsonPie(pjt_code,priority){
		
		var parameter = {PJT_CODE:pjt_code,PRIORITY:priority};		
		$.ajax({
			type: "POST",
			url : "/dashboard/issueUnresolvedPieJson.do",
			data: parameter,
			//modelAttribute:"searchVO",
			success : function(responseData){
				responseDataPieG = responseData;
				drawChartPie(priority,responseData);
			}
		});
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
			url : "/dashboard/codesonarPriorityCsvLinkJson.do",
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
	
	/** codesonar link file **/
	function getCodesonarFileCsvLink(pjtCode,filename){
		var linkUrl = "";
		linkUrl = "<span style=\"cursor: pointer;\" onclick=\"htmlExpandFile('"+pjtCode+ "','" +filename+  "')\">"+filename+"</span>";
		return linkUrl;
	}
	
	function htmlExpandFile(pjtCode,file,obj){
		var linkUrl = "";		
		$.ajax({
			url : "/dashboard/codesonarPriorityCsvLinkJson.do",
			async: false,
			data: {PJT_CODE: pjtCode },
			//data: $("#form").serialize(),
			success : function(responseData){
				var list = responseData.data;
				for(var i=0;i<list.length;i++){
					var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
					var csvnum = list[i].CSV_NUM;
					var link = "http://"+svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=file="+file;
					linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">"+list[i].PJT_CODE + ": "+file +"<span>";
					linkUrl +="<br/>";
				}
			}
		});
		
		var e = this.event;
		
		// hs.Expand 두번뜨는것 방지
		for(var i=0 ;i<hs.expanders.length;i++){
			if(hs.expanders[i] == null)
				continue;
			else
				hs.expanders[i].close();
			//if(hs.expanders[i].maincontentText ==  linkUrl)
			//	hs.expanders[i].close(); //return;
		}
		
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
	
	
	/** codesonar link function **/
	function getCodesonarFunctionCsvLink(pjtCode,filename){
		var linkUrl = "";
		linkUrl = "<span style=\"cursor: pointer;\" onclick=\"htmlExpandFile('"+pjtCode+ "','" +filename+  "',this)\">"+filename+"</span>";
		return linkUrl;
	}
	
	function htmlExpandFunction(pjtCode,file,func){
		var linkUrl = "";
		$.ajax({
			url : "/dashboard/codesonarPriorityCsvLinkJson.do",
			async: false,
			data: {PJT_CODE: pjtCode },
			//data: $("#form").serialize(),
			success : function(responseData){
				var list = responseData.data;
				for(var i=0;i<list.length;i++){
					var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
					var csvnum = list[i].CSV_NUM;
					var link = "http://"+svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=(file="+file+")"+" procedure=&#34;"+func+"&#34;";
					linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">"+ file + ": "+ func +"<span>";
					linkUrl +="<br/>";
				}
			}
		});
		
		
		var e = this.event;
		
		// hs.Expand 두번뜨는것 방지
		for(var i=0 ;i<hs.expanders.length;i++){
			if(hs.expanders[i] == null)
				continue;
			else
				hs.expanders[i].close();
			//if(hs.expanders[i].maincontentText ==  linkUrl)
			//	hs.expanders[i].close(); //return;
		}
		
		hs.htmlExpand(null, {
            pageOrigin: {
                x: e.pageX || e.clientX,
                y: (e.pageY || e.clientY)  + 52 //$(e.target).height() + 30//+ e.currentTarget.offsetHeight + 30
            },
            headingText: 'codesonar link',
            maincontentText: linkUrl,
            width: 300
        })
	}
	
	
	/** hsClick **/
	function hsClick(url,obj){
		window.open(url, '_blank');
		//window.focus();
		//hs.close(obj);
	}
	
	function drawChart11(responseData){				
		var data = responseData;	
		
		//01. prioriy xcategory
		var dataH = groupby(data,'priority');
		
		$('#container11').highcharts({
	        chart: {
	        	plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false,
	        	zoomType: 'x'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: ''
	        },
	        subtitle: {
	            text: ''
	        },
	       
	        plotOptions: {
	        	series: {
	                cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function (e) {
	                            drawChart12(this.name,data);
	                            htmlExpandPriority($("#sProject").val(),this.name);
	                        }
	                    }
	                }
	            },
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                dataLabels: {
	                    enabled: true,
	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
	                    style: {
	                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
	                    }
	                }
	            }
	        },
	        tooltip: {
	            valueSuffix: ''  
	        }, 
	        
	        legend: {
	        	enabled: false
	           
	        },
	        series:[{
	        	type:'pie',
				name:"Issue Type",
				data:dataH
			}]
	    },function(){
	    	//$("#containerPie").preppend('<div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="legentControl()"  value="all" /></div>')
	    	/* <div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="legentControl()"  value="all" /></div> */
	    	drawChart12('',responseData);
	    });		
	}
	
	
	
	
	function drawChart12(priority,responseData){				
		var data = responseData;	
		
		
		//01. prioriy xcategory
		var xcategory = [];
		var dataA = [];
		
		if(priority != ''){
			dataA = $.grep(data,function(d){			
				if(d.priority == priority)
					return d;
			});
		}else{
			dataA = responseData;
		}
		
		var dataB = groupby(dataA, 'class');
		var dataH = [];
		total = 0;
		for(var i=0;i<dataB.length;i++){
			total += dataB[i][1];
		}
		
		dataB.sort(function(a, b){
			return b[1] - a[1];
		});
		
		for(var i=0;i<dataB.length;i++){
			
			xcategory.push(dataB[i][0]);
			
			var d = {
				y: 	dataB[i][1],
				percentage : 	(dataB[i][1]/total)*100
			};
			dataH.push(d);
		}
		
		
		//context menu
		var defaultExporting = Highcharts.getOptions().exporting;
		var myExporting = $.grep(defaultExporting.buttons.contextButton.menuItems,function(menu){
			//if(menu.text == "All Class")
				return menu;
		});
		
		myExporting.push(
			{
				separator: true
			},{
				text: 'All Class',
				onclick: function () {
					drawChart12('',responseData);
				}
			}
		);
		
		var linkUrl = getCodesonarPriorityCsvLink($("#sProject").val(),priority);
		
		$('#container12').highcharts({
	        chart: {
	        	type:'bar',
	        	zoomType: 'x'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: linkUrl ,
	            useHTML:true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons:{
	        		contextButton:{
	        			menuItems: myExporting
	        		}
	        	}
	        },
	        xAxis: {
	        	categories: xcategory,
	            title: {
	                text: null
	            }
	        },
	        yAxis: {
	            title: {
	                text: ''
	            },
	            labels:{
	            	overflow: 'justify'
	            },
	            tickInterval: null,
	            min:0
	            
	        },
	        plotOptions: {
	            series: {
	                //cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function () {
	                            //alert('Category: ' + this.category + ', value: ' + this.y);
	                            //getDataByJsonPie( $("#sProject").val() , this.category)
	                        }
	                    }
	                }
	            },
	            bar:{
	            	dataLabels:{
	            		enabled: true ,
	            		format: '<b> {point.y} ( {point.percentage:.1f} % )</b>'
	            	}
	            }
	        },
	        tooltip: {
	            valueSuffix: ''  ,
	            pointFormat: '{series.name}:<b> {point.y} ( {point.percentage:.1f} % )</b>'
	        }, 
	        
	        legend: {
	        	enabled: false
	           
	        },
	        series:[{
				name:"class",
				data:dataH
			}]
	    },function(){
	    	//$(".div-buttonRight").css("display", "block");
	    	//getDataByJsonPie($("#sProject").val(),"");
	    });		
	}	
	
	
	function drawChart21(responseData){				
		var data = responseData;	
		
		
		//01. prioriy xcategory
		var xcategory = [];
		var dataA = data ;
		
		var dataB = groupby(dataA, 'file');
		var dataH = [];
		total = 0;
		for(var i=0;i<dataB.length;i++){
			total += dataB[i][1];
		}
		
		dataB.sort(function(a, b){
			return b[1] - a[1];
		});
		
		for(var i=0;i<dataB.length;i++){
			if(i>19)
				break;
			xcategory.push(dataB[i][0]);
			
			var d = {
				y: 	dataB[i][1],
				percentage : 	(dataB[i][1]/total)*100
			};
			dataH.push(d);
			
		}		
	
		
		$('#container21').highcharts({
	        chart: {
	        	type:'bar',
	        	zoomType: 'x'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: ''
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	        	categories: xcategory,
	            title: {
	                text: null
	            }
	        },
	        yAxis: {
	            title: {
	                text: ''
	            },
	            labels:{
	            	overflow: 'justify'
	            },
	            tickInterval: null,
	            min:0
	            
	        },
	        plotOptions: {
	            series: {
	                cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function () {
	                            //alert('Category: ' + this.category + ', value: ' + this.y);
	                            //getDataByJsonPie( $("#sProject").val() , this.category)
	                            drawChart22(this.category,responseData);
	                            htmlExpandFile($("#sProject").val(),this.category)
	                        }
	                    }
	                }
	            },
	            bar:{
	            	allowPointSelect: true,
	            	dataLabels:{
	            		enabled: true ,
	            		format: '{point.y} ( {point.percentage:.1f} % )'
	            	}
	            }
	        },
	        tooltip: {
	            valueSuffix: ''  ,
	            pointFormat: '{series.name}:<b> {point.y} ( {point.percentage:.1f} % )</b>'
	        }, 
	        
	        legend: {
	        	enabled: false
	           
	        },
	        series:[{
				name:"file",
				data:dataH
			}]
	    },function(){
	    	//drawchart22(responseData);
	    });		
	}
	
	
	function drawChart22(file,responseData){				
		var data = responseData;	
		
		
		//01. prioriy xcategory
		var xcategory = [];
		var dataA = $.grep(data,function(d){			
			if(d.file == file)
				return d;
		}); ;
		
		var dataB = groupby(dataA, 'procedure');
		var dataH = [];
		total = 0;
		for(var i=0;i<dataB.length;i++){
			total += dataB[i][1];
		}
		
		dataB.sort(function(a, b){
			return b[1] - a[1];
		});
		
		for(var i=0;i<dataB.length;i++){
			
			xcategory.push(dataB[i][0]);
			
			var d = {
				y: 	dataB[i][1],
				percentage : 	(dataB[i][1]/total)*100
			};
			dataH.push(d);
		}		
	
		var linkUrl = getCodesonarFileCsvLink($("#sProject").val(),file);
		
		$('#container22').highcharts({
	        chart: {
	        	type:'bar',
	        	zoomType: 'x'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: linkUrl ,
	            useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        xAxis: {
	        	categories: xcategory,
	            title: {
	                text: null
	            }
	        },
	        yAxis: {
	            title: {
	                text: ''
	            },
	            labels:{
	            	overflow: 'justify'
	            },
	            tickInterval: null,
	            min:0
	            
	        },
	        plotOptions: {
	            series: {
	                cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function () {
	                        	htmlExpandFunction($("#sProject").val(),file,this.category);	                        	
	                        }
	                    }
	                }
	            },
	            bar:{
	            	dataLabels:{
	            		enabled: true ,
	            		format: '{point.y} ( {point.percentage:.1f} % )'
	            	}
	            }
	        },
	        tooltip: {
	            valueSuffix: ''  ,
	            pointFormat: '{series.name}:<b> {point.y} ( {point.percentage:.1f} % )</b>'
	        }, 
	        
	        legend: {
	        	enabled: false
	           
	        },
	        series:[{
				name:"procedure",
				data:dataH
			}]
	    },function(){
	    	//drawChart22(responseData);
	    });		
	}
	
	function drawChartPie(priority,responseData){				
		var data = responseData.data;	
		
		//01. prioriy xcategory
		var dataH = [];
		for(var i=0;i<data.length;i++){
			if(data[i].UNRESOLVED == 0)
				continue;
			
			dataH.push(
					[
					 	data[i].ISSUETYPE,
			            data[i].UNRESOLVED
			        ]);
		}
		
		var defaultExporting = Highcharts.getOptions().exporting;
		var searchs = $.grep(defaultExporting.buttons.contextButton.menuItems,function(menu){
			if(menu.text == "All IssueType")
				return menu;
		});
		
		if(searchs.length == 0){
			defaultExporting.buttons.contextButton.menuItems.push(
			{
				separator: true
			},{
				text: 'All IssueType',
				onclick: function () {
					getDataByJsonPie($('#sProject').val(),'');
				}
			}
			
			);
			
		}
		
		
		
		$('#containerPie').highcharts({
	        chart: {
	        	plotBackgroundColor: null,
	            plotBorderWidth: null,
	            plotShadow: false
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: priority
	        },
	        subtitle: {
	            text: ''
	        },
	        /* exporting : {
        		enabled: true,
        		buttons:{
        			contextButton:{
        				menuItems:[{
        					text: 'All IssueType',
        					onclick: function () {
        						getDataByJsonPie($('#sProject').val(),'');
        					}
        				}]
        			}
        		}
	        }, */
	        plotOptions: {
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                dataLabels: {
	                    enabled: true,
	                    format: '<b>{point.name}</b>: {point.percentage:.1f} %',
	                    style: {
	                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
	                    }
	                }
	            }
	        },
	        tooltip: {
	            valueSuffix: ''  
	        }, 
	        
	        legend: {
	        	enabled: false
	           
	        },
	        series:[{
	        	type:'pie',
				name:"Issue Type",
				data:dataH
			}]
	    },function(){
	    	//$("#containerPie").preppend('<div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="legentControl()"  value="all" /></div>')
	    	/* <div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="legentControl()"  value="all" /></div> */
	    	
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
	
	
	
	/**
	 * Grid-light theme for Highcharts JS
	 * @author Torstein Honsi
	 */

	// Load the fonts
	Highcharts.createElement('link', {
	   href: 'http://fonts.googleapis.com/css?family=Dosis:400,600',
	   rel: 'stylesheet',
	   type: 'text/css'
	}, null, document.getElementsByTagName('head')[0]);

	Highcharts.theme = {
	   colors: ["#7cb5ec", "#f7a35c", "#90ee7e", "#7798BF", "#aaeeee", "#ff0066", "#eeaaee",
	      "#55BF3B", "#DF5353", "#7798BF", "#aaeeee"],
	   chart: {
	      backgroundColor: null,
	      style: {
	         fontFamily: "Dosis, sans-serif"
	      }
	   },
	   title: {
	      style: {
	         fontSize: '16px',
	         fontWeight: 'bold',
	         textTransform: 'uppercase'
	      }
	   },
	   tooltip: {
	      borderWidth: 0,
	      backgroundColor: 'rgba(219,219,216,0.8)',
	      shadow: false
	   },
	   legend: {
	      itemStyle: {
	         fontWeight: 'bold',
	         fontSize: '13px'
	      }
	   },
	   xAxis: {
	      gridLineWidth: 1,
	      labels: {
	         style: {
	            fontSize: '12px'
	         }
	      }
	   },
	   yAxis: {
	      minorTickInterval: 'auto',
	      title: {
	         style: {
	            textTransform: 'uppercase'
	         }
	      },
	      labels: {
	         style: {
	            fontSize: '12px'
	         }
	      }
	   },
	   plotOptions: {
	      candlestick: {
	         lineColor: '#404048'
	      }
	   },

  
	   // General
	   background2: '#F0F0EA'
	   
	};

	
	</script>
	<style type="text/css">
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	     }
	      
		.dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 90%;			
		}
		.dashboard-div ul {
		  margin: 0;
		  padding: 0;
		  list-style-type: inherit;
		  /* for flex */
		  display: -webkit-box;      
		  display: -moz-box;  
		  display: -ms-flexbox;   
		  display: -webkit-flex;   
		  display: flex;      
		  height: 50%;
		}
		.dashboard-div ul li {
		  float: left;
		  height: 100%;
		  display: inline-block;
		  *display: inline; 
		  *zoom: 1;
		  width: 49%;
		  height: 100%;		  	  
		}
		.#updateLegend{
		  position:absolute;
		  right: -100;
		  top: 100px;
		  
		}
		
		.div-buttonRight{
		  position:absolute;
		  /* background-color:#abc; */
		  /* right:50px; */
		  right:80px;
		  top:30px;
		  width:29px;
		  height:21px;
		  display: none;
		  /* margin:5px; */
		}
		
	</style>
</head>
<body>
<form name="form" id="form">
<select name="PJT_CODE" id="sProject" size="1"  onchange="getDataByJson(true)" >
	<option>PROJECT SELECT</option>
</select>
<div class="dashboard-div">
	<ul>
		<li id="container11" ></li>
		<li id="container12" ></li>
	</ul>	
	<ul>
		<li id="container21" ></li>
		<li id="container22" ></li>
	</ul>	
</div>
<div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="getDataByJsonPie($('#sProject').val(),'');"  value="all" /></div> 
</form>
</body>
</html>
