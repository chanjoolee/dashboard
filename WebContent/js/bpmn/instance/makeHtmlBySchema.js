function makeHtmlBySchema( _container , _schema , _instance ){
    this.container = _container; 
    this.schema = _schema;
    this.instance = _instance ;
    this.process_type( _schema , null , _container );
}

makeHtmlBySchema.prototype.process_type = function(  _schema , _schema_parent , container_parent ){
    var _this = this;
    var container = null;
    if(_schema.type == 'Vertical'){
        container = _this.Vertical( _schema , _schema_parent , container_parent);
    }else if(_schema.type == 'Vertical'){
        container = _this.HorizontalLayout( _schema , _schema_parent , container_parent);
    }

    if(_schema.elements != null){
        $.each( _schema.elements , function( i , el){
            _this.process_type( el , _schema ,  container  );
        });
    }
    
}

makeHtmlBySchema.prototype.defaultSetting = function( _container ){
    var _this = this;
    if( _schema.id != null){
        _container.attr("id", _schema.id);
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
    container_parent.append(container);
    return container;
}

makeHtmlBySchema.prototype.inline = function(_schema){
    var _this = this;

    var container = $("<div/>",{});
    _this.defaultSetting(container);
    container_parent.append(container);

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

makeHtmlBySchema.prototype.inline_iframe = function(_schema){
    var _this = this;

    var container = $("<div/>",{});
    _this.defaultSetting(container);
    container_parent.append(container);

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

