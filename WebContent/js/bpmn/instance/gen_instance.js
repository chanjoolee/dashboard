function genInstance(_entityId, _type,  _list_instance ){
    this.entityId = _entityId;
    this.type = _type;
    this.list_instance = _list_instance;
    this.jpaFile = _.find( this._list_instance.jpaFile , { entityId : this.entityId, editType: this.type });
    this.containerId = "div_" + this.entityId + "_"+ this.type ; 
    this.searchContainerId = this.containerId + "_search";
    this.gridCotainerId = this.containerId + "_grid";
    this.container = $("<div/>",{id: containerId });
    this.list_instance.container.append(this.container);
    this.searchContainer = null;
    this.gridCContainer = null;
    
    
    // 어떤식으로 입력을 할 것인가?  
    // div에 소스를 생성하는 방식으로?
    // ==> 이것은 커스터마이징을 할 수 있도록 한다. 
    // schema를 바탕으로 자동으로 생성을 한다?
    // ==> 일단은 이것으로 한다.
    // 이것을 완성 한 다음 div 에 소스를 generating 하는 방식으로 한다.

    // containert 안에 그린다.
    // 01. search
    this.makeSearch();
    // 02. grid
    this.makeGrid();

}

genInstance.prototype.makeSearch = function(){
    var _this = this;
    var searchContainer = $("<div/>",{id: this.searchContainerId});
    this.container.append(searchContainer);
    var schema = this.jpaFile.schema.search.schema ;
    var makehtml = new makeHtmlBySchema( this.searchContainer , schema , this );
}

genInstance.prototype.makeGrid = function(){
    var _this = this;
    var searchContainer = $("<div/>",{id: this.searchContainerId});
    this.container.append(searchContainer);
    var schema = this.jpaFile.schema.contents.schema ;
    var makehtml = new makeHtmlBySchema( this.searchContainer , schema , this );
}


