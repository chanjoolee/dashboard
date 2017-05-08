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
            }
            ,{
                "type": "Group",
				"label": "Tasks",
                "elements": [
                  {
                    "type": "Control",
                    "label": "Name",
                    "scope": {
                      "$ref": "#/properties/tasks/#/properties/name"
                    }
                  },
				  {
                    "type": "Control",
                    "label": "Description",
                    "scope": {
                      "$ref": "#/properties/tasks/#/properties/description"
                    }
                  },
				  {
                    "type": "Control",
                    "label": "DueDate",
                    "scope": {
                      "$ref": "#/properties/tasks/#/properties/dueDate"
                    }
                  },
				  {
                    "type": "Control",
                    "label": "Done",
                    "scope": {
                      "$ref": "#/properties/tasks/#/properties/done"
                    }
                  }
                ]
              }
			  
			  /*,{
				"type": "Control",
				"label": "Task Name",
				"scope": {
				  "$ref": "#/properties/tasks/#/properties/name"
				}
			  }*/
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
