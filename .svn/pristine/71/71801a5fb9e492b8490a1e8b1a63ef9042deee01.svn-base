<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>performance</title>
    <%-- 1. jquery --%>
    <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
    <!-- <script src="js/jquery.csv-0.71.js"></script> -->
    
    <%-- jqgrid --%>
    <!-- <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script> -->
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js"></script>
    <script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js"></script>    
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
	<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	
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
	<script src="js/dashboard.js?version=1"></script>
	
	<%-- 5. local --%>
	<!-- <link rel="stylesheet" type="text/css" href="js/highslide/highslide.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" /> -->
	<!-- <link rel="stylesheet" type="text/css" href="http://www.trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" /> -->
	
	<%-- multi select --%>
	<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
	<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
	<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
	<!-- <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" /> -->
	<script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script>
	
	<link rel="stylesheet" type="text/css" href="/nspim/css/new.css" />
	<link rel="stylesheet" type="text/css" href="/nspim/css/board.css" />
	<script type="text/javascript">
	var categoryInfo =[
	     		      {
	     					category:'Latency.csv',
	     					calculateCols:[
								{
									col:'ORDER',
									val: function(){
										if(this.SPEC.match(/Seq_Read/gi) != null  ){
												return 1;
											}else if(this.SPEC.match(/Ran_Read/gi) != null ){
												return 2;
											}else if(this.SPEC.match(/Seq_Write/gi) != null ){
												return 3;
											}else if(this.SPEC.match(/Ran_Write/gi) != null ){
												return 4;
											}else{
												return 100;
											}
										
									}
								}      
	     					],
	     					filters:[
	     						{col:'FIELD',val:'Average Response Time'}
	     					],
	     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
	     					categoryCols:['SPEC'],
	     					yCol:'MEASURE',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:false,
	     						cols:[]
	     					},
	     					decimalPoint:2,
	     					orderby: 9
	     			 },
	     			 {
	     					category:'SLC_Latency.csv',
	     					calculateCols:[
								{
									col:'ORDER',
									val: function(){
										if(this.SPEC.match(/Seq_Read/gi) != null  ){
												return 1;
											}else if(this.SPEC.match(/Ran_Read/gi) != null ){
												return 2;
											}else if(this.SPEC.match(/Seq_Write/gi) != null ){
												return 3;
											}else if(this.SPEC.match(/Ran_Write/gi) != null ){
												return 4;
											}else{
												return 100;
											}
										
									}
								}      
	     					],
	     					filters:[
	     						{col:'FIELD',val:'Average Response Time'}
	     					],
	     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
	     					categoryCols:['SPEC'],
	     					yCol:'MEASURE',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:false,
	     						cols:[]
	     					},
	     					decimalPoint:2,
	     					orderby:2
	     			 },
	     			 {
	     					category:'Max Throughput.csv',
	     					calculateCols:[
								{
									col:'ORDER',
									val: function(){
										if(this.SPEC.match(/Seq_Read/gi) != null  ){
												return 1;
											}else if(this.SPEC.match(/Ran_Read/gi) != null ){
												return 2;
											}else if(this.SPEC.match(/Seq_Write/gi) != null ){
												return 3;
											}else if(this.SPEC.match(/Ran_Write/gi) != null ){
												return 4;
											}else{
												return 100;
											}
										
									}
								}                     
	     					],
	     					filters:[
	     						{col:'FIELD',val:'MBps (Decimal)'},
	     						{col:'FIELD',val:'IOps'}
	     					],
	     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
	     					categoryCols:['FIELD','SPEC'],
	     					yCol:'MEASURE',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:true,
	     						splitCol:'FIELD'
	     					}
	     					,orderby: 8
	     			 },
	     			 {
	     					category:'SLC_Max Throughput.csv',
	     					calculateCols:[
								{
									col:'ORDER',
									val: function(){
										if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return 1;
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return 2;
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return 3;
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return 4;
	     								}else{
	     									return 100;
	     								}
										
									}
								}               
	     					],
	     					filters:[
	     						{col:'FIELD',val:'MBps (Decimal)'},
	     						{col:'FIELD',val:'IOps'}
	     					],
	     					xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
	     					categoryCols:['FIELD','SPEC'],
	     					yCol:'MEASURE',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:true,
	     						splitCol:'FIELD'
	     					}
	     					, orderby:1
	     			 },
	     			 {
	     				 	//x축을 2개이상 사용하도록 설정필요.
	     					category:'QD 1 to 32.csv',
	     					calculateCols:[
								{
									col:'QD_QUEUE_DEPTH',
									val: function(){
										return 'QD_' + this.QUEUE_DEPTH;
										
									}
								},
	     						{
	     							col:'QD_CAL',
	     							val: function(){
	     								if((this.SPEC.match(/^4kb/gi) != null ) && this.FIELD == 'IOps'){
	     									return 'O';
	     								}else if((this.SPEC.match(/^4kb/gi) == null ) && this.FIELD == 'MBps (Decimal)'){
	     									return 'O';
	     								}else{
	     									return 'null';
	     								}
	     								
	     							}
	     						}
	     					],
	     					filters:[
	     						{col:'QD_CAL',val:  'O'}
	     					],
	     					xOderbyCols:['FIRMWARE1','QD_QUEUE_DEPTH'],
	     					categoryCols:['SPEC','QD_QUEUE_DEPTH'],
	     					yCol:'MEASURE',
	     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     					multichart:{
	     						enabled:true,
	     						splitCol:'SPEC',
	     						chartWidth: 50 , // percent 로 표시
	     						oneLineChatNum: 2,
	     						oneLineHeight: 600
	     					},
	     					orderby: 10
	     			 },
	     			 {
	     				 	//x축을 2개이상 사용하도록 설정필요.
	     					category:'SLC_QD 1 to 32.csv',
	     					calculateCols:[
								{
										col:'QD_QUEUE_DEPTH',
										val: function(){
											return 'QD_' + this.QUEUE_DEPTH;
											
										}
									},
		     						{
		     							col:'QD_CAL',
		     							val: function(){
		     								if((this.SPEC.match(/^4kb/gi) != null ) && this.FIELD == 'IOps'){
		     									return 'O';
		     								}else if((this.SPEC.match(/^4kb/gi) == null ) && this.FIELD == 'MBps (Decimal)'){
		     									return 'O';
		     								}else{
		     									return 'null';
		     								}
		     								
		     							}
		     						}
		     					],
		     					filters:[
		     						{col:'QD_CAL',val:  'O'}
		     					],
		     					xOderbyCols:['FIRMWARE1','QD_QUEUE_DEPTH'],
		     					categoryCols:['SPEC','QD_QUEUE_DEPTH'],
		     					yCol:'MEASURE',
		     					seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		     					multichart:{
		     						enabled:true,
		     						splitCol:'SPEC',
		     						chartWidth: 50 , // percent 로 표시
		     						oneLineChatNum: 2,
		     						oneLineHeight: 600
		     					},
		     					orderby:3
	     			 },
	     			 {
	     			 	//x축을 2개이상 사용하도록 설정필요.
	     				category:'Workload_Align.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},      
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 400
	     				},
	     				orderby: 11
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요.
	     				category:'Workload_Unalign.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},   
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 400
	     				},
	     				orderby: 12
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요. 
	     				category:'SLC_Workload_Align.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},    
	     					{
	     						col:'WA_CATEGORY',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
	     									return '01.Seq.Read';
	     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
	     									return '02.Ran.Read';
	     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
	     									return '03.Seq.Write';
	     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
	     									return '04.Ran.Write';
	     								}else{
	     									return 'null';
	     								}
	     							}else return 'null'
	     							
	     						}
	     					},
	     					{
	     						col:'WA_SPEC',
	     						val: function(){
	     							if(this.FIELD == 'MBps (Decimal)'){
	     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
	     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
	     								}else{
	     									return 'null';
	     								}
	     							}else{
	     								return 'null';
	     							}
	     							
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
	     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
	     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
	     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
	     					{col:'FIELD',val:'MBps (Decimal)'}
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
	     				categoryCols:['WA_CATEGORY','WA_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true ,
	     					splitCol:'WA_CATEGORY',
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 400
	     				},
	     				orderby: 4
	     		 	},
	     		 	{
	     			 	//x축을 2개이상 사용하도록 설정필요. 
	     				category:'SLC_Workload_Unalign.csv',
	     				calculateCols:[
							{
								col:'ORDER',
								val: function(){
									if(this.SPEC.match(/512B/gi) != null  ){
											return 1;
										}else if(this.SPEC.match(/^4KB/gi) != null ){
											return 2;
										}else if(this.SPEC.match(/^8KB/gi) != null ){
											return 3;
										}else if(this.SPEC.match(/^16KB/gi) != null ){
											return 4;
										}else if(this.SPEC.match(/^32KB/gi) != null ){
											return 5;
										}else if(this.SPEC.match(/^64KB/gi) != null ){
											return 6;
										}else if(this.SPEC.match(/^128KB/gi) != null ){
											return 7;
										}else if(this.SPEC.match(/^256KB/gi) != null ){
											return 8;
										}else if(this.SPEC.match(/^512KB/gi) != null ){
											return 9;
										}else if(this.SPEC.match(/^1MB/gi) != null ){
											return 10;
										}else if(this.SPEC.match(/^2MB/gi) != null ){
											return 11;
										}else if(this.SPEC.match(/^4MB/gi) != null ){
											return 12;
										}else if(this.SPEC.match(/^8MB/gi) != null ){
											return 13;
										}else{
											return 100;
										}
									
								}
							},   
     					{
     						col:'WA_CATEGORY',
     						val: function(){
     							if(this.FIELD == 'MBps (Decimal)'){
     								if(this.SPEC.match(/Seq_Read/gi) != null  ){
     									return '01.Seq.Read';
     								}else if(this.SPEC.match(/Ran_Read/gi) != null ){
     									return '02.Ran.Read';
     								}else if(this.SPEC.match(/Seq_Write/gi) != null ){
     									return '03.Seq.Write';
     								}else if(this.SPEC.match(/Ran_Write/gi) != null ){
     									return '04.Ran.Write';
     								}else{
     									return 'null';
     								}
     							}else return 'null'
     							
     						}
     					},
     					{
     						col:'WA_SPEC',
     						val: function(){
     							if(this.FIELD == 'MBps (Decimal)'){
     								if(this.SPEC.match(/^[\d]+[\w]+/gi) != null  ){
     									return this.SPEC.match(/^[\d]+[a-z]{0,2}/gi)[0];
     								}else{
     									return 'null';
     								}
     							}else{
     								return 'null';
     							}
     							
     						}
     					}
     				],
     				filters:[
     					{col:'WA_CATEGORY',val:  '01.Seq.Read'},
     					{col:'WA_CATEGORY',val:  '02.Ran.Read'},
     					{col:'WA_CATEGORY',val:  '03.Seq.Write'},
     					{col:'WA_CATEGORY',val:  '04.Ran.Write'},
     					{col:'FIELD',val:'MBps (Decimal)'}
     				],
     				xOderbyCols:['FIRMWARE1','ORDER','WA_SPEC'],
     				categoryCols:['WA_CATEGORY','WA_SPEC'],
     				yCol:'MEASURE',
     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     				multichart:{
     					enabled:true ,
     					splitCol:'WA_CATEGORY',
     					chartWidth: 50 , // percent 로 표시
     					oneLineChatNum: 2,
     					oneLineHeight: 400
     				},
     				orderby: 5
	     		 },
	     		 	{
	     				category:'Mixed_Seq_RW.csv',
	     				calculateCols:[
	     					{
	     						col:'MIXED_SERIES',
	     						val: function(){
	     							if(this.FIELD == 'Read MBps (Decimal)'  ){
	     								return 'Read';
	     							}else if(this.FIELD == 'Write MBps (Decimal)' ){
	     								return 'Write';
	     							}else{
	     								return null;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'MIXED_SPEC',
	     						val: function(){
	     							//return this.SPEC;
	     							if(this.SPEC.match(/R[\d]+\/W[\d]+$/gi) != null  ){
	     								return this.SPEC.match(/R[\d]+\/W[\d]+$/gi)[0];
	     							}else{
	     								return this.SPEC;
	     							}
	     						}
	     					},
	     					{
	     						col:'MIXED_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'MIXED_SERIES',val:  'Read'},
	     					{col:'MIXED_SERIES',val:  'Write'}				
	     				],
	     				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
	     				xOderbyCols:['MIXED_SERIES',['MIXED_SPEC','desc']],
	     				categoryCols:['FIRMWARE1','MIXED_SPEC'],
	     				yCol:'MEASURE',
	     				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
	     				seriesCol:{cd:'MIXED_SERIES',name:'MIXED_SERIES'},
	     				multichart:{
	     					enabled: true,
	     					splitCol:'FIRMWARE1'
	     				},
	     				addSeries:[
	     					{
	     						name: 'Sum',
	     						type: 'spline',
	     						seriesFunction: function(){
		  	     						var series = arguments;
		  	     						var addS = this;
		     							$.each(series,function(seriesIndex,s){
		     								$.each(s.data,function(dataIndex,d){
		     									if(addS.data[dataIndex] != undefined){
		     										addS.data[dataIndex].y += d.y;
		     									}else{
		     										addS.data[dataIndex] = {
		     											y : d.y	
		     										};
		     									}
		     								});
		     								
		     							});
		     						}
	     					}
	     				],
	     				orderby: 13
	     		 	},
	     		 	{
	     				category:'Mixed_Ran_RW.csv',
	     				calculateCols:[
	     					{
	     						col:'MIXED_SERIES',
	     						val: function(){
	     							if(this.FIELD == 'Read MBps (Decimal)'  ){
	     								return 'Read';
	     							}else if(this.FIELD == 'Write MBps (Decimal)' ){
	     								return 'Write';
	     							}else{
	     								return null;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'MIXED_SPEC',
	     						val: function(){
	     							//return this.SPEC;
	     							if(this.SPEC.match(/R[\d]+\/W[\d]+$/gi) != null  ){
	     								return this.SPEC.match(/R[\d]+\/W[\d]+$/gi)[0];
	     							}else{
	     								return this.SPEC;
	     							}
	     						}
	     					},
	     					{
	     						col:'MIXED_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     					{col:'MIXED_SERIES',val:  'Read'},
	     					{col:'MIXED_SERIES',val:  'Write'}				
	     				],
	     				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
	     				xOderbyCols:['MIXED_SERIES',['MIXED_SPEC','desc']],
	     				categoryCols:['FIRMWARE1','MIXED_SPEC'],
	     				yCol:'MEASURE',
	     				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
	     				seriesCol:{cd:'MIXED_SERIES',name:'MIXED_SERIES'},
	     				multichart:{
	     					enabled: true,
	     					splitCol:'FIRMWARE1'
	     				},
	     				addSeries:[
	   	     					{
	   	     						name: 'Sum',
	   	     						type: 'spline',
		   	     					seriesFunction: function(){
			  	     						var series = arguments;
			  	     						var addS = this;
			     							$.each(series,function(seriesIndex,s){
			     								$.each(s.data,function(dataIndex,d){
			     									if(addS.data[dataIndex] != undefined){
			     										addS.data[dataIndex].y += d.y;
			     									}else{
			     										addS.data[dataIndex] = {
			     											y : d.y	
			     										};
			     									}
			     								});
			     								
			     							});
			     						}
	   	     					}
	   	     				],
	   	     			orderby: 14
	     		 	},
	     		 	{
	     				category:'SLC_Mixed_Seq_RW.csv',
	     				calculateCols:[
 		     					{
 		     						col:'MIXED_SERIES',
 		     						val: function(){
 		     							if(this.FIELD == 'Read MBps (Decimal)'  ){
 		     								return 'Read';
 		     							}else if(this.FIELD == 'Write MBps (Decimal)' ){
 		     								return 'Write';
 		     							}else{
 		     								return null;
 		     							}
 		     							
 		     						}
 		     					},
 		     					{
 		     						col:'MIXED_SPEC',
 		     						val: function(){
 		     							//return this.SPEC;
 		     							if(this.SPEC.match(/R[\d]+\/W[\d]+$/gi) != null  ){
 		     								return this.SPEC.match(/R[\d]+\/W[\d]+$/gi)[0];
 		     							}else{
 		     								return this.SPEC;
 		     							}
 		     						}
 		     					},
 		     					{
 		     						col:'MIXED_DUMMY',
 		     						val: function(){
 		     							return 'measure';
 		     						}
 		     					}
 		     				],
 		     				filters:[
 		     					{col:'MIXED_SERIES',val:  'Read'},
 		     					{col:'MIXED_SERIES',val:  'Write'}				
 		     				],
 		     				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
 		     				xOderbyCols:['MIXED_SERIES',['MIXED_SPEC','desc']],
 		     				categoryCols:['FIRMWARE1','MIXED_SPEC'],
 		     				yCol:'MEASURE',
 		     				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
 		     				seriesCol:{cd:'MIXED_SERIES',name:'MIXED_SERIES'},
 		     				multichart:{
 		     					enabled: true,
 		     					splitCol:'FIRMWARE1'
 		     				},
 		     				addSeries:[
 		  	     					{
 		  	     						name: 'Sum',
 		  	     						type: 'spline',
	 		  	     					seriesFunction: function(){
	 		  	     						var series = arguments;
	 		  	     						var addS = this;
	 		     							$.each(series,function(seriesIndex,s){
	 		     								$.each(s.data,function(dataIndex,d){
	 		     									if(addS.data[dataIndex] != undefined){
	 		     										addS.data[dataIndex].y += d.y;
	 		     									}else{
	 		     										addS.data[dataIndex] = {
	 		     											y : d.y	
	 		     										};
	 		     									}
	 		     								});
	 		     								
	 		     							});
	 		     						}
 		  	     					}
 		  	     				] ,
 		  	     			orderby: 6
	     		 	},
	     		 	{
	     				category:'SLC_Mixed_Ran_RW.csv',
	     				calculateCols:[
  		     					{
  		     						col:'MIXED_SERIES',
  		     						val: function(){
  		     							if(this.FIELD == 'Read MBps (Decimal)'  ){
  		     								return 'Read';
  		     							}else if(this.FIELD == 'Write MBps (Decimal)' ){
  		     								return 'Write';
  		     							}else{
  		     								return null;
  		     							}
  		     							
  		     						}
  		     					},
  		     					{
  		     						col:'MIXED_SPEC',
  		     						val: function(){
  		     							//return this.SPEC;
  		     							if(this.SPEC.match(/R[\d]+\/W[\d]+$/gi) != null  ){
  		     								return this.SPEC.match(/R[\d]+\/W[\d]+$/gi)[0];
  		     							}else{
  		     								return this.SPEC;
  		     							}
  		     						}
  		     					},
  		     					{
  		     						col:'MIXED_DUMMY',
  		     						val: function(){
  		     							return 'measure';
  		     						}
  		     					}
  		     				],
  		     				filters:[
  		     					{col:'MIXED_SERIES',val:  'Read'},
  		     					{col:'MIXED_SERIES',val:  'Write'}				
  		     				],
  		     				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
  		     				xOderbyCols:['MIXED_SERIES',['MIXED_SPEC','desc']],
  		     				categoryCols:['FIRMWARE1','MIXED_SPEC'],
  		     				yCol:'MEASURE',
  		     				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
  		     				seriesCol:{cd:'MIXED_SERIES',name:'MIXED_SERIES'},
  		     				multichart:{
  		     					enabled: true,
  		     					splitCol:'FIRMWARE1'
  		     				},
  		     				addSeries:[
  		 	     					{
  		 	     						name: 'Sum',
  		 	     						type: 'spline',
	  		 	     					seriesFunction: function(){
	 		  	     						var series = arguments;
	 		  	     						var addS = this;
	 		     							$.each(series,function(seriesIndex,s){
	 		     								$.each(s.data,function(dataIndex,d){
	 		     									if(addS.data[dataIndex] != undefined){
	 		     										addS.data[dataIndex].y += d.y;
	 		     									}else{
	 		     										addS.data[dataIndex] = {
	 		     											y : d.y	
	 		     										};
	 		     									}
	 		     								});
	 		     								
	 		     							});
	 		     						}
  		 	     					}
  		 	     				],
  		 	     			orderby: 7
	     		 	},
	     		 	{
	     				category:'CDM301.xlsx',
	     				calculateCols:[
	     					{
	     						col:'CDM_SPEC',
	     						val: function(){	     							
	     							if(this.FIELD.match(/[\d]+/gi) != null ){
	     								var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\([\w\=\s,]+\))?/i);
	     								//["Read 4KB (QD=1)", "Read", "4KB", "(QD=1)"]
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								
	     								var vqd = '';
	     								if(arr[3] != undefined)
	     									vqd = arr[3];
	     								
	     								var vnum = '';
	     								if(arr[2] != undefined)
	     									vnum = arr[2];
	     								
	     								return arr[2] + ' ' + vspec + arr[1].substr(0,1) + vqd;
	     								
	     							}else{
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								return vspec + ' ' + this.FIELD;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'CDM_ORDER',
	     						val: function(){	     							
	     							if(this.FIELD.match(/[\d]+/gi) != null ){
	     								var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\([\w\=\s,]+\))?/i);
	     								//["Read 4KB (QD=1)", "Read", "4KB", "(QD=1)"]
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								
	     								var vqd = '';
	     								if(arr[3] != undefined)
	     									vqd = arr[3];
	     								
	     								var vnum = '';
	     								if(arr[2] != undefined)
	     									vnum = arr[2];
	     								
	     								return arr[2] + ' ' + vqd + vspec + arr[1].substr(0,1);
	     								
	     							}else{
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = '1.';
	     								else
	     									vspec = '2.';
	     								return vspec + ' ' + this.FIELD;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'CDM_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     					
	     				],
	     				xOderbyCols:['FIRMWARE1','CDM_ORDER','CDM_SPEC'],
	     				categoryCols:['CDM_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:false,
	     					cols:[]
	     				},
	     				orderby: 210
	     		 },
	     		 {
	     				category:'CDM503.xlsx',
	     				calculateCols:[
	     					{
	     						col:'CDM_SPEC',
	     						val: function(){
	     							if(this.FIELD.match(/[\d]+/gi) != null ){
	     								var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\([\w\=\s,]+\))?/i);
	     								//["Read 4KB (QD=1)", "Read", "4KB", "(QD=1)"]
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								
	     								var vqd = '';
	     								if(arr[3] != undefined)
	     									vqd = arr[3];
	     								
	     								var vnum = '';
	     								if(arr[2] != undefined)
	     									vnum = arr[2];
	     								
	     								return vnum + ' ' + vspec + arr[1].substr(0,1) + vqd;
	     								
	     							}else{
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = 'Seq.';
	     								else
	     									vspec = 'R.';
	     								return vspec + ' ' + this.FIELD;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'ORDER',
	     						val: function(){
	     							if(this.FIELD.match(/[\d]+/gi) != null ){
	     								var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\(([Q\s]+\=[\w\s]+)?,?([T\s]+\=[\w\s]+)?\))?/i);
	     								//["Read 4KiB (Q= 32,T= 1)", "Read", "4KiB", "(Q= 32,T= 1)", "Q= 32", "T= 1"]
	     								var qd = '0';
	     								if(arr[4] != undefined)
	     									qd = arr[4];
	     								
	     								
	     								var vspec = '0';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = '1';
	     								else
	     									vspec = '2';
	     								
	     								var vnum = '0';
	     								if(arr[2] != undefined)
	     									vnum = arr[2];
	     								
	     								var rw = '0';
	     								if(arr[1] != undefined)
	     									rw = arr[1];
	     								//return qd +'_'+ vnum + '_' +  vspec;
	     								return qd +'_'+ vnum + '_' + rw ;
	     								
	     							}else{
	     								var vspec = '';
	     								if(this.SPEC.match(/Sequential/gi) != null)
	     									vspec = '1. ';
	     								else
	     									vspec = '2. ';
	     								return vspec + ' ' + this.FIELD;
	     							}
	     							
	     						}
	     					},
	     					{
	     						col:'CDM_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     					
	     				],
	     				xOderbyCols:['FIRMWARE1','ORDER','CDM_SPEC'],
	     				categoryCols:['CDM_SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:false,
	     					cols:[]
	     				},
	     				orderby: 220
	     		 },
	     		{
     				category:'AS-SSD1.6.xml',
     				calculateCols:[
     					{
     						col:'AS_SSD_SPEC',
     						val: function(){
     							var sarr = this.SPEC.match(/([a-z]+)([\d]+[a-z]+)([\d]+)/i);
     							if(sarr != undefined){
     								//Random4K64TTest : ["Random4K64", "Random", "4K", "64"]
     								var rs = sarr[1];
     								var rst = '';
     								if(rs.match(/random/gi) != null)
     									rst = 'R.';
     								else
     									rst = 'Seq.';
     								var vol = sarr[2];
     								var speed = sarr[3];
     								var rw = this.FIELD;
     								var rwt = '';
     								if(rw.match(/read/gi) != null)
     									rwt = 'R';
     								else if(rw.match(/Write/gi) != null)
     									rwt = 'W';
     								
     								var speedt = '';
     								if(speed != undefined)
     									speedt = '('+speed+'Thrd)';
     								return vol + ' ' + rst + rwt + speedt;
     								
     							}else if(this.SPEC == 'AccTimeTest'){
     								if(this.FIELD == 'Read')
     									return 'Access Time(Read)';
     								else
     									return 'Access Time(Write)';
     							}else {
     								if(this.FIELD == 'Read')
     									return 'Seq. Read';
     								else
     									return 'Seq. Write';
     							}
     								
     							
     						}
     					},
     					{
     						col:'AS_SSD_ORDER',
     						val: function(){
     							var sarr = this.SPEC.match(/([a-z]+)([\d]+[a-z]+)([\d]+)/i);
     							if(sarr != undefined){
     								//Random4K64TTest : ["Random4K64", "Random", "4K", "64"]
     								var rs = sarr[1];
     								var rst = '';
     								if(rs.match(/random/gi) != null)
     									rst = 'R.';
     								else
     									rst = 'Seq.';
     								var vol = sarr[2];
     								var speed = sarr[3];
     								var rw = this.FIELD;
     								var rwt = '';
     								if(rw.match(/read/gi) != null)
     									rwt = 'R';
     								else if(rw.match(/Write/gi) != null)
     									rwt = 'W';
     								
     								var speedt = '';
     								if(speed != undefined)
     									speedt = '('+speed+'Thrd)';
     								//return vol + ' ' + rst + rwt + speedt;
     								return vol + ' ' + speedt + rst + rwt ;
     								
     							}else if(this.SPEC == 'AccTimeTest'){
     								if(this.FIELD == 'Read')
     									return 'Access Time(Read)';
     								else
     									return 'Access Time(Write)';
     							}else {
     								if(this.FIELD == 'Read')
     									return '1';
     								else
     									return '2';
     							}
     								
     							
     						}
     					},
     					{
     						col:'AS_SSD_DUMMY',
     						val: function(){
     							return 'measure';
     						}
     					}
     				],
     				filters:[
     					{col:'FIELD',val:'Read'},
     					{col:'FIELD',val:'Write'}
     				],
     				xOderbyCols:['FIRMWARE1','AS_SSD_ORDER','AS_SSD_SPEC'],
     				categoryCols:['AS_SSD_SPEC'],
     				yCol:'MEASURE',
     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     				multichart:{
     					enabled:false,
     					cols:[]
     				},
     				orderby: 230
     		 	},
     		 	{
     				category:'AS-SSD1.8.xml',
     				calculateCols:[
     					{
     						col:'AS_SSD_SPEC',
     						val: function(){
     							var sarr = this.SPEC.match(/([a-z]+)([\d]+[a-z]+)([\d]+)/i);
     							if(sarr != undefined){
     								//Random4K64TTest : ["Random4K64", "Random", "4K", "64"]
     								var rs = sarr[1];
     								var rst = '';
     								if(rs.match(/random/gi) != null)
     									rst = 'R.';
     								else
     									rst = 'Seq.';
     								var vol = sarr[2];
     								var speed = sarr[3];
     								var rw = this.FIELD;
     								var rwt = '';
     								if(rw.match(/read/gi) != null)
     									rwt = 'R';
     								else if(rw.match(/Write/gi) != null)
     									rwt = 'W';
     								
     								var speedt = '';
     								if(speed != undefined)
     									speedt = '('+speed+'Thrd)';
     								return vol + ' ' + rst + rwt + speedt;
     								
     							}else if(this.SPEC == 'AccTimeTest'){
     								if(this.FIELD == 'Read')
     									return 'Access Time(Read)';
     								else
     									return 'Access Time(Write)';
     							}else {
     								if(this.FIELD == 'Read')
     									return 'Seq. Read';
     								else
     									return 'Seq. Write';
     							}
     								
     							
     						}
     					},
     					{
     						col:'AS_SSD_ORDER',
     						val: function(){
     							var sarr = this.SPEC.match(/([a-z]+)([\d]+[a-z]+)([\d]+)/i);
     							if(sarr != undefined){
     								//Random4K64TTest : ["Random4K64", "Random", "4K", "64"]
     								var rs = sarr[1];
     								var rst = '';
     								if(rs.match(/random/gi) != null)
     									rst = 'R.';
     								else
     									rst = 'Seq.';
     								var vol = sarr[2];
     								var speed = sarr[3];
     								var rw = this.FIELD;
     								var rwt = '';
     								if(rw.match(/read/gi) != null)
     									rwt = 'R';
     								else if(rw.match(/Write/gi) != null)
     									rwt = 'W';
     								
     								var speedt = '';
     								if(speed != undefined)
     									speedt = '('+speed+'Thrd)';
     								//return vol + ' ' + rst + rwt + speedt;
     								return vol + ' ' + speedt + rst + rwt ;
     								
     							}else if(this.SPEC == 'AccTimeTest'){
     								if(this.FIELD == 'Read')
     									return 'Access Time(Read)';
     								else
     									return 'Access Time(Write)';
     							}else {
     								if(this.FIELD == 'Read')
     									return '1';
     								else
     									return '2';
     							}
     								
     							
     						}
     					},
     					{
     						col:'AS_SSD_DUMMY',
     						val: function(){
     							return 'measure';
     						}
     					}
     				],
     				filters:[
     					{col:'FIELD',val:'Read'},
     					{col:'FIELD',val:'Write'}
     				],
     				xOderbyCols:['FIRMWARE1','AS_SSD_ORDER','AS_SSD_SPEC'],
     				categoryCols:['AS_SSD_SPEC'],
     				yCol:'MEASURE',
     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     				multichart:{
     					enabled:false,
     					cols:[]
     				},
     				orderby: 240
     		 	},
	     		 {
	     				category:'PCMARK_VANTAGE.xlsx',
	     				calculateCols:[
							{
								col:'IS_SCORE',
								val: function(){
									if(this.SPEC == 'Score'  ){
											return 'Score';
										}else{
											return 'NotScore';
										}
									
								}
							},                     
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC','IS_SCORE'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE'
	     				},
	     				orderby: 250
	     		 },
	     		 {
	     				category:'PCMARK7.txt',
	     				calculateCols:[
							{
								col:'IS_SCORE',
								val: function(){
									if(this.SPEC.match(/Score/gi) != null  ){
											return 'Score';
										}else{
											return 'NotScore';
										}
									
								}
							},         
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE',
	     					chartWidth: 100 , // percent 로 표시
	     					oneLineChatNum: 1,
	     					oneLineHeight: 600
	     				},
	     				orderby: 260
	     		 },
	     		 {
	     				category:'PCMARK8.xml',
	     				calculateCols:[
						{
							col:'IS_SCORE',
							val: function(){
								if(this.SPEC.match(/Score/gi) != null  ){
										return 'Score';
									}else{
										return 'NotScore';
									}
								
							}
						},         
	     					{
	     						col:'PCMARK_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:true,
	     					splitCol:'IS_SCORE',
	     					chartWidth: 50 , // percent 로 표시
	     					oneLineChatNum: 2,
	     					oneLineHeight: 600
	     				},
	     				orderby: 270
	     		 },
	     		{
	     				category:'POR.txt',
	     				calculateCols:[
	     					
	     					{
	     						col:'POR_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:false,
	     					cols:[]
	     				},
	     				orderby: 280
	     		 },
	     		 {
	     				category:'SPOR.txt',
	     				calculateCols:[
	     					{
	     						col:'POR_DUMMY',
	     						val: function(){
	     							return 'measure';
	     						}
	     					}
	     				],
	     				filters:[
	     				],
	     				xOderbyCols:['FIRMWARE1','SPEC'],
	     				categoryCols:['SPEC'],
	     				yCol:'MEASURE',
	     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
	     				multichart:{
	     					enabled:false,
	     					cols:[]
	     				},
	     				orderby: 290
	     		 },
     		 	{
     				category:'SYSMARK2014.fdr',
     				calculateCols:[
     					{
     						col:'SYSMARK_DUMMY',
     						val: function(){
     							return 'measure';
     						}
     					}
     				],
     				filters:[
     				],
     				xOderbyCols:['FIRMWARE1','SPEC'],
     				categoryCols:['SPEC'],
     				yCol:'MEASURE',
     				seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
     				multichart:{
     					enabled:false,
     					cols:[]
     				},
     				orderby: 300
     		 }
	     		 
	     	];
	
	//공통적인 컬럼. 
	$.each(categoryInfo,function(){
		this.calculateCols.push(
			{
				col: 'FIRMWARE1',
				val: function(){
					
					var folder = dataFilter( multiSearchObj.analysisList,[{col:'FOLDER_NAME',val:this.FOLDER_NAME}]);
					if(folder.length > 0){
						return folder[0].target + '_' + this.PRODUCT_NAME + '_' + this.CAPACITY + '_' +  this.FIRMWARE;
					}
					else 
						return this.PRODUCT_NAME + '_' + this.CAPACITY + '_' +  this.FIRMWARE;
				}
			}
		);
		
		//add series compare
		if(this.addSeries == undefined)
			this.addSeries = [];
		var filters = dataFilter(this.addSeries,[{col:'name',val:'Compare'}]);
		if(filters.length == 0 && this.category.match(/Mixed_/gi) == null){			
			this.addSeries.push(
				{
					name: 'Compare',
					type: 'spline',
					yAxis : {
						title: 'increase rate',
						opposite: true,
						labels:{
							format:'{value:.1f}'
						}
						//, min: -10
					},
					seriesFunction: function(){
						var series = arguments;
						var addS = this;
						if(series.length == 1)
							return false;
						$.each(series[0].data,function(dataIndex,d){
							
							var diff = series[1].data[dataIndex].y - d.y;
							var increase = 0;
							if(d.y > 0){
								increase = (diff/d.y) * 100;
							}
							addS.data[dataIndex] = {
								y : increase ,
								diff: diff 
							};
						});	
						addS.yAxis = 1;
						addS.dataLabels = {
							enabled:false,
							format:'{point.y:.2f}%({point.diff:.2f})'
						};
						addS.tooltip = {
							pointFormat:'{series.name}: <b>{point.y:.2f}%({point.diff:.2f})</b>'
						};
						addS.color = '#24CBE5';
						
						return true;
					}
				}
			);
		}
		//add series compare end
		
	});
	</script>
	<script type="text/javascript">
// 요구사항 : 증가분 표시	
// 	table 필드 최소화
// 	증가분표시(비유로표시)
// 			검색테이블 필드추가
// 	차트별 table
// 			one row당 2개
// 	테이블 download? 
	
	
	//01. series데이타. project
	var dataList = [];
	var folderList = [];
	var multiSearchObj = {}
	var chartContainers = [];
	var pendingDrawChart = false;
	
	$(function () {
		Highcharts.setOptions({
	        //colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
			colors: ['#058DC7', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
	    });
// 		$.jgrid.styleUI.Bootstrap.base.headerTable = "table table-bordered table-condensed";
//         $.jgrid.styleUI.Bootstrap.base.rowTable = "table table-bordered table-condensed";
//         $.jgrid.styleUI.Bootstrap.base.footerTable = "table table-bordered table-condensed";
//         $.jgrid.styleUI.Bootstrap.base.pagerTable = "table table-condensed";
		getDataByJson();
	});
	
	function getDataByJson(){
		$.ajax({
			url : "/dashboard/performanceFolderListJson.html",
			data: $("#form").serialize(),
			success : function(responseData){
				//dataList = responseData.dataList;
				folderList = responseData.folderList;
				
				//var columns = ['FOLDER_NAME','EDIT_MODE','TARGET','SYSTEM', 'OPERATING_SYSTEM', 'VENDOR', 'PRODUCT_NAME', 'NAND_TECH', 'CELL_TYPE', 'CONTROLLER', 'FORM_FACTOR', 'CAPACITY', 'FIRMWARE', 'SLC_BUFFER', 'MEASURE_DT','IS_GOOD_DATA'];
				var columns = ['FOLDER_NAME','EDIT_MODE','TARGET','MEASURE_DT','VENDOR','PRODUCT_NAME', 'CONTROLLER', 'NAND_TECH','CELL_TYPE', 'FORM_FACTOR','CAPACITY','FIRMWARE','SLC_BUFFER','SERIAL_NUMBER','TEST_COUNT','IS_GOOD_DATA'];
				var gridColumns = [
	                   	{
								label: "Edit",
								search: false,
			                    name: "actions",
			                    width: 70,
			                    formatter: "actions",		                    
			                    formatoptions: {
			                        keys: true
			                        ,delbutton:false
			                        ,editOptions: {}
			                        ,addOptions: {}
			                        ,delOptions: {}
			                        ,afterSave : function(rowid,res) {
			                        	var theGrid = $("#"+ multiSearchObj.gridInfo.tableId);
			                        	theGrid.jqGrid('setRowData',rowid,{EDIT_MODE:'U'});
			                        	var row = theGrid.jqGrid('getRowData',rowid);
			                        	$.ajax({
			                    			url : "/dashboard/performanceSaveJson.html",
			                    			data: row,
			                    			//type: "POST",
			                    			//crossDomain: true,
			                    			//dataType: 'json',
			                    			success : function(responseData){
			                    				if(responseData.result == 'fail'){
			                    					alert(responseData.message);
			                    				}
			                    			}
			                    		});
			                        	
			                        }
			                        ,afterRestore : function(rowid) {
			                        	
			                        }
			                        ,onEdit :function(rowid,actop){
			                        	//jQuery("#rowed1").jqGrid('navGrid',"#prowed1",{edit:false,add:false,del:false});
			    						//alert(aaa);
			    					}
			                        
			                    } 
		                    
		                	}
		                	
                   ];
				$.each(columns,function(){
					var opt = {name: this, index: this, width: '90px',editable: false};
					if(this == 'EDIT_MODE'){
						opt.hidden = true;
					}
					if(this == 'FOLDER_NAME'){
						opt.hidden = true;
					}
					if(this == 'IS_GOOD_DATA'){
						opt.editable = true;
						opt.edittype="checkbox";
						opt.editoptions = {value:"Yes:No"};
						opt.width = '120px'
					}				
						
					gridColumns.push(opt);
				});
				multiSearchObj = new multiSearch(
						'selectContainer'
						,folderList
						,columns
						,{
							tableId:'jqgridTable',
							pagerId:'jqgridPager',
							sourceData: folderList,
							colModel:gridColumns
						}						
				);
				
				document.getElementById("loader").style.display = "none";
				//getDataListByAjax();
				
			}
		});
	}
	
	function getDataListByAjax(){
		
		$.ajax({
			url : "/dashboard/performanceDataListJson.html",
			data: $("#form").serialize(),
			success : function(responseData){
				dataList = responseData.dataList;
				if(pendingDrawChart){
					multiSearchObj.drawchart();
				}
				//clearTimeout(timeout);
				//folderList = responseData.folderList;
			}
		});
	}
	
	
	/**
	* jsonList를 자동으로 multisearch 만듬.
	* excel과 비슷한 filter적용. hierachey 가 아닌 다른조건들 감안
	* list table 추가.
	* 아 이것은 filter dataTable을 통해서 해결 할 수 있다.
	* @param container :  영역
	* @param jsonList: multsearch를 할 데이타소스
	* @param conTree: multisearch를 할 columns
	* @param gridInfo : {tableId:'', pagerId:'', sourceData :resultList,colModel:[{},] }
	*/
	function multiSearch(container,jsonList,colTree,gridInfo){
		var myInstance = this;
		this.container = container;
		this.jsonList = jsonList;
		this.colTree = [];
		this.gridInfo = gridInfo;
		this.analysisList = [];
		
		for(i in colTree){
			var col = colTree[i];
			if(typeof col == 'object'){
				if(col.isMultiple == undefined) 
					col.isMultiple = true;
				this.colTree.push(col);
			}else{
				var colconf = {
					name:col,
					isMultiple: true
				};
				this.colTree.push(colconf)
			}
				
		};
		this.prefix = 'search';
		this.searchList = [];
		
		this.makeSelectObjects = function(instance){
			$.each(instance.colTree,function(i,col){
				var colname=col.name;
				//makeSelectTag
				var $select = $(document.createElement( "select" ));
				$select.attr("id",instance.prefix+colname);
				$select.attr("name",instance.prefix+colname);
				$select.attr("col",colname);
				$select.css("width","150px");
				var list = groupbyCount(instance.groupbyList,[$select.attr("col")]);
				$.each(list,function(i1,m){
					$select.append($('<option>', {
					    value: m[$select.attr("col")],
					    text: m[$select.attr("col")]
					}));
				});
				
				//if(typeof col == 'object' && col.isMultiple)
				$select.attr("multiple","multiple");
				$select.attr("arrindex",i);
				
				
				//관리리스트에 추가
				instance.searchList.push($select);
				//dom에 추가
				$("#"+instance.container).append($select);
				//makeSelectTag end
				//multiselect start
				var opt = {
					multiple: col.isMultiple,
					width:200,
					minWidth: 150,
					//height:400,
					//selectedText: this.attr("col") + ' # ',
					noneSelectedText: 'select ' + $select.attr("col"),
					selectedText: function(numChecked, numTotal, checkedItems){
					      //return numChecked + ' of ' + numTotal + ' checked';
					      return this.element.attr("col") + ": " + $(checkedItems).val();
					},
					open: function(){
					      //$callback.text("Select opened!");
					 	$(this).attr("prev",  $(this).val() );
					 }
				};
				if(!col.isMultiple)
					opt.selectedList = 1;
				//$select.multiselect(opt).multiselectfilter();
				$select.multiselect(opt);
				
			});
			//multiselect end
		};
		
		this.tableSearch = function(instance){
			var theGrid = $("#"+ this.gridInfo.tableId);
			var lastsel2;
			var opt ={
					sortable: true,
					datatype: 'local',
					styleUI : 'Bootstrap',
					data: this.gridInfo.sourceData,
					colModel: this.gridInfo.colModel,
					rowNum:100000,
					//rowList:[10,20,30],
					//pager: this.gridInfo.pagerId,
					viewrecords: true,
					rownumbers: true, // show row numbers
			        multiSort:true,
			        multiselect: true,
			        multiboxonly:true,
			        //sortname: 'orderdate asc, price',
			        //sortorder: 'asc',           
			        caption: 'Analysis List',
			        width: '100%' , 
			        //height: '100%',
// 			        onSelectRow: function(id){
// 						if(id && id!==lastsel2){
// 							theGrid.jqGrid('restoreRow',lastsel2);
// 							theGrid.jqGrid('editRow',id,true);
// 							lastsel2=id;
// 						}
// 					}
// 	        	  	onSelectRow : function (rowid, status) {
// 		        	      return false;
// 		        	      //theGrid.setSelection(rowid, false);
// 	        	    }
					//,editurl:"/dashboard/performanceJson.html"
					editurl:'clientArray'
					//, cellEdit: true
					//, forceFit : true
					,cellsubmit: 'clientArray'
					//,cellsubmit: '/dashboard/performanceJson.html'
// 					,afterEditCell: function (id,name,val,iRow,iCol){
					
// 					}
//  					, afterSaveCell : function(rowid,name,val,iRow,iCol) {
// 						if(name == 'IS_GOOD_DATA') {
// 							theGrid.jqGrid('setRowData',rowid,{EDIT_MODE:'U'});
// 						}
						
// 					}
					//,altRows: true
			};
			
			theGrid.jqGrid(opt);
			theGrid.jqGrid('sortableRows');
			theGrid.jqGrid("setFrozenColumns");
			theGrid.jqGrid('filterToolbar',
				{
					defaultSearch:'cn'
	                // JSON stringify all data from search, including search toolbar operators
	                ,stringResult: true
	                // instuct the grid toolbar to show the search options
	                //searchOperators: true
	            }
			);
			//theGrid.jqGrid('navGrid','#' + this.gridInfo.pagerId,{});
			//theGrid.jqGrid('navGrid','#' + this.gridInfo.pagerId,{search: true,edit:false,add:false,del:false});
			//theGrid.jqGrid('inlineNav','#' + this.gridInfo.pagerId);
// 			theGrid.bind("jqGridAfterGridComplete", function () {
// 			    //alert('jqGridAfterGridComplete');
// 			});

			$('.ui-jqgrid').css("width",'100%');
			$('.ui-jqgrid-view').css("width",'100%');
			$('.ui-jqgrid-hdiv').css("width",'100%');
			$('.ui-jqgrid-bdiv').css("width",'100%');
			$('.ui-jqgrid-pager').css("width",'100%');
			
		};
		
		this.drawchart = function(){
			
			var theGrid = $("#"+ myInstance.gridInfo.tableId);
			var filters = [];
			var selIds = theGrid.jqGrid('getGridParam','selarrrow');
			
			if(selIds.length == 0){
				alert("select more than one item!");
				return;
			}else if(selIds.length>2){
				alert("select two items!");
				return;
			}
			
			$("#loader").show();
			$("#container").hide();
			
// 			if(dataList.length == 0 ){
// 				//alert("waiting data!");
// 				//return;
// 				//timeout = setTimeout(function(){ }, 20000);
// 				pendingDrawChart = true;
// 				return;
// 			}else{
// 				pendingDrawChart = false;
// 			}
			
			
			//Target set
			$.each(theGrid.jqGrid('getDataIDs'),function(i,rowid){
				theGrid.jqGrid('setRowData',rowid,{TARGET:''});
			});			
			
			multiSearchObj.analysisList = [];
			var firstIndex = theGrid.jqGrid('getDataIDs').indexOf(selIds[0]);
			var secondIndex = theGrid.jqGrid('getDataIDs').indexOf(selIds[1]);
			var minIndex = minValue([firstIndex,secondIndex]);
			$.each(selIds,function(i,s){
				var row = theGrid.jqGrid('getRowData',s);
				filters.push({col:"FOLDER_NAME",val: row.FOLDER_NAME});
				var currentIndex = theGrid.jqGrid('getDataIDs').indexOf(s);
				if(currentIndex == minIndex){
					row.target = 'Initial';
				}else{
					row.target = 'Target';
				}
				multiSearchObj.analysisList.push(row);
				theGrid.jqGrid('setRowData',s,{TARGET:row.target});
					
			});
			
			// 이미 있는데이타는 가져오지 않는다.
			var ajaxFilter = [];
			$.each(filters,function(){
				if(dataFilter(dataList,[this]).length == 0)
					ajaxFilter.push(this);
			});
			
			$.each($("[id^='chart_']"),function(){
				$(this).remove();
			});			
			//setTimPCMARK7.txtPCMARK7.txteout(function(){$("#loader").show(); }, 50);
			
			$("#loader").show();
			//document.getElementById("loader").style.display = "auto";
			setTimeout(function(){
				if(ajaxFilter.length > 0){
					$.ajax({
						url : "/dashboard/performanceDataListJson.html",
						//data: {FOLDER_NAME: jmespath.search(filters,"[?col=='FOLDER_NAME'].val") },
						data: {FOLDER_NAME: jmespath.search(ajaxFilter,"[?col=='FOLDER_NAME'].val") },
						//data: jmespath.search(filters,"[?col=='FOLDER_NAME'].{FOLDER_NAME: val}") ,
						async: false,
						success : function(responseData){
							//dataList.push(responseData.dataList);
							//dataList = dataList.concat(responseData.dataList);
							dataList = $.merge(responseData.dataList, dataList);		
						}
						//sucess End
					});
					//ajax End
				}
				
				//Start draw chart 
				var vList = dataFilter(dataList,filters);
				var vSrcList = groupbyCount(vList,['DATA_SRC']);
				
				//order by 조정
				$.each(vSrcList,function(i,src){
					var vCateInfos = dataFilter(categoryInfo,[{col:'category',val: src.DATA_SRC}]);
					var vCateInfo ={};
					if(vCateInfos.length> 0 ){
						vCateInfo = vCateInfos[0];
					}else{
				    	alert('category 정보가 없습니다.' + '('+ src.DATA_SRC +')');
				    	return false;
				    }
					if(vCateInfo.orderby != undefined){
						src.orderby = vCateInfo.orderby;
					}else
						src.orderby = 100;				
				});
				
				
				setTimeout(function(){
					
					sortObjects(vSrcList,['orderby']);
					$.each(vSrcList,function(i,src){
						drawchart(src.DATA_SRC);	
					});
					//theGrid.jqGrid('resetSelection');// 
					$('.ui-jqgrid').css("width",'100%');
					$('.ui-jqgrid-view').css("width",'100%');
					$('.ui-jqgrid-hdiv').css("width",'100%');
					$('.ui-jqgrid-bdiv').css("width",'100%');
					$('.ui-jqgrid-pager').css("width",'100%');
					$("#loader").hide();
					$("#container").show();
					$(window).trigger('resize');
				},50);
				//End draw chart
			
			},0);
			
			
			
		};
		
		
		
		this.groupbyList = groupbyCount(this.jsonList ,jmespath.search(this.colTree,'[*].name'));
		
		//initial construct
		//this.makeSelectObjects(this);
		//makeSearchButton start
// 		var $searchBtn = $(document.createElement( "button" ));
// 		$searchBtn.attr("type","button");
// 		$searchBtn.addClass("btn btn-info btn-sm");
// 		$searchBtn.text("Search");
// 		var instance = this;
// 		$searchBtn.click(function(){
// 			instance.tableSearch();
// 		});
// 		$("#"+this.container).append($searchBtn);
// 		$("#"+this.container).append(" ");
		//makeSearchButton end
		//makeUpdateButton start
// 		var $updateBtn = $(document.createElement( "button" ));
// 		$updateBtn.attr("type","button");
// 		$updateBtn.addClass("btn btn-info btn-sm");
// 		$updateBtn.text("Update");
// 		$("#"+this.container).append($updateBtn);
// 		$("#"+this.container).append(" ");
		//makeUpdateButton end
		//ChatShowButton start
		
// 		var $applyBtn = $(document.createElement( "button" ));
// 		$applyBtn.attr("type","button");
// 		$applyBtn.addClass("btn btn-info btn-sm inline");
// 		$applyBtn.text("Show");
// 		$applyBtn.click(function(){
// 			myInstance.drawchart();
// 		});
// 		$("#"+this.container).append($applyBtn);		
		
		var $applyBtnA = $(document.createElement( "a" ));
		$applyBtnA.addClass("btn_n2");
		var $applyBtn = $(document.createElement( "span" ));
		//$applyBtn.attr("type","button");
		$applyBtn.addClass("btn_n2_right txt_color_c");
		$applyBtn.text("Show");
		$applyBtn.click(function(){
			myInstance.drawchart();
		});
		$applyBtnA.append($applyBtn);
		$("#"+this.container).append($applyBtnA);		
		
		//ChatShowButton end
		//**Legend Button start **//
// 		var $legendLabel1 = $(document.createElement( "label" ));
// 		$legendLabel1.addClass("checkbox-inline");
// 		//$legendLabel1.text("legend show");
// 		$("#"+this.container).append($legendLabel1);
// 		var $legendOption1 = $(document.createElement( "input" ));
// 		$legendOption1.attr("type","checkbox");
// 		//$legendOption1.val("");
// 		$legendLabel1.append($legendOption1);
// 		$legendLabel1.append("legend show");
		
// 		var $legendLabel2 = $(document.createElement( "label" ));
// 		$legendLabel2.addClass("checkbox-inline");
// 		$legendLabel1.text("legend hide");
// 		$("#"+this.container).append($legendLabel2);
// 		var $legendOption2 = $(document.createElement( "input" ));
// 		$legendOption2.attr("type","checkbox");
// 		//$legendOption1.val("");
// 		$legendLabel2.append($legendOption2);
		//** Legend Button end **//
		//end construct
		$("#"+this.container).append("   ");
		$("#"+this.container).append('<label class="radio-inline"><input type="radio" name="optLegend" checked value="on">Legend Show</label><label class="radio-inline"><input type="radio" name="optLegend" value="off">Legend Hide</label>');
		$('input[type=radio][name=optLegend]').change(function() {
			myInstance.drawchart();
	    });
		
		this.tableSearch();
		
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
	
	function drawchart(pDataSrc){
		//$("#container").empty();
		//$("#container").html("");
		/* $.each(chartContainers,function(){
			this.remove();
		});
		chartContainers = []; */
		//document.getElementById("container").innerHTML = "";
		var theGrid = $("#"+ multiSearchObj.gridInfo.tableId);
		var chartContainerId = 'chart_' +  pDataSrc;
		
		if($("[id='"+chartContainerId+"']" ).length == 0){
			//생성
			var $chartContainer = $(document.createElement( "div" ));
			$chartContainer.attr("id",chartContainerId);
			$chartContainer.attr("data_src",pDataSrc);
			//css
			//$chartContainer.css("height","700px");
			$chartContainer.css("width","100%");
			$chartContainer.addClass( "chartContainer modern-p-form p-form-modern-orange");
			//$chartContainer.addClass( "modern-p-form p-form-modern-steelBlue");
			$("#container").append($chartContainer);
			
			//$chartContainer.addClass( "span4");
			// var $subject = $(document.createElement( "h3" ));
			// $subject.addClass( "p-title");
			// $subject.text(pDataSrc.split(".")[0]);
			// $chartContainer.append($subject);
			
			var $subjectDiv = $(document.createElement( "div" ));
			$subjectDiv.addClass( "p-title text-left");
			var $subject = $(document.createElement( "h3" ));
			$subject.addClass( "p-title-line");
			$subject.css( "margin-top","0px");
			$subject.css( "font-size","15px");
			//$subject.text(pDataSrc.split(".")[0]);
			$subject.text(pDataSrc);
			$subjectDiv.append($subject);
			$chartContainer.append($subjectDiv);
		}
		
		
		//01. 데이타필터링
		var filters = [];
		var selIds = theGrid.jqGrid('getGridParam','selarrrow')
		$.each(selIds,function(i,s){
			var row = theGrid.jqGrid('getRowData',s);
			filters.push({col:"FOLDER_NAME",val: row.FOLDER_NAME});
		});
		filters.push({col:'DATA_SRC',val:pDataSrc});
		
		//01.01. 각타입별로 filters 추가. categoryInfo 참조
	    var vCateInfos = dataFilter(categoryInfo,[{col:'category',val: pDataSrc}]);
	    var vCateInfo ={};
	    if(vCateInfos.length> 0 ){
	    	vCateInfo = vCateInfos[0];
	    	//계산된컬럼	    	
    		$.each(vCateInfo.calculateCols,function(j,c){
    			$.each(dataList,function(i,m){
    				if(m.DATA_SRC == pDataSrc ){
    					m[c.col] =  c.val.apply(m);
    				}
    			});
	    	});
	    	
	    	$.each(vCateInfo.filters,function(i,f){
	    		filters.push(f);
	    	});
	    	
	    }else{
	    	alert('category 정보가 없습니다.' + '('+ pDataSrc +')');
	    	return;
	    }
	    
	    var decimalPoint = 0;
	    if(vCateInfo.decimalPoint != undefined)
	    	decimalPoint = vCateInfo.decimalPoint;
		
		//sortObjects(filteredData, vCateInfo.categoryCols);
		
		//02. series
		//03. value 축
		//04. drawchart
		
		
		// multichart
		var filteredData = dataFilter(dataList,filters);
		var vCols = [{containerId:chartContainerId, filter:[]}];
		if(vCateInfo.multichart.enabled &&  vCateInfo.multichart.splitCol != undefined){
			vCols = [];
			var vColsG = groupbyCount(filteredData,[vCateInfo.multichart.splitCol]);
			//parent height
// 			var parentHeight = $chartContainer.height();
// 			if(vCateInfo.multichart.oneLineChatNum != undefined){
// 				var lines = Math.ceil(vColsG.length/vCateInfo.multichart.oneLineChatNum);
// 				parentHeight += (lines -1) * vCateInfo.multichart.oneLineHeight;
// 			}
// 			$chartContainer.css("height",  parentHeight + "px");
			
			sortObjects(vColsG,[vCateInfo.multichart.splitCol]);
			var $lineContainer = {};
			$.each(vColsG,function(i,col){
				if(i%2 == 0){
					$lineContainer =  $(document.createElement( "div" ));
					var lineId = chartContainerId + '_line' + Math.ceil(i/2);
					$lineContainer.attr("id",lineId);
					$lineContainer.css("width","100%");
					$lineContainer.addClass("chartContainerSub");
					$chartContainer.append($lineContainer);
				}
				var subId = chartContainerId + '_' + i;
				if($("[id='"+subId+"']" ).length == 0){
					var $subContainer = $(document.createElement( "span" ));
					$subContainer.attr("id",subId);
					$subContainer.attr("data_src",pDataSrc);
					//css
					//height
// 					var subHeight = 600;
// 					if(vCateInfo.multichart.oneLineHeight != undefined){
// 						subHeight = vCateInfo.multichart.oneLineHeight;
// 					}
					//$subContainer.css("height",subHeight + 'px');
					//width
					var subWidth = (1/vColsG.length)*100 ;
					if(vCateInfo.multichart.chartWidth != undefined){
						subWidth = vCateInfo.multichart.chartWidth;
					}
					$subContainer.css("width",subWidth + '%');
					$subContainer.addClass("chartContainerSub");
					
					//$chartContainer.append($subContainer);
					$lineContainer.append($subContainer);
				}
				
				vCols.push({
					containerId : subId,
					filter:[{col:vCateInfo.multichart.splitCol,val:col[vCateInfo.multichart.splitCol]}]
				});
				
			});
			
		}else{
			//단일차트인경우
			vCols = [];
			var subId = chartContainerId + '_' + '0';
			if($("[id='"+subId+"']" ).length == 0){
				var $subContainer = $(document.createElement( "span" ));
				$subContainer.attr("id",subId);
				$subContainer.attr("data_src",pDataSrc);
				//css
				//height
				var subHeight = 600;
				//$subContainer.css("height",subHeight + 'px');
				//width
				$subContainer.css("width", '100%');
				$subContainer.addClass("chartContainerSub");
				
				$chartContainer.append($subContainer);
				vCols.push({
					containerId : subId,
					filter:[]
				});
			}
		}
		
		$.each(vCols,function(i,col){
			
			var filteredDataSub = dataFilter(filteredData,col.filter);
			var series = getDrillDownDataSeries2(
					'',
					filteredDataSub ,
					vCateInfo.xOderbyCols , //groupby를 안하므로 length:0
					[], //filter
					[{col:vCateInfo.yCol , convert:'y',isnull:0}], //convert
					vCateInfo.categoryCols[vCateInfo.categoryCols.length-1] , 
					//vCateInfo.categoryCols[0] ,
					'CNT',
					vCateInfo.seriesCol,
					{isGroupby: false}
			);
			
			series.category = [];
			$.each(series.series,function(i,s){
				//sortObjects(s.data,[['y','desc']]);
			});
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
			
			/** Start addSeries **/
			var yAxis = [{
		        	min: 0,
		            title: {
		                text: series.series[0].data[0].FIELD == undefined? '': series.series[0].data[0].FIELD
		            }
		            //,tickInterval:5
		    }];
			
			if(vCateInfo.addSeries != undefined && vCateInfo.addSeries.length > 0){
				$.each(vCateInfo.addSeries,function(addSIndex,addSeries){
					//01. 새로운 series 생성
					var addS = {
						id: this.name,
						name: this.name,
						type: this.type,
						data: []
					};
					if(this.yAxis != undefined){
						yAxis.push(this.yAxis);
					}					
					var seriesResult = this.seriesFunction.apply(addS, series.series )
					//03. add series
					if(seriesResult)
						series.series.push(addS);
				});
			}
			
			/** End addSeries **/
			
			var legendVal = $("[name=optLegend]:checked").val();
			var isLegend = false;
			if(legendVal == "on")
				isLegend = true;
			if($("[id='"+ this.containerId +"']" ).highcharts() != undefined) $("[id='"+this.containerId+"']" ).highcharts().destroy();
			$("[id='"+this.containerId+"']" ).highcharts({
		        chart: {
		            type: 'column',
		            zoomType:'x',
		            height: 400
		        },
		        credits: {
	                enabled: false
	            },
		        title: {
		        	//text:pDataSrc.split(".")[0],
		        	//text:pDataSrc,
		        	text:'',
	            	useHTML: true
		        },
		        subtitle: {
		            text: ''
		        },	     
		        legend:{
		        	enabled: isLegend
		        },
		        xAxis:{
		        	categories: series.category,
		        	labels:{
		        		groupedOptions:[{
		        			rotation: 0
		        		},{
		        			rotation: 0
		        		}],
		        		rotation:0,
		        		//formatter: function() {
						//	
		        		//}
		        	} 
		        },
		        yAxis: yAxis,
		        
		        tooltip: {
		            valueDecimals: 0,
		          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
	                //headerFormat:'',
		            pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y:.'+decimalPoint+'f}</b> <br/>',
		            shared: true,
		            enabled: true
		        },
		        //legend: legend,
		        plotOptions: {
		            column: {
		            	grouping: true,
		            	borderWidth: 0,
		            	cursor: 'pointer' ,
		            	point:{	                	
		                	events:{
		                		click: function(e){
// 		                			e.point.select(true,false);
//	 	                			if(this.drillSeries){
//	 	                				setChart(this.drillSeries);
//	 	                			}else{
//	 	                				//var phase = this.category.parent.parent.name;
//	 		                			//var cause = this.category.name;
//	 		                			//var data = "";
//	 		                			//$("#phase").val(phase);
//	 		                			//$("#discoveredFrom").val(cause);
//	 		                			gotoDetail(this.PHASE,this.DISCOVERED_FROM_PURE);
//	 	                			}
		                			
		                			
		                		}
		                	}
		                },
		                //stacking: 'percent',
		                marker: {
		                    lineColor: '#666666',
		                    enabled: true
		                },
		                dataLabels: {
		                    enabled: true,
		                    //useHTML: true,
		                    //format:'{point.y:.0f} ({point.percentage:.0f}%)'
		                    format:'{point.y:.'+decimalPoint+'f}',
		                    //x: 10,
		                   /*  formatter:function(){
		                    	
		                    }, */
		                    color: 'black'
		                },
		                //enableMouseTracking: true,
		                events:{
		                	click: function(e){
		                		//gotoDetail(e.point.options.PJT_CODE,e.point.options.PJT_NAME);
	                		} 
		                }
		                	
		            }
		        },	        
		        series: series.series
		    },function(chart){
		    	
			 });//chart end
			 
			//*****  Start makeTable ******//
			//		01. subContainer
			//var gridId =  chartContainerId.split(".")[0].replace(/[\s]/gi,"") + 'Grid';
			var $subChart = $("[id='"+ this.containerId + "']" );
			var gridId =  this.containerId.replace(/[\s]/gi,"").replace(/[\.]/gi,"_") + 'Grid';
			var $subGrid = $(document.createElement( "div" ));
			$subGrid.attr("id",gridId);
			$subGrid.css("width","100%");
			$subGrid.addClass("chartContainerSub");
			//		01.01. container height + 
			var chartHeight = $subChart.height();
			var gridHeight = 400;
			//$subChart.height(chartHeight + gridHeight);
			//$subGrid.height(gridHeight);
			$subChart.append($subGrid);
			//		01.02.subDivs
			//			01.02.01. table
			var tableId =  gridId + 'Table';
			var $subTable = $(document.createElement( "table" ));
			$subTable.attr("id",tableId);
			$subGrid.append($subTable);
			//				01.02.02. pager
			var pagerId =  gridId + 'Pager';
			var $subPager = $(document.createElement( "div" ));
			$subPager.attr("id",pagerId);
			$subGrid.append($subPager);
			//		02. option
			var gridOpt = {
					datatype: 'local',
					styleUI : 'Bootstrap',
					//data: this.gridInfo.sourceData,
					//colModel: this.gridInfo.colModel,
					rowNum:100000,
					//rowNum:10,
					//rowList:[10,20,30],
					//pager: $subPager , //'#' + pagerId,
					sortable: true,
					viewrecords: true,
					rownumbers: true, // show row numbers
			        multiSort:true,
			    	//sortname : 'FIELD,SPEC,FIRMWARE1,QUEUE_DEPTH',
			        //multiselect: true,
			        //multiboxonly:true,
			        //sortname: 'orderdate asc, price',
			        //sortorder: 'asc',           
			        //caption: pDataSrc.split(".")[0]
			        caption: 'Data'
					, width: '100%'
			        , height:280
			        , hidegrid:true
			        , hiddengrid: true
					//, editurl:'clientArray'
					//, cellEdit: true
					, forceFit : true
					//, cellsubmit: 'clientArray'
					//,cellsubmit: '/dashboard/performanceJson.html'
					// , afterEditCell: function (id,name,val,iRow,iCol){
					
					// }
					// , afterSaveCell : function(rowid,name,val,iRow,iCol) {
					// 	if(name == 'IS_GOOD_DATA') {
					// 		theGrid.jqGrid('setRowData',rowid,{EDIT_MODE:'U'});
					// 	}
					// }
					,iconSet: "fontAwesome"
					,onInitGrid: function () {
				        var p = $(this).jqGrid("getGridParam");
				        // save names of columns in custom option of jqGrid
				        p.originalColumnOrder = $.map(p.colModel, function (cm) {
				            return cm.name;
				        });
				        //alert(JSON.stringify(p.originalColumnOrder));
				    }
			};
			//		03.01. option column
			//gridOpt.colNames = ['CONTROLLER','SLC_BUFFER','CAPACITY','FIELD','SPEC','FIRMWARE','QUEUE_DEPTH','MEASURE'];
			gridOpt.colNames = ['FIELD','SPEC','FIRMWARE','QD','MEASURE'];
			gridOpt.colModel =  [
				//{name: 'PRODUCT_NAME', index: 'PRODUCT_NAME', width: '120px' },  
				//{name: 'CONTROLLER', index: 'CONTROLLER', width: '120px' },    
				//{name: 'SLC_BUFFER', index: 'SLC_BUFFER', width: '120px' },
				//{name: 'CAPACITY', index: 'CAPACITY', width: '120px' },
				{name: 'FIELD', index: 'FIELD', width: '100px' },
				{name: 'SPEC', index: 'SPEC', width: '110px' },
				{name: 'FIRMWARE1', index: 'FIRMWARE1', width: '170px' },
				{name: 'QUEUE_DEPTH', index: 'QUEUE_DEPTH',sorttype: 'number', width: '80px' },
				{name: 'MEASURE', index: 'MEASURE', width: '100px', formatter: 'number', align: 'right' }
				
			];		
			//		03.02. option data
			//gridOpt.data = filteredData;
			//sortObjects(filteredDataSub, vCateInfo.xOderbyCols);
			var gridSort = [];
			if(vCateInfo.gridSorts != undefined){
				gridSort = vCateInfo.gridSorts;
			}else{
				gridSort = vCateInfo.xOderbyCols.slice(1,2);
				//gridSort.unshift(vCateInfo.xOderbyCols[0]);
				gridSort.push(vCateInfo.xOderbyCols[0]);
				gridSort.concat(vCateInfo.xOderbyCols.slice(2));
				sortObjects(filteredDataSub,gridSort);
//	 			sortObjects(filteredDataSub,vCateInfo.categoryCols);
			}
			
			gridOpt.data = filteredDataSub;
			//		04. make table
			"use strict";
			$subTable.jqGrid(gridOpt);
			//$subTable.jqGrid('setFrozenColumns');
			//$subTable.jqGrid('destroyFrozenColumns');
			//***** End  makeTable ******//
			 
		});	// loop end
				
		
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
	        /* height: 100%; */
	        width: 100%;
	        padding: 0;
	        margin: 0;
	        overflow-y: auto;
	        overflow-x: hidden;
	        font-size:11px;
	      }
		
		.dashboard-div{
			/* position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0; */
			width: 100%;
			/* height: 90%; */	
		}
		
		.chartContainer {
			width : auto;
			height: auto;
		    /* border: black; */
		   /*  border: 3px solid orange; */
		    border-width: 3px 3px 0px 3px;
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
		
	</style>
</head>
<body>
<form name="form" id="form" class="">
<input type="hidden" name="version" value="${param.version}"/>
<input type="hidden" name="legendFloat" id="legendFloat" value="false"/>
<div align="left" class="dashboard-div container">
	<div id = "selectContainer" style="/* text-align: right; */ /* display:inline-block;text-overflow:hidden;float:left; */">
	</div>
	<div id="jqgrid" style="width:100%;/* display:inline-block;float:left; */">
		<table id="jqgridTable"></table>
		<div id="jqgridPager"></div>
	</div>
</div>
<div  id="container" class="dashboard-div container"></div>
<div id="loader"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
