function makeHtmlBySchema( _container , _schema , _instance ){
    this.container = _container; 
    this.schema = _schema;
    this.instance = _instance ;
    this.process_type( _schema , null , _container );
}

makeHtmlBySchema.prototype.process_type = function(  _schema , _schema_parent , container_parent ){
    var _this = this;
    _schema.parentSchema = _schema_parent;
    _schema.parentContainer = container_parent;

    var container = $("<div/>",{});
    container_parent.append(container);    
    eval("_this." + _schema.type + "( _schema , _schema_parent , container , container_parent)");
    _this.defaultSetting( _schema , container);
    
    if(_schema.elements != null){
        $.each( _schema.elements , function( i , el){
            _this.process_type( el , _schema ,  container  );
        });
    }    
}


makeHtmlBySchema.prototype.defaultSetting = function( _schema , _container ){
    var _this = this;
    // if(_this.schema.containerType == "search" && _schema.type != "SearchHeader"){
    //     _container.removeClass("col-sm-2");
    //     _container.addClass("col-sm");
    // }

    if( _schema.id != null){
        _container.attr("id", _schema.id + "Container");
    }

    // if( _schema.parentSchema != null && _schema.parentSchema.type == 'HorizontalLayout'){
    //     _container.css("display","inline-block");
    // }

    if( _schema.width != undefined)
        _container.css("width",_schema.width);

    // if( _container.children().length > 0)
    //     _container.css("margin-left","10px");


    if(_schema.containerCls != undefined)
        _container.addClass(_schema.containerCls);


    //***  css ***//
    if(_schema.containerCss != null){
        $.each(_schema.containerCss,function(i,v){
            _container.css(v.code,v.value);
        });
    }

    // // events
    // if( _schema.mainControl != null  && _schema.events != undefined ){
    //     _schema.mainControl.htmlMaker = _this;
    //     $.each(_schema.events,function(ikey,event){
    //         _schema.mainControl.on( ikey, event);
    //     });
    // }


}

makeHtmlBySchema.prototype.Vertical = function( _schema , _schema_parent , container , container_parent ){
    var _this = this;
    // var container = $("<div/>",{});
    // _this.defaultSetting( _schema , container);
    // return container;
}

makeHtmlBySchema.prototype.Group = function( _schema , _schema_parent , container , container_parent ){
    var _this = this;
    // var container = $("<div/>",{});
    // _this.defaultSetting( _schema , container);
    // return container;
}

makeHtmlBySchema.prototype.HorizontalLayout = function( _schema , _schema_parent , container, container_parent){
    var _this = this;

    // var container = $("<div/>",{ style: "display: inline-block "});
    // _this.defaultSetting(_schema , container);
    // container.addClass("row");
    // return container;
}

makeHtmlBySchema.prototype.inline = function(_schema ,_schema_parent , container,  container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    var cols = 3;
    if(_schema.cols != undefined)
        cols = _schema.cols;

    var width = (12 - _schema.cols*2)  / _schema.cols;
    var col_width = "col-sm-" + width;
    var rowDiv = null;
    $.each(_schema.items,function(i,item){
        if(i%cols == 0 ){
            rowDiv = $("<div/>",{class: "form-group row"});
            container.append(rowDiv);
        }
        var labelH = $("<label/>",{class: "col-sm-2 col-form-label input-group-text text-right"});
        labelH.text(item.label);
        rowDiv.append(labelH);

        var labelV = $("<label/>",{class: col_width + " col-form-label "});
        labelV.text(_schema.data()[item.col]);
        rowDiv.append(labelV);

    });

    // return container;
    
}

