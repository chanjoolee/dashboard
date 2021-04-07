function JpaAllGeneratorBracket( _generator){
    // _generator : class_javaJsp
    var _this = this;
    this.generator = _generator;
    this.includeFile = "include.toolbox.pmstable.jsp";
    this.files = [];
    // files example
    var ex =  {
        fileType: "jsp" ,
        fileName: "file_name" ,
        entityId : 'entity["_xmi:id"]' ,
        foreignEntities : [] ,  // { id:'xxx' , referenceId : 'xxx' }
        schema : {},
        jstrees : []
    };

    
    // ex;
    let dataSrc = {
        // "referenceId" : referenceId ,
        // "parent_entity" : parent ,
        // "parent_columns" : parent_columns ,
        // "child_columns" : child_columns ,
        // "column_map" : column_map ,
        // "sqlId" : sqlId ,
        // "data" : function(){
        //     var _this = this;
        //     $.ajax({
        //         type: "POST",
        //         // url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_test.summary.all.1",
        //         url: "/dashboard/genericlListJson.html?" + 
        //             "&sqlid=" + _this.sqlId ,						
        //         data: {}, 
        //         async: false,
        //         success:  function(response){
        //             var dataList = response.dataList;
        //             $.each(dataList , function(i,data){
        //                 var parent_column = _.find(_this.parent_entity.properties , {"_name": _this.column_map.parent_column});

        //                 if(parent_column != null){         
        //                     var name_column = _.find(parent_column.eAnnotations.details,{"_key":"name_column"});
        //                     if(name_column != null){
        //                         _this.value[ data[parent_column._name.toUpperCase()] ]  = data[name_column._value.toUpperCase()] ;
        //                     }else{
        //                         _this.value[ data[parent_column._name.toUpperCase()] ]= data[parent_column._name.toUpperCase()] ;
        //                     }
                                
        //                 }
                        
        //             } );
        //         }
        //     });
        // },
        // "value": {}
    }; 

    /**
     * Jpa Model
     */
    this.Model = _this.generator.schema_bpmn.Model;
    this.sqlPreFix = this.generator.rowData.SORUCE_ID + ".";
    /**
     * Model에서 SqlPreFix를 정하는 경우 Copy & Paste를 했을 경우 Mapper 의 중복에러가 발생한다.
     * 그래서 입력하는 
     */
    // if( _.find([].concat(this.Model.eAnnotations.details),{"_key": "sqlPreFix"}) != null)
    //     this.sqlPreFix = _.find([].concat(this.Model.eAnnotations.details),{"_key": "sqlPreFix"})._value + ".";

    this.sqlAddDate = true;
    if( _.find([].concat(this.Model.eAnnotations.details),{"_key": "sqlAddDate", "_value": "false"}) != null)
        this.sqlAddDate = false;
    

    // Toda Str
    var today = new Date();
    var yyyy = today.getFullYear().toString();
    var MM = _.padStart(today.getMonth() + 1,2,'0');
    var dd = _.padStart(today.getDate(), 2,'0');
    var hh = _.padStart(today.getHours(), 2,'0');
    var mm = _.padStart(today.getMinutes(), 2,'0');
    var ss = _.padStart(today.getSeconds(), 2,'0');
    
    _this.dateStr = yyyy + '.' + MM + '.' + dd + '.' + hh + '.' +  mm + '.' + ss;
    this.init();
}

