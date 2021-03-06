function Generator(_schema_bpmn, _cssType, _dbType, _deploy, _rowdata){
    this.files = {};
    this.cssType = _cssType;
    if(_dbType != null)
        this.dbType = _dbType;
    else
        this.dbType = "oracle";
    this.deploy = _deploy ;
    this.rowData = _rowdata;
    /**
     * two times call prepend
     * url
     * schema
     */
    this.schema_jpa_list = [];
    this.schema_bpmn = _schema_bpmn;
    
    this.init();
}


Generator.prototype.init = function(){
    var _this = this;
    if(this.schema_bpmn == undefined)
        return;
    
    // bpmn
    if(_this.schema_bpmn.Definitions != undefined ){
        // find process
        this.processes = _.filter(this.schema_bpmn.Definitions.rootElements,{"_xsi:type": "bpmn2:Process"});			
        _.forEach(this.processes,function(process,i){
            _this.fn_start(process);
        });
    }
    // Jpa
    else if( _this.schema_bpmn.Model != undefined && (_this.cssType == null || _this.cssType == 'PMS' ) ){
        _this.fn_convert_id();
        var generator = new JpaAllGenerator( _this ) ;
        generator.fn_generate();
        generator.fn_fileSave();

    }
    else if( _this.schema_bpmn.Model != undefined && _this.cssType != null && _this.cssType == "BootStrap" ){
        _this.fn_convert_id();
        var generator = new JpaAllGeneratorBootstrap( _this ) ;
        generator.fn_generate();
        generator.fn_fileSave();

    }
    else if( _this.schema_bpmn.Model != undefined && _this.cssType != null && _this.cssType == "ToolBox" ){
        _this.fn_convert_id();
        var generator = new JpaAllGeneratorToolBox( _this ) ;
        generator.fn_generate();
        generator.fn_fileSave();

    }
    else if( _this.schema_bpmn.Model != undefined && _this.cssType != null && _this.cssType == "Bracket" ){
        _this.fn_convert_id();
        var generator = new JpaAllGeneratorBracket( _this ) ;
        generator.fn_generate();
        generator.fn_fileSave();

    }
    else if( _this.schema_bpmn.Model != undefined && _this.cssType != null && _this.cssType == "IndexedDB" ){
        _this.fn_convert_id();
        var generator = new JpaAllGeneratorLocalStorage( _this ) ;
        generator.fn_generate();
        generator.fn_fileSave();

    }
    
}

Generator.prototype.fn_convert_id = function(){
    var _this = this;
    var entities  = _this.schema_bpmn.Model.ownedEntities;
    $.each(entities , function(i, _entity){
        // 01. Change _referencedEntity id
        var toEntityName = _entity["_name"];
        var refObjects = filterAllByElName(schema_bpmn, {"_referencedEntity": _entity["_xmi:id"] });
        $.each(refObjects , function(j,_refObject){
            _refObject["_referencedEntity"] = toEntityName;
        });

        // 02. Change entity Name
        _entity["_xmi:id"] = toEntityName;
    });

    // 03. Change references ID : reference_parent_child
    $.each(entities , function(i, _entity){
        if(_entity["references"] != null){
            var refObjects = _entity["references"];
            $.each([].concat(refObjects) , function(j, _refObject){
                _refObject["_xmi:id"] = "reference::" + _entity["_name"] + "::" + _refObject["_referencedEntity"] ;
            });
        }
    });
}


// return start in process flowElements 
Generator.prototype.fn_start = function(process){
    var _this = this;
    var target_task ;
    var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
    if ( start == undefined){
        if(_.isArray(process.flowElements)){
            target_task = _.find(process.flowElements, function(flow){
                if ( flow.eAnnotations == undefined )
                    return false;
                var isStart = _.find(flow.eAnnotations.details,{_key: "keyword_is_start"});
                if (isStart != undefined)
                    return true;
            });
            if(target_task == undefined)
                return;
        }else{
            target_task = process.flowElements;
        }
        
        this.fn_task(process,target_task);
        return;
    }
    else{
        // var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
        var sequence = this.findAll(start["_outgoing"], this.processes);
        var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
        if(process.depth != undefined)
            target_task.depth = process.depth + 1;
        
        if(process["file_name"] != undefined){
            var content = {						
                "task": target_task,
                "depth": target_task.depth,
                // "detail": detail,
                "is_start": true
            };
        }
        target_task.is_start = true;
        _this.fn_task(process,target_task);
    }
    
}