makeHtmlBySchema.prototype.inline_edit = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;
    var container_class = "form-layout form-layout-4";
    if ( _schema.edit_type == "view"){
        container_class = "form-layout form-layout-6";
    }
    container.addClass(container_class);

    var new_row_class = "form-group row";
    if ( _schema.edit_type == "view"){
        new_row_class = "no-gutters row";
    }

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    var cols = 1;
    if(_schema.cols != undefined)
        cols = _schema.cols;

    /**
     * btnGroup
     */
    var btnGroup = $("<div/>",{
        class: "btn_group",
        // style : "margin-bottom: 3px; width: 100% "
    });
    container.append(btnGroup);
    var edit_mode = "read";
    if ( _schema.edit_type == "view"){
        edit_mode = "read";
        btnGroup.hide();
    }else{
        edit_mode = "edit";
    }

    // button confirm
    var btnConfirm = $("<button/>",{
        type: "button",
        // style : "width: 100px "
    });
    btnGroup.append(btnConfirm);
    if(_schema.options != undefined && 
        _schema.options.button_option != undefined &&
        _schema.options.button_option.btn_class != null){
            btnConfirm.addClass(_schema.options.button_option.btn_class);	
    }else{
            // btnConfirm.addClass("btn btn-default");
            btnConfirm.addClass("btn btn-outline-primary btn-block mg-b-10");
            
    }

    if(_schema.options != undefined && 
        _schema.options.button_option != undefined &&
        _schema.options.button_option.label != null){
            btnConfirm.text(_schema.options.button_option.label);
    }else{
            btnConfirm.text("Confirm");
    }
    btnGroup.append(btnConfirm);

    /**
     * btnGroup End
     */
    var reactObjects = [];
    var fn_make_group_label = function(_itemGroup){
        container.append('<br/>');
        var h3 = $(document.createElement("h3"));
        h3.addClass("cont_tit");
        h3.text(_itemGroup.option.group_label);
        container.append(h3);
        
    };

    var data = _schema.data();
    var fn_make_table = function(_itemGroup){	
        var minCols = Math.min(_itemGroup.items.length,cols);
        if(_itemGroup.option != null && _itemGroup.option.group_label != null){
            if (_itemGroup.option.cols != null)
                minCols = _itemGroup.option.cols;
            fn_make_group_label(_itemGroup);					
        }

        // var width = (12 - _itemGroup.cols*2)  / _itemGroup.cols;
        // var col_width = "col-sm-" + width;
        var col_width = "col-sm";
        var rowDiv = null;
        var j=0; // for line feed 
        
        $.each(_itemGroup.items,function(i,item){
            if (item.line_feed != null && item.line_feed){
                j = j + Math.abs( j - minCols );
                return true;
            }
            if(data[item.col] == undefined) {
                data[item.col] = "";
            }

            if(i%cols == 0 ){
                rowDiv = $("<div/>",{class: new_row_class });
                container.append(rowDiv);
            }
            // header
            var labelH = null;
            if ( _schema.edit_type != "view"){
                labelH = $("<label/>",{class: "col-sm-3 form-control-label"});
            }else{
                // view
                labelH = $("<div/>",{class: "col-sm-3 form-control-label"});
            }

            labelH.text(item.label);
            if(item.required){
                labelH.append('<span class="tx-danger">*</span>');
            }

            /**
             * value Div. 리액트 사용부분
             */
            // row div
            if(true){
                var inputDiv = $("<div/>",{class: col_width});
                // 리액트 옵션
                var tdOption = {
                    name: item.col,
                    //keys: _schema.keys,
                    value: data[item.col],
                    value_origin: data[item.col],
                    editable : item.editable != undefined ? item.editable : true,
                    required : item.required != undefined ? item.required : false,
                    isDateTime : item.isDateTime != undefined ? item.isDateTime : false,
                    mode: edit_mode,
                    label : item.label,
                    htmlMaker : _this
                };

                // if key not editabe
                if( _this.instance instanceof genInstanceEdit ){
                    var keyProp = _.find(_this.instance.jpaFile.gridProperties , { _name : item.col.toLowerCase(), isKey: true} );
                    if(keyProp != null){
                        tdOption.editable = false;
                    }
                }

                // react key 를 지정한다.
                if(_schema.options != undefined && _schema.options.keys != undefined){
                    var keys = [];
                    //var data = _schema.data();
                    $.each(_schema.options.keys,function(i,k){
                        var key = {
                            field: k,
                            value: data[k]
                        };
                        keys.push(key);
                    });
                    tdOption.keys = keys;
                }

                if(_schema.options != undefined && _schema.options.fn_submit != undefined)
                    tdOption.fn_submit = _schema.options.fn_submit;
                else {
                    tdOption.fn_submit = function(){
                        alert("submit function not defined");
                    };
                }

                if(_schema.options != undefined && _schema.options.fn_change != undefined)
                    tdOption.fn_change = _schema.options.fn_change;
                
                var width_select = "100%";
                var width_input = "100%";
                if (item.file_info != null){
                    item.edit_tag = "file";
                }

                if( item.edit_tag != undefined )	{
                    tdOption.edit_tag = item.edit_tag;
                    if(item.edit_style != undefined ){
                        tdOption.edit_style = item.edit_style;
                    } else {
                        if(item.edit_tag == "textarea"){
                            tdOption.edit_style = {height:"200px",width: "450px"};
                        } else if(item.edit_tag == "select"){
                            tdOption.edit_style = {width: width_select };
                            tdOption.selectOptions = item.selectOptions;
                        } else if(item.edit_tag == "radio"){
                            tdOption.edit_style = {width: "200px" };
                            tdOption.selectOptions = item.selectOptions;
                            if (tdOption.value == "")
                                tdOption.value = item.selectOptions[0].value;
                        } else if(item.edit_tag == "pop_select"){
                            tdOption.edit_style = {width: "70%", display: "inline-block" };		
                            tdOption.fn_pop_select = _schema.options.fn_pop_select ;
                            tdOption.search_str = "" ;
                            tdOption.btn_label = item.btn_label ;
                        } else if(item.edit_tag == "manual_attach"){
                            tdOption.edit_style = {width: "70%", display: "inline-block" };
                            tdOption.fn_manual_attach = _schema.options.fn_manual_attach ;
                            tdOption.btn_label = item.btn_label ;
                        } else {
                            tdOption.edit_style = {};
                        }
                    }
                }else {
                    tdOption.edit_tag = "input";
                    tdOption.edit_style = {
                        height: "2.5em",
                        width: width_input
                    };
                }

                var reacttd = window.fn_td( inputDiv[0], tdOption );
                // 날자형식인 경우 처리
                if (tdOption.isDateTime){
                    var dateEm = inputDiv.find("input");
                    dateEm.datetimepicker({ 
                        //formatDate: 'Y-m-d'
                        //, formatTime:'H:i'
                        format : 'Y-m-d H:i:s'
                        //format : 'H:i:s'
                        //, datepicker: false
                        , timepicker: true 
                        , step: 15
                        //, useSeconds: true //default true
                        , onSelectTime: function( _data, _target) {
                            // _target.trigger('change');
                            // var react = item;
                            item.setState({value:_target.val()})
                        },
                        onSelectDate :  function( _data, _target) {
                            // _target.trigger('change');
                            // var react = item;
                            item.setState({value:_target.val()})
                        },
                    });
                }

                reacttd.reactObjects = reactObjects;
                reactObjects.push(reacttd);		
                if( item.edit_tag != undefined )	{
                    if(item.edit_tag == "pop_select"){
                    } else if(item.edit_tag == "manual_attach"){
                    } else {
                        rowDiv.append(labelH);
                    }
                }else {
                    rowDiv.append(labelH);
                }
                
                rowDiv.append(inputDiv);
            }
            
            

            j++;
            /**
            value Div End
            */
        });


    };


    var itemGroups = [{items:[]}];
    /********************************************************/
    /******************* Show Items  ************************/
    /********************************************************/			
    var v_show_items = _.filter( _schema.items  , function(item){
        if (item.edit_tag != 'hidden')
            return true;
        else
            return false;
    });			
    $.each( v_show_items , function(i,item){
        if( item.group_label != null ){
            var addGroup = {
                option: {
                    group_label : item.group_label
                },
                items: []
            }
            if (item.cols != null ){
                addGroup.option.cols = item.cols;
            }
            itemGroups.push(addGroup);					
            return true;
        }
        var itemGroup = itemGroups[itemGroups.length -1];
        itemGroup.items.push(item);
    });
    /********************************************************/
    /******************* Hide Items  ************************/
    /********************************************************/
    var v_hide_items = _.filter( _schema.items  , function(item){
        if (item.edit_tag == 'hidden')
            return true;
        else
            return false;
    });
    if (v_hide_items.length > 0)
        itemGroups.push({items:[], display: 'none'});
    $.each( v_hide_items , function(i,item){
        if( item.group_label != null ){
            var addGroup = {
                option: {
                    group_label : item.group_label
                },
                items: []
            }
            if (item.cols != null ){
                addGroup.option.cols = item.cols;
            }
            itemGroups.push(addGroup);					
            return true;
        }
        var itemGroup = itemGroups[itemGroups.length -1];
        itemGroup.items.push(item);
    });

    $.each(itemGroups, function(i, group){
        fn_make_table(group);
    });

    // 맨나중에?
    btnGroup.appendTo(container);
    btnConfirm.click(function(){
        var a = "a";
        var state = true;
        $.each(reactObjects,function(i,item){
            if (this.state.required && (this.state.value == "" || this.state.value == null)  ){
                state = false;
                var v_msg = "Please input " + this.state.label;
                $("#modal-alert").attr("target-id", _this.instance.containerId);
                $("#modal-alert").find("p").text(v_msg);
                $("#modal-alert").modal();
            }
        });
        if(!state)
            return;
        // loader
        if(_schema.options != undefined && _schema.options.progressObject != undefined)
            _schema.options.progressObject.show();
        setTimeout(function(){
            
            if( _schema.edit_type == "edit"){
                state = _schema.options.fn_submit.call(reactObjects,"edit");
                // var keyUpdatedObjects = [];
                // // key 가 아닌것을 먼저 update
                // $.each(reactObjects,function(i,item){
                //     var isKeyUpdate = false;
                //     if(this.state.value_origin != this.state.value){
                //         var vObject = this;
                //         $.each(this.state.keys, function(){
                //             if(this.field == vObject.state.name){
                //                 this.value = vObject.state.value_origin;
                //                 isKeyUpdate = true;
                //             }
                                
                //         });
                //         if(!isKeyUpdate){
                //             state = item.props.options.fn_submit.call(this,"edit");
                //             this.setState({value_origin: this.state.value});
                //         }							
                //     }
                        
                //     if(!state)
                //         return false;
                //     // this.setState({mode: "read"});
                //     if(isKeyUpdate){
                //         keyUpdatedObjects.push(item);
                //     }
                // });
                
                // // key 는 나중에 업데이트 한다. 만약 키다 두개이상인 경우는 cover가 안됨
                // $.each(keyUpdatedObjects,function(i,item){
                //     state = item.props.options.fn_submit.call(this,"edit");
                //     this.setState({value_origin: this.state.value});
                        
                //     if(!state)
                //         return false;
                //     // this.setState({mode: "read"});
                    
                // });
                // if(state){
                //     // btnConfirm.hide();
                //     // btnCancel.hide();
                //     // btnEdit.show();
                //     if(_schema.options != undefined && _schema.options.fn_afterSubmit != undefined)
                //         _schema.options.fn_afterSubmit.call(reactObjects,keyUpdatedObjects);
                // }
            }else if (_schema.edit_type == "add"){
                state = _schema.options.fn_submit.call(reactObjects,"add");
                
            }else if (_schema.edit_type == "copy"){
                state = _schema.options.fn_submit.call(reactObjects,"copy");
            }

            
            // 키값을 업데이트 하는 경우
            if(false){
                if(state){
                    btnConfirm.hide();
                    btnCancel.hide();
                    btnEdit.show();
                    if(_schema.options != undefined && _schema.options.fn_afterSubmit != undefined)
                        _schema.options.fn_afterSubmit.call(reactObjects,keyUpdatedObjects);
                }
            }
            
            if(_schema.options != undefined && _schema.options.progressObject != undefined){
                _schema.options.progressObject.hide();
            }
                
        }
        ,50);
        
        
    });


    // return container;
    
}

