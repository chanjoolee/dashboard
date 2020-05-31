function genInstance(_entityId, _type,  _list_instance , _option ){
    
    $("#loader").show();
    this.entityId = _entityId;
    this.type = _type;
    this.list_instance = _list_instance;

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
    this.gridCotainerId = this.containerId + "_gridContainer";
    this.gridId = this.containerId + "_grid";
    this.pagerId = this.gridId + "_pager";
    // make form 
    var formTemplate = `
        <form name="form" id="form" class="">
        <input type="hidden" id="searchJson" name="searchJson" value='{}'/>
        </form>
    `;
    this.formId = this.containerId + "_form";    
    this.form = $(formTemplate);
    this.form.attr("id" , this.formId);
    this.form.attr("name" , this.formId);
    
    var _this = this;
    if(this.option != null && this.option.modal){
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
        this.modalClone.find(".modal-header h6 span").text(headStr);

        // inintial search
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
        this.form.find("#searchJson").val(JSON.stringify({fields: v_filters}));

        // modalId
        this.modalClone.attr("id", this.containerId );
        this.modalClone.attr("name", "infiniteLogModal" + this.containerId );
        this.container = this.modalClone.find(".modal-body");        
        
        this.list_instance.container.append(this.modalClone);

        // modal
        setTimeout( function(){
            _this.modalClone.modal();
            _this.modalClone.draggable({
                handle: ".modal-header"
            }); 
        },0);
        
    }else{
        this.container = $("<div/>",{id:  this.containerId });
        this.list_instance.container.append(this.container);
    }
    this.container.append(this.form);
    
    this.searchContainer = null;
    this.gridCContainer = null;
    
    
    // 어떤식으로 입력을 할 것인가?  
    // div에 소스를 생성하는 방식으로?
    // ==> 이것은 커스터마이징을 할 수 있도록 한다. 
    // schema를 바탕으로 자동으로 생성을 한다?
    // ==> 일단은 이것으로 한다.
    // 이것을 완성 한 다음 div 에 소스를 generating 하는 방식으로 한다.


    this.fn_setDataSourceValue();
    // container 안에 그린다.
    // 01. search
    if(this.option != null && this.option.modal){
        
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
    var gridContainer = $("<div/>",{id: this.gridCotainerId});
    this.gridCContainer = gridContainer;
    this.form.append(gridContainer);
    var schema = this.jpaFile.schema.contents.schema ;
    var makehtml = new makeHtmlBySchema( this.gridCContainer , schema , this );
}

genInstance.prototype.fn_contextmenu = function(){
    var _this = this;

    $.contextMenu(
        {
            "selector": "#" + _this.gridCotainerId + " .jqgrow td.contextMenu",
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
                // var models = eval(vGridOpt.modelVarName);
                // var vEntity = _.find([].concat(models.ownedEntities),{"_xmi:id": vGridOpt.entityId} );
                
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
                                    filter : filter
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
                                    filter : filter
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
    
                if ( _.keys(options.items).length == 1 ){
                    options.items[_.keys(options.items)[0]].callback();
                    return false;
                }
    
                return options;
                // return false; 
            }

        }
    );

}

genInstance.prototype.fn_search = function(){
    var _this = this;
    // $("#loader").show();
    setTimeout( function(){
        // jstreeInfo.search();
        var theGrid = $("#" + _this.gridId ).jqGrid();
        theGrid.trigger('reloadGrid',[{page:1}]);
        // $("#loader").hide();
    },50);
}



