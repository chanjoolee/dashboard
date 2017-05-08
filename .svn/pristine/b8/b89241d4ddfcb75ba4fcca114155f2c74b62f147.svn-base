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
	<script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script>
	<script type="text/javascript">
	//2016.04.06 
	//01.ok 마지막 검색조건은 멀티로 한다.
	//		- 
	//02.ok 멀티선택 한 것들을 차트로 보여준다.
	//03. 멀티x축
	//04. x축 순서정하기.
	//05. scroll기능 적용하기
	
	
	//01. series데이타. project
	var dataList = [];
	var multiSearchObj = {}
	var categoryInfo =[
		      {
					category:'Latency.csv',
					calculateCols:[
						{
							col:'TYPE_REVISION',
							val: function(){
								return this.NAND_TYPE + '('+ this.REVISION +')';
								
							}
						}
					],
					filters:[
						{col:'FIELD',val:'Average Response Time'}
					],
					xOderbyCols:['TYPE_REVISION','NAND_TYPE','SPEC'],
					categoryCols:['NAND_TYPE','SPEC'],
					yCol:'MEASURE',
					seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
					multichart:{
						enabled:false,
						cols:[]
					}
			 },
			 {
					category:'SLC_Latency.csv',
					calculateCols:[
						{
							col:'TYPE_REVISION',
							val: function(){
								return this.NAND_TYPE + '('+ this.REVISION +')';
								
							}
						}
					],
					filters:[
						{col:'FIELD',val:'Average Response Time'}
					],
					xOderbyCols:['TYPE_REVISION','NAND_TYPE','SPEC'],
					categoryCols:['NAND_TYPE','SPEC'],
					yCol:'MEASURE',
					seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
					multichart:{
						enabled:false,
						cols:[]
					}
			 },
			 {
					category:'Max Throughput.csv',
					calculateCols:[
						{
							col:'TYPE_REVISION',
							val: function(){
								return this.NAND_TYPE + '('+ this.REVISION +')';
								
							}
						}
					],
					filters:[
						{col:'FIELD',val:'MBps (Decimal)'}
					],
					xOderbyCols:['TYPE_REVISION','SPEC'],
					categoryCols:['NAND_TYPE','SPEC'],
					yCol:'MEASURE',
					seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
					multichart:{
						enabled:false,
						cols:[]
					}
			 },
			 {
					category:'SLC_Max Throughput.csv',
					calculateCols:[
						{
							col:'TYPE_REVISION',
							val: function(){
								return this.NAND_TYPE + '('+ this.REVISION +')';
								
							}
						}
					],
					filters:[
						{col:'FIELD',val:'MBps (Decimal)'}
					],
					xOderbyCols:['TYPE_REVISION','SPEC'],
					categoryCols:['NAND_TYPE','SPEC'],
					yCol:'MEASURE',
					seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
					multichart:{
						enabled:false,
						cols:[]
					}
			 },
			 {
				 	//x축을 2개이상 사용하도록 설정필요.
					category:'QD 1 to 32.csv',
					calculateCols:[
						{
							col:'TYPE_REVISION',
							val: function(){
								return this.NAND_TYPE + '('+ this.REVISION +')';
								
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
					xOderbyCols:['TYPE_REVISION','SPEC','NAND_TYPE','QUEUE_DEPTH'],
					categoryCols:['SPEC','NAND_TYPE','QUEUE_DEPTH'],
					yCol:'MEASURE',
					seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
					multichart:{
						enabled:false,
						cols:[]
					}
			 },
			 {
				 	//x축을 2개이상 사용하도록 설정필요.
					category:'SLC_QD 1 to 32.csv',
					calculateCols:[
						{
							col:'TYPE_REVISION',
							val: function(){
								return this.NAND_TYPE + '('+ this.REVISION +')';
								
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
					xOderbyCols:['TYPE_REVISION','SPEC','NAND_TYPE','QUEUE_DEPTH'],
					categoryCols:['SPEC','NAND_TYPE','QUEUE_DEPTH'],
					yCol:'MEASURE',
					seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
					multichart:{
						enabled:false,
						cols:[]
					}
			 },
			 {
			 	//x축을 2개이상 사용하도록 설정필요.
				category:'Workload_Align.csv',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
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
				xOderbyCols:['TYPE_REVISION','WA_CATEGORY','NAND_TYPE','WA_SPEC'],
				categoryCols:['WA_CATEGORY','NAND_TYPE','WA_SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
			 	//x축을 2개이상 사용하도록 설정필요.
				category:'Workload_Unalign.csv',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
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
				xOderbyCols:['TYPE_REVISION','WA_CATEGORY','NAND_TYPE','WA_SPEC'],
				categoryCols:['WA_CATEGORY','NAND_TYPE','WA_SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
			 	//x축을 2개이상 사용하도록 설정필요. 
				category:'SLC_Workload_Align.csv',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
					{
						col:'WA_CATEGORY',
						val: function(){
							if( this.FIELD == 'MBps (Decimal)'){
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
				xOderbyCols:['TYPE_REVISION','WA_CATEGORY','NAND_TYPE','WA_SPEC'],
				categoryCols:['WA_CATEGORY','NAND_TYPE','WA_SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
			 	//x축을 2개이상 사용하도록 설정필요. 
				category:'SLC_Workload_Unalign.csv',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
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
				xOderbyCols:['TYPE_REVISION','WA_CATEGORY','NAND_TYPE','WA_SPEC'],
				categoryCols:['WA_CATEGORY','NAND_TYPE','WA_SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
				category:'Mixed_Seq_RW.csv',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
					{
						col:'MIXED_CATEGORY',
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
					{col:'MIXED_CATEGORY',val:  'Read'},
					{col:'MIXED_CATEGORY',val:  'Write'}				
				],
				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
				xOderbyCols:['MIXED_CATEGORY','TYPE_REVISION','MIXED_SPEC'],
				categoryCols:['TYPE_REVISION','MIXED_SPEC'],
				yCol:'MEASURE',
				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
				seriesCol:{cd:'MIXED_CATEGORY',name:'MIXED_CATEGORY'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
				category:'Mixed_Ran_RW.csv',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
					{
						col:'MIXED_CATEGORY',
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
					{col:'MIXED_CATEGORY',val:  'Read'},
					{col:'MIXED_CATEGORY',val:  'Write'}				
				],
				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
				xOderbyCols:['MIXED_CATEGORY','TYPE_REVISION','MIXED_SPEC'],
				categoryCols:['TYPE_REVISION','MIXED_SPEC'],
				yCol:'MEASURE',
				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
				seriesCol:{cd:'MIXED_CATEGORY',name:'MIXED_CATEGORY'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
				category:'SLC_Mixed_Seq_RW.csv',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
					{
						col:'MIXED_CATEGORY',
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
					{col:'MIXED_CATEGORY',val:  'Read'},
					{col:'MIXED_CATEGORY',val:  'Write'}				
				],
				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
				xOderbyCols:['MIXED_CATEGORY','TYPE_REVISION','MIXED_SPEC'],
				categoryCols:['TYPE_REVISION','MIXED_SPEC'],
				yCol:'MEASURE',
				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
				seriesCol:{cd:'MIXED_CATEGORY',name:'MIXED_CATEGORY'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
				category:'SLC_Mixed_Ran_RW.csv',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
					{
						col:'MIXED_CATEGORY',
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
					{col:'MIXED_CATEGORY',val:  'Read'},
					{col:'MIXED_CATEGORY',val:  'Write'}				
				],
				//categoryCols:['MIXED_SPEC','MIXED_CATEGORY'],
				xOderbyCols:['MIXED_CATEGORY','TYPE_REVISION','MIXED_SPEC'],
				categoryCols:['TYPE_REVISION','MIXED_SPEC'],
				yCol:'MEASURE',
				//seriesCol:{cd:'MIXED_DUMMY',name:'MIXED_DUMMY'},
				seriesCol:{cd:'MIXED_CATEGORY',name:'MIXED_CATEGORY'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
				category:'CDM301.xlsx',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
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
						col:'CDM_DUMMY',
						val: function(){
							return 'measure';
						}
					}
				],
				filters:[
					
				],
				xOderbyCols:['TYPE_REVISION','CDM_SPEC'],
				categoryCols:['NAND_TYPE','CDM_SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 },
		 {
				category:'CDM503.xlsx',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
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
						col:'CDM_DUMMY',
						val: function(){
							return 'measure';
						}
					}
				],
				filters:[
					
				],
				xOderbyCols:['TYPE_REVISION','CDM_SPEC'],
				categoryCols:['NAND_TYPE','CDM_SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 },
		 {
				category:'PCMARK_VANTAGE.xlsx',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
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
				xOderbyCols:['TYPE_REVISION','SPEC'],
				categoryCols:['NAND_TYPE','SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 },
		 {
				category:'PCMARK7.txt',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
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
				xOderbyCols:['TYPE_REVISION','SPEC'],
				categoryCols:['NAND_TYPE','SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 },
		 {
				category:'PCMARK8.xml',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
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
				xOderbyCols:['TYPE_REVISION','SPEC'],
				categoryCols:['NAND_TYPE','SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 },
		 {
				category:'AS-SSD1.6.xml',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
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
				xOderbyCols:['TYPE_REVISION','AS_SSD_SPEC'],
				categoryCols:['NAND_TYPE','AS_SSD_SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
				category:'AS-SSD1.8.xml',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
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
				xOderbyCols:['TYPE_REVISION','AS_SSD_SPEC'],
				categoryCols:['NAND_TYPE','AS_SSD_SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 	},
		 	{
				category:'SYSMARK2014.fdr',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
					{
						col:'SYSMARK_DUMMY',
						val: function(){
							return 'measure';
						}
					}
				],
				filters:[
				],
				xOderbyCols:['TYPE_REVISION','SPEC'],
				categoryCols:['NAND_TYPE','SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 },
		 {
				category:'POR.txt',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},
					{
						col:'POR_DUMMY',
						val: function(){
							return 'measure';
						}
					}
				],
				filters:[
				],
				xOderbyCols:['TYPE_REVISION','SPEC'],
				categoryCols:['NAND_TYPE','SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 },
		 {
				category:'SPOR.txt',
				calculateCols:[
					{
						col:'TYPE_REVISION',
						val: function(){
							return this.NAND_TYPE + '('+ this.REVISION +')';
							
						}
					},  
					{
						col:'POR_DUMMY',
						val: function(){
							return 'measure';
						}
					}
				],
				filters:[
				],
				xOderbyCols:['TYPE_REVISION','SPEC'],
				categoryCols:['NAND_TYPE','SPEC'],
				yCol:'MEASURE',
				seriesCol:{cd:'TYPE_REVISION',name:'TYPE_REVISION'},
				multichart:{
					enabled:false,
					cols:[]
				}
		 }
	];
	
	$(function () {
		Highcharts.setOptions({
	        colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4']
	    });
		getDataByJson();
	});
	
	function getDataByJson(){
		$.ajax({
			url : "/dashboard/performanceJson.html",
			data: $("#form").serialize(),
			success : function(responseData){
				dataList = responseData.dataList;
				multiSearchObj = new multiSearch('selectContainer',dataList,['TOOL','PRODUCT','NAND_TYPE','TECH','MEASURE_DT',{name:'DATA_SRC',isMultiple:true}]);
				
			}
		});
	}
	
	
	/**
	* jsonList를 자동으로 multisearch 만듬.
	* @param container :  영역
	* @param jsonList: multsearch를 할 데이타소스
	* @param conTree: multisearch를 할 columns
	*/
	function multiSearch(container,jsonList,colTree){
		var myInstance = this;
		this.container = container;
		this.jsonList = jsonList;
		this.colTree = [];
		for(i in colTree){
			var col = colTree[i];
			if(typeof col == 'object'){
				if(col.isMultiple == undefined) 
					col.isMultiple = false;
				this.colTree.push(col);
			}
			else{
				var colconf = {
					name:col,
					isMultiple: false
				};
				this.colTree.push(colconf)
			}
				
		};
		this.prefix = 'search';
		this.searchList = [];
		
		this.makeSelectObjects = function(instance){
			$.each(instance.colTree,function(i,col){
				var colname='';
				if(typeof col == 'object') 
					colname = col.name;
				else 
					colname = col;
				var $select = $(document.createElement( "select" ));
				$select.attr("id",instance.prefix+colname);
				$select.attr("name",instance.prefix+colname);
				$select.attr("col",colname);
				//$select.css("width","400px");
				//parent 지정
				if(i>0){
					$parentSelect = instance.searchList[i-1];
					
					$parentSelect.change(function(){
						if($(this).attr('prev') == $(this).val()[0])
							return;
						//01. 옵션삭제
						$select.find('option').remove();
						
						
						//02. 옵션추가
						//02.01. 상위데이타dom찾기
						var parents = [];
						var childrens = [];
						$.each(instance.searchList,function(i1,s){
							if(i > i1)
								parents.push(s);
							else if(i < i1)
								childrens.push(s);
						});
						//02.02. 상위데이타검색
						var filters = [];
						$.each(parents,function(pi,p){
							filters.push({col:p.attr("col"),val:p.val()[0]});
						});
						//02.03.옵션추가
						var list = dataFilter(instance.groupbyList,filters);
						var list = groupbyCount(list,[$select.attr("col")]);
						$.each(list,function(i1,m){
							$select.append($('<option>', {
							    value: m[$select.attr("col")],
							    text: m[$select.attr("col")]
							}));
							//$("select").multiselect('refresh');
							$select.multiselect('refresh');
						});
						
						//03. 하위의 combo 비워주기
						$.each(childrens,function(i1,child){
							child.find('option').remove();
							child.multiselect('refresh');
						});
						
						
					});
					
					$select.attr("parentId",$parentSelect.attr("id"));
					
					//마지막이면 chart를 그린다.
					if(i == (instance.colTree.length -1)){
						$select.change(function(){
// 							if($(this).val() == null &&  $(this).attr('prev') == $(this).val().join(","))
// 								return;
							//loop.
							//	- delete
							$.each($("[id^='chart_']"),function(){
								if($.inArray($(this).attr("data_src"),$select.val()) < 0)
									$(this).remove();
							});
							// - create
							$.each($(this).find('option:selected'),function(){
								var chartid = $(this).val();
								drawchart(chartid);
							});
							
						});
						
					}
					
				}else{
					//첫번째항목에 options 추가함.
					var list = groupbyCount(instance.groupbyList,[$select.attr("col")]);
					$.each(list,function(i1,m){
						$select.append($('<option>', {
						    value: m[$select.attr("col")],
						    text: m[$select.attr("col")]
						}));
					});
				}
				
				//if(typeof col == 'object' && col.isMultiple)
				$select.attr("multiple","multiple");
				$select.css("width","100px");
				$select.attr("arrindex",i);
				
				
				//관리리스트에 추가
				instance.searchList.push($select);
				//dom에 추가
				$("#"+instance.container).append($select);
			});
			
			
		};
		
		
		this.groupbyList = groupbyCount(this.jsonList ,jmespath.search(this.colTree,'[*].name'));
		
		//initial construct
		this.makeSelectObjects(this);
		$.each(this.searchList,function(){
			var colConfigs = dataFilter(myInstance.colTree,[{col:'name',val:this.attr("col")}]);
			var colConfig = {};
			if(colConfigs.length > 0)
				colConfig = colConfigs[0];
			var opt = {
				multiple: colConfig.isMultiple,
				//width:200,
				minWidth: 150,
				//height:400,
				//selectedText: this.attr("col") + ' # ',
				noneSelectedText: 'select ' + this.attr("col"),
				selectedText: function(numChecked, numTotal, checkedItems){
				      //return numChecked + ' of ' + numTotal + ' checked';
				      return this.element.attr("col") + ": " + $(checkedItems).val();
				},
				open: function(){
				      //$callback.text("Select opened!");
				 	$(this).attr("prev",  $(this).val() );
				 }
			};
			if(!colConfig.isMultiple)
				opt.selectedList = 1;
			this.multiselect(opt).multiselectfilter();		
		});
		
		//end construct
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
		var chartContainerId = 'chart_' +  pDataSrc;
		
		if($("[id='"+chartContainerId+"']" ).length > 0)
			return;
		else{
			//생성
			$chartContainer = $(document.createElement( "div" ));
			$chartContainer.attr("id",chartContainerId);
			$chartContainer.attr("data_src",pDataSrc);
			//css
			$chartContainer.css("height","600px");
			$chartContainer.css("width","100%");
			$("#container").append($chartContainer);
			
		}
		//01. 데이타필터링
		var filters = [];
		$.each(multiSearchObj.searchList,function(i,s){
			if(s.attr("id") != multiSearchObj.prefix+'DATA_SRC'){
				$.each(s.val(),function(j,val){
					filters.push({col:s.attr("col"),val:val});
				});
				
			}
				
		});
		filters.push({col:'DATA_SRC',val:pDataSrc});
		
		//01.01. 각타입별로 filters 추가. categoryInfo 참조
	    var vCateInfos = dataFilter(categoryInfo,[{col:'category',val: pDataSrc}]);
	    var vCateInfo ={};
	    if(vCateInfos.length> 0 ){
	    	vCateInfo = vCateInfos[0];
	    	//계산된컬럼	    	
    		$.each(vCateInfo.calculateCols,function(j,c){
    			$.each(multiSearchObj.jsonList,function(i,m){
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
	    }
	    
		var filteredData = dataFilter(multiSearchObj.jsonList,filters);
		//sortObjects(filteredData, vCateInfo.categoryCols);
		
		//02. series
		//03. value 축
		//04. drawchart
		
		var series = getDrillDownDataSeries2(
				'',
				filteredData ,
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
		
		
		if($("[id='"+chartContainerId+"']" ).highcharts() != undefined) $("[id='"+chartContainerId+"']" ).highcharts().destroy();
		
		$("[id='"+chartContainerId+"']" ).highcharts({
	        chart: {
	            type: 'column',
	            zoomType:'x'
	        },
	        credits: {
                enabled: false
            },
	        title: {
	        	//text:pDataSrc.split(".")[0],
	        	text:pDataSrc,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },	     
	        legend:{
	        	enabled:false
	        },
	        xAxis:{
	        	categories: series.category,
	        	labels:{
	        		groupedOptions:[{
	        			rotation: 0
	        		},{
	        			rotation: 0
	        		}],
	        		//rotation:-90,
	        		//formatter: function() {
					//	
	        		//}
	        	} 
	        },
	        yAxis: {
	        	min: 0,
	            title: {
	                text: ''
	            }
	            //,tickInterval:5
	        },
	        
	        tooltip: {
	            valueDecimals: 0,
	          	headerFormat: '<span style="font-size: 12px;font-weight: bold;">{point.x}</span><br/>',
                //headerFormat:'',
	            pointFormat: '<span style="color:"#303030">{series.name}</span>: <b>{point.y}</b> <br/>',
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
	                			e.point.select(true,false);
// 	                			if(this.drillSeries){
// 	                				setChart(this.drillSeries);
// 	                			}else{
// 	                				//var phase = this.category.parent.parent.name;
// 		                			//var cause = this.category.name;
// 		                			//var data = "";
// 		                			//$("#phase").val(phase);
// 		                			//$("#discoveredFrom").val(cause);
// 		                			gotoDetail(this.PHASE,this.DISCOVERED_FROM_PURE);
// 	                			}
	                			
	                			
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
	                    format:'{point.y:.0f}',
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
	    	
		 });
		
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
	        font-size:12px;
	      }
		
		.dashboard-div{
			position: relative;
			min-height: 1px;
			padding-left: 0;
			padding-right: 0;
			width: 100%;
			/* height: 90%; */	
		}
		
		.div-priority{
			/* width: 100%; */
			margin-left: 0 ;
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
	<div id = "selectContainer" style="display:inline-block;text-overflow:hidden;float:left;">
	</div>
</div>
<div  id="container" class="dashboard-div"></div>
</form>
</body>
<script src="js/highcharts/themes/dashboard-simple.js"></script>
</html>