Generator.prototype.fn_task = function(process, task){
    var _this = this;
    task.parent = process;
    // subprocess . file create
    if( _.isArray(task.eAnnotations.details) 
        && _.find(task.eAnnotations.details,{"_key":"file_type"}) != undefined
        && process["file_name"] == undefined
    ){
            var file_name = _.find(task.eAnnotations.details,{"_key":"file_name"})._value;
            // var file_path = _.find(task.eAnnotations.details,{"_key":"file_path"})._value;
            // var file_path_type = _.find(task.eAnnotations.details,{"_key":"file_path_type"})._value;
            task.file_name = file_name;

            this.files[file_name] = {};
            this.files[file_name].process = task;
            // this.files[file_name].file_path = file_path;
            // this.files[file_name].file_path_type = file_path_type;
            this.files[file_name].contents = [];
            task.depth = -1;
    }
    
    // detail properties
    if( _.isArray(task.eAnnotations.details) 
        && _.find(task.eAnnotations.details,{"_key":"file_type"}) == undefined
        && process["file_name"] != undefined
    ){

        var content = {						
            task: task ,
            "depth": task.depth 
        };
        this.files[process["file_name"]].contents.push(content);
    }

    
    // file name
    if(process["file_name"] != undefined){
        task.file_name = process["file_name"];
    } 			
    
    // subProces			
    if(task.flowElements != undefined){
        // task.parent = process;
        this.fn_start(task);
    }

    
    
    // end Process
    if(task["_outgoing"] == undefined){
        return;
    }
        

    // --- next task ------- //
    // sequence
    // var sequence = _.find(process.flowElements,{"_xmi:id": task["_outgoing"]});
    // var sequences = _.filter(process.flowElements,function(el){
    //     if(task["_outgoing"].match(el["_xmi:id"]) != null )
    //         return true;
    // });
    var sequences = this.filterAll(task["_outgoing"], _this.processes);
    _.forEach(sequences,function(sequence,i){
        if(process.depth != undefined){
            sequence.parent = process;
            sequence.depth = process.depth + 1;
        }

        var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
        if(process.depth != undefined)
            target_task.depth = process.depth + 1;
        _this.fn_task(process,target_task);
    });
    
}


Generator.prototype.fn_source = function(){
    var _this = this;
    if(_this.schema_bpmn.Definitions != undefined ){
        _.forEach(this.files,function(v,k){
            if( _.isArray(v.process.eAnnotations.details) ){   
                if ( _.find(v.process.eAnnotations.details,{"_key":"file_type"})._value == "python"){
                    var generator = new PythonGenerator(k, _this);
                    _this.files[k].generator = generator;
                }else if(_.find(v.process.eAnnotations.details,{"_key":"file_type"})._value == "java_jsp"){
                    var generator = new JspGenerator(k, _this);
                    _this.files[k].generator = generator;
                }else if(_.find(v.process.eAnnotations.details,{"_key":"file_type"})._value == "toolbox"){
                    var generator = new JpaAllGeneratorToolBox(k, _this);
                    _this.files[k].generator = generator;
                }
                
            }
        });
    
        this.fn_fileSave();
    }

}

Generator.prototype.fn_fileSave = function(){
    var _this = this;
    $.each(_this.files,function(k,v){
        // var blob = new Blob([v.sources.join("\r\n")], {type: "text/plain;charset=utf-8"});
        if(v.generator.fn_generate != undefined)
            v.generator.fn_generate();
        
        var blob = new Blob([v.generator.sources.join("\r\n")], {type: "text/plain;charset=utf-8"});
        saveAs(blob,k);
        
        // var a = document.createElement("a") ;
        // document.body.appendChild(a) ;
        // a.style = "display: none" ;
        // a.href = window.URL.createObjectURL(blob) ;
        // a.download = k ;
        // a.click()
    });
}