/**
특이한 경우에만 사용한다. Iframe 을 어쩔 수 없이 써야만 하는 경우에만.
*/
makeHtmlBySchema.prototype.inline_iframe = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    // return container;
    
}

makeHtmlBySchema.prototype.grid = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    //==grid create    
    container.attr("id",_schema.id + 'Container');
    
    var containerType = container.attr("type");
        
    //==table create
    var gridId = _this.instance.gridId;
    var mainControl = $(document.createElement( "table" ));
    mainControl.attr("id", gridId );
    //table.css("width","100%");
    container.append(mainControl);
    
    //== page create
    var pager = $(document.createElement( "div" ));
    pager.attr("id", _this.instance.pagerId);
    container.append(pager);
    
    // refereced Items
    $.each(_schema.items , function(i, item){
        var dictionary = null;
        var dicCodes = [];
        if(typeof(_this.instance.jpaFile.dictionaries) != 'undefined' ){
            dictionary = _.find(_this.instance.jpaFile.dictionaries,{entityName: item.entityName  });
            if (dictionary != null)
                dicCodes = _.filter(dictionary.value, {"TABLE_NAME":item.entityName.toUpperCase(),"COLUMN_NAME": item.name});
        }
        if(dicCodes.length > 0){
            item.edittype = "select";
            if(item.formatter == null){
                item.formatter = "select";
            }
                
            var editopt = item.editoptions;
            if(editopt == undefined){							
                editopt = {};
                item.editoptions = editopt;
            }
            var editValue = {};
            $.each(dicCodes, function(j,code){
                editValue[code[dictionary.codeColumn.toUpperCase()]] =  code[dictionary.nameColumn.toUpperCase()];
            });
            editopt.value = editValue;

            if (item.stype == "select" 
                && item.searchoptions == null ){
                var search_value = ":ALL";													
                $.each(item.editoptions.value, function( k, v){
                    search_value += ";" + k + ":" +  v ;
                });
                
                item.searchoptions = { value : search_value};						
            }
            

        }else if(item.referenceId != undefined && _this.instance.jpaFile.dataSrc != undefined && !_.includes(['pop_select'], item.data_src_type)){
            var src = _.find(_this.instance.jpaFile.dataSrc, {"referenceId": item.referenceId, "topRefrenceId" : item.topRefrenceId , "childColumnName": item.name.toLowerCase()  });
            if( src != null ){
                item.edittype = "select";
                if(item.formatter == null)
                    item.formatter = "select";
                var editopt = item.editoptions;
                if(editopt == undefined){							
                    editopt = {};
                    item.editoptions = editopt;
                }
                editopt.value = src.value;
            }
            if ( src.parentColumnNames.length > 1){
                var index = _.indexOf( _.map(src.childColumnNames,function(column){ return column.toUpperCase();  }) , item.name.toUpperCase() );
                
                if (index > -1 && index < (src.parentColumnNames.length -1 )){
                    if(item.editoptions.dataEvents  == undefined )
                        item.editoptions.dataEvents = [];
                    var nextColumn = src.childColumnNames[index+1];

                    item.editoptions.dataEvents.push({
                        "type": "change" ,
                        "fn" : function (e) {
                            //console.log("hahahah");
                            var grid = mainControl;
                            var cms = grid.jqGrid("getGridParam", "colModel");
                            var cm = _.find( cms , {name: item.name });
                            var nextCm = _.find( cms , {name: nextColumn.toUpperCase() });
                            var wheres = src.childColumnNames.slice(0,index + 1);
                            var frm = $(this)[0].form;
                            var param = {};
                            $.each(wheres , function(i, where ){
                                param["search_" + _.camelCase(where) ]  =  $(frm).find("#" + where.toUpperCase()).val();
                            });

                            var nextSrc = _.find(dataSrc, {"referenceId": nextCm.referenceId, "topRefrenceId" : nextCm.topRefrenceId , "childColumnName": nextCm.name.toLowerCase()  });
                            var list = nextSrc.dataDynamic(param);
                            var nextEl =  $(frm).find("#" + nextCm.name);
                            var s = '<option value="">Select</option>';
                            $.each(list, function(j, m){
                                var selected = '';
                                if( false) {
                                    selected = ' selected="selected"';
                                }
                                s += '<option value="'+ m[ nextSrc.parentColumnName.toUpperCase() ]+'"'+ selected +' >'+ m[ nextSrc.parentNameColumn.toUpperCase() ]+'</option>';
                            });
                            nextEl.html( s);

                        }
                    });
                }

            }
        }
    });

    //== common option
    var opt = {
        datatype: 'local',
        styleUI : 'Bootstrap4',
        // guiStyle: "bootstrap4",
        colModel: _schema.items,
        //rowNum:10,
        rownumbers: true, // show row numbers
        caption: _schema.label,
        //width: '100%',
        //height: '100%',
        iconSet: "fontAwesome",
        sortable: false,
        //viewrecords: true,
        //pager : pager, 
        //data : _schema.data() 
    };
    if(_schema.data != undefined && typeof _schema.data == 'function')
        opt.data = _schema.data();
    
    if(_schema.gridOpt != undefined){
        $.extend(opt, _schema.gridOpt);
    }
    $.extend(opt, {styleUI: "Bootstrap4", iconSet: "fontAwesome"});

    // getGridParam 추가
    opt.gridProperties = _this.instance.jpaFile.gridProperties ;

    // gridId , pagerId
    opt.gridId = gridId ;
    opt.pager = "#" + gridId + "_pager";
    
    opt.htmlMaker = _this ;
    // if(opt.url == null){
    //     opt.url = function(){
    //        var tx =  this.htmlMaker.instance.db.transaction(this.htmlMaker.instance.entityId, "readwrite");
    //        return tx.objectStore(this.htmlMaker.instance.entityId);
    //     }
    // }


    // 

    // gridComplete
    if(opt.gridComplete == null){
        opt.gridComplete = function () {
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
            
            grid.navGrid(
                gridParam.pager ,
                { edit: true, add: true, del: true, search: false,  refresh: true, view: true, position: "left", cloneToTop: false  
                    ,addfunc: function(){
                        // commonFunc.fn_view_detail.call(this,'add');
                        var filter = {};
                        var instanceOption = {
                            modal : true,
                            caller : gridParam.htmlMaker.instance ,
                            filter : filter
                        };
                        gridParam.htmlMaker.instance.list_instance.add_instance( gridParam.entityId , 'add' , instanceOption );
                    }
                    , editfunc : function(){
                        // commonFunc.fn_view_detail.call(this,'add');
                        var filter = {};
                        var parentRowKey = grid.jqGrid('getGridParam','selrow');
                        var row = grid.getRowData(parentRowKey);
                        $.each(gridParam.htmlMaker.instance.jpaFile.gridProperties , function(i,prop){
                            if(prop.isKey){
                                filter[prop._name.toUpperCase()] = row[prop._name.toUpperCase()];
                            }
                        });
                        var instanceOption = {
                            modal : true,
                            caller : gridParam.htmlMaker.instance ,
                            filter : filter
                        };
                        gridParam.htmlMaker.instance.list_instance.add_instance( gridParam.entityId , 'edit' , instanceOption );
                    }, viewfunc : function(){
                        var filter = {};
                        var parentRowKey = grid.jqGrid('getGridParam','selrow');
                        var row = grid.getRowData(parentRowKey);
                        $.each(gridParam.htmlMaker.instance.jpaFile.gridProperties , function(i,prop){
                            if(prop.isKey){
                                filter[prop._name.toUpperCase()] = row[prop._name.toUpperCase()];
                            }
                        });
                        var instanceOption = {
                            modal : true,
                            caller : gridParam.htmlMaker.instance ,
                            filter : filter
                        };
                        gridParam.htmlMaker.instance.list_instance.add_instance( gridParam.entityId , 'view' , instanceOption );
                    }

                }
                // options for the Edit Dialog
                ,{  }
                // options for the Script Master Add Dialog
                ,{  }
                // options for the Script Master Del Dialog 
                ,{  
                    reloadAfterSubmit: true,
                    afterSubmit: function(response, postdata) { 
                        //$("#refresh_grid_script").hide();
                        // var grid = $(this);
                        var state = true;
                        var paramObj = {
                            delRows : []
                        };
                        $.each(postdata.id.split(","),function(i,rowid){
                            var row = grid.getRowData(rowid);
                            var delQuery = [];
                            $.each(gridParam.htmlMaker.instance.jpaFile.gridProperties , function(i,prop){
                                if(prop.isKey){
                                    delQuery.push(row[prop._name.toUpperCase()]);
                                }
                            });

                            var transaction = gridParam.htmlMaker.instance.db.transaction( [ _this.instance.entityId ], "readwrite");
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
                            var objectStore = transaction.objectStore( _this.instance.entityId );
                            var objectStoreRequest = objectStore.delete(delQuery);
                            objectStoreRequest.onsuccess = function(event) {
                                // _this.caller.fn_search();
                                // var msg = "Delete Success!";
                                // $("#modal-success").attr("target-id", _this.instance.containerId);
                                // $("#modal-success").find("p").text(msg);
                                // $("#modal-success").modal();
                                return [state];
                            };
                
                            objectStoreRequest.onerror = function(event) {
                                state = false;
                                $("#modal-alert").attr("target-id", _this.instance.containerId);
                                $("#modal-alert").find("p").text("Delete Fail!");
                                $("#modal-alert").modal();
                                return [state];
                            };

                        });


                        return [true];
                        // //return [success,message,new_id] ;
                        // if(response1.result == 'success'){
                        //     //$(this).trigger('reloadGrid'); 
                        //     return [true, response1.result, ''];
                        // }
                        // else
                        //     return [false, response1.result + ":<br/>" + response1.message , ''];
                            
                    },
                    afterShowForm: function($form) {
                        var dialog = $form.closest('div.ui-jqdialog'),
                        selRowId = gridParam.selrow ,
                        selRowCoordinates = gridParam.htmlMaker.instance.form.find('#'+selRowId).offset();
                        dialog.offset(selRowCoordinates);
                    }

                }
                ,{ 
                    multipleSearch: true,
                    multipleGroup: true
                }
            );


            /******
            * Copy 메뉴를 한번만 생성하기 위함. search를 할 때마다 gridComplete 가 실행됨.
            */
            var hasCopy = true;
            var pager = $(gridParam.pager);
            var dropmenu = $("#" + pager.find(".dropdownmenu").val() );
            if( pager.find(".ui-pg-button[title=Copy]").length == 0 ){
                hasCopy = false;
            }
            if(!hasCopy){
                if(dropmenu.length > 0){
                    if (dropmenu.find(".g-menu-item:contains(Copy)").length > 0 ){
                        hasCopy = true;
                    }
                }
            }
            
            if ( !hasCopy ) {
                grid.navButtonAdd(gridParam.pager, {
                    caption : "", 
                    title: "Copy",
                    buttonicon : "fa-copy",
                    onClickButton: function(){ 
                        // commonFunc.fn_view_detail.call(this,'add');
                        var filter = {};
                        var parentRowKey = grid.jqGrid('getGridParam','selrow');
                        if (parentRowKey == null ){
                            $("#modal-alert").attr("target-id", _this.instance.containerId);
                            $("#modal-alert").find("p").text("Please, select row");
                            $("#modal-alert").modal();
                            return;
                        }
                        var row = grid.getRowData(parentRowKey);
                        $.each(gridParam.htmlMaker.instance.jpaFile.gridProperties , function(i,prop){
                            if(prop.isKey){
                                filter[prop._name.toUpperCase()] = row[prop._name.toUpperCase()];
                            }
                        });
                        var instanceOption = {
                            modal : true,
                            caller : gridParam.htmlMaker.instance ,
                            filter : filter
                        };
                        gridParam.htmlMaker.instance.list_instance.add_instance( gridParam.entityId , 'copy' , instanceOption );
                    }, 
                    position:"last"
                });
                if(dropmenu.length == 0){
                    var td_cp = $(gridParam.pager).find(".ui-pg-table .ui-pg-button[title='Copy']")
                    var td_add = $(gridParam.pager).find(".ui-pg-table .ui-pg-button[title='Add new row']");
                    td_add.after(td_cp);
                }else{
                    var li_cp = dropmenu.find(".g-menu-item:contains(Copy)").parent();
                    var li_add = dropmenu.find(".g-menu-item:contains(Add new row)").parent();
                    li_add.after(li_cp);
                }
                

            }
            
            // var gridBody = $("#gbox_" + gridParam.id + " .ui-jqgrid-bdiv");
            // gridBody.height( gridBody.height() + 10  );
            var gridBody = $("#gbox_" + gridParam.id + " .ui-jqgrid-bdiv");
            gridBody.height( "100%");   
            if( !_this.instance.option.modal ){
                grid.setGridWidth(_this.instance.container.width());
            }  
            gridBody.height( gridBody.height() + 10  );       
            
                
            
        
        }
    }
    // onCellSelect
    if(opt.onCellSelect == null){
        opt.onCellSelect = function (rowId, iCol, content, event) {

            var grid = $(this).jqGrid();
            var gridParam = grid.getGridParam();
            var row = grid.jqGrid('getRowData',rowId);
            var cms = grid.jqGrid("getGridParam", "colModel");
            var cm = cms[iCol];
            var vGridOpt  = grid.getGridParam();

            var oFrm = _this.instance.form;
            var v_property = _.find(vGridOpt.gridProperties, { _name : cm.name.toLowerCase() });
            
            //customize
            var somCondition = ( v_property != null && 
                v_property._documentation != null &&
                v_property._documentation.file_info != null );

            if ( somCondition ){
                var path_column = v_property._documentation.file_info.path_column ;
                var path = '.'+ row[path_column] ;
                if((/\.(txt|config|pdf|jpg|jpeg|gif|png|log)$/i).test(path)){
                    var newWin1 = window.open("", "filedownload", "width=1200,height=900, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
                    
                    oFrm.action =  path;
                    oFrm.method = "post";
                    oFrm.target = 'filedownload'; 
                    oFrm.submit();		
                    newWin1.focus();
                }else if(row[cm.name].match(/\.([\w]+)$/i) != null){
                    //var src = "/dashboard/filedownloadJson.do";
                    //src += "?filename=" + row.FILE_NAME;
                    //src +="&path=" + row.FILE_PATH;
                    //document.getElementById('file_iframe').src =  src;
                    
                    var isIE = /*@cc_on!@*/false || !!document.documentMode; // At least IE6
                    if (isIE){
                        //var fileData = ['\ufeff' + "." + row.FILE_PATH];
                        //var blobObject = new Blob(fileData);
                        //window.navigator.msSaveOrOpenBlob(blobObject, row.FILE_NAME);
                        var link = document.createElement('a');
                        // customize for same path and name ==> formalize 
                        var value_split = row[cm.name].split("/");
                        var return_text = value_split.pop();
                        // link.download = row[cm.name];
                        link.download = return_text;
                        link.href = "." + row[path_column] ;
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
                        link.href = "." + row[path_column] ;
                        //Firefox requires the link to be in the body
                        document.body.appendChild(link);
                        link.click();
                        document.body.removeChild(link);
                    }
                                                            
                }
            }
        }
    }
    opt.height = "100%";
    mainControl.jqGrid(opt);
    
    
    // width가 100%인 경우
    if(opt.width != undefined && opt.width == '100%'){
        container.find(".ui-jqgrid").css("width","100%");
        container.find(".ui-jqgrid-view").css("width","100%");
        container.find(".ui-jqgrid-hdiv").css("width","100%");
        container.find(".ui-jqgrid-bdiv").css("width","100%");
        container.find(".ui-jqgrid-sdiv").css("width","100%");
        container.find(".ui-jqgrid-pager").css("width","100%");
    }

    // return container;
}





