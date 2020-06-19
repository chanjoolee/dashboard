		jpaFiles.push({
			"fileType": "jsp",
			"editType": "general",
			"fileName": "rmTabCols",
			"entityId": "rm_tab_cols",
			"schema": {
				"search": {
					"name": "v_schema_search",
					"containerId": "v_schema_searchContainer",
					"schema": {
						"type": "Vertical",
						"id": "searchConditionHorizontalLayout",
						"name": "searchConditionHorizontalLayout",
						"label": "",
						"elements": [
							{
								"label": "",
								"type": "HorizontalLayout",
								"cls": "",
								"containerCls": "no-gutters row",
								"elements": [
									{
										"label": "",
										"id": "searchVertical",
										"type": "Vertical",
										"containerCls": "col-sm-10",
										"elements": [
											{
												"label": "",
												"type": "HorizontalLayout",
												"id": "searchHorizontalLayout",
												"name": "searchHorizontalLayout",
												"containerCls": "no-gutters row",
												"containerCss": [
													{
														"code": "width",
														"value": "100%"
													}
												],
												"elements": []
											}
										]
									},
									{
										"label": "",
										"type": "HorizontalLayout",
										"containerCls": "col-sm-2",
										"elements": [
											{
												"type": "ButtonBootstrap",
												"id": "btnSearch",
												"name": "btnSearch",
												"label": "SEARCH",
												"events": {
													"click": function(){
													                                                // fn_search();
													                                                this.htmlMaker.instance.fn_search();
													                                            }

												}
											}
										]
									}
								]
							}
						]
					}
				},
				"contents": {
					"name": "v_schema_content",
					"containerId": "v_schema_contentContainer",
					"schema": {
						"type": "Vertical",
						"id": "contentVertical",
						"name": "contentVertical",
						"label": "",
						"elements": [
							{
								"type": "grid",
								"id": "rmTabColsGrid",
								"name": "rmTabColsGrid",
								"label": "",
								"text": "Rm_tab_cols",
								"sqlId": "rmTabCols.rmTabCols",
								"entityId": "rm_tab_cols",
								"containerCss": [
									{
										"code": "width",
										"value": "100%"
									},
									{
										"code": "margin-top",
										"value": "10px"
									},
									{
										"code": "background-color",
										"value": "#FFF"
									}
								],
								"gridOpt": {
									"datatype": "json",
									"pager": "#rmTabColsGridPager",
									"sqlId": "rmTabCols.rmTabCols",
									"gridId": "rmTabColsGrid",
									"modelVarName": "thenetJpa",
									"url": function(){ 
									                    return	"./genericlListPageJson.html?" + 
									                        $("#form").serialize() + 
									                        "&sqlid=rmTabCols.rmTabCols.page.list" +  
									                        "&paging_sqlid=rmTabCols.rmTabCols.page.total" 
									                },

									"editurl": "./ssdCusDummySaveJson.html",
									"styleUI": "Bootstrap",
									"viewrecords": true,
									"width": "100%",
									"autowidth": true,
									"height": 650,
									"multiselect": false,
									"multiboxonly": true,
									"multiSort": true,
									"rowNum": 20,
									"rowList": [
										5,
										10,
										15,
										20,
										30
									],
									"emptyrecords": "No records to view",
									"subGrid": false,
									"subgridtype": "json",
									"entityId": "rm_tab_cols",
									"subGridRowExpanded": function(parentRowID, parentRowKey){
									                        var theGrid = $(this).jqGrid();
									                        var row = theGrid.jqGrid('getRowData',parentRowKey);
									                        var cms = theGrid.jqGrid("getGridParam", "colModel");
									                        var searchRow = {};
									                        var vGridOpt  = theGrid.getGridParam();
									                        
									                        $.each(row,function(k,v){
									                            // searchRow['search_' + _.camelCase(k)] = v;
									                        });
									                        var vKeys = [];
									                        // var models = eval(vGridOpt.modelVarName);
									                        // var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
									                        
									                        $.each([].concat(vGridOpt.gridProperties), function(i, prop){
									                            let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] ,{"_xsi:type" : "gmmjpa:Id"});
									                            if (vId != null){
									                                vKeys.push(prop._name.toUpperCase());
									                                searchRow['search_' + _.camelCase(prop._name)] = row[prop._name.toUpperCase()];
									                            }
									                        });
									    
									                        // ***  grid ***//
									                        var childDivId = parentRowID + "_div_input";
									                        var childDiv = $(document.createElement("div"));
									                        childDiv.attr("id",childDivId);
									                        // add a table and pager HTML elements to the parent grid row - we will render the child grid here			    			
									                        $('#' + parentRowID).append(childDiv);
									    
									                        var detailList = [];
									                        $.ajax({
									                            type: "POST",
									                            url: "./genericlListJson.html?sqlid=rmTabCols.rmTabCols.one" ,
									                            data: searchRow ,
									                            //data: $("#form").serialize(), 
									                            async: false,
									                            success:  function(response){
									                                detailList  = response.dataList;                            
									                            }
									                        });
									                        
									                        if (detailList.length == 0 ){
									                            childDiv.text("no data");
									                            return;
									                        }
									    
									                        var schema1 = {
									                            containerId: childDivId,
									                            type:'Vertical',
									                            label: '',
									                            elements: [
									                                {
									                                    label: "",
									                                    type: 'Group',
									                                    elements: [
									                                        {
									                                            type: "inline_edit",
									                                            cols: 1,
									                                            data: function(){ 
									                                                return detailList[0];
									                                            },
									                                            options : {
									                                                keys : vKeys ,
									                                                fn_change: function( input ){
									                                                    //
									                                                    // if(this.props.options.name == 'SCRIPT_NAME'){
									                                                    // 	var convert = this.reactObjects.find(function(td){
									                                                    // 		return td.props.options.name == 'CONVERT_SCRIPT';
									                                                    // 	});	
									                                                    // 	//convert digit
									                                                    // 	//var v_hax = this.state.value;
									                                                    // 	var v_hax = input;
									                                                    // 	var v_digit = [];
									                                                    // 	$.each(v_hax.split(" "), function(i,str){
									                                                    // 		var d = "";
									                                                    // 		if(str.startsWith("0x")){
									                                                    // 			v_digit.push(parseInt(str,16));
									                                                    // 		}else{
									                                                    // 			v_digit.push(str);
									                                                    // 		}
									                                                    // 	});																		
									                                                    // 	convert.setState({value : v_digit.join(" ")});
									                                                        
									                                                    // }
									                                                    
									                                                },
									                                                fn_submit: function(){
									                                                    //alert("submit function defined");
									                                                    var state = true;
									                                                    var paramObj = {
									                                                        //origindatas: this.props.options.keys
									                                                        origindatas: this.state.keys
									                                                    };
									                                                    
									                                                    if(this.props.options.value == this.state.value)
									                                                        return state;
									                                                    $.ajax({
									                                                        url: "./genericSaveJson.html",
									                                                        type: "POST",
									                                                        data: {
									                                                            searchJson: JSON.stringify(paramObj),
									                                                            fieldName: this.state.name,
									                                                            fieldValue: this.state.value,
									                                                            fieldValueOrigin: this.state.value_origin,
									                                                            userId: $("#userId").val(),
									                                                            // sqlid: "dashboard.ssd_sm.script_master.update"
									                                                            sqlid: "rmTabCols.rmTabCols.edit"
									                                                        }, 
									                                                        async: false,			                    		
									                                                        success:  function(data){
									                                                            response1 = data;
									                                                            if(response1.result != 'success'){
									                                                                state = false;
									                                                                msg = "Save Success!";
									                                                                $("#dialog-confirm").html(response1.message);
									                                                                $("#dialog-confirm").dialog({
									                                                                    resizable: false,
									                                                                    modal: true,
									                                                                    title: "Error",
									                                                                    //height: 200,
									                                                                    width: 300,
									                                                                    dialogClass: 'no-close',
									                                                                    closeOnEscape: false,
									                                                                    buttons: [
									                                                                        {
									                                                                            text: "OK",
									                                                                            click: function() {
									                                                                            $( this ).dialog( "close" );											                    			                  
									                                                                            }
									                                                                        }
									                                                                    ]
									                                                                });
									                                                                
									                                                                
									                                                                
									                                                            }						                    			
									                                                        }
									                                                    });
									                                                    
									                                                    return state;
									                                                },
									                                                fn_afterSubmit: function(keyUpdatedObjects){
									                                                    
									                                                    $.each(this,function(i,react){
									                                                        if(_.find(cms,function(cm){return cm.name == react.state.name})){
									                                                            var vobject = {};
									                                                            vobject[react.state.name] = react.state.value;
									                                                            theGrid.setRowData(parentRowKey,vobject);
									                                                        }
									                                                        
									                                                    });
									                                                    
									                                                },
									                                                progressObject: parent.$("#loader")
									                                            },
									                                            items: _.map([].concat(gridProperties), function(prop){
									                                                var _cms = cms;
									                                                var rtnObj = {
									                                                    label : _.capitalize(_.upperCase(prop._name)),
									                                                    col : prop._name.toUpperCase() 
									                                                };
									                                                let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] ,{"_xsi:type" : "gmmjpa:Id"});
									                                                if (vId != null){
									                                                    rtnObj.editable = false;
									                                                }
									    
									                                                // list hiden columns
									                                                if ( prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" ){
									                                                    rtnObj.isDateTime = true;
									                                                }
									                                                var vEdit = _.find(prop.eAnnotations.details,{"_key":"edit_tag"});
									                                                if(vEdit != null){
									                                                    rtnObj.edit_tag = vEdit._value;
									                                                }
									    
									                                                var cm = _.find(_cms , {id: rtnObj.col});
									                                                if ( cm != null && cm.editoptions != undefined && cm.editoptions.value != undefined ) {
									    
									                                                    // rtnObj.selectOptions = cm.editoptions.value;
									                                                    var options = [];
									                                                    $.each(cm.editoptions.value, function (k, v) {
									                                                        var opt = {value: k, label: v};
									                                                        options.push(opt);
									                                                    });
									                                                    rtnObj.selectOptions = options;
									                                                    rtnObj.edit_tag = cm.edittype;
									                                                    if (parentFrame.v_filterPop[rtnObj.col] != null ){
									                                                        rtnObj.edit_tag = 'input';
									                                                        rtnObj.editable = false;
									                                                    }
									                                                }
									                                                return rtnObj;
									                                            })
									                                            
									                                        }
									                                        
									                                    
									                                    ]
									                                }
									                                
									                            
									                            ]
									                        };
									                        fn_makeHtml(childDiv,schema1);
									    
									    
									    
									                    }

								},
								"items": [
									{
										"label": "Table name",
										"name": "TABLE_NAME",
										"id": "TABLE_NAME",
										"align": "center",
										"entityName": "rm_tab_cols",
										"editable": true,
										"gridId": "rmTabColsGrid",
										"editrules": {
											"edithidden": true
										},
										"required": true,
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();
										                        // var models = eval(vGridOpt.modelVarName);
										                        // var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
										                        var result = " class='contextMenu contextMenu-child'";
										                        result += " style='vertical-align: middle;";
										                        // blue
										                        // result += "color: #009eff;font-weight: bolder;cursor:pointer;'";
										                        result += "cursor:pointer;'";
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Column name",
										"name": "COLUMN_NAME",
										"id": "COLUMN_NAME",
										"align": "center",
										"entityName": "rm_tab_cols",
										"editable": true,
										"gridId": "rmTabColsGrid",
										"editrules": {
											"edithidden": true
										},
										"required": true,
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();
										                        // var models = eval(vGridOpt.modelVarName);
										                        // var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
										                        var result = " class='contextMenu contextMenu-child'";
										                        result += " style='vertical-align: middle;";
										                        // blue
										                        // result += "color: #009eff;font-weight: bolder;cursor:pointer;'";
										                        result += "cursor:pointer;'";
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									}
								]
							}
						]
					}
				}
			},
			"gridProperties": [
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "table_name",
					"__prefix": null,
					"isKey": true,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "column_name",
					"__prefix": null,
					"isKey": true,
					"_documentation": {}
				}
			],
			"dataSources": [],
			"childReferences": [
				{
					"referenceId": "reference::rm_tab_cols::undefined",
					"parentEntityName": "rm_tab_cols",
					"parent_columns": [
						"table_name",
						"column_name"
					],
					"child_columns": [
						"table_name",
						"column_name"
					]
				},
				{
					"referenceId": "reference::rm_tab_cols::rm_cmm_use",
					"parentEntityName": "rm_tab_cols",
					"childEntityName": "rm_cmm_use",
					"childEntityId": "rm_cmm_use",
					"parent_columns": [
						"table_name",
						"column_name"
					],
					"child_columns": [
						"table_name",
						"column_name"
					]
				}
			],
			"dictionaries": [
				{
					"entityName": "rm_tab_cols",
					"sqlId": "rmTabCols.dictionary.rmTabCols",
					"dictionaryDefTable": "rm_cmm_cd",
					"dictionaryUseTable": "rm_cmm_use",
					"categoryColumn": "code_category",
					"codeColumn": "code_id",
					"nameColumn": "code_nm",
					"data": function () {
					                var _this = this;
					                $.ajax({
					                    type: "POST",
					                    url: "./genericlListJson.html?" +
					                        "&sqlid=" + _this.sqlId,
					                    data: {},
					                    async: false,
					                    success: function (response) {
					                        var dataList = response.dataList;
					                        $.each(dataList, function (i, data) {
					                            if( data != null)
					                                _this.value.push(data);
					                        });
					                    }
					                });
					            },

					"value": []
				}
			],
			"entity_doc_obj": {
				"customFunc": {},
				"dbType": "mysql",
				"entityId": "rmTabCols"
			},
			"entity_sql_prefix": "",
			"commonFunc": {
				"sqlId": "rmTabCols.rmTabCols"
			},
			"popParemeters": {}
		});