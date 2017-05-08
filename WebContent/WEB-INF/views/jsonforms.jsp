<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en" ng-app="jsonforms-seed" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>JSONForms Seed</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="/dashboard/js/jsonforms/bower_components/bootstrap/dist/css/bootstrap.css"/>
    <!--<link rel="stylesheet" href="node_modules/jsonforms/dist/css/jsonforms.css"/>-->
    <!--<link rel="stylesheet" href="node_modules/angular-ui-grid/ui-grid.css"/>-->
	<link rel="stylesheet" href="/dashboard/js/jsonforms/bower_components/angular-ui-grid/ui-grid.css"/>

	<!-- <script src="js/jquery/jquery-1.11.2.js"></script>
    <script src="js/jquery-ui-1.11.3.custom/jquery-ui.js"></script> -->
    
    <script src="/dashboard/js/jsonforms/bower_components/angular/angular.js"  type="text/javascript"></script>
    <!--<script src="node_modules/angular-bootstrap/ui-bootstrap-tpls.js"  type="text/javascript"></script>-->
	<script src="/dashboard/js/jsonforms/bower_components/angular-bootstrap/ui-bootstrap-tpls.js"  type="text/javascript"></script>
    <!--<script src="node_modules/angular-ui-grid/ui-grid.min.js"  type="text/javascript"></script>-->
	<script src="/dashboard/js/jsonforms/bower_components/angular-ui-grid/ui-grid.min.js"  type="text/javascript"></script>
    <script src="/dashboard/js/jsonforms/bower_components/angular-ui-validate/dist/validate.js"  type="text/javascript"></script>
