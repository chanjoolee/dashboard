<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>

<jsp:include page="/WEB-INF/views/include/include.toolbox.pmstable.jsp"></jsp:include>
<script src="./js/bpmn/gen/genSrc052301Jpa.js"></script>
<!-- <script src="./js/bpmn/gen/genSrc052301JpaFiles.js"></script> -->

<!-- xml to js -->
<script type="text/javascript" src="./js/bpmn/python.js"></script>
<script type="text/javascript" src="./js/bpmn/common.js"></script>
<script type="text/javascript" src="./js/bpmn/class_common.js"></script>
<script type="text/javascript" src="./js/bpmn/class_python.js"></script>
<script type="text/javascript" src="./js/bpmn/class_python_txt.js"></script>
<script type="text/javascript" src="./js/bpmn/java_jsp/class_javaJsp.js"></script>
<!-- <script type="text/javascript" src="./js/bpmn/java_jsp/allFromJpa.js"></script> -->
<!-- <script type="text/javascript" src="./js/bpmn/java_jsp/allFromJpa.bootstrap.js"></script> -->
<script type="text/javascript" src="./js/bpmn/java_jsp/allFromJpa.toolbox.js"></script>
<script type="text/javascript" src="./js/bpmn/java_jsp/class_sql.js"></script>
<!-- jszip -->
<script type="text/javascript" src="./js/Stuk-jszip-3109282/dist/jszip.js"></script>


	<script>
		var enityStr = "";
		var enity = {};
		var workFlowStr = "";
		var workFlow = {};
	
		var config = {};
		config.skipEmptyTextNodesForObj = true;
		//config.arrayAccessForm = "property";
		config.stripWhitespaces = true;
		config.enableToStringFunc = false;
		var x2js = new X2JS(config);
		var genmyModelxmi = "";
		var schema_bpmn = {};
		var schema_jpa = [];
		var v_files = {};
		var v_src = {};		
		
		
		var beforEditRow = {};
		var EfContextPath = "";
		var v_filterPop = {};
		// schema
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
				                    url: "${pageContext.request.contextPath}/genericlListJson.do?" +
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
		var jstreeInfo = {
			"idList": [],
			"search": function(){
			                    var _this = this;
			                    if (_this.idList.length == 0)
			                        return;
			                    var vJsTreeId = _this.idList[0];
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
			                    var selJsTree3 = [];
			                    $.each(selJsTree2, function(field, data){
			                        var obj = {
			                            field : field ,
			                            // value: [].concat(data)
			                            value: data , 
			                            isArray : _.isArray(data)
			                        };
			                        selJsTree3.push( obj );
			                    });
			                    $("#searchJson").val(JSON.stringify({fields: selJsTree3}));
			                    // var parameter = $("#form").serializeFormJSON();
			                    // var removedList = _.remove(selJsTree3,{field:'GUBUN'} );
			                }

		};
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
											"value": "30px"
										}
									],
									"elements": []
								},
								{
									"label": "",
									"type": "HorizontalLayout",
									"id": "searchHorizontalLayout_10",
									"name": "searchHorizontalLayout_10",
									"containerCss": [
										{
											"code": "min-height",
											"value": "30px"
										}
									],
									"elements": [
										{
											"type": "SearchHeader",
											"id": "soruceIdSearchHeader",
											"name": "soruceIdSearchHeader",
											"label": "",
											"text": "Soruceid",
											"width": "100px"
										},
										{
											"type": "input",
											"id": "search_soruceId",
											"name": "search_soruceId",
											"columnName": "SORUCE_ID",
											"label": "Soruce_id",
											"text": " ",
											"controlCss": [
												{
													"code": "margin-left",
													"value": "9px"
												},
												{
													"code": "width",
													"value": "100%"
												},
												{
													"code": "height",
													"value": "22px"
												}
											],
											"containerCss": [
												{
													"code": "width",
													"value": "100px"
												}
											],
											"events": {
												"keypress": function(e){
												                    if(e.which === 13){
												                        fn_search();
												                    }
												                    
												                }

											}
										},
										{
											"type": "SearchHeader",
											"id": "genTypeSearchHeader",
											"name": "genTypeSearchHeader",
											"label": "",
											"text": "Gentype",
											"width": "100px"
										},
										{
											"type": "input",
											"id": "search_genType",
											"name": "search_genType",
											"columnName": "GEN_TYPE",
											"label": "Gen_type",
											"text": " ",
											"controlCss": [
												{
													"code": "margin-left",
													"value": "9px"
												},
												{
													"code": "width",
													"value": "100%"
												},
												{
													"code": "height",
													"value": "22px"
												}
											],
											"containerCss": [
												{
													"code": "width",
													"value": "100px"
												}
											],
											"events": {
												"keypress": function(e){
												                    if(e.which === 13){
												                        fn_search();
												                    }
												                    
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
									// "cls": "btn_txt btn_type_e btn_color_a",
									"containerCss": [
										{
											"code": "margin-right",
											"value": "3px"
										},
										{
											"code": "float",
											"value": "right"
										}
									],
									"events": {
										"click": function(){
										                                                fn_search();
										                                            }

									}
								},
								{
									"type": "ButtonBootstrap",
									"id": "btnDownload",
									"name": "btndownload",
									"label": "DOWNLOAD",
									// "cls": "btn_txt btn_type_e btn_color_a",
									"containerCss": [
										{
											"code": "margin-right",
											"value": "3px"
										},
										{
											"code": "float",
											"value": "right"
										}
									],
									"events": {
										"click": function(){
										                                                // fn_FileDownload();
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
					"id": "gensrcListGrid",
					"name": "gensrcListGrid",
					"label": "Gensrc_list",
					"text": "Gensrc_list",
					"sqlId": "gensrcList.gensrcList",
					"entityId": "_ynOcY30vEemtbe7XArhuwQ",
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
						"pager": "#gensrcListGridPager",
						"sqlId": "gensrcList.gensrcList",
						"gridId": "gensrcListGrid",
						"modelVarName": "genSrc052301Jpa",
						"url": function(){ 
						                    return	"${pageContext.request.contextPath}/genericlListPageJson.do?" + 
						                        $("#form").serialize() + 
						                        "&sqlid=gensrcList.gensrcList.page.list" +  
						                        "&paging_sqlid=gensrcList.gensrcList.page.total" 
						                },

						"editurl": "${pageContext.request.contextPath}/ssdCusDummySaveJson.do",
						"styleUI": "Bootstrap",
						"viewrecords": true,
						"width": "100%",
						"height": 500,
						"multiselect": false,
						"rowNum": 20,
						"rowList": [
							10,
							15,
							20,
							30
						],
						"emptyrecords": "No records to view",
						"gridComplete": function () {
						                    var grid = $(this).jqGrid();
						                    grid.jqGrid('filterToolbar',
						                        {
						                            defaultSearch:'cn'
						                            // JSON stringify all data from search, including search toolbar operators
						                            ,stringResult: true
						                            // instuct the grid toolbar to show the search options
						                            //,searchOperators: true
						                        }
						                    );
						                    var gridParam = grid.getGridParam();
						                    grid.navGrid(gridParam.pager ,
						                        // the buttons to appear on the toolbar of the grid
						                        { edit: false, add: true, del: true, search: false, refresh: true, view: false, position: "left", cloneToTop: false  }
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
						                                    url: "${pageContext.request.contextPath}/genericSaveJson.do?sqlid=" + gridParam.sqlId + ".insert",
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
						                                    url: "${pageContext.request.contextPath}/genericSaveJson.do",
						                                    type: "POST",
						                                    data: {
						                                        searchJson: JSON.stringify(paramObj),
						                                        sqlid: "gensrcList.gensrcList.delete"
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
						                },

						"subGrid": true,
						"subgridtype": "json",
						"entityId": "_ynOcY30vEemtbe7XArhuwQ",
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
						                    var models = eval(vGridOpt.modelVarName);
						                    var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
						                    $.each([].concat(vEntity.properties), function(i, prop){
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
						                        url: "${pageContext.request.contextPath}/genericlListJson.do?sqlid=gensrcList.gensrcList.one" ,
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
						                                                    url: "${pageContext.request.contextPath}/genericSaveJson.do",
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
						                                        items: _.map([].concat(vEntity.properties), function(prop){
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
							"label": "Soruce id",
							"name": "SORUCE_ID",
							"id": "SORUCE_ID",
							"entityName": "gensrc_list",
							"editable": true,
							"gridId": "gensrcListGrid",
							"editrules": {
								"required": true,
								"edithidden": false
							},							
							"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
							                    var grid = $(this).jqGrid();
							                    var vGridOpt = grid.getGridParam();
							                    var models = eval(vGridOpt.modelVarName);
							                    var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
							                    var result = " class='contextMenu'";
							                    // result += " style='vertical-align: middle;";
							                    // result += "color: blue;font-weight: bolder;cursor:pointer;'";
							                    result += " gridId='" + vGridOpt.gridId + "'";
							                    result += " entityId='" + vGridOpt.entityId + "'";
							                    result += " columnName='" + cm.name + "'";
							                    result += " cellValue='" + rawObject[cm.name] + "'";
							                    
							                    return result;
							                }

						},
						{
							"label": "Gen type",
							"name": "GEN_TYPE",
							"id": "GEN_TYPE",
							"entityName": "gensrc_list",
							"editable": true,
							"gridId": "gensrcListGrid",
							"editrules": {
								"required": true,
								"edithidden": false
							},
							"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
							                    var grid = $(this).jqGrid();
							                    var vGridOpt = grid.getGridParam();
							                    var models = eval(vGridOpt.modelVarName);
							                    var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
							                    var result = " class='contextMenu'";
							                    // result += " style='vertical-align: middle;";
							                    // result += "color: blue;font-weight: bolder;cursor:pointer;'";
							                    result += " gridId='" + vGridOpt.gridId + "'";
							                    result += " entityId='" + vGridOpt.entityId + "'";
							                    result += " columnName='" + cm.name + "'";
							                    result += " cellValue='" + rawObject[cm.name] + "'";
							                    
							                    return result;
							                }

						},
						{
							"label": "Url",
							"name": "URL",
							"id": "URL",
							"entityName": "gensrc_list",
							"editable": true,
							width: 500, 
							"gridId": "gensrcListGrid",
							"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
							                    var grid = $(this).jqGrid();
							                    var vGridOpt = grid.getGridParam();
							                    var models = eval(vGridOpt.modelVarName);
							                    var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
							                    var result = " class='contextMenu'";
							                    // result += " style='vertical-align: middle;";
							                    // result += "color: blue;font-weight: bolder;cursor:pointer;'";
							                    result += " gridId='" + vGridOpt.gridId + "'";
							                    result += " entityId='" + vGridOpt.entityId + "'";
							                    result += " columnName='" + cm.name + "'";
							                    result += " cellValue='" + rawObject[cm.name] + "'";
							                    
							                    return result;
							                },
				                formatter : 'link'

						},
						{
							"label": "Btn exec",
							"name": "BTN_EXEC",
							"id": "BTN_EXEC",
							"entityName": "gensrc_list",
							"editable": true,
							"gridId": "gensrcListGrid",
							"cellattr": function( rowId, cellValue, rawObject, cm, rdata ){
							                    var grid = $(this).jqGrid();
							                    var vGridOpt = grid.getGridParam();
							                    var models = eval(vGridOpt.modelVarName);
							                    var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
							                    var result = " class='contextMenu'";
							                    // result += " style='vertical-align: middle;";
							                    // result += "color: blue;font-weight: bolder;cursor:pointer;'";
							                    result += " gridId='" + vGridOpt.gridId + "'";
							                    result += " entityId='" + vGridOpt.entityId + "'";
							                    result += " columnName='" + cm.name + "'";
							                    result += " cellValue='" + rawObject[cm.name] + "'";
							                    
							                    return result;
							                },
							align: 'center',							                
			                formatter : function(cellValue, options, rowObject){
			                	var btnHtml = '<button type="button" class="btn btn-warning btn-sm" onclick="fn_generateClick(\''+ options.rowId +'\');">Generate</button>';
			                	return btnHtml;
			                }

						}
					]
				}
			]
		};
		function fn_generateClick(rowId){
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
		            schema_bpmn =  x2js.xml_str2json(genmyModelxmi);
		            // fn_create_source();
		            generator = new Generator(schema_bpmn,rowData.GEN_TYPE);
		            generator.fn_source();
		            // generator.fn_fileSave();
		        }
		    });
			
		}
		
		var popParemeters = 
					{
						"fn_set": function(){
						            if($("#filterPop").val() != "" ){
						                v_filterPop = JSON.parse($("#filterPop").val());
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

					}
		;
	</script>
	<script  id="script_main">
		$(function () {
			$("#loader").show();
			setTimeout( function(){
				$.each(dictionaries,function(i, src){
					src.data();
				});
				$.each(dataSrc,function(i, src){
					src.data();
				});
				$('#v_schema_searchContainer').html('')
				fn_makeHtml('v_schema_searchContainer',v_schema_search);
				$('#v_schema_contentContainer').html('')
				fn_makeHtml('v_schema_contentContainer',v_schema_content);
				setTimeout(function(){
					if(popParemeters != null)  popParemeters.fn_set(); 
					fn_search();
				} ,1000);
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
						            var grid = $("#"+gridId).jqGrid()
						            var rowId = $trigger.parent().attr("id");
						            var rowData = grid.getRowData(rowId);
						            var vGridOpt = grid.getGridParam();
						            var cms = vGridOpt.colModel;
						            var cm = _.find(cms, {name: $trigger.attr("columnName")} );
						            var models = eval(vGridOpt.modelVarName);
						            var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
						            
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
						                        oFrm.action =  "${pageContext.request.contextPath}/generic.do?viewName=" + viewPath.join("/") + "/" + itemName;
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
						            var childrens = [];
						            if(vEntity.references != null){
						                childrens = [].concat(vEntity.references);
						                $.each(childrens , function(i,child){
						                    var childEntityId = child._referencedEntity;
						                    var childEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": childEntityId } );
						                    var reference = child;
						                    var parent_columns = [];
						                    var child_columns = [];
						                    var child_columns_detail = _.find(reference.eAnnotations.details, { "_key": "child_columns" });
						                    if (child_columns_detail != null) {
						                        child_columns = child_columns_detail._value.split(",");
						                    }
						                    var child_columns_index = _.indexOf(child_columns, cm.name.toLowerCase());
						                    if (child_columns_index == -1)
						                        return false;
						                    var parent_columns_detail = _.find([].concat(reference.eAnnotations.details), { "_key": "parent_columns" });
						                    if (parent_columns_detail != null) {
						                        parent_columns = parent_columns_detail._value.split(",");
						                    }
						
						                    var itemName = _.camelCase(childEntity._name);
						                    options.items[itemName] = {
						                        name: "Child: " + itemName ,
						                        callback : function(key, options){
						                            // var m = "clicked: " + key + ", data: " + $(this).text();
						                            // console.log(m);
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
						                            oFrm.action =  "${pageContext.request.contextPath}/generic.do?viewName=" + viewPath.join("/") + "/" + itemName;
						                            oFrm.method = "post";
						                            oFrm.target = windowName; 
						                            oFrm.submit();		
						                            newWin1.focus();
						                        }
						                    };
						                    hasChildrens = true;
						                    
						                    
						                });
						            }
						            if ( !hasParents && !hasChildrens )
						                return false;
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
				var theGrid = $("#gensrcListGrid").jqGrid();
				theGrid.trigger('reloadGrid',[{page:1}]);
				$("#loader").hide();
			},50);
		}
	</script>
</head>
<body  style="min-width:920px">
<form name="form" id="form" class="">
<input type="hidden" id="sender" name="sender" value="${param.sender}"/>
<input type="hidden" id="filterPop" name="filterPop" value='${param.filterPop}'/>
<input type="hidden" id="viewName" name="viewName" value='${param.viewName}'/>
<input type="hidden" id="viewName" name="viewName" value='${param.viewName}'/>
	<div id="v_schema_searchContainer" class="srch_box2" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>
	<div id="v_schema_contentContainer" class="" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>
</form>
</body>
<jsp:include page="/WEB-INF/views/include/includeReactComponent.jsp"></jsp:include>
<script type="text/aaa" id="pagelistHeadOracle">
	Select 
			*		
		From 
		(
			select
				A.*, ROWNUM AS ROW_NUM
			from 
			(

</script>
<script type="text/aaa" id="pagelistHeadMysql">
	Select 
			*		
		From 
		(
			select
				A.*
			from 
			(

</script>
<script type="text/aaa" id="pagelistFooterOracle">
	) A where 1=1 
			<choose>
				<when test="filters != null and filters != '' and (filters.rules.size() > 0  or (filters.groups != null and filters.groups.size() > 0) )">
					and (
					<if test="filters.rules.size() > 0" >
			       		<foreach collection="filters.rules" item="item" index="index"  open="(" separator="" close=")">
			           		<if test="index > 0 "> !{filters.groupOp} </if>
							<choose>
								<when test="item.data.equalsIgnoreCase('isnull')">${item.field} is null</when>
				    			<when test="item.op =='eq' ">REGEXP_LIKE(!{item.field}, '^' || @{item.data} || '$','i')</when>
				           		<when test="item.op =='ne' ">!{item.field} <![CDATA[ != ]]> @{item.data}</when>
				           		<when test="item.op =='lt' ">!{item.field} <![CDATA[ < ]]> @{item.data}</when>
				           		<when test="item.op =='le' ">!{item.field} <![CDATA[ <= ]]> @{item.data}</when>
				           		<when test="item.op =='gt' ">!{item.field} <![CDATA[ > ]]> @{item.data}</when>
				           		<when test="item.op =='ge' ">!{item.field} <![CDATA[ >= ]]> @{item.data}</when>
				           		<when test="item.op =='bw' ">REGEXP_LIKE(!{item.field}, '^' || @{item.data},'i')</when>
				           		<when test="item.op =='bn' "> NOT REGEXP_LIKE(!{item.field}, '^' || @{item.data},'i')</when>
				           		<when test="item.op =='in' "></when>
				           		<when test="item.op =='ni' "></when>
				           		<when test="item.op =='ew' "> REGEXP_LIKE(!{item.field}, @{item.data}|| '$','i')</when>
				           		<when test="item.op =='en' "> NOT REGEXP_LIKE(!{item.field}, @{item.data}|| '$','i')</when>
				           		<when test="item.op =='cn' ">REGEXP_LIKE(!{item.field}, REGEXP_REPLACE(@{item.data},' ','|'),'i')</when>
				           		<when test="item.op =='nc' ">NOT REGEXP_LIKE(!{item.field}, REGEXP_REPLACE(@{item.data},' ','|'),'i')</when>
				           		</choose>
			       		</foreach>	
			       	</if>	
			       	<if test="filters.groups != null and filters.groups.size() > 0">
		       			<foreach collection="filters.groups" item="group" index="group_index"  open=""  close="">
			       			<if test="group.rules.size() > 0">
			       			!{filters.groupOp}
				           	<foreach collection="group.rules" item="rule" index="rule_index"  open="("   separator="" close=")">
					        	<if test="rule_index > 0 "> !{group.groupOp} </if>
	           		 			<choose>
									<when test="rule.data.equalsIgnoreCase('isnull')">${rule.field} is null</when>	
					           		<when test="rule.op =='eq' ">REGEXP_LIKE(!{rule.field}, '^' || @{rule.data}|| '$','i')</when>
					           		<when test="rule.op =='ne' ">!{rule.field} <![CDATA[ != ]]> @{rule.data}</when>
					           		<when test="rule.op =='lt' ">!{rule.field} <![CDATA[ < ]]> @{rule.data}</when>
					           		<when test="rule.op =='le' ">!{rule.field} <![CDATA[ <= ]]> @{rule.data}</when>
					           		<when test="rule.op =='gt' ">!{rule.field} <![CDATA[ > ]]> @{rule.data}</when>
					           		<when test="rule.op =='ge' ">!{rule.field} <![CDATA[ >= ]]> @{rule.data}</when>
					           		<when test="rule.op =='bw' ">REGEXP_LIKE(!{rule.field}, '^' || @{rule.data},'i')</when>
					           		<when test="rule.op =='bn' "> NOT REGEXP_LIKE(!{rule.field}, '^' || @{rule.data},'i')</when>
					           		<when test="rule.op =='in' "></when>
					           		<when test="rule.op =='ni' "></when>
					           		<when test="rule.op =='ew' "> REGEXP_LIKE(!{rule.field}, @{rule.data} || '$','i')</when>
					           		<when test="rule.op =='en' "> NOT REGEXP_LIKE(!{rule.field}, @{rule.data} || '$','i')</when>
					           		<when test="rule.op =='cn' ">REGEXP_LIKE(!{rule.field}, REGEXP_REPLACE(@{rule.data},' ','|'),'i')</when>
					           		<when test="rule.op =='nc' ">NOT REGEXP_LIKE(!{rule.field}, REGEXP_REPLACE(@{rule.data},' ','|'),'i')</when>
					           		</choose> 
					       	</foreach>
					       	</if>
				       	</foreach>
		       		</if> 
		       		 )
		   		</when>
	   		</choose>
		) A
		where
    	<![CDATA[
	    	A.row_num >  to_number(@{rows}) * (to_number(@{page}) -1) 
	    	and A.row_num <= to_number(@{rows}) * to_number(@{page})
    	]]>
</script>
<script type="text/aaa" id="pagelistFooterMysql">
	) A where 1=1 
			<choose>
				<when test="filters != null and filters != '' and (filters.rules.size() > 0  or (filters.groups != null and filters.groups.size() > 0) )">
					and (
					<if test="filters.rules.size() > 0" >
			       		<foreach collection="filters.rules" item="item" index="index"  open="(" separator="" close=")">
			           		<if test="index > 0 "> !{filters.groupOp} </if>
							<choose>
								<when test="item.data.equalsIgnoreCase('isnull')">${item.field} is null</when>
				    			<when test="item.op =='eq' ">REGEXP_LIKE(!{item.field}, '^' || @{item.data} || '$','i')</when>
				           		<when test="item.op =='ne' ">!{item.field} <![CDATA[ != ]]> @{item.data}</when>
				           		<when test="item.op =='lt' ">!{item.field} <![CDATA[ < ]]> @{item.data}</when>
				           		<when test="item.op =='le' ">!{item.field} <![CDATA[ <= ]]> @{item.data}</when>
				           		<when test="item.op =='gt' ">!{item.field} <![CDATA[ > ]]> @{item.data}</when>
				           		<when test="item.op =='ge' ">!{item.field} <![CDATA[ >= ]]> @{item.data}</when>
				           		<when test="item.op =='bw' ">REGEXP_LIKE(!{item.field}, '^' || @{item.data},'i')</when>
				           		<when test="item.op =='bn' "> NOT REGEXP_LIKE(!{item.field}, '^' || @{item.data},'i')</when>
				           		<when test="item.op =='in' "></when>
				           		<when test="item.op =='ni' "></when>
				           		<when test="item.op =='ew' "> REGEXP_LIKE(!{item.field}, @{item.data}|| '$','i')</when>
				           		<when test="item.op =='en' "> NOT REGEXP_LIKE(!{item.field}, @{item.data}|| '$','i')</when>
				           		<when test="item.op =='cn' ">REGEXP_LIKE(!{item.field}, REGEXP_REPLACE(@{item.data},' ','|'),'i')</when>
				           		<when test="item.op =='nc' ">NOT REGEXP_LIKE(!{item.field}, REGEXP_REPLACE(@{item.data},' ','|'),'i')</when>
				           		</choose>
			       		</foreach>	
			       	</if>	
			       	<if test="filters.groups != null and filters.groups.size() > 0">
		       			<foreach collection="filters.groups" item="group" index="group_index"  open=""  close="">
			       			<if test="group.rules.size() > 0">
			       			!{filters.groupOp}
				           	<foreach collection="group.rules" item="rule" index="rule_index"  open="("   separator="" close=")">
					        	<if test="rule_index > 0 "> !{group.groupOp} </if>
	           		 			<choose>
									<when test="rule.data.equalsIgnoreCase('isnull')">${rule.field} is null</when>	
					           		<when test="rule.op =='eq' ">REGEXP_LIKE(!{rule.field}, '^' || @{rule.data}|| '$','i')</when>
					           		<when test="rule.op =='ne' ">!{rule.field} <![CDATA[ != ]]> @{rule.data}</when>
					           		<when test="rule.op =='lt' ">!{rule.field} <![CDATA[ < ]]> @{rule.data}</when>
					           		<when test="rule.op =='le' ">!{rule.field} <![CDATA[ <= ]]> @{rule.data}</when>
					           		<when test="rule.op =='gt' ">!{rule.field} <![CDATA[ > ]]> @{rule.data}</when>
					           		<when test="rule.op =='ge' ">!{rule.field} <![CDATA[ >= ]]> @{rule.data}</when>
					           		<when test="rule.op =='bw' ">REGEXP_LIKE(!{rule.field}, '^' || @{rule.data},'i')</when>
					           		<when test="rule.op =='bn' "> NOT REGEXP_LIKE(!{rule.field}, '^' || @{rule.data},'i')</when>
					           		<when test="rule.op =='in' "></when>
					           		<when test="rule.op =='ni' "></when>
					           		<when test="rule.op =='ew' "> REGEXP_LIKE(!{rule.field}, @{rule.data} || '$','i')</when>
					           		<when test="rule.op =='en' "> NOT REGEXP_LIKE(!{rule.field}, @{rule.data} || '$','i')</when>
					           		<when test="rule.op =='cn' ">REGEXP_LIKE(!{rule.field}, REGEXP_REPLACE(@{rule.data},' ','|'),'i')</when>
					           		<when test="rule.op =='nc' ">NOT REGEXP_LIKE(!{rule.field}, REGEXP_REPLACE(@{rule.data},' ','|'),'i')</when>
					           		</choose> 
					       	</foreach>
					       	</if>
				       	</foreach>
		       		</if> 
		       		 )
		   		</when>
	   		</choose>
		) A
		LIMIT @{int_limit} OFFSET @{int_offset}
		
</script>
<script type="text/aaa" id="pageTotalFooter">
	) a
	where 1=1 			
	<choose>
		<when test="filters != null and filters != '' and (filters.rules.size() > 0  or (filters.groups != null and filters.groups.size() > 0) )">
			and (
			<if test="filters.rules.size() > 0" >
				<foreach collection="filters.rules" item="item" index="index"  open="(" separator="" close=")">
					<if test="index > 0 "> !{filters.groupOp} </if>
					<choose>
				    <when test="item.op =='eq' ">REGEXP_LIKE(!{item.field}, '^' || @{item.data} || '$','i')</when>
				           		<when test="item.op =='ne' ">!{item.field} <![CDATA[ != ]]> @{item.data}</when>
				           		<when test="item.op =='lt' ">!{item.field} <![CDATA[ < ]]> @{item.data}</when>
				           		<when test="item.op =='le' ">!{item.field} <![CDATA[ <= ]]> @{item.data}</when>
				           		<when test="item.op =='gt' ">!{item.field} <![CDATA[ > ]]> @{item.data}</when>
				           		<when test="item.op =='ge' ">!{item.field} <![CDATA[ >= ]]> @{item.data}</when>
				           		<when test="item.op =='bw' ">REGEXP_LIKE(!{item.field}, '^' || @{item.data},'i')</when>
				           		<when test="item.op =='bn' "> NOT REGEXP_LIKE(!{item.field}, '^' || @{item.data},'i')</when>
				           		<when test="item.op =='in' "></when>
				           		<when test="item.op =='ni' "></when>
				           		<when test="item.op =='ew' "> REGEXP_LIKE(!{item.field}, @{item.data} || '$','i')</when>
				           		<when test="item.op =='en' "> NOT REGEXP_LIKE(!{item.field}, @{item.data} || '$','i')</when>
				           		<when test="item.op =='cn' ">REGEXP_LIKE(!{item.field}, REGEXP_REPLACE(@{item.data},' ','|'),'i')</when>
				           		<when test="item.op =='cn' ">NOT REGEXP_LIKE(!{item.field}, REGEXP_REPLACE(@{item.data},' ','|'),'i')</when>
				           		</choose>
				</foreach>	
			</if>	
			<if test="filters.groups != null and filters.groups.size() > 0">
				<foreach collection="filters.groups" item="group" index="group_index"  open=""  close="">
					<if test="group.rules.size() > 0">
					!{filters.groupOp}
					<foreach collection="group.rules" item="rule" index="rule_index"  open="("   separator="" close=")">
						<if test="rule_index > 0 "> !{group.groupOp} </if>
						<choose>
					           		<when test="rule.op =='eq' ">REGEXP_LIKE(!{rule.field}, '^' || @{rule.data} || '$','i')</when>
					           		<when test="rule.op =='ne' ">!{rule.field} <![CDATA[ != ]]> @{rule.data}</when>
					           		<when test="rule.op =='lt' ">!{rule.field} <![CDATA[ < ]]> @{rule.data}</when>
					           		<when test="rule.op =='le' ">!{rule.field} <![CDATA[ <= ]]> @{rule.data}</when>
					           		<when test="rule.op =='gt' ">!{rule.field} <![CDATA[ > ]]> @{rule.data}</when>
					           		<when test="rule.op =='ge' ">!{rule.field} <![CDATA[ >= ]]> @{rule.data}</when>
					           		<when test="rule.op =='bw' ">REGEXP_LIKE(!{rule.field}, '^' || @{rule.data},'i')</when>
					           		<when test="rule.op =='bn' "> NOT REGEXP_LIKE(!{rule.field}, '^' || @{rule.data},'i')</when>
					           		<when test="rule.op =='in' "></when>
					           		<when test="rule.op =='ni' "></when>
					           		<when test="rule.op =='ew' "> REGEXP_LIKE(!{rule.field}, @{rule.data} || '$','i')</when>
					           		<when test="rule.op =='en' "> NOT REGEXP_LIKE(!{rule.field}, @{rule.data} || '$','i')</when>
					           		<when test="rule.op =='cn' ">REGEXP_LIKE(!{rule.field}, REGEXP_REPLACE(@{rule.data},' ','|'),'i')</when>
					           		<when test="rule.op =='cn' ">NOT REGEXP_LIKE(!{rule.field}, REGEXP_REPLACE(@{rule.data},' ','|'),'i')</when>
					           		</choose>           		 
					</foreach>
					</if>
				</foreach>
			</if> 
				)
		</when>
	</choose>
	) a
</script>
<script type="text/aaa" id="pageTotalHead">
	select 
		ceil(count(*)/ @{rows} ) as total,
		@{page} as page ,
		count(*) records 
	from 
	(
		select a.* from (

</script>
<script type="text/aaa" id="editSqlReactWhere">
	<choose>
		<when test="searchJson != null and searchJson != '' and searchJson.origindatas.size() > 0 " >
			<foreach collection="searchJson.origindatas" item="item" index="index"  >
				and !{item.field} = @{item.value}
			</foreach>
		</when>
		<otherwise>
			and 1=2
		</otherwise>
	</choose>
</script>
<script type="text/aaa" id="jstreeSearchJson">
		<choose>
   			<when test="searchJson != null and searchJson != '' and searchJson.fields != null and searchJson.fields.size() > 0  ">   				
   				<foreach collection="searchJson.fields" item="field" index="index"  open=" and " separator=" and " close="">
	                <choose>
	                	<when test="field.isArray == true ">
		                	!{field.field} in 
			                <foreach collection="field.value" item="item" index="index"  open="(" separator=" , " close=")">
			                	@{item}
			                </foreach>
			        	</when>
			        	<otherwise>
			        		!{field.field} = @{field.value}
			        	</otherwise>
	                </choose>
	                
	            </foreach>
   			</when>
   			<otherwise></otherwise>
   		</choose>
		<choose><when test="sidx != null and sidx != '' "> order by !{sidx} <if test="sord != null and sord != '' "> !{sord} </if> </when><otherwise>order by 1,2</otherwise></choose>
</script>
<iframe name="mainFrame" id="mainFrame" src="/dashboard/generic.do?viewName=schema/manage_tabs&sender=${param.sender}" style="min-width:1000px; width:100%;border: 0;height: 1000px; display:block ;"></iframe>

</html>					