makeHtmlBySchema.prototype.SearchHeader = function(_schema , _schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);
        
    container.text(_schema.text);
    container.addClass("col-sm-2");
    // var mainControl = $(document.createElement("span"));
    // //h3.addClass("cont_tit");
    // container.append(mainControl);
    // mainControl.text(_schema.text);
    // mainControl.css("font-weight","bold");
    // mainControl.css("text-align","right");
    // mainControl.css("color","#000");
    

    // return container;
}

makeHtmlBySchema.prototype.multiCombo = function(_schema ,_schema_parent , container, container_parent){
    var _this = this;
    var vData = [];
    if ( _schema.data != null && typeof _schema.data == "function"){
        vData = _schema.data();
        _this.multiCombo_dom(_schema, container, vData);
    }else{
        var transaction = _this.instance.db.transaction( [_schema.entityId], "readonly");
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
        var objectStore = transaction.objectStore(_schema.entityId);
        var request = objectStore.openCursor();
        var datalist = [];
        request.onsuccess = function(event) {
            var cursor = event.target.result;
            if(cursor) {
                datalist.push(cursor.value);
                cursor.continue();
            }else{
                var column = _schema.options.cd.toUpperCase();
                if ( _schema.options.cd != _schema.options.name){
                    column += "," +  _schema.options.name ;
                }
                vData = alasql("select distinct " + column +" , 'selected' as selected from ?",[datalist]);
                _this.multiCombo_dom(_schema, container, vData);
            }
        };

    }
    
    


    // return container;
}