Generator.prototype.fn_keyword_variable = function(process, detail){
    var _this = this;
    var rtn = detail._value;

    if(detail._key == "path"){
        // defined process 
        if( _.isArray(process.parent.eAnnotations.details)
            && _.find(process.parent.eAnnotations.details,{"_key":"path"}) != undefined
        ){
            rtn = "";
            rtn = _.find(process.parent.eAnnotations.details,{"_key":"path"})._key + _this.fn_depth(process.parent,detail);					
            rtn += " + \"/\" +  " + detail._value  ;					
            // return rtn;
        }
        // find parent
        else if( process.parent.parent != undefined){
            // return fn_keyward_variable(process.parent,detail);
            rtn = _this.fn_keyword_variable(process.parent,detail);
        }
        
    }

    // v_loop
    var match = rtn.match(/(?<name>\bv_loop\b)/);
    if(match != null){
        if( _.isArray(process.eAnnotations.details)
            && _.find(process.eAnnotations.details,{"_key":"loop_condition"}) != undefined
        ){
            rtn = rtn.replace(/\bv_loop\b/,"v_loop" + fn_depth(process) )
        }
        // find parent
        else if( process.parent != undefined){
            rtn = _this.fn_keyword_variable(process.parent,detail);
        }
    }

    // path
    if(detail._key != "path"){
        var match = rtn.match(/(?<name>\bpath\b)(\.(?<path>((current)|(parent))))?/);
        
        if(match != null){
            var v_current_parent = "current";
            if(match.groups.path != undefined){
                v_current_parent = match.groups.path;
            }else{
                var v_current_parent = "parent";
            }
                
            if(v_current_parent == "parent"){ // parent
                if( _.isArray(process.parent.eAnnotations.details)
                    && _.find(process.parent.eAnnotations.details,{"_key":"path"}) != undefined
                ){
                    rtn = rtn.replace(/(?<name>\bpath\b)(\.(?<path>((current)|(parent))))?/,"path" + _this.fn_depth(process.parent) );
                }
                // find parent
                else if( process.parent.parent != undefined){ 
                    rtn = _this.fn_keyword_variable(process.parent ,detail);
                }
            }else{ // current
                
                var flows = [];
                var dfn1_start = function(_process){
                    var _start = _.find(_process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
                    // var _sequence = _.find(_process.flowElements,{"_xmi:id": _start["_outgoing"]});
                    var _sequence = _this.findAll(_start["_outgoing"], _this.processes);
                    var _target_task = _.find(_process.flowElements,{"_xmi:id": _sequence["_targetRef"]});
                    dfn1_task(_process,_target_task);
                };
            
                var dfn1_task = function(_process,_task){
                    flows.push(_task);
                    // end Process
                    if(_task["_outgoing"] == undefined){
                        return;
                    }
            
                    // --- next task ------- //
                    // sequence
                    // var sequence = _.find(process.flowElements,{"_xmi:id": task["_outgoing"]});
                    // var sequences = _.filter(_process.flowElements,function(el){
                    //     if(_task["_outgoing"].match(el["_xmi:id"]) != null )
                    //         return true;
                    // });
                    var sequences = _this.filterAll( _task["_outgoing"] , _this.processes );
                    $.each(sequences,function(i,sequence){
                        flows.push(sequence);
                        var target_task = _.find(_process.flowElements,{"_xmi:id": sequence["_targetRef"]});
                        dfn1_task(_process,target_task);
            
                    });
                    
            
                    
                }
                dfn1_start(process.parent);
                $.each(flows, function(i,flow){
                    if(flow == process)
                        return true;

                    if( _.isArray(flow.eAnnotations.details)){
                        var v_path = _.find(flow.eAnnotations.details,{"_key":"path"});
                        if(v_path != undefined)
                            rtn = "path" + _this.fn_depth(flow,v_path);
                    }
                });
                rtn = rtn.replace(/(?<name>\bpath\b)(\.(?<path>((current)|(parent))))?/,"path" + _this.fn_depth(process) );
            
            }            
        }
    }
    
    

    return rtn;
}

Generator.prototype.fn_indent_write = function(indent){
    var src = "";
    for(var j = 0; j < indent ; j++ )
        src += "\t";
    return src ;
}

Generator.prototype.fn_depth = function(task,detail){
    var _this = this;
    if(detail != undefined){
        if(detail._key == "path"){
            if (task.depth == undefined)
                return "";
            else if(task.depth != undefined && task.depth == 0){
                return "";
            }else
                return "_" + task.depth;
        }else {
            return "";
        }
    }else{
        if (task.depth == undefined)
            return "";
        else if(task.depth != undefined && task.depth == 0){
            return "";
        }else
            return "_" + task.depth;
    }
    
    
}

Generator.prototype.findAll = function(id,items){
    var result = [];
    result = this.filterAll(id,items);
    if (result.length > 0 )
        return result[0];
    else 
        return null;
}
Generator.prototype.filterAll = function(id,items){
	var i = 0, found, result = [];

	for (; i < items.length; i++) {
		if ( id.match(items[i]["_xmi:id"]) != null ){
	    	result.push(items[i]);
		} else if (items[i].flowElements != undefined && _.isArray(items[i].flowElements)) {
			found = this.filterAll(id, items[i].flowElements);
		    if (found.length) {
		    	result = result.concat(found);
			}
		}
	}

	return result;
}

/**
 * 
 * @param {*} search {key : string, value : string}
 * @param {*} items object or array
 */
Generator.prototype.filterAll1 = function( search, items){
	var i = 0, found, result = [];

    $.each(items,function(k,v){
        if( _.isArray(v) )
            return true;
        
    });
	for (; i < items.length; i++) {
		if ( id.match(items[i]["_xmi:id"]) != null ){
	    	result.push(items[i]);
		} else if (items[i].flowElements != undefined && _.isArray(items[i].flowElements)) {
			found = this.filterAll1(id, items[i].flowElements);
		    if (found.length) {
		    	result = result.concat(found);
			}
		}
	}

	return result;
}


/**
 * schema에서 특정 element를 찾는다.
 * @param {*} id 
 * @param {*} items 
 */
Generator.prototype.findAllFromObject =  function(id, items) {
    var i = 0, found, result = [];
    

    if( _.isArray(items )){
        for (; i < items.length; i++) {
            if (items[i].id === id) {
                result.push(items[i]);
            } else if (_.isArray(items[i].elements)) {
                found = findAll(id, items[i].elements);
                if (found.length) {
                    result = result.concat(found);
                }
            }
        }
    }else{
        if(items["id"] === id)
            result.push(items);
        if(items["elements"] != undefined){
            found = findAll(id, items["elements"]);
            if (found.length) {
                result = result.concat(found);
            }
        }
    }
    if (result.length > 0 )
        return result[0];
    else
        return undefined;
}

Generator.prototype.filterAllByElName =  function(items ,findJson) {
    var _this = this;
    var i = 0, found, result = [];    

    if(_.isArray(items)){
        var vfind = _.find(items,findJson);
        if(vfind != null)
            result.push(vfind);
        else{
            $.each(items,function(j,item){
                found = _this.filterAllByElName(item, findJson);
                if (found.length) {
                    result = result.concat(found);
                }
            });
            
        }
    }else if(_.isObject(items)){
        var vfind = _.find([items],findJson);
        if(vfind != null)
            result.push(vfind);
        else{
            $.each(items,function(j,item){
                found = _this.filterAllByElName(item ,findJson);
                if (found.length) {
                    result = result.concat(found);
                }
            });
        }

    }

    return result;
}

Generator.prototype.findAllByElName = function(items, findJson){
    var _this = this;
    var result = [];
    result = _this.filterAllByElName(items,findJson);
    if(result.length > 0)
        return result[0];
    else
        return undefined;
}

Generator.prototype.fuctionToString = function(jsobject){
    var _this = this;
    var str = "";
    $.each(jsobject,function(k,v){
        if( v == null || v == undefined)
            return true;

        if(typeof(v) == "function"){
            jsobject[k] = v.toString().replace(/\$sqlId/g, jsobject.sqlId );
        }
        else if(typeof(v) ==  "object")
            _this.fuctionToString(v);
        
    });
    

}


