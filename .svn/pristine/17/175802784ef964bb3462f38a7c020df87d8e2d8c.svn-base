
/**
 * 
 */

function drawchartByAllSite(){
	
		currentFunc = drawchartByAllSite;
		currentArg = arguments;
		var groupKeys = ['NATL_CD','NATL_NAME','YYYYMM'];
		/*var series = getDrillDownDataSeries(
				'',
				dataList,
				groupKeys,
				[],
				'YYYYMM',
				'MM_RESULT',
				{cd: 'NATL_CD', name:'NATL_NAME'}
		);*/
		
		var data = [];
		if(dataListOrigine.length == 0)
			data = dataProject;
		else 
			data  = dataList;
		
		var series = getDrillDownDataSeries2(
				'',
				data,
				groupKeys,
				[], //filter
				[{col:'MM_RESULT',convert:'y',isnull:0},{col:'YYYYMM',convert:'x',datatype:'date'}], //convert
				'YYYYMM',//빈값이 있으면 강제로 할당한다.
				'MM_RESULT',
				{cd: 'NATL_CD', name:'NATL_NAME'},
				{isGroupby:true}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		$('#container').highcharts({
	        chart: {
	            type: 'area',
	            zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text:'&nbsp;',
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	/* buttons:{
	        		contextButton:{
	        			menuItems: myExporting
	        		}
	        	} */
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 *30 -1 ,
	        	//tickmarkPlacement: 'on',
	        	//startOnTick: true,
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
	           /* ,labels: {
	                formatter: function () {
	                	var dt = new Date(this.value);
	                	return (dt.getMonth()+1) + '.' + dt.getDate();
	                    
	                }
	            } */
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: true,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		//day: '%y/%m',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '',
	            valueDecimals: 2
	            /*, formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            }*/
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
	            },
	            area: {
	                stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f}',
	                    formatter: function(){
	                    	if(this.point.y != 0)
	                    		return Math.round(this.point.y);
	                    }
	                },
	                trackByArea: true,
	                enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		$("#loader").show();
	                		var site = this.options.id;
	                		setTimeout(function(){	
	                			drawchartBySiteProject(site);
					    	},50);
	                		
                		} 
	                }
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            }
	        },	        
	        series: series.series
	    },function(chart){
		    	/*var filters = [];
				var sorts = ['NATL_NAME','PJT_NAME','PJT_FUNC_NAME','YYYYMM'];			
				var list = getFilteredData(dataList,filters,sorts);
				setAlldataInList(list);
		    	drawGrid(list, gridModel_site_project_func);	*/
	    	$("#loader").hide();
		    }
		);
		
	}
	
	
	
	function drawchartBySiteProject(site){
//		if(dataList.length == 0)
//			return;
		
		currentFunc = drawchartBySiteProject;
		currentArg = arguments;
		var groupKeys = ['NATL_CD','NATL_NAME','PJT_ID','PJT_NAME','YYYYMM'];
		var series = getDrillDownDataSeries2(
				'' ,
				dataList ,
				groupKeys ,
				[{col:'NATL_CD',val:site}],
				[{col:'MM_RESULT',convert:'y',isnull:0},{col:'YYYYMM',convert:'x',datatype:'date'}], //convert
				'YYYYMM',
				'MM_RESULT',
				{cd: 'PJT_ID', name:'PJT_NAME'}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		
		var title = "";
		if(series.series.length>0)
			title = series.series[0].data[0].NATL_NAME + ' (by Site > Project)';
		
		$('#container').highcharts({
	        chart: {
	            type: 'area',
	            zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text: title ,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					{
						//cursor: 'pointer',
					    x: -250,
					    y: 5,
					    onclick: function () {
							drawchartByAllSite();
					    },
					    symbol: 'square',
					    text:'Up to All Site'
					},
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	drawchartBySiteFunc(site);
					    },
					    symbol: 'square',
					    text:'Convert Site > Func'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
	           /* ,labels: {
	                formatter: function () {
	                	var dt = new Date(this.value);
	                	return (dt.getMonth()+1) + '.' + dt.getDate();
	                    
	                }
	            } */
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: true,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y'
	            },
	            valueSuffix: '' ,
	            valueDecimals: 2 /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
	            },
	            area: {
	                stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		drawchartBySiteProjectFunc(site,this.options.id);
                		}  
	                }
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            }
	        },	        
	        series: series.series
	        //drilldown: {series: drilldowns}
	        
	    },function(chart){	    	
		    	/*var filters = [
		    		{col: 'NATL_CD',val: site}
		    	];
				var sorts = ['NATL_NAME','PJT_NAME','PJT_FUNC_NAME','YYYYMM'];			
				var list = getFilteredData(dataList,filters,sorts);
				setAlldataInList(list);
		    	drawGrid(list, gridModel_site_project_func);	*/
	    	
	    		$("#loader").hide();
	    	}
		);
		
	}
	
	function drawchartBySiteProjectFunc(site,pjtId){
//		if(dataList.length == 0)
//			return;
		
		currentFunc = drawchartBySiteProjectFunc;
		currentArg = arguments;
		var groupKeys = ['NATL_CD','NATL_NAME','PJT_ID','PJT_NAME','UP_PJT_FUNC_NAME','YYYYMM'];
		var series = getDrillDownDataSeries2(
				pjtId,
				dataList,
				groupKeys,
				[{col:'NATL_CD',val:site},{col:'PJT_ID',val:pjtId}],
				[{col:'MM_RESULT',convert:'y',isnull:0},{col:'YYYYMM',convert:'x',datatype:'date'}], //convert
				'YYYYMM',
				'MM_RESULT',
				{cd: 'UP_PJT_FUNC_NAME', name:'UP_PJT_FUNC_NAME'}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		var title = "";
		if(series.series.length>0)
			title = series.series[0].data[0].NATL_NAME + ' > ' + series.series[0].data[0].PJT_NAME + ' (by Site > Project > Func)';
		
		$('#container').highcharts({
	        chart: {
	            type: 'area',
	            zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text: title ,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					/* {
						cursor: 'pointer',
					    x: -250,
					    y: 5,
					    onclick: function () {
							drawchartByAllProject();
					    },
					    symbol: 'square',
					    text:'Up to Main'
					}, */
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	$("#loader").show();
					    	setTimeout(function(){	
					    		drawchartBySiteProject(site);
					    	},50);
					    },
					    symbol: 'square',
					    text:'Up to Site > Project'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
	           /* ,labels: {
	                formatter: function () {
	                	var dt = new Date(this.value);
	                	return (dt.getMonth()+1) + '.' + dt.getDate();
	                    
	                }
	            } */
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: false,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y'
	            },
	            valueSuffix: '',
	            valueDecimals: 2 /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
	            },
	            area: {
	                stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true,
	                events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		drawchartBySiteProjectFuncSubfunc(site,pjtId,this.name);
                		}  
	                }
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            },
	            column: {
	            	stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: true,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: true
	            }
	        },	        
	        series: series.series
	    },function(chart){
    			/*var filters = [
					{col: 'NATL_CD',val: site},
   		    		{col: 'PJT_ID',val: pjtId}
   		    		
   		    	];
   				var sorts = ['NATL_NAME','PJT_NAME','PJT_FUNC_NAME','YYYYMM'];			
   				var list = getFilteredData(dataList,filters,sorts);
   				setAlldataInList(list);
   		    	drawGrid(list, gridModel_site_project_func);	*/
	    	}
		);
		
	}
	
	function drawchartBySiteProjectFuncSubfunc(site,pjtId,func){
		/*if(dataList.length == 0)
			return;*/
		
		currentFunc = drawchartBySiteProjectFuncSubfunc;
		currentArg = arguments;
		var pjtNames = dataFilter(dataList,[{col: 'PJT_ID', val: pjtId}]);
		var pjtName = pjtNames[0].PJT_NAME;
		
		var vlist = [];
		var funcIds = dataFilter(dataList,[{col: 'UP_PJT_FUNC_NAME', val: func }]);
		var funcId = funcIds[0].UP_PJT_FUNC_ID;
		$.ajax({
			url: "/dashboard/pmsResourceSubfuncJson.html",
			data: {site: site, pjt_code: pjtId, func: funcId, estStartDate: $("#estStartDate").val(), estEndDate: $("#estEndDate").val() }, 
			async: false,
			success:  function(response){
				vlist = response.data;
			}
		});
		
			var groupKeys = ['NATL_CD','NATL_NAME','UP_PJT_FUNC_NAME','FUNC_NAME','YYYYMM'];
			var series = getDrillDownDataSeries2(
					'',
					vlist,
					groupKeys,
					[],
					[{col:'MM_RESULT',convert:'y',isnull:0},{col:'YYYYMM',convert:'x',datatype:'date'}], //convert
					'YYYYMM',
					'MM_RESULT',
					{cd: 'FUNC_NAME', name:'FUNC_NAME'},
					{isGroupby: false}
			);
			
			
			if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
			var title = "";
			if(series.series.length>0)
				title = series.series[0].data[0].NATL_NAME + ' > ' + pjtName  + ' > '+ func + ' (by Site > Project > Func > Subfunc)'  ;
			
			$('#container').highcharts({
		        chart: {
		            type: 'area',
		            zoomType: 'y'
		        },
		        credits: {//gets rid of the highcharts logo in bottom right
	                enabled: false
	            },
		        title: {
		        	text: title,
	            	useHTML: true
		        },
		        subtitle: {
		            text: ''
		        },
		        exporting:{
		        	buttons: [
						/* {
							cursor: 'pointer',
						    x: -250,
						    y: 5,
						    onclick: function () {
								drawchartByAllProject();
						    },
						    symbol: 'square',
						    text:'Up to Main'
						}, */
						{
						    x: -100,
						    y: 5,
						    onclick: function () {
						    	drawchartBySiteProjectFunc(site,pjtId);
						    },
						    symbol: 'square',
						    text:'Up to Site > Project > Function'
						}
					]
		        },
		        xAxis: {
		        	type: 'datetime',
		        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
		        	tickInterval: 24 * 3600 * 1000 * 30,
		        	//tickmarkPlacement: 'on',
		        	dateTimeLabelFormats: { // don't display the dummy year
		        		week: '%m/%e',
		        		day: '%m/%e',
		        		month: '%y/%m',
		        		year: '%y/%m/%e'
		            }
		            //title: {
		            //    enabled: false
		            //},
		            //plotBands : plotBandsHigh,
		            //plotLines: plotLinesHigh
		           /* ,labels: {
		                formatter: function () {
		                	var dt = new Date(this.value);
		                	return (dt.getMonth()+1) + '.' + dt.getDate();
		                    
		                }
		            } */
		        },
		        yAxis: {
		            title: {
		                text: ''
		            }
		            
		        },
		        tooltip: {
		        	enabled:true,
		            shared: true ,
		            crosshairs: false,
		            dateTimeLabelFormats: {
		            	week: '%y/%m/%e',
		        		day: '%y/%m/%e',
		        		month: '%y/%m',
		        		year: '%y/%m/%e'
		            },
		            valueSuffix: '' ,
		            valueDecimals: 2 /* ,
		            formatter: function () {
		            	var data = getDataByUtc($("#sProject").val(), this.x);
		                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
		                    '' + this.series.name + ':' + this.y + '';
		            } */
		        },
		        //legend: legend,
		        plotOptions: {
		        	series: {
		        		//cursor: 'pointer',
		                connectNulls: true // by default
		               /*  point:{
		                	events:{
		                		click: function(e){
		                			//alert('click');
		                		}
		                	}
		                } */
		            },
		            area: {
		                stacking: 'normal',
		                lineColor: '#666666',
		                lineWidth: 1,
		                marker: {
		                    lineWidth: 1,
		                    lineColor: '#666666',
		                    enabled: true
		                },
		                dataLabels: {
		                    enabled: true,
		                    format:'{point.y:.0f}'
		                },
		                trackByArea: true,
		                enableMouseTracking: true
		                /* events:{
		                	click: function(e){
		                		//this.options.pjt_id
		                		//this.options.pjt_name
		                		drawchartByProjectSite(this.name);
	                		}  
		                } */
		                	
		            },
		            line: {
		            	//stacking: 'normal',
		                //lineColor: 'red',
		                //lineWidth: 1,
		                marker: {
		                	enabled: false,
		                    lineWidth: 1,
		                    lineColor: '#666666'
		                },
		                dataLabels: {
		                    enabled: false
		                },
		                enableMouseTracking: false
		            },
		            column: {
		            	stacking: 'normal',
		                //lineColor: 'red',
		                //lineWidth: 1,
		                marker: {
		                	enabled: true,
		                    lineWidth: 1,
		                    lineColor: '#666666'
		                },
		                dataLabels: {
		                    enabled: true
		                },
		                enableMouseTracking: true
		            }
		        },	        
		        series: series.series
		    },function(chart){
	    			/*var filters = [
						{col: 'NATL_CD',val: site},
	   		    		{col: 'PJT_FUNC_NAME',val: func}
	   		    		
	   		    	];
	   				var sorts = ['NATL_NAME','PJT_FUNC_NAME','PJT_NAME','YYYYMM'];			
	   				var list = getFilteredData(dataList,filters,sorts);
	   				setAlldataInList(list);
	   		    	drawGrid(list, gridModel_site_func_project);	*/
		    	}
			);
		}
	
	function drawchartBySiteFunc(site){
		/*if(dataList.length == 0)
			return;*/
		
		currentFunc = drawchartBySiteFunc;
		currentArg = arguments;
		
		//var groupKeys = ['NATL_CD','NATL_NAME','PJT_FUNC_ID','PJT_FUNC_NAME','YYYYMM'];
		var groupKeys = ['NATL_CD','NATL_NAME','UP_PJT_FUNC_NAME','YYYYMM'];
		var series = getDrillDownDataSeries2(
				'',
				dataList ,
				groupKeys ,
				[{col:'NATL_CD',val:site}],
				[{col:'MM_RESULT',convert:'y',isnull:0},{col:'YYYYMM',convert:'x',datatype:'date'}], //convert
				'YYYYMM',
				'MM_RESULT',
				{cd: 'UP_PJT_FUNC_NAME', name:'UP_PJT_FUNC_NAME'}
		);
				
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		var title = "";
		if(series.series.length>0)
			title = series.series[0].data[0].NATL_NAME + ' (by Site > Func)' ;
		
		$('#container').highcharts({
	        chart: {
	            type: 'area',
	            zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text: title ,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					{
						cursor: 'pointer',
					    x: -250,
					    y: 5,
					    onclick: function () {
							drawchartByAllSite();
					    },
					    symbol: 'square',
					    text:'Up to All Site'
					},
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	$("#loader").show();
	                		setTimeout(function(){	
	                			drawchartBySiteProject(site);
					    	},50);
					    },
					    symbol: 'square',
					    text:'Convert Site > Project'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
	           /* ,labels: {
	                formatter: function () {
	                	var dt = new Date(this.value);
	                	return (dt.getMonth()+1) + '.' + dt.getDate();
	                    
	                }
	            } */
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: true,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '',
	            valueDecimals: 2/* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
	            },
	            area: {
	                stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true ,
	                events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		//drawchartBySiteFuncProject(site,this.options.id);
	                		drawchartBySiteFuncSubfunc(site,this.options.id);
                		}  
	                }
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            }
	        },	        
	        series: series.series
	    },function(chart){
	    		/*var filters = [
		    		{col: 'NATL_CD',val: site}
		    	];
				var sorts = ['NATL_NAME','PJT_NAME','PJT_FUNC_NAME','YYYYMM'];			
				var list = getFilteredData(dataList,filters,sorts);
				setAlldataInList(list);
		    	drawGrid(list, gridModel_site_func_project);	*/
	    	}
		);
		
	}
	
