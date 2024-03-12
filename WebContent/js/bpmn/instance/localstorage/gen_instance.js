function genInstance(_entityId, _type,  _list_instance , _option ){
    
    $("#loader").show();
    localStorage.removeItem("jstree");
    
    this.entityId = _entityId;
    this.type = _type;
    this.list_instance = _list_instance;
    this.sub_instance = [];

    var today = new Date();
    var y = today.getFullYear();
    var m = today.getMonth() + 1;
    var d = today.getDate();
    var h = today.getHours();
    var mi = today.getMinutes();
    var s = today.getSeconds();
    this.idPrefix =  y + "_" + m + "_" + d + "_" + h + "_" + mi + "_" + s;


    /**
     * optionex
     * @argument isPopSelect : true, false
     * @argument caller
     * @argument filter
     */
    this.option = _option;
    
    this.jpaFile = _.find( this.list_instance.jpaFiles , { entityId : this.entityId, editType: this.type });
    this.db = db;
    this.fn_makeSchema();

    this.jpaFile.dataSrc = this.jpaFile.dataSources;
    this.containerId = "div_" + this.entityId + "_"+ this.type + "_" + this.idPrefix; 
    this.searchContainerId = this.containerId + "_searchContainer";
    this.gridContainerId = this.containerId + "_gridContainer";
    this.gridId = this.containerId + "_grid";
    this.pagerId = this.gridId + "_pager";
    // make form 
    var formTemplate = `
        <form name="form" id="form" class="">
        <input type="hidden" name="searchJson" value='{}'/>
        </form>
    `;
    this.formId = this.containerId + "_form";    
    this.form = $(formTemplate);
    this.form.attr("id" , this.formId);
    this.form.attr("name" , this.formId);
    
    var _this = this;
    // inintial search
    if(this.option != null && this.option.filter != null){
        var v_filters = [];
        $.each(this.option.filter ,function(field, data){
            var obj = {
                field : field ,
                // value: [].concat(data)
                value: data , 
                isArray : _.isArray(data)
            };
            v_filters.push( obj );
        });
        this.form.find("[name=searchJson]").val(JSON.stringify({fields: v_filters}));
    }

    if(this.option != null && this.option.modal ){
        var modalCommon = $("[name=infiniteLogModal]");
        this.modalClone = modalCommon.clone();
        this.modalClone.attr("isCloned","true");

        // Header
        var filterStrs = [];
        $.each(this.option.filter,function(k,v){
            var str = _.camelCase(k);
            str += " : " + v;
            filterStrs.push(str);
        });
        var headStr = '[' + _.camelCase(_this.entityId) + ']  ' +  filterStrs.join(" , ");	
        var emptystr = "&nbsp;";

        this.modalClone.find(".modal-header h6 span").text(headStr );

        // modalId
        this.modalClone.attr("id", this.containerId );
        this.modalClone.attr("name", "infiniteLogModal" + this.containerId );
        this.container = this.modalClone.find(".modal-body");        
        
        // this.list_instance.container.append(this.modalClone);
        $("#pagebody .br-section-wrapper").append(this.modalClone);
        // document.body.append(this.modalClone);

        // modal
        setTimeout( function(){
            _this.modalClone.modal();
            // _this.modalClone.draggable({
            //     handle: ".modal-header"
            // }); 
        },0);
        
    }else{
        this.container = $("<div/>",{id:  this.containerId });
        this.list_instance.container.append(this.container);
    }
    // show title
    if(this.option != null && this.option.showLabel){
        var templateTitle = `
        <h3 class="tx-inverse fa fa-dot-circle-o" style="margin-top: 20px;">edit title</h3>
        `;
        var vTitle = $(templateTitle);
        var strTitle = _.camelCase(this.jpaFile.entityId);
        if(this.jpaFile.entity_doc_obj.label != null){
            strTitle = this.jpaFile.entity_doc_obj.label;
        }
        vTitle.text(strTitle);
        this.container.append(vTitle);
    }
    this.container.append(this.form);
    
    this.searchContainer = null;
    this.gridContainer = null;
    this.jstreeList = [];
    
    // 어떤식으로 입력을 할 것인가?  
    // div에 소스를 생성하는 방식으로?
    // ==> 이것은 커스터마이징을 할 수 있도록 한다. 
    // schema를 바탕으로 자동으로 생성을 한다?
    // ==> 일단은 이것으로 한다.
    // 이것을 완성 한 다음 div 에 소스를 generating 하는 방식으로 한다.

        
    // 데이타소스가 모두 완료가 되었는지. 
    this.dbDataSourceCompleted = 0 ; 
    this.fn_setDataSourceValue();
    setTimeout( function(){
        // container 안에 그린다.
        // 01. search
        if(_this.option != null && _this.option.filter != null ){
            // 필터가 있다면 검색조건을 만들지 않는다.
        }else{
            _this.makeSearch();
        }
        
        // 02. grid
        // this.openDb();
        _this.makeGrid();

        _this.fn_contextmenu();

        $("#loader").hide();

        if(_this.option != null && _this.option.modal){

        }
    }, 150 );
    

}

