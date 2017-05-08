(function (H) {
         var noop = function () {},
         defaultOptions = H.getOptions(),
             each = H.each,
             extend = H.extend,
             format = H.format,
             wrap = H.wrap,
             Chart = H.Chart,
             seriesTypes = H.seriesTypes,
             PieSeries = seriesTypes.pie,
             ColumnSeries = seriesTypes.column,
             fireEvent = HighchartsAdapter.fireEvent,
             inArray = HighchartsAdapter.inArray;

         H.wrap(H.Chart.prototype, 'drillUp', function (proceed) {

             var chart = this,
                 drilldownLevels = chart.drilldownLevels,
                 levelNumber = drilldownLevels[drilldownLevels.length - 1].levelNumber,
                 i = drilldownLevels.length,
                 chartSeries = chart.series,
                 seriesI = chartSeries.length,
                 level,
                 oldSeries,
                 newSeries,
                 oldExtremes,
                 addSeries = function (seriesOptions) {
                     var addedSeries;
                     each(chartSeries, function (series) {
                         if (series.userOptions === seriesOptions) {
                             addedSeries = series;
                         }
                     });

                     addedSeries = addedSeries || chart.addSeries(seriesOptions, false);
                     if (addedSeries.type === oldSeries.type && addedSeries.animateDrillupTo) {
                         addedSeries.animate = addedSeries.animateDrillupTo;
                     }
                     if (seriesOptions === level.seriesOptions) {
                         newSeries = addedSeries;
                     }
                 };

            
             while (i--) {

                 level = drilldownLevels[i];
                  console.log(level.levelNumber);
                 console.log(levelNumber);
                 if (level.levelNumber === levelNumber) {
                     drilldownLevels.pop();

                     // Get the lower series by reference or id
                     oldSeries = level.lowerSeries;

                     if ($.isArray(oldSeries)) {
                        
        if (chart.series) {
            while (chart.series.length > 0) {
                chart.series[0].remove(false);
            }
        }


                         if (level.levelSubtitle) {
                             chart.setTitle(null, {text: level.levelSubtitle});
                         } else {
                             chart.setTitle(null, {
                                 text: ''
                             });
                         }

                         if (chart.xAxis && level.levelXAxis) {
                             while (chart.xAxis.length > 0) {
                                 chart.xAxis[0].remove(false);
                             }
                         }
                         if (chart.yAxis && level.levelYAxis) {
                             while (chart.yAxis.length > 0) {
                                 chart.yAxis[0].remove(false);
                             }
                         }

                         if (level.levelYAxis) {
                             $.each(level.levelYAxis, function () {
                                 chart.addAxis(this, false, false);
                             });
                         }
                         if (level.levelXAxis) {
                             $.each(level.levelXAxis, function () {
                                 chart.addAxis(this, true, false);
                             });
                         }
                         $.each(level.levelSeriesOptions, function () {
                             chart.addSeries(this, false);
                         });
                    

                     } else {
                         if (!oldSeries.chart) { // #2786
                             while (seriesI--) {
                                 if (chartSeries[seriesI].options.id === level.lowerSeriesOptions.id) {
                                     oldSeries = chartSeries[seriesI];
                                     break;
                                 }
                             }
                         }
                         oldSeries.xData = []; // Overcome problems with minRange (#2898)

                         each(level.levelSeriesOptions, addSeries);

                         fireEvent(chart, 'drillup', {
                             seriesOptions: level.seriesOptions
                         });

                         if (newSeries.type === oldSeries.type) {
                             newSeries.drilldownLevel = level;
                             newSeries.options.animation = chart.options.drilldown.animation;

                             if (oldSeries.animateDrillupFrom) {
                                 oldSeries.animateDrillupFrom(level);
                             }
                         }

                         newSeries.levelNumber = levelNumber;

                         oldSeries.remove(false);

                         // Reset the zoom level of the upper series
                         if (newSeries.xAxis) {
                             oldExtremes = level.oldExtremes;
                             newSeries.xAxis.setExtremes(oldExtremes.xMin, oldExtremes.xMax, false);
                             newSeries.yAxis.setExtremes(oldExtremes.yMin, oldExtremes.yMax, false);
                         }

                     }
                 }
             }

             this.redraw();

 
             if (this.drilldownLevels.length === 0) {
                 console.log('destroy');
                 this.drillUpButton = this.drillUpButton.destroy();
             } else {
                 console.log('no destroy '+this.drilldownLevels.length);
                 this.drillUpButton.attr({
                     text: this.getDrilldownBackText()
                 })
                     .align();
             }

         });

         H.wrap(H.Chart.prototype, 'addSingleSeriesAsDrilldown', function (proceed, point, ddOptions) {

             if (!ddOptions.series) {
                 proceed.call(this, point, ddOptions);
             } else {

                 var thisChart = this;

                 var oldSeries = point.series,
                     xAxis = oldSeries.xAxis,
                     yAxis = oldSeries.yAxis,
                     color = point.color || oldSeries.color,
                     pointIndex,
                     levelSeries = [],
                     levelSeriesOptions = [],
                     levelXAxis = [],
                     levelYAxis = [],
                     levelSubtitle,
                     level,
                     levelNumber;

                 levelNumber = oldSeries.levelNumber || 0;

             //    ddOptions.series[0] = extend({
              //       color: color
             //    }, ddOptions.series[0]);
             //    pointIndex = inArray(point, oldSeries.points);

                 // Record options for all current series
                 each(oldSeries.chart.series, function (series) {
                     if (series.xAxis === xAxis) {
                         levelSeries.push(series);
                         levelSeriesOptions.push(series.userOptions);
                         series.levelNumber = series.levelNumber || 0;
                     }
                 });

                 each(oldSeries.chart.xAxis, function (xAxis) {
                     levelXAxis.push(xAxis.userOptions);
                 });

                 each(oldSeries.chart.yAxis, function (yAxis) {
                     levelYAxis.push(yAxis.userOptions);
                 });

                    
                 if(oldSeries.chart.subtitle && oldSeries.chart.subtitle.textStr){
                     levelSubtitle = oldSeries.chart.subtitle.textStr;
                     console.log(levelSubtitle);
                 }

                 // Add a record of properties for each drilldown level
                 level = {
                     levelNumber: levelNumber,
                     seriesOptions: oldSeries.userOptions,
                     levelSeriesOptions: levelSeriesOptions,
                     levelSeries: levelSeries,
                     levelXAxis: levelXAxis,
                     levelYAxis: levelYAxis,
                     levelSubtitle: levelSubtitle,
                     shapeArgs: point.shapeArgs,
                     bBox: point.graphic.getBBox(),
                     color: color,
                     lowerSeriesOptions: ddOptions,
                     pointOptions: oldSeries.options.data[pointIndex],
                     pointIndex: pointIndex,
                     oldExtremes: {
                         xMin: xAxis && xAxis.userMin,
                         xMax: xAxis && xAxis.userMax,
                         yMin: yAxis && yAxis.userMin,
                         yMax: yAxis && yAxis.userMax
                     }
                 };

                 // Generate and push it to a lookup array
                 if (!this.drilldownLevels) {
                     this.drilldownLevels = [];
                 }
                 this.drilldownLevels.push(level);

                 level.lowerSeries = [];

                 if (ddOptions.subtitle) {
                     this.setTitle(null, {text: ddOptions.subtitle});
                 }else{
                     this.setTitle(null, {text: ''});
                 }

                 if (this.xAxis && ddOptions.xAxis) {
                     while (this.xAxis.length > 0) {
                         this.xAxis[0].remove(false);
                     }
                 }
                 if (this.yAxis && ddOptions.yAxis) {
                     while (this.yAxis.length > 0) {
                         this.yAxis[0].remove(false);
                     }
                 }
                 

                 if (ddOptions.yAxis) {
                     if ($.isArray(ddOptions.yAxis)) {
                         $.each(ddOptions.yAxis, function () {
                             thisChart.addAxis(this, false, false);
                         });
                     } else {
                         thisChart.addAxis(ddOptions.yAxis, false, false);
                     }
                 }
                 if (ddOptions.xAxis) {
                     if ($.isArray(ddOptions.xAxis)) {
                         $.each(ddOptions.xAxis, function () {
                             thisChart.addAxis(this, true, false);
                         });
                     } else {
                         thisChart.addAxis(ddOptions.xAxis, true, false);
                     }

                 }



                 $.each(ddOptions.series, function () {

                     var newSeries = thisChart.addSeries(this, true);
                     level.lowerSeries.push(newSeries);
                     newSeries.levelNumber = levelNumber + 1;
         //            if (xAxis) {
        //                 xAxis.oldPos = xAxis.pos;
           //              xAxis.userMin = xAxis.userMax = null;
            //             yAxis.userMin = yAxis.userMax = null;
              //       }

                //     // Run fancy cross-animation on supported and equal types
                 //    if (oldSeries.type === newSeries.type) {
                  //       newSeries.animate = newSeries.animateDrilldown || noop;
                  //       newSeries.options.animation = true;
                   //  }
                 });
 


             }
         });

         H.wrap(H.Point.prototype, 'doDrilldown', function (proceed, _holdRedraw) {

             if (!$.isPlainObject(this.drilldown)) {
                 proceed.call(this, _holdRedraw);
             } else {
                 var ddChartConfig = this.drilldown;
                 console.log(ddChartConfig);
                 var ddSeries = ddChartConfig.series;

                 var series = this.series;
                 var chart = series.chart;
                 var drilldown = chart.options.drilldown;

                 var seriesObjs = [];
                 for (var i = 0; i < ddSeries.length; i++) {
                     if (!$.isPlainObject(ddSeries[i])) {
                         console.log(ddSeries[i]);
                         var j = (drilldown.series || []).length;
                         var seriesObj = null;
                         while (j-- && !seriesObj) {
                             if (drilldown.series[j].id === ddSeries[i]) {
                                 seriesObj = drilldown.series[j];
                             }
                         }
                         if (seriesObj) {
                             seriesObjs.push(seriesObj);
                         }
                     } else {
                         seriesObjs.push(ddSeries[i]);
                     }
                 }

                 ddChartConfig.series = seriesObjs;
                 ddSeries = ddChartConfig.series;

                 // Fire the event. If seriesOptions is undefined, the implementer can check for 
                 // seriesOptions, and call addSeriesAsDrilldown async if necessary.
                 HighchartsAdapter.fireEvent(chart, 'drilldown', {
                     point: this,
                     seriesOptions: ddChartConfig
                 });

                 if (ddChartConfig) {
                     if (_holdRedraw) {
                         chart.addSingleSeriesAsDrilldown(this, ddChartConfig);
                     } else {
                         chart.addSeriesAsDrilldown(this, ddChartConfig);
                     }
                 }
             }

         });
     }(Highcharts));