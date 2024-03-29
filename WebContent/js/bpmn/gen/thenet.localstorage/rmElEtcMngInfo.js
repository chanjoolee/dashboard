		jpaFiles.push({
			"fileType": "jsp",
			"editType": "general",
			"fileName": "rmElEtcMngInfo",
			"entityId": "rm_el_etc_mng_info",
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
												"elements": [
													{
														"type": "SearchHeader",
														"id": "prj_no_car_no_SearchHeader",
														"name": "prj_no_car_no_SearchHeader",
														"label": "",
														"text": "Prj_no ...",
														"containerCls": "col-sm-2"
													},
													{
														"type": "jsTreeSearch",
														"id": "prj_no_car_no_jsTreeSearch",
														"name": "prj_no_car_no_jsTreeSearch",
														"label": "rmElBaseinfoMngTree Search",
														"text": " ",
														"keys": [
															{
																"codeColumn": "prj_no",
																"nameColumn": "prj_no"
															},
															{
																"codeColumn": "car_no",
																"nameColumn": "car_no"
															}
														],
														"rootText": "Select prjNo/carNo",
														"relation": {
															"parentEntityName": "rm_el_baseinfo_mng",
															"childEntityName": "rm_el_etc_mng_info",
															"columns": [
																{
																	"parentColumn": "prj_no",
																	"childColumn": "prj_no",
																	"index": 0
																},
																{
																	"parentColumn": "car_no",
																	"childColumn": "car_no",
																	"index": 1
																}
															]
														},
														"popValues": [],
														"events": {
															"changed.jstree": function (e, data) {
															                if (data.event != null) {
															                    // fn_search();
															                    e.target.htmlMaker.instance.fn_search();
															                }
															            },

															"loaded.jstree": function (e, data) {
															                // getGridData();
															            }

														},
														"sqlId": "rmElEtcMngInfo.rmElBaseinfoMng.jstreesearch",
														"data": function(){
														        var _this = this;
														        var rtnList = [];
														        $.ajax({
														            url: "./genericlListJson.do",
														            data: {"sqlid": _this.sqlId }, 
														            async: false,
														            success:  function(response){
														                rtnList = response.dataList;
														            }
														        });
														        return rtnList;
														    },

														"entityId": "rm_el_baseinfo_mng",
														"containerCls": "col-sm"
													}
												]
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
								"id": "rmElEtcMngInfoGrid",
								"name": "rmElEtcMngInfoGrid",
								"label": "",
								"text": "Rm_el_etc_mng_info",
								"sqlId": "rmElEtcMngInfo.rmElEtcMngInfo",
								"entityId": "rm_el_etc_mng_info",
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
									"pager": "#rmElEtcMngInfoGridPager",
									"sqlId": "rmElEtcMngInfo.rmElEtcMngInfo",
									"gridId": "rmElEtcMngInfoGrid",
									"modelVarName": "thenetJpa",
									

									"editurl": "./ssdCusDummySaveJson.do",
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
									"entityId": "rm_el_etc_mng_info",
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
									                            url: "./genericlListJson.do?sqlid=rmElEtcMngInfo.rmElEtcMngInfo.one" ,
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
									                                                        url: "./genericSaveJson.do",
									                                                        type: "POST",
									                                                        data: {
									                                                            searchJson: JSON.stringify(paramObj),
									                                                            fieldName: this.state.name,
									                                                            fieldValue: this.state.value,
									                                                            fieldValueOrigin: this.state.value_origin,
									                                                            userId: $("#userId").val(),
									                                                            // sqlid: "dashboard.ssd_sm.script_master.update"
									                                                            sqlid: "rmElEtcMngInfo.rmElEtcMngInfo.edit"
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
										"label": "Prj no",
										"name": "PRJ_NO",
										"id": "PRJ_NO",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"required": true,
										"referenceId": "reference::rm_el_baseinfo_mng::rm_el_etc_mng_info",
										"topRefrenceId": "reference::rm_el_baseinfo_mng::rm_el_etc_mng_info",
										"editoptions": {
											"dataEvents": []
										},
										"unformat": function( cellval ,  opts , cell){
										                        var grid = $(this).jqGrid();
										                        var originVal = $(cell).attr("cellValue");
										                        //opts.colModel.editoptions.value[]
										                        return originVal;
										                    },

										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();
										                        // var models = eval(vGridOpt.modelVarName);
										                        // var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
										                        var result = " class='contextMenu contextMenu-all'";
										                        result += " style='vertical-align: middle;";
										                        // result += "color: black;font-weight: bolder;cursor:pointer;'";
										                        result += "cursor:pointer;'";
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Car no",
										"name": "CAR_NO",
										"id": "CAR_NO",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"required": true,
										"referenceId": "reference::rm_el_baseinfo_mng::rm_el_etc_mng_info",
										"topRefrenceId": "reference::rm_el_baseinfo_mng::rm_el_etc_mng_info",
										"editoptions": {
											"dataEvents": []
										},
										"unformat": function( cellval ,  opts , cell){
										                        var grid = $(this).jqGrid();
										                        var originVal = $(cell).attr("cellValue");
										                        //opts.colModel.editoptions.value[]
										                        return originVal;
										                    },

										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();
										                        // var models = eval(vGridOpt.modelVarName);
										                        // var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
										                        var result = " class='contextMenu contextMenu-all'";
										                        result += " style='vertical-align: middle;";
										                        // result += "color: black;font-weight: bolder;cursor:pointer;'";
										                        result += "cursor:pointer;'";
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Mob col",
										"name": "MOB_COL",
										"id": "MOB_COL",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
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
										"label": "Seq no",
										"name": "SEQ_NO",
										"id": "SEQ_NO",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Mob no",
										"name": "MOB_NO",
										"id": "MOB_NO",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Email",
										"name": "EMAIL",
										"id": "EMAIL",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Trb nocur yn",
										"name": "TRB_NOCUR_YN",
										"id": "TRB_NOCUR_YN",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Trb cmp yn",
										"name": "TRB_CMP_YN",
										"id": "TRB_CMP_YN",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Chk strt yn",
										"name": "CHK_STRT_YN",
										"id": "CHK_STRT_YN",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Chk succ yn",
										"name": "CHK_SUCC_YN",
										"id": "CHK_SUCC_YN",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Comm disor yn",
										"name": "COMM_DISOR_YN",
										"id": "COMM_DISOR_YN",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Chk rpt yn",
										"name": "CHK_RPT_YN",
										"id": "CHK_RPT_YN",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Smaph cntl yn",
										"name": "SMAPH_CNTL_YN",
										"id": "SMAPH_CNTL_YN",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
										                        result += " gridId='" + vGridOpt.gridId + "'";
										                        result += " entityId='" + vGridOpt.entityId + "'";
										                        result += " columnName='" + cm.name + "'";
										                        result += " cellValue='" + rawObject[cm.name] + "'";
										                        
										                        return result;
										                    }

									},
									{
										"label": "Del yn",
										"name": "DEL_YN",
										"id": "DEL_YN",
										"align": "center",
										"entityName": "rm_el_etc_mng_info",
										"editable": true,
										"gridId": "rmElEtcMngInfoGrid",
										"editrules": {
											"edithidden": true
										},
										"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
										                        var grid = $(this).jqGrid();
										                        var vGridOpt = grid.getGridParam();                    
										                        var result = "";
										                        
										                        if ( cm.file_info != null){
										                            result = " class='glyphicon glyphicon-download-alt'";
										                            result += " style='vertical-align: middle;";
										                            result += "cursor:pointer;'";
										                        }
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
					"_name": "prj_no",
					"__prefix": null,
					"isKey": true,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "car_no",
					"__prefix": null,
					"isKey": true,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "mob_col",
					"__prefix": null,
					"isKey": true,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "seq_no",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "mob_no",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "email",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "trb_nocur_yn",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "trb_cmp_yn",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "chk_strt_yn",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "chk_succ_yn",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "comm_disor_yn",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "chk_rpt_yn",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "smaph_cntl_yn",
					"__prefix": null,
					"_documentation": {}
				},
				{
					"type": {
						"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
						"__prefix": null
					},
					"_name": "del_yn",
					"__prefix": null,
					"_documentation": {}
				}
			],
			"dataSources": [
				{
					"referenceId": "reference::rm_el_baseinfo_mng::rm_el_etc_mng_info",
					"topRefrenceId": "reference::rm_el_baseinfo_mng::rm_el_etc_mng_info",
					"parentEntity": "rm_el_baseinfo_mng",
					"parentColumnName": "prj_no",
					"childColumnName": "prj_no",
					"childColumnNames": [
						"prj_no",
						"car_no"
					],
					"parentNameColumn": "prj_no",
					"parentColumnNames": [
						"prj_no",
						"car_no"
					],
					"topEntity": "rm_el_baseinfo_mng",
					"topColumnName": "prj_no",
					"topColumnNames": [
						"prj_no",
						"car_no"
					],
					"topNameColumn": "prj_no",
					"sqlId": "rmElEtcMngInfo.datasrc.rmElBaseinfoMng.prjNo",
					"data": function ( _gridProperties ) {
					                    var _this = this;
					                    var vGridProperties = null;
					                    if( _gridProperties == null)
					                        vGridProperties = gridProperties;
					                    else 
					                        vGridProperties = _gridProperties;
					                    
					                    var prop = _.find( vGridProperties , { _name : _this.childColumnName } );
					                    var dataSrcType = "select";
					                    if ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)
					                        dataSrcType = prop._documentation.data_src_type;
					                    if (dataSrcType != "select")
					                        return;
					                    $.ajax({
					                        type: "POST",
					                        url: "./genericlListJson.do?" +
					                            "&sqlid=" + _this.sqlId,
					                        data: {},
					                        async: false,
					                        success: function (response) {
					                            var dataList = response.dataList;
					                            $.each(dataList, function (i, data) {
					                                if( data != null)
					                                    _this.value[data[ _this.topColumnName.toUpperCase()]] = data[_this.topNameColumn.toUpperCase()];
					                            });
					                        }
					                    });
					                },

					"value": {},
					"sqlIdDynamic": "rmElEtcMngInfo.datasrc.dynamic.rmElBaseinfoMng.prjNo",
					"dataDynamic": function ( param ) {
					                    var _this = this;
					                    var rtnList = [];
					                    $.ajax({
					                        type: "POST",
					                        url: "./genericlListJson.do?" +
					                            "&sqlid=" + _this.sqlIdDynamic,
					                        data: param,
					                        async: false,
					                        success: function (response) {
					                            rtnList = response.dataList;
					                        }
					                    });
					                    return rtnList;
					                }

				},
				{
					"referenceId": "reference::rm_el_baseinfo_mng::rm_el_etc_mng_info",
					"topRefrenceId": "reference::rm_el_baseinfo_mng::rm_el_etc_mng_info",
					"parentEntity": "rm_el_baseinfo_mng",
					"parentColumnName": "car_no",
					"childColumnName": "car_no",
					"childColumnNames": [
						"prj_no",
						"car_no"
					],
					"parentNameColumn": "car_no",
					"parentColumnNames": [
						"prj_no",
						"car_no"
					],
					"topEntity": "rm_el_baseinfo_mng",
					"topColumnName": "car_no",
					"topColumnNames": [
						"prj_no",
						"car_no"
					],
					"topNameColumn": "car_no",
					"sqlId": "rmElEtcMngInfo.datasrc.rmElBaseinfoMng.carNo",
					"data": function ( _gridProperties ) {
					                    var _this = this;
					                    var vGridProperties = null;
					                    if( _gridProperties == null)
					                        vGridProperties = gridProperties;
					                    else 
					                        vGridProperties = _gridProperties;
					                    
					                    var prop = _.find( vGridProperties , { _name : _this.childColumnName } );
					                    var dataSrcType = "select";
					                    if ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)
					                        dataSrcType = prop._documentation.data_src_type;
					                    if (dataSrcType != "select")
					                        return;
					                    $.ajax({
					                        type: "POST",
					                        url: "./genericlListJson.do?" +
					                            "&sqlid=" + _this.sqlId,
					                        data: {},
					                        async: false,
					                        success: function (response) {
					                            var dataList = response.dataList;
					                            $.each(dataList, function (i, data) {
					                                if( data != null)
					                                    _this.value[data[ _this.topColumnName.toUpperCase()]] = data[_this.topNameColumn.toUpperCase()];
					                            });
					                        }
					                    });
					                },

					"value": {},
					"sqlIdDynamic": "rmElEtcMngInfo.datasrc.dynamic.rmElBaseinfoMng.carNo",
					"dataDynamic": function ( param ) {
					                    var _this = this;
					                    var rtnList = [];
					                    $.ajax({
					                        type: "POST",
					                        url: "./genericlListJson.do?" +
					                            "&sqlid=" + _this.sqlIdDynamic,
					                        data: param,
					                        async: false,
					                        success: function (response) {
					                            rtnList = response.dataList;
					                        }
					                    });
					                    return rtnList;
					                }

				}
			],
			"childReferences": [
				{
					"referenceId": "reference::rm_el_etc_mng_info::rm_el_etc_test",
					"parentEntityName": "rm_el_etc_mng_info",
					"childEntityName": "rm_el_etc_test",
					"childEntityId": "rm_el_etc_test",
					"parent_columns": [
						"prj_no",
						"car_no",
						"mob_col"
					],
					"child_columns": [
						"prj_no",
						"car_no",
						"mob_col"
					]
				}
			],
			"dictionaries": [
				{
					"entityName": "rm_el_etc_mng_info",
					"sqlId": "rmElEtcMngInfo.dictionary.rmElEtcMngInfo",
					"dictionaryDefTable": "rm_cmm_cd",
					"dictionaryUseTable": "rm_cmm_use",
					"categoryColumn": "code_category",
					"codeColumn": "code_id",
					"nameColumn": "code_nm",
					"data": function () {
					                var _this = this;
					                $.ajax({
					                    type: "POST",
					                    url: "./genericlListJson.do?" +
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
				"entityId": "rmElEtcMngInfo"
			},
			"entity_sql_prefix": "",
			"commonFunc": {
				"sqlId": "rmElEtcMngInfo.rmElEtcMngInfo"
			},
			"popParemeters": {}
		});