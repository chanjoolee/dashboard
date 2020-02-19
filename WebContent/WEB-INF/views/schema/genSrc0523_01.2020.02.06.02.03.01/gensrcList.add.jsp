<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/include/include.toolbox.pmstable.jsp"></jsp:include>
	<script>
		localStorage.removeItem("jstree");
		// to find origin list page
		var parentFrame = "${param.frameName}";
		if (parentFrame != ""){
			parentFrame =  eval("parent.${param.frameName}");
		}
		var beforEditRow = {};
		var EfContextPath = "";
		var v_filterPop = {};
		// schema
		var v_schema = {};
		var dictionaries = [
			{
				"entityName": "gensrc_list",
				"sqlId": "gensrcList.dictionary.gensrcList",
				"dictionaryDefTable": "gensrc_cmm_cd",
				"dictionaryUseTable": "gensrc_cmm_use",
				"categoryColumn": "code_category",
				"codeColumn": "code_id",
				"nameColumn": "code_nm",
				"data": function () {
				                var _this = this;
				                $.ajax({
				                    type: "POST",
				                    url: "${pageContext.request.contextPath}/genericlListJson.html?" +
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
		];
		var dataSrc = [];
		var childReferences = [];
		var gridProperties = [
			{
				"eAnnotations": {
					"details": {
						"_xmi:id": "_SmZlyEg2EeqonN_RS9oRzw",
						"_key": "uuid",
						"_value": "_EGy8MV9QEDek0JnbBus9EQ",
						"__prefix": null
					},
					"_xmi:id": "_SmZlx0g2EeqonN_RS9oRzw",
					"_source": "genmymodel",
					"__prefix": null
				},
				"annotations": {
					"eAnnotations": {
						"details": {
							"_xmi:id": "_SmZly0g2EeqonN_RS9oRzw",
							"_key": "uuid",
							"_value": "_KJ0OkV9QEDek0JnbBus9EQ",
							"__prefix": null
						},
						"_xmi:id": "_SmZlykg2EeqonN_RS9oRzw",
						"_source": "genmymodel",
						"__prefix": null
					},
					"_xsi:type": "gmmjpa:Id",
					"_xmi:id": "_SmZlyUg2EeqonN_RS9oRzw",
					"__prefix": null
				},
				"type": {
					"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
					"__prefix": null
				},
				"_xmi:id": "_SmZlxkg2EeqonN_RS9oRzw",
				"_name": "soruce_id",
				"_documentation": {
					"required": true
				},
				"__prefix": null
			},
			{
				"eAnnotations": {
					"details": {
						"_xmi:id": "_SmZlzkg2EeqonN_RS9oRzw",
						"_key": "uuid",
						"_value": "_5fm7EV9PEDek0JnbBus9EQ",
						"__prefix": null
					},
					"_xmi:id": "_SmZlzUg2EeqonN_RS9oRzw",
					"_source": "genmymodel",
					"__prefix": null
				},
				"annotations": {
					"eAnnotations": {
						"details": {
							"_xmi:id": "_SmZl0Ug2EeqonN_RS9oRzw",
							"_key": "uuid",
							"_value": "_hH-ggF9dEDek0JnbBus9EQ",
							"__prefix": null
						},
						"_xmi:id": "_SmZl0Eg2EeqonN_RS9oRzw",
						"_source": "genmymodel",
						"__prefix": null
					},
					"_xsi:type": "gmmjpa:Id",
					"_xmi:id": "_SmZlz0g2EeqonN_RS9oRzw",
					"__prefix": null
				},
				"type": {
					"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
					"__prefix": null
				},
				"_xmi:id": "_SmZlzEg2EeqonN_RS9oRzw",
				"_name": "gen_type",
				"_documentation": {
					"required": true
				},
				"__prefix": null
			},
			{
				"eAnnotations": {
					"details": {
						"_xmi:id": "_SmZl1Eg2EeqonN_RS9oRzw",
						"_key": "uuid",
						"_value": "_2CtT8R5NEDiJl4vo7-ai9A",
						"__prefix": null
					},
					"_xmi:id": "_SmZl00g2EeqonN_RS9oRzw",
					"_source": "genmymodel",
					"__prefix": null
				},
				"annotations": {
					"eAnnotations": {
						"details": {
							"_xmi:id": "_SmZl10g2EeqonN_RS9oRzw",
							"_key": "uuid",
							"_value": "_P3zCoR5OEDiJl4vo7-ai9A",
							"__prefix": null
						},
						"_xmi:id": "_SmZl1kg2EeqonN_RS9oRzw",
						"_source": "genmymodel",
						"__prefix": null
					},
					"_xsi:type": "gmmjpa:Embedded",
					"_xmi:id": "_SmZl1Ug2EeqonN_RS9oRzw",
					"__prefix": null
				},
				"type": {
					"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
					"__prefix": null
				},
				"_xmi:id": "_SmZl0kg2EeqonN_RS9oRzw",
				"_name": "db_type",
				"_documentation": {
					"required": true
				},
				"__prefix": null
			},
			{
				"eAnnotations": {
					"details": {
						"_xmi:id": "_SmZl2kg2EeqonN_RS9oRzw",
						"_key": "uuid",
						"_value": "_oZa2MF9PEDek0JnbBus9EQ",
						"__prefix": null
					},
					"_xmi:id": "_SmZl2Ug2EeqonN_RS9oRzw",
					"_source": "genmymodel",
					"__prefix": null
				},
				"type": {
					"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
					"__prefix": null
				},
				"_xmi:id": "_SmZl2Eg2EeqonN_RS9oRzw",
				"_name": "url",
				"_documentation": {
					"file_info": {
						"path_column": "URL"
					}
					
				},
				"__prefix": null
			}
		];
		var popParemeters = {
			"fn_set": function(){
						            if($("#filterPop").val() != "" ){
						                v_filterPop = JSON.parse($("#filterPop").val());
						                var v_filters = [];
						                $.each(v_filterPop ,function(field, data){
						                    var obj = {
						                        field : field ,
						                        // value: [].concat(data)
						                        value: data , 
						                        isArray : _.isArray(data)
						                    };
						                    v_filters.push( obj );
						                });
						                $("#searchJson").val(JSON.stringify({fields: v_filters}));                          
						            }            
						        }

		};
		var entityDoc = {
			"custom_columns": [
				{
					"column_name": "btn_exec",
					"column_after": "url",
					"properties": {
						"formatter": function(cellValue, options, rowObject){
											var btnHtml = '<button type="button" class="btn btn-warning btn-sm" onclick="entityDoc.customFunc.fn_generateClick(\''+ options.rowId +'\');">Generate</button>';
											return btnHtml;
										},

						"align": "center"
					}
				}
			],
			"customFunc": {
				"fn_generateClick": function(rowId){
							var grid = $("#gensrcListGrid");
							var rowData = grid.getRowData(rowId);
							
						    var url = rowData.URL;
						    $.ajax({
						        url: url ,
						        // data: {sqlid: "codegen.tables",owner: $("#owner").val()}, 
								async: false,
								headers:{
									authorization : "Bearer 1bb9a71d-3742-471e-8d0a-aaf68db4eab8"
								},
						        success:  function(doc,result,response){
						            // console.log(response.responseText);
						            genmyModelxmi = response.responseText;
				
									var config = {};
									config.skipEmptyTextNodesForObj = true;
									//config.arrayAccessForm = "property";
									config.stripWhitespaces = true;
									config.enableToStringFunc = false;
				
									var x2js = new X2JS(config);
						            schema_bpmn =  x2js.xml_str2json(genmyModelxmi);
						            // fn_create_source();
						            generator = new Generator(schema_bpmn,rowData.GEN_TYPE);
						            generator.fn_source();
						            // generator.fn_fileSave();
						        }
						    });
							
						}

			}
		};
		var commonFunc = {
			"sqlId": "gensrcList.gensrcList",
			"fn_make_schema": function(){
			                var detailList = [];
			                
			                var v_type = "inline";
			                if( _.includes(['edit','view', 'copy'],$("#detailType").val()) ){
			                    $.ajax({
			                        type: "POST",
			                        url: "${pageContext.request.contextPath}/genericlListJson.html?sqlid=gensrcList.gensrcList.one",
			                        // data: searchRow ,
			                        data: $("#form").serialize(), 
			                        async: false,
			                        success:  function(response){
			                            detailList  = response.dataList;     
			                            // commonFunc.data = detailList[0] ;
			                            commonFunc.data = _.merge(detailList[0], commonFunc.data);
			                        }
			                    });
			                }
			                var data = commonFunc.data;
			                if ( _.includes(['add'],$("#detailType").val()) && parentFrame.v_filterPop != null && _.keys(parentFrame.v_filterPop).length > 0 ) {
			                    data = parentFrame.v_filterPop;
			                }
			
			                if( _.includes(['edit','add'],$("#detailType").val()) ){
			                    v_type = "inline_edit";
			                }
			                var vKeys = [];
			                var properties = _.filter(gridProperties, function(prop){ 
			                    return true;
			                });
			                $.each([].concat(properties), function(i, prop){
			                    let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] ,{"_xsi:type" : "gmmjpa:Id"});
			                    if (vId != null){
			                        vKeys.push(prop._name.toUpperCase());
			                    }
			                });
			                var gridid = findAllByElName(parentFrame.v_schema_content.elements , {type:"grid"}).id;
			                var theGrid = parentFrame.$("#"+gridid);
			                var cms = theGrid.jqGrid("getGridParam", "colModel");
			
			                var v_items = [];
			                // custom order by
			                if (entityDoc.detail != null && entityDoc.detail.order_by != null){
			                    $.each(entityDoc.detail.order_by, function(i, _order){									
			                        var _cms = cms;									
			                        var prop = _.find([].concat(properties), {_name : _order.column_name});
			                        var rtnObj = {};
			                        if (prop != null){										
			                            rtnObj = {
			                                label : _.capitalize(_.upperCase(prop._name)),
			                                col : prop._name.toUpperCase() ,
			                                orderby : i
			                            };
			                            let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] ,{"_xsi:type" : "gmmjpa:Id"});
			                            if (vId != null &&  _.includes(['edit'], "${param.detailType}")){
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
			                                if (parentFrame.v_filterPop[rtnObj.col] != null && parentFrame.v_filterPop[rtnObj.col] != ""){
			                                    rtnObj.edit_tag = 'input';
			                                    rtnObj.editable = false;
			                                }
			                            }
			
			                            // if add_hidden , then edit_tage : hidden
			                            if (prop._documentation != null && prop._documentation.add_hidden ){
			                                rtnObj.edit_tag = "hidden";
			                            }
			                            v_items.push(rtnObj);
			                        }else {
			                            rtnObj = _order;
			                            rtnObj.orderby = i;
			                            var prop1 = _.find(gridProperties,{"_name": _order.column_name});
			                            if(prop1 != null && prop1._documentation != null && prop1._documentation.add_hidden ){
			
			                            }else{
			                                rtnObj.col = _order.column_name;
			                                v_items.push(rtnObj);
			                            }
			                        }
			                        
			
			                    });
			                    
			                }
			
			                // Process than not exists in orderby 
			                $.each([].concat(properties), function(i, prop){									
			                    var v_item = _.find([].concat(v_items),{col : prop._name.toUpperCase()});
			                    if ( v_item == null){
			                        var _cms = cms;									
			                        var rtnObj = {};
			                                                            
			                        rtnObj = {
			                            label : _.capitalize(_.upperCase(prop._name)),
			                            col : prop._name.toUpperCase() ,
			                            orderby : 100
			                        };
			                        let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] ,{"_xsi:type" : "gmmjpa:Id"});
			                        if (vId != null &&  _.includes(['edit'], "${param.detailType}")){
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
			
			                        // if add_hidden , then edit_tage : hidden
			                        if (prop._documentation != null && prop._documentation.add_hidden ){
			                            rtnObj.edit_tag = "hidden";
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
			                            if (parentFrame.v_filterPop[rtnObj.col] != null && parentFrame.v_filterPop[rtnObj.col] != "" ){
			                                rtnObj.edit_tag = 'input';
			                                rtnObj.editable = false;
			                            }
			                        }
			                        
			                        v_items.push(rtnObj);
			                    }
			                });
			
			                // pop_select
			                var pop_props = _.filter(gridProperties, {_documentation: { data_src_type : "pop_select" } });
			                $.each(pop_props, function(i,pop_prop){
			                    var pop_item = _.find(v_items , {col : pop_prop._name.toUpperCase()});
			                    if (pop_item != null)
			                        pop_item.edit_tag = "pop_select";
			                });
			
			                // label merge
			                $.each(v_items , function(i, _item){
			                    if (_item.col == null)
			                        return true;
			                    var v_property = _.find(gridProperties, { _name : _item.col.toLowerCase() });
			                    if ( v_property != null && v_property._documentation != null){
			                        _.merge(_item , v_property._documentation);
			                        // if (v_property._documentation.label != null){
			                        //     _.merge(_item , v_property._documentation);
			                        //     _item.label = v_property._documentation.label ;
			                        // }
			                    }
			
			                });
			
			                var schema_options = {
			                    keys : vKeys ,
			                    fn_change: function( input ){									
			                        // cascade update
			                        var _this = this;
			                        var gridJson = findAllByElName(parentFrame.v_schema_content.elements , {type:"grid"});
			                        var item = _.find(gridJson.items, {name : this.props.options.name});
			                        var src = {};
			                        if (item != null && item.referenceId != null && dataSrc != null){
			                            src = _.find(dataSrc, {"referenceId": item.referenceId, "topRefrenceId" : item.topRefrenceId , "childColumnName": item.name.toLowerCase()  });
			                        }
			                        if ( src.parentColumnNames != null && src.parentColumnNames.length > 1){
			                            var index = _.indexOf( _.map(src.childColumnNames,function(column){ return column.toUpperCase();  }) , item.name.toUpperCase() );
			                            if (index > -1 && index < (src.parentColumnNames.length -1 )){
			                                var nextColumn = src.childColumnNames[index+1];
			                                var nextCm = _.find( cms , {name: nextColumn.toUpperCase() });												
			                                var wheres = src.childColumnNames.slice(0,index + 1);
			                                var frm = document.getElementById("form");
			                                var param = {};
			                                $.each(wheres , function(i, where ){
			                                    var whereReact = _.find(_this.reactObjects , 
			                                        { 
			                                            props : {
			                                                options : {
			                                                    name: where.toUpperCase()
			                                                } 
			                                            }															
			                                        }
			                                    );
			                                    if ( _this == whereReact )
			                                        param["search_" + _.camelCase(where) ] = input;
			                                    else
			                                        param["search_" + _.camelCase(where) ]  =  whereReact.state.value;
			                                });												
			                                var nextSrc = _.find(dataSrc, {"referenceId": nextCm.referenceId, "topRefrenceId" : nextCm.topRefrenceId , "childColumnName": nextCm.name.toLowerCase()  });
			                                var list = nextSrc.dataDynamic(param);
			                                var nextReact = _.find(_this.reactObjects , 
			                                    { 
			                                        props : { 
			                                            options : {
			                                                name: nextColumn.toUpperCase()
			                                            }															
			                                        } 
			                                    }
			                                );
			                                
			                                var options = [];
			                                $.each(list, function (i, obj) {
			                                    var opt = { label : obj[nextSrc.parentNameColumn.toUpperCase()], value :obj[nextSrc.parentColumnName.toUpperCase()] };
			                                    options.push(opt);
			                                });
			                                // nextReact.state.selectOptions = options ;
			                                nextReact.setState({selectOptions : options });
			                                // setState()
			
			                            }
			                        }
			                        
			                    },
			                    fn_submit: function(_editType){
			                        if (_editType == "edit"){
			                            //alert("submit function defined");
			                            var state = true;
			                            var paramObj = {
			                                //origindatas: this.props.options.keys
			                                origindatas: this.state.keys
			                            };
			                            
			                            if(this.props.options.value == this.state.value)
			                                return state;
			                            $.ajax({
			                                url: "${pageContext.request.contextPath}/genericSaveJson.html",
			                                type: "POST",
			                                data: {
			                                    searchJson: JSON.stringify(paramObj),
			                                    fieldName: this.state.name,
			                                    fieldValue: this.state.value,
			                                    fieldValueOrigin: this.state.value_origin,
			                                    userId: $("#userId").val(),
			                                    // sqlid: "dashboard.ssd_sm.script_master.update"
			                                    sqlid: "gensrcList.gensrcList.edit"
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
			                        } 
			                        else if ( _.includes(['add','copy'], _editType)){
			                            //alert("submit function defined");
			                            var state = true;
			                            var reactObjects = this;
			                            var addRow = {};
			                            var gridJson = findAllByElName(parentFrame.v_schema_content.elements , {type:"grid"});
			                            $.each(reactObjects,function(i,react){
			                                addRow[this.state.name] = this.state.value;
			                            });
			                            addRow['sqlid'] = gridJson.sqlId + ".insert";
			
			                            var form1 = $("#form");
										
										var parameter = "uploadBoard=schema";
										parameter += "&useRealFileName=Y";

										$('#form').ajaxForm({
											url: "${pageContext.request.contextPath}/fileTestJson.html?" + parameter 
											, type:"POST"
											, dataType:"json"
											, async: false
											, success:function(json) {
												fileInfo = json;
											}
											, error:function(e){
												alert(e);
											}
										});
										$('#form').submit();
										
										_.merge(addRow, form1.serializeFormJSON() );

										var edit_item = findAllByElName(v_schema.elements , {edit_tag : 'file'});
										if (edit_item != null){
											var item_fileinfo = _.find( fileInfo.searchVO.fileInfoList , {fieldName : edit_item.col });
											if (item_fileinfo != null){
												addRow[edit_item.col] = item_fileinfo.orgFileName;
												addRow[edit_item.file_info.path_column] = item_fileinfo.filePath;
											}											
										}


			                            $.ajax({
			                                url: "${pageContext.request.contextPath}/genericSaveJson.html",
			                                type: "POST",
			                                data: addRow , 
			                                async: false,			                    		
			                                success:  function(data){
			                                    response1 = data;
			                                    if(response1.result != 'success'){
			                                        state = false;
			                                        var msg = "Save Success!";
			                                        $("#dialog-confirm").html(response1.message);
			                                        $("#dialog-confirm").dialog({
			                                            resizable: false,
			                                            modal: true,
			                                            title: "Error",
			                                            //height: 200,
			                                            width: 500,
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
			                                    // Success
			                                    else {
			                                        // To do 
			                                        // Message ==> Click  ==> Parent Grid Refresh , Self Refresh Edit
			                                        parentFrame.fn_search();
			                                        var msg = "Save Success!";
			                                        $("#dialog-confirm").html(msg);
			                                        $("#dialog-confirm").dialog({
			                                            resizable: false,
			                                            modal: true,
			                                            title: "Error",
			                                            //height: 200,
			                                            width: 500,
			                                            dialogClass: 'no-close',
			                                            closeOnEscape: false,
			                                            buttons: [
			                                                {
			                                                    text: "OK",
			                                                    click: function() {
			                                                        $( this ).dialog( "close" );
			                                                        setTimeout( function(){
			                                                            // parent.$("#" + window.frameElement.name.replace("frame","modal")).remove();
			                                                            parent.$("#" + window.frameElement.name.replace("frame","modal")).modal('toggle');
			                                                        },0);
			                                                    }
			                                                }
			                                            ]
			                                        });
			                                        
			                                        // reload to edit mode;
			                                    }						                    			
			                                }
			                            });
			                            
			
			                            return state;
			                        }
			                        
			                    },
			                    fn_afterSubmit: function(keyUpdatedObjects){
			                        // if only edit
			                        $.each(this,function(i,react){
			                            if(_.find(cms,function(cm){return cm.name == react.state.name})){
			                                var vobject = {}; 
			                                var parentRowKey = theGrid.getGridParam('selrow');
			                                vobject[react.state.name] = react.state.value;
			                                theGrid.setRowData(parentRowKey,vobject);
			                            }
			                            
			                        });
			                        
			                        var msg = "Save Success!";
			                        $("#dialog-confirm").html(msg);
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
			                                                    
			                        
			                    },
			                    progressObject: $("#loader"),
			                    fn_pop_select : commonFunc.fn_pop_select
			                };
			                if (entityDoc.add_button_option != null){
			                    schema_options.button_option = entityDoc.add_button_option ;
			                }
			
			                v_schema = {
			                    containerId: '',
			                    type:'Vertical',
			                    label: '',
			                    elements: [
			                        {
			                            label: "",
			                            type: 'Group',
			                            elements: [
			                                {
			                                    type: "inline_edit",
			                                    edit_type : "${param.detailType}",
			                                    cols: entityDoc.detail_cols_add =! null  ? entityDoc.detail_cols_add : 1 ,
			                                    data: function(){ 
			                                        return commonFunc.data;
			                                    },
			                                    options : schema_options,
			                                    items: v_items 
			                                    
			                                }
			                                
			                            
			                            ]
			                        }
			                        
			                    
			                    ]
			                };  
			                
			                
			
			            },

			"fn_pop_select": function(e){
							// console.log("fn_pop_select");
							// 01. find reference childColumnName
							var _this = this;
							var v_react_column_name = this.props.options.name.toLowerCase();
							var v_value = this.state.value;
							var v_datasrc = _.find(dataSrc, {childColumnName : v_react_column_name} );
							
							if ( v_datasrc != null){
								
								// frame dom copy
								if(true){
									var pageBody = parent.$("body");
									var modalCommon = parent.$("[name=infiniteLogModal]");
									var modalClone = modalCommon.clone();
									pageBody.append(modalClone);
									modalClone.attr("isCloned","true");
					
									var today = new Date();
									var y = today.getFullYear();
									var m = today.getMonth() + 1;
									var d = today.getDate();
									var h = today.getHours();
									var mi = today.getMinutes();
									var s = today.getSeconds();
									var idPrefix =  y + "_" + m + "_" + d + "_" + h + "_" + mi + "_" + s;
									var modalId = "modal_" + idPrefix;
									var frameId = "frame_" + idPrefix;
									modalClone.attr("id",modalId);
									modalClone.attr("name",modalId);
					
									var frameDom = $('<iframe name="" id=""  src="" style="width:1000px;border: 0;height: 600px ; " ></iframe>');
									frameDom.attr("id", frameId);
									frameDom.attr("name", frameId);
					
									var container = modalClone.find(".infiniteLogContainer");
									container.append(frameDom);
								}
								
								var oFrm = document.getElementById("form");					
								var viewName = $("#viewName").val();
								var viewPath = viewName.split("/");
								var itemName = viewPath.pop();
								var parentViewName = _.camelCase( v_datasrc.parentEntity);
								oFrm.action =  "${pageContext.request.contextPath}/generic.html?viewName=" + viewPath.join("/") + "/" + parentViewName + "&backgroundColor=FFF&isPop=Y&is_pop_select=Y";
								oFrm.method = "post";
								oFrm.target = frameId;
			                    
			                    var parentFrameName = "${param.frameName}";
								if ( _.startsWith( parentFrameName,"frame") ){						
									$("#frameName").val( parentFrameName + "." + window.frameElement.name );
								}else {
									$("#frameName").val( window.frameElement.name );
								}	
								frameDom.show();
			
								// selectPop
								var pop_select = {};
								$.each(_this.reactObjects , function(i,react){
									pop_select[this.state.name] = this.state.value;
									if( this.state.search_str != null ){
										var prop = _.find(gridProperties, { _name : react.state.name.toLowerCase() , _documentation : { data_src_type : "pop_select"} });
										if (prop != null && prop._documentation.search_str_option != null){
											var option = prop._documentation.search_str_option;
			                                
			                                if (typeof option.search_field == "string"){
												option.search_value = this.state.search_str;								
												
											}else{
												$.each( option.search_field , function(i,search_field){
													var target_react = _.find( 
														_this.reactObjects ,  
														{ 
															props : {
																options : {
																	name: search_field.from
																} 
															}															
														}
													);																		
													search_field.value = target_react.state.value;										
												});
			                                }
			                                
			                                pop_select.search_str_option = option;
			
										}
									}
										
								});
								$("#pop_select").val(JSON.stringify(pop_select));
								$("#filterPop").val("{}");
								commonFunc.pop_select_react_object = _this;
								commonFunc.pop_select_react_object.dataSrc = v_datasrc;
			
								// header
								var headerStrs = [];
								$.each(pop_select,function(k,v){
									var str = _.camelCase(k);
									str += " : " + v;
									headerStrs.push(str);
								});
								// var headStr = '[' + parentViewName + ']  ' +  headerStrs.join(" , ");
								var headStr = '[' + parentViewName + ']  ' +  'Search For Select';
								modalClone.find(".modal-header h6 span").text(headStr);
			
								modalClone.modal();
								oFrm.submit();
							}
			            
			            },

			"pop_select_react_object": {},
			"fn_pop_select_callback": function(){
			                // to do some customize ...
			                if ( entityDoc.customFunc != null && entityDoc.customFunc.fn_pop_select_callback != null){
			                    entityDoc.customFunc.fn_pop_select_callback.call(this);
			                }
			
			                if (entityDoc.show_sub_pages){
			                    commonFunc.fn_view_sub();
			                }
			                
			            },

			"data": {},
			"fn_view_sub": function(){
							if(entityDoc.show_sub_pages != true)
								return;
							var sub_container = $("#v_sub_pages");				
							sub_container.html('');
			
							$.each(childReferences , function(i,child){
			                    // to do group label
			                    var h3 = $(document.createElement("h3"));
			                    h3.css("margin-top"," 10px");
			                    h3.css("padding-bottom"," 0px");
			                    h3.addClass("cont_tit");
			                    h3.text( _.camelCase(child.childEntityName));
			                    sub_container.append(h3);
			                    
			                    var frameId = "frame_" + child.childEntityId ;
								var frameDom = $('<iframe name="" id=""  src="" style="width:100%;border: 0;height: 370px ; " ></iframe>');
								frameDom.attr("id", frameId);
								frameDom.attr("name", frameId);
								sub_container.append(frameDom);
			
								// Form Submit
								var oFrm = document.getElementById("form");
								var filter = {};
								$.each(child.parent_columns,function(j,parent_column){
									var child_column = child.child_columns[j];
									filter[child_column.toUpperCase()] = commonFunc.data[parent_column.toUpperCase()];
								});
								$("#filterPop").val(JSON.stringify(filter));
								var viewName = $("#viewName").val();
								var viewPath = viewName.split("/");
								var itemName = _.camelCase(child.childEntityName);
								viewPath.pop();
								oFrm.action =  "${pageContext.request.contextPath}/generic.html?viewName=" + viewPath.join("/") + "/" + itemName + "&backgroundColor=FFF&isSubFrame=Y";;
								oFrm.method = "post";
								oFrm.target = frameId;
								frameDom.show();
								var parentFrameName = "${param.frameName}";
								if ( _.startsWith( parentFrameName,"frame") ){						
									$("#frameName").val( parentFrameName + "." + window.frameElement.name );
								}else {
									$("#frameName").val( window.frameElement.name );
								}	
			
								oFrm.submit();
								
							});
						}

		};
	</script>
	<script  id="script_main">
		$(function () {
			$("#loader").show();
			setTimeout( function(){
				// dictionary
				$.each(dictionaries,function(i, src){
					src.data();
				});
				// data scource
				$.each(dataSrc,function(i, src){
					var prop = _.find(gridProperties , { _name : src.childColumnName } );
					var dataSrcType = 'select';
					if ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)
						dataSrcType = prop._documentation.data_src_type;
					if (dataSrcType == 'select')
						src.data();
				});
				popParemeters.fn_set();
				$('#v_schema_contentContainer').html('');
				// getID If show_sub_pages
				if( entityDoc.show_sub_pages && _.includes(['add','copy'],$('#detailType').val()) ){
					commonFunc.getID();
				}
				commonFunc.fn_make_schema();
				fn_makeHtml('v_schema_contentContainer',v_schema);
				// show show_sub_pages
				if( entityDoc.show_sub_pages && _.includes(['edit','view'],$('#detailType').val()) ){
					commonFunc.fn_view_sub();
				}
				$("#loader").hide();
			},50);
		});
	</script>
</head>
<body  style="min-width:920px">
<form name="form" id="form" class="">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
 <input type="hidden" name="cookieName" value="${param.cookieName}"/>
<input type="hidden" name="cookieToken" value="${param.cookieToken}"/>
<input type="hidden" id="userId" name="userId" value="${param.userId}"/>
<input type="hidden" id="pjtId" name="pjtId" value="${param.pjtId}"/>
<input type="hidden" id="filterPop" name="filterPop" value='${param.filterPop}'/>
<input type="hidden" id="pop_select" name="pop_select" value='${param.pop_select}'/>
<input type="hidden" id="viewName" name="viewName" value='${param.viewName}'/>
<input type="hidden" id="searchJson" name="searchJson" value='{}'/>
<input type="hidden" id="detailType" name="detailType" value='${param.detailType}'/>
<input type="hidden" id="frameName" name="frameName" value='${param.frameName}'/>
	<div id="v_schema_searchContainer" class="srch_box2" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>
	<div id="v_schema_contentContainer" class="" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>
	<div id="v_sub_pages" class="" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>
</form>
<div id="dialog-confirm"></div>
<div id="loader" style='display:none'></div>
</body>
<jsp:include page="/WEB-INF/views/include/includeReactComponent.jsp"></jsp:include>