makeHtmlBySchema.prototype.multiCombo_dom = function(_schema, container, vData){
    var _this = this;
    var sb = [];
    var mainControl = $(document.createElement("select"));
    mainControl.css("width", _schema.width);
    if (_schema.multiselectOpt != undefined && _schema.multiselectOpt.multiple != undefined && _schema.multiselectOpt.multiple == true)
        mainControl.attr("multiple", "multiple");
    if (_schema.name != undefined)
        mainControl.attr("name", _schema.name);
    if (_schema.id != undefined)
        mainControl.attr("id", _schema.id);
    container.append(mainControl);


    /* var option1 = $(document.createElement( "option" ));
    option1.val('xxx');
    option1.text('xxx');
    option1.css("display","none");
    mainControl.append(option1); */
    if (_schema.options.group != undefined) {
        var groupKeys = [_schema.options.group.cd, _schema.options.group.name];
        var series = getDrillDownDataSeries2(
            '',
            vData,
            groupKeys,
            [],
            [],
            '',
            '',
            { cd: _schema.options.group.cd, name: _schema.options.group.name },
            { isGroupby: false }
        );
        var selected = "selected";
        var sb = [];
        sortObjects(series.series, ['name']);
        $.each(series.series, function (index, s) {
            var optGrp = $(document.createElement("optgroup"));
            optGrp.attr("label", s.name);
            optGrp.attr("cd", s.cd);
            mainControl.append(optGrp);
            $.each(s.data, function (index1, d) {
                var option = $(document.createElement("option"));
                option.val(this[_schema.options.cd]);
                option.text(this[_schema.options.name]);
                //모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
                $.each(this, function (k, v) {
                    option.attr(k.toLowerCase(), v);
                });
                optGrp.append(option);
            });
        });

    }
    else {
        $.each(vData, function () {
            var option = $(document.createElement("option"));
            option.val(this[_schema.options.cd]);
            option.text(this[_schema.options.name]);
            var _this = this;
            //모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
            $.each(this, function (k, v) {
                try {
                    option.attr(k.toLowerCase(), v);
                }
                catch (e) {
                    console.log(_this);
                }
            });
            //sb.push("<option value='"+ this[_schema.options.cd] +"' "+''+">" + this[_schema.options.name] +"</option>");
            mainControl.append(option);
        });
    }



    //$(vSelect).append(sb.join(""));
    //$(vSelect).append(sb.join(""));
    var multiselectOpt = {
        //selectedList: 1,
        // multiple: true,
        height: 300,
        minWidth: 100,
        //selectedText: _schema.text + ' # selected',
        selectedText: function (numChecked, numTotal, checkedItems) {
            return numChecked + ' of ' + numTotal + ' checked';
        },
        noneSelectedText: 'Select ' + _schema.text
    };
    if (_schema.multiselectOpt != undefined)
        $.extend(multiselectOpt, _schema.multiselectOpt);
    var vMultiSelect = mainControl.multiselect(multiselectOpt).multiselectfilter();
    this.container.find("button.ui-multiselect.ui-widget").css("width", "100%");
    mainControl.multiselect('widget').css("width", "420px");
    mainControl.multiselect('widget').find(".ui-multiselect-filter input").css("width", "150px");
    // mainControl.multiselectOption = multiselectOpt;
    //filter by parent
    if (_schema.options.childrens != undefined) {
        $.each(_schema.options.childrens, function (i, child) {
            var childSchema = findAll(child.id, eval(child.topElement))[0];
            if (childSchema != undefined) {
                mainControl.on('change', function () {

                    $("select[name=" + _schema.name + "] option").each(function (i, sel) {
                        if ($(this).is(':selected')) {
                            $("select[name=" + child.id + "] option[" + _schema.options.cd + "='" + $(this).val() + "']").prop("disabled", false);
                            //$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", true );
                            $("select[name=" + child.id + "] option[" + _schema.options.cd + "='" + $(this).val() + "']").prop("selected", true);
                        }
                        else {
                            $("select[name=" + child.id + "] option[" + _schema.options.cd + "='" + $(this).val() + "']").prop("disabled", true);
                            //$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", false );
                            $("select[name=" + child.id + "] option[" + _schema.options.cd + "='" + $(this).val() + "']").prop("selected", false);
                        }
                    });

                    $("select[name=" + child.id + "] option").each(function (i, project) {
                        $("input[name=multiselect_" + child.id + "][value='" + $(this).val() + "']").prop("disabled", $(this).prop("disabled"));
                        if ($(this).prop("disabled")) {
                            $("input[name=multiselect_" + child.id + "][value='" + $(this).val() + "']").parent().addClass("ui-state-disabled");
                            $("input[name=multiselect_" + child.id + "][value='" + $(this).val() + "']").attr("checked", false);

                        }
                        else {
                            $("input[name=multiselect_" + child.id + "][value='" + $(this).val() + "']").parent().removeClass("ui-state-disabled");
                            $("input[name=multiselect_" + child.id + "][value='" + $(this).val() + "']").attr("checked", true);
                        }

                    });


                    //$("input[name=multiselect_"+ child.id+"]").each(function(){
                    //	$("select[name="+ child.id+"] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
                    //});
                    var childMultiselectOpt = {
                        //selectedList: 1,
                        height: 300,
                        minWidth: 100,
                        //selectedText: _schema.text + ' # selected',
                        selectedText: function (numChecked, numTotal, checkedItems) {
                            return numChecked + ' of ' + numTotal + ' checked';
                        },
                        noneSelectedText: 'Select ' + childSchema.text
                    };
                    if (childSchema.multiselectOpt != undefined)
                        $.extend(childMultiselectOpt, childSchema.multiselectOpt);


                    $("select[name=" + child.id + "]").multiselect(childMultiselectOpt).multiselectfilter();
                    //$("select[name="+ child.id+"]").multiselect(childSchema.multiselectOpt).multiselectfilter();
                    // 해당하는 Object 만 refresh 한다.
                    var my = $("select[name=" + child.id + "]");
                    //my.multiselect('refresh');
                    var $menu = $.data(my[0], "ech-multiselect").menu;
                    $menu.css("width", "420px");
                    $menu.find(".ui-multiselect-filter input").css("width", "150px");

                    //$("div.ui-multiselect-menu").css("width","400px");
                    //$(".ui-multiselect-filter input").css("width","150px");
                    var obj_child = $("#" + childSchema.id);
                    obj_child.trigger("change");
                });


            }

        });

    }

    if (_this.schema.containerType == "search") {
        mainControl.on("change", function () {
            _this.instance.fn_search();
        });
    }
}

