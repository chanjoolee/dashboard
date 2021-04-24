function genInstanceView(_entityId, _type,  _list_instance , _option ){
    
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
    // this.jpaFile.dataSrc = this.jpaFile.dataSources;
    this.containerId = "div_" + this.entityId + "_"+ this.type + "_" + this.idPrefix; 
    
    // make form 
    var formTemplate = `
        <form name="form" id="form" class="">
        <input type="hidden" name="searchJson" value='{}'/>
        </form>
    `;
    this.formId = this.containerId + "_form";    
    this.contentContainerId = this.containerId + "_content";
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
        // 제목을 Label 로 표시한다.
        var vPageLabel = this.entityId;
        var vJpa = _.find(instances.jpaFiles,{entityId : this.entityId});
        if (vJpa.entity_doc_obj != null && vJpa.entity_doc_obj.label != null){
            vPageLabel = vJpa.entity_doc_obj.label;
        }     
        var headStr = '[' + _.camelCase(vPageLabel) + ' ' + _.capitalize(this.type) +  ']  ' ;
        this.modalClone.find(".modal-header h6 span").text(headStr);
        if( this.option != null &&
            this.option.filterLabel != null){
                var filterStrs = [];        
                $.each(this.option.filterLabel,function(k,v){
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
    // 추가 2021.04.24
    this.fn_contextmenu();
    this.fn_subview();

    $("#loader").hide();


}

genInstanceView.prototype.makeContent = function(){
    var _this = this;
    var contentContainer = $("<div/>",{id: _this.contentContainerId});
    this.contentContainer = contentContainer;
    this.form.append(contentContainer);
    var makehtml = new makeHtmlBySchema( this.contentContainer , _this.schema , this );
}

genInstanceView.prototype.makeSchema = function(){

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

    // context menu 용. mobile에서도 작용하려면.
    v_items.push({
        label : "Context Menu",
        col : "context",
        orderby : 0 ,
        editable : false
    });
    v_items.push({line_feed:true});

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
                // if (docObj != null && docObj.view_hidden ){
                //     rtnObj.edit_tag = "hidden";
                // }
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
            if (docObj != null && docObj.view_hidden ){
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
            var jpaFile = _this.caller.jpaFile;
            var gridSchema = jpaFile.schema.contents.schema;
            var gridJson = findAllByElName( gridSchema.elements , {type:"grid"});

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
                    // userId: $("#userId").val(),
                    // sqlid: "dashboard.ssd_sm.script_master.update"
                    sqlid: gridJson.sqlId + ".edit"
                }, 
                async: false,			                    		
                success:  function(data){
                    response1 = data;
                    if(response1.result != 'success'){
                        state = false;
                        $("#modal-alert").attr("target-id", _this.containerId);
                        $("#modal-alert").find("p").text(response1.message);
                        $("#modal-alert").modal();
                    }
                                                            
                }
            });
            return state;
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
            $("#modal-success").attr("target-id", _this.containerId);
            $("#modal-success").find("p").text(msg);
            $("#modal-success").modal();
        }
        // ,progressObject: $("#loader"),
        // fn_pop_select : commonFunc.fn_pop_select
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
                        edit_type : "view",
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

genInstanceView.prototype.fn_contextmenu = function(){
    var _this = this;
    if(_this.jpaFile.entity_doc_obj.customFunc.fn_contextmenu_detail != null){
        _this.jpaFile.entity_doc_obj.customFunc.fn_contextmenu_detail.call(_this);
        return;
    }
    
    var default_option = {
        "selector": "#" + _this.contentContainerId + " .contextMenu",
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

            // Start Parent
            $.each(_this.jpaFile.dataSrc, function(i,src){
                // Label이 있으면 Label 로 표현한다.
                var itemName = src.parentEntity;
                var parentJpa = _.find(instances.jpaFiles,{entityId : src.parentEntity});
                if (parentJpa.entity_doc_obj != null && parentJpa.entity_doc_obj.label != null){
                    itemName = parentJpa.entity_doc_obj.label;
                }
                options.items[itemName] = {
                    name: itemName ,
                    callback : function(key, options){
                        var m = "clicked: " + key + ", data: " + $(this).text();

                        // Modal Pop
                        if(true){
                            // Form Submit
                            var filter = {};
                            // 표시를 Label 로 한다.
                            var filterLabel = {};
                            $.each(src.childColumnNames , function(i,column){
                                var parentColumn = src.parentColumnNames[i];
                                var parentColumnLabel = parentColumn;
                                
                                var parentColumnObj = _.find(parentJpa.gridProperties,{_name: parentColumn});
                                // 이것을 대안으로 써도 된다.
                                // findAllByElName(parentJpa.schema.contents.schema.elements, {name:parentColumn.toUpperCase()})
                                if(parentColumnObj._documentation != null &&  parentColumnObj._documentation.label != null)
                                    parentColumnLabel = parentColumnObj._documentation.label;

                                if(_this.data[column.toUpperCase()] != null){
                                    filter[parentColumn.toUpperCase()] = _this.data[column.toUpperCase()];
                                    filterLabel[parentColumnLabel] = _this.data[column.toUpperCase()];
                                }
                                // $(this).attr("cellValue");
                            });

                            var instanceOption = {
                                modal : true,
                                caller : _this ,
                                filter : filter ,
                                filterLabel : filterLabel
                            };
                            _this.list_instance.add_instance ( src.parentEntity , 'general' , instanceOption );
                            
                        }
                        return; 

                        
                    }
                };
            });
            // End Parent

            // Seperator
            options.items["Seperator"] = "-------------";
            // children
            var hasChildrens = false;
            var childrens = _this.jpaFile.childReferences;

            $.each(childrens , function(i,child){
                var child_columns = child.child_columns;
                var parent_columns = child.parent_columns;
               
                // entytyId를 넣어야 하므로 camelCase 를 쓰지 않는다.
                var itemName = child.childEntityName;
                // Label이 있으면 Label 로 표현한다.
                var vJpa = _.find(instances.jpaFiles,{entityId : child.childEntityName});
                if (vJpa.entity_doc_obj != null && vJpa.entity_doc_obj.label != null){
                    itemName = vJpa.entity_doc_obj.label;
                }
                options.items[itemName] = {
                    name: itemName ,
                    callback : function(key, options){
                        // var m = "clicked: " + key + ", data: " + $(this).text();
                        // console.log(m);

                        // Modal Pop
                        if(true){
                            // Form Submit
                            var filter = {};
                            // 표시를 Label 로 한다.
                            var filterLabel = {};
                            $.each(child_columns , function(i,column){
                                var parentColumn = parent_columns[i];
                                var childColumnLabel = column.toUpperCase();
                                var childColumnObj = _.find(vJpa.gridProperties,{_name:column});
                                // 이것을 대안으로 써도 된다.
                                // findAllByElName(vJpa.schema.contents.schema.elements, {name:parentColumn.toUpperCase()})
                                if(childColumnObj._documentation != null && childColumnObj._documentation.label != null)
                                    childColumnLabel = childColumnObj._documentation.label;
                                
                                if(_this.data[column.toUpperCase()] != null){
                                    filter[column.toUpperCase()] = _this.data[parentColumn.toUpperCase()];
                                    filterLabel[childColumnLabel] = _this.data[parentColumn.toUpperCase()];
                                }
                                    
                                // $(this).attr("cellValue");
                            });
                            
                            var instanceOption = {
                                modal : true,
                                caller : _this ,
                                filter : filter ,
                                filterLabel : filterLabel
                            };
                            _this.list_instance.add_instance ( child.childEntityName , 'general' , instanceOption );
                            
                        }
                        return ;

                        
                    }
                };
               
            });
            

            // 참조가 하나만 있는 경우. 바로 보여주기. 일단주석
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

genInstanceView.prototype.fn_getData = function(){
    var _this = this;
    var selected_id = _this.grid.jqGrid('getGridParam','selrow');
    _this.data = _this.grid.getRowData(selected_id);
}

genInstanceView.prototype.fn_subview = function(){
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