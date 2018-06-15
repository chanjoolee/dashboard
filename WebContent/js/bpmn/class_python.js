function PythonGenerator(file_name, _generator){
    var _this = this;
    this.generator = _generator;
    this.file_name = file_name;
    this.processes = this.generator.processes;
    this.process = this.generator.files[this.file_name].process;
    this.sources = [];    
    this.init();
}

PythonGenerator.prototype.init = function(){
    var _this = this;
    this.fn_comment(this.process);
    this.fn_custom_script(this.process);
    this.fn_start(this.process);
}

PythonGenerator.prototype.fn_depth = Generator.prototype.fn_depth;
PythonGenerator.prototype.fn_loop = function(task){
    var _this = this;
    if( _.isArray(task.eAnnotations.details)
        && _.find(task.eAnnotations.details,{"_key":"loop_condition"}) != undefined
    ){
        src = "";
        // indent
        var indent = _this.fn_indent(task);
        for(var j = 0; j < indent ; j++ )
            src += "\t";
        
        variable = "v_loop" + _this.fn_depth(task);
        var detail = _.find(task.eAnnotations.details,{"_key":"loop_condition"});
        value = detail._value;
        value = fn_keyward_variable(task,_.find(task.eAnnotations.details,{"_key":"loop_condition"}));
        src += "for " + variable + " in " + value + ":";
        // src += "for " + variable + " in loop_condition:";
        this.sources.push(src);
    }
};

/**
 * indicate if pre task is exclusive gate
 * @param {*} _task 
 */
PythonGenerator.prototype.fn_pre_exgate = function(_task){
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

/**
 * return if parent task declare opeing text file.
 * @param {*} _task 
 */
PythonGenerator.prototype.fn_parent_open_txt = function(_task){
    var _this = this;
    if( _.isArray(_task.parent.eAnnotations.details) 
        && _.find(_task.parent.eAnnotations.details,{"_key":"keyword_open_file"}) != undefined
        && _.find(_task.parent.eAnnotations.details,{"_key":"keyword_file_ext"}) != undefined
        && _.find(_task.parent.eAnnotations.details,{"_key":"keyword_file_ext"})._value == "txt"
    ){
        return _task.parent;
    }
    return null;
}

PythonGenerator.prototype.fn_keyword_variable = Generator.prototype.fn_keyword_variable;
PythonGenerator.prototype.fn_indent = function(task){
    var _this = this;
    var process_tree = [];
    var dfn_process_tree = function(_task){
        // console.log(_task);
        if(_task.depth == -1)
            return;
        else{
            process_tree.unshift(_task);
            dfn_process_tree(_task.parent);
        }
    };

    dfn_process_tree(task);
    var indent = 0;
    for( var i=1; i < process_tree.length ; i++){
        var _task = process_tree[i];
        var _parent = process_tree[i-1]
        if(i==0)
            continue;					
        if( _.isArray(_parent.eAnnotations.details) 
            && _.find(_parent.eAnnotations.details,{"_key":"loop_condition"}) != undefined
        ){
            indent++;
        }
        
        var v_pre_exgate = this.fn_pre_exgate(_task);					
        if( v_pre_exgate != null) indent++;
        var v_parent_txt = this.fn_parent_open_txt(_task);					
        if( v_parent_txt != null) indent++;
        
    }

    return indent;
}

PythonGenerator.prototype.fn_indent_write = Generator.prototype.fn_indent_write;

PythonGenerator.prototype.fn_start = function(process){
    var _this = this;
    var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
    // var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
    var sequence = this.findAll(start["_outgoing"], _this.process.flowElements);
    var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
    this.fn_task(process,target_task);
}

PythonGenerator.prototype.fn_process_sequence = function(process,task,sequence, _indent){
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
PythonGenerator.prototype.fn_task = function(process,task){
    var _this = this;
    this.fn_comment(task);
    this.fn_detail_variable(task);    
    this.fn_split_string(task);
    this.fn_txt_file_parsing(task);
    this.fn_custom_script(task);
    this.fn_loop(task);
    
    if(task.flowElements != undefined){
        // task.parent = process;
        var keyword_subtask_skip = _.find(task.eAnnotations.details,{"_key":"keyword_subtask_skip"});
        if ( keyword_subtask_skip == undefined ||  keyword_subtask_skip == null || keyword_subtask_skip._value != "true" )
            _this.fn_start(task);
    }			

    _this.fn_data_output(task);

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
        _this.fn_detail_variable(sequence);
        _this.fn_process_sequence(process, task, sequence);
        var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
        _this.fn_task(process,target_task);

    });
    
}

PythonGenerator.prototype.fn_comment = function(task){
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

PythonGenerator.prototype.fn_data_output = function(task, _indent){
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
                src = _this.fn_indent_write(indent) + "cur.execute(v_query ,v_binding)"; _this.sources.push(src);
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
            src = _this.fn_indent_write(indent) + "cur.execute(v_query ,v_binding)"; _this.sources.push(src);

            // query commit
            src = _this.fn_indent_write(indent);	src += "con.commit()"; _this.sources.push(src);
            // close 
            src = _this.fn_indent_write(indent);	src += "if cur:"; _this.sources.push(src);
            src = _this.fn_indent_write(indent);	src += "\tcur.close()"; _this.sources.push(src);
            src = _this.fn_indent_write(indent);	src += "if con:"; _this.sources.push(src);
            src = _this.fn_indent_write(indent);	src += "\tcon.close()"; _this.sources.push(src);

        }
    }
}

PythonGenerator.prototype.fn_detail_variable = function(task){
    var _this = this;
    
    // variable
    if( _.isArray(task.eAnnotations.details)){
        $.each(task.eAnnotations.details,function(i,detail){
            if ( detail["_key"] == "uuid")
                return true;
            
            var _key = detail._key;
            if (_key.match(/^keyword/i) != null)
                return true;

            var src = "";
            // indent
            var indent = _this.fn_indent(task);
            src += _this.fn_indent_write(indent);
            // for(var j = 0; j < indent ; j++ )
            // 	src += "\t";
            
            variable = detail["_key"] + _this.fn_depth(task,detail);
            value = _this.fn_keyword_variable(task, detail);
            if( value.match(/true/i) != null)
                value = "True";
            if( value.match(/false/i) != null)
                value = "False";

            src += variable + " = " + value;
            _this.sources.push(src);
            // dfn_split_string(task,detail);
            
        });
    }

}

PythonGenerator.prototype.fn_custom_script = function(task){
    var _this = this;
    if(task.documentation == undefined)
        return;
    // if(task._name == "regex pattern")
    //     debugger;
    var match = task.documentation._text.match(/<code class="language-python">(?<content>[\w\s\(\)#$&!\^\?\+\.\\\/,"'\=:;\r\n\[\]]+)<\/code>/);
    if(match != null){
    	var indent = _this.fn_indent(task);
    	var content = match.groups.content;
    	var codes = content.split('\n');
    	for(var i=0;i<codes.length;i++){
    		var src = _this.fn_indent_write(indent);
    		src += codes[i];
    		_this.sources.push(src);
    	}
    }
}


PythonGenerator.prototype.fn_split_string = function(task){
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


PythonGenerator.prototype.findAll = Generator.prototype.findAll;
PythonGenerator.prototype.filterAll = Generator.prototype.filterAll;