function makeHtmlBySchema( _container , _schema , _instance ){
    this.container = _container; 
    this.schema = _schema;
    this.instance = _instance ;
    this.process_type( _schema , null , _container );
}

makeHtmlBySchema.prototype.process_type = function(  _schema , _schema_parent , container_parent ){
    var _this = this;
    var container = eval("_this." + _schema.type + "( _schema , _schema_parent , container_parent)");

    if(_schema.elements != null){
        $.each( _schema.elements , function( i , el){
            _this.process_type( el , _schema ,  container  );
        });
    }
    
}


makeHtmlBySchema.prototype.defaultSetting = function( _container ){
    var _this = this;
    if( _schema.id != null){
        _container.attr("id", _schema.id + "Container");
    }
}

makeHtmlBySchema.prototype.Vertical = function( _schema , _schema_parent , container_parent ){
    var _this = this;
    var container = $("<div/>",{});
    _this.defaultSetting(container);
    container_parent.append(container);    
    return container;
}

makeHtmlBySchema.prototype.HorizontalLayout = function( _schema , _schema_parent , container_parent){
    var _this = this;
    var container = $("<div/>",{ style: "display: inline-block "});
    _this.defaultSetting(container);
    if(_schema.width != undefined){
        container.css("width",_schema.width);
    }
    return container;
}

makeHtmlBySchema.prototype.inline = function(_schema ,_schema_parent , container_parent){
    var _this = this;

    var container = $("<div/>",{});
    _this.defaultSetting(container);

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

    return container;
    
}

makeHtmlBySchema.prototype.inline_edit = function(_schema ,_schema_parent , container_parent){
    var _this = this;

    var container = $("<div/>",{});
    _this.defaultSetting(container);

    var cols = 1;
    if(_schema.cols != undefined)
        cols = _schema.cols;

    /**
     * btnGroup
     */
    var btnGroup = $("<div/>",{
        class: "btn_group",
        style : "margin-bottom: 3px; width: 100% "
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
        style : "width: 100px "
    });
    btnGroup.append(btnConfirm);
    if(_schema.options != undefined && 
        _schema.options.button_option != undefined &&
        _schema.options.button_option.btn_class != null){
            btnConfirm.addClass(_schema.options.button_option.btn_class);	
    }else{
            btnConfirm.addClass("btn btn-default");
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

        var width = (12 - _itemGroup.cols*2)  / _itemGroup.cols;
        var col_width = "col-sm-" + width;
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
                rowDiv = $("<div/>",{class: "form-group row"});
                container.append(rowDiv);
            }
            // header
            var labelH = $("<label/>",{class: "col-sm-2 col-form-label input-group-text text-right"});
            labelH.text(item.label);
            

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
                    label : item.label
                };

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

                var reacttd = window.fn_td( inputDiv, tdOption );
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


    

    return container;
    
}

/**
특이한 경우에만 사용한다. Iframe 을 어쩔 수 없이 써야만 하는 경우에만.
*/
makeHtmlBySchema.prototype.inline_iframe = function(_schema ,_schema_parent , container_parent){
    var _this = this;

    var container = $("<div/>",{});
    _this.defaultSetting(container);

    return container;
    
}

