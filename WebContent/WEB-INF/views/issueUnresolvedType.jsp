<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>IssueUnresolved Type</title>
<script src="js/jquery/jquery-1.11.2.min.js"></script>
<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
<script src="js/highcharts/src/highcharts.src.js"></script>
<script src="js/highcharts/src/highcharts-more.src.js"></script>
<script src="js/highcharts/src/exporting.src.js"></script>
<script src="js/highcharts/modules/no-data-to-display.src.js"></script>

<script src="js/dashboard.js?version=2017.05.26"></script>


<!-- Additional files for the Highslide popup effect -->
<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
<script type="text/javascript" src="js/highslide/highslide.config.js"
	charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />

<script type="text/javascript">
	$(document).ready(function() {
		//$("#makeitmove").draggable( {containment: "#containerPie", scroll: false} );
	});

	$(function() {
		var sender =  "${param.sender}";
		if(sender == 'pms'){
			//document.domain = 'hynix.com';
		}	
		projectListByAjax();
	});

	/**
	Combo박스용. 프로젝트리스트를 가져온다.
	 */
	function projectListByAjax() {
		$.ajax({
			url : "/dashboard/projectListByJson.html",
			data : {
				division : 'jira'
			},
			success : function(responseData) {
				var projectList = responseData.projectList;
				var projectList = responseData.projectList;
				var paramPjtcode = "${param.pjt_code}";
				var selected = "";

				for (var i = 0; i < projectList.length; i++) {
					var pjt_code = projectList[i].PJT_CODE;
					selected = "";
					if (paramPjtcode == pjt_code)
						selected = "selected";

					$("#sProject").append(
							"<option value='"+ projectList[i].PJT_CODE +"' "+selected+">"
									+ projectList[i].PJT_CODE + "</option>");

				}
				if (paramPjtcode != "")
					getDataByJsonPie($("#sProject").val());
			}
		});
	}

	function getDataByJsonPie(pjt_code) {
		var priority = $("#sPriority").val();
		var parameter = {
			PJT_CODE : pjt_code,
			PRIORITY : priority
		};
		$.ajax({
			type : "POST",
			url : "/dashboard/issueUnresolvedPieJson.html",
			data : $("#form").serialize() ,
			//modelAttribute:"searchVO",
			success : function(responseData) {
				responseDataG = responseData;
				drawChartPie(priority, responseData);
			}
		});
	}

	function drawChartPie(priority, responseData) {
		var dataRaw = responseData.data;
		var data = [];

		//subProject별로 된 데이타를 project별로 합친다. 2015-05-11.
		var dtwo = {
			ISSUETYPE : ""
		};
		for (var i = 0; i < dataRaw.length; i++) {
			if (dtwo.ISSUETYPE != dataRaw[i].ISSUETYPE) {
				if (dtwo.PJT_CODE != undefined && dtwo.UNRESOLVED != 0)
					data.push(dtwo);
				dtwo = {
					PJT_CODE : dataRaw[i].PJT_CODE,
					ISSUETYPE : dataRaw[i].ISSUETYPE,
					UNRESOLVED : dataRaw[i].UNRESOLVED
				};
			} else {
				dtwo.UNRESOLVED += dataRaw[i].UNRESOLVED;
			}
		}
		if (dtwo.UNRESOLVED != 0)
			data.push(dtwo);

		//01. prioriy xcategory
		var dataH = [];
		for (var i = 0; i < data.length; i++) {
			if (data[i].UNRESOLVED == 0)
				continue;
			dataH.push([ data[i].ISSUETYPE, data[i].UNRESOLVED ]);
		}

		var defaultExporting = Highcharts.getOptions().exporting;
		var searchs = $.grep(defaultExporting.buttons.contextButton.menuItems,
				function(menu) {
					if (menu.text == "All IssueType")
						return menu;
				});

		if (searchs.length == 0) {
			defaultExporting.buttons.contextButton.menuItems.push({
				separator : true
			}, {
				text : 'All IssueType',
				onclick : function() {
					$('#sPriority').val("");
					getDataByJsonPie($('#sProject').val());
				}
			}

			);

		}

		var linkUrl = getJiraPriorityCsvLink($("#sProject").val(), priority);

		$('#container')
				.highcharts(
						{
							chart : {
								plotBackgroundColor : null,
								plotBorderWidth : null,
								plotShadow : false
							},
							credits : {//gets rid of the highcharts logo in bottom right
								enabled : false
							},
							title : {
								text : linkUrl,
								useHTML : true
							},
							subtitle : {
								text : ''
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
							plotOptions : {
								series : {
									cursor : 'pointer',
									point : {
										events : {
											click : function() {
												htmlExpandIssueType($(
														"#sProject").val(),
														priority, this.name);
											}
										}
									}
								},
								pie : {
									allowPointSelect : true,
									cursor : 'pointer',
									dataLabels : {
										enabled : true,
										format : '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
										distance : -30,
										//format: ': {point.percentage:.1f} %',
										style : {
											color : (Highcharts.theme && Highcharts.theme.contrastTextColor)
													|| 'black'
										}
									}
								//,center: ["50%","50%"]
								}
							},
							tooltip : {
								valueSuffix : '',
								pointFormat : ':<b> {point.y} ( {point.percentage:.1f} % )</b>'
							},

							legend : {
								enabled : false

							},
							series : [ {
								type : 'pie',
								name : "Issue Type",
								data : dataH
							} ]
						}, function() {
							//$("#containerPie").preppend('<div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="legentControl()"  value="all" /></div>')
							/* <div class="div-buttonRight"><input type="button" id="updateLegend"  onclick="legentControl()"  value="all" /></div> */

						});
	}
</script>
<style type="text/css">
html, body, form {
	height: 100%;
	width: 100%;
	padding: 0;
	margin: 0;
	overflow: hidden;
}

.container {
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
		<input type="hidden" name="PRIORITY" id="sPriority" /> <select
			name="PJT_CODE" id="sProject" size="1"
			onchange="getDataByJsonPie(this.value)"
			<c:if test="${param.pjt_code != null}"> style="display:none;"   </c:if>>
			<option>PROJECT SELECT</option>
		</select>
		
		<%-- 검색조건추가 2015-09-25 --%>
		<input type="hidden" name="userId" value="${param.userId}"/>
		<input type="hidden" name="solution" value="${param.solution}"/>
		<input type="hidden" name="url" value="issueTrends.html"/>
		
		<div id="container" class="container">
	</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
<script>
Highcharts.theme = {
		colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', 
		             '#FF9655', '#FFF263', '#6AF9C4']
}
Highcharts.setOptions(Highcharts.theme);
</script>
</html>
