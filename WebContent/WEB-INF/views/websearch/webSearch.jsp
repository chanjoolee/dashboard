<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Air Search</title>
    <%-- 1. jquery --%>
    <!-- <script src="js/jquery/jquery-1.11.2.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
    <!-- <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script> -->
    <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> 
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    <%-- jqgrid --%>
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
    <!-- link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">  -->
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
	
	<%-- http://swebdeveloper.com/apps/forms-plus-css/popup-form-comment.html --%>
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/font-awesome.min.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/modern-forms-plus.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/purple.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/cadetBlue.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/orange.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra1color4.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/extra2color3.css">
	 <link rel="stylesheet" href="/dashboard/css/bootstrap/steelBlue.css">
	 
    
  
   <!--  <link rel="stylesheet" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid.css" type="text/css" /> --> 
    <link rel="stylesheet" media="screen" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap.css" type="text/css" />
    <!-- <link rel="stylesheet" media="screen"  href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap-ui.css" type="text/css" /> -->
    
    
    
    <%-- 2. high charts --%>
	<!--<script src="/dashboard/js/Highcharts-5.0.7/code/highcharts.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/highcharts-more.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/drilldown.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/no-data-to-display.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/exporting.src.js"></script>
	<script src="/dashboard/js/Highcharts-5.0.7/code/modules/offline-exporting.src.js"></script> -->
	
	<script src="/dashboard/js/Highstock-5.0.9/code/highstock.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/heatmap.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/highcharts-more.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/drilldown.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/no-data-to-display.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/exporting.src.js"></script>
	<script src="/dashboard/js/Highstock-5.0.9/code/modules/offline-exporting.src.js"></script>
	
	<%-- x축 그룹라벨 --%>
	<!-- <script src="js/highcharts/grouped-categories.js"></script> -->
	<!-- <script src="http://blacklabel.github.io/grouped_categories/grouped-categories.js"></script> -->
	
	<%-- 3. Additional files for the Highslide popup effect --%>
	<script type="text/javascript" src="js/highslide/highslide-full.js"></script>
	<script type="text/javascript" src="js/highslide/highslide.config.js" charset="utf-8"></script>
	
	<%-- 4. local common --%>
	<script src="js/dashboard.js?version=2017.11.16"></script>
	
	<%-- 5. local --%>
	<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="http://www.trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" /> -->
	
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<!--<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" />-->
	<script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script>
	
	<link rel="stylesheet" type="text/css" href="/nspim/css/common.css" />
	<link rel="stylesheet" type="text/css" href="/nspim/css/new.css" />
	<link rel="stylesheet" type="text/css" href="/nspim/css/board.css" />
	<script src="/common/js/module.js"></script>
	
	<%-- File Saver --%>
	<script type="text/javascript" src="/dashboard/js/FileSaver.js/FileSaver.js" charset="utf-8"></script>
	<script type="text/javascript" src="/dashboard/js/jquery-zclip-master/jquery.zclip.js"></script>
	
	<script type="text/javascript" src="/dashboard/js/alasql-develop/dist/alasql.js"></script>
	<script src="/dashboard/js/jointjs/lodash.min.js"></script>
	
	<%-- jqueryDatePicker --%>
	<script type="text/javascript" src="https://cdn.rawgit.com/dubrox/Multiple-Dates-Picker-for-jQuery-UI/master/jquery-ui.multidatespicker.js"></script>
	<link rel="https://cdn.rawgit.com/dubrox/Multiple-Dates-Picker-for-jQuery-UI/master/jquery-ui.multidatespicker.css" />
	<!--<link rel="https://code.jquery.com/ui/1.12.1/themes/pepper-grinder/jquery-ui.css" />-->
	
	
	<%-- jqueryMohthPicker --%>
    <link rel="https://rawgit.com/KidSysco/jquery-ui-month-picker/v3.0.0/demo/MonthPicker.min.css" />
   	<script type="text/javascript" src="https://rawgit.com/digitalBush/jquery.maskedinput/1.4.1/dist/jquery.maskedinput.min.js"></script>
   	<script type="text/javascript" src="https://rawgit.com/KidSysco/jquery-ui-month-picker/v3.0.0/demo/MonthPicker.min.js"></script>
	
	
	
	
	<script type="text/javascript" id="script_common" >
	var dataList = [];
	
		
	</script>
	<script type="text/javascript" id="script_schemaSearchCondition">
	
	
	var EfContextPath = "";
