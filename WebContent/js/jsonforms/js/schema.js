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