<!--<script src="node_modules/lodash-compat/lodash.min.js"  type="text/javascript"></script>-->
	
	<script src="/dashboard/js/jsonforms/bower_components/lodash-compat/lodash.min.js" type="text/javascript"></script>
    <!--<script src="node_modules/path-loader/browser/path-loader-min.js" type="text/javascript"></script>-->
	<script src="/dashboard/js/jsonforms/bower_components/path-loader/browser/path-loader-min.js" type="text/javascript"></script>
    <!--<script src="node_modules/traverse/traverse.js" type="text/javascript"></script>-->
	<script src="/dashboard/js/jsonforms/bower_components/js-traverse/traverse.js"  type="text/javascript"></script>
    <!--<script src="node_modules/json-refs/browser/json-refs-min.js" type="text/javascript"></script>-->
	<script src="/dashboard/js/jsonforms/bower_components/json-refs/browser/json-refs-min.js" type="text/javascript"></script>
    <script src="/dashboard/js/jsonforms/bower_components/tv4/tv4.js" type="text/javascript"></script>
    <script src="/dashboard/js/jsonforms/dist/js/jsonforms.js" type="text/javascript"></script>
     
    <script title="app">
    	'use strict';
	    var app = angular.module('jsonforms-seed', ['jsonforms']);
	    app.controller('MyController', ['$scope', 'SchemaService', 'UISchemaService', function($scope, SchemaService, UISchemaService) {
	
	        $scope.schema = SchemaService.schema;
	
	        $scope.uiSchema = UISchemaService.uiSchema; 
	
	        $scope.data = {
	            "firstName": 'John Doe',
	            //"age": 36,
	            "heigth": 1.85,
	            "gender": 'Male'
	        };
	    }]);
    </script>
    <script title="schema">
   'use strict';

    var app = angular.module('jsonforms-seed');
    app.factory('SchemaService', function() {
        return {
            schema: {
              "type": "object",
              "properties": {
                "firstName": {
                  "type": "string"
                },
                "lastName": {
                  "type": "string"
                },
                "gender": {
                  "type": "string",
                  "enum": [
                    "Male",
                    "Female"
                  ]
                },
                "active": {
                  "type": "boolean"
                },
                "timeOfRegistration": {
                  "type": "string",
                  "format": "date-time"
                },
                "weight": {
                  "type": "number"
                },
                "heigth": {
                  "type": "integer"
                },
                "nationality": {
                  "type": "string",
                  "enum": [
                    "German",
                    "French",
                    "UK",
                    "US",
                    "Spanish",
                    "Italian",
                    "Russian"
                  ]
                },
                "dateOfBirth": {
                  "type": "string",
                  "format": "date-time"
                },
                "email": {
                  "type": "string"
                },
//                 "tasks": {
//                   "type": "object",
//                   "properties": {
//                     "name": {
//                       "type": "string"
//                     },
//                     "description": {
//                       "type": "string"
//                     },
//                     "dueDate": {
//                       "type": "string",
//                       "format": "date-time"
//                     },
//                     "done": {
//                       "type": "boolean"
//                     }
//                   },
//                   "additionalProperties": false
//                 }
                "tasks": {
                    "type": "array",
                    "title" : "A list of fixed items",
                    "items": {
				        "title": "Product",
				        "type": "object",
				        "properties": {
				            "id": {
				                "description": "The unique identifier for a product",
				                "type": "number"
				            },
				            "name": {
				                "type": "string"
				            },
				            "price": {
				                "type": "number",
				                "minimum": 0,
				                "exclusiveMinimum": true
				            }
// 				            ,"tags": {
// 				                "type": "array",
// 				                "items": {
// 				                    "type": "string"
// 				                },
// 				                "minItems": 1,
// 				                "uniqueItems": true
// 				            }
// 				            ,"dimensions": {
// 				                "type": "object",
// 				                "properties": {
// 				                    "length": {"type": "number"},
// 				                    "width": {"type": "number"},
// 				                    "height": {"type": "number"}
// 				                }
// 				                ,"required": ["length", "width", "height"]
// 				            },
				        }
				        //,"required": ["id", "name", "price"]
				    },
                    "additionalProperties": false
                  } 
              },
              "additionalProperties": false,
              "required": [
                "lastName",
                "email"
              ]
            }
        }
    });
	
    </script>
    <script title="ui-schema">
   'use strict';

    var app = angular.module('jsonforms-seed');
    app.service('UISchemaService', function() {

        this.uiSchema = {
          "type": "VerticalLayout",
          "elements": [
            {
              "type": "VerticalLayout",
              "elements": [
                {
                  "type": "Group",
                  "elements": [
                    {
                      "type": "Control",
                      "label": "First Name",
                      "scope": {
                        "$ref": "#/properties/firstName"
                      }
                    },
                    {
                      "type": "Control",
                      "label": "Last Name",
                      "scope": {
                        "$ref": "#/properties/lastName"
                      }
                    },
                    {
                      "type": "Control",
                      "label": "Email",
                      "scope": {
                        "$ref": "#/properties/email"
                      }
                    },
                    {
                      "type": "Control",
                      "label": "Date Of Birth",
                      "scope": {
                        "$ref": "#/properties/dateOfBirth"
                      }
                    },
                    {
                      "type": "Control",
                      "label": "Gender",
                      "scope": {
                        "$ref": "#/properties/gender"
                      }
                    }
                  ]
                },
                {
                  "type": "Group",
                  "elements": [
                    {
                      "type": "Control",
                      "label": "Weight",
                      "scope": {
                        "$ref": "#/properties/weight"
                      }
                    },
                    {
                      "type": "Control",
                      "label": "Heigth",
                      "scope": {
                        "$ref": "#/properties/heigth"
                      }
                    },
                    {
                      "type": "Control",
                      "label": "Active",
                      "scope": {
                        "$ref": "#/properties/active"
                      }
                    },
                    {
                      "type": "Control",
                      "label": "Time Of Registration",
                      "scope": {
                        "$ref": "#/properties/timeOfRegistration"
                      }
                    },
                    {
                      "type": "Control",
                      "label": "Nationality",
                      "scope": {
                        "$ref": "#/properties/nationality"
                      }
                    }
//                     , {
//                         "type": "Control",
//                         "label": "Tasks",
//                         "scope": {
//                           "$ref": "#/properties/tasks"
//                         }
//                       }
                  ]
                }
//                 ,{
//                     "type": "Group",
//     				"label": "Tasks",
//                     "elements": [
//                       {
//                         "type": "Control",
//                         "label": "Name",
//                         "scope": {
//                           "$ref": "#/properties/tasks/#/properties/name"
//                         }
//                       },
//     				  {
//                         "type": "Control",
//                         "label": "Description",
//                         "scope": {
//                           "$ref": "#/properties/tasks/#/properties/description"
//                         }
//                       },
//     				  {
//                         "type": "Control",
//                         "label": "DueDate",
//                         "scope": {
//                           "$ref": "#/properties/tasks/#/properties/dueDate"
//                         }
//                       },
//     				  {
//                         "type": "Control",
//                         "label": "Done",
//                         "scope": {
//                           "$ref": "#/properties/tasks/#/properties/done"
//                         }
//                       }
//                     ]
//                   }


//                 ,{
//                     "type": "Group",
//     				//"label": "Tasks",
//                     "elements": [
//                       {
//                         "type": "Control",
//                         //"label": "tasks",
//                         "scope": {
//                           "$ref": "#/properties/tasks"
//                         }
//                       }
//                     ]
//                   }

    			  
    			  ,{
    				"type": "Control",
    				"label": "Task Name",
    				"scope": {
    				  "$ref": "#/properties/tasks/"
    				}
    			  }
    			  
    			  
    			  
              ]
            }
//             ,{
//               "type": "Control",
//               "label": "Tasks",
//               "scope": {
//                 "$ref": "#/properties/tasks"
//               } 
//             }
          ]
        };

    });

    </script>
	<script>
	// 
	
		var testSchema = {
			"type" : "object",
			"properties" : {
				"listOfStrings" : {
					"type" : "array",
					"title" : "A list of strings",
					"items" : {
						"type" : "string",
						"default" : "bazinga"
					}
				},
				"multipleChoicesList" : {
					"type" : "array",
					"title" : "A multiple choices list",
					"items" : {
						"type" : "string",
						"enum" : [ "foo", "bar", "fuzz", "qux" ]
					},
					"uniqueItems" : true
				},
				"fixedItemsList" : {
					"type" : "array",
					"title" : "A list of fixed items",
					"items" : [ {
						"title" : "A string value",
						"type" : "string",
						"default" : "lorem ipsum"
					}, {
						"title" : "a boolean value",
						"type" : "boolean"
					} ],
					"additionalItems" : {
						"title" : "Additional item",
						"type" : "number"
					}
				},
				"nestedList" : {
					"type" : "array",
					"title" : "Nested list",
					"items" : {
						"type" : "array",
						"title" : "Inner list",
						"items" : {
							"type" : "string",
							"default" : "lorem ipsum"
						}
					}
				}
			}
		};
	
	
		var testUiSchema = {
			"multipleChoicesList" : {
				"ui:widget" : "checkboxes"
			},
			"fixedItemsList" : {
				"items" : [ {
					"ui:widget" : "textarea"
				}, {
					"ui:widget" : "select"
				} ],
				"additionalItems" : {
					"ui:widget" : "updown"
				}
			}
		}
	</script>
</head>
<body>
<div class="container" ng-controller="MyController">
    <div class="row" id="demo">
        <div class="col-sm-12">
            <div class="panel-primary panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><strong>JSONForms Seed</strong></h3>
                </div>
                <div class="panel-body jsf" style="line-height: 2.0">
                    Bound data: {{data}}
                    <jsonforms schema="schema" ui-schema="uiSchema" data="data"/>
                </div>
            </div>
        </div>
    </div>
</div> <!-- /container -->
</body>
</html>