genInstance.prototype.fn_setDataSourceValue = function(){
    var _this = this;
    // dictionary
    $.each(_this.jpaFile.dictionaries,function(i, src){
        // src.data();
        // if(src.data != null && typeof src.data == "function"){
        //     src.data();
        // }else{
        //     _this.fn_setDataDictionary(src);
        // }
        _this.fn_setDataDictionary(src);
        
    });

    // data scource
    $.each(_this.jpaFile.dataSrc,function(i, src){
        var prop = _.find( _this.jpaFile.gridProperties , { _name : src.childColumnName } );
        var dataSrcType = 'select';
        if ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)
            dataSrcType = prop._documentation.data_src_type;
        if (dataSrcType == 'select'){
            _this.fn_setDataSourceValueParent(src);
        }
        
    });

}

genInstance.prototype.fn_setDataDictionary = function( _datasrc ){
    var _this = this;
    _datasrc.value = [];
    var transactionUse = _this.db.transaction( _datasrc.dictionaryUseTable , "readonly");
    var objectStoreUse = transactionUse.objectStore( _datasrc.dictionaryUseTable );

    // keyRange not use
    // var keyRangeUse = IDBKeyRange.only( _this.entityId);
    var requestUse = objectStoreUse.openCursor();
    var datalistUse = [];
    var datalist = [];
    requestUse.onsuccess = function(event) {
        var cursor = event.target.result;
        if(cursor) {
            // cursor.value contains the current record being iterated through
            // this is where you'd do something with the result
            var re = new RegExp("\^" + _this.entityId + "\$", 'i');
            if(re.exec(cursor.value['TABLE_NAME']) != null){
                datalistUse.push(cursor.value);
            }
            cursor.continue();
        } else {
            $.each( datalistUse , function( i, use){
                // start common code
                var transactionCode = _this.db.transaction( _datasrc.dictionaryDefTable , "readonly");
                var objectStoreCode = transactionCode.objectStore( _datasrc.dictionaryDefTable );
                var requestCode = objectStoreCode.openCursor();
                requestCode.onsuccess = function(event1){
                    var cursor1 = event1.target.result;
                    if(cursor1){
                        if( cursor1.value[_datasrc.categoryColumn.toUpperCase()] == use[_datasrc.categoryColumn.toUpperCase() ]){
                            var data = _.cloneDeep(use);
                            _.merge(data, cursor1.value);
                            _datasrc.value.push(data);
                        }                        
                        cursor1.continue();
                    }else{
                        
                    }
                }
            });
        }
    };
}

