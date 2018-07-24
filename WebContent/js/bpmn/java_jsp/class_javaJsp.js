function JspGenerator(file_name, _generator){
    var _this = this;
    this.generator = _generator;
    this.file_name = file_name;
    this.processes = this.generator.processes;
    this.process = this.generator.files[this.file_name].process;
    this.src_script_include = [];
    
    /**
     * 
     * @name string
     * @schema {}
     */
    this.src_schemas = [];
    this.src_script = [];
    this.src_html = [];
    this.sources = [];    
    this.init();
}

JspGenerator.prototype.init = function(){
    var _this = this;
    //this.fn_comment(this.process);
    // this.fn_custom_script(this.process);
    this.fn_start(this.process);
}

JspGenerator.prototype.fn_depth = Generator.prototype.fn_depth;


/**
 * indicate if pre task is exclusive gate
 * @param {*} _task 
 */
JspGenerator.prototype.fn_pre_exgate = function(_task){
    var _this = this;
    var v_income = _task["_incoming"];
    if ( v_income != undefined){
        // var pre_sequence = _.find(_task.parent.flowElements, {"_xmi:id": v_income});
        var pre_sequence = _this.findAll(v_income, _this.process.flowElements );
        if (pre_sequence != null && pre_sequence["_xsi:type"] == "bpmn2:SequenceFlow")
        {
            var v_src = pre_sequence["_sourceRef"];
            if(v_src != undefined){
                var pre_gate = _.find(_task.parent.flowElements, {"_xmi:id": v_src});
                if( pre_gate != null && pre_gate["_xsi:type"] == "bpmn2:ExclusiveGateway" ){
                    return pre_gate;

                }
                    
            }
                
        }
    }
    return null;	
}
JspGenerator.prototype.fn_keyword_variable = Generator.prototype.fn_keyword_variable;


JspGenerator.prototype.fn_indent_write = Generator.prototype.fn_indent_write;

JspGenerator.prototype.fn_start = function(process){
    var _this = this;
    var target_task
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
    }else {
        // var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
        var sequence = this.findAll(start["_outgoing"], _this.process.flowElements);
        var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
        this.fn_task(process,target_task);
    }
        
    
}

JspGenerator.prototype.fn_process_sequence = function(process,task,sequence, _indent){
    var _this = this;
    var indent = _this.fn_indent(task);
    var src = "";
    if (_indent != undefined)
        indent = _indent;
    
    // detail properties
    if(sequence._name != undefined &&  sequence._name.trim().length > 0 ){
        var src = _this.fn_indent_write(_this.fn_indent(sequence)); src += "# " + sequence._name;  _this.sources.push(src);
    }
        
    if( _.isArray(sequence.eAnnotations.details) 
        && _.find(sequence.eAnnotations.details,{"_key":"file_type"}) == undefined
        && process["file_name"] != undefined
    ){

        if(task["_xsi:type"] == "bpmn2:ExclusiveGateway"
            && _.find(sequence.eAnnotations.details,{"_key":"keyword_check_type"}) != undefined
            && _.find(sequence.eAnnotations.details,{"_key":"keyword_check_type"})["_value"] == "file_exists"
        ){
            var src = _this.fn_indent_write(_this.fn_indent(sequence)); src += "# ExclusiveGateway";  _this.sources.push(src);
            _this.fn_detail_variable(sequence);
            var detail_path = _.find(sequence.eAnnotations.details, {"_key":"path"});
            if( detail_path != null){ 
                // var path = "path" + fn_depth(task,detail_path);                
                var path = _this.fn_keyword_variable(task, detail_path );
                src = _this.fn_indent_write(_this.fn_indent(sequence)); src += "if os.path.isfile(" + path + ") == True:"; _this.sources.push(src);
            }
        }else if( task["_xsi:type"] == "bpmn2:ExclusiveGateway"
            && _.find(sequence.eAnnotations.details,{"_key":"keyword_check_type"}) != undefined
            && _.find(sequence.eAnnotations.details,{"_key":"keyword_check_type"})["_value"] == "file_pattern_match"
        ){
            var src = _this.fn_indent_write(_this.fn_indent(sequence)); src += "# ExclusiveGateway";  _this.sources.push(src);
            _this.fn_detail_variable(sequence);
        }else if( task["_xsi:type"] == "bpmn2:ExclusiveGateway"
            && _.find(sequence.eAnnotations.details,{"_key":"keyword_compare_value"}) != undefined
        ){
            var compareValue = _.find(sequence.eAnnotations.details,{"_key":"keyword_compare_value"});
            src = _this.fn_indent_write(_this.fn_indent(sequence)); src += "if " + compareValue._value + ":"; _this.sources.push(src);
        }

    }

    
};
JspGenerator.prototype.fn_task = function(process,task){
    var _this = this;
    // this.fn_detail_variable(task);    
    _this.fn_schema(task);
    // _this.fn_custom_script(task);
    
    if(task.flowElements != undefined){
        // task.parent = process;
        var keyword_subtask_skip = _.find(task.eAnnotations.details,{"_key":"keyword_subtask_skip"});
        if ( keyword_subtask_skip == undefined ||  keyword_subtask_skip == null || keyword_subtask_skip._value != "true" )
            _this.fn_start(task);
    }			

    // _this.fn_data_output(task);

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
    var sequences = this.filterAll(task["_outgoing"], _this.process.flowElements);
    $.each(sequences,function(i,sequence){
        // _this.fn_detail_variable(sequence);
        // _this.fn_process_sequence(process, task, sequence);
        var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
        _this.fn_task(process,target_task);

    });
    
}