genInstance.prototype.fn_makeHtml = function( container , _schema ){
    var _this = this;
    var containerSub = null;
    if(container == null)
        container = _schema.containerId;
    if(typeof container == 'string')
        container = $("#" + container);
    
    if(_schema.parentSchema != undefined && _schema.parentSchema.cls != undefined)
        container.addClass(_schema.parentSchema.cls);
    if(_schema.parentSchema != undefined &&  _schema.parentSchema.containerCss != undefined){
        $.each(_schema.parentSchema.containerCss,function(i,v){
            container.css(v.code,v.value);
        });
    }
        
    var mainContainer = null;
    var mainControl = null;
    if(_schema.type == 'inline'){
        var cols = 3;
        if(_schema.cols != undefined)
            cols = _schema.cols;
        
        //tableCreate
        mainContainer = $(document.createElement("table"));
        //table.addClass("table_hori m_bottom_20");
        mainContainer.addClass("table_hori");
        container.append(mainContainer);
        
        // colgroup
        var colgroup = $(document.createElement("colgroup"));
        mainContainer.append(colgroup);
        
        for(var i=0; i< cols;i++){
            if(i == (cols - 1) ){
                colgroup.append("<col width=\"150\"/><col width=\"\"/>");
            }else{
                colgroup.append("<col width=\"150\"/><col width=\"180\"/>");
            }
        }
        // -- colgroup
        
        // tbody
        var tbody = $(document.createElement("tbody"));
        mainContainer.append(tbody); 
        var tr = null;
        $.each(_schema.items,function(i,item){
            if(i%cols == 0 ){
                tr =$(document.createElement("tr"));
                tbody.append(tr);
            }
            //header
            var th = $(document.createElement("th"));
            th.addClass("txt_right");
            th.text(item.label);
            //td value
            var td = $(document.createElement("td"));
            td.addClass("hori_t_data");
            td.text(_schema.data()[item.col]);
            
            tr.append(th);
            tr.append(td);
            
        });
        // --tbody
    }else if(_schema.type == 'inline_iframe'){
        var cols = 2;
        if(_schema.cols != undefined)
            cols = _schema.cols;
        
        //tableCreate
        mainContainer = $(document.createElement("table"));
        //table.addClass("table_hori m_bottom_20");
        mainContainer.addClass("table_hori");
        container.append(mainContainer);
        
        // colgroup
        var colgroup = $(document.createElement("colgroup"));
        mainContainer.append(colgroup);
        
        for(var i=0; i< cols;i++){
            colgroup.append("<col width=\"150\"/>");
        }
        // -- colgroup
        
        // tbody
        var tbody = $(document.createElement("tbody"));
        mainContainer.append(tbody); 
        var tr = null;
        $.each(_schema.items,function(i,item){
            if(i%cols == 0 ){
                tr =$(document.createElement("tr"));
                tbody.append(tr);
            }
            //header	
            //td value
            var td = $(document.createElement("td"));
            td.addClass("hori_t_data");
            //td.text(_schema.data()[item.col]);
            tr.append(td);
            td.css("border","0px");
            
            
            
            var tabContainer = $(document.createElement( "div" ));
            tabContainer.attr("id",_schema.id + item.name +  'TabContainer' )
            tabContainer.addClass("tit_btn");
            tabContainer.addClass("m_top_10");		
            tabContainer.css("display","inline-block");
            td.append(tabContainer);
            
            $ul = $(document.createElement( "ul" )); 
            $ul.attr("id",_schema.id +  item.name +  'Ul');
            $ul.addClass("tab_2depth");
            tabContainer.append($ul);
            
            var $li = $(document.createElement( "li" ));
            $li.attr("id", _schema.id +  item.name +  'Tab' );
            $li.addClass("on")
            $ul.append($li);
            
            
            var $a = $(document.createElement( "a" ));
            $a.attr("id", _schema.id + '_a' );
            $a.attr("origin_id", _schema.id );
            $a.text(item.label);
            $li.append($a);		
        
            v_content = $(document.createElement( "div" ));
            td.append(v_content);
            v_content.attr("id", _schema.id + item.name +  'Content');
            v_content.css("height",_schema.height);
            //v_content.css("margin-top","10px");
            //v_content.css("padding","0 10px 0 10px");
            v_content.css("width","100%");
            
            //iframe
            var v_frame = $(document.createElement( "iframe" ));
            v_frame.attr("id", _schema.id + '_'+ item.name +'Frame');
            v_frame.attr("name",  _schema.id + '_'+ item.name +'Frame');
            v_frame.css("width","100%");
            v_frame.css("height","100%");
            
            if(_schema.iframe_css != null){
                $.each(_schema.iframe_css,function(i,v){
                    v_frame.css(v.code,v.value);
                });
            }
            v_content.append(v_frame);
            var viewName = item.viewName;
            var form_id = _schema.form_id;
            
            var vform =  document.getElementById(form_id);
            vform.action = './generic.html?viewName='+viewName;
            vform.method = "post";
            vform.target = _schema.id + '_'+ item.name +'Frame';
            //vform.target = v_content[0];
            if(item.data != undefined)				{
                $.each(item.data,function(k,v){
                    $("#"+k).val(v);
                })
            }
            
            vform.submit();
            
        });
        // --tbody
    }else if(_schema.type == 'inline_edit'){
        var cols = 1;
        if(_schema.cols != undefined)
            cols = _schema.cols;
        
        
        var btnGroup = $(document.createElement("div"));
        btnGroup.addClass("btn-group");	
        btnGroup.css("margin-bottom","3px");
        btnGroup.css("width","100%");
        container.append(btnGroup);
        var edit_mode = "read";
        if ( _schema.edit_type == "view"){
            edit_mode = "read";
            btnGroup.hide();
        }else{
            edit_mode = "edit";
        }
        
        if(false){
            // create button edit
            var btnEdit = $(document.createElement("button"));
            btnEdit.attr("type","button");
            btnEdit.addClass("btn btn-default");	
            btnEdit.css("width","100px");
            btnEdit.text("Edit");
            btnEdit.hide();
            btnGroup.append(btnEdit);
        }
        
        // button confirm
        var btnConfirm = $(document.createElement("button"));
        btnConfirm.attr("type","button");				
        btnConfirm.css("width","100px");

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
        if (false){
            // button cancel
            var btnCancel = $(document.createElement("button"));
            btnCancel.attr("type","button");
            btnCancel.addClass("btn btn-default");	
            btnCancel.css("width","100px");
            btnCancel.text("Cancel");
            btnCancel.hide();
            btnGroup.append(btnCancel);
        }
        
        // //tableCreate
        // var mainContainerDiv =  $(document.createElement("div"));
        // // mainContainerDiv.addClass("table-responsive");
        // container.append(mainContainerDiv);
        // mainContainer = $(document.createElement("table"));
        // //table.addClass("table_hori m_bottom_20");
        // mainContainer.addClass("table");
        // mainContainerDiv.append(mainContainer);
        
        // PMS Style
        var reactObjects = [];
        mainContainer = $(document.createElement("div"));
        container.append(mainContainer);
        var fn_make_group_label = function(_itemGroup){
            mainContainer.append('<br/>');
            var h3 = $(document.createElement("h3"));
            h3.addClass("cont_tit");
            h3.text(_itemGroup.option.group_label);
            mainContainer.append(h3);
            
        };
        var fn_make_table = function(_itemGroup){				
            var minCols = Math.min(_itemGroup.items.length,cols);
            if(_itemGroup.option != null && _itemGroup.option.group_label != null){
                if (_itemGroup.option.cols != null)
                    minCols = _itemGroup.option.cols;
                fn_make_group_label(_itemGroup);					
            }

            // PMS Style
            var v_table = $(document.createElement("table"));
            if (_itemGroup.display == 'none')
                v_table.hide();
            //table.addClass("table_hori m_bottom_20");
            v_table.addClass("table_hori");
            mainContainer.append(v_table);
            
            // colgroup
            var colgroup = $(document.createElement("colgroup"));
            v_table.append(colgroup);
            
            
            for(var i=0; i< minCols;i++){
                if(minCols == 1 ){
                    colgroup.append("<col width=\"150\"/><col width=\"\"/>");
                }
                else if(i == (minCols - 1) ){
                    colgroup.append("<col width=\"100\"/><col width=\"200\"/>");
                }else{
                    colgroup.append("<col width=\"100\"/><col width=\"200\"/>");
                }
            }
            // -- colgroup
            
            // tbody
            var tbody = $(document.createElement("tbody"));
            v_table.append(tbody); 
            var tr = null;
            var data = _schema.data();		
            
            var j=0; // for line feed 
            $.each(_itemGroup.items,function(i,item){
                
                if (item.line_feed != null && item.line_feed){
                    j = j + Math.abs( j - minCols );
                    return true;
                }
                if(data[item.col] == undefined) {
                    data[item.col] = "";
                }
                if(j%minCols == 0 ){
                    tr =$(document.createElement("tr"));
                    tbody.append(tr);
                }
                
                
                //header
                var th = $(document.createElement("th"));
                th.addClass("txt_right");
                if (item.required)
                    th.addClass("required");

                th.text(item.label);
                //td value
                var td = $(document.createElement("td"));
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
                
                var reacttd = window.fn_td(td[0], tdOption );
                if (tdOption.isDateTime){
                    var dateEm = $(td).find("input");
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
                //td.addClass("hori_t_data");
                //td.text(_schema.data()[item.col]);				
                
                // reactDom 으로 부터 특정 component 를 찾을 수 없으므로 
                reacttd.reactObjects = reactObjects;
                reactObjects.push(reacttd);		
                if( item.edit_tag != undefined )	{
                    if(item.edit_tag == "pop_select"){
                    } else if(item.edit_tag == "manual_attach"){
                    } else {
                        tr.append(th);
                    }
                }else {
                    tr.append(th);
                }
                
                tr.append(td);
                

                j++;
                
            });
        };

        // var itemGroups = [[]];
        var itemGroups = [{items:[]}];
        var groupCols = null;
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

        // hidden items


        if (false){
            // PMS Style
            mainContainer = $(document.createElement("table"));
            //table.addClass("table_hori m_bottom_20");
            mainContainer.addClass("table_hori");
            container.append(mainContainer);
            
            // colgroup
            var colgroup = $(document.createElement("colgroup"));
            mainContainer.append(colgroup);
            
            for(var i=0; i< cols;i++){
                if(cols == 1 ){
                    colgroup.append("<col width=\"150\"/><col width=\"\"/>");
                }
                else if(i == (cols - 1) ){
                    colgroup.append("<col width=\"100\"/><col width=\"200\"/>");
                }else{
                    colgroup.append("<col width=\"100\"/><col width=\"200\"/>");
                }
            }
            // -- colgroup
            
            // tbody
            var tbody = $(document.createElement("tbody"));
            mainContainer.append(tbody); 
            var tr = null;
            var data = _schema.data();
            
            var reactObjects = [];
            
            
            var j=0; // for line feed 
            $.each(_schema.items,function(i,item){
                if (item.line_feed != null && item.line_feed){
                    j = j + Math.abs( j - cols );
                    return true;
                }
                if(data[item.col] == undefined) {
                    data[item.col] = "";
                }
                if(j%cols == 0 ){
                    tr =$(document.createElement("tr"));
                    tbody.append(tr);
                }
                //header
                var th = $(document.createElement("th"));
                th.addClass("txt_right");
                th.text(item.label);
                //td value
                var td = $(document.createElement("td"));
                var tdOption = {
                    name: item.col,
                    //keys: _schema.keys,
                    value: data[item.col],
                    value_origin: data[item.col],
                    editable : item.editable != undefined ? item.editable : true,
                    isDateTime : item.isDateTime != undefined ? item.isDateTime : false,
                    mode: edit_mode
                };

                
                
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
                        }
                        else {
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
                
                var reacttd = window.fn_td(td[0], tdOption );
                if (tdOption.isDateTime){
                    var dateEm = $(td).find("input");
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
                //td.addClass("hori_t_data");
                //td.text(_schema.data()[item.col]);				
                
                // reactDom 으로 부터 특정 component 를 찾을 수 없으므로 
                reacttd.reactObjects = reactObjects;
                reactObjects.push(reacttd);
                tr.append(th);
                tr.append(td);

                j++;
                
            });
        }

        if(false){
            btnEdit.click(function(){
                var a = "a";
                $.each(reactObjects,function(i,item){
                    if(item.props.options.editable){
                        item.setState({mode:"edit"});
                        if(item.props.options.isDateTime){
                            var dateEm = $("[data-reactid='" +item._reactInternalInstance._rootNodeID + "']").find("input");
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
                            
                    }
                });
                btnEdit.hide();
                btnConfirm.show();
                btnCancel.show();
            });
            btnCancel.click(function(){
                var a = "a";
                $.each(reactObjects,function(i,item){
                    this.setState({mode: "read"});
                });
                btnConfirm.hide();
                btnCancel.hide();
                btnEdit.show();
            });
        }

        btnConfirm.click(function(){
            var a = "a";
            var state = true;
            $.each(reactObjects,function(i,item){
                if (this.state.required && (this.state.value == "" || this.state.value == null)  ){
                    state = false;
                    var v_msg = "Please input " + this.state.label;
                    $("#dialog-confirm").html(v_msg);
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
            });
            if(!state)
                return;
            // loader
            if(_schema.options != undefined && _schema.options.progressObject != undefined)
                _schema.options.progressObject.show();
            setTimeout(function(){
                
                if( _schema.edit_type == "edit"){
                    var keyUpdatedObjects = [];
                    // key 가 아닌것을 먼저 update
                    $.each(reactObjects,function(i,item){
                        var isKeyUpdate = false;
                        if(this.state.value_origin != this.state.value){
                            var vObject = this;
                            $.each(this.state.keys, function(){
                                if(this.field == vObject.state.name){
                                    this.value = vObject.state.value_origin;
                                    isKeyUpdate = true;
                                }
                                    
                            });
                            if(!isKeyUpdate){
                                state = item.props.options.fn_submit.call(this,"edit");
                                this.setState({value_origin: this.state.value});
                            }							
                        }
                            
                        if(!state)
                            return false;
                        // this.setState({mode: "read"});
                        if(isKeyUpdate){
                            keyUpdatedObjects.push(item);
                        }
                    });
                    
                    // key 는 나중에 업데이트 한다. 만약 키다 두개이상인 경우는 cover가 안됨
                    $.each(keyUpdatedObjects,function(i,item){
                        state = item.props.options.fn_submit.call(this,"edit");
                        this.setState({value_origin: this.state.value});
                            
                        if(!state)
                            return false;
                        // this.setState({mode: "read"});
                        
                    });
                    if(state){
                        // btnConfirm.hide();
                        // btnCancel.hide();
                        // btnEdit.show();
                        if(_schema.options != undefined && _schema.options.fn_afterSubmit != undefined)
                            _schema.options.fn_afterSubmit.call(reactObjects,keyUpdatedObjects);
                    }
                }else if (_schema.edit_type == "add"){
                    state = _schema.options.fn_submit.call(reactObjects,"add");
                    
                }else if (_schema.edit_type == "copy"){
                    state = _schema.options.fn_submit.call(reactObjects,"copy");
                }

                
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

        if(_schema.options != undefined && 
            _schema.options.button_option != undefined &&
            _schema.options.button_option.location != null){
                var button_group = $(".btn-group");	
                var location = _schema.options.button_option.location;
                if (location == "bottom-right"){
                    container.append(btnGroup);
                    // btnGroup.css("margin-right","20px");
                    btnGroup.css("margin-top","3px");
                    btnConfirm.css("float","right");
                    container.css("margin-top","0px");
                }else if (location == "bottom-left"){

                }
        }
        

        
    }else if(_schema.type == 'grid'){
        //==grid create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(container.children().length > 0)
                mainContainer.css("margin-left","10px");
        }
            
        container.append(mainContainer);
        //mainContainer.css("width","100%");
        //grid.addClass("chartContainerSub");
        
        
        //==table create
        mainControl = $(document.createElement( "table" ));
        mainControl.attr("id",_schema.id);
        //table.css("width","100%");
        mainContainer.append(mainControl);
        
        //== page create
        var pager = $(document.createElement( "div" ));
        pager.attr("id",_schema.id + 'Pager');
        mainContainer.append(pager);
        
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
            mainContainer.find(".ui-jqgrid").css("width","100%");
            mainContainer.find(".ui-jqgrid-view").css("width","100%");
            mainContainer.find(".ui-jqgrid-hdiv").css("width","100%");
            mainContainer.find(".ui-jqgrid-bdiv").css("width","100%");
            mainContainer.find(".ui-jqgrid-sdiv").css("width","100%");
            mainContainer.find(".ui-jqgrid-pager").css("width","100%");
        }
        
        
    }else if(_schema.type == 'chart'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(container.children().length > 0)
                mainContainer.css("margin-left","10px");
        }
        if(_schema.width != undefined)
            mainContainer.css("width",_schema.width);
            
        if(_schema.label != ""){
            var h3 = $(document.createElement("h3"));
            h3.addClass("cont_tit");
            h3.text(_schema.label);
            container.append(h3);
        }
        
        container.append(mainContainer);
        
        
        if($(mainContainer).highcharts() != undefined) $(mainContainer).highcharts().destroy();
        var defaultOption =  {
                credits: {//gets rid of the highcharts logo in bottom right
                    enabled: false
                }
        };
        var series = {};
        var options = $.extend( defaultOption, _schema.options());
        if(_schema.data != undefined && typeof _schema.data == 'function'){
            var vData = _schema.data();
            series = vData.series;
            options.series = vData.series.series;
            if(vData.xAxis != undefined)
                options.xAxis = vData.xAxis;
            if(vData.yAxis != undefined)
                options.yAxis = vData.yAxis;
        }
        // var chartUser = Highcharts.stockChart($(mainContainer).attr('id') ,options,function(chart){
            
        // });
        
        
        
        if(options.stockchart != undefined && options.stockchart){
            $(mainContainer).highcharts('StockChart',options,function(chart){
                if(options.complete != undefined && typeof options.complete == 'function' ){
                    options.complete.call(chart);
                }
            });
        }else{
            $(mainContainer).highcharts(options,function(chart){
                if(options.complete != undefined && typeof options.complete == 'function' ){
                    options.complete.call(chart);
                }
            });
        }
        
            
        //var chart = mainContainer.highcharts();
        //chart.reflow();
        
        // $(mainContainer).highcharts(options,function(chart){
            
        //  });
        
    }else if(_schema.type == 'SearchHeader'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            if(container.children().length > 0)
                mainContainer.css("margin-left","1px");
        }
            
        mainControl = $(document.createElement("h3"));
        //h3.addClass("cont_tit");
        mainContainer.append(mainControl);
        mainControl.text(_schema.text);
        mainControl.css("font-weight","bold");
        mainControl.css("text-align","right");
        mainControl.css("color","#000");
        
        container.append(mainContainer);
    }else if(_schema.type == 'multiCombo'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            if(container.children().length > 0)
                mainContainer.css("margin-left","10px");
        }
        container.append(mainContainer); 
        
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
        mainContainer.append(mainControl);
        
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
        
    }else if(_schema.type == 'jsTreeSearch'){
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');

        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            if(container.children().length > 0)
                mainContainer.css("margin-left","10px");
        }
        if(_schema.width != undefined)
            mainContainer.css("width",_schema.width);
        container.append(mainContainer); 
        var vData = _schema.data();

        mainControl = $(document.createElement( "div" ));
        // mainControl.css("width",_schema.width);
        mainControl.addClass("ui-multiselect-menu ui-widget-content ui-corner-all");
        if(_schema.name != undefined)
            mainControl.attr("name",_schema.name);
        if(_schema.id != undefined)
            mainControl.attr("id",_schema.id);
        mainControl.hide();
        // mainContainer.append(mainControl);
        mainControl.appendTo(document.body);
        var button = $('<button type="button"><span class="ui-icon ui-icon-triangle-2-n-s"></span></button>')
        .addClass('ui-multiselect ui-widget ui-state-default ui-corner-all')
        .addClass("")
        .attr({ 'title':"", 'aria-haspopup':true }) 
        .css({width: "100%"})
        .appendTo(mainContainer);
        
        var buttonlabel = $('<span />')
        .html("Js Tree Search")
        .appendTo(button);
        button.on( "click", function() {
            // mainControl.toggle( 'blind', { to: { width: 200, height: 300 } }, 500 );
            var display = mainControl.css("display");
            var pos = $(this).offset();
            mainControl.css({
                top: pos.top + $(this).outerHeight(),
                left : pos.left
            });
            if (display == "none"){
                mainControl.show();
            }else
                mainControl.hide();
            

        });

        buttonlabel.attr("mainControlId",_schema.id );
        var searchTree = new List2Tree(vData, _schema.keys);
        _.merge(searchTree.tree ,
            {
                checkbox : {
                    // three_state : false,
                    // cascade: 'undetermined',
                    // visible: true,
                    // three_state: false
                    // tie_selection: false
                },
                'plugins': ["checkbox", "state"],
                // 'plugins': ["checkbox", "wholerow"],
                "core": {
                    themes:{
                        'icons':false
                    }
                }
            }
        );
        if(_schema.rootText != null){
            searchTree.tree.core.data[0].text = _schema.rootText;
        }else{
            searchTree.tree.core.data[0].text = _.map( _schema.keys,function(key , i){
                return _.camelCase(key);
            }).join("/");
        }

        mainControl.css("width","400px");
        mainControl.css("max-height","600px");
        mainControl.css("overflow","scroll");
        mainControl.jstree(_.cloneDeep(searchTree.tree));
        var vtree = mainControl.jstree(true);
        mainControl.on("changed.jstree", function(){
            // var vLabel = $("[mainControlId="+_schema.id + "]");
            // vLabel.text(vtree.get_selected().length + " Selected");
            buttonlabel.text(vtree.get_selected().length + " Selected");
        });

        $(document).bind('mousedown.' + this._namespaceID, function(e) {
            var display = mainControl.css("display");

            if(display != "none" && e.target != mainControl[0] && !$.contains(mainControl[0], e.target) && !$.contains(button[0], e.target) && e.target !== button[0]) {
                mainControl.hide();
            }
        });



    }else if(_schema.type == 'Button'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            
        }
        
        mainControl = $(document.createElement("a"));
        mainContainer.append(mainControl);
        
        
        var span = $(document.createElement("span"));
        span.addClass("name");
        var span1 = $(document.createElement("span"));
        span1.addClass("txt");
        span1.text(_schema.label);
        span.append(span1);
        mainControl.append(span);
        
        container.append(mainContainer);
    }else if(_schema.type == 'ButtonBootstrap'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            
        }
        
        mainControl = $(document.createElement("button"));
        mainControl.attr("type","button");
        mainControl.addClass("btn btn-warning btn-sm");
        mainControl.text(_schema.label);
        mainContainer.append(mainControl);
        
        container.append(mainContainer);
    }else if(_schema.type == 'radioButton'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            
        }
        
        mainControl = $(document.createElement("input"));
        mainControl.attr("type","radio");
        mainControl.attr("name",_schema.name);
        mainControl.attr("id",_schema.id);
        
        if(_schema.checked != undefined)
            mainControl.prop("checked",_schema.checked);
        
        mainContainer.append(mainControl);
        
        var label = $(document.createElement("label"));
        label.text(_schema.label);
        mainContainer.append(label);
        
        container.append(mainContainer);
    }else if(_schema.type == 'dateInput'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            
        }
        
        // text
        mainControl = $(document.createElement("input"));
        mainControl.attr("type","text");
        mainControl.attr("name",_schema.name);
        mainControl.attr("id",_schema.id);
        mainControl.attr("readonly", "readonly");
        mainContainer.append(mainControl);			
        
        container.append(mainContainer);
        
    }else if(_schema.type == 'input'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            
        }
        
        // text
        mainControl = $(document.createElement("input"));
        mainControl.attr("type","text");
        mainControl.attr("name",_schema.name);
        mainControl.attr("id",_schema.id);			
        //mainControl.attr("readonly", "readonly");
        mainContainer.append(mainControl);			
        
        container.append(mainContainer);
        
    }else if(_schema.type == 'monthInput'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            
        }
        
        // text
        mainControl = $(document.createElement("input"));
        mainControl.attr("type","text");
        mainControl.attr("name",_schema.name);
        mainControl.attr("id",_schema.id);
        mainControl.attr("readonly", "readonly");
        //mainControl.MonthPicker();
        //mainControl.MonthPicker('option','MonthFormat', 'yymm');
        mainContainer.append(mainControl);			
        
        container.append(mainContainer);
        mainControl.MonthPicker();
        mainControl.MonthPicker('option','MonthFormat', 'yymm');
        $("#MonthPicker_" + _schema.id).css("width","160px");   
        
    }else if(_schema.type == 'dateButton'){
        //==chart container create
        //mainContainer = $(document.createElement( "div" ));
        //mainContainer.attr("id",_schema.id + 'Container');
        if(_schema.parentContainerId != undefined){
            mainContainer = $("#"  + _schema.parentContainerId);
            
            // btn
            mainControl = $(document.createElement("a"));
            mainContainer.append(mainControl);

            var span = $(document.createElement("span"));
            span.addClass("blind");
            
            mainControl.append(span);
        }
        else{
            mainContainer = $(document.createElement( "div" ));	
            
            var containerType = container.attr("type");
            if(_schema.parentSchema.type == 'HorizontalLayout'){
                mainContainer.css("display","inline-block");
                if(_schema.width != undefined)
                    mainContainer.css("width",_schema.width);
            }
            
            // btn
            mainControl = $(document.createElement("a"));
            mainContainer.append(mainControl);

            var span = $(document.createElement("span"));
            span.addClass("blind");
            
            mainControl.append(span);
            container.append(mainContainer);
        }
    
    }else if(_schema.type == 'dateJquery'){
        //==chart container create
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        
        var containerType = container.attr("type");
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            
        }
        
        // text
        mainControl = $(document.createElement("input"));
        mainControl.attr("type","text");
        mainControl.attr("name",_schema.name);
        mainControl.attr("id",_schema.id);
        // mainControl.attr("readonly", "readonly");
        mainContainer.append(mainControl);	
        
        mainControl.datetimepicker({
            timepicker:false,
            datepicker: true ,
            format:'Y-m-d'
        });
        
        container.append(mainContainer);
    }else if(_schema.type == 'title'){
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            if(container.children().length > 0)
                mainContainer.css("margin-left","1px");
        }
        mainControl = $(document.createElement("h3"));
        mainContainer.append(mainControl);
        mainControl.addClass("cont_tit");
        mainControl.text(_schema.label);
        container.append(mainContainer);
    }else if(_schema.type == 'emptyDiv'){
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container');
        if(_schema.parentSchema.type == 'HorizontalLayout'){
            mainContainer.css("display","inline-block");
            if(_schema.width != undefined)
                mainContainer.css("width",_schema.width);
            if(container.children().length > 0)
                mainContainer.css("margin-left","1px");
        }
        
        container.append(mainContainer);
    }else if(_schema.type == 'tab_list'){
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container' )
        mainContainer.addClass("tit_btn");
        mainContainer.addClass("m_top_10");			
        
        mainControl = $(document.createElement( "ul" )); 
        mainControl.attr("id",_schema.id + 'Ul');
        mainControl.addClass("tab_2depth");
        mainContainer.append(mainControl);
        
        container.append(mainContainer);
    }else if(_schema.type == 'tab_iframe'){
        var topContainer = fn_findTopContainer.call(_schema);
        var v_ul = $(_schema.parentContainer).find("ul");
        
        var v_li = $(document.createElement( "li" ));
        v_li.attr("id", _schema.id + 'Tab' );
        v_li.attr("target", _schema.id + 'Content' );
        v_ul.append(v_li);
        
        var mainControl = $(document.createElement( "a" ));
        mainControl.attr("id", _schema.id + '_a' );
        mainControl.attr("origin_id", _schema.id );
        $.each(_schema.connected_content, function(key,val){
            mainControl.attr(key,val);
        });
        mainControl.text(_schema.label);
        v_li.append(mainControl);		
        
        var content_id = _schema.id + 'Content';
        var frame_id = _schema.id + 'Frame';
        var v_content = null;
        var v_frame = null;
        if($("#"+content_id).length > 0 ){
            v_content = $("#"+content_id);
            v_frame = ("#"+frame_id);
        }else {
            //
            v_content = $(document.createElement( "div" ));
            v_content.attr("id", _schema.id + 'Content');
            //v_content.css("margin-top","10px");
            //v_content.css("padding","0 10px 0 10px");
            v_content.css("width","100%");
            $(window.document.body).append(v_content);
            
            //iframe
            var v_frame = $(document.createElement( "iframe" ));
            v_frame.attr("id", _schema.id + 'Frame');
            v_frame.attr("name", _schema.id + 'Frame');
            v_frame.css("width","100%");
            v_frame.css("height","1550px");
            
            if(_schema.iframe_css != null){
                $.each(_schema.iframe_css,function(i,v){
                    v_frame.css(v.code,v.value);
                });
            }
            v_content.append(v_frame);
        }
        
        
        
        
        //tab 클릭시 동작
        if( _schema.events == undefined || _schema.events.click == undefined ){
            mainControl.on("click",function(){
                
                $.each(_schema.parentSchema.elements,function(i,el){
                    $("#"+el.id + 'Tab').removeClass('on'); 
                    $("#"+el.id + 'Tab').removeClass('off');
                    $("#"+el.id + 'Tab').addClass('off');
                    
                    $("#"+el.id + 'Content').hide();
                });
                $("#" + _schema.id + 'Tab').removeClass("off");
                $("#" + _schema.id + 'Tab').addClass("on");
                v_content.show();
                
                var roaded = mainControl.attr("roaded");
                if(roaded == undefined ) roaded = 'n';
                if( roaded != 'n')
                    return;
                
                var viewName = $(this).attr("viewName");
                var form_id = $(this).attr("form_id");
                
                //todo from this
                //var vform = $(document.createElement( "form" ));
                
                var vform =  document.getElementById(form_id);
                vform.action = './generic.html?viewName='+viewName;
                vform.method = "post";
                vform.target = _schema.id + 'Frame';
                //vform.target = v_content[0];
                vform.submit();
                
                mainControl.attr("roaded","y");
                
                
            });
        }
        
        var cur_index = null;
        $.each(_schema.parentSchema.elements,function(i,el){
            if(el == _schema){
                cur_index = i;
                return false;
            }					
        });
        
        if(cur_index == 0 ){
            v_li.addClass("on")
            v_content.css("display", "");				
            
            // load content
            if( _schema.events == undefined || _schema.events.click == undefined ){
                mainControl.trigger("click");
            }else {
                _schema.events.click.call(mainControl);
            }
            
            //mainControl.trigger("click");
        }else{
            v_li.addClass("off")
            v_content.css("display", "none");
        }
        
    }else if(_schema.type == 'tab_list_ssd'){
        mainContainer = $(document.createElement( "div" ));
        mainContainer.attr("id",_schema.id + 'Container' )
        mainContainer.addClass("tab_master");
        // mainContainer.addClass("m_top_10");			
        
        mainControl = $(document.createElement( "ul" )); 
        mainControl.attr("id",_schema.id + 'Ul');
        mainControl.addClass("tab_list");
        mainContainer.append(mainControl);
        
        container.append(mainContainer);
    }else if(_schema.type == 'tab_iframe_ssd'){
        var topContainer = fn_findTopContainer.call(_schema);
        var v_ul = $(_schema.parentContainer).find("ul");
        
        var v_li = $(document.createElement( "li" ));
        v_li.attr("id", _schema.id + 'Tab' );
        v_li.attr("target", _schema.id + 'Content' );
        v_li.addClass("tab_item");
        v_ul.append(v_li);
        
        var mainControl = $(document.createElement( "a" ));
        mainControl.attr("id", _schema.id + '_a' );
        mainControl.attr("origin_id", _schema.id );
        mainControl.addClass("tab_link");
        $.each(_schema.connected_content, function(key,val){
            mainControl.attr(key,val);
        });
        mainControl.text(_schema.label);

        v_li.append(mainControl);		
        
        var content_id = _schema.id + 'Content';
        var frame_id = _schema.id + 'Frame';
        var v_content = null;
        var v_frame = null;
        if($("#"+content_id).length > 0 ){
            v_content = $("#"+content_id);
            v_frame = ("#"+frame_id);
        }else {
            //
            v_content = $(document.createElement( "div" ));
            v_content.attr("id", _schema.id + 'Content');
            //v_content.css("margin-top","10px");
            //v_content.css("padding","0 10px 0 10px");
            v_content.css("width","100%");
            $(window.document.body).append(v_content);
            
            //iframe
            var v_frame = $(document.createElement( "iframe" ));
            v_frame.attr("id", _schema.id + 'Frame');
            v_frame.attr("name", _schema.id + 'Frame');
            v_frame.css("width","100%");
            v_frame.css("height","1550px");
            
            if(_schema.iframe_css != null){
                $.each(_schema.iframe_css,function(i,v){
                    v_frame.css(v.code,v.value);
                });
            }
            v_content.append(v_frame);
        }
        
        //tab 클릭시 동작
        if( _schema.events == undefined || _schema.events.click == undefined ){
            mainControl.on("click",function(){
                $.each(_schema.parentSchema.elements,function(i,el){
                    $("#"+el.id + 'Tab').removeClass('selected'); 
                    $("#"+el.id + 'Content').hide();
                });
                $("#" + _schema.id + 'Tab').addClass("selected");
                v_content.show();
                
                var roaded = mainControl.attr("roaded");
                if(roaded == undefined ) roaded = 'n';
                if( roaded != 'n')
                    return;
                
                var viewName = $(this).attr("viewName");
                var form_id = $(this).attr("form_id");
                
                var vform =  document.getElementById(form_id);
                vform.action = './generic.html?viewName='+viewName;
                vform.method = "post";
                vform.target = _schema.id + 'Frame';
                //vform.target = v_content[0];
                vform.submit();
                
                mainControl.attr("roaded","y");
            });
        }
        
        var cur_index = null;
        $.each(_schema.parentSchema.elements,function(i,el){
            if(el == _schema){
                cur_index = i;
                return false;
            }					
        });
        
        if(cur_index == 0 ){
            v_li.addClass("selected")
            v_content.css("display", "");				
            
            // load content
            if( _schema.events == undefined || _schema.events.click == undefined ){
                mainControl.trigger("click");
            }else {
                _schema.events.click.call(mainControl);
            }
            
            //mainControl.trigger("click");
        }else{
            v_content.css("display", "none");
        }
        
    }		//******* common properties *******//
    
    //*** default value ***//
    if(mainControl != null  && _schema.value != undefined){
        if(typeof _schema.value == 'string')
            mainControl.val(_schema.value);
        else if(typeof _schema.value == 'function')
            mainControl.val(_schema.value());
    }
    
    //***  class ***//
    if(mainControl != null  && _schema.cls != undefined)
        mainControl.addClass(_schema.cls);
    
    //***  events ***//
    //if(_schema.events != undefined && _schema.events.click != undefined)
    //	vInput.click(_schema.events.click);
    if(mainControl != null  && _schema.events != undefined ){
        $.each(_schema.events,function(ikey,event){
            mainControl.on( ikey, event);
            
        });
    }
    
    
    var containerType = container.attr("type");
    //***  class ***//
    if(mainContainer != null  && _schema.containerCls != undefined)
        mainContainer.addClass(_schema.containerCls);
    //***  css ***//
    if(mainContainer != null && _schema.parentSchema != undefined && _schema.parentSchema.type == 'HorizontalLayout'){
        mainContainer.css("display","inline-block");
        if(_schema.width != undefined)
            mainContainer.css("width",_schema.width);
    }
    //- control
    if(mainControl != null && _schema.controlCss != null){
        $.each(_schema.controlCss,function(i,v){
            mainControl.css(v.code,v.value);
        });
    }
    //- container
    if(mainContainer != null && _schema.containerCss != null){
        $.each(_schema.containerCss,function(i,v){
            mainContainer.css(v.code,v.value);
        });
    }
    
    
    //******* End common properties *******//
    
    
    // data process
    if(_schema.elements != undefined &&  _schema.label != undefined){
        
        if(_schema.label != ""){
            var h3 = $(document.createElement("h3"));
            h3.addClass("cont_tit");
            h3.text(_schema.label);
            container.append(h3);
        }
        
        
        containerSub = $(document.createElement("div"));
        container.append(containerSub);
        
        //상위 container type을 줘서 알아서 판단 할 수 있도록 한다.
        containerSub.attr("type", _schema.type);
        if(_schema.parentSchema != undefined 
                && _schema.parentSchema.type == 'HorizontalLayout'){
            
            containerSub.css("display","inline-block");
            if(_schema.width != undefined)
                containerSub.css("width",_schema.width);
            //if(container.children().length > 0)
            //	containerSub.css("margin-left","10px");
        }
        
        
    }
    
    if(_schema.elements != undefined){
        $.each(_schema.elements, function(i,el){
            
            el.parentSchema = _schema;
            el.parentContainer = container;
            fn_makeHtml(containerSub,el);
            /* if(el.type == 'inline'){
                makeInline(containerSub, el);
            }else if(el.type == 'grid'){
                makeGrid(containerSub , el );
            }else if(el.type == 'chart'){
                makeChart(containerSub , el );
            }else if(el.type == 'SearchHeader'){
                makeSearchHeader(containerSub , el );
            }else if(el.type == 'multiCombo'){
                makeMultiCombo(containerSub , el );
            }else if(el.elements != undefined){
                makeHtml(container, el);
            } */
        });
    }
    
    
    
    // $("div.ui-multiselect-menu").css("width","400px");
    // $(".ui-multiselect-filter input").css("width","150px");

}