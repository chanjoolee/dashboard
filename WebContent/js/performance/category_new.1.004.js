var category_new = [
	{
		category:'CDM_PCI',
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
				col:'ORDER1',
				val: function(){
					if(this.FIELD.match(/[\d]+/gi) != null ){
						var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\([\w\=\s,]+\))?/i);
						//["Read 4KB (QD=1)", "Read", "4KB", "(QD=1)"]
						var vspec = '';
						if(this.SPEC.match(/Sequential/gi) != null)
							vspec = 1;
						else
							vspec = 2;
						
						return vspec;
						
					}else{
						return 10;
					}
					
				}
			},
			{
				col:'ORDER2',
				val: function(){
					if(this.FIELD.match(/[\d]+/gi) != null ){
						var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\([\w\=\s,]+\))?/i);
						//["Read 4KB (QD=1)", "Read", "4KB", "(QD=1)"]
						var vnum = '';
						var vnum1 = 0;
						if(arr[2] != undefined){
							vnum = arr[2];
							vnum1 = parseInt(vnum);
						}
						
						if ( vnum == '')
							vnum1 = 1000;
						return vnum1 ;
						
					}else{
						var vspec = '';
						if(this.SPEC.match(/Sequential/gi) != null)
							vspec = 1;
						else
							vspec = 2;
						
						return vspec;
					}
					
				}
			},
			
			{
				col:'ORDER3',
				val: function(){
					if(this.FIELD.match(/[\d]+/gi) != null ){
						var arr = this.FIELD.match(/([\w]+)\s+([\d]+[\w]+)?\s*(\([\w\=\s,]+\))?/i);
						//["Read 4KB (QD=1)", "Read", "4KB", "(QD=1)"]
						var vqd = '';
						if(arr[3] != undefined)
							vqd = arr[3];
						
						return vqd;
						
					}else{
						return 10;
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
		xOderbyCols:['FIRMWARE1','ORDER1','ORDER2','ORDER3','CDM_SPEC'],
		categoryCols:["SPEC1","CDM_SPEC"],
		yCol:'MEASURE',
		decimalPoint:2,
		yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'SPEC1',
			chartWidth: 100 , // percent �??�시
			oneLineChatNum: 1,
			oneLineHeight: 600
		},
		gridSeriesColWidth: '100px',
 		gridColWidth: '70px',
 		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 210
 	},
	// QD_PCI
	{
	 	//x축을 2개이???�용?�도�??�정?�요.
		category:'QD_PCI',
		category_name:'QD_PCIe',
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
		decimalPoint:2,
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'SPEC',
			chartWidth: 50 , // percent �??�시
			oneLineChatNum: 2,
			oneLineHeight: 600,
			orderBy: function(){
				var m = this.SPEC.match(/^([0-9]+)([\w]+)/);
				if(m != null ){
					if (m[1] == "4")
						return 100;
					else if (m[1] == "128")
						return 80;
					else
						return 70;
				}else{
					return 1000;
				}
			}
		},
		gridColWidth: '75px',
		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 10
	},
	// QD_PCI_8GB
	{
	 	//x축을 2개이???�용?�도�??�정?�요.
		category:'QD_PCI8GB',
		category_name:'QD_PCIe_TLC',
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
		decimalPoint:2,
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'SPEC',
			chartWidth: 50 , // percent �??�시
			oneLineChatNum: 2,
			oneLineHeight: 600,
			orderBy: function(){
				var m = this.SPEC.match(/^([0-9]+)([\w]+)/);
				if(m != null ){
					if (m[1] == "4")
						return 100;
					else if (m[1] == "128")
						return 80;
					else
						return 70;
				}else{
					return 1000;
				}
			}
		},
		gridColWidth: '75px',
		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 10.5
	},
	//Latency_PCI
	{
		category:'Latency_PCI',
		category_name:'Latency_PCIe',
		calculateCols:[
		{
			col:'ORDER0',
			val: function(){
				if(this.SPEC.match(/^[\d]+/gi) != null  ){
						return parseInt(this.SPEC.match(/^[\d]+/gi)[0]);
				}
				
			}
		},
		{
			col:'ORDER1',
			val: function(){
				if(this.SPEC.match(/Seq Read/gi) != null  ){
						return 1;
					}else if(this.SPEC.match(/Seq Write/gi) != null ){
						return 2;
					}else if(this.SPEC.match(/Ran Read/gi) != null ){
						return 3;
					}else if(this.SPEC.match(/Ran Write/gi) != null ){
						return 4;
					}else{
						return 100;
					}
				
			}
		},
		{
			col:'MEASURE1',
			val: function(){
				var v_measure = this.MEASURE;
				var v_measure1 = null;
				if ( v_measure == 0 )
					v_measure1 = 0;
				else
					v_measure1 = 1/v_measure * 1000000 ;
				return v_measure1;									
			}
		},
		{
			col:'is_idle',
			val: function(){
				if (this.SPEC.match(/Idle/gi) != null)
					return 'Y';
				else
					return 'N';
			}
		}
		],
		filters:[
			{col:'FIELD',val:'IOps'},
			{col:'is_idle',val:'N'}
		],
		xOderbyCols:['FIRMWARE1','ORDER0','ORDER1','SPEC'],
		categoryCols:['SPEC'],
		yCol:'MEASURE1',
		yAxisTitle:'us',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:false,
			cols:[]
		},
		decimalPoint:2
		, gridSeriesColWidth: ''
		, gridColWidth: '115px'
		, girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' }
		, orderby: 9
 	},
 	{
		category:'Latency_PCI8GB',
		category_name:'Latency_PCIe_TLC',
		calculateCols:[
		{
			col:'ORDER0',
			val: function(){
				if(this.SPEC.match(/^[\d]+/gi) != null  ){
						return parseInt(this.SPEC.match(/^[\d]+/gi)[0]);
				}
				
			}
		},
		{
			col:'ORDER1',
			val: function(){
				if(this.SPEC.match(/Seq Read/gi) != null  ){
						return 1;
					}else if(this.SPEC.match(/Seq Write/gi) != null ){
						return 2;
					}else if(this.SPEC.match(/Ran Read/gi) != null ){
						return 3;
					}else if(this.SPEC.match(/Ran Write/gi) != null ){
						return 4;
					}else{
						return 100;
					}
				
			}
		},
		{
			col:'MEASURE1',
			val: function(){
				var v_measure = this.MEASURE;
				var v_measure1 = null;
				if ( v_measure == 0 )
					v_measure1 = 0;
				else
					v_measure1 = 1/v_measure * 1000000 ;
				return v_measure1;														
			}
		}
		],
		filters:[
			{col:'FIELD',val:'IOps'}
		],
		xOderbyCols:['FIRMWARE1','ORDER0','ORDER1','SPEC'],
		categoryCols:['SPEC'],
		yCol:'MEASURE1',
		yAxisTitle:'us',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:false,
			cols:[]
		},
		decimalPoint:2
		, gridSeriesColWidth: ''
		, gridColWidth: '115px'
		, girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' }
		, orderby: 9
 	},
 	//PCM_7.xml
 	{
		category:'PCM_7.xml',
		calculateCols:[
			{
				col:'IS_DISPLAY',
				val: function(){
					if(this.SPEC.match(/^secondary_storage/gi) != null  ){
							
						var myarr = this.SPEC.match(/([a-z0-9]+)/gi);
						var laststr = myarr[myarr.length-1];
						var laststr1 = myarr[myarr.length-2];
						if(laststr == "bps" && laststr1 == "3" )
							return 'Y';
						else if(laststr != "bps")
							return 'Y';
						else return 'N';
							
					}else{
						return 'N';
					}
					
				}
			},
			{
				col:'IS_SCORE',
				val: function(){
					if(this.SPEC.match(/^secondary_storage_score$/gi) != null  ){
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
			},
			{
				col:'SPEC2',
				val: function(){
					if(this.SPEC.match(/^secondary_storage/gi) != null ){
						var myarr = this.SPEC.match(/([a-z0-9]+)/gi);
						var laststr = myarr[myarr.length-1];
						if(laststr == "bps")
							return myarr.slice(2,-2).join(" ");
						else
							return myarr.slice(2).join(" ");
					}
					
				}
			},
			{
				col:'IS_DISPLAY1',
				val: function(){
					if(this.SPEC2 != undefined && this.SPEC2.match(/^score residual/gi) != null  ){
							
						return 'N';
							
					}else{
						return 'Y';
					}
					
				}
			},
			{
				col:'MEASURE1',
				val: function(){
					if(this.IS_SCORE == 'Score')
						return this.MEASURE;
					else 
						return this.MEASURE / 1000000;
					
					
				}
			}
		],
		filters:[
			{col:'IS_DISPLAY', val:'Y'},
			{col:'IS_DISPLAY1', val:'Y'}
		],
		xOderbyCols:['FIRMWARE1','SPEC2'],
		categoryCols:['SPEC2'],
		yCol:'MEASURE1',
		yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		decimalPoint:1,
		multichart:{
			enabled:true,
			splitCol:'IS_SCORE',
			yAxisTitle:{NotScore:'MB/s',Score:'Score'},
			chartWidth: 100 , // percent 
			oneLineChatNum: 1,
			oneLineHeight: 600,
			gridColformat: {
				NotScore:{ decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 1, defaultValue: '0.0' },
				Score:{ decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 2, defaultValue: '0.00' }
			}
		},
		gridSeriesColWidth: '100px',
 		gridColWidth: '80px',
 		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 260
 	},
 	{
		category:'PCM_8.xml',
		calculateCols:[
			{
				col:'IS_DISPLAY',
				val: function(){
					if(this.SPEC.match(/^storage[\w]+bandwidth$/gi) != null  ){
						return 'Y';
					}else if(this.SPEC.match(/^storage[\w]+score$/gi) != null  ){
						return 'Y';
					}else if(this.SPEC.match(/^storage_([\w]+)_compound_s$/gi) != null  ){
						return 'Y';
					}else
						return 'N';
					
				}
			},
			{
				col:'CHART_TYPE',
				val: function(){
					if(this.SPEC.match(/^storage[\w]+score$/gi) != null  ){
						return 'Score';
					}else if(this.SPEC.match(/^storage[\w]+bandwidth$/gi) != null  ){
						return 'Bandwidth';
					}else if(this.IS_DISPLAY=='Y') {
						return 'Items';
					}
				}
			}, 
			{
				col:'PCMARK_DUMMY',
				val: function(){
					return 'measure';
				}
			},
			{
				col:'SPEC2',
				val: function(){
					if(this.IS_DISPLAY=='Y' && this.CHART_TYPE == 'Items' ){
						var spec = this.SPEC.match(/^storage_([\w]+)_compound_s$/i)[1];
						var myarr = spec.split("_");						
						return myarr.slice(0,-1).join(" ");
					}else if(this.IS_DISPLAY=='Y' && this.CHART_TYPE == 'Score' ){
						return 'Score';
					}else if(this.IS_DISPLAY=='Y' && this.CHART_TYPE == 'Bandwidth' ){
						return 'Bandwidth';
					}
					else{
						return this.SPEC;
					}
					
				}
			},
			{
				col:'MEASURE1',
				val: function(){
					if(this.CHART_TYPE == 'Score')
						return this.MEASURE;
					else if (this.CHART_TYPE == 'Items')
						return this.MEASURE;
					else if (this.CHART_TYPE == 'Bandwidth')
						return this.MEASURE / 1000000;
					
					
				}
			}
		],
		filters:[
			{col:'IS_DISPLAY', val:'Y'}
		],
		xOderbyCols:['FIRMWARE1','SPEC2'],
		categoryCols:['SPEC2'],
		yCol:'MEASURE1',
		yAxisTitle :' sec',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'CHART_TYPE',
			yAxisTitle:{Score:'Score'},
			chartWidth: 100 , // percent 
			customStyle: [
				{
					name: '(Score)|(Bandwidth)', // �ø������ �պκа� ��ġ
					chartWidth: 50,
					oneLineChatNum: 2
					
				},
//				{
//					name: 'Bandwidth',
//					chartWidth: 50,
//					oneLineChatNum: 2
//				},
				{
					name: 'Items',
					chartWidth: 100,
					oneLineChatNum: 1
				}
			],
			oneLineChatNum: 1,
			oneLineHeight: 600,
			orderBy : function(){
				if(this.CHART_TYPE == 'Items')
					return 30;
				else if (this.CHART_TYPE == 'Score')
					return 10;
				else if (this.CHART_TYPE == 'Bandwidth')
					return 20;
				
			},
			gridColformat: {
				Bandwidth:{ decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
				Score:{ decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' }
			}
		},
		gridSeriesColWidth: '200px',
 		gridColWidth: '100px',
 		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 2, defaultValue: '0.00' },
		orderby: 260.1
 	},
 	//PCMV_PCI
 	{
		category:'PCMV_PCI',
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
				col:'Category',
				val: function(){
					return this.SPEC1 + " " + this.IS_SCORE;
					
				}
			},                    
			{
				col:'PCMARK_DUMMY',
				val: function(){
					return 'measure';
				}
			}
		],
		addRows: function(){
			// this : dataList
			var alls = this;
			var filters = [
				{
					col:'IS_SCORE', 
					val:'Score'
				}
			];
			
			var list = dataFilter(alls,filters);
			$.each(list,function(i,d){
				var d1 = $.extend(true,{},d);
				d1.Category = 'Trend';
				d1.SPEC = d.SPEC1;
				if(d.SPEC1 == 'NONE')
					//d1.SPEC = '0_' + d1.SPEC;
					//d1.SPEC = '0';
					d1.SPEC = '0 clean';
				else
					d1.SPEC = d.SPEC1 + 'GB dirty'
				d1.IS_SCORE = 'Trend';
				alls.push(d1);
				
			});			 
			
		},
		
		filters:[
		],
		xOderbyCols:['FIRMWARE1','SPEC','IS_SCORE'],
		categoryCols:['Category','SPEC'], 
		yCol:'MEASURE',
		yAxisTitle :'MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'Category',
			yAxisTitle:{Trend:''},
			chartWidth: 50 , // percent �� ǥ��
			oneLineChatNum: 2,
			oneLineHeight: 600,
			orderBy : function(){	
				var s = this.Category.split(" ")[0];
				if(s == 'Trend')
					return 5;
				else if(s == 'NONE')
					return 10 ;
				else 
					return 20;
				
			},
			customStyle: [
				{
					name: 'Trend', // �ø������ �պκа� ��ġ
					chartWidth: 100,
					oneLineChatNum: 1
					
				},
				{
					name: '[\d]+\s', // �ø������ �պκа� ��ġ
					chartWidth: 50,
					oneLineChatNum: 2
					
				},
				{
					name: 'NONE', // �ø������ �պκа� ��ġ
					chartWidth: 50,
					oneLineChatNum: 2
					
				}
			]
			//,chartType: {
			//	Trend: 'spline'
			//}
		},
		gridSeriesColWidth: '100px',
		gridColWidth: '65px',
		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 250.1
		
		
 	},
 	//WORKER_PCI
 	{
		category:'WORKER_PCI',
		calculateCols:[
			{
				col:'IS_IDLE',
				val: function(){
					if(this.SPEC.match(/^Idle/gi) != null  ){
						return "Y";
					}else{
						return "N";
					}
					
				}
			},
			{
				col:'SPEC2',
				val: function(){
					if(this.SPEC.match(/^Idle/gi) != null  ){
						return this.SPEC;
					}else{
						var myarr = this.SPEC.match(/([a-z0-9]+)/gi);
						var myarr1 = [myarr[0],myarr[1],myarr[3]];
						return "QD" + this.QUEUE_DEPTH + " " + myarr1.join(" ");
					}
					
				}
			},
			{
				col:'IS_DISPLAY',
				val: function(){
					if(this.IS_IDLE == 'N'  ){
						var myarr = this.SPEC.match(/([a-z0-9]+)/gi);
						var myarr1 = [myarr[0],myarr[1],myarr[3]];
						if(myarr1[0].match(/^128kb/gi) != null )
							return 'N'; 
						else 
							return 'Y';
					}else{
						return 'N';
						
					}
					
				}
			},
			{
				col:'WORKER',
				val: function(){
					return this.SPEC1 + " worker";
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
			{col:"IS_DISPLAY", val:"Y"},
			{col:"IS_IDLE", val:"N"},
			{col:"FIELD", val:'IOps'}
		],
		xOderbyCols:['FIRMWARE1','SPEC2','WORKER'],
		categoryCols:['SPEC2','WORKER'],
		yCol:'MEASURE',
		decimalPoint:2,
		//yAxisTitle :" MB/s",
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:"SPEC2",
			//yAxisTitle:{"03. BANDWIDTH":'MB/s',"02. SCORE":"score","01. ITEMS":'sec'},
			chartWidth: 100 , // percent 
			oneLineChatNum: 1,
			oneLineHeight: 600
		},
		gridSeriesColWidth: '100px',
 		gridColWidth: '80px',
 		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 300
 	},
 	{
		category:'WORKER_PCI8GB',
		calculateCols:[
			{
				col:'IS_IDLE',
				val: function(){
					if(this.SPEC.match(/^Idle/gi) != null  ){
						return "Y";
					}else{
						return "N";
					}
					
				}
			},
			{
				col:'SPEC2',
				val: function(){
					if(this.SPEC.match(/^Idle/gi) != null  ){
						return this.SPEC;
					}else{
						var myarr = this.SPEC.match(/([a-z0-9]+)/gi);
						var myarr1 = [myarr[0],myarr[1],myarr[3]];
						return "QD" + this.QUEUE_DEPTH + " " + myarr1.join(" ");
					}
					
				}
			},
			{
				col:'WORKER',
				val: function(){
					return this.SPEC1 + " worker";
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
			{col:"IS_IDLE", val:"N"},
			{col:"FIELD", val:'IOps'}
		],
		xOderbyCols:['FIRMWARE1','SPEC2','WORKER'],
		categoryCols:['SPEC2','WORKER'],
		yCol:'MEASURE',
		decimalPoint:2,
		//yAxisTitle :" MB/s",
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:"SPEC2",
			//yAxisTitle:{"03. BANDWIDTH":'MB/s',"02. SCORE":"score","01. ITEMS":'sec'},
			chartWidth: 100 , // percent 
			oneLineChatNum: 1,
			oneLineHeight: 600
		},
		gridSeriesColWidth: '100px',
 		gridColWidth: '80px',
 		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 300.5
 	}
 	
 	
 
];