makeHtmlBySchema.prototype.jsTreeSearch = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);
    var vData = [];
    if( _schema.data != null && typeof _schema.data ==  "function"){
        vData = _schema.data();
        _this.jsTreeSearch_afterData(_schema, container, vData);
    }else{
        var transaction = _this.instance.db.transaction( [ _schema.relation.parentEntityName], "readonly");
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
        var objectStore = transaction.objectStore(_schema.relation.parentEntityName);
        var request = objectStore.openCursor();
        var datalist = [];
        request.onsuccess = function(event) {
            var cursor = event.target.result;
            if(cursor) {
                datalist.push(cursor.value);
                cursor.continue();
            }else{
                vData = _.map(datalist, function(data,i){
                    var rtnObj = {};
                    $.each(_schema.keys, function(ii, key){
                        rtnObj[key.codeColumn.toUpperCase()] = data[key.codeColumn.toUpperCase()];
                        rtnObj[key.nameColumn.toUpperCase()] = data[key.nameColumn.toUpperCase()];
                    });
                    return rtnObj;
                });
                _this.jsTreeSearch_afterData(_schema, container, vData);
            }
        };
    }
    

    // return container;
}


makeHtmlBySchema.prototype.jsTreeSearch_afterData = function(_schema, container, vData) {
    var _this = this;
    var mainControl = $(document.createElement("div"));

    mainControl.addClass("ui-multiselect-menu ui-widget-content ui-corner-all");
    if (_schema.name != undefined)
        mainControl.attr("name", _schema.name);
    if (_schema.id != undefined)
        mainControl.attr("id", _schema.id);
    mainControl.hide();
    // mainContainer.append(mainControl);
    mainControl.appendTo(_this.instance.form);
    _this.instance.jstreeList.push(_schema);

    var button = $('<button type="button"><span class="ui-icon ui-icon-triangle-2-n-s"></span></button>')
        .addClass('ui-multiselect ui-widget ui-state-default ui-corner-all')
        .addClass("")
        .attr({ 'title': "", 'aria-haspopup': true })
        .css({ width: "100%" })
        .appendTo(container);

    var buttonlabel = $('<span />')
        .html("Js Tree Search")
        .appendTo(button);
    button.on("click", function () {
        // mainControl.toggle( 'blind', { to: { width: 200, height: 300 } }, 500 );
        var display = mainControl.css("display");
        var pos = $(this).offset();
        mainControl.css({
            top: pos.top + $(this).outerHeight(),
            left: pos.left
        });
        if (display == "none") {
            mainControl.show();
        }
        else
            mainControl.hide();


    });

    buttonlabel.attr("mainControlId", _schema.id);
    var searchTree = new List2Tree(vData, _schema.keys);
    _.merge(searchTree.tree,
        {
            checkbox: {
                // three_state : false,
                // cascade: 'undetermined',
                // visible: true,
                // three_state: false
                // tie_selection: false
            },
            'plugins': ["checkbox", "state"],
            // 'plugins': ["checkbox", "wholerow"],
            "core": {
                themes: {
                    'icons': false
                }
            }
        }
    );

    if (_schema.rootText != null) {
        searchTree.tree.core.data[0].text = _schema.rootText;
    }
    else {
        searchTree.tree.core.data[0].text = _.map(_schema.keys, function (key, i) {
            return _.camelCase(key);
        }).join("/");
    }

    mainControl.css("width", "400px");
    mainControl.css("max-height", "600px");
    mainControl.css("overflow", "scroll");
    mainControl.jstree(_.cloneDeep(searchTree.tree));
    var vtree = mainControl.jstree(true);
    mainControl.on("changed.jstree", function () {
        // var vLabel = $("[mainControlId="+_schema.id + "]");
        // vLabel.text(vtree.get_selected().length + " Selected");
        buttonlabel.text(vtree.get_selected().length + " Selected");
        _this.instance.fn_search();
    });

    $(document).bind('mousedown.' + this._namespaceID, function (e) {
        var display = mainControl.css("display");

        if (display != "none" && e.target != mainControl[0] && !$.contains(mainControl[0], e.target) && !$.contains(button[0], e.target) && e.target !== button[0]) {
            mainControl.hide();
        }
    });
}