/**
부모를 참조하는 데이타 셋팅
*/
genInstance.prototype.fn_setDataSourceValueParent = function( _datasrc ){
    var _this = this;
    _datasrc.value = {};
    var prop = _.find( _this.jpaFile.gridProperties , { _name : _datasrc.childColumnName } );
    var dataSrcType = "select";
    if ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)
        dataSrcType = prop._documentation.data_src_type;
    if (dataSrcType == "select")
        var dataSrcType = "select";
    if (dataSrcType != "select")
        return;
    if( _datasrc.data != null && typeof _datasrc.data == "function"){
        _datasrc.data( _this.jpaFile.gridProperties );
    }else{
        // _datasrc.value[data[ _datasrc.topColumnName.toUpperCase()]] = data[_datasrc.topNameColumn.toUpperCase()];
        var transaction = _this.db.transaction( _datasrc.parentEntity , "readonly");
        var objectStore = transaction.objectStore( _datasrc.parentEntity);        

        var request = objectStore.openCursor();
        var datalist = [];
        var dataUniq = [];
        
        request.onsuccess = function(event) {
            var cursor = event.target.result;
            if(cursor) {
                // cursor.value contains the current record being iterated through
                // this is where you'd do something with the result
                datalist.push(cursor.value);
                cursor.continue();
            } else {
                dataUniq = _.uniqBy(datalist, _datasrc.childColumnName.toUpperCase() );
                $.each(dataUniq , function( i , data){
                    _datasrc.value[data[ _datasrc.topColumnName.toUpperCase()]] = data[_datasrc.topNameColumn.toUpperCase()];
                });

            }
        };

    }
    
}

genInstance.prototype.makeSearch = function(){
    var _this = this;
    var searchContainer = $("<div/>",{id: this.searchContainerId});
    this.searchContainer = searchContainer;
    this.searchContainer.addClass("form-layout form-layout-7");
    this.form.append(searchContainer);

    // make schema if schema not exists
    var schema = this.jpaFile.schema.search.schema ;
    schema.containerType = "search";
    var makehtml = new makeHtmlBySchema( this.searchContainer , schema , this );
}

/**
 * 만약 schema가 없다면 schema를 만든다.
 * 소스 generate를 한다면 schema가 있을 것이다.
 * js fiddle 같은데에 예제를 올리는 경우.
 */
