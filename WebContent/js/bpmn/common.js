function fn_file_open(){
    $("input#btn_file_open").trigger("click");
}

function fn_create_workflow(){
    
    // select workflow file.json
    // generate webpages in files ?
    // ... 
    // or diynamic load webpage
    // ... param2: wokflow Object
    // ... param1: workflow_id
    // ... param3: type
    
    
    
    
    
    // 01. table list
    // 02. find connections
    // 02.1. parents
    // 02.2. childs
    // 03. make search condition
    // 04. make grid
    
    
    
    
    
    // var filename= 'entity_'+ $("#owner").val();
    // var blob = new Blob([JSON.stringify(schema)], {type: "text/plain;charset=utf-8"});
    // saveAs(blob, filename+".json");


    // var newWin1 = window.open("", "MS_WordReport", "width=1200,height=800, screenY=20, top=20, screenX=100,left=100, scrollbars=yes,resizable=yes");
    
    // var oFrm = document.getElementById("formReport");
    // oFrm.searchJson.value = JSON.stringify(schema);
    
    // oFrm.action =  '/dashboard/performanceReportJson.do';
    // oFrm.method = "post";
    // oFrm.target = 'MS_WordReport';
    // oFrm.submit();		    
    // newWin1.focus();	
}

var generator
function fn_load_schema(){
    var url = $("#schemaUrl").val();
    $.ajax({
        url: url ,
        // data: {sqlid: "codegen.tables",owner: $("#owner").val()}, 
        async: false,
        success:  function(doc,result,response){
            // console.log(response.responseText);
            genmyModelxmi = response.responseText;
            schema_bpmn =  x2js.xml_str2json(genmyModelxmi);
            // fn_create_source();
            generator = new Generator(schema_bpmn,"ToolBox","mysql");
            generator.fn_source();
            // generator.fn_fileSave();
        }
    });
}


function fn_create_source(){
    // find process
    var processes = _.filter(schema_bpmn.Definitions.rootElements,{"_xsi:type": "bpmn2:Process"});			
    $.each(processes,function(i,process){
        fn_start(process);
    });
    
    fn_source();

}

// return start in process flowElements 
function fn_start(process){
    var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
    var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
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
        // v_files[process["file_name"]].contents.push(content);
    }
    target_task.is_start = true;
    fn_task(process,target_task);
}

function fn_start_detail(process){
    var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
    var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
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
        v_files[process["file_name"]].contents.push(content);
    }
    fn_task_detail(process,target_task);
}

function fn_task(process, task){
    task.parent = process;
    // subprocess . file create
    if( _.isArray(task.eAnnotations.details) 
        && _.find(task.eAnnotations.details,{"_key":"file_type"}) != undefined
        && process["file_name"] == undefined
    ){
            var file_name = _.find(task.eAnnotations.details,{"_key":"file_name"})._value;
            var file_path = _.find(task.eAnnotations.details,{"_key":"file_path"})._value;
            var file_path_type = _.find(task.eAnnotations.details,{"_key":"file_path_type"})._value;
            task.file_name = file_name;

            v_files[file_name] = {};
            v_files[file_name].process = task;
            v_files[file_name].file_path = file_path;
            v_files[file_name].file_path_type = file_path_type;
            v_files[file_name].contents = [];
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
        v_files[process["file_name"]].contents.push(content);
    }

    
    // file name
    if(process["file_name"] != undefined){
        task.file_name = process["file_name"];
    } 			
    
    // subProces			
    if(task.flowElements != undefined){
        // task.parent = process;
        fn_start(task);
    }

    
    
    // end Process
    if(task["_outgoing"] == undefined){
        return;
    }
        

    // --- next task ------- //
    // sequence
    // var sequence = _.find(process.flowElements,{"_xmi:id": task["_outgoing"]});
    var sequences = _.filter(process.flowElements,function(el){
        if(task["_outgoing"].match(el["_xmi:id"]) != null )
            return true;
    });
    $.each(sequences,function(i,sequence){
        if(process.depth != undefined){
            sequence.parent = process;
            sequence.depth = process.depth + 1;
        }
            
        fn_process_sequence(process, task, sequence);

        var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
        if(process.depth != undefined)
            target_task.depth = process.depth + 1;
        fn_task(process,target_task);
    });
    
}