JpaAllGeneratorBracket.prototype.getDefaultOption = function( _schema, _file ){
    var _this = this;
    // find parent table
    var foreign_entities = _file.foreignEntities ;
    var vEntity = _.find([].concat(_this.Model.ownedEntities),{"_xmi:id": _schema.entityId} );
    var varModelName = _.camelCase(_this.Model._name+ '_jpa');
    var defaultOption = {
        "Vertical": {
            // width : "100%"
        } ,
        "HorizontalLayout": {
            // width : "100%"
        } ,
        "SearchHeader": {
            // width : "100px"
            containerCls : "col-sm-2"
        },
        "multiCombo" : {
            multiselectOpt : {multiple: true},
            width: "150px",
            options : {
                cd : "CODE_ID",
                name: "CODE_NAME"
            },
            data: function(){
                var rtnList = [];
                $.ajax({
                    url: "./genericlListJson.html",
                    data: {"sqlid": "$sqlId"}, 
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
            // events:{
            //     "change" : function(e){
            //         // fn_search();
            //         e.target.htmlMaker.instance.fn_search();
            //     }
            // },
            containerCls : "col-sm"
        } ,
        "Button" : {
            // cls: 'btn_txt btn_type_e btn_color_a',
            // containerCss:[
            //     {code: 'margin-right', value:'3px'} ,
            //     {code: 'float', value:'right'} 
            // ],
            label: _file._name 
        } ,
        "grid" : {
            containerCss:[
                {code: 'width', value:'100%'},
                {code: 'margin-top', value:'10px'},
                {code: 'background-color', value:'#FFF'},
            ],	
            label: _file._name ,
            
            gridOpt : {
                // datatype:'local',
                datatype:'json',
                pager: "#" + _schema.id + "Pager",
                sqlId: _schema.sqlId ,
                gridId: _schema.id ,
                modelVarName : varModelName,                
                // url
                editurl: './ssdCusDummySaveJson.html',
                styleUI : 'Bootstrap',
                viewrecords: true,
                width: '100%',
                autowidth: true,
			    // shrinkToFit: true,
                height : 650 ,
                // sortable: true,
                // multiSort:true,
                multiselect: false,
                multiboxonly: true,
                multiSort: true ,
                rowNum: 20,
                rowList:[5,10,15,20,30],
                emptyrecords: "No records to view"
            }
            

        },
        "input" : {
            // controlCss :[
            //     {code:'margin-left',value:'9px'} ,
            //     {code:'width',value:'100%'},
            //     {code:'height',value:'22px'}
            // ],
            // containerCss :[
            //     {code:'width',value:'100px'}
            // ],
            containerCls : "col-sm",
            events:{
                "keypress" : function(e){
                    if(e.which === 13){
                        // fn_search();
                        e.target.htmlMaker.instance.fn_search();
                    }
                    
                }
            }
        },
        "jsTreeSearch" : {
            // width: "150px"
            containerCls : "col-sm"
        }
    };

        // multicombo code , name
        if( _schema.type == "multiCombo" && _schema.entityId != undefined){
            // code_id, code_name
            let vColumn = _.find([].concat(vEntity.properties), {"_name": _schema.jpa_column.parent_column});
            let name_column = _.find([].concat(vColumn.eAnnotations.details),{"_key":"name_column"});
            if ( name_column != null ){
                defaultOption.multiCombo.options = {
                    cd : vColumn._name.toUpperCase(),
                    name: name_column._value.toUpperCase()
                }
            }else{
                defaultOption.multiCombo.options = {
                    cd : vColumn._name.toUpperCase(),
                    name: vColumn._name.toUpperCase()
                }
            }
        }
    
        if( _schema.type == "grid" && _schema.entityId != undefined){
            // items
            defaultOption.grid.items = _.map([].concat(vEntity.properties), function(prop){
                var v_prop_doc = _this.documentToObject(prop._documentation);
                var gridItem = {
                    label : _.capitalize(_.upperCase(prop._name)),
                    name : prop._name.toUpperCase() ,
                    id : prop._name.toUpperCase() ,
                    align: 'center',
                    entityName : vEntity._name ,
                    editable: true ,
                    gridId : _schema.id 
                };
                
                gridItem.editrules = {edithidden:true} ;
                let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] , { "_xsi:type": "gmmjpa:Id" });
                if (vId != null) {
                    gridItem.editrules.edithidden = true ;                    
                    gridItem.required = true;
                }
                
                // list hiden columns
                var hidden = _.find(prop.eAnnotations.details,{"_key":"is_list_hidden","_value":"true"});
                if(hidden != null){
                    gridItem.hidden = true;
                }
    
                // find parent table ==> to be replaced by making datasource function
                // var hasParents = _this.fn_datasource(foreign_entities, vEntity, prop, _file, rtnObj);
                var hasParents = _this.fn_datasource_by_top(vEntity, prop, _file, gridItem);
                _this.fn_datasource_by_dictionary(vEntity, prop, _file, gridItem);
                if(gridItem.referenceId != null && gridItem.referenceId != "" ){
                    gridItem.unformat = function( cellval ,  opts , cell){
                        var grid = $(this).jqGrid();
                        var originVal = $(cell).attr("cellValue");
                        //opts.colModel.editoptions.value[]
                        return originVal;
                    }
                }
    
    
    
                // Child setAttr;
                var hasChildrens = false;
                var childrens = [];
                if(vEntity.references != null){
                    childrens = [].concat(vEntity.references);
                    $.each(childrens , function(i,child){
                        // var childEntityId = child._referencedEntity;
                        // var childEntity = _.find([].concat(_this.Model.ownedEntities),{"_xmi:id": childEntityId } );
                        // if ( _.includes(_.map([].concat(childEntity.properties), function( property ){  
                        //         return property._name.toUpperCase(); 
                        //     } ), prop._name.toUpperCase()) ) {
                        //     hasChildrens = true;
                        // }
                        let parent_columns_detail = _.find(child.eAnnotations.details, {"_key" : "parent_columns"} );
                        let parent_columns = parent_columns_detail._value.split(",");
                        if( _.includes(parent_columns, prop._name) ) 
                            hasChildrens = true;
    
                    });
                }
    
                if (hasParents && hasChildrens){
                    gridItem.cellattr = function( rowId, cellValue, rawObject, cm, rdata ){
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
                    };
                }else if ( hasParents ){
                    gridItem.cellattr = function( rowId, cellValue, rawObject, cm, rdata ){
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
                    };
                }else if ( hasChildrens ){
                    gridItem.cellattr = function( rowId, cellValue, rawObject, cm, rdata ){
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
                    };
                }else {
                    gridItem.cellattr = function( rowId, cellValue, rawObject, cm, rdata ){
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
                    };
                }
                
                // datetime
                if ( prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" ){
                    gridItem.editoptions = {
                        size: 12,
                        maxlengh: 12,
                        dataInit: function (element) {
                            //$(element).datepicker({ dateFormat: 'yy-mm-dd', timepicker: true });
                            $(element).datetimepicker({ 
                                //formatDate: 'Y-m-d'
                                //, formatTime:'H:i'
                                format : 'Y-m-d H:i:s'
                                //format : 'H:i:s'
                                //, datepicker: false
                                , timepicker: true 
                                , step: 15
                                //, useSeconds: true //default true
                            });
                        }
                    }
                }   
    
                // file_info ==> formatter
                if (v_prop_doc.file_info != null){
                    gridItem.formatter = function(cellValue, options, rowObject){                    
                        // var return_text = "Download";
                        var return_text = cellValue;
                        if (cellValue != null){
                            var value_split = cellValue.split("/");
                            return_text = value_split.pop();
                        }                    
                        // som condition
                        
                        return return_text;
                    };
                    gridItem.unformat = function( cellval ,  opts , cell){
                        var grid = $(this).jqGrid();
                        var originVal = $(cell).attr("cellValue");
                        //opts.colModel.editoptions.value[]
                        return originVal;
                    }
    
                }
    
                _this.fn_set_grid_custom_item(prop,gridItem);
                return gridItem;
            });
    
            // custom columns from references
            if ( vEntity.references != null) {
                $.each( [].concat(vEntity.references) , function(i, ref){
                    if(ref._documentation == undefined)
                        return true;
                    // if(task._name == "regex pattern")
                    //     debugger;
                    var matches = ref._documentation.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
                    if(matches){
                        $.each(matches,function(i,m){
                            var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                            var content = match.groups.content;
                            // var custom_obj = JSON.parse(content);            
                            eval("var custom_obj = " + _.unescape(content));
                            if ( custom_obj.subquery != null ){
                                let gridItem = {
                                    label : _.capitalize(_.upperCase(custom_obj.subquery.column_name)),
                                    name : custom_obj.subquery.column_name.toUpperCase() ,
                                    id : custom_obj.subquery.column_name.toUpperCase() ,
                                    align: 'center',
                                    entityName : vEntity._name ,
                                    editable: true ,
                                    gridId : _schema.id 
                                };
    
                                if(custom_obj.subquery.properties != null){
                                    _.merge(gridItem,custom_obj.subquery.properties);
                                }
    
                                var _index = _.findIndex(defaultOption.grid.items, function(o) { return o.name == custom_obj.subquery.column_after.toUpperCase(); })
                                if (_index == (defaultOption.grid.items.length -1) )
                                    defaultOption.grid.items.push(gridItem);
                                else
                                    defaultOption.grid.items.splice(_index,0,gridItem);
    
                            }
                            
                        });        
                    }
                });
            }
    
            // custom columns from Entities
            if ( vEntity._documentation != null) {            
                    
                var matches = vEntity._documentation.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
                if(matches){
                    $.each(matches,function(i,m){
                        var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                        var content = match.groups.content;
    
                        // var custom_obj = JSON.parse(content);            
                        eval("var custom_obj = " + _.unescape(content));
                        // sub column 
                        if ( custom_obj.custom_columns != null ){
                            $.each([].concat(custom_obj.custom_columns), function(i ,custom_column){
                                let gridItem = {
                                    label : _.capitalize(_.upperCase(custom_column.column_name)),
                                    name : custom_column.column_name.toUpperCase() ,
                                    id : custom_column.column_name.toUpperCase() ,
                                    align: 'center',
                                    entityName : vEntity._name ,
                                    editable: true ,
                                    gridId : _schema.id 
                                };
    
                                if(custom_column.properties != null){
                                    _.merge(gridItem, custom_column.properties);
                                }
    
                                var _index = _.findIndex(defaultOption.grid.items, function(o) { return o.name == custom_column.column_after.toUpperCase(); });
                                if (_index == (defaultOption.grid.items.length -1) )
                                    defaultOption.grid.items.push(gridItem);
                                else
                                    defaultOption.grid.items.splice(_index,0,gridItem);
                            });
                            
    
                        }
                       
                        // grid option from Entities
                        if ( custom_obj.grid_option != null){
                            _.merge(defaultOption.grid.gridOpt, custom_obj.grid_option);
                        }
                    });        
                }
                
            }
    
            
    
            // details show 
            var isDetail = false;
            // deferent with bpmn
            var objDetail =  _.find(vEntity.eAnnotations.details, {"_key":"keyword_detail_hide", "_value":"true"});
            if( objDetail == null ) isDetail = true;
            if(isDetail){
          
                var vGridOpt = {
                    subGrid : false ,
                    subgridtype: 'json' ,
                    entityId : _schema.entityId,
    
                    subGridRowExpanded: function(parentRowID, parentRowKey){
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
                            url: "./genericlListJson.html?sqlid=$sqlId.one" ,
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
                                                            sqlid: "$sqlId.edit"
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
                };
                _.merge(defaultOption.grid.gridOpt ,  vGridOpt );
    
            }
            delete _schema.jpa_enity;
        }
    
        return defaultOption[_schema.type];
}

JpaAllGeneratorBracket.prototype.init = function(){
    var _this = this;
    _this.fn_entities();    
}


JpaAllGeneratorBracket.prototype.fn_entities = function () {
    var _this = this;
    // SqlPreFix For Each Entity
    $.each(_this.Model.ownedEntities, function(i, entity){
        var v_entity_doc_obj = _this.documentToObject(entity._documentation);
        var v_entity_sql_prefix = (function () {
            var rtn = "";
            if(v_entity_doc_obj.sqlPreFix != null)
                rtn = v_entity_doc_obj.sqlPreFix + "." + _this.sqlPreFix;
            else
                rtn = _this.sqlPreFix;
            return rtn;
        })();

        entity.sqlPreFix = v_entity_sql_prefix;
    });

    $.each(_this.Model.ownedEntities, function(i, entity){
        _this.fn_entities_general(entity);
        if(_this.generator.dbType == 'mysql')
            // 데이타베이스를 생성한다.
            _this.manageTable(entity);
    });

    // Make Main Page
}

/**
 * entity 를 그대로 쓰는 것이 아니고 entity에 대응하는는 fileObj 를 생성한다. 그리고 이후에는 fileObj를 이용한다. 
 * @param {*} entity 
 */
JpaAllGeneratorBracket.prototype.fn_entities_general = function (entity) {
    var _this = this;    
    var file_name = _.camelCase( entity._name );
    var v_entity_doc_obj = _this.documentToObject(entity._documentation);
    if ( v_entity_doc_obj.dbType == null )
        v_entity_doc_obj.dbType = _this.generator.dbType;
    v_entity_doc_obj.entityId = file_name;

    
    var fileObj = {
        fileType: "jsp" ,
        editType: "general",
        fileName: file_name ,
        entityId : entity["_xmi:id"] ,
        foreignEntities : [] ,  // { id:'xxx' , referenceId : 'xxx' }
        childEntities : [] , // { id:'xxx' , referenceId : 'xxx' }
        schema : {},
        gridProperties : [].concat( _this.entityPropsToObject(entity.properties) ) , // for coonbinient
        sqlGenerator : {},
        // sources : [] ,
        dataSources : [] ,
        childReferences : [] ,
        dictionaries : [] ,
       
        entity_doc : entity._documentation ,
        entity_doc_obj : v_entity_doc_obj ,
        entity_sql_prefix : entity.sqlPreFix,
        commonFunc: {
            sqlId : entity.sqlPreFix + _.camelCase( file_name ) + "." + _.camelCase(entity._name) 
        },
        popParemeters : {
            
        }
        

    };

    _this.files.push(fileObj);
    _this.fn_foreign(fileObj);
    _this.fn_children(fileObj);
    _this.xmlMake(fileObj);
    _this.fn_schema(fileObj);
    _this.fn_defaultOption(fileObj.schema, fileObj);
}

JpaAllGeneratorBracket.prototype.fn_foreign = function ( _file ) {
    // if ( _file.fileName == "ssdSmScriptsetMap")
    //     debugger;
    var _this = this;
    $.each(_this.Model.ownedEntities, function (i , entity) {
        if (entity.references == undefined)
            return true;
        var reference = _.find([].concat(entity.references), { _referencedEntity: _file.entityId });
        // entity.references.eAnnotations.details
        if( reference != null){
            var foreign = {
                id: entity["_xmi:id"] ,
                referenceId : reference["_xmi:id"] ,                    
                schemas: []
            };            
            _file.foreignEntities.push(foreign);
        }
            
            
    });
}

JpaAllGeneratorBracket.prototype.fn_get_top_parent = function( _parentInfo ){
    var _this = this;
    // find parent
    var reference = {};
    var parent_columns_detail = {};
    var child_columns_detail = {};
    var index = -1;
    var parentInfo = null;

    var parentInfo = null;
    $.each(_this.Model.ownedEntities, function (i , entity) {
        if (entity.references == undefined)
            return true;
        reference = _.find([].concat(entity.references), { _referencedEntity: _parentInfo.entityId });
        if ( reference != null){
            parent_columns_detail = _.find([].concat(reference.eAnnotations.details), { "_key": "parent_columns" });
            child_columns_detail = _.find(reference.eAnnotations.details, { "_key": "child_columns" });
            index = _.findIndex(child_columns_detail["_value"].split(","), function(o){  return o == _parentInfo.columnName; });
            if (index > -1 ){
                var parentColumnName = parent_columns_detail["_value"].split(",")[index];                
                parentInfo = {
                    "entityId": entity["_xmi:id"] ,
                    "columnName" : parentColumnName ,
                    "nameColumn" : parentColumnName ,
                    "columnNames" : parent_columns_detail["_value"].split(",") ,
                    "referenceId" : reference["_xmi:id"]
                }
                var parent_column_prop = _.find([].concat(entity.properties), {"_name": parentColumnName });
                var name_column = _.find([].concat(parent_column_prop.eAnnotations.details),{"_key":"name_column"});   
                if ( name_column != null)
                    parentInfo.nameColumn = name_column["_value"];
                
                return false;
            }
                
        }
    });


    if (parentInfo != null){
        parentInfo = _this.fn_get_top_parent(parentInfo);
        return parentInfo;
    }else{
        return _parentInfo;
    }
    
}

JpaAllGeneratorBracket.prototype.fn_get_parent = function( _parentInfo ){
    var _this = this;
    // find parent
    var reference = {};
    var parent_columns_detail = {};
    var child_columns_detail = {};
    var index = -1;

    var parentInfo = null;
    $.each(_this.Model.ownedEntities, function (i , entity) {
        if (entity.references == undefined)
            return true;
        reference = _.find([].concat(entity.references), { _referencedEntity: _parentInfo.entityId });
        if ( reference != null){
            parent_columns_detail = _.find([].concat(reference.eAnnotations.details), { "_key": "parent_columns" });
            child_columns_detail = _.find(reference.eAnnotations.details, { "_key": "child_columns" });
            index = _.findIndex(child_columns_detail["_value"].split(","), function(o){  return o == _parentInfo.columnName; });
            if (index > -1 ){
                var parentColumnName = parent_columns_detail["_value"].split(",")[index];                
                parentInfo = {
                    "entityId": entity["_xmi:id"] ,
                    "columnName" : parentColumnName ,
                    "nameColumn" : parentColumnName ,
                    "columnNames" : parent_columns_detail["_value"].split(",") ,
                    "childColumnNames" : child_columns_detail["_value"].split(",") ,
                    "referenceId" : reference["_xmi:id"]
                }
                var parent_column_prop = _.find([].concat(entity.properties), {"_name": parentColumnName });
                var name_column = _.find([].concat(parent_column_prop.eAnnotations.details),{"_key":"name_column"});   
                if ( name_column != null)
                    parentInfo.nameColumn = name_column["_value"];
                
                return false;
            }
                
        }
    });


    return parentInfo;
    
}

JpaAllGeneratorBracket.prototype.fn_children = function ( _file ) {
    var _this = this;
    var vEntity = _.find(_this.Model.ownedEntities, {"_xmi:id": _file.entityId});
    if (vEntity.references == undefined)
        return true;
    var references = [].concat(vEntity.references);
    // entity.references.eAnnotations.details
    $.each(references, function(i, reference){
        var parent_columns = [];
        var parent_columns_detail = _.find([].concat(reference.eAnnotations.details), { "_key": "parent_columns" });
        if (parent_columns_detail != null) {
            parent_columns = parent_columns_detail._value.split(",");
        }
        var child_columns = [];
        var child_columns_detail = _.find(reference.eAnnotations.details, { "_key": "child_columns" });
        if (child_columns_detail != null) {
            child_columns = child_columns_detail._value.split(",");
        }

        var refApply = {
            referenceId : reference["_xmi:id"],
            parentEntityName : vEntity._name ,
            childEntityName: reference._referencedEntity,
            childEntityId: reference._referencedEntity,
            parent_columns : parent_columns,
            child_columns : child_columns
        }        
        _file.childReferences.push(refApply);
    });




}

/**
 * 화면을 생성하는 엔진의 input 값이 schema를 생성한다.
 * @param {*} _file 
 */
JpaAllGeneratorBracket.prototype.fn_schema = function ( _file) {
    var _this = this;
    var schema = {
        "search" : {
            name: "v_schema_search",
            containerId : "v_schema_search" + "Container",
            schema: {
                "type": "Vertical",
                "id" : "searchConditionHorizontalLayout",
                "name": "searchConditionHorizontalLayout",
                "label" : "" ,
                // "controlCss" : [
                //     {code: "min-height", value: "30px"}
                // ],
                
                elements : [
                    {
                        label:'',
                        type: 'HorizontalLayout',
                        cls: '',
                        containerCls: "no-gutters row",		
                        elements:[
                            {
                                label:'',
                                id: "searchVertical",
                                type:'Vertical',
                                containerCls: "col-sm-10",
                                elements:[
                                    //1line
                                    {
                                        label:'',
                                        type: 'HorizontalLayout',
                                        id: "searchHorizontalLayout",
                                        name: "searchHorizontalLayout",
                                        containerCls: "no-gutters row",
                                        containerCss : [
                                            {code: "width", value : "100%" }
                                        ],
                                        elements:[
                                            
                                        ]
                                    }
                                    //2line
                                    
                                    
                                ]
                            },                            
                            //검색버튼
                            {
                                label:'',
                                type: 'HorizontalLayout',
                                containerCls : "col-sm-2",
                                elements:[
                                    {
                                        type:'ButtonBootstrap',
                                        id: 'btnSearch',
                                        name: 'btnSearch',
                                        label:'SEARCH',
                                        //width: '50px',
                                        // cls: 'btn_txt btn_type_e btn_color_a',
                                        // containerCss:[
                                        //     {code: 'margin-right', value:'3px'}
                                        // ],
                                        events:{
                                            click : function(){
                                                // fn_search();
                                                this.htmlMaker.instance.fn_search();
                                            }
                                        }
                                    }
                                    // ,{
                                    //     type:'Button',
                                    //     id: 'btnDownload',
                                    //     name: 'btndownload',
                                    //     label:'DOWNLOAD',
                                    //     //width: '50px',
                                    //     cls: 'btn_txt btn_type_e btn_color_a',
                                    //     containerCss:[
                                    //         {code: 'margin-right', value:'3px'},
                                    //         {code: "display" , value: 'none'}
                                    //     ],
                                    //     events:{
                                    //         click : function(){
                                    //             // fn_FileDownload();
                                    //         }
                                    //     }
                                    // }
                                
                                ]
                            }
                        
                        ]
                    }                   
                ]
            }

        }, 
        "contents": {
            name: "v_schema_content",
            containerId : "v_schema_content" + "Container",
            schema: {
                "type": "Vertical",
                "id": "contentVertical",
                "name": "contentVertical",
                "label": "",
                elements : [

                ]


            }
        }
    };
    _file.schema = schema;
    var entity = _.find(_this.Model.ownedEntities, {"_xmi:id": _file.entityId});    
    _this.fn_schema_search(_file);
    _this.fn_schema_content(_file);

}

/***
* 검색조건 만들기
*/
JpaAllGeneratorBracket.prototype.fn_schema_search = function ( _file) {
    var _this = this;
    var schemaVertical = _this.generator.findAllByElName( _file.schema.search.schema , { id: 'searchVertical' } );
    var schema = _this.generator.findAllByElName( _file.schema.search.schema , { id: 'searchHorizontalLayout' } );
    var schemaClone = _.cloneDeep(schema);
    

    var vEntity = _.find(_this.Model.ownedEntities, {"_xmi:id": _file.entityId});

    // MultiCombo <== Parents
    var searchCols = [];
    var schemaNew = {};
    $.each(_file.foreignEntities, function (i, parentDef) {
        var parent = _this.generator.findAllByElName( _this.Model , {"_xmi:id":parentDef.id });
        var reference = _.find([].concat(parent.references), { _referencedEntity: _file["entityId"] });
        var parent_columns = [];
        var child_columns = [];
        
        var child_columns_detail = _.find(reference.eAnnotations.details, { "_key": "child_columns" });
        if (child_columns_detail != null) {
            child_columns = child_columns_detail._value.split(",");
            
        }

        var parent_columns_detail = _.find(reference.eAnnotations.details, { "_key": "parent_columns" });
        if (parent_columns_detail != null) {
            parent_columns = parent_columns_detail._value.split(",");
        }
        //  to do : refColumn 
        if(child_columns.length == 1){
            // multiCombo make
            _this.fn_schema_search_combo(child_columns, vEntity, parent_columns, parent, parentDef , _file, schema);
        }else if ( child_columns.length > 1 ) {
            // multiCombo jstree
            // schemaNew = _this.fn_schema_search_jstree(schemaNew, schemaClone, i, schemaVertical, child_columns, parent, reference, vEntity, parent_columns, _file, parentDef);
            _this.fn_schema_search_jstree(child_columns,parent_columns, vEntity, parent, reference, parentDef , _file, schema);
            
        }
    });

    // All Columns <== Entity   
    var j = 0; 
    // 2019-09-19. <== Not need Search condition 
    return;
    
    $.each([].concat( vEntity.properties ), function(i, prop){
        let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] ,{"_xsi:type" : "gmmjpa:Id"});
        
        if( _this.generator.findAllByElName(schemaVertical.elements,{type:'multiCombo', jpa_column:{child_column: prop._name} }) != null   ){
            return true;
        }

        // let jstrees = _this.generator.findAllByElName(schemaVertical.elements,{type:'jsTreeSearch'} );
        if( _this.generator.findAllByElName(schemaVertical.elements, function(el){
            if ( el.type ==  'jsTreeSearch'){
                if (el.relation.childEntityName  == vEntity._name ) {
                    if ( _.find( el.relation.columns , {  childColumn: prop._name} ) != null ){
                        return true;
                    }else
                        return false;
                }
            }
            
            return false;
        }) != null   ){
            return true;
        }
        if (vId == null){
            return true;
        }
        // new line
        if ( j%3 == 0 ){
            schemaNew = _.cloneDeep(schemaClone);
            schemaNew.id = "searchHorizontalLayout_1" + i;
            schemaNew.name = "searchHorizontalLayout_1" + i;
            schemaVertical.elements.push(schemaNew);
        }
        var obj_txt = {
            type: "SearchHeader",
            id: _.camelCase( prop._name ) + 'SearchHeader' ,
            name: _.camelCase( prop._name ) + 'SearchHeader' ,
            label: '' ,
            text : _.capitalize(_.camelCase(prop._name))
        };
        var inputName = 'search_' + _.camelCase( prop._name);
        var obj_input = {
            type: "input",
            id: inputName ,
            name: inputName ,
            columnName: prop._name.toUpperCase() ,
            label: _.capitalize(prop._name)  ,
            text : ' '
           
        };
        schemaNew.elements.push(obj_txt);        
        schemaNew.elements.push(obj_input);
        j = j + 1;
    });


}
JpaAllGeneratorBracket.prototype.fn_schema_search_combo = function(child_columns, vEntity, parent_columns, parent, parentDef, _file, schema) {
    var _this = this;
    $.each(child_columns, function (i, child_column) {
        var childProp = _.find([].concat(vEntity.properties), { "_name": child_column });
        var parent_column = parent_columns[i];
        var parentProp = _.find([].concat(parent.properties), { "_name": parent_column });
        var obj_txt = {
            type: "SearchHeader",
            id: _.camelCase(parent._name + '_' + parentProp._name) + 'SearchHeader',
            name: _.camelCase(parent._name + '_' + parentProp._name) + 'SearchHeader',
            label: '',
            text: _.capitalize(_.camelCase(child_column))
            
        };
        var obj_combo = {
            type: "multiCombo",
            id: _.camelCase(parent._name + '_' + parentProp._name) + 'SearchMultiCombo',
            name: _.camelCase(parent._name + '_' + parentProp._name) + 'SearchMultiCombo',
            label: '',
            text: _.capitalize(parentProp._name),
            jpa_column: { "parent_column": parentProp._name, "child_column": child_column },
            events:{
                "change" : function(e){
                    // fn_search();
                    e.target.htmlMaker.instance.fn_search();
                }
            }
            
        };
        if (parentDef["schemas"] == undefined)                     
            parentDef["schemas"] = [];
        parentDef.schemas.push(obj_combo);
        _this.sqlSelect(_file, parent, obj_combo);
        schema.elements.push(obj_txt);
        schema.elements.push(obj_combo);
    });
}

