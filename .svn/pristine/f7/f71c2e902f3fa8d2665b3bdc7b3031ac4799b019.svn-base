<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>projectMultiByPCnt</title>
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
	
	
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=1"></script>
	
	<%-- 5. local --%>
	<link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" />
	<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
	
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" />
	
	<script type="text/javascript">
	//01. series데이타. project
	var seriesHigh = new Array();
	var projectMultiSelect ;
	
	$(function () {
		pmsProjectList();
		getDataByJson();
	});
	
	var responseData = {};
	var projectList = [];
	
	function pmsProjectList(){
		$.ajax({
			//url : "/dashboard/dashboardProjectListJson.html",
			url : "/dashboard/pmsProjectListJson.html",
			data: {division:'jira'},
			async : false,
			success : function(pResponseData){
				//var projectList = responseData.projectList;
				//var projectList0 = responseData.dataList;
				//var projectList =	dataFilter(projectList0,[{col:'APPLICATION_ID',val:'SPM_00005011'},{col:'APPLICATION_ID',val:'SPM_00005010'},{col:'APPLICATION_ID',val:'SPM_00005558'}]);
				//var projectList =responseData.projectList;
				//sortObjects(projectList,['APPLICATION_NM','PJT_NAME'])
				responseData = pResponseData;
				projectList =pResponseData.dataList;
				
				var groupKeys = ['DISPLAY_ORDER','PJT_NAME'];
				var series = getDrillDownDataSeries2(
						'',
						projectList ,
						groupKeys ,
						[], //filter
						[], //convert
						'', //xAxis
						'CNT',
						{cd: 'APPLICATION_ID', name:'APPLICATION_NAME'},
						{isGroupby: false}
				);
				
				var selected ="";
				var sb = [];
				$.each(series.series,function(index,s){
					sb.push("<optgroup label=\""+s.name+" (Click)\">");
					$.each(s.data,function(index1,d){
						if(this.APPLICATION_NAME=="Mobile Solution")
							selected = "selected";
						else 
							selected = "selected";
						sb.push("<option value='"+ d.PJT_CODE +"' "+selected+" status='"+d.PJT_STATE+"'>" + d.PJT_NAME +"</option>");
					});
					sb.push("</optgroup>");
				});
				
				$("select[name=pjtCodeList]").append(sb.join(""));
				
				$("select[name=pjtCodeList]").change(function(){
					getDataByJson();
					//drawchart();
				});
				projectMultiSelect = $("select[name=pjtCodeList]").multiselect({
					height:400,
					selectedText: 'Project # selected',
					noneSelectedText: 'Select projects'
				}).multiselectfilter();
				$("div.ui-multiselect-menu").css("width","500px");
				$(".ui-multiselect-filter input").css("width","200px");
				
				//상태표시
				$.each(series.series,function(index,s){
					$.each(s.data,function(index1,d){
						var label = $("input[name=multiselect_pjtCodeList][value="+d.PJT_CODE+"]").parent();
						label.append("<span style='color: blue;float:right;'>"+ d.PJT_STATE_NAME +"</span>");
						
					});
				});
				
				pjtStatus(projectList);
			}
		});
	}
	
	
	function pjtStatus(projectList){
		var status = groupbyCount(projectList,['PJT_STATE','PJT_STATE_NAME']);
		
		var selected ="";
		var sb = [];
		$.each(status,function(){
			if(this.PJT_STATE_NAME=="Proceeding")
				selected = "selected";
			else 
				selected = "";
			sb.push("<option value='"+ this.PJT_STATE +"' "+selected+">" + this.PJT_STATE_NAME +"</option>");
		});
		
		$("select[name=pjtStatus]").append(sb.join(""));
		$("select[name=pjtStatus]").change(function(){
			filterByStatus();
			
		});
		var select = $("select[name=pjtStatus]").multiselect({
			selectedList: 1,
			height:100,
			selectedText: 'Status # selected',
			noneSelectedText: 'Select Status'
		});
		filterByStatus(status);
	}
	
	function filterByStatus(){
		$("select[name=pjtStatus] option").each(function(i,sel){
			if($(this).is(':selected')){
				$("select[name=pjtCodeList] option[status="+$(this).val()+"]").prop( "disabled", false );
				//$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", true );
			}else{
				$("select[name=pjtCodeList] option[status="+$(this).val()+"]").prop( "disabled", true );
				//$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", false );
			}
		});
		$("select[name=pjtCodeList] option").each(function(i,project){			
			$("input[name=multiselect_pjtCodeList][value="+$(this).val()+"]").prop( "disabled", $(this).prop("disabled") );
			if($(this).prop("disabled")){
				$("input[name=multiselect_pjtCodeList][value="+$(this).val()+"]").parent().addClass( "ui-state-disabled" );
				$("input[name=multiselect_pjtCodeList][value="+$(this).val()+"]").attr("checked",false);
				
			}else{
				$("input[name=multiselect_pjtCodeList][value="+$(this).val()+"]").parent().removeClass( "ui-state-disabled" );
			}
			
		});
		
		$("input[name=multiselect_pjtCodeList]").each(function(){
			$("select[name=pjtCodeList] option[value="+$(this).val()+"]").prop( "selected", $(this).is(":checked") );
		});
		
		//projectMultiSelect.multiselect('refresh');
				
		/* var groupKeys = ['DISPLAY_ORDER','PJT_NAME'];
		var series = getDrillDownDataSeries2(
				'',
				projectList ,
				groupKeys ,
				[], //filter
				[], //convert
				'', //xAxis
				'CNT',
				{cd: 'APPLICATION_ID', name:'APPLICATION_NAME'},
				{isGroupby: false}
		); */
		
		projectMultiSelect = $("select[name=pjtCodeList]").multiselect({
			height:400,
			selectedText: 'Project # selected',
			noneSelectedText: 'Select projects'
		}).multiselectfilter();
		//$("div.ui-multiselect-menu").css("width","500px");
		//$(".ui-multiselect-filter input").css("width","200px");
		
		//상태표시
		/* $.each(series.series,function(index,s){
			$.each(s.data,function(index1,d){
				var label = $("input[name=multiselect_pjtCodeList][value="+d.PJT_CODE+"]").parent();
				label.append("<span style='color: blue;float:right;'>"+ d.PJT_STATE_NAME +"</span>");
				
			});
		}); */
		
		getDataByJson();
	}
	
	function legentControl(){
		var chart = $('#container').highcharts(); 
		if(chart == undefined) 
			return;
		
        var legend = chart.legend; 
        
        var btn = $("#updateLegend");
        if($("#legendFloat").val() == "true")
        	$("#legendFloat").val("false");
        else
        	$("#legendFloat").val("true");
        
       drawChart(true);
	}
	
	function getDataByJson(){
		
		$.ajax({
			url : "/dashboard/projectMultiByPCntJson.html",
			//data: {PJT_CODE: $("#sProject").val() },
			data: $("#form").serialize(),
			success : function(pResponseData){
				responseData = pResponseData;
				// 가져온데이타에 필드추가
				//01. resonseData.dataRaw;
				var dataRaw = responseData.dataRaw;
				//01. 1. dataRaw에 필드추가 phaseSeqDt
				for(var i=0;i<dataRaw.length;i++){
					var data = dataRaw[i];
					data.phaseSeqDt = getPhaseSeqDt(data.PJT_CODE,data.PHASE,data.PHASE_SEQ);
				}
				
				drawChart(false);
			}
		});
	}
	
	// 수정된 가상의 날짜를 계산한다.
	function getPhaseSeqDt(pjtCode,phase,phaseSeq){
		var phaseDt = getPhaseDt(phase);
		var phaseDtSplit = phaseDt.split('-');
		var dataCount = responseData.dataCount;
		for(var i=0;i<dataCount.length;i++){
			if(pjtCode == dataCount[i].PJT_CODE && phase == dataCount[i].PHASE){
				var phaseCnt = dataCount[i].CNT;
				var phaseSeqDt = parseInt((phaseSeq-1) *(30/phaseCnt)+2);
				//var phaseSeqDt = parseInt((phaseSeq-1) *(30/phaseCnt));
				//var phaseSeqDt = (phaseSeq) *(30/phaseCnt);
				return phaseDtSplit[0] + '-' + phaseDtSplit[1] + '-' + phaseSeqDt.toString();				
			}
		}
		return 'error';
	}
	
	// 가사의 UTC 날자로 실제 날의 가져올다.
	function getDataByUtc(pjtCode,phaseSeqDtUtc){
		var dataRaw = responseData.dataRaw;
		for(var i=0;i<dataRaw.length;i++){
			var data = dataRaw[i];
			if(data.PJT_NAME == pjtCode && data.phaseSeqDtUTC == phaseSeqDtUtc )
				return data;//data.phaseSeqDt;
		}
		return 'error';
	}
	
	// phase별로 데이타를 가져온다.
	function getPhaseDt(phase){
		var dataPhase = responseData.dataPhase;
		for(var i=0;i<dataPhase.length;i++){
			if(phase == dataPhase[i].PHASE){
				return dataPhase[i].PHASE_DT;
			}			
		}
	}
	
	/**
	* baseLine의 범위가 다른프로젝트 의 범위보다 항상 크므로 series.visible 값에 따라 범위를 조정한다.
	* @param obj:  해당이벤트 series 객체
	*/	
	function adjustBaseLine(obj){
		//alert("aaa");
		//03. visible project 들의 phase 유일값 리스트.
		var chart = $('#container').highcharts();
		
		/* var uSeries = chart.series.filter( function(s){
			if(s.name != 'BaseLine' && s.name != 'BaseLineA')
				return s.visible;
		}); */
		var uSeries;
		uSeries =  $.grep( chart != undefined ? chart.series : seriesHigh , function (item) {
			if(item.name != 'P0-BaseLine' && item.name != 'P1-BaseLine')
				return item.visible;
		});
		
		
		var uSeriesVal = [];
		for(var i = 0; i< uSeries.length;i++){
			uSeriesVal.push(uSeries[i].name);
		}
		
		/* var baseLine = chart.series.filter( function(s){
			if(s.name == 'BaseLine')
				return true;
		}); */
		
		var baseLine = $.grep( chart != undefined ? chart.series : seriesHigh , function(s){
			if(s.name == 'P0-BaseLine')
				return true;
		});
		/* var baseLineA = chart.series.filter( function(s){
			if(s.name == 'BaseLineA')
				return true;
		}); */
		var baseLineA = $.grep(chart != undefined ? chart.series : seriesHigh, function(s){
			if(s.name == 'P1-BaseLine')
				return true;
		});
		baseLine[0].data = [];
		baseLineA[0].data = [];
		
		//04. distinct PhaseList
		var phaseList = [];
		var dataRaw = responseData.dataRaw;
		for(var i=0;i<dataRaw.length;i++){
			//var pjt = dataRaw[i].PJT_CODE;
			var pjt = dataRaw[i].PJT_NAME;
			
			/* var containPjts = uSeriesVal.filter(function(val){
				if(val == pjt)	
					return val;
			}); */
			 var containPjts = $.grep(uSeriesVal, function(val){
					if(val == pjt)	
						return val;
				});
			var phase = dataRaw[i].PHASE;
			if(containPjts.length>0)
				phaseList.push(phase);			
		}
		var phaseListUni = jQuery.unique(phaseList);
		
		//05. baseLine 값조정
		var dataPhase = responseData.dataPhase;
		var minPhase = minValue(phaseListUni);
		var maxPhase =maxValue(phaseListUni);
		$.each(dataPhase,function(index,d){
			if(d.PHASE >= minPhase && d.PHASE <= maxPhase)
				phaseListUni.push(d.PHASE);
		});
		var baseLineData = []; var baseLineDataA = [];
		phaseListUni = jQuery.unique(phaseListUni);
		phaseListUni.sort();
		for (var i = 0; i < phaseListUni.length; i++){	
			/* var phases = dataPhase.filter(function(val){
				if(val.PHASE == phaseListUni[i])
					return val;
			}); */
			var phases = $.grep(dataPhase,function(val){
				if(val.PHASE == phaseListUni[i])
					return val;
			});
			var phase = {};
			if(phases.length > 0)
				phase = phases[0];
			var phaseDtSplit = phase.PHASE_DT.split('-');			
			var utcDt1 = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			var utcDt2 = {};
			
			// to
			if(i < (phaseListUni.length-1)){
				/* var phases1 = dataPhase.filter(function(val){
					if(val.PHASE == phaseListUni[i+1])
						return val;
				}); */
				var phases1 = $.grep(dataPhase , function(val){
					if(val.PHASE == phaseListUni[i+1])
						return val;
				});
				var phase1 = {};
				if(phases1.length > 0)
					phase1 = phases1[0];
				var phaseDtSplit1 = phase1.PHASE_DT.split('-');	
				utcDt2 = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
			}else{//마지막데이타					
				if(phaseDtSplit[1]=='11')
					utcDt2 = Date.UTC(phaseDtSplit[0]+1,0 , 1) ;
				else
					utcDt2 = Date.UTC(phaseDtSplit[0], phaseDtSplit[1] , 1 ) ;
			}
			
			var target = 0; var targetA = 0;
			var chk0 = $('#p0').is(":checked");
			var chk1 = $('#p1').is(":checked");
			var chk2 = $('#p2').is(":checked");
			if(chk0){ target += phase.P0; targetA += phase.PA0;}
			if(chk1){ target += phase.P1; targetA += phase.PA1;}
			if(chk2){ target += phase.P2; targetA += phase.PA2;}
			
			baseLineData.push(
					{
						x: utcDt1, 
						y: target,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						}/* ,
						dataLabels: {
		                    enabled: false,
		                    color: 'red',
		                    style: {
		                        fontWeight: 'bold'
		                    }
		                } */
					},
					{
						x: utcDt2, 
						y:target,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false
		                }
					}
			);
			baseLineDataA.push(
					{
						x: utcDt1, 
						y: targetA,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						}/* ,
						dataLabels: {
		                    enabled: false,
		                    color: 'red',
		                    style: {
		                        fontWeight: 'bold'
		                    }
		                } */
					},
					{
						x: utcDt2, 
						y:targetA,//(phaseListUni.length-i)*80,
						marker:{
							enable: false	
						},
						dataLabels: {
		                    enabled: false
		                }
					}
			);
			
			//baseLineData.push([utcDt1, (phaseListUni.length-i)*80]);
			//baseLineData.push([utcDt2, (phaseListUni.length-i)*80]);
			
		}
		//baseLineData.sort();
		//baseLine[0].data = baseLineData;
		//baseLine[0].setData(baseLineData);
		if(chart != undefined){
			baseLine[0].update({
				data: baseLineData
			});
			baseLineA[0].update({
				data: baseLineDataA
			});
		}else{
			baseLine[0].data = baseLineData;
			baseLineA[0].data = baseLineDataA;
		}
		
	}
	
	/**
	* 기준값에 따라 프로젝트가 보여줄지 말지를 결정한다.
	* @param pjtCode: 프로젝트코드
	* @return: boolean
	* @author: 이찬주
	*/
	function determineVisibleByTarget(pjtCode){
		/* var dataRaws = responseData.dataRaw.filter(function(data){
			if(data.PJT_CODE == pjtCode)	
				return true;
		}); */
		
		var dataRaws = $.grep(responseData.dataRaw,function(data){
			if(data.PJT_CODE == pjtCode)	
				return true;
		});
		
		if(dataRaws.length == 0)
			return false;
		
		var strPhase = '';
		var dataRaw = {};
		if(dataRaws.length > 0){
			strPhase = dataRaws[dataRaws.length-1].PHASE;
			dataRaw = dataRaws[dataRaws.length-1];
		}
		
		var phase = {};
		/* var phases = responseData.dataPhase.filter(function(data){
			if(data.PHASE == strPhase)	
				return true;
		}); */
		
		var phases = $.grep(responseData.dataPhase,function(data){
			if(data.PHASE == strPhase)	
				return true;
		});
		phase = phases[0];
		
		var target = 0;
		var val = 0;
		var chk0 = $('#p0').is(":checked");
		var chk1 = $('#p1').is(":checked");
		var chk2 = $('#p2').is(":checked");
		
		if(chk0){target += phase.P0; val += dataRaw.P0_CNT}
		if(chk1){target += phase.P1; val += dataRaw.P1_CNT}
		if(chk2){target += phase.P2; val += dataRaw.P2_CNT}
		
		if(val > target) return true;
		else return false;		
	}
	
	/* function htmlExpand(pjtCode,priority,dt){
		var linkUrl = "";
		$.ajax({
			url : "/dashboard/codesonarPriorityCsvLinkJson.html",
			async: false,
			data: {PJT_CODE: pjtCode },
			//data: $("#form").serialize(),
			success : function(responseData){
				var list = responseData.data;
				var dtSplit = dt.split("/");
				
				for(var i=0;i<list.length;i++){
					var svr = "codesonar"+$.trim(list[i].CODESONAR_SVR);
					var csvnum = list[i].CSV_NUM;
					var priority1 = "\""+priority+"\"";
					//var link = "http://"+ svr+".skhynix.com:7340/search.html?filter=2&scope=aid:"+csvnum+"&query=priority=&#34;"+priority+"&#34;";
					var link = "http://"+ svr+".skhynix.com:7340/search.html?filter=2&scope=all&query=";
					link += "project:"+ list[i].PJT_CODE;
					link += " priority=&#34;"+priority+"&#34;";
					var searchDt =  dtSplit[1]+"/"+dtSplit[2]+"/"+dtSplit[0].substr(2,2);
					link += " detected:" + searchDt + ".."+ searchDt;
					linkUrl +="<span style=\"cursor: pointer;\" onclick=\"hsClick('"+link+"',this);\">"+list[i].PJT_CODE + ": "+priority + ", "+ dt +"</span>";
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
            width: 250
        })
	}
	
	
	
	function hsClick(url,obj){
		window.open(url, '_blank');
		//window.focus();
		//hs.close(obj);
	} */
	
	function drawChart(redraw){		
		var dataRaw = responseData.dataRaw;
		var dataCount = responseData.dataCount;
		var dataPhase = responseData.dataPhase;
		var dataProject = responseData.dataProject;
		var chk0 = $('#p0').is(":checked");
		var chk1 = $('#p1').is(":checked");
		var chk2 = $('#p2').is(":checked");
		
		
		seriesHigh = [];
		for (var i = 0; i < dataProject.length; i++){
			var project =	{
				name: dataProject[i].PJT_NAME ,
				data: [],
				visible: true,
				events: {
					hide: function(){
						adjustBaseLine(this);
					},
					show: function(){
						//color조정
						if(this.color.charAt(0)=='#' && this.options.success){
							var R = hexToR(this.color);
							var G = hexToG(this.color);
							var B = hexToB(this.color);
							
							this.update({
								//color: 'rgba('+R+','+G+','+B+', 1)',
								dashStyle: 'dot'
							});
						}
						adjustBaseLine(this);
					}
				}
			};
			
			var success = determineVisibleByTarget(dataProject[i].PJT_CODE);
			project.success = !success;
			//커트라인을 통과한 프로젝트는 dot으로 표현.
			if(project.success)
				project.dashStyle = 'dot';
			
			if(redraw){
				var chart = $('#container').highcharts();
				/* var myLegend = chart.legend.allItems.filter(function(val){ 
					if(val.name == dataProject[i].PJT_CODE ){
					   return val;
					} 
				}); */
				var myLegend = $.grep(chart.legend.allItems,function(val){ 
					if(val.name == dataProject[i].PJT_NAME ){
					   return val;
					} 
				});
				var visible = myLegend[0].visible ;
				if(myLegend[0].color.charAt(0)=='#'){
					//visible = visible && success;
				}
				//project.visible = success;
				project.visible = visible;
				project.color = myLegend[0].color;
				//project.dashStyle = myLegend[0].options.dashStyle;
			}else {
				
				project.visible = success;
				
				//if(i < 3)		
				//	project.visible = true;
				//else
				//	project.visible = false;
			}
			
			
			for (var j = 0; j < dataRaw.length; j++){	
				if(dataRaw[j].PJT_CODE == dataProject[i].PJT_CODE ){
					var dateSplit = dataRaw[j].phaseSeqDt.split('-');
					var cnt = 0;
					if(chk0) cnt += dataRaw[j].P0_CNT;
					if(chk1) cnt += dataRaw[j].P1_CNT;
					if(chk2) cnt += dataRaw[j].P2_CNT;
					dataRaw[j].phaseSeqDtUTC = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]);
					
					var seriesdata = {
						x: 	Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]) ,
						y: cnt,
						rawdata: dataRaw[j]
					};
					//project.data.push([Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2]), cnt]);
					project.data.push(seriesdata);
				}				
			}
			
			//project.dashStyle =  'dot';
			seriesHigh.push(project);
		}
		
		//---------------  baseLine  -------------------------//
		// seriese
		var baseLine = {
			type: 'line',
			name: 'P0-BaseLine',
			dashStyle: 'dash',
			color:'rgba(0,0,255,1)',
			lineWidth:2,			
			/* marker: {
                enabled: false
            }, */
            data:[]
				
		};	
		var baseLineA = {
				type: 'line',
				name: 'P1-BaseLine',
				dashStyle: 'dash',
				color:'rgba(255,0,0,1)',
				lineWidth:2,			
				/* marker: {
	                enabled: false
	            }, */
	            data:[]
					
			};		
		seriesHigh.push(baseLine);
		seriesHigh.push(baseLineA);
		adjustBaseLine(null);
		//---------------  End baseLine  -------------------------//
		
		var plotBandsHigh = new Array();
		var plotLinesHigh = new Array();
		for (var i = 0; i < dataPhase.length; i++){	
			//------------- plotBands 구성. Phase -----------//
			var plotBand = {};
			var phaseDtSplit = dataPhase[i].PHASE_DT.split('-');
			// from
			plotBand.from = Date.UTC(phaseDtSplit[0],phaseDtSplit[1] -1 ,phaseDtSplit[2]);
			
			// to
			if(i < (dataPhase.length-1)){
				var phaseDtSplit1 = dataPhase[i+1].PHASE_DT.split('-');
				plotBand.to = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
			}else{//마지막데이타
				if(phaseDtSplit[1]=='11')
					plotBand.to = Date.UTC(phaseDtSplit[0]+1,0 , 0);
				else
					plotBand.to = Date.UTC(phaseDtSplit[0], phaseDtSplit[1] +1  , 0 );
			}
			
			// label
			plotBand.label = {
					text : dataPhase[i].PHASE ,
					style: {
						color: '#606060' ,
						fontWeight : 'bold'
					}
			};	
			plotBandsHigh.push(plotBand);
			
			//-------------   plotLine 구성.  ----------------//
			var plotLine = {
					color:'black',
					width:1,
					value: 0 ,
					dashStyle: 'ShortDash'			
			};
			
			if(i < (dataPhase.length-1)){
				var phaseDtSplit1 = dataPhase[i+1].PHASE_DT.split('-');
				//plotLine.value = Date.UTC(phaseDtSplit1[0],phaseDtSplit1[1] -1 ,phaseDtSplit1[2]);
				if(phaseDtSplit[1]=='11')
					plotLine.value = Date.UTC(phaseDtSplit1[0]+1,0 , 1);
				else
					plotLine.value = Date.UTC(phaseDtSplit1[0], phaseDtSplit1[1]-1 , 1 );
				
				plotLinesHigh.push(plotLine);
			}else{//마지막데이타
				/* if(phaseDtSplit[1]=='11')
					plotBand.value = Date.UTC(phaseDtSplit[0]+1,0 , 0);
				else
					plotBand.value = Date.UTC(phaseDtSplit[0], phaseDtSplit[1] +1 , 0 ); */
			}
			
		}
		
		
		var legend =  {
            layout: 'vertical',
            align: 'right',
            verticalAlign: 'top',
            x: -50,
            y: 50,
            floating: true,
            borderWidth: 1,
            symbolWidth: 35,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || '#FFFFFF'
            ,labelFormatter: function(){
            	//alert("aaa");
            	var len = this.name.length;
            	if(len> 10){
            		var text = this.name.substr(0,10) + "...";
            		
            		return "<div title=\""+this.name+"\">"+text+"</div>";
            	}            		
            	else
            		return this.name;
            }
            ,useHTML: true
            ,enabled: true
        }
		if($("#legendFloat").val() == "false"){
			legend.floating = false;
			legend.x = 0;
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
				text: 'Legend',
				onclick: function () {
					legentControl();
					//prototype: defaultOptions.exporting.buttons.contextButton.menuItems.onclick;
				},
				separator: false
			}
		);
		
		$('#container').highcharts('StockChart',{
	        chart: {
	            type: 'spline',
	            zoomType: 'xy'
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
	        exporting:{
	        	buttons:{
	        		contextButton:{
	        			menuItems: myExporting
	        		}
	        	}
	        },
	        xAxis: {
	        	type: 'datetime',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y'
	            },
	            title: {
	                text: ' '
	            },
	            plotBands : plotBandsHigh,
	            plotLines: plotLinesHigh
	            ,labels: {
	                formatter: function () {
	                	return '';
	                }
	            }
	            //, range: 2.1 * 30 * 24 * 3600 * 1000 // 2 months
	            , tickInterval: 30 * 24 * 3600 * 1000 // one months
	        },
	        rangeSelector: {
	        	enabled:false
	        },
	        navigator: {
	        	xAxis:{
	        		labels:{
	        			enabled:false
	        		}
	        	},
	        	height: 20
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	        	,min: 0
	        	//기준선추가
	        	/* ,plotLines: [{
	                 color: '#FF0000',
	                 dashStyle: 'Dot',
	                 width: 2,
	                 value: 70,
	                 label:{
	                	 text: 'BaseLine'
	                 }
	             }]  */
	             //, tickInterval: 100
	             , opposite: false
	             , gridLineWidth: 0
	        },
	        tooltip: {
	            shared: false, // 하나만 표시한다. y이면 모두표시함
	            crosshairs: false,
	            valueSuffix: '' , /* 
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m/%e',
	        		year: '%y/%m/%e'
	            }, */ 
	            formatter: function () {
	            	var data = getDataByUtc(this.series.name, this.x);
	            	if(this.series.name != 'BaseLine'){
	            		return '<b>' + data.PJT_NAME + '</b><br/>' + 
	                	'' + data.PHASE + '_' + data.PHASE_SEQ  + '(' + data.ANALYSYS_DATE.replace(/\//g,'.') + ')' + 
	                    ': ' + this.y + '';
	            	}
	                
	            }
	        },
	        legend: legend ,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true, // by default
	                point:{
	                	
	                	events:{
	                		click: function(e){
	                			var priority = "P0: High";
	                			
	                			
	                			//var dt = data.ANALYSYS_DATE;
	                			var ind = this.series.data.length -1;
	                			//var data = getDataByUtc(this.series.name, this.x);
	                			var data = this.series.data[ind].rawdata;
	                			var dt =data.ANALYSYS_DATE;
	                			//htmlExpand(this.series.name,priority,dt);
	                			//htmlExpand(data.PJT_CODE,priority,dt);
	                			
	                			dt = dt.replace(/\//gi,'-');
	                			htmlExpandPriority(data.PJT_CODE,priority,dt);
	                			
	                		}
	                	}
	                }
	            },
	            area: {
	                stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: true
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: '#666666',
	                //lineWidth: 1,
	                marker: {
	                	//enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#ff0000'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            },
	            spline: {
	            	//stacking: 'normal',
	                //lineColor: '#666666',
	                //lineWidth: 2,
	                marker: {
	                	enabled: true,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: true,
	                    style:{fontSize: "8px"},
	                    formatter:function(){
	                    	if(this.series.data[this.point.index-1] != undefined){
	                    		var prey = this.series.data[this.point.index-1].y;
	                    		if(prey == this.y)
	                    			return '';
	                    		else
	                    			return this.y;
	                    	}else{
	                    		return this.y;
	                    	}
	                    }
	                },
	                enableMouseTracking: true
	            }
	        },
	        series: seriesHigh
	    },
		    function(chart){
		    	adjustBaseLine(null);
		    }
	    
	    
		);
		
		
		//$('#container').highcharts.series[0].hide();
		//$('#container').highcharts.series[1].hide();
		// Apply the theme
		//Highcharts.setOptions(Highcharts.theme);
	}
	
	
	//$( "input[type=checkbox]" ).on( "click", drawChart );
	
	$( "#p0" ).click(function() {
		drawChart();
	});
	$( "#p1" ).click(function() {
		drawChart();
	});
	$( "#p2" ).click(function() {
		drawChart();
	});
	
	//http://www.javascripter.net/faq/hextorgb.htm
	/**
	* R = hexToR("#FFFFFF");
	* G = hexToG("#FFFFFF");
	* B = hexToB("#FFFFFF");
	*/
	function hexToR(h) {return parseInt((cutHex(h)).substring(0,2),16)}
	function hexToG(h) {return parseInt((cutHex(h)).substring(2,4),16)}
	function hexToB(h) {return parseInt((cutHex(h)).substring(4,6),16)}
	function cutHex(h) {return (h.charAt(0)=="#") ? h.substring(1,7):h}
	
	function rgbToHex(R,G,B) {return toHex(R)+toHex(G)+toHex(B)}
	function toHex(n) {
	 n = parseInt(n,10);
	 if (isNaN(n)) return "00";
	 n = Math.max(0,Math.min(n,255));
	 return "0123456789ABCDEF".charAt((n-n%16)/16)
	      + "0123456789ABCDEF".charAt(n%16);
	}
	
	</script>
	<style type="text/css">
	
		html, body,form {
	        height: 100%;
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow: visible;
	        font-size:12px;
	      }
		
		.dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			height: 90%;	
		}
		
		.div-priority{
			/* width: 100%; */
			/* margin-left:10px; */
			height: 20px;		
			display: block;	
			font-size: 12px;
		}
		
		/* multi-select 관련  */
		.ui-multiselect-checkboxes li label{
			font-size: 13px;
			line-height: 1.3em;
		}		
		.ui-multiselect-checkboxes li label input[type="checkbox"] {margin:0; padding:0; vertical-align:middle;}
		ui-multiselect-menu a:link, a:visited, a:active {
			font-family:'Malgun Gothic', arial, gulim, dotum;
			/* color: #000; */
			text-decoration:none;
		}
		
	
		
	</style>
</head>
<body>
<form name="form" id="form" class="">
<input type="hidden" name="version" value="${param.version}"/>
<input type="hidden" name="legendFloat" id="legendFloat" value="false"/>
<div align="left" class="div-priority">
	<div style="display:inline-block;text-overflow:hidden;float:left;">
		<select name="pjtStatus" id="pjtStatus" multiple="multiple" style="width:150px" >
	    </select>
		<input type="hidden" name="pjtCodeList" value ="xxx"/>
		<select name="pjtCodeList" id="pjtCodeList" multiple="multiple" style="width:350px" >
	    </select>	 
	    
	</div>
	<div style=\"width:100px;display:inline-block;text-overflow:ellipsis;float:left;\"><input type="checkbox" checked="checked" name="p0" id="p0" onchange="drawChart(true)"/>P0</div>
	<div style=\"width:100px;display:inline-block;text-overflow:ellipsis;float:left;\"><input type="checkbox" name="p1" id="p1" onchange="drawChart(true)"/>P1</div>
	<div style=\"width:100px;display:inline-block;text-overflow:ellipsis;float:left;\"><input type="checkbox" name="p2" id="p2" onchange="drawChart(true)"/>P2</div>
</div>
<div  id="container" class="dashboard-div"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