JspGenerator.prototype.fn_comment = function(task){
    var _this = this;
    src = "";
    // indent
    var indent = this.fn_indent(task);
    for(var j = 0; j < indent ; j++ )
        src += "\t";
    src += "# ";
    if (task["_name"] != undefined)
        src += task["_name"];
    else{
        src += task["_xsi:type"];
    }
    this.sources.push(src);
}

JspGenerator.prototype.fn_data_output = function(task, _indent){
    var _this = this;
    var src = "";
    var process = task.parent;
    // data assosiation  datastore target
    var v_dataOutputAssociations = null;

    var indent = _this.fn_indent(task);
    if( _indent != undefined )
        indent = _indent;

    if(_.isArray(task.dataOutputAssociations)){
        v_dataOutputAssociations = _.find(task.dataOutputAssociations,function(o){
            if(o._targetRef != undefined){ 
                return true;
            }else{
                return false;
            }

        });
    }
    else 
        v_dataOutputAssociations =  task.dataOutputAssociations;

    if(v_dataOutputAssociations != null && v_dataOutputAssociations != undefined && v_dataOutputAssociations._targetRef != undefined){
        var target_refer = _.find(process.flowElements,{"_xmi:id": v_dataOutputAssociations._targetRef });
        if (target_refer._dataStoreRef != undefined){
            var data_store = _.find(this.generator.schema_bpmn.Definitions.rootElements,{"_xmi:id": target_refer._dataStoreRef});
            var data_def = _.find(this.generator.schema_bpmn.Definitions.rootElements,{"_xmi:id": data_store._itemSubjectRef});

            // get jpa enity
            var match = data_def.structureRef._href.match(/genmymodel:\/\/(?<project_id>[\w]+)#(\/\/@)(?<tag_name>[\w]+)\.(?<index>[\d]+)/);
            //var url_data = 'https://api.genmymodel.com/projects/_yDLSMDfMEeiQp6eXyhUzBA/xmi';
            var url_data = 'https://api.genmymodel.com/projects/' + match.groups.project_id+ '/xmi';
            var schema_jpa1 = {};
            schema_jpa_enity = {};
            $.ajax({
                url: url_data  ,
                // data: {sqlid: "codegen.tables",owner: $("#owner").val()},
                async: false,
                success:  function(doc,result,response){
                    // console.log(response.responseText);
                    genmyModelxmi = response.responseText;
                    schema_jpa1 =  x2js.xml_str2json(genmyModelxmi);	
                    schema_jpa_enity = schema_jpa1.Model.ownedEntities[match.groups.index];
                }
            });	
            
            // // variable
            // target_refer.depth = task.depth;
            // target_refer.parent = task.parent;
            // dfn_detail_variable(target_refer);
            // db connection
            src = _this.fn_indent_write(indent);	src += "v_con = cx_Oracle.connect(con_str)"; _this.sources.push(src);
            src = _this.fn_indent_write(indent);	src += "v_cur = v_con.cursor()"; _this.sources.push(src);
            
            // query
            // // if delete 
            if( _.isArray(target_refer.eAnnotations.details) 
                && _.find(target_refer.eAnnotations.details,{"_key":"keyword_delete","_value":"true"}) != null )
            {
                src = _this.fn_indent_write(indent) + "v_query = '''"; _this.sources.push(src);
                src = _this.fn_indent_write(indent) + "\tdelete from " + schema_jpa_enity._name ; _this.sources.push(src);
                src = _this.fn_indent_write(indent) + "\twhere 1=1" ; _this.sources.push(src);
                // query key
                var bindings = [];
                $.each(schema_jpa_enity.properties,function(i,p){
                    if(p.annotations == undefined)
                        return true;

                    var annotations = []
                    if(_.isArray(p.annotations)){
                        annotations = p.annotations;
                    }else{
                        annotations.push(p.annotations);
                    }

                    var isId = false;
                    if( _.find(annotations,{"_xsi:type":"gmmjpa:Id"}) != null)
                        isId = true;
                    else{
                        isId = true;
                            
                    }
                    if(isId){
                        src = _this.fn_indent_write(indent) + "\tand " +"" + p._name + " = :bind_" + _.camelCase(p._name); _this.sources.push(src);
                        src = _this.fn_indent_write(indent) + "'''"; _this.sources.push(src);
                        bindings.push({name: p._name, "bind_name":"bind_" + _.camelCase(p._name) ,"src": src});
                    }

                });

                // query binding
                var basic_data = _.find(target_refer.eAnnotations.details,{"_key":"keyword_basic_data"});
                if( basic_data != null ){
                    src = _this.fn_indent_write(indent) +  basic_data._key + " = " + basic_data._value; _this.sources.push(src);
                    src = _this.fn_indent_write(indent) + "v_binding = {}"; _this.sources.push(src);
                    $.each(bindings,function(i,binding){
                        // if binding_data
                        if( basic_data != null ){
                            src = _this.fn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + basic_data._value + "['" + binding.name + "']" ; _this.sources.push(src);
                        }
                        // specific binding data
                        if( _.isArray(target_refer.eAnnotations.details)){
                            $.each(target_refer.eAnnotations.details,function(i,detail){
                                if ( detail["_key"] == "uuid")
                                    return true;
                                
                                var regex = new RegExp('^'+detail._key,'i')
                                if(binding.name.match(regex) != null ){
                                    src = _this.fn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + detail._value ; _this.sources.push(src);
                                }

                                
                            });
                        }
                    });				
                    
                }

            
                // excuete
                src = _this.fn_indent_write(indent) + "v_cur.execute(v_query ,v_binding)"; _this.sources.push(src);
                // db connection end

                // // test code
                // var match = target_refer.documentation._text.match(/<code class="language-python">(?<content>[\w\s\(\)\."\=:\r\n]+)<\/code>/);
                // if(match != null){
                // 	var indent = dfn_indent(task);
                // 	var content = match.groups.content;
                // 	var codes = content.split('\n');
                // 	for(var i=0;i<codes.length;i++){
                // 		src = dfn_indent_write(indent);
                // 		src += codes[i];
                // 		sources.push(src);
                // 	}
                // }

            }
        
            // // insert query
            if(true){
                src = _this.fn_indent_write(indent) + "v_query = '''"; _this.sources.push(src);
                src = _this.fn_indent_write(indent) + "\tinsert into  " + schema_jpa_enity._name ; _this.sources.push(src);
                src = _this.fn_indent_write(indent) + "\t(" ; _this.sources.push(src);
                // query columns
                var bindings = [];
                $.each(schema_jpa_enity.properties,function(i,p){
                    src = _this.fn_indent_write(indent) + "\t\t" + p._name + " , " ; _this.sources.push(src);
                    bindings.push({name: p._name, "bind_name":"bind_" + _.camelCase(p._name) ,"src": src});
                });
                src = _this.fn_indent_write(indent) + "\t\tins_dt " ; _this.sources.push(src);
                src = _this.fn_indent_write(indent) + "\t)" ; _this.sources.push(src);
                // query values
                src = _this.fn_indent_write(indent) + "\tvalues(" ; _this.sources.push(src);
                $.each(schema_jpa_enity.properties,function(i,p){
                    src = _this.fn_indent_write(indent) + "\t\t:bind_" + _.camelCase(p._name) + " , " ; _this.sources.push(src);
                });
                src = _this.fn_indent_write(indent) + "\t\tsysdate " ; _this.sources.push(src);
                src = _this.fn_indent_write(indent) + "\t)" ; _this.sources.push(src);
                src = _this.fn_indent_write(indent) + "'''"; _this.sources.push(src);
                // query binding
                var basic_data = null;
                if(_.isArray(target_refer.eAnnotations.details)){
                    basic_data = _.find(target_refer.eAnnotations.details,{"_key":"keyword_basic_data"});
                }
                if( basic_data != null ){
                    src = _this.fn_indent_write(indent) +  basic_data._key + " = " + basic_data._value; _this.sources.push(src);
                    src = _this.fn_indent_write(indent) + "v_binding = {}"; _this.sources.push(src);
                    $.each(bindings,function(i,binding){
                        // if binding_data
                        if( basic_data != null ){
                            src = _this.fn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + basic_data._value + "['" + binding.name + "']" ; _this.sources.push(src);
                        }
                        // specific binding data
                        if( _.isArray(target_refer.eAnnotations.details)){
                            $.each(target_refer.eAnnotations.details,function(i,detail){
                                if ( detail["_key"] == "uuid")
                                    return true;
                                
                                var regex = new RegExp('^'+detail._key + '$','i')
                                if(binding.name.match(regex) != null ){
                                    src = _this.fn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + detail._value ; _this.sources.push(src);
                                }

                                
                            });
                        }
                    });				
                }else{
                    src = _this.fn_indent_write(indent) + "v_binding = {}"; _this.sources.push(src);
                    $.each(bindings,function(i,binding){
                        // specific binding data
                        if( _.isArray(target_refer.eAnnotations.details)){
                            $.each(target_refer.eAnnotations.details,function(i,detail){
                                if ( detail["_key"] == "uuid")
                                    return true;
                                
                                var regex = new RegExp('^'+detail._key + '$','i')
                                if(binding.name.match(regex) != null ){
                                    src = _this.fn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + detail._value ; _this.sources.push(src);
                                }
                                
                            });
                        }
                    });	
                }
            }
            // excuete
            src = _this.fn_indent_write(indent) + "v_cur.execute(v_query ,v_binding)"; _this.sources.push(src);

            // query commit
            src = _this.fn_indent_write(indent);	src += "v_con.commit()"; _this.sources.push(src);
            // close 
            src = _this.fn_indent_write(indent);	src += "if v_cur:"; _this.sources.push(src);
            src = _this.fn_indent_write(indent);	src += "\tv_cur.close()"; _this.sources.push(src);
            src = _this.fn_indent_write(indent);	src += "if v_con:"; _this.sources.push(src);
            src = _this.fn_indent_write(indent);	src += "\tv_con.close()"; _this.sources.push(src);

        }
    }
}

JspGenerator.prototype.fn_detail_variable = function(task){
    var _this = this;

    // variable
    if( _.isArray(task.eAnnotations.details)){
        $.each(task.eAnnotations.details,function(i,detail){
            if ( detail["_key"] == "uuid")
                return true;
            
            var _key = detail._key;
            var _value = detail._value;
            if (_key.match(/^keyword/i) != null)
                return true;
            
            var src = "";
            
        });
    }

}

JspGenerator.prototype.fn_schema = function(task){
    var _this = this;
    
    var detail_schema_type = _.find(task.eAnnotations.details, {"_key":"schema_type"});
    var detail_schema_var = _this.fn_find_schema_var(task);    
    if( detail_schema_type != undefined){
        // head schema : Header
        // _this.fn_schema_head(_this, detail_schema_var, task, detail_schema_type);
        // default schema
        _this.fn_schema_default(detail_schema_var, task, detail_schema_type);
        // detail schema
        _this.fn_schema_custom(task);
        // width , css
        _this.fn_set_schema_properties(task);
        _this.fn_set_schema_custom_script(task);        
    }
}

JspGenerator.prototype.fn_schema_default = function(detail_schema_var, task, detail_schema_type) {
    var _this = this;
    var top_obj_schema = _.find(_this.src_schemas, { "name": detail_schema_var.detail._value });
    var taskId = task["_xmi:id"];
    var obj_schema = {
        type: detail_schema_type._value,
        id: taskId,
        name: _.camelCase(task._name + ' ' + detail_schema_type._value),
        label: '',
        text : task._name 
        
    };
    if (top_obj_schema == undefined) {
        top_obj_schema = {
            name: detail_schema_var.detail._value,
            containerId : _.camelCase(detail_schema_var.detail._value + ' Container') ,
            schema: obj_schema
        };
        
        _this.src_schemas.push(top_obj_schema);
    }
    var parent_schema_task = _this.fn_parent_schema(task);
    if (parent_schema_task != null) {
        // var parent_schema =  findAll( parent_schema_task.id, top_obj_schema.schema );
        var parent_schema = _this.generator.findAllFromObject(parent_schema_task.id, top_obj_schema.schema);
        if (parent_schema.elements == undefined )
            parent_schema.elements = [];
        parent_schema.elements.push(obj_schema);
    }
    
}

JspGenerator.prototype.fn_schema_custom = function( task) {
    var _this = this;

    if ( !_.isArray(task.eAnnotations.details))
        return;
    
    // find schema
    var detail_schema_var = _this.fn_find_schema_var(task); 
    var top_obj_schema = _.find( _this.src_schemas, {"name": detail_schema_var.detail._value});
    var obj_schema = _this.generator.findAllFromObject(task["_xmi:id"] , top_obj_schema.schema );
    if (obj_schema == undefined)
        return;

    if(obj_schema.type == 'multiCombo'){
        // multiselectOpt
        obj_schema.multiselectOpt = {
            selectedList: 1 ,
            multiple: false,
            selectedText: function(numChecked, numTotal, checkedItems){
                //return numChecked + ' of ' + numTotal + ' checked';
                var sb = [];
                $.each(checkedItems,function(){
                    sb.push($(this).val());
                });
                return sb.join(",");
            }
        };
    }
    
}

JspGenerator.prototype.fn_set_schema_properties = function(task){
    var _this = this;

    if ( !_.isArray(task.eAnnotations.details))
        return;
    
    // find schema
    var detail_schema_var = _this.fn_find_schema_var(task); 
    var top_obj_schema = _.find( _this.src_schemas, {"name": detail_schema_var.detail._value});
    var obj_schema = _this.generator.findAllFromObject(task["_xmi:id"] , top_obj_schema.schema );
    if (obj_schema == undefined)
        return;
    $.each(task.eAnnotations.details, function(i, detail){
        if( detail._key == "uuid")
            return true;
        if( detail._key == "schema_type")
            return true;
        if( detail._key == "schema_variable")
            return true;
        if (detail._key.match(/^keyword/i) != null)
            return true;
        
        
        obj_schema[detail._key] = detail._value;
    });
}

/**
 * 해당 schema 의 variable을 찾는다.
 * @param {*} task 
 */
JspGenerator.prototype.fn_find_schema_var = function(task){
    var _this = this;
    if(task == undefined)
        return undefined
    var detail_var = _.find(task.eAnnotations.details, {"_key":"schema_variable"});
    if ( detail_var != undefined){
        var obj = {
            "detail" : detail_var , 
            "task" : task
        };
        // 별도의 설정없이 variable로 조합한다.
        // var detail_container = _.find(task.eAnnotations.details, {"_key":"keyword_container"});
        // if ( detail_container != undefined )
        //     obj.container = detail_container;
        return obj;    
    }
    else 
        return _this.fn_find_schema_var(task.parent);
}

/**
 * 
 * @param {*} task 
 */
JspGenerator.prototype.fn_parent_schema = function(task){
    var _this = this;
    if(task.parent != undefined 
        && _.isArray(task.parent.eAnnotations.details) 
        && _.find(task.parent.eAnnotations.details,{"_key":"schema_type"}) != undefined
    )
        return {
            task: task.parent,
            id : task.parent["_xmi:id"] ,
            schema_type : _.find(task.parent.eAnnotations.details,{"_key":"schema_type"})._value
        };
    else
        return null;
    

}


/**
 * json 형식으로 정의함.
 * @param {*} task 
 */
JspGenerator.prototype.fn_set_schema_custom_script = function(task){
    var _this = this;
    if(task.documentation == undefined)
        return;
    // if(task._name == "regex pattern")
    //     debugger;
    var matches = task.documentation._text.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!\^\?\+\.\\\/,"'\=:;\r\n\[\]{}]+)<\/code>/g);
    if(matches){
        var detail_schema_var = _this.fn_find_schema_var(task);
        var top_obj_schema = _.find( _this.src_schemas, {"name": detail_schema_var.detail._value});
        var obj_schema = _this.generator.findAllFromObject(task["_xmi:id"] , top_obj_schema.schema );
        if (obj_schema == undefined)
            return;
        $.each(matches,function(i,m){
            var match = m.match(/<code class="language-json">(?<content>[\w\s\(\)#$&!\^\?\+\.\\\/,"'\=:;\r\n\[\]{}]+)<\/code>/);
            var content = match.groups.content;
            // var custom_obj = JSON.parse(content);            
            eval("var custom_obj = " + content)
            _.merge(obj_schema,custom_obj);
            var codes = content.split('\n');
            
        });        
    	
    }
}


JspGenerator.prototype.fn_split_string = function(task){
    var _this = this;
    if( _.isArray(task.eAnnotations.details)){
        $.each(task.eAnnotations.details,function(i,detail){
            if ( detail["_key"] == "uuid")
                return true;

            if ( detail["_key"] == "is_string_split"
                && detail["_value"] == "true"
            ){
                var indent = _this.fn_indent(task);
                src = _this.fn_indent_write(indent);
                src +="string_split_data = {\"target\": string_split_target ,  \"data\": dict(zip( string_split_info , string_split_target.split(string_split_char) ))}";
                _this.sources.push(src);

            }
        });

        
    }
}


JspGenerator.prototype.findAll = Generator.prototype.findAll;
JspGenerator.prototype.filterAll = Generator.prototype.filterAll;



JspGenerator.prototype.fn_generate = function(){
    var _this = this;
    
    
    // header
    var src = '<%@ page contentType="text/html;charset=utf-8" %>'; this.sources.push(src);
    src = '<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>'; this.sources.push(src);
    src = '<%@ page session="false" %>'; this.sources.push(src);
    src = '<!DOCTYPE html>'; this.sources.push(src);
    src = '<html>'; this.sources.push(src);
    src = '<head>'; this.sources.push(src);
    
    // includes
    _this.fn_generate_import();
    $.each(_this.src_script_include, function(i, script){
        var src = "\t" + script; + _this.sources.push(src);
    });

    //  script
    src = '\t<script>'; this.sources.push(src);
    src = '\t\tvar beforEditRow = {};'; this.sources.push(src);
    src = '\t\tvar EfContextPath = "";'; this.sources.push(src);
    _this.fn_generate_script_schema();
    src = '\t</script>'; this.sources.push(src);
    // script main
    src = '\t<script  id="script_main">'; this.sources.push(src);
    src = '\t\t$(function () {'; this.sources.push(src);
    src = '\t\t\t$("#loader").show();'; this.sources.push(src);
    src = '\t\t\tsetTimeout( function(){'; this.sources.push(src);
    // todo
    src = '\t\t\t\t'; this.sources.push(src);

    _this.fn_generate_make_html();
    

    src = '\t\t\t\t$("#loader").hide();'; this.sources.push(src);
    src = '\t\t\t},50);'; this.sources.push(src);
    src = '\t\t});'; this.sources.push(src);
    src = '\t</script>'; this.sources.push(src);

    src = '</head>'; this.sources.push(src);

    // body
    src = '<body  style="min-width:920px">'; this.sources.push(src);
    src = '<form name="form" id="form" class="">'; this.sources.push(src);
    _this.fn_generate_container();
    //  to do
    src = '</form>'; this.sources.push(src);
    src = '</body>'; this.sources.push(src);
    

}

JspGenerator.prototype.fn_generate_import = function(){
    var _this = this;
    if(_this.process.documentation != undefined){
        var matches = _this.process.documentation._text.match(/<code class="language-javascript">(?<content>[\w\s\(\)#$&!\^\?\+\.\\\/,"'\=:;\r\n\[\]{}%\-가-힣]+)<\/code>/g);
        if(matches){
            $.each(matches,function(i,m){
                var match = m.match(/<code class="language-javascript">(?<content>[\w\s\(\)#$&!\^\?\+\.\\\/,"'\=:;\r\n\[\]{}%\-가-힣]+)<\/code>/);
                var content = match.groups.content;
                var codes = content.split('\n');
                for(var i=0;i<codes.length;i++){
                    // var src = _this.fn_indent_write(1);
                    var src = codes[i];
                    var src1 = _.unescape(src);
                    _this.src_script_include.push(src1);
                }
            });        
            
        }
    }
    
}

JspGenerator.prototype.fn_generate_script_schema = function(){
    var _this = this;
    $.each(_this.src_schemas, function(i,schema){
        
        _this.generator.fuctionToString( schema.schema );
        var schema_str = JSON.stringify(schema.schema, null, '\t');
        var codes = schema_str.split('\n');
        var src = "\t\tvar " + schema.name + " = ";
        for(var i=0;i<codes.length;i++){
            
            if ( i == 0 )
                src += codes[i];
            else
                src = "\t\t" + codes[i];
            // function 
            if(src.match(/"function/)){
                var src1 = src1 = src.replace(/"function/,"function");
                var src2 = src1.substr(0, src1.length -1 );
                // var src3 = src2.replace(/\\r\\n/g,"\r\n");
                // var src3 = src3.replace(/\\n/g,"\r\n");
                //var src3 = src2.replace(/\\([\w])/g,"\$1");
                var src3 = src2.replace(/\\([\w"])/g,function(match, p1, p2, p3, offset, string){
                    if(match == "\\r")
                        return "\r";
                    if(match == "\\n")
                        return "\n";
                    if(match == "\\t")
                        return "\t";
                    if(match == "\\\"")
                        return "\"";
                });
                if(src.match(/^\t+/)){
                    var indent = src.match(/^\t+/)[0];
                    var src4 = "";
                    $.each(src3.split("\n"),function(i,str){
                        var str1 = "";
                        if( i > 0){
                            str1 = indent + str;
                        }else{
                            str1 = str;
                        }
                        src4 += str1 + "\n";

                    });
                    src = src4;
                }
                else {
                    src = src3;
                }
            }
            
            if ( i == (codes.length -1 ) ) 
                src += ';';
            _this.sources.push(src);
        }
    }) ;

}

JspGenerator.prototype.fn_generate_make_html = function(){
    var _this = this;
    $.each(_this.src_schemas, function(i,schema){
        var src = "\t\t\t\tfn_makeHtml('" + schema.containerId + "'," + schema.name+ ");"; _this.sources.push(src);
    }) ;

}

JspGenerator.prototype.fn_generate_container = function(){
    var _this = this;
    $.each(_this.src_schemas, function(i,schema){
        var src = '\t<div id="' + schema.containerId + '" style="margin-top: 10px;width: 100%;"></div>'; _this.sources.push(src);
    }) ;

}