function fn_task_detail(process, task){
    task.parent = process;
    // subprocess . file create
    if( _.isArray(task.eAnnotations.details) 
        && _.find(task.eAnnotations.details,{"_key":"file_type"}) != undefined
        && process["file_name"] == undefined
    ){

            var file_name = _.find(task.eAnnotations.details,{"_key":"file_name"})._value;
            var file_path = _.find(task.eAnnotations.details,{"_key":"file_path"})._value;
            var file_path_type = _.find(task.eAnnotations.details,{"_key":"file_path_type"})._value;
            task.file_name = file_name;
            v_files[file_name] = {};
            v_files[file_name].file_path = file_path;
            v_files[file_name].file_path_type = file_path_type;
            v_files[file_name].contents = [];
            task.depth = -1;
            

    }
    
    // detail properties
    if( _.isArray(task.eAnnotations.details) 
        && _.find(task.eAnnotations.details,{"_key":"file_type"}) == undefined
        && process["file_name"] != undefined
    ){

        $.each(task.eAnnotations.details,function(i,detail){
            if ( detail["_key"] == "uuid")
                return true;
            
            var content = {						
                task: task,
                "depth": task.depth,
                "detail": detail						
                //"variable": detail["_key"],
                //"value": detail["_value"]
            };
            content.variable = detail["_key"] + fn_depth(task,detail);
            content.value = fn_keyward_variable(process, detail);

            v_files[process["file_name"]].contents.push(content);
        });

    }

    
    // file name
    if(process["file_name"] != undefined){
        task.file_name = process["file_name"];
    } 
    
    // loop start
    if(_.isArray(task.eAnnotations.details)
        && _.find(task.eAnnotations.details,{"_key":"loop_condition"}) != undefined
    ){
        var content = {
            task: task,
            "depth": task.depth,
            is_loop: true,
            loop_start : true,
            loop_end : false,
            "variable": "v_loop" + fn_depth(task),
            "value": _.find(task.eAnnotations.details,{"_key":"loop_condition"})._value
        };
        v_files[process["file_name"]].contents.push(content);
    }
    // subProces			
    if(task.flowElements != undefined){
        // task.parent = process;
        fn_start_detail(task);
    }

    // data assosiation  datastore target
    if(task.dataOutputAssociations != undefined && task.dataOutputAssociations._targetRef != undefined){
        var target_refer = _.find(process.flowElements,{"_xmi:id": task.dataOutputAssociations._targetRef });
        if (target_refer._dataStoreRef != undefined){
            var data_store = _.find(schema_bpmn.Definitions.rootElements,{"_xmi:id": target_refer._dataStoreRef});
            var data_def = _.find(schema_bpmn.Definitions.rootElements,{"_xmi:id": data_store._itemSubjectRef});
            var content = {
                task: task,
                "depth": task.depth
            };
            content.data_store = data_store;
            content.data_def = data_def;

            // get jpa enity
            var match = data_def.structureRef._href.match(/genmymodel:\/\/(?<project_id>[\w]+)#(\/\/@)(?<tag_name>[\w]+)\.(?<index>[\d]+)/);
            //var url_data = 'https://api.genmymodel.com/projects/_yDLSMDfMEeiQp6eXyhUzBA/xmi';
            var url_data = 'https://api.genmymodel.com/projects/' + match.groups.project_id+ '/xmi';
            var schema_jpa1 = {};
            $.ajax({
                url: url_data  ,
                // data: {sqlid: "codegen.tables",owner: $("#owner").val()},
                async: false,
                success:  function(doc,result,response){
                    // console.log(response.responseText);
                    genmyModelxmi = response.responseText;
                    schema_jpa1 =  x2js.xml_str2json(genmyModelxmi);	
                    content.schema_jpa = schema_jpa1;
                    content.schema_jpa_enity = schema_jpa1.Model.ownedEntities[match.groups.index];
                }
            });					
            v_files[process["file_name"]].contents.push(content);
        }
    }

    // loop end
    if(_.isArray(task.eAnnotations.details)
        && _.find(task.eAnnotations.details,{"_key":"loop_condition"}) != undefined
    ){
        var content = {
            task: task,
            "depth": task.depth,
            is_loop: true,
            loop_start : false,
            loop_end : true,
            "variable": "v_loop" + fn_depth(task),
            "value": _.find(task.eAnnotations.details,{"_key":"loop_condition"})._value
        };
        v_files[process["file_name"]].contents.push(content);
    }
    
    // end Process
    if(task["_outgoing"] == undefined){
        if (process["file_name"] != undefined ){
            var content = {						
                "task": task,
                "depth": task.depth,
                // "detail": detail,
                "is_end": true
            };
            v_files[process["file_name"]].contents.push(content);
        }				
        return;
    }
        

    // --- next task ------- //
    // sequence
    var sequence = _.find(process.flowElements,{"_xmi:id": task["_outgoing"]});
    if(process.depth != undefined)
        sequence.depth = process.depth + 1;
    fn_process_sequence_detail(process, task, sequence);

    var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
    if(process.depth != undefined)
        target_task.depth = process.depth + 1;
    fn_task_detail(process,target_task);
}

function fn_process_sequence(process,task,sequence, _indent){
    var indent = fn_indent(task);
    if (_indent != undefined)
        indent = _indent;

    // detail properties
    if( _.isArray(sequence.eAnnotations.details) 
        && _.find(sequence.eAnnotations.details,{"_key":"file_type"}) == undefined
        && process["file_name"] != undefined
    ){
        var content = {						
            "gateway": task,
            "task": sequence 
        };
        v_files[process["file_name"]].contents.push(content);

        if(task["_xsi:type"] == "bpmn2:ExclusiveGateway"
            && _.find(sequence.eAnnotations.details,{"_key":"check_type"}) != undefined
            && _.find(sequence.eAnnotations.details,{"_key":"check_type"})["_value"] == "file_exists"
            && _.find(sequence.eAnnotations.details,{"_key":"compare"}) != undefined
            && _.find(sequence.eAnnotations.details,{"_key":"compare"})["_value"] == "equal"
        ){
            //var src = fn_indent_write(indent); src += "# ExclusiveGateway";  sources.push(src);
        }

    }
    
}

function fn_process_sequence_detail(process,task,sequence){
    // detail properties
    if( _.isArray(sequence.eAnnotations.details) 
        && _.find(sequence.eAnnotations.details,{"_key":"file_type"}) == undefined
        && process["file_name"] != undefined
    ){

        $.each(sequence.eAnnotations.details,function(i,detail){
            if ( detail["_key"] == "uuid")
                return true;
            
            var content = {											
                "task": sequence,
                "is_sequence": true,
                "depth": sequence.depth,
                "detail": detail						
            };
            content.variable = detail["_key"] + fn_depth(sequence,detail);
            content.value = fn_keyward_variable(process, detail);

            v_files[process["file_name"]].contents.push(content);
        });
        
        if(task["_xsi:type"] == "bpmn2:ExclusiveGateway"
            && _.find(sequence.eAnnotations.details,{"_key":"check_type"}) != undefined
            && _.find(sequence.eAnnotations.details,{"_key":"check_type"})["_value"] == "file_exists"
            && _.find(sequence.eAnnotations.details,{"_key":"compare"}) != undefined
            && _.find(sequence.eAnnotations.details,{"_key":"compare"})["_value"] == "equal"
        ){
            
        }

    }
    
}

function fn_create_file(){

}

function fn_create_file_python(){

}

function fn_keyward_variable(process, detail){
    
    rtn = detail._value;

    

    if(detail._key == "path"){
        // defined process 
        if( _.isArray(process.eAnnotations.details)
            && _.find(process.eAnnotations.details,{"_key":"path"}) != undefined
        ){
            rtn = "";
            rtn = _.find(process.eAnnotations.details,{"_key":"path"})._key + fn_depth(process,detail);					
            // rtn += "+\"/\" + ";
            // check parent is loop
            // if( true
            // 	// && process.parent != undefined 
            // 	// && _.isArray(process.parent.eAnnotations.details)
            // 	// && _.find(process.parent.eAnnotations.details,{"_key":"loop_condition"}) != undefined){
            // 	&& _.find(process.eAnnotations.details,{"_key":"loop_condition"}) != undefined){
            // 	 rtn += " + \"/\" + " + "v_loop" + fn_depth(process) ;
            // }
            rtn += " + \"/\" +  " + detail._value  ;					
            // return rtn;
        }
        // find parent
        else if( process.parent != undefined){
            // return fn_keyward_variable(process.parent,detail);
            rtn = fn_keyward_variable(process.parent,detail);
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
            rtn = fn_keyward_variable(process.parent,detail);
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
                if( _.isArray(process.eAnnotations.details)
                    && _.find(process.eAnnotations.details,{"_key":"path"}) != undefined
                ){
                    rtn = rtn.replace(/\bpath\b/,"path" + fn_depth(process) );
                }
                // find parent
                else if( process.parent != undefined){
                    rtn = fn_keyward_variable(process.parent,detail);
                }
            }else{ // current
                
                
                var flows = [];
                var dfn1_start = function(_process){
                    var _start = _.find(_process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
                    var _sequence = _.find(_process.flowElements,{"_xmi:id": _start["_outgoing"]});
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
                    var sequences = _.filter(_process.flowElements,function(el){
                        if(_task["_outgoing"].match(el["_xmi:id"]) != null )
                            return true;
                    });
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
                        v_path = _.find(flow.eAnnotations.details,{"_key":"path"});
                        if(v_path != undefined)
                            rtn = "path" + fn_depth(flow,v_path);
                    }
                });
                rtn = rtn.replace(/\bpath\b/,"path" + fn_depth(process) );
            
            }
            
            
            
        }
    }
    
    

    return rtn;
}



function fn_depth(task,detail){
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

function fn_source(){
    $.each(v_files,function(k,v){
        if( _.isArray(v.process.eAnnotations.details) 
            && _.find(v.process.eAnnotations.details,{"_key":"file_type"})._value == "python"){
            fn_source_python(k,v);
        }
    });

    fn_fileSave();

}

function fn_fileSave(){
    $.each(v_files,function(k,v){
        var blob = new Blob([v.sources.join("\r\n")], {type: "text/plain;charset=utf-8"});
        saveAs(blob,k);
    });
}
function fn_indent(task){
    var process_tree = [];
    var fn_process_tree = function(_task){
        if(_task.depth == -1)
            return;
        else{
            process_tree.unshift(_task);
            fn_process_tree(_task.parent);
        }
    };				
    fn_process_tree(task);
    
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
    }

    return indent;
}
function fn_indent_write (indent){
    var src = "";
    for(var j = 0; j < indent ; j++ )
        src += "\t";
    return src ;
}