function drawchartBySiteFuncProject(site,func){
	/*if(dataList.length == 0)
		return;*/
	
	currentFunc = drawchartBySiteFuncProject;
	currentArg = arguments;
		var groupKeys = ['NATL_CD','NATL_NAME','UP_PJT_FUNC_NAME','PJT_ID','PJT_NAME','YYYYMM'];
		var series = getDrillDownDataSeries2(
				func,
				dataList,
				groupKeys,
				[{col:'NATL_CD',val:site},{col:'UP_PJT_FUNC_NAME',val:func}],
				[{col:'MM_RESULT',convert:'y',isnull:0},{col:'YYYYMM',convert:'x',datatype:'date'}], //convert
				'YYYYMM',
				'MM_RESULT',
				{cd: 'PJT_ID', name:'PJT_NAME'}
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		var title = "";
		if(series.series.length>0)
			title = series.series[0].data[0].NATL_NAME + ' > ' + series.series[0].data[0].UP_PJT_FUNC_NAME + ' (by Site > Func > Project)'  ;
		
		$('#container').highcharts({
	        chart: {
	            type: 'area',
	            zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text: title,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					/* {
						cursor: 'pointer',
					    x: -250,
					    y: 5,
					    onclick: function () {
							drawchartByAllProject();
					    },
					    symbol: 'square',
					    text:'Up to Main'
					}, */
					{
					    x: -350,
					    y: 5,
					    onclick: function () {
					    	drawchartBySiteFunc(site);
					    },
					    symbol: 'square',
					    text:'Up to Site > Func'
					},
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	drawchartBySiteFuncSubfunc(site, func);
					    },
					    symbol: 'square',
					    text:'Convert Site > Function > Sub function'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
	           /* ,labels: {
	                formatter: function () {
	                	var dt = new Date(this.value);
	                	return (dt.getMonth()+1) + '.' + dt.getDate();
	                    
	                }
	            } */
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: false,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '' ,
	            valueDecimals: 2 /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		//cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
	            },
	            area: {
	                stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true
	                /* events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		drawchartByProjectSite(this.name);
                		}  
	                } */
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            },
	            column: {
	            	stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: true,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: true
	            }
	        },	        
	        series: series.series
	    },function(chart){
    			/*var filters = [
					{col: 'NATL_CD',val: site},
   		    		{col: 'PJT_FUNC_NAME',val: func}
   		    		
   		    	];
   				var sorts = ['NATL_NAME','PJT_FUNC_NAME','PJT_NAME','YYYYMM'];			
   				var list = getFilteredData(dataList,filters,sorts);
   				setAlldataInList(list);
   		    	drawGrid(list, gridModel_site_func_project);	*/
	    	}
		);
	}

