<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Current Unresolved</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
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
		projectListByAjax();
	});
	
	
	var responseDataG = {};
	var responseDataPieG = {};
	var total = 0;
	
	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	*/
	function projectListByAjax(){
		$.ajax({
			url : "/dashboard/projectListByJson.do",
			data: {division:'jira'},
			success : function(responseData){
				var projectList = responseData.projectList;
				var projectList = responseData.projectList;
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
		 $("#containerPie").html("");
		var parameter = {};
		//var parameter = {PJT_CODE: $("#sProject").val()}
		
		//var parameter = $("#form").serialize();
		parameter.PJT_CODE = $("#sProject").val();
		$.ajax({
			type: "POST",
			url : "/dashboard/issueUnresolvedJson.do",
			data: parameter,
			//modelAttribute:"searchVO",
			success : function(responseData){
				responseDataG = responseData;
				drawChart(responseData);
			}
		});
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
	
	
	/** jira link  priority **/
	function getJiraPriorityCsvLink(pjtCode,priority){
		var linkUrl = "";
		linkUrl += "<span style=\"cursor: pointer;\" onclick=\"htmlExpandPriority('"+pjtCode+ "','" +priority+  "')\">"+priority+"</span>";
		return linkUrl;
	}
	
	function htmlExpandPriority(pjtCode,priority){
		var linkUrl = "";
		$.ajax({
			url : "/dashboard/jiraPkeyLinkJson.do",
			async: false,
			data: {PJT_CODE: pjtCode },
			//data: $("#form").serialize(),
			success : function(responseData){
				var list = responseData.data;
				for(var i=0;i<list.length;i++){
					//var svr = "jira.skhynix.com";
					var pkey = list[i].PKEY;
					//var priority1 = "\""+priority+"\"";
					var link = "http://jira.skhynix.com/issues/?jql=project = " + pkey + " AND resolution = Unresolved";
					link +=" AND priority = "+ priority;		
					linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">"+list[i].PKEY +": " + priority + "</span>";
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
            headingText: 'jira link',
            maincontentText: linkUrl,
            width: 230
        })
	}
	
	
	function htmlExpandIssueType(pjtCode,priority,issuetype){
		var linkUrl = "";
		$.ajax({
			url : "/dashboard/jiraPkeyLinkJson.do",
			async: false,
			data: {PJT_CODE: pjtCode },
			//data: $("#form").serialize(),
			success : function(responseData){
				var list = responseData.data;
				for(var i=0;i<list.length;i++){
					//var svr = "jira.skhynix.com";
					var pkey = list[i].PKEY;
					//var priority1 = "\""+priority+"\"";
					var link = "http://jira.skhynix.com/issues/?jql=project = " + pkey + " AND resolution = Unresolved";
					if(priority != "")
						link +=" AND priority = "+ priority;		
					link +=" AND issuetype =&#34" + issuetype+"&#34";
					linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">"+list[i].PKEY +": " + priority + ", "+ issuetype+"</span>";
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
            headingText: 'jira link',
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
		var data = responseData.data;	
		
		//01. prioriy xcategory
		var xcategory = [];
		var dataH = [];
		total = 0;
		for(var i=0;i<data.length;i++){
			total += data[i].UNRESOLVED;
		}
		
		for(var i=0;i<data.length;i++){
			
			xcategory.push(data[i].PRIORITY);
			
			var d = {
				y: 	data[i].UNRESOLVED,
				percentage : 	(data[i].UNRESOLVED/total)*100
			};
			//dataH.push(data[i].UNRESOLVED);
			dataH.push(d);
		}
		
		
		var title = $("#sProject").val();
		if( window != parent.window )
			title = "Issue Unresolved";
		
		$('#container').highcharts({
	        chart: {
	        	type:'bar'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	            text: title
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
	                            getDataByJsonPie( $("#sProject").val() , this.category)
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
	           // pointFormat: '{series.name}:<b> {point.y} ( {point.percentage:.1f} % )</b>'
	            pointFormat: ':<b> {point.y} ( {point.percentage:.1f} % )</b>'
	        }, 
	        
	        legend: {
	        	enabled: false
	           
	        },
	        series:[{
				name:"priority",
				data:dataH
			}]
	    },function(){
	    	//$(".div-buttonRight").css("display", "block");
	    	getDataByJsonPie($("#sProject").val(),"");
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
		
		var linkUrl = getJiraPriorityCsvLink($("#sProject").val(),priority);
		
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
	            text: linkUrl ,
	            useHTML:true	            
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
	        	series: {
	                cursor: 'pointer',
	                point: {
	                    events: {
	                        click: function () {
	                        	htmlExpandIssueType($("#sProject").val(),priority,this.name);	                        	
	                        }
	                    }
	                }
	            },
	            pie: {
	                allowPointSelect: true,
	                cursor: 'pointer',
	                dataLabels: {
	                    enabled: true,
	                    format: '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
	                    //format: ': {point.percentage:.1f} %',
	                    style: {
	                        color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
	                    }
	                }
	            }
	        },
	        tooltip: {
	            valueSuffix: ''  ,
	            pointFormat: ':<b> {point.y} ( {point.percentage:.1f} % )</b>'
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
		  list-style-type: none;
		  /* for flex */
		  display: -webkit-box;      
		  display: -moz-box;  
		  display: -ms-flexbox;   
		  display: -webkit-flex;   
		  display: flex;      
		  height: 100%;
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
		<li id="container" ></li>
		<li id="containerPie" ></li>
	</ul>	
</div>
<div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="getDataByJsonPie($('#sProject').val(),'');"  value="all" /></div> 
</form>
</body>
<script src="js/highcharts/themes/grid-light-pms.js"></script>
</html>
