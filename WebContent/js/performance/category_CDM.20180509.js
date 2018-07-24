var category_cdm = [
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
		yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:false,
			cols:[]
		},
		gridSeriesColWidth: '100px',
		 gridColWidth: '70px',
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
		yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:false,
			cols:[]
		},
		gridSeriesColWidth: '100px',
		 gridColWidth: '70px',
		orderby: 220
	},
	{
		category:'CDM600.xlsx',
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
		yAxisTitle :' MB/s',
		seriesCol:{cd:'FIRMWARE1',name:'FIRMWARE1'},
		multichart:{
			enabled:false,
			cols:[]
		},
		gridSeriesColWidth: '100px',
		 gridColWidth: '70px',
		orderby: 230
	}
 	
 
];