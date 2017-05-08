<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script>
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
              ]
            },
            {
            	"type":"Group",
            	"elements":[
					{
						"type":"Control",
						"label": "Task Name",
						"scope": {
		                    "$ref": "#/properties/tasks/properties/name"
		                 }
					}            		
            	]
            }
          ]
        }/*,
        {
          "type": "Control",
          "label": "Tasks",
          "scope": {
            "$ref": "#/properties/tasks"
          } 
        }*/
      ]
    };

});


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
            "tasks": {
              "type": "object",
              "properties": {
                "name": {
                  "type": "string"
                },
                "description": {
                  "type": "string"
                },
                "dueDate": {
                  "type": "string",
                  "format": "date-time"
                },
                "done": {
                  "type": "boolean"
                }
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
</head>
<body>

</body>
</html>