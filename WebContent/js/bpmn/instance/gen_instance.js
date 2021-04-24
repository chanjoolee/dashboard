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

    // 제목을 Label 로 표시한다.
    var vPageLabel = _this.entityId;
    var vJpa = _.find(instances.jpaFiles,{entityId : _this.entityId});
    if (vJpa.entity_doc_obj != null && vJpa.entity_doc_obj.label != null){
        vPageLabel = vJpa.entity_doc_obj.label;
    }

    if(this.option != null && this.option.modal ){
        var modalCommon = $("[name=infiniteLogModal]");
        this.modalClone = modalCommon.clone();
        this.modalClone.attr("isCloned","true");

        // Header
        var filterStrs = [];
        $.each(this.option.filterLabel,function(k,v){
            // k : 컬럼
            var str = _.camelCase(k);            
            str += " : " + v;
            filterStrs.push(str);
        });
        
        var headStr = '[' + _.camelCase(vPageLabel) + ']  ' +  filterStrs.join(" , ");	
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
        // this.container.append($("<h5/>",{class: "page-title"}).text(vPageLabel));
        this.container.append(`
        <div class="page-title-box">            
            <h4 class="page-title">` + vPageLabel  + `</h4>
        </div>
        `);
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


    this.fn_setDataSourceValue();
    // container 안에 그린다.
    // 01. search
    if(this.option != null && this.option.filter != null ){
        // 필터가 있다면 검색조건을 만들지 않는다.
    }else{
        this.makeSearch();
    }
    
    // 02. grid
    this.makeGrid();

    this.fn_contextmenu();

    $("#loader").hide();

    if(this.option != null && this.option.modal){

    }

}

genInstance.prototype.fn_setDataSourceValue = function(){
    var _this = this;
    // dictionary
    $.each(_this.jpaFile.dictionaries,function(i, src){
        src.data();
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

/**
부모를 참조하는 데이타 셋팅
*/
genInstance.prototype.fn_setDataSourceValueParent = function( _datasrc ){
    var _this = this;
    var prop = _.find( _this.jpaFile.gridProperties , { _name : _datasrc.childColumnName } );
    var dataSrcType = "select";
    if ( prop != null && prop._documentation != null && prop._documentation.data_src_type != null)
        dataSrcType = prop._documentation.data_src_type;
    if (dataSrcType == "select")
        var dataSrcType = "select";
    if (dataSrcType != "select")
        return;
    $.ajax({
        type: "POST",
        url: "./genericlListJson.html?" +
            "&sqlid=" + _datasrc.sqlId,
        data: {},
        async: false,
        success: function (response) {
            var dataList = response.dataList;
            $.each(dataList, function (i, data) {
                if( data != null)
                _datasrc.value[data[ _datasrc.topColumnName.toUpperCase()]] = data[_datasrc.topNameColumn.toUpperCase()];
            });
        }
    });
}

genInstance.prototype.makeSearch = function(){
    var _this = this;
    var searchContainer = $("<div/>",{id: this.searchContainerId});
    this.searchContainer = searchContainer;
    this.searchContainer.addClass("form-layout form-layout-7");
    this.form.append(searchContainer);
    var schema = this.jpaFile.schema.search.schema ;
    schema.containerType = "search";
    var makehtml = new makeHtmlBySchema( this.searchContainer , schema , this );
}

genInstance.prototype.makeGrid = function(){
    var _this = this;
    var gridContainer = $("<div/>",{id: this.gridContainerId});
    this.gridContainer = gridContainer;
    this.form.append(gridContainer);
    var schema = this.jpaFile.schema.contents.schema ;
    var makehtml = new makeHtmlBySchema( this.gridContainer , schema , this );
}

genInstance.prototype.fn_contextmenu = function(){
    var _this = this;
    if(_this.jpaFile.entity_doc_obj.customFunc.fn_contextmenu != null){
        _this.jpaFile.entity_doc_obj.customFunc.fn_contextmenu.call(_this);
    }
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
                
                // Label이 있으면 Label 로 표현한다.
                var itemName = src.parentEntity;
                var parentJpa = _.find(instances.jpaFiles,{entityId : src.parentEntity});
                if (parentJpa.entity_doc_obj != null && parentJpa.entity_doc_obj.label != null){
                    itemName = parentJpa.entity_doc_obj.label;
                }
                // entityId를 넣어야 하므로 camelCase 를 쓰지 않는다.
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

                                if(rowData[column.toUpperCase()] != null){
                                    filter[parentColumn.toUpperCase()] = rowData[column.toUpperCase()];
                                    filterLabel[parentColumnLabel] = rowData[column.toUpperCase()];
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
                hasParents = true;
                // }

            }
            // Seperator
            options.items["Seperator"] = "-------------";
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
                                
                                if(rowData[column.toUpperCase()] != null){
                                    filter[column.toUpperCase()] = rowData[parentColumn.toUpperCase()];
                                    filterLabel[childColumnLabel] = rowData[parentColumn.toUpperCase()];
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
                hasChildrens = true;
                
                
            });
            
            if ( !hasParents && !hasChildrens )
                return false;

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

genInstance.prototype.fn_jstreeSearch = function(){
    var _this = this;
    
    if (_this.jstreeList.length == 0)
        return;
    if(this.option != null && this.option.modal ){
        return;
    }
    var selJsTree3 = [];
    $.each(_this.jstreeList, function(i,vJsTreeId){
        // 만약 Child Pop 인 경우, jstree가 없으므로 넘어간다.
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
    _this.form.find("[name=searchJson]").val(JSON.stringify({fields: selJsTree3}));
}

genInstance.prototype.fn_search = function(){
    var _this = this;
    // $("#loader").show();
    setTimeout( function(){
        
        if( _this.jpaFile.entity_doc_obj.customFunc.jstreeInfoSearch != null ){
            _this.jpaFile.entity_doc_obj.customFunc.jstreeInfoSearch.call(_this);
        }else{
            _this.fn_jstreeSearch();
        }
        
        var theGrid = $("#" + _this.gridId ).jqGrid();
        theGrid.trigger('reloadGrid',[{page:1}]);
        // theGrid.trigger('reloadGrid');
        // $("#loader").hide();
        // var gridBody = $("#gbox_" + _this.gridId + " .ui-jqgrid-bdiv");
        // gridBody.height( "100%"  );
        // gridBody.height( gridBody.height() + 10  );
    },50);
}



