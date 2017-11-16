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
						
						return vnum + ' ' + vqd + vspec + arr[1].substr(0,1);
						
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
		categoryCols:["SPEC1","CDM_SPEC"],
		yCol:'MEASURE',
		decimalPoint:2,
		yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'SPEC1',
			chartWidth: 100 , // percent Î°??úÏãú
			oneLineChatNum: 1,
			oneLineHeight: 600
		},
		gridSeriesColWidth: '100px',
 		gridColWidth: '70px',
		orderby: 210
 },
	// QD_PCI
	{
	 	//xÏ∂ïÏùÑ 2Í∞úÏù¥???¨Ïö©?òÎèÑÎ°??§Ï†ï?ÑÏöî.
		category:'QD_PCI',
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
			chartWidth: 50 , // percent Î°??úÏãú
			oneLineChatNum: 2,
			oneLineHeight: 600
		},
		gridColWidth: '75px',
		orderby: 10
	},
	// QD_PCI_8GB
	{
	 	//xÏ∂ïÏùÑ 2Í∞úÏù¥???¨Ïö©?òÎèÑÎ°??§Ï†ï?ÑÏöî.
		category:'QD_PCI8GB',
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
			chartWidth: 50 , // percent Î°??úÏãú
			oneLineChatNum: 2,
			oneLineHeight: 600
		},
		gridColWidth: '75px',
		orderby: 10.5
	},
	//Latency_PCI
	{
		category:'Latency_PCI',
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
		},
		{
			col:'MEASURE1',
			val: function(){
				return this.MEASURE;									
			}
		}
		],
		filters:[
			{col:'FIELD',val:'IOps'}
		],
		xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
		categoryCols:['SPEC'],
		yCol:'MEASURE1',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:false,
			cols:[]
		},
		decimalPoint:2
		, gridSeriesColWidth: ''
		, gridColWidth: '115px'
		, orderby: 9
 	},
 	{
		category:'Latency_PCI8GB',
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
		},
		{
			col:'MEASURE1',
			val: function(){
				return this.MEASURE;									
			}
		}
		],
		filters:[
			{col:'FIELD',val:'IOps'}
		],
		xOderbyCols:['FIRMWARE1','ORDER','SPEC'],
		categoryCols:['SPEC'],
		yCol:'MEASURE1',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:false,
			cols:[]
		},
		decimalPoint:2
		, gridSeriesColWidth: ''
		, gridColWidth: '115px'
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
			{col:'IS_DISPLAY', val:'Y'}
		],
		xOderbyCols:['FIRMWARE1','SPEC2'],
		categoryCols:['SPEC2'],
		yCol:'MEASURE1',
		yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'IS_SCORE',
			yAxisTitle:{NotScore:'MB/s'},
			chartWidth: 100 , // percent 
			oneLineChatNum: 1,
			oneLineHeight: 600
		},
		gridSeriesColWidth: '100px',
 		gridColWidth: '80px',
		orderby: 260
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
			yAxisTitle:{NotScore:'MB/s'},
			chartWidth: 50 , // percent ∑Œ «•Ω√
			oneLineChatNum: 2,
			oneLineHeight: 600
		},
		gridSeriesColWidth: '100px',
		gridColWidth: '65px',
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
		orderby: 300.5
 	}
 	
 	
 
];