//	<ul class="ip-list">						<li><input type="radio" onclick="autoFindCity('LHR','런던(히드로)', 'GB')" id="LHR" class="radio" name="radio"><label for="LHR"> 런던(히드로)</label></li>					<li><input type="radio" onclick="autoFindCity('LGW','런던(게트윅)', 'GB')" id="LGW" class="radio" name="radio"><label for="LGW"> 런던(게트윅)</label></li>					<li><input type="radio" onclick="autoFindCity('CDG','파리(샤를드골)', 'FR')" id="CDG" class="radio" name="radio"><label for="CDG"> 파리(샤를드골)</label></li>					<li><input type="radio" onclick="autoFindCity('FRA','프랑크푸르트', 'DE')" id="FRA" class="radio" name="radio"><label for="FRA"> 프랑크푸르트</label></li>					<li><input type="radio" onclick="autoFindCity('ROM','로마', 'IT')" id="ROM" class="radio" name="radio"><label for="ROM"> 로마</label></li>					<li><input type="radio" onclick="autoFindCity('IST','이스탄불', 'TR')" id="IST" class="radio" name="radio"><label for="IST"> 이스탄불</label></li>						<li><input type="radio" onclick="autoFindCity('MAD','마드리드', 'ES')" id="MAD" class="radio" name="radio"><label for="MAD"> 마드리드</label></li>						<li><input type="radio" onclick="autoFindCity('PRG','프라하', 'CZ')" id="PRG" class="radio" name="radio"><label for="PRG"> 프라하</label></li>						<li><input type="radio" onclick="autoFindCity('BCN','바르셀로나', 'ES')" id="BCN" class="radio" name="radio"><label for="BCN"> 바르셀로나</label></li>					<li><input type="radio" onclick="autoFindCity('ZRH','취리히', 'NL')" name="radio" class="radio" id="ZRH"><label for="ZRH"> 취리히</label></li>						<li><input type="radio" onclick="autoFindCity('AMS','암스테르담', 'CH')" name="radio" class="radio" id="AMS"><label for="AMS"> 암스테르담</label></li>					<li><input type="radio" onclick="autoFindCity('MXP','밀라노', 'IT')" name="radio" class="radio" id="MXP"><label for="MXP"> 밀라노</label></li>					</ul>	
	var airports = [
		{ region:'EU',region_name:'유럼',id:'LHR',name: '런던(히드로)' },
		{ region:'EU',region_name:'유럼',id:'LGW',name: '런던(게트윅)' },
		{ region:'EU',region_name:'유럼',id:'CDG',name: '파리(샤를드골)' },
		{ region:'EU',region_name:'유럼',id:'FRA',name: '프랑크푸르트' },
		{ region:'EU',region_name:'유럼',id:'ROM',name: '로마' },
		{ region:'EU',region_name:'유럼',id:'IST',name: '이스탄불' },
		{ region:'EU',region_name:'유럼',id:'MAD',name: '마드리드' },
		{ region:'EU',region_name:'유럼',id:'PRG',name: '프라하' },
		{ region:'EU',region_name:'유럼',id:'BCN',name: '바르셀로나' },
		{ region:'EU',region_name:'유럼',id:'ZRH',name: '취리히' },
		{ region:'EU',region_name:'유럼',id:'AMS',name: '암스테르담' },
		{ region:'EU',region_name:'유럼',id:'MXP',name: '밀라노' },
		
		{ region:'ASIA_SE',region_name:'동남아',id:'HKG',name: '홍콩' },
		{ region:'ASIA_SE',region_name:'동남아',id:'BKK',name: '방콕' },
		{ region:'ASIA_SE',region_name:'동남아',id:'MNL',name: '마닐라' },
		{ region:'ASIA_SE',region_name:'동남아',id:'HKT',name: '푸켓' },
		{ region:'ASIA_SE',region_name:'동남아',id:'SIN',name: '싱가폴' },
		{ region:'ASIA_SE',region_name:'동남아',id:'DAD',name: '다 낭' },
		{ region:'ASIA_SE',region_name:'동남아',id:'SGN',name: '호치민' },
		{ region:'ASIA_SE',region_name:'동남아',id:'HAN',name: '하노이' },
		{ region:'ASIA_SE',region_name:'동남아',id:'TPE',name: '타이페이' },
		{ region:'ASIA_SE',region_name:'동남아',id:'CEB',name: '세부' },
		{ region:'ASIA_SE',region_name:'동남아',id:'KLO',name: '칼리보(보라카이)' },
		{ region:'ASIA_SE',region_name:'동남아',id:'DPS',name: '발리' },
		{ region:'ASIA_SE',region_name:'동남아',id:'CGK',name: ' 자카르타' },
		
		
		
		{ region:'JAPAN',region_name:'일본',id:'TYO',name: '도쿄' },
		{ region:'JAPAN',region_name:'일본',id:'NRT',name: '도쿄(나리타)' },
		{ region:'JAPAN',region_name:'일본',id:'HND',name: '도쿄(하네다)' },
		{ region:'JAPAN',region_name:'일본',id:'OSA',name: '오사카' },
		{ region:'JAPAN',region_name:'일본',id:'NGO',name: '나고야' },
		{ region:'JAPAN',region_name:'일본',id:'FUK',name: '후쿠오카' },
		{ region:'JAPAN',region_name:'일본',id:'OKA',name: '오키나와' },
		{ region:'JAPAN',region_name:'일본',id:'CTS',name: '삿포로' },
		
		{ region:'pacific',region_name:'대양주',id:'SYD',name: '시드니' },
		{ region:'pacific',region_name:'대양주',id:'AKL',name: '오클랜드' },
		{ region:'pacific',region_name:'대양주',id:'BNE',name: '브리즈번' },
		{ region:'pacific',region_name:'대양주',id:'MEL',name: '멜버른' },
		{ region:'pacific',region_name:'대양주',id:'GUM',name: '괌' },
		{ region:'pacific',region_name:'대양주',id:'SPN',name: '사이판' },
		{ region:'pacific',region_name:'대양주',id:'ROR',name: '팔라우' },
		{ region:'pacific',region_name:'대양주',id:'CNS',name: '케언즈' },
		{ region:'pacific',region_name:'대양주',id:'PER',name: '퍼스' },
		{ region:'pacific',region_name:'대양주',id:'CHC',name: '크라이스트쳐치' }
		
		
		
	];
	var schemaSearch = {
			containerId:'searchCondition',
			type:'Vertical',
			label:'',
			cls: 'srch_box2',
			elements:[
				{
					label:'',
					type: 'HorizontalLayout',
					elements:[
					 	{
					 		containerCss:[
								
							],
							label:'',
							type:'Vertical',
							elements:[
								{
									label:'',
									type: 'HorizontalLayout',
									containerCss:[
							    		{code:'height',value:'30px'}
							    	],
									elements:[
										// date pick gubun
										{
											type:'SearchHeader',
											id: 'searchdatePickGubunHead',
											name: 'searchdatePickGubunHead',
											label:'',
											text:'Multi Date',
											width: '150px',
											containerCss:[
									    		{code:'text-align',value:'right'}
									    	]
										},
										{
											type:'multiCombo',
											id: 'search_multi_date',
											name: 'search_multi_date',
											label:'',
											text:'Project',
											width: '110px',
											data: function(){
												return [
													{  id: 'Single',name:'Single'},
													{  id: 'Multi',name:'Multi'}
												];
												
											},
											//value :'CSSD',
											options: {
												cd:'id',
												name:'name'
											},
											multiselectOpt:{
												selectedList: 1 ,
												multiple: false,
												selectedText: function(numChecked, numTotal, checkedItems){
													 var sb = [];
													 $.each(checkedItems,function(){
														 sb.push($(this).val());
													 });
													 return sb.join(",");
												}
											},
											events:{
											
											}
										} ,
										//Start Date
										{
											type:'SearchHeader',
											id: 'sampleHead',
											name: 'sampleHead',
											label:'',
											text:'Start Date ',
											width: '100px'
										},
										//dateFrom
										{
											type: 'dateInput',
											id: 'dateFrom',
											name: 'dateFrom',
											label:'',
											//value:'',
											//width:'100px',
											// cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												{code: 'margin-left', value:'10px'}
											],
											controlCss:[
												{code: 'text-align', value:'center'},
												{code: 'height', value:'1.8em'},
												{code: 'width', value:'100px'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												}
											},
											value: function(){
												var today = new Date();
										    	var year = today.getFullYear();
										    	var month = today.getMonth();
										    	var date = today.getDate();
										    	
										    	var startDate = new Date(year,month-0,date+2);
										    	
										    	return startDate.toISOString('YYYY-MM-DD').substr(0,10);
										    	//$("#dateButtonFrom").val(startDate.toISOString('YYYY-MM-DD').substr(0,10));
										    	//$("#dateButtonFrom").val(today.toISOString('YYYY-MM-DD').substr(0,10));
											}
										},
										//dateButtonFrom
										{
											type: 'dateButton',
											id: 'dateButtonFrom',
											name: 'dateButtonFrom',
											label:'',
											value: function(){
												
											},
											//width:'100px',
											cls: 'btn_date',
											containerCss:[
											],
											controlCss:[
												{code: 'margin-left', value:'0'},
												{code: 'margin-top', value:'-4px'}
											],
											events:{
												click : function(){
													if($("#search_multi_date").val() == 'Single')
														calendar.calendar_show(event, this, 'dateFrom');
													else {
														var today = new Date();
														var y = today.getFullYear();
														var md = $('#mdp-demo');
														md.css({top: event.clientY + 10 , left: event.clientX + 10, position:'absolute'});
														if(md.html() == ""){
															md.multiDatesPicker({
																//addDates: ['10/14/'+y, '02/19/'+y, '01/14/'+y, '11/16/'+y],
																numberOfMonths: [3,4],
																dateFormat: 'yy-mm-dd'
																//defaultDate: '1/1/'+y
																//defaultDate: y+'/1/1'
																
															});
														}else{
															md.toggle();
														}
														
													}
													
												}
											}
										}
										,
										//Airport
										{
											type:'SearchHeader',
											id: 'airportHead',
											name: 'airportHead',
											label:'',
											text:'Airport',
											width: '60px'
										},
										{
											type:'multiCombo',
											id: 'search_airport',
											name: 'search_airport',
											label:'',
											text:'Airport',
											width: '110px',
											data: function(){
												
												return airports;
											},
											//value :'CSSD',
											options: {
												cd:'id',
												name:'name',
												group: {
													cd:'region',
													name: 'region_name'
												}
											},
											multiselectOpt:{
												//selectedList: 1 ,
												multiple: true,
												selectedText: function(numChecked, numTotal, checkedItems){
													 //return numChecked + ' of ' + numTotal + ' checked';
													 
													 var rtn = "";
													 var sb = [];
													 $.each(checkedItems,function(i,d){
													 	 if(i < 2)
														 	sb.push($(this).val());
													 });
													 rtn = sb.join(",");
													 if((checkedItems.length-2) > 0){
													 	rtn += " ..." + (checkedItems.length-2)+" more"
													 }
													 return rtn;
												}
											},
											events:{
											
											}
										} ,
										// Travel Days
										{
											type:'SearchHeader',
											id: 'termHead',
											name: 'termHead',
											label:'',
											text:'Travel Days ',
											width: '80px',
											containerCss:[
									    		{code:'text-align',value:'right'}
									    	]
										},
										{
											type: 'input',
											id: 'travel_term',
											name: 'travel_term',
											label:'',
											//value:'7',
											//width:'100px',
											// cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												{code: 'margin-left', value:'10px'}
											],
											controlCss:[
												{code: 'text-align', value:'center'},
												{code: 'height', value:'1.8em'},
												{code: 'width', value:'50px'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												}
											},
											value: function(){
												return '10';
											}
										},
										// Person
										{
											type:'SearchHeader',
											id: 'requestCountHead',
											name: 'requestCountHead',
											label:'',
											text:'Seats',
											width: '80px',
											containerCss:[
									    		{code:'text-align',value:'right'}
									    	]
										},
										{
											type: 'input',
											id: 'requestCount',
											name: 'requestCount',
											label:'',
											//value:'7',
											//width:'100px',
											// cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												{code: 'margin-left', value:'10px'}
											],
											controlCss:[
												{code: 'text-align', value:'center'},
												{code: 'height', value:'1.8em'},
												{code: 'width', value:'50px'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												}
											},
											value: function(){
												return '1';
											}
										}
										
									
									]
								},
								//2line
								{
									label:'',
									type: 'HorizontalLayout',
									containerCss:[
							    		{code:'height',value:'30px'}
							    	],
									elements:[
										// Search Gubun(day/month)
										{
											type:'SearchHeader',
											id: 'searchGubunHead',
											name: 'searchGubunHead',
											label:'',
											text:'Search Gubun(day/month) ',
											width: '150px',
											containerCss:[
									    		{code:'text-align',value:'right'}
									    	]
										},
										{
											type:'multiCombo',
											id: 'search_gubun',
											name: 'search_gubun',
											label:'',
											text:'Project',
											width: '110px',
											data: function(){
												return [
													{  id: 'day',name:'day'},
													{  id: 'month',name:'month'}
												];
												
											},
											//value :'CSSD',
											options: {
												cd:'id',
												name:'name'
											},
											multiselectOpt:{
												selectedList: 1 ,
												multiple: false,
												selectedText: function(numChecked, numTotal, checkedItems){
													 var sb = [];
													 $.each(checkedItems,function(){
														 sb.push($(this).val());
													 });
													 return sb.join(",");
												}
											},
											events:{
											
											}
										} ,
										// searchRange
										{
											type:'SearchHeader',
											id: 'searchRangMMHead',
											name: 'searchRangMMHead',
											label:'',
											text:'Search Range ',
											width: '100px',
											containerCss:[
									    		{code:'text-align',value:'right'}
									    	]
										},
										{
											type: 'input',
											id: 'searchRange',
											name: 'searchRange',
											label:'',
											//value:'7',
											//width:'100px',
											// cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												{code: 'margin-left', value:'10px'}
											],
											controlCss:[
												{code: 'text-align', value:'center'},
												{code: 'height', value:'1.8em'},
												{code: 'width', value:'50px'}
											],
											events:{
												click : function(){
													//alert($("[name=radioDate]").val());
												}
											},
											value: function(){
												return '6';
											}
										},
										
										// Direct Gubun : ItinList.StartSeg.ItinItem ItinList.ReturnSeg.ItinItem
										{
											type:'SearchHeader',
											id: 'searchHead',
											name: 'searchStopTimeHead',
											label:'',
											text:'Stop Time',
											width: '100px',
											containerCss:[
									    		{code:'text-align',value:'right'},
									    		{code:'margin-left',value:'33px'}
									    	]
										},
										{
											type:'multiCombo',
											id: 'search_stops',
											name: 'search_stops',
											label:'',
											text:'Project',
											width: '100px',
											data: function(){
												return [
													{  id: '0',name:'0'},
													{  id: '1',name:'1'},
													{  id: '2',name:'2'}
												];
												
											},
											//value :'CSSD',
											options: {
												cd:'id',
												name:'name'
											},
											multiselectOpt:{
												selectedList: 1 ,
												multiple: false,
												selectedText: function(numChecked, numTotal, checkedItems){
													 var sb = [];
													 $.each(checkedItems,function(){
														 sb.push($(this).attr("title"));
													 });
													 return sb.join(",");
												}
											},
											events:{
											
											}
										}
										
									
									]
								}
								
							]
					 	},
					 	//검색버튼
					 	{
					 		label:'',
					 		type: 'VerticalLayout',
							cls: 'btn_txt',
							containerCss:[
								{code: 'margin-left', value:'10px'}
								, {code: 'float', value:'right'}
							]
					 		, elements:[
					 			{
					 				label:'',
							 		type: 'HorizontalLayout',
									cls: 'btn_txt',
									containerCss:[
										{code: 'margin-left', value:'10px'}
									],
									elements:[
										{
											type:'Button',
											id: 'btnSearch',
											name: 'btnSearch',
											label:'SEARCH',
											//width: '50px',
											cls: 'btn_txt btn_type_e btn_color_a',
											containerCss:[
												{code: 'margin-right', value:'15px'},
												{code: 'padding-top', value:'3px'},
											],
											events: {
												click: function(){
													//searchSite(); 
													$("#loader").show();
													setTimeout( function(){
														searchStart();
														$("#loader").hide();
													},50);	
												}
											}
										}
									
									 ]
					 			}
					 		            
					 		]
							
					 	}
					]
				}
			
			
			]
			
	};
	
	
	
	
	</script>
	<script type="text/javascript" id="script_main">
	var v_list = [];
	var v_sites = {};
	
	
	
	
	$(function () {
		//$("#loader").show();
		setTimeout( function(){
			fn_makeHtml('searchCondition',schemaSearch);	
			$("#loader").hide();
		},50);
		
		parent.$("body").css("overflow","");
	});
	
	
	function searchStart(){
		// $("#loader").show();
		v_list = [];
		v_sites = {};
		var start = $('#dateFrom').val().split("-").join("");
		var search_gubun = $("#search_gubun").val();
		var searchRange = parseInt($("#searchRange").val());
		var end = "";
		if(search_gubun == 'day'){
			end = dateAdd(start,searchRange);
		}else{
			end = monthAdd(start,searchRange);
		}
		
		// date single
		if($("#search_multi_date").val() == 'Single'){
			var dt1 = start; 		
			while( dt1 < end ){
				$.each($("#search_airport").val(),function(i,dep){
					searchSite(dt1,dep,1);
				});
				dt1 = dateAdd(dt1,1);
				//break;
			}
		}else{
			// date multy
			var md = $('#mdp-demo');
			var dts = md.val().split(",");
			$.each(dts, function(i,dt){
				var dt1 = dt.trim().replace(/-/g,"");
				$.each($("#search_airport").val(),function(i,dep){
					searchSite(dt1,dep,1);
				});
			});
		}
		
		
		
		// alert("Complete!");
		
	}
	
	function searchSite(dt1,airport, pageno){
    	var dt2 = dateAdd(dt1,Number($("#travel_term").val()));  
    	
		//해외항공
		url = "http://smartair.interpark.com/HtmlSearch/GetGoodsSmartList.aspx";
		url += "?Soto=N";
		url += "&ptype=I";
		url += "&SeatAvail=Y";
		url += "&dep0=SEL";
		url += "&comp=Y";
		url += "&arr0=" + airport;
		url += "&depdate0="+ dt1;
		url += "&dep1="+ airport;
		url += "&faretype=";
		url += "&arr1=SEL";
		url += "&enc=u";
		url += "&SeatType=A";
		url += "&FLEX=Y";
		url += "&Change=";
		url += "&PageNo=" + pageno;
		url += "&SplitNo=50";
		url += "&retdate="+dt2;
		url += "&adt=2";
		url += "&chd=1";
		url += "&BEST=Y";
		//url += "&MoreKey=636462660768456428372";
		url += "&inf=0";
		url += "&trip=RT";
		//url += "&AirLine=KE";
		url += "&AirLine=";
		url += "&StayLength=";
		url += "&JSON=Y";
		// url += "&Callback=onJsonResult";
		url += "&callback=fn_successJsonp";
		var paramObj = {};
		paramObj.sites = [
			// 해외항공
			{
				name: "interpark_air",
				url: url
			}
		];
		
		$.ajax({
			// type: "POST",
			//url: "/dashboard/webSearchJson.do",
			url: url,
			dataType: 'jsonp', 
			// data: {searchJson: JSON.stringify(paramObj)}, 
			
			//async: false,
			success: function(data) {
				console.log('성공 - ', data);
			},
			error: function(xhr) {
				console.log('실패 - ', xhr);
			}
		});
	}
	
	// var onJsonResult = function(response){
	// 	var aaa = "aaa";
	// }
	
	var fn_success = function(response){
		v_list.push(response);
		$.each(response.result.searchJson.sites,function(i,site){
			site.responseJson = eval(site.response.substr(12));
			
			// log
			console.log([dt1,airport, pageno, site.responseJson]);
			
			var moreKey = site.responseJson.Responses.GoodsSummary.MoreKey;
			var pageNo = site.responseJson.Responses.GoodsSummary.PageNO;
			var maxPageNo = site.responseJson.Responses.GoodsSummary.MaxPageNO;
				
			if( v_sites[site.name] == undefined ){
				v_sites[site.name] = {
					list : [],
					best : {}
				};
			}
			
			if(site.responseJson.Responses.GoodsList != ""){
				if($.isArray(site.responseJson.Responses.GoodsList.Goods)){
					sortObjects(site.responseJson.Responses.GoodsList.Goods,[['TotalSaleFare','asc']]);
					var goods = site.responseJson.Responses.GoodsList.Goods;
					// site list add to v_sites
					$.each(goods,function(j,good){
						var requestCount = parseInt($("#requestCount").val());
						
						// 가능 좌석일때만!! 대기도 뺀다~~
						var isSeat = false;
						if(parseInt(good.StartCheck) >= requestCount
								&& parseInt(good.ReturnCheck) >= requestCount
								&& good.FareFix == "확정"
								&& good.SiteCode != "MOBILE" ){
							isSeat = true;
						}
						
						// 경유
						var isVia = false;
						var viaType = parseInt($("#search_stops").val()) + 1;
						var maxViaType = 0;
						if(typeof (good.AirAvail.ReturnAvail.AirItn) != 'undefined') {
							if( typeof (good.AirAvail.ReturnAvail.AirItn.length) == 'undefined') {
								if (parseInt(good.AirAvail.ReturnAvail.AirItn.Total_Seg) > maxViaType){
									maxViaType = parseInt(good.AirAvail.ReturnAvail.AirItn.Total_Seg);
								}
							} else {
								for( var j=0; j< good.AirAvail.ReturnAvail.AirItn.length; j++) {
									if (parseInt(good.AirAvail.ReturnAvail.AirItn[j].Total_Seg) > maxViaType){
										maxViaType = parseInt(good.AirAvail.ReturnAvail.AirItn[j].Total_Seg);
									}
								}
							}
						}
						
						if( maxViaType < 3 && maxViaType != 0) {
							if( viaType == 1) {
								if( maxViaType == 1) {
									isVia = true;
								}
							} else {
								isVia = true;
							}
						}
						if(isSeat && isVia){
							var v1 = dataFilter(airports,[{col:"id",val: airport}])[0];
							good.airport = v1.name;
							v_sites[site.name].list.push(good);
						}
							
						
					});
				}else if(site.responseJson.Responses.GoodsList.Goods != undefined ){
					var good = site.responseJson.Responses.GoodsList.Goods;
					// 가능 좌석일때만!! 대기도 뺀다~~
					var isSeat = false;
					if(parseInt(good.StartCheck) >= requestCount
							&& parseInt(good.ReturnCheck) >= requestCount
							&& good.FareFix == "확정"
							&& good.SiteCode != "MOBILE" ){
						isSeat = true;
					}
					// 경유
					var isVia = false;
					var viaType = parseInt($("search_stops").val()) + 1;
					var maxViaType =0;
					if(typeof (good.AirAvail.ReturnAvail.AirItn) != 'undefined') {
						if( typeof (good.AirAvail.ReturnAvail.AirItn.length) == 'undefined') {
							if (parseInt(good.AirAvail.ReturnAvail.AirItn.Total_Seg) > maxViaType){
								maxViaType = parseInt(good.AirAvail.ReturnAvail.AirItn.Total_Seg);
							}
						} else {
							for( var j=0; j< good.AirAvail.ReturnAvail.AirItn.length; j++) {
								if (parseInt(good.AirAvail.ReturnAvail.AirItn[j].Total_Seg) > maxViaType){
									maxViaType = parseInt(good.AirAvail.ReturnAvail.AirItn[j].Total_Seg);
								}
							}
						}
					}
					if( maxViaType < 3 && maxViaType != 0) {
						if( viaType == 1) {
							if( maxViaType == 1) {
								isVia = true;
							}
						} else {
							isVia = true;
						}
					}
					if(isSeat && isVia){
						var v1 = dataFilter(airports,[{col:"id",val: airport}])[0];
						good.airport = v1.name;
						v_sites[site.name].list.push(good);
					}
					
				}
			}					
			
			
			
			if( parseInt(pageNo) < parseInt(maxPageNo) ) {
				searchSite(dt1,airport, parseInt(pageNo) +1);
			}
			
		});
	}

	
	var fn_successJsonp = function(response){
		console.log("dkjfkjdfkjdkjf");
		v_list.push(response.Responses);
		
		// log
		// console.log([dt1,airport, pageno, response]);
		
		var airport = this.url.match(/dep1=([\w]+)&/i)[1];
		var airport_name = _.findWhere(airports,{id: airport}).name;

		var depdate = this.url.match(/depdate0=([\w]+)&/i)[1];

		var moreKey = response.Responses.GoodsSummary.MoreKey;
		var pageNo = response.Responses.GoodsSummary.PageNO;
		var maxPageNo = response.Responses.GoodsSummary.MaxPageNO;
		
			
		if( v_sites[airport_name] == undefined ){			
			v_sites[airport_name] = {
				pages:{
					
				},				
				list : [],
				best : {}
			};
		}

		if(v_sites[airport_name].pages[depdate] == undefined){
			v_sites[airport_name].pages[depdate] = {};
			for(var i=1 ; i < Number(maxPageNo) ; i++){
				v_sites[airport_name].pages[depdate][i+""] = {dataRecieved :false};
			}
		}
			
		

	
		
		if(response.Responses.GoodsList != ""){
			if($.isArray(response.Responses.GoodsList.Goods)){
				sortObjects(response.Responses.GoodsList.Goods,[['TotalSaleFare','asc']]);
				var goods = response.Responses.GoodsList.Goods;
				// site list add to v_sites
				$.each(goods,function(j,good){
					var requestCount = parseInt($("#requestCount").val());
					
					// 가능 좌석일때만!! 대기도 뺀다~~
					var isSeat = false;
					if(parseInt(good.StartCheck) >= requestCount
							&& parseInt(good.ReturnCheck) >= requestCount
							&& good.FareFix == "확정"
							&& good.SiteCode != "MOBILE" ){
						isSeat = true;
					}
					
					// 경유
					var isVia = false;
					var viaType = parseInt($("#search_stops").val()) + 1;
					var maxViaType = 0;
					if(typeof (good.AirAvail.ReturnAvail.AirItn) != 'undefined') {
						if( typeof (good.AirAvail.ReturnAvail.AirItn.length) == 'undefined') {
							if (parseInt(good.AirAvail.ReturnAvail.AirItn.Total_Seg) > maxViaType){
								maxViaType = parseInt(good.AirAvail.ReturnAvail.AirItn.Total_Seg);
							}
						} else {
							for( var j=0; j< good.AirAvail.ReturnAvail.AirItn.length; j++) {
								if (parseInt(good.AirAvail.ReturnAvail.AirItn[j].Total_Seg) > maxViaType){
									maxViaType = parseInt(good.AirAvail.ReturnAvail.AirItn[j].Total_Seg);
								}
							}
						}
					}
					
					if( maxViaType < 3 && maxViaType != 0) {
						if( viaType == 1) {
							if( maxViaType == 1) {
								isVia = true;
							}
						} else {
							isVia = true;
						}
					}
					if(isSeat && isVia){
						var v1 = dataFilter(airports,[{col:"id",val: airport}])[0];
						good.airport = v1.name;
						v_sites[airport_name].list.push(good);
					}
						
					
				});
			}else if(response.Responses.GoodsList.Goods != undefined ){
				var good = response.Responses.GoodsList.Goods;
				// 가능 좌석일때만!! 대기도 뺀다~~
				var isSeat = false;
				if(parseInt(good.StartCheck) >= requestCount
						&& parseInt(good.ReturnCheck) >= requestCount
						&& good.FareFix == "확정"
						&& good.SiteCode != "MOBILE" ){
					isSeat = true;
				}
				// 경유
				var isVia = false;
				var viaType = parseInt($("search_stops").val()) + 1;
				var maxViaType =0;
				if(typeof (good.AirAvail.ReturnAvail.AirItn) != 'undefined') {
					if( typeof (good.AirAvail.ReturnAvail.AirItn.length) == 'undefined') {
						if (parseInt(good.AirAvail.ReturnAvail.AirItn.Total_Seg) > maxViaType){
							maxViaType = parseInt(good.AirAvail.ReturnAvail.AirItn.Total_Seg);
						}
					} else {
						for( var j=0; j< good.AirAvail.ReturnAvail.AirItn.length; j++) {
							if (parseInt(good.AirAvail.ReturnAvail.AirItn[j].Total_Seg) > maxViaType){
								maxViaType = parseInt(good.AirAvail.ReturnAvail.AirItn[j].Total_Seg);
							}
						}
					}
				}
				if( maxViaType < 3 && maxViaType != 0) {
					if( viaType == 1) {
						if( maxViaType == 1) {
							isVia = true;
						}
					} else {
						isVia = true;
					}
				}
				if(isSeat && isVia){
					var v1 = dataFilter(airports,[{col:"id",val: airport}])[0];
					good.airport = v1.name;
					v_sites[airport_name].list.push(good);
				}
				
			}
		}					
		
		v_sites[airport_name].pages[depdate][pageNo].dataRecieved = true;
		
		var cnt_all = _.filter(v_sites,function(site){
			var v_cnt_dt = _.filter(site.pages,function(dt){
				var v_cnt = _.where(dt,{dataRecieved: false});
				return v_cnt.length == 0;
			});
			return v_cnt_dt.length == 0;
		});

		if(cnt_all.length == v_sites.length)
			fn_sqlcall();

		if(pageNo == 1){
			for( var i=2 ; i < Number(maxPageNo) ; i++ ){
				searchSite(depdate,airport, i);
			}
		}

		
		// if( parseInt(pageNo) < parseInt(maxPageNo) ) {
		// 	searchSite(dt1,airport, parseInt(pageNo) +1);
		// }
			
		
		
	}


	function fn_sqlcall(){
		$.each(v_sites,function(name,site){
			//console.log(k);
			if(alasql.tables[name] == undefined && site.list.length >0){
				var v_sql = 'create table '+ name +'(';
    			var i = 0;
    			$.each(site.list[0],function(k,v){
    				//if( typeof v != "string")
    				//	return true;
    				
    				if(i > 0)
    					v_sql += ',';
    				if(k == 'NUM')
    					v_sql += 'NumberA' + ' ' + typeof v;
    				else
    					v_sql += k + ' ' + typeof v;
					i += 1;
    			});
    			v_sql += ')';
    			alasql(v_sql);
			}
			sortObjects(site.list,[['TotalSaleFare','asc'],'StartDT']);	
    		alasql.tables[name].data = site.list;
			alasql('create index idx_Price on '+ name +'(TotalSaleFare)');
			alasql('create index idx_AirPort_Price on '+ name +'(airport,TotalSaleFare)');
			alasql('create index idx_StartDT on '+ name +'(StartDT)');
		});

		alert("Complete!");
	}
	
	</script>
	
	<style type="text/css" title="main">
	
		html, body,form {
	        /* height: 100%; */
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        
	        font-size:11px;
	      }
		
		.dashboard-div{
			/* position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0; */
			width: 100%;
			/* margin-top: 10px; */
			/* height: 90%; */	
		}
		
		.container {
		    padding-right: 0px;
		    padding-left: 0px;
		}
		
		.chartContainer {
			width : auto;
			height: auto;
		    /* border: black; */
		   /*  border: 3px solid orange; */
		    border-width: 2px 2px 2px 2px;
		    border-color: orange;
		    border-style: solid; 
		    /* margin-top: 10px; */
		}
		
		.chartContainerSub {
			float: left;
		}
		
		.div-priority{
			/* width: 100%; */
			margin-left: 0 ;
			/* height: 20px; */		
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
		
		.modern-p-form{
			font-size:11px;
			font-family:inherit;
		}
		
		
		#loader {
		  position: absolute;
		  left: 50%;
		  top: 50%;
		  z-index: 1;
		  width: 150px;
		  height: 150px;
		  margin: -75px 0 0 -75px;
		  border: 16px solid #f3f3f3;
		  border-radius: 50%;
		  border-top: 16px solid #3498db;
		  width: 120px;
		  height: 120px;
		  -webkit-animation: spin 2s linear infinite;
		  animation: spin 2s linear infinite;
		}
		
		@-webkit-keyframes spin {
		  0% { -webkit-transform: rotate(0deg); }
		  100% { -webkit-transform: rotate(360deg); }
		}
		
		@keyframes spin {
		  0% { transform: rotate(0deg); }
		  100% { transform: rotate(360deg); }
		}
		
		/* Add animation to "page content" */
		.animate-bottom {
		  position: relative;
		  -webkit-animation-name: animatebottom;
		  -webkit-animation-duration: 1s;
		  animation-name: animatebottom;
		  animation-duration: 1s
		}
		
		@-webkit-keyframes animatebottom {
		  from { bottom:-100px; opacity:0 } 
		  to { bottom:0px; opacity:1 }
		}
		
		@keyframes animatebottom { 
		  from{ bottom:-100px; opacity:0 } 
		  to{ bottom:0; opacity:1 }
		}
		
		.btn_n2 {
		 	width: 100px;		 	
		}
		
		.btn_n2:hover {
			width: 100px;
			cursor: pointer;
			text-decoration: none;
		}
		
		.btn_n2:active {
		  width: 100px;
		}
		
		<%-- 탭뷰--%>
		a:hover,a:focus{
		    text-decoration: none;
		    outline: none;
		    cursor: pointer;
		}
		.nav-tabs {
		    border-bottom: 1px solid #e4e4e4;
		}
		.nav-tabs > li{
		    margin-right: 1px;
		}
		.nav-tabs > li > a{
		    border-radius: 0px;
		    border: 1px solid #e4e4e4;
		    border-right: 0px none;
		    margin-right: 0px;
		    padding: 8px 17px;
		    color:#222222;
		    transition: all 0.3s ease-in 0s;
		}
		.nav-tabs > li:last-child{
		    border-right:1px solid #ededed;
		}
		.nav-tabs > li > a{
		    /* padding: 15px 30px; */
		   /*  padding: 4px 6px; */
		    border:1px solid #ededed;
		    border-right: 0px none;
		    border-top: 2px solid #ededed;
		    background: #ededed;
		    color: #8f8f8f;
		    font-weight: bold;
		}
		.nav-tabs > li > a:hover{
		    border-bottom-color: #ededed;
		    border-right: 0px none;
		    background: #f1f1f1;
		    color: #444;
		}
		.nav-tabs > li.active > a,
		.nav-tabs > li.active > a:focus,
		.nav-tabs > li.active > a:hover{
		    border-top: 2px solid #3498db;
		    border-right: 0px none;
		    color: #444;
		}
		.tab-content > .tab-pane{
		    border: 1px solid #e4e4e4;
		    border-top: 0px none;
		    /* padding: 20px; */
		   /*  padding: 20px; */
		    line-height: 22px;
		}
		.tab-content > .tab-pane > h3{
		    margin-top: 0;
		}
		
		
		.table>tbody>tr>td{
			padding: 3px;
		}
		
		
		
		<%--
		/* chart가 숨김시 작아지는 현상 없앰 */
		
		.tab-content > .tab-pane,
		.pill-content > .pill-pane {
		    display: block;    
		    height: 0;          
		    overflow-y: hidden; 
		}
		
		.tab-content > .active,
		.pill-content > .active {
		    height: auto;       
		} 
		--%>
		
		.tab-content .ui-th-column{
			text-align: center;
		}
		
		.table-copy:before {
		    content: "\e142";
		}
		
		/***  jqgrid Header   ***/
		.ui-jqgrid-hdiv th {
			text-align: center;
		}
		
		.ui-jqgrid .ui-jqgrid-labels th.ui-th-column {
    	    background-color: #f5f5f5;;
    	    background-image: none
    	}
    	
    	.ui-jqgrid .ui-jqgrid-htable th div {
			height:auto;
			overflow:hidden;
			padding-right:4px;
			padding-top:2px;
			position:relative;
			vertical-align:text-top;
			white-space:normal !important;
			}
		th.ui-th-column div{
	        white-space:normal !important;
	        height:auto !important;
	        padding:2px;
	    }
	    
		input[type="text"], input[type="password"]{
	    	height: 34px;
	    }
	    
	    #tabContainer_host .tab_2depth {height: 19px; margin-left: 10px;}
	    #tabContainer_host .tab_2depth .on {border: 1px solid #fb6c07;background: rgba(252, 132, 57, 0.67);}
	    #tabContainer_host .tab_2depth li a {
	        height: 15px;
    		line-height: 16px;
    	}
    	
    	
    	.cellDiv 
        {
            left: 0px; top:5px; height:22px;
            position:relative;padding:0;margin-right:-4px;border:0;
        }
        .gradient1{
            /* fallback (Opera) */
            background: #008AEF;
            /* Mozilla: https://developer.mozilla.org/en/CSS/-moz-linear-gradient */
            background: -moz-linear-gradient(left, #008AEF, white);
            /* Chrome, Safari: http://webkit.org/blog/175/introducing-css-gradients/ */
            background: -webkit-gradient(linear, left top, right top, from(#008AEF), to(white));
            /* MSIE http://msdn.microsoft.com/en-us/library/ms532997(VS.85).aspx */
            filter: progid:DXImageTransform.Microsoft.Gradient(StartColorStr='#008AEF', EndColorStr='white', GradientType=1);
            /*ie8*/
            -ms-filter: "progid:DXImageTransform.Microsoft.Gradient(StartColorStr='#008AEF', EndColorStr='white', GradientType=1)";
            position: absolute; left: -2px; top:-5px; right: 2px; height:22px; float:left;
        }
    	.gradient2{
            /* fallback (Opera) */
            background: #63C384;
            /* Mozilla: */
            background: -moz-linear-gradient(left, #63C384 0%, white 100%);
            /* Chrome, Safari:*/
            background: -webkit-gradient(linear, left top, right top, from(#63C384), to(white));
            /* MSIE */
            filter: progid:DXImageTransform.Microsoft.Gradient(StartColorStr='#63C384', EndColorStr='white', GradientType=1);
            /*ie8*/
            -ms-filter: "progid:DXImageTransform.Microsoft.Gradient(StartColorStr='#63C384', EndColorStr='white', GradientType=1)";
            position: absolute; left: -2px; top:-5px; right: 2px; height:22px; float:left;
        }
        .cellTextRight
        {
            position:relative;
            margin-right:4px;
            text-align:right;
            float:right;
        }
		
	</style>
</head>


<body  style="min-width:920px" >
<form name="form" id="form" class="">
	<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
	<div id="searchCondition"></div>
	<div id="contentMain" style="margin-top: 10px;width: 100%;"></div>

	<div id="loader"></div>
	<div id="mdp-demo"></div>
</form>

 <div id="dialog-confirm"></div>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
