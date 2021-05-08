/**
 * custom type master and sub
 * @param {*} _entityId master entityId
 * @param {*} _type master_sub
 * @param {*} _list_instance 
 * @param {*} _option schema {}
 */
function genInstanceMasterSub(_entityId, _type,  _list_instance , _option ){
    this.type = _type;
    var _this = this;
    this.list_instance = _list_instance;
    this.option = _option;
    this.entityId = _entityId;

    var today = new Date();
    var y = today.getFullYear();
    var m = today.getMonth() + 1;
    var d = today.getDate();
    var h = today.getHours();
    var mi = today.getMinutes();
    var s = today.getSeconds();
    this.idPrefix =  y + "_" + m + "_" + d + "_" + h + "_" + mi + "_" + s;
    this.containerId = "div_" + this.entityId + "_"+ this.type + "_" + this.idPrefix;
    this.container = $("<div/>",{id:  this.containerId });
    this.list_instance.container.append(this.container);
    this.container.addClass("row");
    

    this.sub_instance = {
        parent_instance : _this,
        list : new gen_instance_list(_this.container , _this.list_instance.jpaFiles )
    }
    var instanceOption = {
        isPopSelect : false
    };
    //master;
    var masterInstance = new genInstance( _entityId, 'master' , this.sub_instance.list ,instanceOption);
    this.sub_instance.list.list.push(masterInstance);
    masterInstance.container.addClass("col-xl-12");
    var masterGrid = $("#" + masterInstance.gridId).jqGrid();
    
    

    //sub
    $.each(this.option.elements, function(i,child){
        var reference = _.find(masterInstance.jpaFile.childReferences,{childEntityName : child.entity_id});
        var filter = {};
        var filterLabel = {};
        $.each(reference.child_columns , function(i,column){
            var parentColumn = reference.parent_columns[i];
            filter[column] = 'xxx';
        });
        var instanceOption = {
            modal : false,
            caller : _this ,
            filter : filter,
            filterLabel :filterLabel ,
            showLabel : true 
        };
        var subInstance = new genInstance( child.entity_id, 'sub' , _this.sub_instance.list , instanceOption);
        subInstance.container.addClass("col-xl-6");
        _this.sub_instance.list.list.push(subInstance);

    });

    // master gridrow click
    var grid = $("#" + masterInstance.gridId ).jqGrid();
    grid.on("click",".jqgrow.ui-row-ltr",function(e) {
        // console.log( $( this ).text() );
        var rowId = $(e.target).parent().attr("id");
        if(rowId == null)
            return;
        var row = grid.jqGrid('getRowData',rowId);
        // sub filter
        $.each(_this.option.elements, function(i,child){
            var reference = _.find(masterInstance.jpaFile.childReferences,{childEntityName : child.entity_id});
            var filter = {};
            var filterLabel = {};
            $.each(reference.child_columns , function(i,column){
                var parentColumn = reference.parent_columns[i];
                var parentColumnLabel = parentColumn;
                var parentColumnObj = _.find(masterInstance.jpaFile.gridProperties,{_name: parentColumn});
                if(parentColumnObj._documentation != null &&  parentColumnObj._documentation.label != null)
                    parentColumnLabel = parentColumnObj._documentation.label;
                filter[column.toUpperCase()] = row[parentColumn.toUpperCase()];
                filterLabel[parentColumnLabel] = row[parentColumn.toUpperCase()];
            });
            var v_filters = [];
            $.each(filter ,function(field, data){
                var obj = {
                    field : field ,
                    // value: [].concat(data)
                    value: data , 
                    isArray : _.isArray(data)
                };
                v_filters.push( obj );
            });            
            var subInstance = _.find(_this.sub_instance.list.list,{entityId:child.entity_id});
            subInstance.option.filter = filter;
            subInstance.option.filterLabel = filterLabel;
            subInstance.form.find("[name=searchJson]").val(JSON.stringify({fields: v_filters}));
            subInstance.fn_search();
        });
        
    });

    
    // pager setting
    this.list_instance.container.find('.ui-pg-selbox').show();
    this.list_instance.container.find('.ui-paging-pager td').show();
    // auto submit prevent
    setTimeout( function(){
        // $(masterGrid.getGridParam("pager")).find("td button.dropdownmenu").attr("type","button");
        _this.list_instance.container.find(".ui-pager-control td button.dropdownmenu").attr("type","button");
    },50);

}