// 미완성.
makeHtmlBySchema.prototype.input = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    /**
    Start Logic
    */

    var mainControl = $(document.createElement("input"));
    mainControl.attr("type","text");
    // mainControl.addClass("btn btn-warning btn-sm");
    mainControl.text(_schema.label);
    container.append(mainControl);

    if(_this.schema.containerType == "search"){
        mainControl.addClass("btn-block");
    }
            
    if ( _this.schema.containerType == "search" && _schema.name == "btnSearch" ){
        mainControl.on("click",function(){
            _this.instance.fn_search();
        });
    }

    /***
    End Logic    
    */


    // return container;
    
}

makeHtmlBySchema.prototype.Button = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    /**
    Start Logic
    */

    var mainControl = $(document.createElement("button"));
    mainControl.attr("type","button");
    mainControl.addClass("btn btn-warning btn-sm");
    mainControl.text(_schema.label);
    container.append(mainControl);

    if(_this.schema.containerType == "search"){
        mainControl.addClass("btn-block");
    }
            
    if ( _this.schema.containerType == "search" && _schema.name == "btnSearch" ){
        mainControl.on("click",function(){
            _this.instance.fn_search();
        });
    }

    /***
    End Logic    
    */


    // return container;
    
}

makeHtmlBySchema.prototype.ButtonBootstrap = function(_schema ,_schema_parent ,container , container_parent){
    this.Button(_schema ,_schema_parent , container , container_parent);
    
}

