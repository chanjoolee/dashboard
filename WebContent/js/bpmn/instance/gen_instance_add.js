function genInstanceAdd(_entityId, _type,  _list_instance , _option ){
    
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
    
    this.jpaFile = this.option.caller.jpaFile;
    // this.jpaFile.dataSrc = this.jpaFile.dataSources;
    this.containerId = "div_" + this.entityId + "_"+ this.type + "_" + this.idPrefix; 
    
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
        var headStr = '[' + _.camelCase(_this.entityId) + ' ' + _._.capitalize(this.type) +  ']  ' +  filterStrs.join(" , ");													
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
    this.contentContainer = null;
    this.data = {};
    this.makeContent();  

    $("#loader").hide();


}



genInstanceAdd.prototype.makeContent = function(){
    var _this = this;
    var contentContainer = $("<div/>",{id: this.gridCotainerId});
    this.contentContainer = contentContainer;
    this.form.append(contentContainer);
    var schema = this.jpaFile.schema.contents.schema ;
    var makehtml = new makeHtmlBySchema( this.gridCContainer , schema , this );
}

genInstanceAdd.prototype.makeSchema = function(){

    var _this = this;
    this.fn_getData();
}


genInstanceAdd.prototype.fn_getData = function(){
    var _this = this;
    _this.data = _this.option.filter;
    var vKeys = [];
    $.each([].concat( _this.jpaFile.gridProperties ), function(i, prop){
        let vId = _.find( _.isArray(prop.annotations)?prop.annotations:[prop.annotations] ,{"_xsi:type" : "gmmjpa:Id"});
        if (vId != null){
            vKeys.push(prop._name.toUpperCase());
        }
    });

    
}