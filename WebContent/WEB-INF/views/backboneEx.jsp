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
                // this.fetch({
                //     success: this.fetchSuccess,
                //     error: this.fetchError
                // });
                // this.deferred = new $.Deferred();
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
        
        
        
        var Corona = Backbone.Model.extend({
            
        });    
        var Coronas = Backbone.Collection.extend({
            model : Corona,
            url:'/dashboard/genericlListPageJson.html?sqlid=dashboard.corona.detail.last&paging_sqlid=dashboard.corona.detail.last.page&rows=20&page=2&sample=Armstrong3D_S36_128Gb_128GB&firmware=U3AE351C7B14',
            parse: function(data){
                return data.rows;
            }
        });

        var DocumentRow = Backbone.View.extend({
            tagName: "li",
            className : "document-row",
            events: {
                "click .icon":          "open",
                "click .button.edit":   "openEditDialog",
                "click .button.delete": "destroy"
            },
            initialize: function() {
                this.listenTo(this.model, "change", this.render);
            }
        });
        var coronas = new Coronas();
        coronas.fetch();
    
    
    
    
    
    </script>
</body>
</html>