JpaAllGeneratorBracket.prototype.fn_schema_search_jstree = function(child_columns, parent_columns, vEntity,  parent,reference, parentDef, _file, schema) {
    var _this = this;
    var obj_txt = {
        type: "SearchHeader",
        id: child_columns.join("_") + '_SearchHeader',
        name: child_columns.join("_") + '_SearchHeader',
        label: '',
        text : _.capitalize(child_columns[0]) + " ..."
        // text: _.map(child_columns, function (col, i) {
        //     return _.capitalize(col);
        // }).join(" ")
       
    };

    // For name columns
    var vKeys = _.map(parent_columns, function(col, i){
        var paramForTopParent1 = { 
            "entityId": parent["_xmi:id"] , 
            "columnName": col
        };
        var topParent = _this.fn_get_top_parent(paramForTopParent1);
        var topParentEntity = _.find([].concat(_this.Model.ownedEntities),{"_xmi:id": topParent.entityId} );
        if (paramForTopParent1 != topParent){
            var rtnObj =  {
                codeColumn: col,
                nameColumn: col,
                "topParent" : topParent.entityId
            };
            var column_prop  = _.find([].concat( topParentEntity.properties ), {"_name": topParent.columnName });
            var name_column = _.find([].concat(column_prop.eAnnotations.details),{"_key":"name_column"});
            if ( name_column != null )
                rtnObj.nameColumn = name_column["_value"];
            return rtnObj;

        }else {
            var rtnObj = {
                codeColumn: col,
                nameColumn: col
            };
            var column_prop  = _.find([].concat( parent.properties ), {"_name": col });
            var name_column = _.find([].concat(column_prop.eAnnotations.details),{"_key":"name_column"});
            if ( name_column != null )
                rtnObj.nameColumn = name_column["_value"];
            return rtnObj;
        }

    });

    var obj_tree = {
        type: 'jsTreeSearch',
        id: child_columns.join("_") + '_jsTreeSearch',
        name: child_columns.join("_") + '_jsTreeSearch',
        label: _.camelCase(parent._name) + 'Tree Search',
        text: ' ',
        // width: '200px',
        // keys: _.map(parent_columns, function (col, i) { return col.toUpperCase(); }),
        keys: vKeys ,
        rootText: 'Select ' + _.map(child_columns, function (col, i) { return _.camelCase(col); }).join("/"),
        referenceId: reference._id,
        // relationColumns: { "parent_columns": parent_columns, "child_columns": child_columns },
        relation: {
            parentEntityName: parent._name,
            childEntityName: vEntity._name,
            columns: _.map(parent_columns, function (pcol, i) {
                return {
                    parentColumn: pcol,
                    childColumn: child_columns[i],
                    index: i
                };
            })
        },
        popValues : [] ,
        events: {
            "changed.jstree": function (e, data) {
                if (data.event != null) {
                    // fn_search();
                    e.target.htmlMaker.instance.fn_search();
                }
            },
            "loaded.jstree": function (e, data) {
                // getGridData();
            }
        }
    };
    if (parentDef["schemas"] == undefined)
        parentDef["schemas"] = [];
    parentDef.schemas.push(obj_tree);
    _this.sqlSelectJsTree(_file, parent, obj_tree);
    schema.elements.push(obj_txt);
    schema.elements.push(obj_tree);    
}

JpaAllGeneratorBracket.prototype.fn_schema_content = function ( _file) {
    var _this = this;
    var schema = _this.generator.findAllByElName( _file.schema.contents.schema , { id: 'contentVertical' } );
    var entity = _.find(_this.Model.ownedEntities, {"_xmi:id": _file.entityId});

    var vType = "grid";
    if (_file.entity_doc_obj != null && _file.entity_doc_obj.type != null)
        vType = _file.entity_doc_obj.type ;

    var schema_obj = {
        type: vType,
        id: _.camelCase(entity._name) + 'Grid' ,
        name: _.camelCase(entity._name) + 'Grid' ,
        label: "" , //_.capitalize(entity._name) ,
        text : _.capitalize(entity._name)
    };
    _this.sqlSelect( _file, entity, schema_obj );
    _this.whereAndDetail( _file, entity, schema_obj );
    _this.sqlInsert( _file, entity, schema_obj );
    _this.sqlEdit( _file, entity, schema_obj );
    _this.sqlDelete( _file, entity, schema_obj );

    // _.merge(obj_combo,  _this.getDefaultOption(schema_obj, _file) );
    schema.elements.push(schema_obj);

}

JpaAllGeneratorBracket.prototype.fn_defaultOption = function(jsobject, _file){
    _this = this;
    var str = ""
    $.each(jsobject,function(k,v){
        if( v == null || v == undefined)
            return true;

        if(typeof(v) ==  "object"){
            if( v["type"] != null ){
                _.merge( v , _this.getDefaultOption(v, _file));
            }
            _this.fn_defaultOption(v , _file);
        }
        
    });
    

}

/**
 * generate js file include entire entity , data_sources
 */
JpaAllGeneratorBracket.prototype.fn_gen_js = function () {
    var _this = this;
    
}

JpaAllGeneratorBracket.prototype.fn_generate = function () {
    var _this = this;
    _this.fn_generate_main_bracket();    
}

JpaAllGeneratorBracket.prototype.fn_generate_main_bracket = function () {
    var _this = this; 

    // 하나의 파일로 몰지 않고 여러개의 파일로 나눈다.
    var jpaFiles = [];
    $.each( _.orderBy( _.filter( _this.files ,{editType: "general"} )  , ['entityId'],['asc']) , function( i, _file){
        jpaFiles.push(_file.fileName  + ".js");
    });
    var menu_src = "";
    var searchJson =  { 
        menus : _.orderBy( _.filter( _this.files ,{editType: "general"} )  , ['entityId'],['asc']) 
        , jpaFiles : ['jpaFiles.js'].concat( jpaFiles ) 
        , jpaVarName : "jpaFiles"
        , folder : _this.Model._name + "." + _this.dateStr
    };
    $.ajax({
        // url: "./template" ,
        url: "./template.html" ,
        type : "POST",
        async: false,
        data : {    
            searchJson : JSON.stringify(searchJson),
            // searchJson : searchJson ,
            viewName : "bracket.vm" ,
            menuFolder : 'schema/'+ _this.Model._name + "." + _this.dateStr + '/'
        },
        success: function (content){
            menu_src = content;
        } ,
        error : function (){
            // editor.setData("");
        },
        
    });

    var menu_dom = $(menu_src);
    var side_menu = menu_dom.find(".br-sideleft-menu");
    side_menu.html("");

    // Iframe Create
    mainFrame.$('html').html();
    var fileObj = {
        fileType: "jsp" ,
        fileName : "main" ,
        sources : menu_src.split("\n")
    };

    _this.files.push(fileObj);

}

