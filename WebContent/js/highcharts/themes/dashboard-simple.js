/**
 * Grid-light theme for Highcharts JS
 * @author Torstein Honsi
 */

// Load the fonts
Highcharts.createElement('link', {
	href: 'http://fonts.googleapis.com/css?family=Dosis:400,600',
	rel: 'stylesheet',
	type: 'text/css'
}, null, document.getElementsByTagName('head')[0]);

Highcharts.theme = {
	
	chart: {
		backgroundColor: null,
		style: {
			fontFamily: "Malgun Gothic"
		},
		events:{
			click: function(){
				// hs.Expand 두번뜨는것 방지
				for(var i=0 ;i<hs.expanders.length;i++){
					if(hs.expanders[i] == null)
						continue;
					else
						hs.expanders[i].close();
				}
			},
			
			load: function(){
				// 슬라이드를 모두 지운다.
				for(var i=0 ;i<hs.expanders.length;i++){
					if(hs.expanders[i] == null)
						continue;
					else
						hs.expanders[i].close();
				}
			}
		}
	},
	title: {
		style: {
			fontSize: '12px',
			fontWeight: 'bold'
			//textTransform: 'uppercase'
		}
	},
	tooltip: {
		borderWidth: 0,
		backgroundColor: 'rgba(219,219,216,0.8)',
		shadow: false
	},
	legend: {
		itemStyle: {
			fontWeight: 'bold',
			fontSize: '11px'
		}
	},
	xAxis: {
		//gridLineWidth: 1,
		labels: {
			style: {
				fontSize: '8px' ,
				fontWeight: 'bold'
			}
		}
		
	},
	yAxis: {
		//minorTickInterval: 'auto',
		title: {
			style: {
				textTransform: 'none'
			}
		},
		labels: {
			style: {
				fontSize: '8px'
			}
		}
	},
	plotOptions: {
		/*candlestick: {
			lineColor: '#404048'
		}*/
	}//,


	// General
	//background2: '#F0F0EA'
	
};

// Apply the theme
Highcharts.setOptions(Highcharts.theme);

