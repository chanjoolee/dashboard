<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<meta name="viewport" content="width=device-width, initial-scale=1"/>
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no"/>
    <title>corona summary</title>
    <script src="js/jquery/jquery-1.11.2.min.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />
    <!-- 합쳐지고 최소화된 최신 CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
    

    <!-- 부가적인 테마 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
    <link rel="stylesheet" href="http://bootstrapk.com/assets/css/docs.min.css"/>

    <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
	
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" />
	<script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script>
	
	
	
	<%-- File Saver --%>
	<script type="text/javascript" src="/dashboard/js/FileSaver.js/FileSaver.js" charset="utf-8"></script>
	<script type="text/javascript" src="/dashboard/js/jquery-zclip-master/jquery.zclip.js"></script>
	
	<script type="text/javascript" src="/dashboard/js/alasql-develop/dist/alasql.js"></script>
	<script src="/dashboard/js/jointjs/lodash.min.js"></script>
	
	<%-- jqueryMohthPicker --%>
    <link rel="https://cdn.jsdelivr.net/gh/KidSysco/jquery-ui-month-picker@v3.0.0/demo/MonthPicker.min.css" />
   	<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/digitalBush/jquery.maskedinput@1.4.1/dist/jquery.maskedinput.min.js"></script>
   	<script type="text/javascript" src="https://cdn.jsdelivr.net/gh/KidSysco/jquery-ui-month-picker@v3.0.0/demo/MonthPicker.min.js"></script>
	
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
	
	<%-- 4. local common --%>
	<script src="js/dashboard.1.js"></script>
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
										
										{
											type:'SearchHeader',
											id: 'sampleHead',
											name: 'sampleHead',
											label:'',
											text:'Start Date ',
											width: '100px',
											containerCss:[
									    		{code:'text-align',value:'right'}
									    	]
										},
										{
											type: 'dateInput',
											id: 'dateFrom',
											name: 'dateFrom',
											label:'',
											//value:'',
											//width:'100px',
// 											cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												
											],
											controlCss:[
												{code: 'text-align', value:'center'},
												{code: 'height', value:'1.8em'}
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
										
										{
											type:'SearchHeader',
											id: 'airportHead',
											name: 'airportHead',
											label:'',
											text:'Airport',
											width: '100px',
											containerCss:[
									    		{code:'text-align',value:'right'}
									    	]	
										},
										{
											type:'multiCombo',
											id: 'search_airport',
											name: 'search_airport',
											label:'',
											text:'Project',
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
													 return numChecked + ' of ' + numTotal + ' checked';
													 
													 /*var sb = [];
													 $.each(checkedItems,function(){
														 sb.push($(this).val());
													 });
													 return sb.join(",");*/
												}
											},
											events:{
											
											}
										} ,
										{
											type:'SearchHeader',
											id: 'termHead',
											name: 'termHead',
											label:'',
											text:'Travel Days ',
											width: '100px',
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
// 											cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												
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
										{
											type:'SearchHeader',
											id: 'searchGubunHead',
											name: 'searchGubunHead',
											label:'',
											text:'Search Gubun(day/month) ',
											width: '200px',
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
										{
											type:'SearchHeader',
											id: 'searchRangMMHead',
											name: 'searchRangMMHead',
											label:'',
											text:'Search Range ',
											width: '150px',
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
// 											cls: 'btn_txt btn_type_d btn_color_b',
											containerCss:[
												
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
										}
										
									
									]
								}
								//2line
								
								
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
											type:'Button_bootstrap',
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
		var dt1 = start; //dateAdd(dt1,Number($("#travel_term").val());
		//var year = dt1.substr(0,4);
		//var mm = dt1.substr(4,2);
		//var dd = dt1.substr(6,2);
		//var dt1a = new Date(year,mm - 1, dd);
		
		while( dt1 < end ){
			$.each($("#search_airport").val(),function(i,dep){
				searchSite(dt1,dep);
			});
			
			dt1 = dateAdd(dt1,1);
			//break;
		}
		
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
	
	function searchSite(dt1,airport){
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
		url += "&PageNo=1";
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
		url += "&Callback=onJsonResult";
		var paramObj = {};
		paramObj.sites = [
//			{
//				name: "koreaAirline",
//				//url: "https://kr.koreanair.com/korea/ko/booking/booking-gate.html"
//				url: "https://kr.koreanair.com"
//			},
//			{
//				name: "koreaAirline-booking",
//				//url: "https://kr.koreanair.com/korea/ko/booking/booking-gate.html"
//				url: "https://kr.koreanair.com/korea/ko/booking/booking-gate.html"
//			},
			// 국내항공
//			{
//				name: "interpark-air",
//				//url: "http://domair.interpark.com/api/booking/airJourney.do?format=json&dep=CJU&arr=GMP&depDate=20171015&adt=1&chd=0&inf=0&tripDivi=0&airlineCode=KE"
//				url: "http://domair.interpark.com/api/booking/airJourney.do?format=json&dep=CJU&arr=GMP&depDate="+dt1+"&adt=1&chd=0&inf=0&tripDivi=0"
//			},
			// 해외항공
			{
				name: "interpark_air",
				url: url
			}
//			,{
//				name: "koreaAirline-booking",
//				url: "https://kr.koreanair.com/content/koreanair/global/en.html"
//			}
//			,{
//				name: "naver",
//				url: "https://www.naver.com/"
//			}
//			,{
//				name: "jira",
//				url: "http://jira.skhynix.com/secure/RapidBoard.jspa?rapidView=902&quickFilter=1005"
//			}
		];
		
		$.ajax({
			type: "POST",
			url: "/dashboard/webSearchJson.html",
			data: {searchJson: JSON.stringify(paramObj)}, 
			async: false,
			success:  function(response){
				$.each(response.result.searchJson.sites,function(i,site){
					site.responseJson = eval(site.response.substr(12));
					if(site.responseJson.Responses.GoodsList == "") 
						return true;						
//					var cnt = parseInt(site.responseJson.Responses.GoodsSummary.RealGoodCnt);
//					//var cnt = parseInt(site.responseJson.Responses.GoodsSummary.TotalGoodCnt);
//					if(cnt == 0) 
//						return true;
						
					if( v_sites[site.name] == undefined ){
						v_sites[site.name] = {
							list : [],
							best : {}
						};
					}	
					
					if($.isArray(site.responseJson.Responses.GoodsList.Goods)){
						sortObjects(site.responseJson.Responses.GoodsList.Goods,[['TotalSaleFare','asc']]);
						var goods = site.responseJson.Responses.GoodsList.Goods;
						// site list add to v_sites
						$.each(goods,function(j,good){
							var v1 = dataFilter(airports,[{col:"id",val:airport}])[0];
							good.airport = v1.name;
							v_sites[site.name].list.push(good);
						});
					}else{
						v_sites[site.name].list.push(site.responseJson.Responses.GoodsList.Goods);
					}
					
					console.log(dt1);
					/////////// best logic 01.
					// site best
					//sortObjects(v_sites[site.name].list, [['TotalSaleFare','asc']]);
					//v_sites[site.name].best = v_sites[site.name].list[0];
					
					/////////// best logic 02.
//					sortObjects(goods, [['TotalSaleFare','asc']]);
//					site.best = goods[0];
//					console.log(dt1 + ' Best:');
//					console.log(goods[0]);
//					if(v_sites[site.name]['best']['TotalSaleFare'] == undefined){
//						v_sites[site.name].best = goods[0];
//						console.log(v_sites[site.name].best);
//					}
//						
//					if(Number(goods[0].TotalSaleFare) < Number(v_sites[site.name].best.TotalSaleFare)){
//						v_sites[site.name].best = goods[0];
//						console.log('Best:');
//						console.log(v_sites[site.name].best);
//					}

					// BEST Logic alasql create index by TotalSaleFare
						
					
					//console.log(v_sites[site.name].best);
					
				});
				v_list.push(response);	
				//console.log(v_response);
				// v_list[0].result.searchJson.sites[0].responseJson.Responses.GoodsList
				// v_list[0].result.searchJson.sites[0].responseJson.Responses.GoodsList.Goods
				// sortObjects(v_list[0].result.searchJson.sites[0].responseJson.Responses.GoodsList.Goods,[['TotalSaleFare','asc']])
			}
		});
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
		
		
		
	</style>
	
	<%-- Bootstrap Css--%>
	<style type="text/css"  >
		.col-md-2{
			
		}
		.show-grid [class^=col-]{
			background-color: transparent;
			border:0px solid #ddd;
			
			padding-left: 10px;
			padding-right: 5px;
			padding-bottom: 10px;
			padding-top: 10px;
			width: auto;
			
		}
	</style>
</head>


<body  style="min-width:920px" >
<form name="form" id="form" class="">
	<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>

	<div id="searchCondition" class="panel panel-default"></div>
	<div id="contentMain" style="margin-top: 10px;width: 100%;"></div>

	<div id="loader"></div>
</form>

 <div id="dialog-confirm"></div>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>	