makeHtmlBySchema.prototype.grid = function(_schema ,_schema_parent , container_parent){
    var _this = this;

    var container = $("<div/>",{});
    _this.defaultSetting(container);

    //==grid create    
    container.attr("id",_schema.id + 'Container');
    
    var containerType = container.attr("type");
    if(_schema.parentSchema.type == 'HorizontalLayout'){
        container.css("display","inline-block");
        if(container.children().length > 0)
            container.css("margin-left","10px");
    }
        
    //==table create
    var mainControl = $(document.createElement( "table" ));
    mainControl.attr("id",_schema.id);
    //table.css("width","100%");
    container.append(mainControl);
    
    //== page create
    var pager = $(document.createElement( "div" ));
    pager.attr("id",_schema.id + 'Pager');
    container.append(pager);
    
    // refereced Items
    $.each(_schema.items , function(i, item){
        var dictionary = null;
        var dicCodes = [];
        if(typeof(dictionaries) != 'undefined' ){
            dictionary = _.find(dictionaries,{entityName: item.entityName  });
            if (dictionary != null)
                dicCodes = _.filter(dictionary.value, {"TABLE_NAME":item.entityName.toUpperCase(),"COLUMN_NAME": item.name});
        }
        if(dicCodes.length > 0){
            item.edittype = "select";
            if(item.formatter == null)
                item.formatter = "select"
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
            

        }else if(item.referenceId != undefined && dataSrc != undefined && !_.includes(['pop_select'], item.data_src_type)){
            var src = _.find(dataSrc, {"referenceId": item.referenceId, "topRefrenceId" : item.topRefrenceId , "childColumnName": item.name.toLowerCase()  });
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

    return container;
}


makeHtmlBySchema.prototype.SearchHeader = function(_schema ,_schema_parent , container_parent){
    var _this = this;

    var container = $("<div/>",{});
    _this.defaultSetting(container);

    if(_schema.parentSchema.type == 'HorizontalLayout'){
        container_parent.css("display","inline-block");
        if(_schema.width != undefined)
            container.css("width",_schema.width);
        if(container.children().length > 0)
            container.css("margin-left","1px");
    }
        
    var mainControl = $(document.createElement("h3"));
    //h3.addClass("cont_tit");
    container.append(mainControl);
    mainControl.text(_schema.text);
    mainControl.css("font-weight","bold");
    mainControl.css("text-align","right");
    mainControl.css("color","#000");
    

    return container;
}

makeHtmlBySchema.prototype.multiCombo = function(_schema ,_schema_parent , container_parent){
    var _this = this;

    var container = $("<div/>",{});
    _this.defaultSetting(container);

    if(_schema.parentSchema.type == 'HorizontalLayout'){
        container.css("display","inline-block");
        if(_schema.width != undefined)
            container.css("width",_schema.width);
        if(container.children().length > 0)
            container.css("margin-left","10px");
    }
    
    var vData = _schema.data();
    var sb = [];
    //sb.push("<option value='' multiple='multiple' ></option>");
    mainControl = $(document.createElement( "select" ));
    mainControl.css("width",_schema.width);
    if(_schema.multiselectOpt != undefined && _schema.multiselectOpt.multiple != undefined && _schema.multiselectOpt.multiple == true )
        mainControl.attr("multiple","multiple");
    if(_schema.name != undefined)
        mainControl.attr("name",_schema.name);
    if(_schema.id != undefined)
        mainControl.attr("id",_schema.id);
    container.append(mainControl);
    
    /* var option1 = $(document.createElement( "option" ));
    option1.val('xxx');
    option1.text('xxx');
    option1.css("display","none");
    mainControl.append(option1); */
    
    if(_schema.options.group != undefined){
        var groupKeys = [_schema.options.group.cd, _schema.options.group.name];
        var series = getDrillDownDataSeries2(
                '',
                vData ,
                groupKeys ,
                [], //filter
                [], //convert
                '', //xAxis
                '',
                {cd: _schema.options.group.cd, name: _schema.options.group.name},
                {isGroupby: false}
        );
        var selected ="selected";
        var sb = [];
        sortObjects(series.series,['name']);
        $.each(series.series,function(index,s){
            var optGrp = $(document.createElement( "optgroup" ));
            optGrp.attr("label",s.name);
            optGrp.attr("cd",s.cd);
            mainControl.append(optGrp);
            $.each(s.data,function(index1,d){
                var option = $(document.createElement( "option" ));
                option.val(this[_schema.options.cd]);
                option.text(this[_schema.options.name]);
                //모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
                $.each(this,function(k,v){
                    option.attr(k.toLowerCase(),v);
                });
                optGrp.append(option);
            });
        });
        
    }
    else {
        $.each(vData,function(){
            var option = $(document.createElement( "option" ));
            option.val(this[_schema.options.cd]);
            option.text(this[_schema.options.name]);
            var _this = this;
            //모든 쿼리필드를 attr 등록 하여 jquery에서 사용할 수 있도록 한다.
            
            $.each(this,function(k,v){
                try{
                    option.attr(k.toLowerCase(),v);
                }catch(e){
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
        height:300,
        minWidth: 100,
        //selectedText: _schema.text + ' # selected',
        selectedText: function(numChecked, numTotal, checkedItems){
             return numChecked + ' of ' + numTotal + ' checked';
        },
        noneSelectedText: 'Select ' + _schema.text
        
    };
    if(_schema.multiselectOpt != undefined)
        $.extend(multiselectOpt, _schema.multiselectOpt);
    var vMultiSelect = mainControl.multiselect(multiselectOpt).multiselectfilter();
    mainControl.multiselect('widget').css("width","400px");
    mainControl.multiselect('widget').find(".ui-multiselect-filter input").css("width","150px");
    // mainControl.multiselectOption = multiselectOpt;
    
    //filter by parent
    if(_schema.options.childrens != undefined){
        $.each(_schema.options.childrens, function(i,child){
            var childSchema = findAll(child.id, eval(child.topElement) )[0];
            if(childSchema != undefined){						
                mainControl.on( 'change', function(){
                    
                    $("select[name="+_schema.name+"] option").each(function(i,sel){
                        if($(this).is(':selected')){
                            $("select[name="+ child.id+"] option["+_schema.options.cd+"='"+$(this).val()+"']").prop( "disabled", false );
                            //$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", true );
                            $("select[name="+ child.id+"] option["+_schema.options.cd+"='"+$(this).val()+"']").prop( "selected", true );
                        }else{
                            $("select[name="+ child.id+"] option["+_schema.options.cd+"='"+$(this).val()+"']").prop( "disabled", true );
                            //$("input[name=multiselect_pjtCodeList],[value="+$(this).val()+"]").prop( "disabled", false );
                            $("select[name="+ child.id+"] option["+_schema.options.cd+"='"+$(this).val()+"']").prop( "selected", false );
                        }
                    });
                    
                    $("select[name="+ child.id+"] option").each(function(i,project){			
                        $("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").prop( "disabled", $(this).prop("disabled") );
                        if($(this).prop("disabled")){
                            $("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").parent().addClass( "ui-state-disabled" );
                            $("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").attr("checked",false);
                            
                        }else{
                            $("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").parent().removeClass( "ui-state-disabled" );
                            $("input[name=multiselect_"+ child.id+"][value='"+$(this).val()+"']").attr("checked",true);
                        }
                        
                    });
                    
                    
                    //$("input[name=multiselect_"+ child.id+"]").each(function(){
                    //	$("select[name="+ child.id+"] option[value='"+$(this).val()+"']").prop( "selected", $(this).is(":checked") );
                    //});
                    
                    var childMultiselectOpt = {
                        //selectedList: 1,
                        height:300,
                        minWidth: 100,
                        //selectedText: _schema.text + ' # selected',
                        selectedText: function(numChecked, numTotal, checkedItems){
                             return numChecked + ' of ' + numTotal + ' checked';
                        },
                        noneSelectedText: 'Select ' + childSchema.text
                        
                    };
                    if(childSchema.multiselectOpt != undefined)
                        $.extend(childMultiselectOpt, childSchema.multiselectOpt);
                    
                    
                    $("select[name="+ child.id+"]").multiselect(childMultiselectOpt).multiselectfilter();
                    //$("select[name="+ child.id+"]").multiselect(childSchema.multiselectOpt).multiselectfilter();
                    
                    // 해당하는 Object 만 refresh 한다.
                    var my = $("select[name="+ child.id+"]");
                    //my.multiselect('refresh');
                    $menu = $.data(my[0],"ech-multiselect").menu;
                    $menu.css("width","400px");
                    $menu.find(".ui-multiselect-filter input").css("width","150px");
                    
                    //$("div.ui-multiselect-menu").css("width","400px");
                    //$(".ui-multiselect-filter input").css("width","150px");
                    
                    var obj_child = $("#"+childSchema.id);
                    obj_child.trigger("change");
                });
                
                
            }
            
        } );
        
    }
    

    return container;
}