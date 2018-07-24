var category_sit = [
	// DiskMark.txt  referenced from CDM301.xlsx
	{
		category:'DiskMark.txt',
		category_name:'CDM(5.0.3)',
		calculateCols:[
			{
				col:'CDM_SPEC',
				val: function(){	     							
					var match_qd = this.QUEUE_DEPTH.match(/Q\=\s+([\d]+)/);
					var vqd = "";
					var vspec = "";
					var vvolume = "";
					
					if(match_qd != null){
						vqd = "(QD"+match_qd[1] + ")";
					}
					
					if(this.SPEC.match(/Sequential/gi) != null)
						vspec = 'Seq.';
					else
						vspec = 'R.';
					
					if(this.SPEC1 != 'NONE'){
						vvolume = this.SPEC1;
					}

					if(vvolume != "")
						return vvolume + ' ' + vspec + this.FIELD.substr(0,1) + vqd;
					else
						return vspec + ' ' + this.FIELD + vqd;

				}
			},
			{
				col:'CDM_ORDER',
				val: function(){	     							
					var match_qd = this.QUEUE_DEPTH.match(/Q\=\s+([\d]+)/);
					var vqd = "0";
					var vspec = "";
					var vvolume = "";
					
					if(match_qd != null){
						vqd = match_qd[1];
					}
					if(this.SPEC.match(/Sequential/gi) != null)
						vspec = 'Seq.';
					else
						vspec = 'R.';
					
					if(this.SPEC1 != 'NONE'){
						vvolume = this.SPEC1;
					}

					if(vvolume != "")
						return vvolume + ' ' + vqd +  vspec + this.FIELD.substr(0,1) ;						
					else{
						if(this.SPEC.match(/Sequential/gi) != null)
							vspec = '1.';
						else
							vspec = '2.';
						return vspec + ' ' + vqd  + this.FIELD ;
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
		yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:false,
			cols:[]
		},
		gridSeriesColWidth: '200px',
		gridColWidth: '80px',
		orderby: 100
	}
	// IOMETER_MAX_results
	, {
		category:'IOMETER_MAX_results',
		category_name:'IOMETER MAX',
		calculateCols:[
			{
				col:'QD',
				val: function(){	     							
					return "QD: " + this.QUEUE_DEPTH;
				}
			},		
			{
				col:'SPEC_CUS',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)_(?<seq_random>[\w]+)_(?<read_write>[\w]+)(\((?<unalign>[\w]+)\))?/i);
					if(match){
						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						var unalign = match.groups.unalign;

						return spec + "." +  seq_random + "." + read_write;
						// return seq_random;

					}else
						return this.SPEC;
				}
			},
			{
				col:'ALIGN',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)_(?<seq_random>[\w]+)_(?<read_write>[\w]+)(\((?<unalign>[\w]+)\))?/i);
					if(match){

						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						var unalign = match.groups.unalign;
						if ( unalign == undefined)
							return "Align";
						else 
							return "Unalign";

					}else
						return "0";
				}
			},
			{
				col:'READ_WRITE',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)_(?<seq_random>[\w]+)_(?<read_write>[\w]+)(\((?<unalign>[\w]+)\))?/i);
					if(match){

						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						var unalign = match.groups.unalign;
						return read_write;

					}else
						return "0";
				}
			},
			{
				col:'VOLUME',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)_(?<seq_random>[\w]+)_(?<read_write>[\w]+)(\((?<unalign>[\w]+)\))?/i);
					if(match){
						var volume = match.groups.volume;
						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						var unalign = match.groups.unalign;
						return "Volume: " + volume;

					}else
						return "0";
				}
			},
			{
				col:'SEQ_RANDOM',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)_(?<seq_random>[\w]+)_(?<read_write>[\w]+)(\((?<unalign>[\w]+)\))?/i);
					if(match){
						var volume = match.groups.volume;
						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						var unalign = match.groups.unalign;
						return seq_random;

					}else
						return "0";
				}
			},
			{
				col:'ORDER_SEQ_RANDOM',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)_(?<seq_random>[\w]+)_(?<read_write>[\w]+)(\((?<unalign>[\w]+)\))?/i);
					if(match){
						var volume = match.groups.volume;
						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						var unalign = match.groups.unalign;
						if(seq_random.match(/Seq/i) != null)
							return "1";
						else
							return "2";

					}else
						return "0";
				}
			}
		],
		filters:[
			
		],
		xOderbyCols:['FIRMWARE1','ALIGN','READ_WRITE','VOLUME','QD','ORDER_SEQ_RANDOM'],
		categoryCols:['ALIGN','READ_WRITE','VOLUME','SEQ_RANDOM','QD','SPEC_CUS'],
		yCol:'MEASURE',
		// yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'FIELD',
			chartWidth: 100 ,
			oneLineChatNum: 1,
			// ,oneLineHeight: 800
			title: {'IOps':'IOps','MBps (Decimal)':'MBps (Decimal)'}
		},
		gridSeriesColWidth: '200px',
		gridColWidth: '90px',
		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 200
	}
	// IOMETER_SUST_results
	, {
		category:'IOMETER_SUST_results',
		category_name:'IOMETER SUST',
		calculateCols:[
			{
				col:'QD',
				val: function(){	     							
					return "QD: " + this.QUEUE_DEPTH;
				}
			},		
			{
				col:'SPEC_CUS',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)__(?<read_write>[\w]+)\s+(?<percent1>[\d]+)%__(?<seq_random>[\w]+)\s+(?<percent2>[\d]+)%/i);
					if(match){
						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;

						return spec + "." +  seq_random + "." + read_write;
						// return seq_random;

					}else
						return this.SPEC;
				}
			},
			{
				col:'READ_WRITE',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)__(?<read_write>[\w]+)\s+(?<percent1>[\d]+)%__(?<seq_random>[\w]+)\s+(?<percent2>[\d]+)%/i);
					if(match){
						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						var unalign = match.groups.unalign;
						return read_write;

					}else
						return "0";
				}
			},
			{
				col:'VOLUME',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)__(?<read_write>[\w]+)\s+(?<percent1>[\d]+)%__(?<seq_random>[\w]+)\s+(?<percent2>[\d]+)%/i);
					if(match){
						var volume = match.groups.volume;
						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						return "Volume: " + volume;

					}else
						return "0";
				}
			},
			{
				col:'SEQ_RANDOM',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)__(?<read_write>[\w]+)\s+(?<percent1>[\d]+)%__(?<seq_random>[\w]+)\s+(?<percent2>[\d]+)%/i);
					if(match){
						var volume = match.groups.volume;
						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						return seq_random;

					}else
						return "0";
				}
			},
			{
				col:'ORDER_SEQ_RANDOM',
				val: function(){	     							
					var match = this.SPEC.match(/(?<volume>[\d]+)(?<unit>[\w]+)__(?<read_write>[\w]+)\s+(?<percent1>[\d]+)%__(?<seq_random>[\w]+)\s+(?<percent2>[\d]+)%/i);
					if(match){
						var volume = match.groups.volume;
						var spec = match.groups.volume + match.groups.unit;
						var seq_random = match.groups.seq_random;						
						var read_write = match.groups.read_write;
						if(seq_random.match(/Seq/i) != null)
							return "1";
						else
							return "2";

					}else
						return "0";
				}
			}
		],
		filters:[
			
		],
		xOderbyCols:['FIRMWARE1','READ_WRITE','VOLUME','QD','ORDER_SEQ_RANDOM'],
		categoryCols:['READ_WRITE','SPEC_CUS'],
		yCol:'MEASURE',
		// yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'FIELD',
			chartWidth: 50 ,
			oneLineChatNum: 2,
			// ,oneLineHeight: 800
			title: {'IOps':'IOps','MBps (Decimal)':'MBps (Decimal)'}
		},
		gridSeriesColWidth: '200px',
		gridColWidth: '120px',
		girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 300
	}
	// SSD Tune BM Log
	, {
		category:'BM_Logs',
		category_name:'SSDTune BM Logs',
		calculateCols:[
			{
				col:'TITLE',
				val: function(){	     							
					return this.SPEC;
				}
			}	
		],
		filters:[
			
		],
		xOderbyCols:['FIRMWARE1','FIELD'],
		categoryCols:['TITLE','FIELD'],
		yCol:'MEASURE',
		// yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'SPEC',
			chartWidth: 25 ,
			oneLineChatNum: 4,
			// ,oneLineHeight: 800
			orderBy : function(){
				if(this.SPEC == 'Average')
					return 10;
				else if (this.SPEC == 'Maximum')
					return 20;
				else if (this.SPEC == 'Minimum')
					return 30;
				else if (this.SPEC == 'IOPS')
					return 40;
				
			},
			yAxisTitle:{Average:'MB/s',IOPS:'IOPS',Maximum:'MB/s',Average:'MB/s'},
			title: {Average:'Average',IOPS:'IOPS',Maximum:'Maximum',Minimum:'Minimum'}
		},
		gridSeriesColWidth: '100px',
		gridColWidth: '80px',
		// girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 400
	}
	, {
		category:'FDM_Logs',
		category_name:'SSDTune FDM Logs',
		calculateCols:[
			{
				col:'TITLE',
				val: function(){	     							
					return this.SPEC;
				}
			}	
		],
		filters:[
			
		],
		xOderbyCols:['FIRMWARE1','FIELD'],
		categoryCols:['TITLE','FIELD'],
		yCol:'MEASURE',
		// yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'SPEC',
			chartWidth: 25 ,
			oneLineChatNum: 4,
			// ,oneLineHeight: 800
			orderBy : function(){
				if(this.SPEC == 'Average')
					return 10;
				else if (this.SPEC == 'Maximum')
					return 20;
				else if (this.SPEC == 'Minimum')
					return 30;
				else if (this.SPEC == 'IOPS')
					return 40;
				
			},
			yAxisTitle:{Average:'MB/s',IOPS:'IOPS',Maximum:'MB/s',Minimum:'MB/s'},
			title: {Average:'Average',IOPS:'IOPS',Maximum:'Maximum',Minimum:'Minimum'}
		},
		gridSeriesColWidth: '100px',
		gridColWidth: '80px',
		// girdColFormat: { decimalSeparator: ".", thousandsSeparator: ",", decimalPlaces: 0, defaultValue: '0' },
		orderby: 500
	}

	,{
		category:'pcmark8.xml',
		category_name:'PCMark8',
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
		yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:true,
			splitCol:'IS_SCORE',
			yAxisTitle:{NotScore:'MB/s'},
			chartWidth: 50 , // percent 로 표시
			oneLineChatNum: 2,
			oneLineHeight: 600
		},
		gridColWidth: '140px',
		orderby: 600
	 },
 
];