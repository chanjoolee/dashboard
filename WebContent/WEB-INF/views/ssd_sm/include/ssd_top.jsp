<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" type="text/css" href="css/ssd/common.css"/>
<link rel="stylesheet" type="text/css" href="css/ssd/layout.css"/>
<link rel="stylesheet" type="text/css" href="css/ssd/btn01.css"/>
<link rel="stylesheet" type="text/css" href="css/ssd/board01.css"/>
<link rel="stylesheet" type="text/css" href="css/ssd/table01.css"/>
<link rel="stylesheet" type="text/css" href="css/ssd/object.css"/>
<link rel="stylesheet" type="text/css" href="css/ssd/popup.css"/>
<script type="text/javascript" src="js/ssd/css.browser.detect.js" ></script>
<script type="text/javascript" src="js/ssd/jquery-1.9.1.min.js" ></script>
<script type="text/javascript" src="js/ssd/jquery-ui.min.js" ></script>
<!-- <script type="text/javascript" src="js/ssd/jquery.form.js" ></script> -->
<script type="text/javascript" src="js/ssd/jquery.ui.js" ></script>
<script type="text/javascript" src="js/ssd/ssd.pagination.js" ></script>



<%-- 1. jquery --%>
<script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/jquery-1.11.0.min.js"></script>
<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="js/jquery-ui-1.11.3.custom/jquery-ui.css" />

<%-- 2. handsontable grid --%>
<script src="js/ssd/select2.js"></script>
<link href="css/ssd/select2.css" rel="stylesheet" />



<link rel="stylesheet" type="text/css" href="css/ssd/handsontable.full.min.css">
<!-- <link rel="stylesheet" type="text/css" href="css/ssd/main.css"> -->
<script src="js/ssd/handsontable.full.js"></script> 
<!-- <script src="https://docs.handsontable.com/pro/4.0.0/components/handsontable-pro/dist/handsontable.full.min.js"></script> -->
<script src="js/ssd/select2-editor.js"></script>

<%-- jqgrid --%>
<script type="text/javascript" src="js/jqGrid_JS_5.1.0/js/i18n/grid.locale-en.js" ></script>
<script type="text/javascript" src="js/jqGrid_JS_5.1.0/src/jquery.jqGrid.js?version=2018.02.23"></script>    

<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>

<script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script>

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

<link rel="stylesheet" media="screen" href="js/jqGrid_JS_5.1.0/css/ui.jqgrid-bootstrap.css" type="text/css" />


<%-- 2. high charts --%>
		<!--<script src="/dashboard/js/Highcharts-5.0.7/code/highcharts.src.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/highcharts-more.src.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/modules/drilldown.src.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/modules/no-data-to-display.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/modules/exporting.src.js"></script>
		<script src="/dashboard/js/Highcharts-5.0.7/code/modules/offline-exporting.src.js"></script> -->
		
		<script src="/dashboard/js/Highstock-5.0.9/code/highstock.src.js"></script>
		<script src="/dashboard/js/Highstock-5.0.9/code/modules/heatmap.src.js"></script>
		<script src="/dashboard/js/Highstock-5.0.9/code/highcharts-more.src.js"></script>
		<script src="/dashboard/js/Highstock-5.0.9/code/modules/drilldown.src.js"></script>
		<script src="/dashboard/js/Highstock-5.0.9/code/modules/no-data-to-display.js"></script>
		<script src="/dashboard/js/Highstock-5.0.9/code/modules/exporting.src.js"></script>
		<script src="/dashboard/js/Highstock-5.0.9/code/modules/offline-exporting.src.js"></script>
		

<%-- 4. local common --%>
<script src="/dashboard/js/dashboard.js?version=2018.02.23.01"></script>

<%-- multi select --%>
		<script src="/dashboard/js/jquery-multiselect/jquery.multiselect.js"></script>
		<script src="/dashboard/js/jquery-multiselect/src/jquery.multiselect.filter.js"></script>
		<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.css" />
		<link rel="stylesheet" type="text/css" href="/dashboard/js/jquery-multiselect/jquery.multiselect.filter.css" />
		<!-- <link rel="stylesheet" type="text/css" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1/themes/ui-lightness/jquery-ui.css" /> -->
		<script src="/dashboard/js/jmespath.js-master/jmespath.js?version=1"></script>
		
<%-- Util --%>
<script src="/dashboard/js/jointjs/lodash.4.17.10.js"></script>