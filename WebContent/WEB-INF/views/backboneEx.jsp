<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
	<title>Insert title here</title>
	<link rel="stylesheet" href="/dashboard/js/jointjs/joint.css" />
    <script src="/dashboard/js/jointjs/jquery.min.js"></script>
    <script src="/dashboard/js/jointjs/lodash.min.js"></script>
    <!-- <script src="/dashboard/js/jointjs/backbone-min.js"></script> -->
    <script src="/dashboard/js/jointjs/backbone.js"></script>
    <script src="/dashboard/js/jointjs/joint.js"></script>
    <script src="/dashboard/js/test/test.js"></script>
</head>
<body>
	<div id="myholder"></div>
	<div id="myholder-small"></div>
	<script type="text/javascript">
	// lodash template test
    _.templateSettings = {
	    interpolate: /\<\@\=(.+?)\@\>/gim,
	    evaluate: /\<\@(.+?)\@\>/gim,
	    escape: /\<\@\-(.+?)\@\>/gim
	};
    //var compiled = _.template("hello:<@=name@>");
    //console.log(compiled({name:'chanjoo'}));
	
    //**** backboneTest ****//
    var project = Backbone.Model.extend({
    	idAttribute: 'PJT_CODE'
	});    
    
    var projects = Backbone.Collection.extend({
        model: project,
        url: '/dashboard/rest/backbone',
        initialize: function () {
//             this.fetch({
//                 success: this.fetchSuccess,
//                 error: this.fetchError
//             });
//             this.deferred = new $.Deferred();
				this.fetch();
        },
        deferred: Function.constructor.prototype,
        fetchSuccess: function (collection, response) {
            collection.deferred.resolve();
        },
        fetchError: function (collection, response) {
            throw new Error("Products fetch did get collection from API");
        }, 
        parse : function(response) {
            return response.list;
        }
    });

    var projects = new projects();
    
    
    
	</script>
</body>
</html>