makeHtmlBySchema.prototype.radioButton = function(_schema ,_schema_parent ,container, container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    /**
    Start Logic
    */

    var vData = _schema.data();
    $.each(vData,function(i,data){
        var vDiv = $("<div/>",{class : "form-check form-check-inline"});
        container.append(vDiv);
        // input
        var vInput = $("<input/>",{
            class: "form-check-input", 
            type: "radio", 
            value : this[_schema.options.cd] ,
            name : _schema.id ,
            id : _schema.id + "_" + i
        });
        vDiv.append(vInput);
        // label
        var label = $("<label/>",{
            class : "form-check-label", 
            value : this[_schema.options.name]
        });
        container.append(label);
    });
    /***
    End Logic    
    */

    // return container;
    
}



makeHtmlBySchema.prototype.dateInput = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    /**
    Start Logic
    */

    var template = `
        <div class="input-group">
            <span class="input-group-addon"><i class="icon ion-calendar tx-16 lh-0 op-6"></i></span>
            <input type="text" class="form-control fc-datepicker" placeholder="YYYY/MM/DD">
        </div>
    `;
    
    var subContainer = $(template);
    subContainer.find("input").attr("id", _schema.id);
    subContainer.find("input").attr("name", _schema.id);
    
    container.append(subContainer);
    $("#" + _schema.id ).datepicker({
        dateFormat: "yy-mm-dd" ,
        showOtherMonths: true ,
        selectOtherMonths: true
    });

    /***
    End Logic    
    */

    // return container;
    
}


makeHtmlBySchema.prototype.title = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    /**
    Start Logic
    */

    var template = `
        <div><h6 class="tx-gray-800 tx-uppercase tx-bold tx-14 mg-b-10"></h6></div>
    `;
    
    var subContainer = $(template);
    subContainer.find("h6").text(_schema.label);
    container.append(subContainer);

    /***
    End Logic    
    */

    // return container;
    
}

makeHtmlBySchema.prototype.emptyDiv = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    /**
    Start Logic
    */
    
    /***
    End Logic    
    */

    // return container;
    
}

makeHtmlBySchema.prototype.tab_list = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    // var container = $("<div/>",{});
    // _this.defaultSetting(_schema, container);

    /**
    Start Logic
    */

    // tab list
    var template = `
        <ul class="nav nav-pills mb-3" id="` + _schema.id + `Ul" role="tablist"></ul>
    `;
    
    var mainControl = $(template);
    mainControl.attr("href","");
    container.append(mainControl);

    // tab content
    var template1 = `
        <ul class="tab-content" id="` + _schema.id + `TabContent"></ul>
    `;
    
    var maincontrol1 = $(template1);
    container.append(maincontrol1);

    

    /***
    End Logic    
    */

    // return container;
    
}

makeHtmlBySchema.prototype.tab_item = function(_schema ,_schema_parent , container , container_parent){
    var _this = this;

    /**
    Start Logic
    */

    var v_tab_group = _schema.parentContainer.find("ul[role=tablist]");
    var v_content_group = _schema.parentContainer.find("ul.tab-content");

    // tab
    var template = `
        <li class="nav-item">
            <a class="nav-link" id="" data-toggle="pill" href="" role="tab" aria-controls="">Home</a>
        </li>
    `;
    var tab_id = _schema.id + '-tab';
    var content_id = _schema.id + 'Content';
    var $template = $(template);
    container = $template;
    if(v_tab_group.children().length > 0){
        container.addClass("active");
    }
    
    var tab_control = $template.find("a");
    tab_control.attr("origin_id", _schema.id );
    tab_control.attr("id", tab_id );
    tab_control.attr("href", "#" + content_id );
    tab_control.attr("aria-controls", content_id );
    tab_control.text(_schema.label);
    
    $.each(_schema.connected_content, function(key,val){
        tab_control.attr(key,val);
    });
    
    v_tab_group.append($template);
    
    // content
    var template1 = `
    <div class="tab-pane fade" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab">...</div>
    `;
    
    var tab_content = $(template1);
    if(v_content_group.children().length > 0){
        tab_content.addClass("show active");
    }

    tab_content.attr("origin_id", _schema.id );
    tab_content.attr("id", content_id );
    tab_content.attr("aria-labelledby", tab_id );

    
    v_content_group.append(tab_content);
    

    container.append(maincontrol);
    

    /***
    End Logic    
    */

   
    
}



