var category_sustain = [
	// sustain
	{				
		category:'Sustain',
		calculateCols : [],
		orderby: 1000,
		uiSchema: {
			containerId:'Sustain',
			type:'HorizontalLayout',
			label:'',
			elements:[ 
				{
					containerCss:[
						{code: 'display', value:''}
						,{code: 'float', value:'left'}
						//,{code: 'height', value:'1000px'}
						,{code: 'width', value:'100%'}
					],					
					type:'chart',
		            	id: 'Sustain_highChart',
		            	label:'',
		            	width: '100%',
		            	//height:'800px',
			            data: function(){
		            		var rtn = {};
							
							// 01. data ajax
		            		$.each(dataList, function(){
		            			try{
		            				var dateSplit = this.SPEC1.match(/([0-9]+)/gi);
			            			var utcdt = Date.UTC(dateSplit[0], dateSplit[1] -1 , dateSplit[2],dateSplit[3],dateSplit[4],dateSplit[5],dateSplit[6]);
			            			this.dtUtc = utcdt;
			            			this.x = utcdt;
			            			this.y = this.MEASURE;
		            			}catch(e){
		            				var err = e;
		            			}
		            		});
		            		
		            		// create table
		            		var series = {series: []};
		            		if(alasql.tables.sustain == undefined && dataList.length >0){
                				var v_sql = 'create table sustain(';
                    			var i = 0;
                    			$.each(dataList[0],function(k,v){
                    				if(i > 0)
                    					v_sql += ',';
                    				v_sql += k + ' ' + typeof v;
            						i += 1;
                    			});
                    			v_sql += ')';
                    			alasql(v_sql);
                			}
                			alasql.tables['sustain'].data = dataList;
		            		var chart_param = {
		            				dataSrc: dataList , 
		            				seriesKey: {cd:'FIRMWARE', name:'FIRMWARE'},
		            				seriesIndex:{sql:'create index idx_FIRMWARE on sustain(FIRMWARE)', index : 'idx_FIRMWARE'},
		            				//filters: [] ,
		            				//convertDefiines: [] ,
		            				//xCategoryCol : 'x',
		            				xCategoryAddIfEmpty: false ,
		            				//xCategoryIndex :'idx_TESTNAME_SLOTNAME', // xCategoryAddIfEmpty == true 인경우 유효. 속도에 절대적인 요소.  
		            				xCategoryIndicate: false,
		            				//yCategoryCol : 'MEASURE',
		            				yCategoryIndicate: false,
		            				isGroupby : false,
		            				tablename : 'sustain'
		            		};
		            		series = fn_makeDataForChart(chart_param);
		            		$.each(series.series, function(){
		            			this.turboThreshold = 1000000;
		            		});
		            		
		            		//////////// xcategory?
		            		var xAxis = {
		            			type: 'datetime'	
		            			, dateTimeLabelFormats:{
		            				
		            				second: '%Y.%m.%e %H:%M:%S',
		            				minute: '%Y.%m.%e %H:%M',
		            				hour: '%Y.%m.%e %H',
		            				day: '%Y.%m.%e',
		            				week: '%Y.%m.%e',
		            				month: '%Y.%m',
		            				year: '%Y'
		            			},
			            		labels: {
			                        rotation: -45
			                        
			                    }
		            		};
		            		
		            		rtn.xAxis = xAxis;
		            		
		            		// return start
		            		rtn.series = series;
		            		return rtn;
		            	},
		            	options: function(){
		            		var option = {
	            				chart:{
	            					type: 'scatter',
	            					//, plotBorderWidth: 1
	            			        zoomType: 'xy',
	            			        height: 600
	            				}
	            				, legend: {
	            			        enabled: true
	            			    }
	            				, title: {
	            			        text: ' '
	            			    },
	            			    plotOptions: {
						            scatter: {
						                marker: {
						                    radius: 2
						                }
						            }
						        },
	            			    tooltip: {
//	            			    	crosshairs: false,
//	            			    	shared: false,
//			 	            		useHTML: true,
//	            			        headerFormat: '',
 	            			        pointFormat: '{point.options.SPEC1} : <b> {point.y} </b>'
 	            			        			 
// 	            			        footerFormat: '</table>',

//									pointFormatter: function(){
//										if(this.series.type=='line'){
//											var rtn = '';
//											rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
//											rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
//											rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
//											rtn += '<br><b>Time:</b>' + this.DT_STR;
//											rtn += '<br><b>Average:</b>' + Highcharts.numberFormat(this.Avg ,0,'.',',') ;
//											rtn +=  '<br><b>Min:</b> ' +  Highcharts.numberFormat(this.Min ,0,'.',',');
//											rtn +=  '<br><b>Max:</b> ' + Highcharts.numberFormat(this.Max ,0,'.',',');
//											return rtn;
//										}else if(this.series.type == 'arearange'){
//											var rtn = '';
//											
//											rtn += '<br><b>Sub test:</b>' + this.SUBTEST ;
//											rtn += '<br><b>Serial number:</b>' + this.SERIAL_NUMBER ;
//											rtn += '<br><b>Capacity:</b>' + this.CAPACITY;
//											rtn += '<br><b>Time:</b>' + this.DT_STR;
//											rtn += '<br><b>Average:</b>' + Highcharts.numberFormat(this.Avg ,0,'.',',') ;
//											rtn +=  '<br><b>Min:</b> ' +  Highcharts.numberFormat(this.Min ,0,'.',',');
//											rtn +=  '<br><b>Max:</b> ' + Highcharts.numberFormat(this.Max ,0,'.',',');
//											
//											return rtn;
//												
//										}
//									},
//  			        			followPointer: true
	            			    }
	            				
	            		};
	            		
	            		return option;
	            	}
		            	
				}
				
			]								
		}
		//uiSchema end
	}
 
];