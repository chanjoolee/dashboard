<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="/WEB-INF/views/include/include.toolbox.pmstable.jsp"></jsp:include>
	<script>
		localStorage.removeItem("jstree");
		// to find origin list page not use in general
		var parentFrame = "${param.frameName}";
		if (parentFrame != ""){
			parentFrame =  eval("parent.${param.frameName}");
		}
		var beforEditRow = {};
		var EfContextPath = "";
		var v_filterPop = {};
		// schema
		var dictionaries = [
			{
				"entityName": "gensrc_cmm_use",
				"sqlId": "gensrcCmmUse.dictionary.gensrcCmmUse",
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
		var dataSrc = [
			{
				"referenceId": "reference::gensrc_tab_cols::gensrc_cmm_use",
				"topRefrenceId": "reference::gensrc_tab_cols::gensrc_cmm_use",
				"parentEntity": "gensrc_tab_cols",
				"parentColumnName": "table_name",
				"childColumnName": "table_name",
				"childColumnNames": [
					"table_name",
					"column_name"
				],
				"parentNameColumn": "table_name",
				"parentColumnNames": [
					"table_name",
					"column_name"
				],
				"topEntity": "gensrc_tab_cols",
				"topColumnName": "table_name",
				"topColumnNames": [
					"table_name",
					"column_name"
				],
				"topNameColumn": "table_name",
				"sqlId": "gensrcCmmUse.datasrc.gensrcTabCols.tableName",
				"data": function () {
				                    var _this = this;
				                    var prop = _.find(gridProperties , { _name : _this.childColumnName } );
				                    var dataSrcType = "select";
				                    if ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)
				                        dataSrcType = prop._documentation.data_src_type;
				                    if (dataSrcType == "select")
				                        var dataSrcType = "select";
				                    if (dataSrcType != "select")
				                        return;
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
				                                    _this.value[data[ _this.topColumnName.toUpperCase()]] = data[_this.topNameColumn.toUpperCase()];
				                            });
				                        }
				                    });
				                },

				"value": {},
				"sqlIdDynamic": "gensrcCmmUse.datasrc.dynamic.gensrcTabCols.tableName",
				"dataDynamic": function ( param ) {
				                    var _this = this;
				                    var rtnList = [];
				                    $.ajax({
				                        type: "POST",
				                        url: "${pageContext.request.contextPath}/genericlListJson.html?" +
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
				"referenceId": "reference::gensrc_tab_cols::gensrc_cmm_use",
				"topRefrenceId": "reference::gensrc_tab_cols::gensrc_cmm_use",
				"parentEntity": "gensrc_tab_cols",
				"parentColumnName": "column_name",
				"childColumnName": "column_name",
				"childColumnNames": [
					"table_name",
					"column_name"
				],
				"parentNameColumn": "column_name",
				"parentColumnNames": [
					"table_name",
					"column_name"
				],
				"topEntity": "gensrc_tab_cols",
				"topColumnName": "column_name",
				"topColumnNames": [
					"table_name",
					"column_name"
				],
				"topNameColumn": "column_name",
				"sqlId": "gensrcCmmUse.datasrc.gensrcTabCols.columnName",
				"data": function () {
				                    var _this = this;
				                    var prop = _.find(gridProperties , { _name : _this.childColumnName } );
				                    var dataSrcType = "select";
				                    if ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)
				                        dataSrcType = prop._documentation.data_src_type;
				                    if (dataSrcType == "select")
				                        var dataSrcType = "select";
				                    if (dataSrcType != "select")
				                        return;
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
				                                    _this.value[data[ _this.topColumnName.toUpperCase()]] = data[_this.topNameColumn.toUpperCase()];
				                            });
				                        }
				                    });
				                },

				"value": {},
				"sqlIdDynamic": "gensrcCmmUse.datasrc.dynamic.gensrcTabCols.columnName",
				"dataDynamic": function ( param ) {
				                    var _this = this;
				                    var rtnList = [];
				                    $.ajax({
				                        type: "POST",
				                        url: "${pageContext.request.contextPath}/genericlListJson.html?" +
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
				"referenceId": "reference::gensrc_cmm_cd::gensrc_cmm_use",
				"topRefrenceId": "reference::gensrc_cmm_cd::gensrc_cmm_use",
				"parentEntity": "gensrc_cmm_cd",
				"parentColumnName": "code_category",
				"childColumnName": "code_category",
				"childColumnNames": [
					"code_category"
				],
				"parentNameColumn": "code_category",
				"parentColumnNames": [
					"code_category"
				],
				"topEntity": "gensrc_cmm_cd",
				"topColumnName": "code_category",
				"topColumnNames": [
					"code_category"
				],
				"topNameColumn": "code_category",
				"sqlId": "gensrcCmmUse.datasrc.gensrcCmmCd.codeCategory",
				"data": function () {
				                    var _this = this;
				                    var prop = _.find(gridProperties , { _name : _this.childColumnName } );
				                    var dataSrcType = "select";
				                    if ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)
				                        dataSrcType = prop._documentation.data_src_type;
				                    if (dataSrcType == "select")
				                        var dataSrcType = "select";
				                    if (dataSrcType != "select")
				                        return;
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
				                                    _this.value[data[ _this.topColumnName.toUpperCase()]] = data[_this.topNameColumn.toUpperCase()];
				                            });
				                        }
				                    });
				                },

				"value": {},
				"sqlIdDynamic": "gensrcCmmUse.datasrc.dynamic.gensrcCmmCd.codeCategory",
				"dataDynamic": function ( param ) {
				                    var _this = this;
				                    var rtnList = [];
				                    $.ajax({
				                        type: "POST",
				                        url: "${pageContext.request.contextPath}/genericlListJson.html?" +
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
		];
		var childReferences = [];
		var jstreeInfo = {
			"idList": [
				"table_name_column_name_jsTreeSearch"
			],
			"search": function(){
			                var _this = this;
			                if (_this.idList.length == 0)
			                    return;
			                var selJsTree3 = [];
			                $.each(_this.idList, function(i,vJsTreeId){
			                    var vJsTree = $("#" + vJsTreeId ).jstree(true);
			                    // var selJsTree = _.filter(vJsTree._model.data , {state : {selected: true } });
			                    var selJsTree = _.filter(vJsTree._model.data , function( data ){
			                        // if (data.id == "#")
			                        // 	return false;
			                        if (data['original'] == null || data.original["field"] == null)
			                            return false;
			                        if ( data.state.selected == null ) 
			                            return false;
			                        var vSelected = data.state.selected;
			                        if ( vSelected)
			                            return true;
			                        $.each(vJsTree.get_node(data.id).children_d, function(i, nodeId){
			                            var vNode = vJsTree.get_node(nodeId);
			                            if ( vNode.state.selected) {
			                                vSelected = true;
			                                return false;
			                            }
			                        });
			                        // if ( vJsTree.get_bottom_checked(data.id).length > 0 )
			                        // 	return true;
			
			                        return vSelected;
			
			                    });
			                    var selJsTree1 = _.map(selJsTree, function(data, i){
			                        var obj = {};
			
			                        // // Customize if field is different with Original field
			                        // var _datas = data.id.split(";;;");
			                        // var _col = _datas[1];
			                        // if ( _col != null && data.original.field != 'GUBUN' ){
			                        //     var _cols = _col.split("/");
			                        //     var textIndex = _.findIndex(_datas.slice(2), function(o) { return o == data.text; });
			                        //     var keyIndex   = textIndex - 0;
			                        //     var _field = _cols[keyIndex];
			                        //     if ( _field == null) 
			                        //         debugger;
			                        //     var _field1 = decamelize(_field,'_')
			                        //     obj[ _field1.toUpperCase() ] = data.text; 
			                        // }else{
			                        //     // obj[_.camelCase(data.original.field)] = data.text;
			                        //     obj[ data.original.field] = data.text;
			                        // }
			                        obj[ data.original.field] = data.original.value;
			
			                        return obj;
			
			                    });
			                    var selJsTree2 = serializeArrayJSON(selJsTree1);
			                    
			                    $.each(selJsTree2, function(field, data){
			                        var obj = {
			                            field : field ,
			                            // value: [].concat(data)
			                            value: data , 
			                            isArray : _.isArray(data)
			                        };
			                        selJsTree3.push( obj );
			                    });
			                    
			                });
			                $("#searchJson").val(JSON.stringify({fields: selJsTree3}));
			                // var parameter = $("#form").serializeFormJSON();
			                // var removedList = _.remove(selJsTree3,{field:'GUBUN'} );
			            }

		};
		var gridProperties = [
			{
				"eAnnotations": {
					"details": {
						"_xmi:id": "_SmZmEUg2EeqonN_RS9oRzw",
						"_key": "uuid",
						"_value": "_Xiv-mF9QEDek0JnbBus9EQ",
						"__prefix": null
					},
					"_xmi:id": "_SmZmEEg2EeqonN_RS9oRzw",
					"_source": "genmymodel",
					"__prefix": null
				},
				"annotations": {
					"eAnnotations": {
						"details": {
							"_xmi:id": "_SmZmFEg2EeqonN_RS9oRzw",
							"_key": "uuid",
							"_value": "_Xiv-mV9QEDek0JnbBus9EQ",
							"__prefix": null
						},
						"_xmi:id": "_SmZmE0g2EeqonN_RS9oRzw",
						"_source": "genmymodel",
						"__prefix": null
					},
					"_xsi:type": "gmmjpa:Id",
					"_xmi:id": "_SmZmEkg2EeqonN_RS9oRzw",
					"__prefix": null
				},
				"type": {
					"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
					"__prefix": null
				},
				"_xmi:id": "_SmZmD0g2EeqonN_RS9oRzw",
				"_name": "table_name",
				"__prefix": null
			},
			{
				"eAnnotations": {
					"details": {
						"_xmi:id": "_SmZmF0g2EeqonN_RS9oRzw",
						"_key": "uuid",
						"_value": "_Xiv-ml9QEDek0JnbBus9EQ",
						"__prefix": null
					},
					"_xmi:id": "_SmZmFkg2EeqonN_RS9oRzw",
					"_source": "genmymodel",
					"__prefix": null
				},
				"annotations": {
					"eAnnotations": {
						"details": {
							"_xmi:id": "_SmZmGkg2EeqonN_RS9oRzw",
							"_key": "uuid",
							"_value": "_Xiv-m19QEDek0JnbBus9EQ",
							"__prefix": null
						},
						"_xmi:id": "_SmZmGUg2EeqonN_RS9oRzw",
						"_source": "genmymodel",
						"__prefix": null
					},
					"_xsi:type": "gmmjpa:Id",
					"_xmi:id": "_SmZmGEg2EeqonN_RS9oRzw",
					"__prefix": null
				},
				"type": {
					"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
					"__prefix": null
				},
				"_xmi:id": "_SmZmFUg2EeqonN_RS9oRzw",
				"_name": "column_name",
				"__prefix": null
			},
			{
				"eAnnotations": {
					"details": {
						"_xmi:id": "_SmZmHUg2EeqonN_RS9oRzw",
						"_key": "uuid",
						"_value": "_XiwloF9QEDek0JnbBus9EQ",
						"__prefix": null
					},
					"_xmi:id": "_SmZmHEg2EeqonN_RS9oRzw",
					"_source": "genmymodel",
					"__prefix": null
				},
				"type": {
					"_href": "http://www.eclipse.org/emf/2002/Ecore#//EString",
					"__prefix": null
				},
				"_xmi:id": "_SmZmG0g2EeqonN_RS9oRzw",
				"_name": "code_category",
				"__prefix": null
			}
		];
		var v_schema_search = {
			"type": "Vertical",
			"id": "searchConditionHorizontalLayout",
			"name": "searchConditionHorizontalLayout",
			"label": "",
			"controlCss": [
				{
					"code": "min-height",
					"value": "30px"
				}
			],
			"elements": [
				{
					"label": "",
					"type": "HorizontalLayout",
					"cls": "",
					"containerCss": [],
					"elements": [
						{
							"containerCss": [],
							"label": "",
							"id": "searchVervical",
							"type": "Vertical",
							"elements": [
								{
									"label": "",
									"type": "HorizontalLayout",
									"id": "searchHorizontalLayout",
									"name": "searchHorizontalLayout",
									"containerCss": [
										{
											"code": "min-height",
											"value": "25px"
										}
									],
									"elements": [
										{
											"type": "SearchHeader",
											"id": "table_name_column_name_SearchHeader",
											"name": "table_name_column_name_SearchHeader",
											"label": "",
											"text": "Table_name ...",
											"width": "100px"
										},
										{
											"type": "jsTreeSearch",
											"id": "table_name_column_name_jsTreeSearch",
											"name": "table_name_column_name_jsTreeSearch",
											"label": "gensrcTabColsTree Search",
											"text": " ",
											"keys": [
												{
													"codeColumn": "table_name",
													"nameColumn": "table_name"
												},
												{
													"codeColumn": "column_name",
													"nameColumn": "column_name"
												}
											],
											"rootText": "Select tableName/columnName",
											"relation": {
												"parentEntityName": "gensrc_tab_cols",
												"childEntityName": "gensrc_cmm_use",
												"columns": [
													{
														"parentColumn": "table_name",
														"childColumn": "table_name",
														"index": 0
													},
													{
														"parentColumn": "column_name",
														"childColumn": "column_name",
														"index": 1
													}
												]
											},
											"popValues": [],
											"events": {
												"changed.jstree": function (e, data) {
												                if (data.event != null) {
												                    fn_search();
												                }
												            },

												"loaded.jstree": function (e, data) {
												                // getGridData();
												            }

											},
											"sqlId": "gensrcCmmUse.gensrcTabCols.jstreesearch",
											"data": function(){
											        var _this = this;
											        var rtnList = [];
											        $.ajax({
											            url: "${pageContext.request.contextPath}/genericlListJson.html",
											            data: {"sqlid": _this.sqlId }, 
											            async: false,
											            success:  function(response){
											                rtnList = response.dataList;
											            }
											        });
											        return rtnList;
											    },

											"entityId": "gensrc_tab_cols",
											"width": "150px"
										},
										{
											"type": "SearchHeader",
											"id": "gensrcCmmCdCodeCategorySearchHeader",
											"name": "gensrcCmmCdCodeCategorySearchHeader",
											"label": "",
											"text": "Codecategory",
											"width": "100px"
										},
										{
											"type": "multiCombo",
											"id": "gensrcCmmCdCodeCategorySearchMultiCombo",
											"name": "gensrcCmmCdCodeCategorySearchMultiCombo",
											"label": "",
											"text": "Code_category",
											"jpa_column": {
												"parent_column": "code_category",
												"child_column": "code_category"
											},
											"sqlId": "gensrcCmmUse.gensrcCmmCd.multicombo",
											"entityId": "gensrc_cmm_cd",
											"multiselectOpt": {
												"multiple": true
											},
											"width": "150px",
											"options": {
												"cd": "CODE_CATEGORY",
												"name": "CODE_CATEGORY"
											},
											"data": function(){
											                var rtnList = [];
											                $.ajax({
											                    url: "${pageContext.request.contextPath}/genericlListJson.html",
											                    data: {"sqlid": "gensrcCmmUse.gensrcCmmCd.multicombo"}, 
											                    async: false,
											                    success:  function(response){
											                        // rtnList = response.dataList;
											                        
											                        $.each(response.dataList,function(i,d){
											                            if(d != null){
											                                rtnList.push(d);
											                                if (response.dataList.length <= 100 )
											                                    d["selected"] = "selected";
											                            }
											                                
											                        });
											                    }
											                });
											                return rtnList;
											
											            },

											"events": {
												"change": function(e){
												                    fn_search();
												                }

											}
										}
									]
								}
							]
						},
						{
							"label": "",
							"type": "HorizontalLayout",
							"cls": "btn_txt",
							"containerCss": [
								{
									"code": "margin-left",
									"value": "10px"
								},
								{
									"code": "float",
									"value": "right"
								}
							],
							"elements": [
								{
									"type": "ButtonBootstrap",
									"id": "btnSearch",
									"name": "btnSearch",
									"label": "SEARCH",
									"containerCss": [
										{
											"code": "margin-right",
											"value": "3px"
										}
									],
									"events": {
										"click": function(){
										                                                fn_search();
										                                            }

									}
								}
							]
						}
					]
				}
			]
		};
		var v_schema_content = {
			"type": "Vertical",
			"id": "contentVertical",
			"name": "contentVertical",
			"label": "",
			"elements": [
				{
					"type": "grid",
					"id": "gensrcCmmUseGrid",
					"name": "gensrcCmmUseGrid",
					"label": "",
					"text": "Gensrc_cmm_use",
					"sqlId": "gensrcCmmUse.gensrcCmmUse",
					"entityId": "gensrc_cmm_use",
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
						"pager": "#gensrcCmmUseGridPager",
						"sqlId": "gensrcCmmUse.gensrcCmmUse",
						"gridId": "gensrcCmmUseGrid",
						"modelVarName": "genSrc052301Jpa",
						"url": function(){ 
						                    return	"${pageContext.request.contextPath}/genericlListPageJson.html?" + 
						                        $("#form").serialize() + 
						                        "&sqlid=gensrcCmmUse.gensrcCmmUse.page.list" +  
						                        "&paging_sqlid=gensrcCmmUse.gensrcCmmUse.page.total" 
						                },

						"editurl": "${pageContext.request.contextPath}/ssdCusDummySaveJson.html",
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
						"gridComplete": function () {
						                    var grid = $(this).jqGrid();
						                    var gridParam = grid.getGridParam();
						                    var show_filter = true;
						                    if ( gridParam.filterToolbarShow != null 
						                        && gridParam.filterToolbarShow == false )
						                        show_filter = false; 
						                    if (show_filter){
						                        grid.jqGrid('filterToolbar',
						                        {
						                            defaultSearch:'cn'
						                            // JSON stringify all data from search, including search toolbar operators
						                            ,stringResult: true
						                            // instuct the grid toolbar to show the search options
						                            // ,searchOperators: true
						                        }
						                        );
						                    }
						                    
						                    
						                    grid.navGrid(gridParam.pager ,
						                        // the buttons to appear on the toolbar of the grid
						                        { edit: true, add: true, del: true, search: false,  refresh: true, view: true, position: "left", cloneToTop: false  
						                            ,addfunc: function(){
						                                commonFunc.fn_view_detail.call(this,'add');
						                            }
						                            , editfunc : function(){
						                                commonFunc.fn_view_detail.call(this,'edit');
						                            }, viewfunc : function(){
						                                commonFunc.fn_view_detail.call(this,'view');
						                            }
						
						                        }
						                        // options for the Edit Dialog
						                        ,{  }
						                        // options for the Script Master Add Dialog
						                        
						                        ,{	
						                            addCaption: "Add Script Master",
						                            modal:true,
						                            recreateForm: true,
						                            closeAfterAdd: true,
						                            reloadAfterSubmit: true,
						                            //template: template,
						                            errorTextFormat: function (data) {
						                                return 'Error: ' + data.responseText
						                            },
						                            onInitializeForm : function(formid){
						                                $(formid).attr('method','POST');
						                                $(formid).attr('action','');
						                                $(formid).attr('enctype','multipart/form-data');
						                                $(formid).css("font-size","14px");
						                                
						                            },
						                            afterSubmit: function(response, postdata) 
						                            { 
						                                var grid = $(this).jqGrid();
						                                var gridParam = grid.getGridParam();
						                                var formdata = this.ownerDocument.FormPost;
						                                var fd = new FormData(formdata);  	
						                                var response1 = {};
						                                
						                                $.ajax({
						                                    url: "${pageContext.request.contextPath}/genericSaveJson.html?sqlid=" + gridParam.sqlId + ".insert",
						                                    type: "POST",
						                                    data: fd, 
						                                    async: false,
						                                    cache: false,
						                                    contentType: false,
						                                    processData: false,
						                                    success:  function(data){
						                                        response1 = data;
						                                        if(response1.result == 'success'){
						                                            // Cumtomise...
						                                        }
						                                        
						                                    }
						                                });
						                                
						                                //return [success,message,new_id] ;
						                                if(response1.result == 'success'){
						                                    //$(this).trigger('reloadGrid'); 
						                                    return [true, response1.result, ''];
						                                }
						                                else
						                                    return [false, response1.result + ":<br/>" + response1.message , ''];
						                                    
						                            }                         
						                        }
						                        // options for the Script Master Del Dialog 
						                        ,{  
						                            reloadAfterSubmit: true,
						                            afterSubmit: function(response, postdata) { 
						                                //$("#refresh_grid_script").hide();
						                                var grid = $(this);
						                                var paramObj = {
						                                    delRows : []
						                                };
						                                $.each(postdata.id.split(","),function(i,rowid){
						                                    var row = grid.getRowData(rowid);
						                                    paramObj.delRows.push(row);
						                                });
						                                
						                                //  
						                                paramObj.loop_id = "delRows";
						                                $.ajax({
						                                    url: "${pageContext.request.contextPath}/genericSaveJson.html",
						                                    type: "POST",
						                                    data: {
						                                        searchJson: JSON.stringify(paramObj),
						                                        sqlid: "gensrcCmmUse.gensrcCmmUse.delete"
						                                    }  , 
						                                    async: false,
						                                    success:  function(data){
						                                        response1 = data;
						                                        if(response1.result == 'success'){
						                                        
						                                            msg = "Del Success!";
						                                            $("#dialog-confirm").html(msg);
						                                            $("#dialog-confirm").dialog({
						                                                resizable: false,
						                                                modal: true,
						                                                title: "Success",
						                                                //height: 200,
						                                                width: 200,
						                                                dialogClass: 'no-close',
						                                                closeOnEscape: false,
						                                                buttons: [
						                                                    {
						                                                        text: "OK",
						                                                        click: function() {
						                                                            $( this ).dialog( "close" );		
						                                                            // fn_search_script();
						                                                        }
						                                                    }
						                                                ]
						                                            });
						                                        }
						                                        
						                                    }
						                                });
						                                
						                                //return [success,message,new_id] ;
						                                if(response1.result == 'success'){
						                                    //$(this).trigger('reloadGrid'); 
						                                    return [true, response1.result, ''];
						                                }
						                                else
						                                    return [false, response1.result + ":<br/>" + response1.message , ''];
						                                    
						                            }
						                        }
						                        ,{ 
						                            multipleSearch: true,
						                            multipleGroup: true
						                        }
						                        
						                    );
						                    if ($(gridParam.pager).find(".ui-pg-button[title=Copy]").length == 0 && true) {
						                        grid.navButtonAdd(gridParam.pager, {
						                            caption : "", 
						                            title: "Copy",
						                            buttonicon : "glyphicon-copy",
						                            onClickButton: function(){ 
						                                var theGrid = $(this).jqGrid();
						                                var parentRowKey = theGrid.jqGrid('getGridParam','selrow');
						                                if ( parentRowKey == null )   {
						                                    $("#dialog-confirm").html("Please, select row");
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
						                                    return;
						                                }
						                                commonFunc.fn_view_detail.call(this,'copy');
						                                // alert("Deleting Row");
						                            }, 
						                            position:"last"
						                        });
						                        var td_cp = $(gridParam.pager).find(".ui-pg-table .ui-pg-button[title='Copy']")
						                        var td_add = $(gridParam.pager).find(".ui-pg-table .ui-pg-button[title='Add new row']");
						                        td_add.after(td_cp);
						
						
						                    }
						                },

						"onCellSelect": function (rowId, iCol, content, event) {
						
						                    var grid = $(this).jqGrid();
						                    var row = grid.jqGrid('getRowData',rowId);
						                    var cms = grid.jqGrid("getGridParam", "colModel");
						                    var cm = cms[iCol];
						
						                    var oFrm = document.getElementById("form1");
						
						                    var v_property = _.find(gridProperties, { _name : cm.name.toLowerCase() });
						                    
						                    //customize
						                    var somCondition = ( v_property != null && 
						                        v_property._documentation != null &&
						                        v_property._documentation.file_info != null );
						
						                    if ( somCondition ){
						                        var path_column = v_property._documentation.file_info.path_column ;
						                        var path = '${pageContext.request.contextPath}'+ row[path_column] ;
						                        if((/\\.(txt|config|pdf|jpg|jpeg|gif|png|log)$/i).test(path)){
						                            var newWin1 = window.open("", "filedownload", "width=1200,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
						                            
						                            oFrm.action =  path;
						                            oFrm.method = "post";
						                            oFrm.target = 'filedownload'; 
						                            oFrm.submit();		
						                            newWin1.focus();
						                        }else if(row[cm.name].match(/\.([\w]+)$/i) != null){
						                            //var src = "/dashboard/filedownloadJson.html";
						                            //src += "?filename=" + row.FILE_NAME;
						                            //src +="&path=" + row.FILE_PATH;
						                            //document.getElementById('file_iframe').src =  src;
						                            
						                            var isIE = /*@cc_on!@*/false || !!document.documentMode; // At least IE6
						                            if (isIE){
						                                //var fileData = ['\\ufeff' + "${pageContext.request.contextPath}" + row.FILE_PATH];
						                                //var blobObject = new Blob(fileData);
						                                //window.navigator.msSaveOrOpenBlob(blobObject, row.FILE_NAME);
						                                var link = document.createElement('a');
						                                // customize for same path and name ==> formalize 
						                                var value_split = row[cm.name].split("/");
						                                var return_text = value_split.pop();
						                                // link.download = row[cm.name];
						                                link.download = return_text;
						                                link.href = "${pageContext.request.contextPath}" + row[path_column] ;
						                                //Firefox requires the link to be in the body
						                                document.body.appendChild(link);
						                                link.click();
						                                link.target = '_blank';
						                                document.body.removeChild(link);
						
						                            }else{
						                                var link = document.createElement('a');
						                                // customize for same path and name ==> formalize 
						                                var value_split = row[cm.name].split("/");
						                                var return_text = value_split.pop();
						                                // link.download = row[cm.name];
						                                link.download = return_text;
						                                link.href = "${pageContext.request.contextPath}" + row[path_column] ;
						                                //Firefox requires the link to be in the body
						                                document.body.appendChild(link);
						                                link.click();
						                                document.body.removeChild(link);
						                            }
						                                                                    
						                        }
						                    }
						                },

						"subGrid": false,
						"subgridtype": "json",
						"entityId": "gensrc_cmm_use",
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
						                        $.each([].concat(gridProperties), function(i, prop){
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
						                            url: "${pageContext.request.contextPath}/genericlListJson.html?sqlid=gensrcCmmUse.gensrcCmmUse.one" ,
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
						                                                        url: "${pageContext.request.contextPath}/genericSaveJson.html",
						                                                        type: "POST",
						                                                        data: {
						                                                            searchJson: JSON.stringify(paramObj),
						                                                            fieldName: this.state.name,
						                                                            fieldValue: this.state.value,
						                                                            fieldValueOrigin: this.state.value_origin,
						                                                            userId: $("#userId").val(),
						                                                            // sqlid: "dashboard.ssd_sm.script_master.update"
						                                                            sqlid: "gensrcCmmUse.gensrcCmmUse.edit"
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
							"entityName": "gensrc_cmm_use",
							"editable": true,
							"gridId": "gensrcCmmUseGrid",
							"editrules": {
								"edithidden": true
							},
							"referenceId": "reference::gensrc_tab_cols::gensrc_cmm_use",
							"topRefrenceId": "reference::gensrc_tab_cols::gensrc_cmm_use",
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
							                        var result = " class='contextMenu contextMenu-parent'";
							                        result += " style='vertical-align: middle;";
							                        // red
							                        // result += "color: #d34b4b;font-weight: bolder;cursor:pointer;'";
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
							"entityName": "gensrc_cmm_use",
							"editable": true,
							"gridId": "gensrcCmmUseGrid",
							"editrules": {
								"edithidden": true
							},
							"referenceId": "reference::gensrc_tab_cols::gensrc_cmm_use",
							"topRefrenceId": "reference::gensrc_tab_cols::gensrc_cmm_use",
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
							                        var result = " class='contextMenu contextMenu-parent'";
							                        result += " style='vertical-align: middle;";
							                        // red
							                        // result += "color: #d34b4b;font-weight: bolder;cursor:pointer;'";
							                        result += "cursor:pointer;'";
							                        result += " gridId='" + vGridOpt.gridId + "'";
							                        result += " entityId='" + vGridOpt.entityId + "'";
							                        result += " columnName='" + cm.name + "'";
							                        result += " cellValue='" + rawObject[cm.name] + "'";
							                        
							                        return result;
							                    }

						},
						{
							"label": "Code category",
							"name": "CODE_CATEGORY",
							"id": "CODE_CATEGORY",
							"align": "center",
							"entityName": "gensrc_cmm_use",
							"editable": true,
							"gridId": "gensrcCmmUseGrid",
							"editrules": {
								"edithidden": true
							},
							"referenceId": "reference::gensrc_cmm_cd::gensrc_cmm_use",
							"topRefrenceId": "reference::gensrc_cmm_cd::gensrc_cmm_use",
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
							                        var result = " class='contextMenu contextMenu-parent'";
							                        result += " style='vertical-align: middle;";
							                        // red
							                        // result += "color: #d34b4b;font-weight: bolder;cursor:pointer;'";
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
		};
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
			                    if(false){
			                        //  tree deselect all
			                        var vJstreeList = [];
			                        $.each(v_filterPop ,function(k, v){
			                            var targetEl = findAllByElName( v_schema_search , function( _el){
			                                if ( _el.type == "jsTreeSearch"){
			                                    let _target = _.find(_el.relation.columns, function(col){
			                                        return col.childColumn.toUpperCase() ==  k.toUpperCase();
			                                    });
			                                    if( _target != null)
			                                        return true;
			                                }
			                            });
			    
			                            if ( targetEl != null){
			                                if (targetEl.type == "jsTreeSearch"){
			                                    if( _.find(vJstreeList,{id : targetEl.id}) == null){
			                                        vJstreeList.push(targetEl);
			                                    }
			                                    targetEl.popValues.push(v);
			                                    
			                                }
			                            }
			                            
			                        });
			                        $.each(vJstreeList, function (i,tree) {  
			                            var vTree = $("#" + tree.id ).jstree(true);
			                            vTree.deselect_all(true);
			                            vTree.select_node(tree.popValues.join(';;;'));
			                        });
			    
			                        $.each(v_filterPop ,function(k, v){
			                            var targetEl = findAllByElName( v_schema_search , function( _el){
			                                if( _el.type == "multiCombo"){
			                                    if( _el.jpa_column.child_column.toUpperCase() == k.toUpperCase())
			                                        return true;
			                                }else if ( _el.type == "jsTreeSearch"){
			                                    // let _target = _.find(_el.relation.columns, function(col){
			                                    //     return col.childColumn.toUpperCase() ==  k.toUpperCase();
			                                    // });
			                                    // if( _target != null)
			                                    //     return true;
			                                }else if ( _el.type == "input"){
			                                    if ( _el.columnName.toUpperCase() == k.toUpperCase() )
			                                        return true;
			                                }
			                            });
			    
			                            if ( targetEl != null){
			                                if (targetEl.type == "multiCombo"){
			                                    // origin select
			                                    $("#" + targetEl.id +" option").prop('selected',false);
			                                    $("#" + targetEl.id +" option[value='"  + v + "']").prop('selected',true);
			                                    // // div view
			                                    // $("input[name=multiselect_" + targetEl.name +"]").prop('checked',false);
			                                    // $("input[name=multiselect_" + targetEl.name +"] option[value="  + v + "]").prop('checked',true);
			                                    var mainControl = $("#" + targetEl.id );
			                                    mainControl.multiselect('refresh');
			                                    mainControl.multiselect('widget').css("width","400px");
			                                    mainControl.multiselect('widget').find(".ui-multiselect-filter input").css("width","150px");
			    
			                                }else if (targetEl.type == "jsTreeSearch"){
			                                    // var vTree = $("#" + targetEl.id ).jstree(true);
			                                    // // vTree.deselect_all(true);
			                                    // var seldata = _.find(vTree._model.data , function( data ){
			                                    //     if (data['original'] == null || data.original["field"] == null)
			                                    //         return false;
			                                    //     var vOriginal = data['original'];
			                                    //     if ( vOriginal.field == k && vOriginal.value == v){
			                                    //         return true;
			                                    //     }
			                                    //     return false;
			    
			                                    // });
			                                    // if(seldata != null  && seldata.children != null && seldata.children.length == 0 )
			                                    //     vTree.select_node(seldata.id);
			    
			                                }else if (targetEl.type == "input"){
			                                    $("#" + targetEl.id).val(v);
			                                }
			                            }
			                            
			                            
			                            
			                        });
			                    }
			                    
			                }
			                
			            },

			"fn_pop_select_set": function(){
										
			                if($("#pop_select").val() == "" )
			                    return;
			                var v_pop_select = JSON.parse($("#pop_select").val());
			                if ( _.keys(v_pop_select).length == 0 )
			                    return;
			                if ( _.keys(v_pop_select.search_str_option).length == 0 )
			                    return;
			
			                // find grid
			                var v_grid_schema = findAllByElName(v_schema_content.elements , {type:"grid"});
			                if ( v_grid_schema  == null)
			                    return;
			                
			                // rules Array  2020.01.03
			                v_rules =[];
			                if (typeof v_pop_select.search_str_option.search_field == "string"){
			                    // find item
			                    var v_item = _.find(v_grid_schema.items , {name : v_pop_select.search_str_option.search_field});
			                    if (v_item == null)
			                        return;
			                    /**********************************************/
			                    /****  For Item setting filter initialtext ****/
			                    /**********************************************/
			                    // set searchoptions.defaultValue
			                    var v_item_to_merge = {
			                        searchoptions : {
			                            searchOperMenu: true,
			                            defaultValue: '' + v_pop_select.search_str_option.search_value
			                            //  defaultValue: '^' + v_pop_select.search_str_option.search_value
			                        }								
			                    };
			                    _.merge(v_item, v_item_to_merge);
			                    /**********************************************/
			                    /****  For Grid Setting postData.filers *******/
			                    /**********************************************/
			                    v_rules.push(
			                        {
			                            field : v_pop_select.search_str_option.search_field,
			                            op: "cn",
			                            data : '^' + v_pop_select.search_str_option.search_value
			                        }
			                    );
			                }else if ( _.isArray(v_pop_select.search_str_option.search_field)){
			                    
			                    $.each(v_pop_select.search_str_option.search_field , function(i,search_field){
			                        
			                        if ( search_field.value != null && search_field.value.length > 0){
			                            /**********************************************/
			                            /****  For Item setting filter initialtext ****/
			                            /**********************************************/
			                            // set searchoptions.defaultValue
			                            var v_item = _.find(v_grid_schema.items , {name : search_field.target });
			                            if ( v_item == null )
			                                return true;
			                            var v_item_to_merge = {
			                                searchoptions : {
			                                    searchOperMenu: true,
			                                    defaultValue: '^' + search_field.value
			                                    //  defaultValue: '^' + v_pop_select.search_str_option.search_value
			                                }								
			                            };
			                            _.merge(v_item, v_item_to_merge);
			
			                            /**********************************************/
			                            /****  For Grid Setting postData.filers *******/
			                            /**********************************************/
			                            
			                            v_rules.push(
			                                {
			                                    field : search_field.target,
			                                    op: "cn",
			                                    // data : '^' + v_pop_select.search_str_option.search_value
			                                    data : '^' + search_field.value
			                                }
			                            );
			                        }
			                        
			                    });
			                }else{
			                    return;
			                }
			                    
			                var v_filters = {
			                    groupOp : "AND",
			                    rules : v_rules
			                };
			                
			
			
			                var v_grid_to_merge = {
			                    postData : {
			                        filters : JSON.stringify(v_filters)
			                    }
			                };
			                _.merge(v_grid_schema.gridOpt, v_grid_to_merge);
			
			
			            }

		};
		var entityDoc = {};
		var commonFunc = {
			"sqlId": "gensrcCmmUse.gensrcCmmUse",
			"fn_view_detail": function(_type){
			                var pageBody = parent.$("body");
			                if (pageBody.length == 0)
								pageBody = parent.parent.$("body");
			                // var modalCommon = parent.$("[name=infiniteLogModal]");
			                // if (modalCommon.length == 0 ){
			                //     modalCommon = parent.parent.$("[name=infiniteLogModal]");
			                // }
			                var parent_str = "parent";
			                var modalCommon = eval(parent_str + ".$('[name=infiniteLogModal]')");
			                while(modalCommon.length ==0){
			                    parent_str += ".parent";
			                    modalCommon = eval(parent_str + ".$('[name=infiniteLogModal]')");
			                    pageBody = eval(parent_str + ".$('body')");
			                }
			                
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
			
			                // Form Submit
			                var oFrm = document.getElementById("form");
			                var filter = {};
			                var theGrid = $(this).jqGrid();
			                var parentRowKey = theGrid.jqGrid('getGridParam','selrow');
			                var row = theGrid.getRowData(parentRowKey);
			                var entityId = theGrid.jqGrid('getGridParam','entityId');
			                $.each(gridProperties , function(i,prop){
			                    let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] ,{"_xsi:type" : "gmmjpa:Id"});
			                    if(vId != null){
			                        filter[prop._name.toUpperCase()] = row[prop._name.toUpperCase()];
			                    }
			                });
			                $("#filterPop").val(JSON.stringify(filter));
			
			                var viewName = $("#viewName").val();
			                var viewPath = viewName.split("/");
			                var itemName = viewPath.pop();
			                oFrm.action =  "${pageContext.request.contextPath}/generic.html?viewName=" + viewPath.join("/") + "/" + itemName + "." + _type + "&backgroundColor=FFF&isPop=Y";;
			                // oFrm.action =  "${pageContext.request.contextPath}/generic.html?viewName=common/commonDetail";
			                $("#detailSqlId").val("gensrcCmmUse.gensrcCmmUse.one");
			                $("#detailSqlUpdateId").val("gensrcCmmUse.gensrcCmmUse.edit");
			                $("#detailType").val(_type);
			                // $("#frameName").val( 'frame_' +  _.camelCase( entityId ));
			                // $("#frameName").val( window.frameElement.name );
			                var parentFrameName = "${param.frameName}";
			                if ( _.startsWith( parentFrameName,"frame") ){						
			                    $("#frameName").val( parentFrameName + "." + window.frameElement.name );
			                }else {
			                    $("#frameName").val( window.frameElement.name );
			                }
			                oFrm.method = "post";
			                oFrm.target = frameId;
			                frameDom.show();
			                // Header
			                var filterStrs = [];
			                $.each(filter,function(k,v){
			                    var str = _.camelCase(k);
			                    str += " : " + v;
			                    filterStrs.push(str);
			                });
			                
			                var headStr = '[' + _.camelCase( entityId ) + ' ' +  _.upperCase(_type) + ' ]  '
			                if ( _type != "add" ) 
			                    headStr += filterStrs.join(" , ");			
			
			                modalClone.find(".modal-header h6 span").text(headStr);
			                modalClone.modal();
			                // parent.$("#"+modalId).modal();
			                modalClone.draggable({
			                    handle: ".modal-header"
			                }); 
			                oFrm.submit();
			            },

			"fn_grid_option": function(){
			                var is_pop_select = "${param.is_pop_select}";
			                var is_pop = "${param.isPop}";
			                var is_sub_frame = "${param.isSubFrame}";
			
			                var grid_shema = findAllByElName(v_schema_content.elements , {type: 'grid'});
			                
			                if ( is_sub_frame ==  "Y"){
			                    grid_shema.gridOpt.height = 210;
			                    grid_shema.gridOpt.rowNum = 5;
			                }else if ( is_pop_select ==  "Y"){
			                    grid_shema.gridOpt.height = 420;
			                    grid_shema.gridOpt.rowNum = 15;
			                }else if ( is_pop ==  "Y"){
			                    grid_shema.gridOpt.height = 420;
			                    grid_shema.gridOpt.rowNum = 15;
			                }else {
			                    grid_shema.gridOpt.height = 650;
			                    grid_shema.gridOpt.rowNum = 20;
			                }
			            },

			"fn_add_button_select_in_grid": function(){
			                var is_pop_select = "${param.is_pop_select}";
			                if (is_pop_select != "Y")
								return;
							
							var item = {
								"label": " ",
								"name": "SELECT_BUTTON",
								"id": "SELECT_BUTTON",
								"align": "center",
								"width": 45,
								search : false ,
								"formatter": function(cellValue, options, rowObject){
									var btnHtml = '<button type="button" class="btn btn-warning btn-xs" style="line-height:1" onclick="commonFunc.fn_select_for_parentframe(\''+ options.rowId +'\');">Select</button>';
									return btnHtml;
								}
							};
							var grid_schema = findAllByElName(v_schema_content.elements , {type:'grid'});
							if (grid_schema != null){
								grid_schema.items.push(item);
							}
			            },

			"fn_select_for_parentframe": function(_rowid){
			                var grid_shema = findAllByElName(v_schema_content.elements , {type: 'grid'});
			                var theGrid = $("#" + grid_shema.id).jqGrid();
			    
			                var row = theGrid.getRowData(_rowid);
			                var v_react_target = parentFrame.commonFunc.pop_select_react_object ;
			                var col = v_react_target.dataSrc.parentColumnName.toUpperCase() ;
			                
			                v_react_target.setState({value :row[col] });
			                
			                // search_str : expression	
			                if($("#pop_select").val() != "" ){
			                    var v_pop_select = JSON.parse($("#pop_select").val());
			                    if ( _.keys(v_pop_select).length > 0 ){
			                        if ( _.keys(v_pop_select.search_str_option).length > 0 ){
			                            if (v_pop_select.search_str_option.expression != null){
			                                if (v_pop_select.search_str_option.expression != ""){
			                                    v_react_target.setState({search_str : eval(v_pop_select.search_str_option.expression) });
			                                    
			                                    // search_str : addtional field update
			                                    if (v_pop_select.search_str_option.additional_update_field != null){
			                                        $.each(v_pop_select.search_str_option.additional_update_field, function(k,v){
			                                            var v_addtional_target = _.find(v_react_target.reactObjects,{state: {name : k}});
			                                            if(v_addtional_target != null)
			                                                v_addtional_target.setState({value: row[v]});
			                                        });
			                                    }
			                                    
			    
			                                }
			                            }
			                        }
			                    }
			                }
			                parentFrame.commonFunc.fn_pop_select_callback();
			                // parentFrame.commonFunc.fn_view_sub();
			    
			                // window close
			                setTimeout( function(){
			                    // parent.$("#" + window.frameElement.name.replace("frame","modal")).remove();
			                    parent.$("#" + window.frameElement.name.replace("frame","modal")).modal('toggle');
			                },0);
			    
			            }

		};
		commonFunc.fn_grid_option();
	</script>
	<script  id="script_main">
		$(function () {
			commonFunc.fn_add_button_select_in_grid();
			$("#loader").show();
			setTimeout( function(){
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
				$('#v_schema_searchContainer').html('')
				if($("#filterPop").val() == "" ){
					fn_makeHtml('v_schema_searchContainer',v_schema_search);
				}
				else{
					popParemeters.fn_set();
					popParemeters.fn_pop_select_set();
					findAll("gensrcCmmUseGrid",v_schema_content.elements)[0].label = "";
				}
				$('#v_schema_contentContainer').html('')
				fn_makeHtml('v_schema_contentContainer',v_schema_content);
				$.contextMenu(
					{
						"selector": ".jqgrow td.contextMenu",
						"trigger": "left",
						"build": function($trigger) {
						            var options = {
						                callback: function(key, options) {
						                    // var m = "clicked: " + key;
						                    // window.console && console.log(m) || alert(m);
						                    options.items[key].callback.call(this,key,options);
						                },
						                items: {}
						
						            };
						
						            // if ($trigger.hasClass('something')) {
						            // 	options.items.foo = {name: "foo"};
						            // } else {
						            //     options.items.bar = {name: "bar"};
						            // }
						            var columnName = $trigger.attr("columnName");
						            if (columnName == null)
						                return false;
						
						            var gridId = $trigger.attr("gridId");
						            var grid = $("#"+gridId).jqGrid();
						            var rowId = $trigger.parent().attr("id");
						            var rowData = grid.getRowData(rowId);
						            var vGridOpt = grid.getGridParam();
						            var cms = vGridOpt.colModel;
						            var cm = _.find(cms, {name: $trigger.attr("columnName")} );
						            // var models = eval(vGridOpt.modelVarName);
						            // var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
						            
						            // parents
						            var hasParents = false;
						            var parents = [];
						            if ( cm.referenceId != null){
						                
						                var src = _.find(dataSrc, {"referenceId": cm.referenceId , "topRefrenceId" : cm.topRefrenceId  });
						                // if ( _.includes(_.map(src.childColumnNames, function( _name ){  return _name.toUpperCase(); } ), cm.name.toUpperCase()) ) {
						                var itemName = _.camelCase(src.parentEntity);
						                options.items[itemName] = {
						                    name: "Parents: " + itemName ,
						                    callback : function(key, options){
						                        var m = "clicked: " + key + ", data: " + $(this).text();
						
						                        // Modal Pop
						                        if(true){
						                            var pageBody = parent.$("body");
						                            var modalCommon = parent.$("[name=infiniteLogModal]");
						                            var parent_str = "parent";
						                            var modalCommon = eval(parent_str + ".$('[name=infiniteLogModal]')");
						                            while(modalCommon.length ==0){
						                                parent_str += ".parent";
						                                modalCommon = eval(parent_str + ".$('[name=infiniteLogModal]')");
						                                pageBody = eval(parent_str + ".$('body')");
						                            }
						                            // var modalClone = $(modalCommon.html());
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
						                            
						
						                            // Form Submit
						                            var oFrm = document.getElementById("form");
						                            var viewName = $("#viewName").val();
						                            var viewPath = viewName.split("/");
						                            viewPath.pop();
						                            var filter = {};
						                            $.each(src.childColumnNames , function(i,column){
						                                var parentColumn = src.parentColumnNames[i];
						                                if(rowData[column.toUpperCase()] != null)
						                                    filter[parentColumn.toUpperCase()] = rowData[column.toUpperCase()];
						                                // $(this).attr("cellValue");
						                            });
						                            $("#filterPop").val(JSON.stringify(filter));
						                            oFrm.action =  "${pageContext.request.contextPath}/generic.html?viewName=" + viewPath.join("/") + "/" + itemName + "&backgroundColor=FFF&isPop=Y";;
						                            oFrm.method = "post";
						                            oFrm.target = frameId;
						                            frameDom.show();
						                            // Header
						                            var filterStrs = [];
						                            $.each(filter,function(k,v){
						                                var str = _.camelCase(k);
						                                str += " : " + v;
						                                filterStrs.push(str);
						                            });
						                            var headStr = '[' + itemName + ']  ' +  filterStrs.join(" , ");													
						                            modalClone.find(".modal-header h6 span").text(headStr);
						
						                            modalClone.modal();
						                            // parent.$("#"+modalId).modal();
						                            modalClone.draggable({
						                                handle: ".modal-header"
						                            }); 
						                            oFrm.submit();
						                            
						                        }
						                        return; 
						
						                        // Window Pop
						                        // console.log(m);
						                        var windowName = "Parents: " + itemName;
						                        var newWin1 = window.open("", windowName , "width=1000,height=750, screenY=" + event.screenY + ", top=" + event.screenY + ", screenX=" + event.screenX + ",left=" + (event.screenX + 0) + ", scrollbars=yes,resizable=yes");
						                        var oFrm = document.getElementById("form");	
						                        var viewName = $("#viewName").val();
						                        var viewPath = viewName.split("/");
						                        viewPath.pop();
						                        var filter = {};
						                        // // filter[cm.name] = $(this).text() ;
						                        // var referece = _.find([].concat(src.parentEntity.references ), {"xmi:id": cm.referenceId });
						                        // var child_columns_detail = _.find(reference.eAnnotations.details, { "_key": "child_columns" });
						                        // var child_columns = child_columns_detail._value.split(",");
						                        $.each(src.childColumnNames , function(i,column){
						                            var parentColumn = src.parentColumnNames[i];
						                            if(rowData[column.toUpperCase()] != null)
						                                filter[parentColumn.toUpperCase()] = rowData[column.toUpperCase()];
						                            // $(this).attr("cellValue");
						                        });
						
						                        
						                        $("#filterPop").val(JSON.stringify(filter));
						                        oFrm.action =  "${pageContext.request.contextPath}/generic.html?viewName=" + viewPath.join("/") + "/" + itemName + "&backgroundColor=FFF&isPop=Y";
						                        oFrm.method = "post";
						                        oFrm.target = windowName; 
						                        oFrm.submit();		
						                        newWin1.focus();
						                    }
						                };
						                hasParents = true;
						                // }
						
						            }
						
						            // children
						            var hasChildrens = false;
						            var childrens = childReferences;
						
						            $.each(childrens , function(i,child){
						                var child_columns = child.child_columns;
						                var parent_columns = child.parent_columns;
						                var child_columns_index = _.indexOf(child.parent_columns, cm.name.toLowerCase());
						                if (child_columns_index == -1)
						                    return false;
						                var itemName = _.camelCase(child.childEntityName);
						                options.items[itemName] = {
						                    name: "Child: " + itemName ,
						                    callback : function(key, options){
						                        // var m = "clicked: " + key + ", data: " + $(this).text();
						                        // console.log(m);
						
						                        // Modal Pop
						                        if(true){
						                            var pageBody = parent.$("body");
						                            var modalCommon = parent.$("[name=infiniteLogModal]");                            
						                            var parent_str = "parent";
						                            var modalCommon = eval(parent_str + ".$('[name=infiniteLogModal]')");
						                            while(modalCommon.length ==0){
						                                parent_str += ".parent";
						                                modalCommon = eval(parent_str + ".$('[name=infiniteLogModal]')");
						                                pageBody = eval(parent_str + ".$('body')");
						                            }
						
						                            // var modalClone = $(modalCommon.html());
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
						                            
						
						                            // Form Submit
						                            var oFrm = document.getElementById("form");
						                            var viewName = $("#viewName").val();
						                            var viewPath = viewName.split("/");
						                            viewPath.pop();
						                            var filter = {};
						                            $.each(child_columns , function(i,column){
						                                var parentColumn = parent_columns[i];
						                                if(rowData[column.toUpperCase()] != null)
						                                    filter[column.toUpperCase()] = rowData[parentColumn.toUpperCase()];
						                                // $(this).attr("cellValue");
						                            });
						                            $("#filterPop").val(JSON.stringify(filter));
						                            oFrm.action =  "${pageContext.request.contextPath}/generic.html?viewName=" + viewPath.join("/") + "/" + itemName + "&backgroundColor=FFF&isPop=Y";;
						                            oFrm.method = "post";
						                            oFrm.target = frameId;
						                            frameDom.show();
						                            
						                            // Header
						                            var filterStrs = [];
						                            $.each(filter,function(k,v){
						                                var str = _.camelCase(k);
						                                str += " : " + v;
						                                filterStrs.push(str);
						                            });
						                            var headStr = '[' + itemName + ']  ' +  filterStrs.join(" , ");													
						                            modalClone.find(".modal-header h6 span").text(headStr);
						
						                            modalClone.modal();
						                            // parent.$("#"+modalId).modal();
						                            modalClone.draggable({
						                                handle: ".modal-header"
						                            }); 
						                            oFrm.submit();
						                            
						                        }
						                        return ;
						
						                        // Window Pop
						                        var windowName = "Child: " + itemName;
						                        var newWin1 = window.open("", windowName , "width=1000,height=750, screenY=" + event.screenY + ", top=" + event.screenY + ", screenX=" + event.screenX + ",left=" + (event.screenX + 0) + ", scrollbars=yes,resizable=yes");
						                        var oFrm = document.getElementById("form");	
						                        var viewName = $("#viewName").val();
						                        var viewPath = viewName.split("/");
						                        viewPath.pop();
						                        var filter = {};
						                        // filter[cm.name] = $(this).text() ;
						
						                        $.each(child_columns , function(i,column){
						                            var parentColumn = parent_columns[i];
						                            if(rowData[column.toUpperCase()] != null)
						                                filter[column.toUpperCase()] = rowData[parentColumn.toUpperCase()];
						                            // $(this).attr("cellValue");
						                        });
						
						
						                        $("#filterPop").val(JSON.stringify(filter));
						                        oFrm.action =  "${pageContext.request.contextPath}/generic.html?viewName=" + viewPath.join("/") + "/" + itemName;
						                        oFrm.method = "post";
						                        oFrm.target = windowName; 
						                        oFrm.submit();		
						                        newWin1.focus();
						                    }
						                };
						                hasChildrens = true;
						                
						                
						            });
						            
						            if ( !hasParents && !hasChildrens )
						                return false;
						
						            if ( _.keys(options.items).length == 1 ){
						                options.items[_.keys(options.items)[0]].callback();
						                return false;
						            }
						
						            return options;
						            // return false; 
						        }

					}
				);
				$("#loader").hide();
			},50);
		});
		function fn_search(){
			$("#loader").show();
			setTimeout( function(){
				jstreeInfo.search();
				var theGrid = $("#gensrcCmmUseGrid").jqGrid();
				theGrid.trigger('reloadGrid',[{page:1}]);
				$("#loader").hide();
			},50);
		}
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
<input type="hidden" id="detailSqlId" name="detailSqlId" value=""/>
<input type="hidden" id="detailSqlUpdateId" name="detailSqlUpdateId" value=""/>
<input type="hidden" id="detailType" name="detailType" value=""/>
<input type="hidden" id="frameName" name="frameName" value="${param.frameName}"/>
<input type="hidden" id="isSubFrame" name="isSubFrame" value="${param.isSubFrame}"/>
	<div id="v_schema_searchContainer" class="srch_box2" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>
	<div id="v_schema_contentContainer" class="" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>
</form>
<div id="dialog-confirm"></div>
<div id="loader" style='display:none'></div>
</body>
<jsp:include page="/WEB-INF/views/include/includeReactComponent.jsp"></jsp:include>