genInstance.prototype.fn_makeSchema = function(){
    var _this = this;
    var _file = this.jpaFile ;
    var v_schema = this.jpaFile.schema;
    if ( v_schema == null){
        v_schema = {
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
        this.jpaFile.schema = v_schema;
        _this.fn_makeSchemaSearch();
        _this.fn_makeSchemaGrid();
    }
}
genInstance.prototype.fn_makeSchemaSearch = function(){
    var _this = this;
    var _file = this.jpaFile ;
    var schemaVertical = findAllByElName( _file.schema.search.schema , { id: 'searchVertical' } );
    var schema = findAllByElName( _file.schema.search.schema , { id: 'searchHorizontalLayout' } );
    var schemaClone = _.cloneDeep(schema);

    // MultiCombo <== Parents
    var searchCols = [];
    var schemaNew = {};
    var processedReferenceId = "";
    $.each( this.jpaFile.dataSources, function (i, _datasrc) {
        var child_columns = _datasrc.childColumnNames;
        var parent_columns = _datasrc.parentColumnNames;
        if ( child_columns.length == 1){
            var parentFile = _.find(_this.list_instance.list, {entityId : _datasrc.parentEntity, editType : "general"} );
            // multi combo            
            $.each(child_columns, function (i, child_column) {
                var parent_column = parent_columns[i];
                var parentProp = _.find([].concat(parentFile.gridProperties), { "_name": parent_column });
                var obj_txt = {
                    type: "SearchHeader",
                    id: _.camelCase(_datasrc.parentEntity + '_' + parentProp._name) + 'SearchHeader',
                    name: _.camelCase(parent.parentEntity + '_' + parentProp._name) + 'SearchHeader',
                    label: '',
                    text: _.capitalize(_.camelCase(child_column)),
                    containerCls : "col-sm-2"
                };

                var obj_combo = {
                    type: "multiCombo",
                    id: _.camelCase(_datasrc.parentEntity + '_' + parentProp._name) + 'SearchMultiCombo',
                    name: _.camelCase(_datasrc.parentEntity + '_' + parentProp._name) + 'SearchMultiCombo',
                    label: '',
                    text: _.capitalize(parentProp._name),
                    jpa_column: { "parent_column": parentProp._name, "child_column": child_column },
                    events:{
                        "change" : function(e){
                            // fn_search();
                            e.target.htmlMaker.instance.fn_search();
                        }
                    },
                    multiselectOpt : {multiple: true},
                    width: "150px",
                    options : {
                        cd : parentColumnName.toUpperCase(),
                        name: parentNameColumn.toUpperCase()
                    },
                    containerCls : "col-sm"
                };

                

                schema.elements.push(obj_txt);
                schema.elements.push(obj_combo);
            });            

        }else if ( child_columns.length > 1  ){
            // jstree
            if ( processedReferenceId == _datasrc.referenceId){
                // continue
                return true;
            }
            // jstree 가 적용될 datasrc list
            var ref_datasrcs = _.filter(_this.jpaFile.dataSources , {referenceId : _datasrc.referenceId });
            var obj_txt = {
                type: "SearchHeader",
                id: child_columns.join("_") + '_SearchHeader',
                name: child_columns.join("_") + '_SearchHeader',
                label: '',
                text : _.capitalize(child_columns[0]) + " ...",
                containerCls : "col-sm-2"
            };

            // For name columns
            var vKeys = _.map(ref_datasrcs, function( _src , i){
                var rtnObj =  {
                    codeColumn: _src.parentColumnName ,
                    nameColumn: _src.parentNameColumn
                };
                if ( _src.topEntity != _src.parentEntity ){
                    rtnObj.topParent = _src.topEntity;
                };
                return rtnObj;
                    
            });
            var obj_tree = {
                type: 'jsTreeSearch',
                id: child_columns.join("_") + '_jsTreeSearch',
                name: child_columns.join("_") + '_jsTreeSearch',
                label: _.camelCase(_datasrc.parentEntity) + 'Tree Search',
                text: ' ',
                // width: '200px',
                // keys: _.map(parent_columns, function (col, i) { return col.toUpperCase(); }),
                keys: vKeys ,
                rootText: 'Select ' + _.map(child_columns, function (col, i) { return _.camelCase(col); }).join("/"),
                referenceId: _datasrc.referenceId,
                // relationColumns: { "parent_columns": parent_columns, "child_columns": child_columns },
                relation: {
                    parentEntityName: _datasrc.parentEntity,
                    childEntityName: _file.entityId,
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
                },
                entityId : _file.entityId ,
                containerCls: "col-sm"
            };
            schema.elements.push(obj_txt);
            schema.elements.push(obj_tree);  

            processedReferenceId = _datasrc.referenceId;
        }
        
    });

}

genInstance.prototype.fn_makeSchemaGrid = function(){
    var _this = this;
    var _file = this.jpaFile ;
    var schema = findAllByElName( _file.schema.contents.schema , { id: 'contentVertical' } );
    var schema_obj = {
        type: "grid",
        id: _.camelCase( _this.jpaFile.entityId) + 'Grid' ,
        name: _.camelCase(_this.jpaFile.entityId) + 'Grid' ,
        label: "" , //_.capitalize(entity._name) ,
        text : _.capitalize(_this.jpaFilefileName),
        sqlId : _.camelCase( _this.jpaFile.entityId) + "." + _.camelCase( _this.jpaFile.entityId),
        entityId : _this.jpaFile.entityId,
        containerCss:[
            {code: 'width', value:'100%'},
            {code: 'margin-top', value:'10px'},
            {code: 'background-color', value:'#FFF'},
        ],
        gridOpt : {
            datatype:'local',
            editurl: "./ssdCusDummySaveJson.do",
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

    };
    schema_obj.items = _.map([].concat(_this.jpaFile.gridProperties), function(prop){
        var v_prop_doc = prop._documentation;
        var gridItem = {
            label : _.capitalize(_.upperCase(prop._name)),
            name : prop._name.toUpperCase() ,
            id : prop._name.toUpperCase() ,
            align: 'center',
            entityName :_this.entityId ,
            editable: true ,
            edithidden : true ,
            gridId : _this.gridId
        };

        if( prop.isKey){
            gridItem.editrules = {edithidden:true};       
            gridItem.required = true;
        }
        // parent 
        var datasrc = _.find( _this.jpaFile.dataSources , {childColumnName : prop._name});
        if(datasrc != null){
            gridItem.referenceId = datasrc.referenceId;
            if(datasrc.topRefrenceId != null){
                gridItem.topRefrenceId = datasrc.topRefrenceId;
            }
            gridItem.unformat = function( cellval ,  opts , cell){
                var grid = $(this).jqGrid();
                var originVal = $(cell).attr("cellValue");
                //opts.colModel.editoptions.value[]
                return originVal;
            }
        }
        // children
        var v_childrens = _.filter( _this.list_instance.jpaFiles , { dataSources : [{ parentEntity : _this.entityId, parentColumnName : prop._name}] }) ; 
        if( datasrc != null && v_childrens.length > 0){
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
        }else if(datasrc != null){
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
        }else if(v_childrens.length > 0){
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
        }else{
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

        // custom 
        _.merge(gridItem, v_prop_doc );

        return gridItem;
    });

    // custom columns from references
    // custom columns from Entities
    if ( _this.jpaFile.entity_doc_obj.custom_columns != null){
        $.each([].concat(_this.jpaFile.entity_doc_obj.custom_columns), function(i ,custom_column){
            let gridItem = {
                label : _.capitalize(_.upperCase(custom_column.column_name)),
                name : custom_column.column_name.toUpperCase() ,
                id : custom_column.column_name.toUpperCase() ,
                align: 'center',
                entityName : _this.entityId ,
                editable: true ,
                gridId : _this.gridId
            };

            if(custom_column.properties != null){
                _.merge(gridItem, custom_column.properties);
            }

            var _index = _.findIndex(schema_obj.items, function(o) { return o.name == custom_column.column_after.toUpperCase(); });
            if (_index == (schema_obj.items.length -1) )
                schema_obj.items.push(gridItem);
            else
                schema_obj.items.splice(_index,0,gridItem);
        });
    }

    // grid option from Entities
    if ( _this.jpaFile.entity_doc_obj.grid_option != null){
        _.merge(schema_obj.gridOpt, custom_obj._this.jpaFile.entity_doc_obj.grid_option );
    }
    schema.elements.push(schema_obj);
}

genInstance.prototype.makeGrid = function(){
    var _this = this;
    var gridContainer = $("<div/>",{id: this.gridContainerId});
    this.gridContainer = gridContainer;
    this.form.append(gridContainer);
    var schema = this.jpaFile.schema.contents.schema ;
    var makehtml = new makeHtmlBySchema( this.gridContainer , schema , this );
    _this.fn_search();
}

genInstance.prototype.fn_contextmenu = function(){
    var _this = this;
    var default_option = {
        "selector": "#" + _this.gridContainerId + " .jqgrow td.contextMenu",
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
            var grid = _this.container.find("#"+gridId).jqGrid();
            var rowId = $trigger.parent().attr("id");
            var rowData = grid.getRowData(rowId);
            var vGridOpt = grid.getGridParam();
            var cms = vGridOpt.colModel;
            var cm = _.find(cms, {name: $trigger.attr("columnName")} );
            
            // parents
            var hasParents = false;
            var parents = [];
            if ( cm.referenceId != null){
                
                var src = _.find( _this.jpaFile.dataSrc, {"referenceId": cm.referenceId , "topRefrenceId" : cm.topRefrenceId  });
                // entytyId를 넣어야 하므로 camelCase 를 쓰지 않는다.
                var itemName = src.parentEntity;
                options.items[itemName] = {
                    name: "Parents: " + itemName ,
                    callback : function(key, options){
                        var m = "clicked: " + key + ", data: " + $(this).text();

                        // Modal Pop
                        if(true){
                            // Form Submit
                            var filter = {};
                            $.each(src.childColumnNames , function(i,column){
                                var parentColumn = src.parentColumnNames[i];
                                if(rowData[column.toUpperCase()] != null)
                                    filter[parentColumn.toUpperCase()] = rowData[column.toUpperCase()];
                                // $(this).attr("cellValue");
                            });

                            var instanceOption = {
                                modal : true,
                                caller : _this ,
                                filter : filter ,
                                referenceType : "parent",
                                reference : src
                            };
                            _this.list_instance.add_instance ( itemName , 'general' , instanceOption );
                            
                        }
                        return; 

                        
                    }
                };
                hasParents = true;
                // }

            }

            // children
            var hasChildrens = false;
            var childrens = _this.jpaFile.childReferences;

            $.each(childrens , function(i,child){
                var child_columns = child.child_columns;
                var parent_columns = child.parent_columns;
                var child_columns_index = _.indexOf(child.parent_columns, cm.name.toLowerCase());
                if (child_columns_index == -1)
                    return false;

                // entytyId를 넣어야 하므로 camelCase 를 쓰지 않는다.
                var itemName = child.childEntityName;
                options.items[itemName] = {
                    name: "Child: " + itemName ,
                    callback : function(key, options){
                        // var m = "clicked: " + key + ", data: " + $(this).text();
                        // console.log(m);

                        // Modal Pop
                        if(true){
                            // Form Submit
                            var filter = {};
                            $.each(child_columns , function(i,column){
                                var parentColumn = parent_columns[i];
                                if(rowData[column.toUpperCase()] != null)
                                    filter[column.toUpperCase()] = rowData[parentColumn.toUpperCase()];
                                // $(this).attr("cellValue");
                            });
                            
                            var instanceOption = {
                                modal : true,
                                caller : _this ,
                                filter : filter ,
                                referenceType : "child",
                                reference : child
                            };
                            _this.list_instance.add_instance ( itemName , 'general' , instanceOption );
                            
                        }
                        return ;

                        
                    }
                };
                hasChildrens = true;
                
                
            });
            
            if ( !hasParents && !hasChildrens )
                return false;

            // if ( _.keys(options.items).length == 1 ){
            //     options.items[_.keys(options.items)[0]].callback();
            //     return false;
            // }

            return options;
            // return false; 
        }

    };
    var option = {};
    if( _this.jpaFile.entity_doc_obj.customFunc.contextOption != null ){
        option = _this.jpaFile.entity_doc_obj.customFunc.contextOption;
    }else{
        option = default_option;
    }
    _this.container.contextMenu(option);

}

genInstance.prototype.fn_jstreeSearch = function(){
    var _this = this;
    
    if (_this.jstreeList.length == 0)
        return;
    if(this.option != null && this.option.modal ){
        return;
    }
    var selJsTree3 = [];
    $.each(_this.jstreeList, function(i, jsSchema ){
        // 만약 Child Pop 인 경우, jstree가 없으므로 넘어간다.
        var vJsTreeId = jsSchema.id;
        var $jsTree = _this.form.find("#" + vJsTreeId );
        if ($jsTree.length == 0)
            return true;
                
        var vJsTree =  _this.form.find("#" + vJsTreeId ).jstree(true);
        // var selJsTree = _.filter(vJsTree._model.data , {state : {selected: true } });
        var selJsTree = _.filter(vJsTree._model.data , function( data ){
            // if (data.id == "#")
            // 	return false;
            if (data['original'] == null || data.original["field"] == null)
                return false;
            if ( data.state.selected == null ) 
                return false;
            if( data.children_d.length > 0 )
                return false;
            var vSelected = data.state.selected;
            if ( vSelected)
                return true;
            
            return vSelected;

        });
        var selJsTree1 = _.map(selJsTree, function(data, i){
            var obj = {};
            $.each(jsSchema.keys , function(i, key){
                obj[key.codeColumn.toUpperCase()] = data.id.split(";;;")[i];
            });
            return obj;

        });
        selJsTree3.push({
            id : vJsTreeId,
            value : selJsTree1
        });
        // var selJsTree2 = serializeArrayJSON(selJsTree1);
        
        // $.each(selJsTree2, function(field, data){
        //     var obj = {
        //         field : field ,
        //         // value: [].concat(data)
        //         value: data , 
        //         isArray : _.isArray(data)
        //     };
        //     selJsTree3.push( obj );
        // });
        
    });
    _this.form.find("[name=searchJson]").val(JSON.stringify({jstreeSearch : selJsTree3}));
}

genInstance.prototype.fn_search = function(){
    var _this = this;
    setTimeout( function(){
        
        if( _this.jpaFile.entity_doc_obj.customFunc.jstreeInfoSearch != null ){
            _this.jpaFile.entity_doc_obj.customFunc.jstreeInfoSearch.call(_this);
        }else{
            _this.fn_jstreeSearch();
        }
        
        var theGrid = $("#" + _this.gridId ).jqGrid();
        var transaction = _this.db.transaction( _this.entityId , "readonly");
        var objectStore = transaction.objectStore( _this.entityId);
        // preFrame call child 
        // and you have to find datasorce
        if(_this.option != null && _this.option.filter != null && _this.option.referenceType=="child"){
            var datasrc = _.find( _this.jpaFile.dataSrc, {"referenceId": _this.option.reference.referenceId });         
            var vIndex = objectStore.index(datasrc.referenceId);
            var keys = [];
            var vquery = [];
            $.each(datasrc.parentColumnNames , function(i, col){
                keys.push(datasrc.childColumnNames[i].toUpperCase());
            });
            $.each(keys, function(i, key){
                vquery.push(_this.option.filter[key]);
            });
            
            var request = vIndex.getAll(vquery);
            request.onsuccess = function(event) {
                var cursor = event.target.result;
                if(cursor) {
                    theGrid.setGridParam({data : cursor});
                    theGrid.trigger('reloadGrid');
                }
            };
        }else if(_this.option != null && _this.option.filter != null && _this.option.referenceType=="parent"){
        // preFrame call parent 
        // and you have to find self key
            var keys = [];
            var vquery = [];
            $.each(_this.option.reference.parentColumnNames , function(i, col){
                keys.push(col.toUpperCase());
            });
            $.each(keys, function(i, key){
                vquery.push(_this.option.filter[key]);
            });

            var request = objectStore.get( vquery );
            var datalist = [];
            request.onsuccess = function(event) {
                var cursor = event.target.result;
                if(cursor) {
                    datalist.push(cursor);
                    theGrid.setGridParam({data : datalist});
                    theGrid.trigger('reloadGrid');
                }
            };
        }else{
            // 모달이 아닌경우. not modal
            var request = objectStore.openCursor();
            var datalist = [];
            request.onsuccess = function(event) {
                var cursor = event.target.result;
                if(cursor) {
                    var isPass = true;
                    var searchJson = JSON.parse(_this.form.find("[name=searchJson]").val());
                    // filter jstree
                    if(searchJson.jstreeSearch != null) {
                        $.each(searchJson.jstreeSearch, function(i, jstree){
                            
                            if (jstree.value.length > 0){
                                var where = {};
                                $.each(jstree.value[0], function(k,v){
                                    where[k] = cursor.value[k];
                                });
                                var vFind = _.find(jstree.value, where );
                                if(vFind == null){
                                    isPass = false;
                                    return false;
                                }
                            }
                            
                        });                        
                    }
                    // filter multicombo
                    if( isPass){
                        var combosList = filterAllByElName( _this.jpaFile.schema.search.schema.elements , {type: "multiCombo"} );
                        $.each(combosList , function(i, combos){
                            var formarray = $(instances.list[0].form).serializeArray();
                            var formarrayCombo = _.filter(formarray, {name : combos.name});
                            if( formarrayCombo.length > 0 
                                && !_.includes( _.map(formarrayCombo, 'value') , cursor.value[combos.jpa_column.child_column.toUpperCase()] ) 
                            ){
                                isPass = false;
                                return false;
                            }
                                
                        });
                        
                    }
                    
                    // finally display
                    if(isPass){
                        datalist.push(cursor.value);
                    }
                    
                    cursor.continue();
                } else {
                    theGrid.jqGrid("clearGridData");
                    theGrid.setGridParam({data : datalist});
                    theGrid.trigger('reloadGrid');
                }
            };
        }
        
        
        
    },50);
}





