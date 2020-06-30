function genInstanceCopy(_entityId, _type,  _list_instance , _option ){
    
    $("#loader").show();
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
    this.caller  = this.option.caller;
    
    this.jpaFile = this.option.caller.jpaFile;
    this.db = db;
    // this.jpaFile.dataSrc = this.jpaFile.dataSources;
    this.containerId = "div_" + this.entityId + "_"+ this.type + "_" + this.idPrefix; 
    
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
    this.grid = $("#" + this.caller.gridId).jqGrid();
    
    var _this = this;
    if(this.option != null && this.option.modal){
        var modalCommon = $("[name=modal-edit]");
        this.modalClone = modalCommon.clone();
        this.modalClone.attr("isCloned","true");

        // Header        
        var headStr = '[' + _.camelCase(_this.entityId) + ' ' + _.capitalize(this.type) +  ']  ' ;
        this.modalClone.find(".modal-header h6 span").text(headStr);
        if( this.option != null &&
            this.option.filter != null){
                var filterStrs = [];        
                $.each(this.option.filter,function(k,v){
                    var str = _.camelCase(k);
                    str += " : " + v;
                    filterStrs.push(str);
                });
                headStr += filterStrs.join(" , ");	
                this.modalClone.find(".modal-header h6 span").text(headStr);

        }												
        this.modalClone.find(".modal-header h6 span").text(headStr );
        // this.modalClone.find(".modal-header h6 span").append()

        // inintial search
        var v_filters = [];        
        this.form.find("[name=searchJson]").val(JSON.stringify({fields: v_filters}));

        // modalId
        this.modalClone.attr("id", this.containerId );
        this.modalClone.attr("name", "infiniteLogModal" + this.containerId );
        this.container = this.modalClone.find(".modal-body");        
        
        // this.list_instance.container.append(this.modalClone);
        // document.body.append(this.modalClone);
        $("#pagebody .br-section-wrapper").append(this.modalClone);

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
    this.contentContainer = null;
    this.data = {};
    this.schema = {};
    this.makeSchema();
    this.makeContent();
    this.fn_subview();

    $("#loader").hide();


}

genInstanceCopy.prototype.makeContent = function(){
    var _this = this;
    var contentContainer = $("<div/>",{id: this.gridContainerId});
    this.contentContainer = contentContainer;
    this.form.append(contentContainer);
    var makehtml = new makeHtmlBySchema( this.contentContainer , _this.schema , this );
}

genInstanceCopy.prototype.makeSchema = function(){

    var _this = this;
    this.fn_getData();

    var vKeys = [];
    $.each([].concat( _this.jpaFile.gridProperties ), function(i, prop){
        if (prop.isKey){
            vKeys.push(prop._name.toUpperCase());
        }
    });
    var v_type = "inline_edit";


    var v_items = [];
    var theGrid = $("#" + _this.caller.gridId).jqGrid();
    var cms = theGrid.jqGrid("getGridParam", "colModel");

    // custom order by
    var entityDoc = this.caller.jpaFile.entity_doc_obj ;
    if (entityDoc.detail != null && entityDoc.detail.order_by != null){
        $.each(entityDoc.detail.order_by, function(i, _order){									
            var _cms = cms;									
            var prop = _.find([].concat(_this.jpaFile.gridProperties), {_name : _order.column_name});
            // var docObj = JpaAllGeneratorBracket.prototype.documentToObject( prop._documentation );
            var docObj = prop._documentation;
            if (docObj == null){
                docObj = {};
            }
            var rtnObj = {};
            if (prop != null){										
                rtnObj = {
                    label : _.capitalize(_.upperCase(prop._name)),
                    col : prop._name.toUpperCase() ,
                    orderby : i ,
                    editable : true
                };
                if (prop.isKey){
                    rtnObj.required = true;
                }
                if (docObj.required){
                    rtnObj.required = docObj.required;
                }
                
                // list hiden columns
                if ( prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" ){
                    rtnObj.isDateTime = true;
                }
                var vEdit = prop._documentation['edit_tag'];
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
                    if ( _this.caller.option.filter[rtnObj.col] != null && _this.caller.option.filter[rtnObj.col] != ""){
                        rtnObj.edit_tag = 'input';
                        rtnObj.editable = false;
                    }
                }

                // if add_hidden , then edit_tage : hidden
                
                if (docObj != null && docObj.add_hidden ){
                    rtnObj.edit_tag = "hidden";
                }
                v_items.push(rtnObj);
            }else {
                rtnObj = _order;
                rtnObj.orderby = i;
                var prop1 = _.find(_this.jpaFile.gridProperties,{"_name": _order.column_name});
                if(prop1 != null && prop1._documentation != null && prop1._documentation.add_hidden ){

                }else{
                    rtnObj.col = _order.column_name;
                    v_items.push(rtnObj);
                }
            }
            

        });
        
    }

    // Process than not exists in orderby 
    $.each([].concat( _this.jpaFile.gridProperties ), function(i, prop){		
        // var docObj = JpaAllGeneratorBracket.prototype.documentToObject( prop._documentation );	
        var docObj = prop._documentation;
        if (docObj == null){
            docObj = {};
        }			
        var v_item = _.find([].concat(v_items),{col : prop._name.toUpperCase()});
        if ( v_item == null){
            var _cms = cms;									
            var rtnObj = {};
                                                
            rtnObj = {
                label : _.capitalize(_.upperCase(prop._name)),
                col : prop._name.toUpperCase() ,
                orderby : 100,
                editable : true
            };

            // required 
            if (prop.isKey){
                rtnObj.required = true;
            }
            if (docObj.required){
                rtnObj.required = docObj.required;
            }

            // list hiden columns
            if ( prop.type._href == "http://www.eclipse.org/emf/2002/Ecore#//EDate" ){
                rtnObj.isDateTime = true;
            }
            var vEdit = prop._documentation['edit_tag'];
            if(vEdit != null){
                rtnObj.edit_tag = vEdit._value;
            }

            // if add_hidden , then edit_tage : hidden
            if (docObj != null && docObj.add_hidden ){
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
                if ( _this.caller.option.filter != null
                    && _this.caller.option.filter[rtnObj.col] != null 
                    && _this.caller.option.filter[rtnObj.col] != "" ){
                    rtnObj.edit_tag = 'input';
                    rtnObj.editable = false;
                }
            }
            
            v_items.push(rtnObj);
        }
    });

    // pop_select
    var pop_props = _.filter( _this.jpaFile.gridProperties , {_documentation: { data_src_type : "pop_select" } });
    $.each(pop_props, function(i,pop_prop){
        var pop_item = _.find(v_items , {col : pop_prop._name.toUpperCase()});
        if (pop_item != null)
            pop_item.edit_tag = "pop_select";
    });

    // label more field merge
    $.each(v_items , function(i, _item){
        if (_item.col == null)
            return true;
        var v_property = _.find( _this.jpaFile.gridProperties , { _name : _item.col.toLowerCase() });
        if ( v_property != null && v_property._documentation != null){
            _.merge(_item , v_property._documentation);
            
        }

    });

    // schema_options
    var schema_options = {
        keys : vKeys ,
        fn_change: function( input ){									
            // cascade update
            var __this = this;
            var jpaFile =  _this.caller.jpaFile ;
            var gridSchema = jpaFile.schema.contents.schema;
            var gridJson = findAllByElName( gridSchema.elements , {type:"grid"});
            
            var item = _.find(gridJson.items, {name : this.props.options.name});
            var dataSrc = jpaFile.dataSrc ;
            var src = {};
            if (item != null && item.referenceId != null && dataSrc != null){
                src = _.find( dataSrc, {"referenceId": item.referenceId, "topRefrenceId" : item.topRefrenceId , "childColumnName": item.name.toLowerCase()  });
            }
            if ( src.parentColumnNames != null && src.parentColumnNames.length > 1){
                var index = _.indexOf( _.map(src.childColumnNames,function(column){ return column.toUpperCase();  }) , item.name.toUpperCase() );
                if (index > -1 && index < (src.parentColumnNames.length -1 )){
                    var nextColumn = src.childColumnNames[index+1];
                    var nextCm = _.find( cms , {name: nextColumn.toUpperCase() });												
                    var wheres = src.childColumnNames.slice(0,index + 1);
                    // var frm = document.getElementById("form");
                    var frm = _this.form[0];
                    var param = {};
                    $.each(wheres , function(i, where ){
                        var whereReact = _.find(__this.reactObjects , 
                            { 
                                props : {
                                    options : {
                                        name: where.toUpperCase()
                                    } 
                                }															
                            }
                        );
                        if ( __this == whereReact )
                            param["search_" + _.camelCase(where) ] = input;
                        else
                            param["search_" + _.camelCase(where) ]  =  whereReact.state.value;
                    });												
                    var nextSrc = _.find(dataSrc, {"referenceId": nextCm.referenceId, "topRefrenceId" : nextCm.topRefrenceId , "childColumnName": nextCm.name.toLowerCase()  });
                    var list = nextSrc.dataDynamic(param);
                    var nextReact = _.find( __this.reactObjects , 
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
            var state = true;
            var reactObjects = this;
            var addRow = {};
            var jpaFile = _this.caller.jpaFile;
            var gridSchema = jpaFile.schema.contents.schema;
            var gridJson = findAllByElName( gridSchema.elements , {type:"grid"});
            $.each(reactObjects,function(i,react){
                addRow[this.state.name] = this.state.value;
            });
            addRow['sqlid'] = gridJson.sqlId + ".insert";

            var form1 = _this.form;

            // fileupload
            var parameter = "";
            // if you want to upload options ....
            // parameter = "uploadBoard=schema";
            // parameter += "&useRealFileName=Y";
            var fileInfo = {};
            if(_.find(reactObjects,{state : {edit_tag:'file'}}) != null){
                form1.ajaxForm({
                    url: "./fileTestJson.html?" + parameter 
                    , type:"POST"
                    , dataType:"json"
                    , async: false
                    , success:function(json) {
                        fileInfo = json;
                    }
                    , error:function(e){
                        alert(e.responseText);
                    }
                });
                form1.submit();
            }            
            _.merge(addRow, form1.serializeFormJSON() );
            
            var edit_items = filterAllByElName( gridSchema.elements , {edit_tag : 'file'});
            if (edit_items.length > 0 ){
                $.each(edit_items, function(i,edit_item){
                    var item_fileinfo = _.find( fileInfo.searchVO.fileInfoList , {fieldName : edit_item.col });
                    if (item_fileinfo != null){
                        addRow[edit_item.col] = item_fileinfo.orgFileName;
                        addRow[edit_item.file_info.path_column] = item_fileinfo.filePath;
                        
                    }		
                });
                                                    
            }

            var transaction = _this.db.transaction( [_this.entityId ], "readwrite");
            transaction.oncomplete = function(event) {
                // var msg = "Save Success!";
                // $("#modal-success").attr("target-id", _this.containerId);
                // $("#modal-success").find("p").text(msg);
                // $("#modal-success").modal();
            };

            transaction.onerror = function(event) {
                state = false;
                // $("#modal-alert").attr("target-id", _this.containerId);
                // $("#modal-alert").find("p").text("Duplicate items not allowed");
                // $("#modal-alert").modal();
            };
            var objectStore = transaction.objectStore(_this.entityId);
            var objectStoreRequest = objectStore.add(addRow);

            objectStoreRequest.onsuccess = function(event) {
                // report the success of our request
                // note.innerHTML += '<li>Request successful.</li>';
                _this.caller.fn_search();
                var msg = "Save Success!";
                $("#modal-success").attr("target-id", _this.containerId);
                $("#modal-success").find("p").text(msg);
                $("#modal-success").modal();
                return state;
            };

            objectStoreRequest.onerror = function(event) {
                state = false;
                $("#modal-alert").attr("target-id", _this.containerId);
                $("#modal-alert").find("p").text("Duplicate items not allowed");
                $("#modal-alert").modal();
                return state;
            };

        }
    };


    if (entityDoc.add_button_option != null){
        schema_options.button_option = entityDoc.add_button_option ;
    }

    _this.schema = {
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
                        edit_type : "copy",
                        cols: entityDoc.detail_cols_add =! null  ? entityDoc.detail_cols_add : 1 ,
                        data: function(){ 
                            return _this.data ;
                        },
                        options : schema_options,
                        items: v_items 
                        
                    }
                    
                
                ]
            }
            
        
        ]
    };  



}

genInstanceCopy.prototype.fn_getData = function(){
    var _this = this;
    var selected_id = _this.grid.jqGrid('getGridParam','selrow');
    _this.data = _this.grid.getRowData(selected_id);
}

genInstanceCopy.prototype.fn_subview = function(){
    var _this = this;
    if( _this.jpaFile.entity_doc_obj != null && _this.jpaFile.entity_doc_obj.show_sub_pages){
        _this.sub_container = $("<div/>",{id: _this.containerId + "_subcontainer"});
        _this.container.append(_this.sub_container);
        _this.sub_instance = {
            parent_instance : _this,
            list : new gen_instance_list(_this.sub_container , _this.list_instance.jpaFiles )
        };
        var childrens = _this.jpaFile.childReferences;
        $.each(childrens , function(i,child){
            var instanceOption = {
                modal : false,
                caller : _this ,
                filter : _this.option.filter,
                showLabel : true 
            };
            _this.sub_instance.list.add_instance ( child.childEntityId , 'general' , instanceOption );
        });
        
    }
}