JpaAllGeneratorBracket.prototype.fn_generate_jsmodel = function() {
    
    // Model 
    var _this = this;
    var _model = _.cloneDeep( _this.Model );
    var varName = 'jpa';
    var fileName = varName + ".js";
    _this.generator.fuctionToString( _model);
    var modelStr = JSON.stringify( _model, null, '\t');
    var codes = modelStr.split('\n');
    var src = "\t\tvar " + varName + " = ";
    var sources = [];
    for(var i=0;i<codes.length;i++){
        if ( i == 0 )
            src += codes[i];
        else
            src = "\t\t" + codes[i];
        // function 
        if(src.match(/"function/)){
            var src1 = src.replace(/"function/,"function");
            var src2 = src1.replace(/(?<quotes>")(?<rest>,)?$/,'$2');
            var src3 = src2.replace(/\\([\w"'])/g,function(match, p1, p2, p3, offset, string){
                if(match == "\\r")
                    return "\r";
                if(match == "\\n")
                    return "\n";
                if(match == "\\t")
                    return "\t";
                if(match == "\\\"")
                    return "\"";
                if(match == "\\'")
                    return "\'";
            });
            if(src.match(/^\t+/)){
                var indent = src.match(/^\t+/)[0];
                var src4 = "";
                $.each(src3.split("\n"),function(i,str){
                    var str1 = "";
                    if( i > 0){
                        str1 = indent + str;
                    }else{
                        str1 = str;
                    }
                    src4 += str1 + "\n";

                });
                src = src4;
            }
            else {
                src = src3;
            }
        }
        
        if ( i == (codes.length -1 ) ) 
            src += ';';

        sources.push(src);
        
    }

    var blob = new Blob([sources.join("\r\n")], {type: "text/plain;charset=utf-8"});
    return {blob: blob, fileName: fileName};
    //saveAs(blob, fileName );
}

JpaAllGeneratorBracket.prototype.fn_generate_fileinfo = function() {
    
    // Model 
    var _this = this;
    var _model = _.cloneDeep( _this.files );
    var varName = _.camelCase(_this.Model._name + '_jpaFiles');
    var fileName = varName + '.' + _this.dateStr + ".js";
    _this.generator.fuctionToString( _model);
    var modelStr = JSON.stringify( _model, null, '\t');
    var codes = modelStr.split('\n');
    var src = "\t\tvar " + varName + " = ";
    var sources = [];
    for(var i=0;i<codes.length;i++){
        if ( i == 0 )
            src += codes[i];
        else
            src = "\t\t" + codes[i];
        // function 
        if(src.match(/"function/)){
            var src1 = src.replace(/"function/,"function");
            var src2 = src1.replace(/(?<quotes>")(?<rest>,)?$/,'$2');
            var src3 = src2.replace(/\\([\w"'])/g,function(match, p1, p2, p3, offset, string){
                if(match == "\\r")
                    return "\r";
                if(match == "\\n")
                    return "\n";
                if(match == "\\t")
                    return "\t";
                if(match == "\\\"")
                    return "\"";
                if(match == "\\'")
                    return "\'";
            });
            if(src.match(/^\t+/)){
                var indent = src.match(/^\t+/)[0];
                var src4 = "";
                $.each(src3.split("\n"),function(i,str){
                    var str1 = "";
                    if( i > 0){
                        str1 = indent + str;
                    }else{
                        str1 = str;
                    }
                    src4 += str1 + "\n";

                });
                src = src4;
            }
            else {
                src = src3;
            }
        }
        
        if ( i == (codes.length -1 ) ) 
            src += ';';

        sources.push(src);
        
    }

    var blob = new Blob([sources.join("\r\n")], {type: "text/plain;charset=utf-8"});
    return {blob: blob, fileName: fileName};
    // saveAs(blob, fileName );
}

JpaAllGeneratorBracket.prototype.fn_generate_fileinfo_var = function() {
    
    // Model 
    var _this = this;
    var varName = 'jpaFiles';
    var fileName = varName + ".js";
    var sources = [];
    var src = "\t\tvar " + varName + " = [];"; sources.push(src);
    var blob = new Blob([sources.join("\r\n")], {type: "text/plain;charset=utf-8"});
    return {blob: blob, fileName: fileName};
    // saveAs(blob, fileName );
}

JpaAllGeneratorBracket.prototype.fn_generate_fileinfo_one = function( _file) {
    
    // Model 
    var _this = this;
    var _model = _.cloneDeep( _file );

    delete _model.foreignEntities;
    delete _model.childEntities;
    delete _model.entity_doc;
    delete _model.sqlGenerator;


    var varName = 'jpaFiles';
    var fileName = _file.fileName + ".js";
    _this.generator.fuctionToString( _model);
    var modelStr = JSON.stringify( _model, null, '\t');
    var codes = modelStr.split('\n');
    var src = "\t\t" + varName + ".push("; // sources.push(src);
    var sources = [];
    for(var i=0;i<codes.length;i++){
        if ( i == 0 )
            src += codes[i];
        else
            src = "\t\t" + codes[i];
        // function 
        if(src.match(/"function/)){
            var src1 = src.replace(/"function/,"function");
            var src2 = src1.replace(/(?<quotes>")(?<rest>,)?$/,'$2');
            var src3 = src2.replace(/\\([\w"'])/g,function(match, p1, p2, p3, offset, string){
                if(match == "\\r")
                    return "\r";
                if(match == "\\n")
                    return "\n";
                if(match == "\\t")
                    return "\t";
                if(match == "\\\"")
                    return "\"";
                if(match == "\\'")
                    return "\'";
            });
            if(src.match(/^\t+/)){
                var indent = src.match(/^\t+/)[0];
                var src4 = "";
                $.each(src3.split("\n"),function(i,str){
                    var str1 = "";
                    if( i > 0){
                        str1 = indent + str;
                    }else{
                        str1 = str;
                    }
                    src4 += str1 + "\n";

                });
                src = src4;
            }
            else {
                src = src3;
            }
        }
        
        if ( i == (codes.length -1 ) ) 
            src += ');';

        sources.push(src);
        
    }
    // var src = "\t\t" + ");"; sources.push(src);
    var blob = new Blob([sources.join("\r\n")], {type: "text/plain;charset=utf-8"});
    return {blob: blob, fileName: fileName};
    // saveAs(blob, fileName );
}

/**
 * generate data source , schema
 * @param {*} _file 
 */
JpaAllGeneratorBracket.prototype.fn_generate_script_schema = function( _file){
    var _this = this;

    // dictionary
    _this.objectToFileScript(_file, 'dictionaries', _file.dictionaries);

    // data source
    _this.objectToFileScript(_file, 'dataSrc', _file.dataSources);
    
    // childReferences
    _this.objectToFileScript(_file, 'childReferences', _file.childReferences);

    // gridProperties
    _this.objectToFileScript(_file, 'gridProperties', _file.gridProperties);


    // schema
    $.each( _file.schema , function(schemaName,schema){
        _this.objectToFileScript(_file, schema.name, schema.schema);
    });


    // setPopParemeters
    _this.objectToFileScript(_file, 'popParemeters', _file.popParemeters);
    
    
    // entityDoc
    _this.documentToScript(_file, 'entityDoc', _file.entity_doc);

    // commonFunc
    _this.objectToFileScript(_file, 'commonFunc', _file.commonFunc);
}

JpaAllGeneratorBracket.prototype.fn_generate_pop_search_init = function( _file){
    var _this = this;   
    var src = "\t\t\t\tsetTimeout(function(){fn_search();},1000);"; _file.sources.push(src); 
    var src = '\t\t\t\t' + 'popParemeters.fn_set();'; _file.sources.push(src);
}

JpaAllGeneratorBracket.prototype.fn_generate_make_html = function( _file ) {
    var _this = this;
    // dictionary
    var src =  "\t\t\t\t$.each(dictionaries,function(i, src){";  _file.sources.push(src);
    var src =  "\t\t\t\t\tsrc.data();";  _file.sources.push(src);
    var src =  "\t\t\t\t});"; _file.sources.push(src);

    // data scource datasource only when type select
    var src =  "\t\t\t\t// data scource"; _file.sources.push(src);
    var src =  "\t\t\t\t$.each(dataSrc,function(i, src){";  _file.sources.push(src);
    var src =  "\t\t\t\t\tvar prop = _.find(gridProperties , { _name : src.childColumnName } );"; _file.sources.push(src);
    var src =  "\t\t\t\t\tvar dataSrcType = 'select';"; _file.sources.push(src);
    
    var src =  "\t\t\t\t\tif ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)"; _file.sources.push(src);
    var src =  "\t\t\t\t\t\tdataSrcType = prop._documentation.data_src_type;"; _file.sources.push(src);
    
    var src =  "\t\t\t\t\tif (dataSrcType == 'select')"; _file.sources.push(src);
    var src =  "\t\t\t\t\t\tsrc.data();";  _file.sources.push(src);
    var src =  "\t\t\t\t});"; _file.sources.push(src);

    $.each( _file.schema , function( schemaName ,schema){
        var src = "\t\t\t\t$('#" + schema.containerId + "').html('')"; _file.sources.push(src);
        if(schemaName == 'search'){
            src = '\t\t\t\tif($("#filterPop").val() == "" ){'; _file.sources.push(src);
            src = "\t\t\t\t\tfn_makeHtml('" + schema.containerId + "'," + schema.name + ");"; _file.sources.push(src);
            src = '\t\t\t\t}'; _file.sources.push(src);
            src = '\t\t\t\telse{'; _file.sources.push(src);
            src = "\t\t\t\t\tpopParemeters.fn_set();"; _file.sources.push(src);
            src = "\t\t\t\t\tpopParemeters.fn_pop_select_set();"; _file.sources.push(src);
            src = "\t\t\t\t\tfindAll(\"" + _file.fileName + "Grid\"," + _file.schema.contents.name + ".elements)[0].label = \"\";"; _file.sources.push(src);
            src = '\t\t\t\t}'; _file.sources.push(src);
        }else{
            var src = "\t\t\t\tfn_makeHtml('" + schema.containerId + "'," + schema.name + ");"; _file.sources.push(src);
        }
        
        
    });
    // var src = "\t\t\t\t" + "setTimeout(function(){"; _file.sources.push(src);
    // var src = "\t\t\t\t\t" + "if(popParemeters != null)  popParemeters.fn_set(); "; _file.sources.push(src); 
    // var src = "\t\t\t\t\t" + "fn_search();"; _file.sources.push(src);
    // var src = "\t\t\t\t" + "} ,1000);"; _file.sources.push(src);
    
}

JpaAllGeneratorBracket.prototype.fn_generate_make_html_add = function( _file ) {
    var _this = this;
    // dictionary   
    var src =  "\t\t\t\t// dictionary"; _file.sources.push(src);
    var src =  "\t\t\t\t$.each(dictionaries,function(i, src){";  _file.sources.push(src);
    var src =  "\t\t\t\t\tsrc.data();";  _file.sources.push(src);
    var src =  "\t\t\t\t});"; _file.sources.push(src);

    // data scource datasource only when type select
    var src =  "\t\t\t\t// data scource"; _file.sources.push(src);
    var src =  "\t\t\t\t$.each(dataSrc,function(i, src){";  _file.sources.push(src);
    var src =  "\t\t\t\t\tvar prop = _.find(gridProperties , { _name : src.childColumnName } );"; _file.sources.push(src);
    var src =  "\t\t\t\t\tvar dataSrcType = 'select';"; _file.sources.push(src);
    
    var src =  "\t\t\t\t\tif ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)"; _file.sources.push(src);
    var src =  "\t\t\t\t\t\tdataSrcType = prop._documentation.data_src_type;"; _file.sources.push(src);
    
    var src =  "\t\t\t\t\tif (dataSrcType == 'select')"; _file.sources.push(src);
    var src =  "\t\t\t\t\t\tsrc.data();";  _file.sources.push(src);
    var src =  "\t\t\t\t});"; _file.sources.push(src);

    var src = "\t\t\t\tpopParemeters.fn_set();"; _file.sources.push(src);
    var src = "\t\t\t\t$('#v_schema_contentContainer').html('');"; _file.sources.push(src);
    
    var src =  "\t\t\t\t// getID If show_sub_pages"; _file.sources.push(src);
    var src = "\t\t\t\tif( entityDoc.show_sub_pages && _.includes(['add','copy'],$('#detailType').val()) ){"; _file.sources.push(src);
    var src = "\t\t\t\t\tcommonFunc.getID();" ; _file.sources.push(src);
    var src = "\t\t\t\t}"; _file.sources.push(src);

    var src = "\t\t\t\tcommonFunc.fn_make_schema();"; _file.sources.push(src);
    var src = "\t\t\t\tfn_makeHtml('v_schema_contentContainer',v_schema);"; _file.sources.push(src);
    
    var src =  "\t\t\t\t// show show_sub_pages"; _file.sources.push(src);
    var src = "\t\t\t\tif( entityDoc.show_sub_pages && _.includes(['edit','view'],$('#detailType').val()) ){"; _file.sources.push(src);
    var src = "\t\t\t\t\tcommonFunc.fn_view_sub();" ; _file.sources.push(src);
    var src = "\t\t\t\t}"; _file.sources.push(src);
}

JpaAllGeneratorBracket.prototype.fn_generate_content_contextmenu = function ( _file) {
    var _this = this;
    var context = {
        selector: '.jqgrow td.contextMenu', 
        // selector: '.jqgrow td.contextMenu', 
        trigger: 'left',
        // callback: function(key, options) {
        // 	var m = "clicked: " + key;
        // 	window.console && console.log(m) || alert(m); 
        // },
        // items: {
        // 	"edit": {name: "Edit", icon: "edit"},
        // 	"cut": {name: "Cut", icon: "cut"},
        // 	"copy": {name: "Copy", icon: "copy"},
        // 	"paste": {name: "Paste", icon: "paste"},
        // 	"delete": {name: "Delete", icon: "delete"},
        // 	"sep1": "---------",
        // 	"quit": {name: "Quit", icon: function($element, key, item){ return 'context-menu-icon context-menu-icon-quit'; }}
        // }
        build: function($trigger) {
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
                            oFrm.action =  "./generic.html?viewName=" + viewPath.join("/") + "/" + itemName + "&backgroundColor=FFF&isPop=Y";;
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
                        oFrm.action =  "./generic.html?viewName=" + viewPath.join("/") + "/" + itemName + "&backgroundColor=FFF&isPop=Y";
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
                            oFrm.action =  "./generic.html?viewName=" + viewPath.join("/") + "/" + itemName + "&backgroundColor=FFF&isPop=Y";;
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
                        oFrm.action =  "./generic.html?viewName=" + viewPath.join("/") + "/" + itemName;
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
    };

    _this.generator.fuctionToString( context );
    var contextStr = JSON.stringify( context, null, '\t');
    var src = '\t\t\t\t' + '$.contextMenu('; _file.sources.push(src);
    var codes = contextStr.split('\n');    
    for(var i=0;i<codes.length;i++){
        src = "\t\t\t\t\t" + codes[i];
        // function 
        if(src.match(/"function/)){
            var src1 = src.replace(/"function/,"function");
            var src2 = src1.replace(/(?<quotes>")(?<rest>,)?$/,'$2');
            var src3 = src2.replace(/\\([\w"'])/g,function(match, p1, p2, p3, offset, string){
                if(match == "\\r")
                    return "\r";
                if(match == "\\n")
                    return "\n";
                if(match == "\\t")
                    return "\t";
                if(match == "\\\"")
                    return "\"";
                if(match == "\\'")
                    return "\'";
            });
            if(src.match(/^\t+/)){
                var indent = src.match(/^\t+/)[0];
                var src4 = "";
                $.each(src3.split("\n"),function(i,str){
                    var str1 = "";
                    if( i > 0){
                        str1 = indent + str;
                    }else{
                        str1 = str;
                    }
                    src4 += str1 + "\n";

                });
                src = src4;
            }
            else {
                src = src3;
            }
        }
        
        if ( i == (codes.length -1 ) ) {
            // src += ';';
        }
            
        _file.sources.push(src);
    }
    var src = '\t\t\t\t' + ');'; _file.sources.push(src);


}

JpaAllGeneratorBracket.prototype.fn_generate_container = function( _file ){
    var _this = this;
    $.each(_file.schema, function(schemaName,schema){
        var vClass = "content_container";
        if(schemaName == "search")
            vClass += " srch_box2";
        var src = '\t<div id="' + schema.containerId + '" class="' + vClass+ '" style="margin-top: 3px;"></div>'; 
        
        _file.sources.push(src);
    });

}

JpaAllGeneratorBracket.prototype.fn_generate_container_add = function( _file ){
    var _this = this;
    var searchContainerId = "v_schema_searchContainer";
    var contentContainerId = "v_schema_contentContainer";
    var vClass = "srch_box2";
    
    var src = '\t<div id="' + searchContainerId + '" class="' + vClass+ '" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>';  _file.sources.push(src);
    var src = '\t<div id="' + contentContainerId + '" class="' + ''+ '" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>';  _file.sources.push(src);
    var src = '\t<div id="v_sub_pages" class="' + ''+ '" style="margin-top: 3px;margin-left: 20px;margin-right: 20px;"></div>';  _file.sources.push(src);

}

JpaAllGeneratorBracket.prototype.fn_fileSave = function(){
    var _this = this;
    var sqls = [];
    var zip = new JSZip();
    var fQuery = zip.folder("query");
    // var fJsp = zip.folder("jsp");
    var fJavascript = zip.folder("javascript");
    // FileInfo. 
    var fileInfoVar = _this.fn_generate_fileinfo_var();
    fJavascript.file(fileInfoVar.fileName , fileInfoVar.blob);
    $.each( _this.files ,function(i,file){
            
        // SQL XML
        if(file.sqlGenerator != undefined){
            file.sqlGenerator.fn_generate();
            var blob = new Blob([file.sqlGenerator.sources.join("\r\n")], {type: "text/plain;charset=utf-8"});
            fQuery.file(file.sqlGenerator.fileName,blob);
        }
        // JSP. not used. only Main
        if( file.sources != null && file.sources.length > 0){
            var blob = new Blob([file.sources.join("\r\n")], {type: "text/plain;charset=utf-8"});
            zip.file(file.fileName + "." + file.fileType,blob);
        }

        // FileInfo. 
        var fileInfoOne = _this.fn_generate_fileinfo_one(file);
        fJavascript.file(fileInfoOne.fileName , fileInfoOne.blob);
        
    });
    
    var jsinfo = _this.fn_generate_jsmodel();
    fJavascript.file(jsinfo.fileName , jsinfo.blob);

    // var fileInfo = _this.fn_generate_fileinfo();
    // fJavascript.file(fileInfo.fileName , fileInfo.blob);

    zip.generateAsync({type:"blob"})
    .then(function(content) {
        // see FileSaver.js
        var today = new Date();
		var yyyy = today.getFullYear().toString();
        var MM = _.padStart(today.getMonth() + 1,2,'0');
        var dd = _.padStart(today.getDate(), 2,'0');
        var hh = _.padStart(today.getHours(), 2,'0');
        var mm = _.padStart(today.getMinutes(), 2,'0');
        var ss = _.padStart(today.getSeconds(), 2,'0');
        
        var dateStr = yyyy + '.' + MM + '.' + dd + '.' +  hh + '.'  + mm + '.' + ss ;
        var reader = new FileReader();
        // this function is triggered once a call to readAsDataURL returns
        reader.onload = function(event){
            var generated_file_info = {};
            var fd = new FormData();
            var fileOfBlob = new File([content], _this.Model._name + "." + _this.dateStr + ".zip");
            fd.append('file', fileOfBlob);
            fd.append('uploadBoard', 'generated_sources');
            fd.append('useRealFileName', 'Y');
            $.ajax({
                type: 'POST',
                async : false,
                url: './fileTestJson.html',
                data: fd
                , processData: false
                , contentType: false
                , success:  function(data){
                    // console.log("Uploaded " + _this.Model._name + "." + _this.dateStr + ".zip");
                    // alert("Uploaded " + _this.Model._name + "." + _this.dateStr + ".zip");
                    generated_file_info = data;
                    $("#loader").hide();
                } 
                
            });


            // generated file info save
            var grid = $("#gensrcListGrid");
            var rowId = grid.getGridParam( "selrow" );
            var rowData = grid.getRowData(rowId); 
            

            var item_fileinfo = _.find( generated_file_info.searchVO.fileInfoList , {fieldName : "file" });
            if (item_fileinfo != null){
                rowData['SOURCE'] = item_fileinfo.filePath;
                // grid.setRowData(rowId,{SOURCE : item_fileinfo.filePath });
            }	
            var paramObj = {
                "origindatas": [
                    {
                        "field": "SORUCE_ID",
                        "value": rowData["SORUCE_ID"]
                    },
                    {
                        "field": "GEN_TYPE",
                        "value": rowData["GEN_TYPE"]
                    }
                ]
            }
            $.ajax({
                url: "./genericSaveJson.html",
                type: "POST",
                data: {
                    searchJson: JSON.stringify(paramObj),
                    fieldName: "SOURCE",
                    fieldValue: rowData['SOURCE'],
                    fieldValueOrigin: rowData['SOURCE'],
                    userId: $("#userId").val(),
                    sqlid: "gensrcList.gensrcList.edit"
                } , 
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
                        fn_search();
                        var msg = "Save Success!";
                        $("#dialog-confirm").html(msg);
                        $("#dialog-confirm").dialog({
                            resizable: false,
                            modal: true,
                            title: "Success",
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
                        
                        // reload to edit mode;
                    }						                    			
                }
            });
            
        };
        // trigger the read from the reader...
        reader.readAsDataURL(content);
        
    });

}

JpaAllGeneratorBracket.prototype.xmlMake = function ( _fileObj) {
    var _this = this;
    _fileObj.sqlGenerator = new SqlGeneratorAll( _fileObj );
}

JpaAllGeneratorBracket.prototype.sqlSelect = function( _file , schema_jpa_enity,  obj_schema) {
    var _this = this;
    var sqlId = schema_jpa_enity.sqlPreFix + _.camelCase( _file.fileName ) + "." + _.camelCase(schema_jpa_enity._name);
    if (obj_schema.type == "multiCombo")
        sqlId += ".multicombo";
    
    if (obj_schema.type == "jsTreeSearch")
        sqlId += ".jstreesearch";
    
    var sql = _.find(_file.sqlGenerator.sqls, { "id": sqlId });
    if (sql == null) {
        sql = {
            id: sqlId,
            type: "select",
            contents: [],
            wheres: []
        };
        _file.sqlGenerator.sqls.push(sql);
    
        // query select
        var src = "select "; sql.contents.push(src);


        var columns_0 = _.map([].concat(schema_jpa_enity.properties), 
            // '_name'
            function(prop,i){
                var rtn = "";
                
                rtn = prop._name.toUpperCase();  
                var isSqlSelectCustomed = false; 
                var matches = null;                
                if(prop._documentation != null)
                    matches = prop._documentation.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
                
                if(matches){
                    $.each(matches,function(i,m){
                        var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                        var content = match.groups.content;
                        // var custom_obj = JSON.parse(content);            
                        // eval("var custom_obj = " + _.unescape(content));
                        var custom_obj = eval( "(" + _.unescape(content) + ")");
                        // sub column 
                        if ( custom_obj.sql_select != null ){
                            rtn = "(" + custom_obj.sql_select + ") as " + prop._name.toUpperCase() ;  
                            isSqlSelectCustomed = true;             
                        }else if ( custom_obj.query != null ){
                            // 혹시몰라서
                            rtn = "(" + custom_obj.query + ") as " + prop._name.toUpperCase() ;      
                            isSqlSelectCustomed = true;     
                        }
                        
                    });
                }            
                if ( !isSqlSelectCustomed && prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" )
                    rtn = "to_char(" + prop._name.toUpperCase() + ",'YYYY-MM-DD HH24:MI:SS') as " + prop._name.toUpperCase();
                
                return rtn;
            }
        ); 
        
        // custom columns from references
        if ( schema_jpa_enity.references != null ) {
            $.each( [].concat(schema_jpa_enity.references) , function(i, ref){
                if(ref._documentation == undefined)
                    return true;
                // if(task._name == "regex pattern")
                //     debugger;
                var matches = ref._documentation.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
                if(matches){
                    $.each(matches,function(i,m){
                        var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                        var content = match.groups.content;
                        // var custom_obj = JSON.parse(content);            
                        eval("var custom_obj = " + _.unescape(content));
                        if ( custom_obj.subquery != null ){
                            var subquery = "(" + custom_obj.subquery.query.toUpperCase() + ") as " + custom_obj.subquery.column_name.toUpperCase();
                            columns_0.push(subquery);
                        }
                        
                    });        
                }
            });
        }

        // custom columns from Entities
        if ( schema_jpa_enity._documentation != null) {            
                
            var matches = schema_jpa_enity._documentation.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
            if(matches){
                $.each(matches,function(i,m){
                    var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                    var content = match.groups.content;
                    // var custom_obj = JSON.parse(content);            
                    eval("var custom_obj = " + _.unescape(content));
                    // sub column 
                    if ( custom_obj.custom_columns != null ){
                        $.each([].concat(custom_obj.custom_columns), function(i ,custom_column){

                            if(custom_column.query != null){
                                var subquery = "(" + custom_column.query.toUpperCase() + ") as " + custom_column.column_name.toUpperCase();
                                columns_0.push(subquery);
                            }

                        });
                        

                    }
                   
                    
                });        
            }
            
        }
        
        var columns = "\t" + columns_0.join(",");

        if (obj_schema.type == "multiCombo" && obj_schema.jpa_column != null){
            src = "distinct"; sql.contents.push(src);
            columns = "\t" + obj_schema.jpa_column.parent_column.toUpperCase();
            let _parentProp =  _.find([].concat(schema_jpa_enity.properties),{_name:obj_schema.jpa_column.parent_column});
            if( _parentProp == null )
                debugger;
            let _parentNameCol = _.find(_parentProp.eAnnotations.details , {"_key": "name_column"});
            if ( _parentNameCol != null )
                columns += "," + _parentNameCol._value.toUpperCase();
            
        }
        sql.contents.push(columns);
        src = "from " + schema_jpa_enity._name.toUpperCase() + " a "; sql.contents.push(src);
        src = "where 1=1"; sql.contents.push(src);
        if ( obj_schema.type == "grid" ){
            $.each([].concat(schema_jpa_enity.properties), function (i, prop) {
                let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] , { "_xsi:type": "gmmjpa:Id" });
                // if (vId != null) {
                // All columns   
                src = "<if test=\"search_" + _.camelCase(prop._name) + " != null and search_" + _.camelCase(prop._name) + " !='' \">"; sql.wheres.push(src);
                if ( prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" ){
                    src = "\tand " + prop._name + " = to_date(#{search_" + _.camelCase(prop._name) + "} , 'YYYY-MM-DD HH24:MI:SS' )"; sql.wheres.push(src);
                }
                else {
                    src = "\tand " + prop._name + " = #{search_" + _.camelCase(prop._name) + "}"; sql.wheres.push(src);
                }
                // src = "\tand REGEXP_LIKE(" + prop._name + ", #{search_" +  _.camelCase(prop._name) + "} ,'i')  "; sql.wheres.push(src);
                src = "</if>"; sql.wheres.push(src);
                // }
            });
        }
        if (obj_schema.type == "multiCombo") {
            src = "order by 1 "; sql.contents.push(src);
        }
        else if (obj_schema.type == "grid") {
            // sql.type = "sql";
            sql.jsp_type = "grid";
        }
    }

    obj_schema.sqlId = sqlId;
    obj_schema.entityId = schema_jpa_enity["_xmi:id"];
}

JpaAllGeneratorBracket.prototype.sqlSelectJsTree = function( _file , jpaEntity,  obj_schema) {
    var _this = this;
    var sqlId = jpaEntity.sqlPreFix + _.camelCase( _file.fileName ) + "." + _.camelCase(jpaEntity._name);
    sqlId += ".jstreesearch";    
    var sql = _.find(_file.sqlGenerator.sqls, { "id": sqlId });
    if (sql == null) {
        sql = {
            id: sqlId,
            type: "select",
            contents: [],
            wheres: []
        };
        _file.sqlGenerator.sqls.push(sql);
    
        // query select
        var src = "select distinct "; sql.contents.push(src);
        
        // var columns = "\t" + _.map([].concat(obj_schema.relation.columns), 
        //     // '_name'
        //     function(prop,i){
        //         var rtn = prop.parentColumn;
        //         return rtn;
        //     }
        // ).join(","); 

        var columns = "\t" + _.map([].concat(obj_schema.keys), function(key,i){
                var rtn =  key.codeColumn.toUpperCase();
                if( key.topParent != undefined &&  key.topParent._name != jpaEntity._name){
                    if ( key.codeColumn != key.nameColumn ){
                        rtn += ",(";
                        rtn += "select max(t." + key.topParent.nameColumn.toUpperCase() + ") from " + key.topParent.entity._name.toUpperCase() + " t";
                        rtn += " where t." + key.topParent.columnName + " = " + "a." + key.codeColumn;
                        rtn += " ) AS " + key.nameColumn.toUpperCase();
                    }
                }else{
                    if ( key.codeColumn != key.nameColumn ){
                        rtn += "," + key.nameColumn.toUpperCase();
                    }
                }
                    
                return rtn;
            }
        ).join(",\r\n\t\t\t"); 
        
        sql.contents.push(columns);
        src = "from " + jpaEntity._name.toUpperCase() + " a"; sql.contents.push(src);
        src = "where 1=1"; sql.contents.push(src);        
        src = "order by 1 "; sql.contents.push(src);
       
    }

    obj_schema.sqlId = sqlId;
    obj_schema.data = function(){
        var _this = this;
        var rtnList = [];
        $.ajax({
            url: "./genericlListJson.html",
            data: {"sqlid": _this.sqlId }, 
            async: false,
            success:  function(response){
                rtnList = response.dataList;
            }
        });
        return rtnList;
    };
    obj_schema.entityId = jpaEntity["_xmi:id"];
}

JpaAllGeneratorBracket.prototype.whereAndDetail = function( _file , schema_jpa_enity,  obj_schema) {
    var _this = this;
    var sql = _.find( _file.sqlGenerator.sqls , {id : obj_schema.sqlId } );
    $.each(_file.foreignEntities, function (i, parentDef) {
        var parentEntity = _this.generator.findAllByElName( _this.Model , {"_xmi:id":parentDef.id });
        $.each(parentDef.schemas , function(j, search_schema){
            if (search_schema.type == "multiCombo" && search_schema.jpa_column != undefined) {
                src = "<if test=\"" + search_schema.name + "Arr != null and " + search_schema.name + "Arr !='' \">";                sql.wheres.push(src);
                src = "\t" + "and " + search_schema.jpa_column.child_column + " in ";                sql.wheres.push(src);
                src = "\t\t" + "<foreach collection=\"" + search_schema.name + "Arr\" item=\"item\" index=\"index\" open=\"(\" separator=\",\" close=\")\" >";                sql.wheres.push(src);
                src = "\t\t" + "#" + "{item}";                sql.wheres.push(src);
                src = "\t\t" + "</foreach>";                sql.wheres.push(src);
                src = "</if>";                sql.wheres.push(src);
            }else if ( search_schema.jpa_column != null ){
                src = "<if test=\"" + search_schema.name + " != null and " + search_schema.name + " !='' \">";                sql.wheres.push(src);
                src = "\t" + "and " + search_schema.jpa_column.child_column + " =  #{" + search_schema.name + "} ";                sql.wheres.push(src);
                src = "</if>";                sql.wheres.push(src);
            }
        });
        
        
    });

}

JpaAllGeneratorBracket.prototype.sqlInsert = function( _file , schema_jpa_enity,  obj_schema) {
    var _this = this;
    let sqlId = schema_jpa_enity.sqlPreFix + _.camelCase( _file.fileName ) + "." + _.camelCase(schema_jpa_enity._name) + ".insert";
    var sql = _.find( _file.sqlGenerator.sqls , {id : sqlId } );
    if( sql != null)
        return;
    
    sql = {
        id: sqlId,
        type: "insert",
        contents: [],
        wheres: []
    };
    _file.sqlGenerator.sqls.push(sql);

    var vSqlAddDate = _this.sqlAddDate;
    if(_file.entity_doc_obj.sqlAddDate != null)
        vSqlAddDate = _file.entity_doc_obj.sqlAddDate;
    
    // query
    var src = "";
    if(_file.sqlGenerator.dbType == "oracle"){
        src = "declare" ; sql.contents.push(src);
        src = "\t" + "cnt number;" ; sql.contents.push(src);
        src = ""+ "begin" ; sql.contents.push(src);
    }
    

    src = "\tinsert into " + schema_jpa_enity._name.toUpperCase() + "(" ;  sql.contents.push(src);
    src = "\t\t" + _.map([].concat(schema_jpa_enity.properties) ,'_name').join(","); sql.contents.push(src);
    if(vSqlAddDate){
        src = "\t\t" + ",INS_DT"; sql.contents.push(src);
    }
    src = "\t)"; sql.contents.push(src);

    src = "\tvalues (" ; sql.contents.push(src);

    $.each([].concat(schema_jpa_enity.properties), function (i, prop) {
        if (i > 0){
            src = "\t\t,"; sql.contents.push(src);
        }

        var custom_sql_insert = "";
        if (prop._documentation != null){
            var matches = prop._documentation.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
            if(matches){
                $.each(matches,function(i,m){
                    var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                    var content = match.groups.content;
                    // var custom_obj = JSON.parse(content);            
                    eval("var custom_obj = " + _.unescape(content));
                    // sub column 
                    if ( custom_obj.sql_insert != null ){
                        // custom_sql_insert = custom_obj.sql_insert;
                        custom_sql_insert = "(" + custom_obj.sql_insert + ") " ;               
                    }
                    
                });
            }
        }
        if ( custom_sql_insert != ""){
            src = "\t\t" + custom_sql_insert ; sql.contents.push(src);
        }else if ( prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" ){
            src = "\t\tto_date( #{" + prop._name.toUpperCase() + "} ,'YYYY-MM-DD HH24:MI:SS')"; sql.contents.push(src);
        }
        else{
            src = "\t\t#{" + prop._name.toUpperCase() + "}"; sql.contents.push(src);
        }
            
    });

    if(vSqlAddDate){
        if(_file.sqlGenerator.dbType == "oracle"){
            src = "\t\t,sysdate" ; sql.contents.push(src);
        }
        else if ( _file.sqlGenerator.dbType == "mysql" ){
            src = "\t\t,now()" ; sql.contents.push(src);
        }
            
    }
    src = "\t);" ; sql.contents.push(src);
    if(_file.sqlGenerator.dbType == "oracle"){
        src = "end;"; sql.contents.push(src);
    }
    if (obj_schema.type == "grid") {
        // sql.type = "sql";
        sql.jsp_type = "grid";
    }
}

JpaAllGeneratorBracket.prototype.sqlEdit = function( _file , schema_jpa_enity,  obj_schema) {
    var _this = this;
    let sqlId = schema_jpa_enity.sqlPreFix + _.camelCase( _file.fileName ) + "." + _.camelCase(schema_jpa_enity._name) + ".edit";
    var sql = _.find( _file.sqlGenerator.sqls , {id : sqlId } );
    if( sql != null)
        return;
    
    sql = {
        id: sqlId,
        type: "update",
        contents: [],
        wheres: []
    };
    _file.sqlGenerator.sqls.push(sql);
    var vSqlAddDate = _this.sqlAddDate;
    if(_file.entity_doc_obj.sqlAddDate != null)
        vSqlAddDate = _file.entity_doc_obj.sqlAddDate;
    // query
    if(_file.sqlGenerator.dbType == "oracle"){
        src =  "declare" ; sql.contents.push(src);
        src = "\t" + "cnt number;" ; sql.contents.push(src);
        src = "\t"+ "begin" ; sql.contents.push(src);
    }

    src = "update " + schema_jpa_enity._name.toUpperCase() + " set" ;  sql.contents.push(src);
    if ( vSqlAddDate ){
        if(_file.sqlGenerator.dbType == "oracle"){
            src = "\t" + "MOD_Dt = sysdate,  "; sql.contents.push(src);
        }
        else if ( _file.sqlGenerator.dbType == "mysql" ){
            src = "\t" + "MOD_Dt = now(),  "; sql.contents.push(src);
        }
    }
    var vDtCols = _.filter(schema_jpa_enity.properties,{type:{_href:'http://www.eclipse.org/emf/2002/Ecore#//EDate'}});
    if (vDtCols.length > 0 ){
        src = "\t" + "<choose>"; sql.contents.push(src);
        $.each([].concat(vDtCols), function (i, prop) {
            src = "\t\t" + "<when test=\"fieldName eq '" + prop['_name'].toUpperCase() + "' \">"; sql.contents.push(src);
            src = "\t\t" + "${fieldName} = to_date(#{fieldValue} ,'YYYY-MM-DD HH24:MI:SS')"; sql.contents.push(src);
            src = "\t\t" + "</when>";sql.contents.push(src);
        });
        src = "\t\t" + "<otherwise>"; sql.contents.push(src);
        src = "\t\t" + "${fieldName} = #{fieldValue}" ; sql.contents.push(src);
        src = "\t\t" + "</otherwise>"; sql.contents.push(src);
        src = "\t" + "</choose>"; sql.contents.push(src);
    }else{
        src = "\t\t" +" ${fieldName} = #{fieldValue}" ; sql.contents.push(src);
    }
    
    
    src = "\t" + "where 1=1"; sql.contents.push(src);

    // src = $("#editSqlReactWhere").text().replace(/@{/g,"#{").replace(/!{/g,"${");   sql.contents.push(src);
    var vDtWheres = _.filter(schema_jpa_enity.properties,{type:{_href:'http://www.eclipse.org/emf/2002/Ecore#//EDate'}});
    src = "\t" + "<choose>"; sql.contents.push(src);
    src = "\t\t" + "<when test=\"searchJson != null and searchJson != '' and searchJson.origindatas.size() > 0 \" >" ; sql.contents.push(src);
    src = "\t\t\t" + "<foreach collection=\"searchJson.origindatas\" item=\"item\" index=\"index\"  >"; sql.contents.push(src);
    if (vDtWheres.length > 0 ){
        src = "\t\t\t\t" + "<choose>"; sql.contents.push(src);
        $.each([].concat(vDtWheres), function (i, prop) {
            src = "\t\t\t\t" + "<when test=\"item.field == '" + prop['_name'].toUpperCase() + "' \">" + " and ${item.field} = to_date( #{item.value} , 'YYYY-MM-DD HH24:MI:SS' ) " + "</when>"; sql.contents.push(src);
        });
        src = "\t\t\t\t" + "<otherwise>" + "and ${item.field} = #{item.value}" + "</otherwise>"; sql.contents.push(src);
        src = "\t\t\t\t" + "</choose>"; sql.contents.push(src);
    }else{
        src = "\t\t\t" + " and ${item.field} = #{item.value}" ; sql.contents.push(src);
    }
    src = "\t\t\t" + "</foreach>"; sql.contents.push(src);
    src = "\t\t" + "</when>"; sql.contents.push(src);
    src = "\t\t" + "<otherwise>"; sql.contents.push(src);
    src = "\t\t" + "and 1=2"; sql.contents.push(src);
    src = "\t\t" + "</otherwise>"; sql.contents.push(src);
    src = "\t" + "</choose>"; sql.contents.push(src);
    src = "\t;"; sql.contents.push(src);

    if(_file.sqlGenerator.dbType == "oracle"){
        src = "end;"; sql.contents.push(src);
    }

}

JpaAllGeneratorBracket.prototype.sqlDelete = function( _file , schema_jpa_enity,  obj_schema) {
    var _this = this;
    let sqlId = schema_jpa_enity.sqlPreFix + _.camelCase( _file.fileName ) + "." + _.camelCase(schema_jpa_enity._name) + ".delete";
    var sql = _.find( _file.sqlGenerator.sqls , {id : sqlId } );
    if( sql != null)
        return;

    sql = {
        id: sqlId,
        type: "update",
        contents: [],
        wheres: []
    };
    _file.sqlGenerator.sqls.push(sql);

    // query
    if(_file.sqlGenerator.dbType == "oracle"){
        src =  "declare" ; sql.contents.push(src);
        src = "\t" + "cnt number;" ; sql.contents.push(src);
        src = "\t"+ "begin" ; sql.contents.push(src);
    }

    src = "\t\tdelete from " + schema_jpa_enity._name.toUpperCase()  ;  sql.contents.push(src);
    src = "\t\twhere 1=1"; sql.contents.push(src);
    $.each([].concat(schema_jpa_enity.properties), function (i, prop) {
        let vId = _.find( [].concat(prop.annotations) , { "_xsi:type": "gmmjpa:Id" });
        if (vId != null) {
            if ( prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" ){
                src = "\t\tand " + prop._name + " = to_date( #{detail." +   prop._name.toUpperCase() + "} , 'YYYY-MM-DD HH24:MI:SS' ) " ; sql.contents.push(src);
            }else{
                src = "\t\tand " + prop._name + " = #{detail." +   prop._name.toUpperCase() + "}" ; sql.contents.push(src);
            }
            
        }
    });
    src = "\t\t;"; sql.contents.push(src);
    if(_file.sqlGenerator.dbType == "oracle"){
        src = "end;"; sql.contents.push(src);
    }
}

JpaAllGeneratorBracket.prototype.fn_datasource = function(foreign_entities, vEntity, jpa_prop, _file, gridCol) {
    var _this = this;
    var hasParents = false;
    if (foreign_entities != null) {
        $.each(foreign_entities, function (i, parentDef) {
            var parent = _this.generator.findAllByElName(_this.Model, { "_xmi:id": parentDef.id });
            var reference = {};
            var parent_columns = [];
            var child_columns = [];
            reference = _.find([].concat(parent.references), { _referencedEntity: vEntity["_xmi:id"] });
            var child_columns_detail = _.find(reference.eAnnotations.details, { "_key": "child_columns" });
            if (child_columns_detail != null) {
                child_columns = child_columns_detail._value.split(",");
            }
            var child_columns_index = _.indexOf(child_columns, jpa_prop._name);
            if (child_columns_index == -1)
                return true;
            hasParents = false;
            var parent_columns_detail = _.find([].concat(reference.eAnnotations.details), { "_key": "parent_columns" });
            if (parent_columns_detail != null) {
                parent_columns = parent_columns_detail._value.split(",");
            }
            var column_map = { "parent_column": parent_columns[child_columns_index], "child_column": jpa_prop._name };
            
            if (child_columns.length == 1) {
                var referenceId = reference["_xmi:id"];
                var dataSrc = _.find(_file.dataSources, { "referenceId": referenceId });
                if (dataSrc == null) {
                    // var sqlId = _.camelCase(_this.file_name) + "." + _.camelCase(_task._name) + ".datasrc." + _.camelCase(reference._name);
                    var sqlId = vEntity.sqlPreFix + _.camelCase(_file.fileName) + ".datasrc." + _.camelCase(parent._name) + "." + _.camelCase(vEntity._name);
                    dataSrc = {
                        "referenceId": referenceId,
                        "parent_entity": parent,
                        "parent_columns": parent_columns,
                        "child_columns": child_columns,
                        "column_map": column_map,
                        "sqlId": sqlId,
                        "data": function () {
                            var _this = this;
                            // var prop = _.find(gridProperties , { _name : src.childColumnName } );

                            $.ajax({
                                type: "POST",
                                // url: "/dashboard/genericlListJson.html?sqlid=dashboard.ssd_test.summary.all.1",
                                url: "./genericlListJson.html?" +
                                    "&sqlid=" + _this.sqlId,
                                data: {},
                                async: false,
                                success: function (response) {
                                    var dataList = response.dataList;
                                    $.each(dataList, function (i, data) {
                                        var parent_column = _.find([].concat(_this.parent_entity.properties), { "_name": _this.column_map.parent_column });
                                        if (parent_column != null) {
                                            var name_column = _.find(parent_column.eAnnotations.details, { "_key": "name_column" });
                                            if (name_column != null) {
                                                _this.value[data[parent_column._name.toUpperCase()]] = data[name_column._value.toUpperCase()];
                                            }
                                            else {
                                                _this.value[data[parent_column._name.toUpperCase()]] = data[parent_column._name.toUpperCase()];
                                            }
                                        }
                                    });
                                }
                            });
                        },
                        "value": {}
                    };
                    _file.dataSources.push(dataSrc);
                    // query xml 만들기
                    var sql = _.find(_file.sqlGenerator.sqls, { "id": sqlId });
                    if (sql == null) {
                        sql = {
                            id: sqlId,
                            type: "select",
                            contents: [],
                            wheres: []
                        };
                        _file.sqlGenerator.sqls.push(sql);
                        // query select
                        var src = "select ";
                        sql.contents.push(src);
                        var columns = "\t" + _.map([].concat(parent.properties), '_name').join(",");
                        sql.contents.push(columns);
                        src = "from " + parent._name.toUpperCase();
                        sql.contents.push(src);
                        src = "where 1=1";
                        sql.contents.push(src);
                        src = "order by 1";
                        sql.contents.push(src);
                    }
                }
                var editSetting = {
                    // "edittype": 'select' ,
                    // "formatter": 'select' ,
                    "referenceId": referenceId
                };
                _.merge(gridCol, editSetting);
            }
            hasParents = true;
        });
    }
    return hasParents;
}

/**
 * 테이블생성
 * @param {*} _entity 
 */
JpaAllGeneratorBracket.prototype.manageTable = function( _entity ){
    
    // select table exists
    // create table
    
    // columns
    // select column exists
    // alter column add
    // primary key delete
    // primary key create


    var _this = this;
    // select table exists
    var existsTable = _this.existsTable( _entity )
    // create table
    if( !existsTable)
        _this.createTable(_entity);
    // columns
    if(existsTable){
        // select column exists
        // alter column add
        _this.addColumns(_entity);
        // primary key delete
        
    }

    var existskey = _this.existsPrimaryKey(_entity);
    if(existskey)
        _this.deletePrimaryKey(_entity);
    // primary key create
    _this.createPrimaryKey(_entity);
    
}
JpaAllGeneratorBracket.prototype.existsTable = function( _entity ){
    var _this = this;
    var rtn = false;
    $.ajax({
        url: "./genericlListJson.html",
        type: "POST",
        data: {
            table_name : _entity._name.toUpperCase(),
            sqlid :"gensrc.common.select.table" 
        } , 
        async: false,			                    		
        success:  function(data){
            if(data.dataList[0].CNT > 0)
                rtn = true;
        } 
    });
    return rtn;
}
JpaAllGeneratorBracket.prototype.existsPrimaryKey = function( _entity ){
    var _this = this;
    var rtn = false;
    $.ajax({
        url: "./genericlListJson.html",
        type: "POST",
        data: {
            table_name : _entity._name.toUpperCase(),
            sqlid :"gensrc.common.select.primarykey" 
        } , 
        async: false,			                    		
        success:  function(data){
            if(data.dataList.length > 0)
                rtn = true;
        } 
    });
    return rtn;
}
JpaAllGeneratorBracket.prototype.createTable = function( _entity ){
    var _this = this;
    var rtn = false;
    var type = function(_prop){
        var rtn_type = "VARCHAR";
        if (_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" )
            rtn_type = "DATE";
        else if(_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EInt")
            rtn_type = "INT";
        else if(_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EIntegerObject")
            rtn_type = "INT";
        else if(_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDoubleObject")
            rtn_type = "DOUBLE";
        else if(_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EFloatObject")
            rtn_type = "FLOAT";
        
        // if type is 'varchar', read length
        if( rtn_type == 'VARCHAR'){
            var annotationColumn = _.find([].concat(_prop.annotations),{"_xsi:type":"gmmjpa:Column"});
            if( annotationColumn != null && annotationColumn._length != null && annotationColumn._length != "0"){
                rtn_type += "(" + annotationColumn._length + ")";
            }else{
                rtn_type += "(100)";
            }
        }
        
        return rtn_type;
    };
    var columns =  _.map([].concat(_entity.properties),function(prop,i){
        var notnull = "NULL";
        let vId = _.find( [].concat(prop.annotations) , { "_xsi:type": "gmmjpa:Id" });
        if (vId != null) {
            notnull = "NOT NULL";
        }
        var col = {
            column_name : prop._name.toUpperCase(),
            data_type : type(prop) ,
            notnull : notnull
        };
        return col;
    });
    columns.push(
        {
            column_name : "INS_DT",
            data_type : "DATE",
            notnull: "NULL"
        },
        {
            column_name : "MOD_DT",
            data_type : "DATE",
            notnull: "NULL"
        }
    );
    var paramObj = {
        "columns" : columns
    };
    $.ajax({
        url: "./genericSaveJson.html",
        type: "POST",
        data: {
            table_name : _entity._name.toUpperCase() ,
            sqlid :"gensrc.common.create_table" ,
            searchJson: JSON.stringify(paramObj)
            
        } , 
        async: false,			                    		
        success:  function(data){
            if(data.result != "success"){
                $("#dialog-confirm").html(data.message);
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
                $("#loader").hide();
                throw data.message;
            }
            
        } 
    });
    
}
JpaAllGeneratorBracket.prototype.addColumns = function( _entity ){
    var _this = this;
    var rtn = false;
    var type = function(_prop){
        var rtn_type = "VARCHAR";
        if (_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" )
            rtn_type = "DATE";
        else if(_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EInt")
            rtn_type = "INT";
        else if(_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EIntegerObject")
            rtn_type = "INT";
        else if(_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDoubleObject")
            rtn_type = "DOUBLE";
        else if(_prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EFloatObject")
            rtn_type = "FLOAT";

        // if type is 'varchar', read length
        if( rtn_type == 'VARCHAR'){
            var annotationColumn = _.find([].concat(_prop.annotations),{"_xsi:type":"gmmjpa:Column"});
            if( annotationColumn != null && annotationColumn._length != null && annotationColumn._length != "0"){
                rtn_type += "(" + annotationColumn._length + ")";
            }else{
                rtn_type += "(100)";
            }
        }

        return rtn_type;
    };
    var columns =  _.map([].concat(_entity.properties),function(prop,i){
        var notnull = "NULL";
        let vId = _.find( [].concat(prop.annotations) , { "_xsi:type": "gmmjpa:Id" });
        if (vId != null) {
            notnull = "NOT NULL";
        }
        var col = {
            sqlid : "gensrc.common.entity.add_column",
            table_name : _entity._name.toUpperCase(),
            column_name : prop._name.toUpperCase(),
            data_type : type(prop) ,
            notnull : notnull
        };
        return col;
    });
    columns.push(
        {
            sqlid : "gensrc.common.entity.add_column",
            table_name : _entity._name.toUpperCase(),
            column_name : "INS_DT",
            data_type : "DATE",
            notnull: "NULL"
        },
        {
            sqlid : "gensrc.common.entity.add_column",
            table_name : _entity._name.toUpperCase(),
            column_name : "MOD_DT",
            data_type : "DATE",
            notnull: "NULL"
        }
    );
    $.each(columns, function(i,column){
        $.ajax({
            url: "./genericlListJson.html",
            type: "POST",
            data: {
                table_name : _entity._name.toUpperCase(),
                column_name : column.column_name,
                sqlid :"gensrc.common.select.column" 
            } , 
            async: false,			                    		
            success:  function(data){
                if(data.dataList[0].CNT == 0){
                    $.ajax({
                        url: "./genericSaveJson.html",
                        type: "POST",
                        data: column , 
                        async: false,			                    		
                        success:  function(data){
                            if(data.result != "success"){
                                $("#dialog-confirm").html(data.message);
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
                                $("#loader").hide();
                                throw data.message;
                            }
                        } 
                    });
                }
                    
            } 
        });
    });

    
    

   
    
}
JpaAllGeneratorBracket.prototype.deletePrimaryKey = function( _entity ){
    var _this = this;
    var rtn = false;
    
    
    $.ajax({
        url: "./genericSaveJson.html",
        type: "POST",
        data: {
            table_name : _entity._name.toUpperCase() ,
            sqlid :"gensrc.common.entity.drop.primarykey" 
        } , 
        async: false,			                    		
        success:  function(data){
            if(data.result != "success"){
                $("#dialog-confirm").html(data.message);
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
                $("#loader").hide();
                throw data.message;
            }
        } 
    });
}
JpaAllGeneratorBracket.prototype.createPrimaryKey = function( _entity ){
    var _this = this;
    var rtn = false;
    
    var columns =  [];
    $.each([].concat(_entity.properties),function(i, prop){
        var isId = "N";
        let vId = _.find( [].concat(prop.annotations) , { "_xsi:type": "gmmjpa:Id" });
        if (vId != null) {
            isId = "Y";
        }
        var col = {
            column_name : prop._name.toUpperCase(),
            notnull : isId
        };
        if (vId != null) {
            columns.push(col);
        }
    });
    
    
    var paramObj = {
        "columns" : columns
    };
    $.ajax({
        url: "./genericSaveJson.html",
        type: "POST",
        data: {
            table_name : _entity._name.toUpperCase() ,
            sqlid :"gensrc.common.entity.create.primarykey" ,
            searchJson: JSON.stringify(paramObj)
            
        } , 
        async: false,			                    		
        success:  function(data){
            if(data.result != "success"){
                $("#dialog-confirm").html(data.message);
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
                $("#loader").hide();
                throw data.message;
            }
        } 
    });
}

JpaAllGeneratorBracket.prototype.fn_datasource_by_top = function(vEntity, jpa_prop, _file, gridCol) {
    var _this = this;
    var hasParents = false;
    var paramForTopParent1 = { 
        "entityId": vEntity["_xmi:id"], 
        "columnName": jpa_prop._name
    };
    // if ( vEntity._name == "ssd_sm_result_h" && gridCol.name=="SCRIPT_NAME")
    //     debugger;
    var topParent = _this.fn_get_top_parent(paramForTopParent1);
    var topParentEntity = _.find([].concat(_this.Model.ownedEntities),{"_xmi:id": topParent.entityId} );
    var parent = _this.fn_get_parent(paramForTopParent1);
    var parentEntity = null;
    if ( parent != null)
        parentEntity = _.find([].concat(_this.Model.ownedEntities),{"_xmi:id": parent.entityId} );
    if (paramForTopParent1 != topParent)
        hasParents = true;
    if (paramForTopParent1 != topParent){
        
        var referenceId = parent.referenceId;
        var topReferenceId = topParent.referenceId;
        var sqlId = topParentEntity.sqlPreFix + _.camelCase(_file.fileName) + ".datasrc." + _.camelCase(topParentEntity._name) + "." + _.camelCase(topParent.columnName) ;
        // var dataSrc = _.find(_file.dataSources, { "referenceId": referenceId , "topRefrencedId": topReferenceId });
        var dataSrc = _.find(_file.dataSources, { "sqlId": sqlId });
        if (dataSrc == null) {
            var sqlIdDynamic = parentEntity.sqlPreFix + _.camelCase(_file.fileName) + ".datasrc.dynamic." + _.camelCase(parentEntity._name) + "." + _.camelCase(parent.columnName) ;
            dataSrc = {
                "referenceId": referenceId,
                "topRefrenceId" :  topReferenceId ,
                "parentEntity" : parentEntity._name,
                "parentColumnName": parent.columnName,
                "childColumnName": jpa_prop._name,
                "childColumnNames": parent.childColumnNames,  
                "parentNameColumn": parent.nameColumn,
                "parentColumnNames": parent.columnNames,
                
                "topEntity" : topParentEntity._name ,
                "topColumnName" : topParent.columnName ,
                "topColumnNames" : topParent.columnNames ,
                "topNameColumn" : topParent.nameColumn ,
                "sqlId": sqlId,                
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
                        url: "./genericlListJson.html?" +
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
                "value": {} ,
                "sqlIdDynamic": sqlIdDynamic, 
                "dataDynamic": function ( param ) {
                    var _this = this;
                    var rtnList = [];
                    $.ajax({
                        type: "POST",
                        url: "./genericlListJson.html?" +
                            "&sqlid=" + _this.sqlIdDynamic,
                        data: param,
                        async: false,
                        success: function (response) {
                            rtnList = response.dataList;
                        }
                    });
                    return rtnList;
                }
            };
            var editSetting = {
                // "edittype": 'select' ,
                // "formatter": 'select' ,
                "referenceId": referenceId ,
                "topRefrenceId" :  topReferenceId,
                editoptions : {
                    dataEvents: []
                }

            };
            _file.dataSources.push(dataSrc);
            // query xml 만들기
            var sql = _.find(_file.sqlGenerator.sqls, { "id": sqlId });
            if (sql == null) {
                sql = {
                    id: sqlId,
                    type: "select",
                    contents: [],
                    wheres: []
                };
                _file.sqlGenerator.sqls.push(sql);
                // query select
                var src = "select distinct ";
                sql.contents.push(src);

                // var columns = "\t" + [ topParent.columnName , topParent.nameColumn ].join(",");
                var columns = [topParent.columnName.toUpperCase()];
                if ( topParent.columnName !=  topParent.nameColumn)
                    columns.push(topParent.nameColumn.toUpperCase());
                
                sql.contents.push("\t" + columns.join(","));
                src = "from " + topParentEntity._name.toUpperCase();  sql.contents.push(src);
                src = "where 1=1"; sql.contents.push(src);
                if(topParent.columnNames.length == 1){
                
                }
                src = "order by 1"; sql.contents.push(src);
                
            }

            // query dependency dynamic
            var sql = _.find(_file.sqlGenerator.sqls, { "id": sqlIdDynamic });
            if (sql == null) {
                sql = {
                    id: sqlIdDynamic,
                    type: "select",
                    contents: [],
                    wheres: []
                };
                _file.sqlGenerator.sqls.push(sql);
                // query select
                var src = "select distinct ";
                sql.contents.push(src);

                // var columns = "\t" + [ topParent.columnName , topParent.nameColumn ].join(",");
                var columns = [parent.columnName.toUpperCase()];
                if ( parent.columnName !=  parent.nameColumn)
                    columns.push(parent.nameColumn.toUpperCase());
                
                sql.contents.push("\t" + columns.join(","));
                src = "from " + parentEntity._name.toUpperCase();  sql.contents.push(src);
                src = "where 1=1"; sql.contents.push(src);
                if(parent.columnNames.length > 1){
                    var index = _.indexOf(dataSrc.childColumnNames,dataSrc.childColumnName);
                    if ( index > -1){
                        var wheres = dataSrc.childColumnNames.slice(0,index);
                        $.each(wheres , function(i, where ){
                            src = "<if test=\"search_" + _.camelCase(where) + " != null and search_" + _.camelCase(where) + " !='' \">"; sql.wheres.push(src);
                            src = "\tand " + where + " = #{search_" + _.camelCase(where) + "}"; sql.wheres.push(src);
                            src = "</if>"; sql.wheres.push(src);
                        } );
                    }
                    
                }
                src = "order by 1"; sql.wheres.push(src);
                
            }
            
            _.merge(gridCol, editSetting);
            
        }
    }

    return hasParents;
}


/**
 * if field has dictionary override datasrc
 */
JpaAllGeneratorBracket.prototype.fn_datasource_by_dictionary = function(vEntity, jpa_prop, _file, gridCol) {
    var _this = this;
    // defined Entity
    var dictionaryDefEntity = _.find( this.Model.ownedEntities , {eAnnotations: { details: [{ _key: "isDictionaryDefine"}] } , sqlPreFix : vEntity.sqlPreFix } );
    if (dictionaryDefEntity == null)
        return;
    var dictionaryDefPropCategory = _.find( [].concat(dictionaryDefEntity.eAnnotations.details), {"_key": "categoryColumn"} );
    var dictionaryDefPropCode = _.find( [].concat(dictionaryDefEntity.eAnnotations.details), {"_key": "codeColumn"} );
    var dictionaryDefPropName = _.find( [].concat(dictionaryDefEntity.eAnnotations.details), {"_key": "nameColumn"} );
    // use Entyty
    var dictionaryUseEntyty = _.find( this.Model.ownedEntities , {eAnnotations: { details: [{ _key: "isDictionaryUse"}] } , sqlPreFix : vEntity.sqlPreFix } );
    if ( dictionaryUseEntyty == null)
        return;
    
    var sqlId = vEntity.sqlPreFix + _.camelCase(_file.fileName) +  ".dictionary." + _.camelCase(vEntity._name) ;
    var dictionary = _.find(_file.dictionaries, { "sqlId": sqlId });
    if ( dictionary == null){
        dictionary = {
            entityName : vEntity._name,            
            sqlId : sqlId,
            dictionaryDefTable : dictionaryDefEntity._name ,
            dictionaryUseTable : dictionaryUseEntyty._name ,
            categoryColumn : dictionaryDefPropCategory._value ,
            codeColumn : dictionaryDefPropCode._value , 
            nameColumn : dictionaryDefPropName._value ,
            
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
        };
        _file.dictionaries.push(dictionary);
        // sql query
        var sql = _.find(_file.sqlGenerator.sqls, { "id": sqlId });
        if (sql == null) {
            sql = {
                id: sqlId,
                type: "select",
                contents: [],
                wheres: []
            };
            _file.sqlGenerator.sqls.push(sql);
            var src = "select  ";  sql.contents.push(src);
            src = "b.TABLE_NAME" ; sql.contents.push(src);
            src = ", b.COLUMN_NAME" ; sql.contents.push(src);
            src = ", a." + dictionary.categoryColumn.toUpperCase(); sql.contents.push(src);
            src = ", a." + dictionary.codeColumn.toUpperCase(); sql.contents.push(src);
            src = ", a." + dictionary.nameColumn.toUpperCase(); sql.contents.push(src);
            
            src = "from " + dictionary.dictionaryDefTable.toUpperCase() + " a";  sql.contents.push(src);
            src = "left outer join  " + dictionary.dictionaryUseTable.toUpperCase() + " b";  sql.contents.push(src);
            src = " on a." + dictionary.categoryColumn.toUpperCase() + " = " + "b." +  dictionary.categoryColumn.toUpperCase() ;  sql.contents.push(src);
            // src = " and a." + dictionary.codeColumn + " = " + "b." +  dictionary.codeColumn ;  sql.contents.push(src);
            // src = "where  REGEXP_LIKE(b.table_name, '^" + vEntity._name + "' ,'i') "   ; sql.contents.push(src);
            src = "where b.TABLE_NAME is not null"   ; sql.contents.push(src);
            src = "order by 1,2,3,4" ; sql.contents.push(src);

        }

    }
}

/**
 * json 형식으로 정의함.
 * @param {*} task 
 */
JpaAllGeneratorBracket.prototype.fn_set_grid_custom_item = function(_prop, _gridItem ){
    var _this = this;
    if(_prop._documentation == undefined)
        return;
    // if(task._name == "regex pattern")
    //     debugger;
    var matches = _prop._documentation.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
    if(matches){
        $.each(matches,function(i,m){
            var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
            var content = match.groups.content;
            // var custom_obj = JSON.parse(content);            
            // eval("var custom_obj = " + _.unescape(content));
            var custom_obj = eval( "(" + _.unescape(content) + ")");
            delete custom_obj.sql_insert;
            delete custom_obj.sql_select;
            delete custom_obj.query;

            _.merge(_gridItem,custom_obj);
            var codes = content.split('\n');            
        });        
    	
    }
}

/**
 * 파일의 특정 변수를 JSP 변수객체로 만든다.
 */
JpaAllGeneratorBracket.prototype.objectToFileScript = function(_file, object_name, jsobject){
    var _this = this;
    var objectClone = _.cloneDeep(jsobject);
    _this.generator.fuctionToString(objectClone);
    // var object_str = JSON.stringify( objectClone, null, '\t');

    var object_str = JSON.stringify( objectClone, function(key, value){
        if (key == "_documentation" && typeof value === "string") {
            var value_to = {};
            // var matches = value.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!\^\?\+\.\\\/,"'\=:;\r\n\[\]{}]+)<\/code>/g);
            var matches = value.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
            if(matches){
                $.each(matches,function(i,m){
                    var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                    var content = match.groups.content;
                    var custom_obj = eval( "(" + _.unescape(content) + ")");
                    delete custom_obj.sql_insert;
                    delete custom_obj.sql_select;
                    delete custom_obj.query;
                    _.merge(value_to,custom_obj );
                });
            }
            return value_to;
        }
        return value;
    }, '\t');
    var codes = object_str.split('\n');
    var src = "\t\tvar " + object_name + " = ";

    for(var i=0;i<codes.length;i++){
        if ( i == 0 )
            src += codes[i];
        else
            src = "\t\t" + codes[i];
        // function 
        if(src.match(/"function/)){
            var src1 = src.replace(/"function/,"function");
            var src2 = src1.replace(/(?<quotes>")(?<rest>,)?$/,'$2');
            var src3 = src2.replace(/\\([\w"'])/g,function(match, p1, p2, p3, offset, string){
                if(match == "\\r")
                    return "\r";
                else if(match == "\\n")
                    return "\n";
                else if(match == "\\t")
                    return "\t";
                else if(match == "\\\"")
                    return "\"";
                else if(match == "\\'")
                    return "\'";
                else
                    return match;
            });

            src3 = src3.replace(/match\(\/(?<regular>[\w\\\.\(\)\+\[\]\$\^\/]+)\/i\)/g,function(match, p1, p2, p3, offset, string){
                // return "match(/\\.([\\w]+)$/i)";
                // return match;
                // return match.replace("/\\\\/","\\");
                return match.split("\\\\").join("\\");
            });

            if(src.match(/^\t+/)){
                var indent = src.match(/^\t+/)[0];
                var src4 = "";
                $.each(src3.split("\n"),function(i,str){
                    var str1 = "";
                    if( i > 0){
                        str1 = indent + str;
                    }else{
                        str1 = str;
                    }
                    src4 += str1 + "\n";

                });
                src = src4;
            }
            else {
                src = src3;
            }
        }
        
        if ( i == (codes.length -1 ) ) 
            src += ';';
        _file.sources.push(src);
    }
}

/**
 * 파일의 특정 변수를 JSP 변수객체로 만든다.
 */
JpaAllGeneratorBracket.prototype.documentToScript = function(_file, object_name, _docstr){
    var _this = this;
    
    var v_doc_object = {};
    if ( _docstr != null){
        // var matches = value.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!\^\?\+\.\\\/,"'\=:;\r\n\[\]{}]+)<\/code>/g);
        var matches = _docstr.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+||ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
        if(matches){
            $.each(matches,function(i,m){
                var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+||ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                var content = match.groups.content;
                var custom_obj = eval( "(" + _.unescape(content) + ")");           
                _.merge(v_doc_object,custom_obj );
            });
        }
    }
    
    var objectClone = _.cloneDeep(v_doc_object);
    _this.generator.fuctionToString(objectClone);

    var object_str = JSON.stringify( objectClone, null , '\t');
    var codes = object_str.split('\n');
    var src = "\t\tvar " + object_name + " = ";

    for(var i=0;i<codes.length;i++){
        if ( i == 0 )
            src += codes[i];
        else
            src = "\t\t" + codes[i];
        // function 
        if(src.match(/"function/)){
            var src1 = src.replace(/"function/,"function");
            var src2 = src1.replace(/(?<quotes>")(?<rest>,)?$/,'$2');
            var src3 = src2.replace(/\\([\w"'])/g,function(match, p1, p2, p3, offset, string){
                if(match == "\\r")
                    return "\r";
                if(match == "\\n")
                    return "\n";
                if(match == "\\t")
                    return "\t";
                if(match == "\\\"")
                    return "\"";
                if(match == "\\'")
                    return "\'";
            });
            if(src.match(/^\t+/)){
                var indent = src.match(/^\t+/)[0];
                var src4 = "";
                $.each(src3.split("\n"),function(i,str){
                    var str1 = "";
                    if( i > 0){
                        str1 = indent + str;
                    }else{
                        str1 = str;
                    }
                    src4 += str1 + "\n";

                });
                src = src4;
            }
            else {
                src = src3;
            }
        }
        
        if ( i == (codes.length -1 ) ) 
            src += ';';
        _file.sources.push(src);
    }

}

JpaAllGeneratorBracket.prototype.documentToObject = function(_docstr){
    var _this = this;
    
    var v_doc_object = {};
    if ( _docstr != null){
        // var matches = value.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!\^\?\+\.\\\/,"'\=:;\r\n\[\]{}]+)<\/code>/g);
        var matches = _docstr.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+||ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
        if(matches){
            $.each(matches,function(i,m){
                var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+||ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                var content = match.groups.content;
                var custom_obj = eval( "(" + _.unescape(content) + ")");           
                _.merge(v_doc_object,custom_obj );
            });
        }
    }
    if (v_doc_object.customFunc == null){
        v_doc_object.customFunc = {};
    }
    return v_doc_object;

}



/**
 * Entiry의 Propertis 
 */
JpaAllGeneratorBracket.prototype.entityPropsToObject = function( jsobject ){
    var _this = this;
    var objectClone = _.cloneDeep(jsobject);    
    _this.generator.fuctionToString(objectClone);
    _this.entityPropsAnnotationsToKey(objectClone);
    // var object_str = JSON.stringify( objectClone, null, '\t');

    var object_str = JSON.stringify( objectClone, function(key, value){
        if (key == "_documentation") {
            var value_to = {};
            // var matches = value.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!\^\?\+\.\\\/,"'\=:;\r\n\[\]{}]+)<\/code>/g);
            var matches = value.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/g);
            if(matches){
                $.each(matches,function(i,m){
                    var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!%\^\?\+*\.\\\/,"'\=:;\t\r\n\[\]{}\-\+|ㄱ-ㅎㅏ-ㅣ가-힣]+)<\/code>/);
                    var content = match.groups.content;
                    var custom_obj = eval( "(" + _.unescape(content) + ")");
                    delete custom_obj.sql_insert;
                    delete custom_obj.sql_select;
                    delete custom_obj.query;
                    _.merge(value_to,custom_obj );
                });
            }
            return value_to;
        }
        
        return value;
    }, '\t');
    
    var props =  eval(object_str);
    $.each(props, function(i,prop){
        if (prop._documentation == null){
            prop._documentation = {};
        }
        delete prop["_xmi:id"];
    });
    return props;
   
}

JpaAllGeneratorBracket.prototype.entityPropsAnnotationsToKey = function(jsobject){
    var _this = this;
    var str = "";
    $.each(jsobject,function(k,v){
        if( v == null || v == undefined)
            return true;

        if(k == "eAnnotations"){
           delete jsobject[k];
           return true;
        }else if(k == "annotations"){
            let vId = _.find( _.isArray(v)?v:[v] , { "_xsi:type": "gmmjpa:Id" });
            if (vId != null) {
                jsobject['isKey'] = true;
            }
            delete jsobject[k];
        }else if(typeof(v) ==  "object"){
            _this.entityPropsAnnotationsToKey(v);
        }
        
    });
    

}