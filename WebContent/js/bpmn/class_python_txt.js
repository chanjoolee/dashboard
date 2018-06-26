/**
 * text file parsing
 * @param {*} task 
 */
PythonGenerator.prototype.fn_txt_file_parsing = function(task){
    var _this = this;    

    var fn_detail_variable = function(task){
        var indent = _this.fn_indent(task);
        
        var fn_make_pattern = function(task){
            var src = "";
            if ( task.parent.keyword_use_expression == true){
                    
                var detail_key  = _.find(task.eAnnotations.details,{"_key":"name"});
                var detail_regex  = _.find(task.eAnnotations.details,{"_key":"regex"});
                if ( detail_key != null ){
                    src = _this.fn_indent_write(indent); src += "v_pattern_str  += '(?P<" + detail_key._value +  ">'" ;  _this.sources.push(src);
                    src = _this.fn_indent_write(indent); src += "v_pattern_str  += '" + detail_regex._value + ")'" ;
                }else{
                    src = _this.fn_indent_write(indent); src += "v_pattern_str  += '" + detail_regex._value + "'" ;
                }
                _this.sources.push(src);				
            }
        };

        if( _.isArray(task.eAnnotations.details) ){
            fn_make_pattern(task);
        }
        
    };
    var fn_make_pattern1 = function(task){					
        var indent = _this.fn_indent(task) ;
        if( _.isArray(task.eAnnotations.details) ){
            var v_use_expression = _.find(task.eAnnotations.details,{"_key":"keyword_use_expression"});
            if(v_use_expression != undefined && v_use_expression != null && v_use_expression._value == "true")
                task.keyword_use_expression = true;
        }
        if ( task.keyword_use_expression == true){
            var src = _this.generator.fn_indent_write(indent); src += "v_pattern_str  = ''" ; _this.sources.push(src);
        }
    };
    var fn_make_pattern2 = function(task){					
        var indent = _this.fn_indent(task);
        var src = "";
        if ( task.keyword_use_expression == true){
            src = _this.generator.fn_indent_write(indent); src += "# " + task._name + " : pattern" ;  _this.sources.push(src);
            src = _this.generator.fn_indent_write(indent); src += "v_pattern = re.compile(v_pattern_str)";  _this.sources.push(src);
            src = _this.generator.fn_indent_write(indent); src += "v_match = v_pattern.search(line)";  _this.sources.push(src);
            src = _this.generator.fn_indent_write(indent); src += "if v_match:";  _this.sources.push(src);
            src = _this.generator.fn_indent_write(indent + 1); src += "v_dic = v_match.groupdict()";  _this.sources.push(src);
        }
        
    };
    var fn_start = function(process){
        var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
        // var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
        var sequence = _this.findAll(start["_outgoing"], _this.process.flowElements);
        var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
        fn_task(process,target_task);
    };

    var fn_task = function(process,task){
        _this.fn_comment(task);
        
        // use expression
        fn_make_pattern1(task);
        fn_detail_variable(task);
        if(task.flowElements != undefined){
            fn_start(task);
        }
        fn_make_pattern2(task);
        var v_indent = _this.fn_indent(task) + 1;
        _this.fn_data_output(task, v_indent);

        // end Process
        if(task["_outgoing"] == undefined){
            return;
        }

        // --- next task ------- //
        // sequence
        // var sequence = _.find(process.flowElements,{"_xmi:id": task["_outgoing"]});
        // dfn_process_sequence(process, task, sequence);
        // var sequences = _.filter(process.flowElements,function(el){
        //     if(task["_outgoing"].match(el["_xmi:id"]) != null )
        //         return true;
        // });
        var sequences = _this.filterAll(task["_outgoing"], _this.process.flowElements);
        $.each(sequences,function(i,sequence){
            var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
            fn_task(process,target_task);
        });
        
    };

    if( _.isArray(task.eAnnotations.details)){
        
        var openFile = _.find(task.eAnnotations.details,{"_key":"keyword_open_file"});
        var ext = _.find(task.eAnnotations.details,{"_key":"keyword_file_ext"});
        if ( openFile != null && ext != null && ext._value == 'txt'){
            var indent = _this.fn_indent(task);
            var filePath = _.find(task.eAnnotations.details,{"_key":"keyword_file_path"});						
            var src = _this.fn_indent_write(indent) + "f = open(" + _this.fn_keyword_variable( task, filePath ) + ", 'r')" ; _this.sources.push(src);
            src = _this.fn_indent_write(indent) + "for line in f:" ; _this.sources.push(src);						
            if(task.flowElements != undefined){
                fn_start(task);
            }
            var src = _this.fn_indent_write(indent) + "f.close()" ; _this.sources.push(src);
        }
        
    }


}