function drawchartBySiteFuncSubfunc(site,func){
	/*if(dataList.length == 0)
		return;*/
	
	currentFunc = drawchartBySiteFuncSubfunc;
	currentArg = arguments;
	
	var siteName = dataFilter(dataList,[{col: 'NATL_CD', val: site}])[0].NATL_NAME;
	
	var vlist = [];
	var funcIds = dataFilter(dataList,[{col: 'UP_PJT_FUNC_NAME', val: func}]);
	var funcId = funcIds[0].UP_PJT_FUNC_ID;
	$.ajax({
		url: "/dashboard/pmsResourceSubfuncJson.html",
		data: {site: site, func: funcId, estStartDate: $("#estStartDate").val(), estEndDate: $("#estEndDate").val()}, 
		async: false,
		success:  function(response){
			vlist = response.data;
		}
	});
	
		var groupKeys = ['FUNC_NAME','YYYYMM'];
		var series = getDrillDownDataSeries2(
				'',
				vlist,
				groupKeys,
				[],
				[{col:'MM_RESULT',convert:'y',isnull:0},{col:'YYYYMM',convert:'x',datatype:'date'}], //convert
				'YYYYMM',
				'MM_RESULT',
				{cd: 'FUNC_NAME', name:'FUNC_NAME'}
	
		);
		
		
		if($('#container').highcharts() != undefined) $('#container').highcharts().destroy();
		var title = "";
		if(series.series.length>0)
			title = siteName + ' > ' + func + ' (by Site > Func > Subfunc)'  ;
		
		$('#container').highcharts({
	        chart: {
	            type: 'area',
	            zoomType: 'y'
	        },
	        credits: {//gets rid of the highcharts logo in bottom right
                enabled: false
            },
	        title: {
	        	text: title,
            	useHTML: true
	        },
	        subtitle: {
	            text: ''
	        },
	        exporting:{
	        	buttons: [
					/* {
						cursor: 'pointer',
					    x: -250,
					    y: 5,
					    onclick: function () {
							drawchartByAllProject();
					    },
					    symbol: 'square',
					    text:'Up to Main'
					}, */
					{
					    x: -350,
					    y: 5,
					    onclick: function () {
					    	drawchartBySiteFunc(site);
					    },
					    symbol: 'square',
					    text:'Up to Site > Func'
					}, 
					{
					    x: -100,
					    y: 5,
					    onclick: function () {
					    	drawchartBySiteFuncProject(site,func);
					    },
					    symbol: 'square',
					    text:'Convert Site > Function > Project'
					}
				]
	        },
	        xAxis: {
	        	type: 'datetime',
	        	//tickInterval: 24 * 3000000 * 1000 , //1000000 * 60 * 60 * 24 ,
	        	tickInterval: 24 * 3600 * 1000 * 30,
	        	//tickmarkPlacement: 'on',
	        	dateTimeLabelFormats: { // don't display the dummy year
	        		week: '%m/%e',
	        		day: '%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            }
	            //title: {
	            //    enabled: false
	            //},
	            //plotBands : plotBandsHigh,
	            //plotLines: plotLinesHigh
	           /* ,labels: {
	                formatter: function () {
	                	var dt = new Date(this.value);
	                	return (dt.getMonth()+1) + '.' + dt.getDate();
	                    
	                }
	            } */
	        },
	        yAxis: {
	            title: {
	                text: ''
	            }
	            
	        },
	        tooltip: {
	        	enabled:true,
	            shared: true ,
	            crosshairs: false,
	            dateTimeLabelFormats: {
	            	week: '%y/%m/%e',
	        		day: '%y/%m/%e',
	        		month: '%y/%m',
	        		year: '%y/%m/%e'
	            },
	            valueSuffix: '' ,
	            valueDecimals: 2 /* ,
	            formatter: function () {
	            	var data = getDataByUtc($("#sProject").val(), this.x);
	                return '' +  data.PHASE + '_' + data.PHASE_SEQ + ' ' + data.ANALYSYS_DATE.replace(/\//g,'.') +  '<br/>' + 
	                    '' + this.series.name + ':' + this.y + '';
	            } */
	        },
	        //legend: legend,
	        plotOptions: {
	        	series: {
	        		//cursor: 'pointer',
	                connectNulls: true // by default
	               /*  point:{
	                	events:{
	                		click: function(e){
	                			//alert('click');
	                		}
	                	}
	                } */
	            },
	            area: {
	                stacking: 'normal',
	                lineColor: '#666666',
	                lineWidth: 1,
	                marker: {
	                    lineWidth: 1,
	                    lineColor: '#666666',
	                    enabled: true
	                },
	                dataLabels: {
	                    enabled: true,
	                    format:'{point.y:.0f}'
	                },
	                trackByArea: true,
	                enableMouseTracking: true
	                /* events:{
	                	click: function(e){
	                		//this.options.pjt_id
	                		//this.options.pjt_name
	                		drawchartByProjectSite(this.name);
                		}  
	                } */
	                	
	            },
	            line: {
	            	//stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: false,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: false
	                },
	                enableMouseTracking: false
	            },
	            column: {
	            	stacking: 'normal',
	                //lineColor: 'red',
	                //lineWidth: 1,
	                marker: {
	                	enabled: true,
	                    lineWidth: 1,
	                    lineColor: '#666666'
	                },
	                dataLabels: {
	                    enabled: true
	                },
	                enableMouseTracking: true
	            }
	        },	        
	        series: series.series
	    },function(chart){
    			/*var filters = [
					{col: 'NATL_CD',val: site},
   		    		{col: 'PJT_FUNC_NAME',val: func}
   		    		
   		    	];
   				var sorts = ['NATL_NAME','PJT_FUNC_NAME','PJT_NAME','YYYYMM'];			
   				var list = getFilteredData(dataList,filters,sorts);
   				setAlldataInList(list);
   		    	drawGrid(list, gridModel_site_func_project);	*/
	    	}
		);
	}