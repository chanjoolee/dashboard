function fn_source_python(file_name){
	var sources = [];			
	v_files[file_name]['sources'] = sources;
	var top_resource = v_files[file_name];

	var dfn_indent = function(task){
		var process_tree = [];
		var dfn_process_tree = function(_task){
			if(_task.depth == -1)
				return;
			else{
				process_tree.unshift(_task);
				dfn_process_tree(_task.parent);
			}
		};

		var dfn_pre_exgate = function(_task){
			var v_income = _task["_incoming"];
			if ( v_income != undefined){
				var pre_sequence = _.find(_task.parent.flowElements, {"_xmi:id": v_income});
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
		};

		var dfn_parent_open_txt = function(_task){
			if( _.isArray(_task.parent.eAnnotations.details) 
				&& _.find(_task.parent.eAnnotations.details,{"_key":"keyword_open_file"}) != undefined
				&& _.find(_task.parent.eAnnotations.details,{"_key":"keyword_file_ext"}) != undefined
				&& _.find(_task.parent.eAnnotations.details,{"_key":"keyword_file_ext"})._value == "txt"
			){
				return _task.parent;
			}
			return null;
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
			
			var v_pre_exgate = dfn_pre_exgate(_task);					
			if( v_pre_exgate != null) indent++;
			var v_parent_txt = dfn_parent_open_txt(_task);					
			if( v_parent_txt != null) indent++;
			
		}

		return indent;
	};
	var dfn_indent_write = function(indent){
		var src = "";
		for(var j = 0; j < indent ; j++ )
			src += "\t";
		return src ;
	};
	
	var dfn_split_string = function(task){
		if( _.isArray(task.eAnnotations.details)){
			$.each(task.eAnnotations.details,function(i,detail){
				if ( detail["_key"] == "uuid")
					return true;

				if ( detail["_key"] == "is_string_split"
					&& detail["_value"] == "true"
				){
					var indent = dfn_indent(task);
					//
					// var src =  dfn_indent_write(indent);
					// src += "string_split_data = {}"
					// sources.push(src);
					//
					// var src =  dfn_indent_write(indent);
					// src += "if is_string_split == True:"
					// sources.push(src);
					//
					src = dfn_indent_write(indent);
					src +="string_split_data = {\"target\": string_split_target ,  \"data\": dict(zip( string_split_info , string_split_target.split(string_split_char) ))}";
					sources.push(src);

				}
			});

			
		}
		
	}

	var dfn_detail_variable = function(task){
		if( _.isArray(task.eAnnotations.details)){
			$.each(task.eAnnotations.details,function(i,detail){
				if ( detail["_key"] == "uuid")
					return true;
				
				var _key = detail._key;
				if (_key.match(/^keyword/i) != null)
					return true;

				src = "";
				// indent
				var indent = dfn_indent(task);
				src += dfn_indent_write(indent);
				// for(var j = 0; j < indent ; j++ )
				// 	src += "\t";
				
				variable = detail["_key"] + fn_depth(task,detail);
				value = fn_keyward_variable(task.parent, detail);
				if( value.match(/true/i) != null)
					value = "True";
				if( value.match(/false/i) != null)
					value = "False";

				src += variable + " = " + value;
				sources.push(src);
				// dfn_split_string(task,detail);

				
			});
		}
	};
	
	var dfn_loop = function(task){
		if( _.isArray(task.eAnnotations.details)
			&& _.find(task.eAnnotations.details,{"_key":"loop_condition"}) != undefined
		){
			src = "";
			// indent
			var indent = dfn_indent(task);
			for(var j = 0; j < indent ; j++ )
				src += "\t";
			
			variable = "v_loop" + fn_depth(task);
			var detail = _.find(task.eAnnotations.details,{"_key":"loop_condition"});
			value = detail._value;
			value = fn_keyward_variable(task,_.find(task.eAnnotations.details,{"_key":"loop_condition"}));
			src += "for " + variable + " in " + value + ":";
			// src += "for " + variable + " in loop_condition:";
			sources.push(src);
		}
	};

	var dfn_comment = function(task){
		src = "";
		// indent
		var indent = dfn_indent(task);
		for(var j = 0; j < indent ; j++ )
			src += "\t";
		src += "# ";
		if (task["_name"] != undefined)
			src += task["_name"];
		else{
			src += task["_xsi:type"];
		}
		sources.push(src);
	};

	var dfn_data_output = function(task, _indent){
		var process = task.parent;
		// data assosiation  datastore target
		var v_dataOutputAssociations = null;

		var indent = dfn_indent(task);
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
				var data_store = _.find(schema_bpmn.Definitions.rootElements,{"_xmi:id": target_refer._dataStoreRef});
				var data_def = _.find(schema_bpmn.Definitions.rootElements,{"_xmi:id": data_store._itemSubjectRef});

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
				src = dfn_indent_write(indent);	src += "v_con = cx_Oracle.connect(con_str)"; sources.push(src);
				src = dfn_indent_write(indent);	src += "v_cur = v_con.cursor()"; sources.push(src);
				
				// query
				// // if delete 
				if( _.isArray(target_refer.eAnnotations.details) 
					&& _.find(target_refer.eAnnotations.details,{"_key":"keyword_delete","_value":"true"}) != null )
				{
					src = dfn_indent_write(indent) + "v_query = '''"; sources.push(src);
					src = dfn_indent_write(indent) + "\tdelete from " + schema_jpa_enity._name ; sources.push(src);
					src = dfn_indent_write(indent) + "\twhere 1=1" ; sources.push(src);
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
							src = dfn_indent_write(indent) + "\tand " +"" + p._name + " = :bind_" + _.camelCase(p._name); sources.push(src);
							src = dfn_indent_write(indent) + "'''"; sources.push(src);
							bindings.push({name: p._name, "bind_name":"bind_" + _.camelCase(p._name) ,"src": src});
						}

					});

					// query binding
					var basic_data = _.find(target_refer.eAnnotations.details,{"_key":"keyword_basic_data"});
					if( basic_data != null ){
						src = dfn_indent_write(indent) +  basic_data._key + " = " + basic_data._value; sources.push(src);
						src = dfn_indent_write(indent) + "v_binding = {}"; sources.push(src);
						$.each(bindings,function(i,binding){
							// if binding_data
							if( basic_data != null ){
								src = dfn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + basic_data._value + "['" + binding.name + "']" ; sources.push(src);
							}
							// specific binding data
							if( _.isArray(target_refer.eAnnotations.details)){
								$.each(target_refer.eAnnotations.details,function(i,detail){
									if ( detail["_key"] == "uuid")
										return true;
									
									var regex = new RegExp('^'+detail._key,'i')
									if(binding.name.match(regex) != null ){
										src = dfn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + detail._value ; sources.push(src);
									}

									
								});
							}
						});				
						
					}

				
					// excuete
					src = dfn_indent_write(indent) + "cur.execute(v_query ,v_binding)"; sources.push(src);
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
					src = dfn_indent_write(indent) + "v_query = '''"; sources.push(src);
					src = dfn_indent_write(indent) + "\tinsert into  " + schema_jpa_enity._name ; sources.push(src);
					src = dfn_indent_write(indent) + "\t(" ; sources.push(src);
					// query columns
					var bindings = [];
					$.each(schema_jpa_enity.properties,function(i,p){
						src = dfn_indent_write(indent) + "\t\t" + p._name + " , " ; sources.push(src);
						bindings.push({name: p._name, "bind_name":"bind_" + _.camelCase(p._name) ,"src": src});
					});
					src = dfn_indent_write(indent) + "\t\tins_dt " ; sources.push(src);
					src = dfn_indent_write(indent) + "\t)" ; sources.push(src);
					// query values
					src = dfn_indent_write(indent) + "\tvalues(" ; sources.push(src);
					$.each(schema_jpa_enity.properties,function(i,p){
						src = dfn_indent_write(indent) + "\t\t:bind_" + _.camelCase(p._name) + " , " ; sources.push(src);
					});
					src = dfn_indent_write(indent) + "\t\tsysdate " ; sources.push(src);
					src = dfn_indent_write(indent) + "\t)" ; sources.push(src);
					src = dfn_indent_write(indent) + "'''"; sources.push(src);
					// query binding
					var basic_data = null;
					if(_.isArray(target_refer.eAnnotations.details)){
						basic_data = _.find(target_refer.eAnnotations.details,{"_key":"keyword_basic_data"});
					}
					if( basic_data != null ){
						src = dfn_indent_write(indent) +  basic_data._key + " = " + basic_data._value; sources.push(src);
						src = dfn_indent_write(indent) + "v_binding = {}"; sources.push(src);
						$.each(bindings,function(i,binding){
							// if binding_data
							if( basic_data != null ){
								src = dfn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + basic_data._value + "['" + binding.name + "']" ; sources.push(src);
							}
							// specific binding data
							if( _.isArray(target_refer.eAnnotations.details)){
								$.each(target_refer.eAnnotations.details,function(i,detail){
									if ( detail["_key"] == "uuid")
										return true;
									
									var regex = new RegExp('^'+detail._key + '$','i')
									if(binding.name.match(regex) != null ){
										src = dfn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + detail._value ; sources.push(src);
									}

									
								});
							}
						});				
					}else{
						src = dfn_indent_write(indent) + "v_binding = {}"; sources.push(src);
						$.each(bindings,function(i,binding){
							// specific binding data
							if( _.isArray(target_refer.eAnnotations.details)){
								$.each(target_refer.eAnnotations.details,function(i,detail){
									if ( detail["_key"] == "uuid")
										return true;
									
									var regex = new RegExp('^'+detail._key + '$','i')
									if(binding.name.match(regex) != null ){
										src = dfn_indent_write(indent) + "v_binding['" + binding.bind_name + "'] = " + detail._value ; sources.push(src);
									}
									
								});
							}
						});	
					}
				}
				// excuete
				src = dfn_indent_write(indent) + "cur.execute(v_query ,v_binding)"; sources.push(src);

				// query commit
				src = dfn_indent_write(indent);	src += "con.commit()"; sources.push(src);
				// close 
				src = dfn_indent_write(indent);	src += "if cur:"; sources.push(src);
				src = dfn_indent_write(indent);	src += "\tcur.close()"; sources.push(src);
				src = dfn_indent_write(indent);	src += "if con:"; sources.push(src);
				src = dfn_indent_write(indent);	src += "\tcon.close()"; sources.push(src);

			}
		}
	}

	var dfn_process_sequence = function(process,task,sequence, _indent){
		var indent = dfn_indent(task);
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
				&& _.find(sequence.eAnnotations.details,{"_key":"keyword_check_type"}) != undefined
				&& _.find(sequence.eAnnotations.details,{"_key":"keyword_check_type"})["_value"] == "file_exists"
			){
				var src = fn_indent_write(dfn_indent(sequence)); src += "# ExclusiveGateway";  sources.push(src);
				dfn_detail_variable(sequence);
				var detail_path = _.find(sequence.eAnnotations.details, {"_key":"path"});
				if( detail_path != null){ 
					// var path = "path" + fn_depth(task,detail_path);
					
					var path = fn_keyward_variable(task, detail_path );
					src = dfn_indent_write(dfn_indent(sequence)); src += "if os.path.isfile(" + path + ") == True:"; sources.push(src);
				}
			}else if( task["_xsi:type"] == "bpmn2:ExclusiveGateway"
				&& _.find(sequence.eAnnotations.details,{"_key":"keyword_check_type"}) != undefined
				&& _.find(sequence.eAnnotations.details,{"_key":"keyword_check_type"})["_value"] == "file_pattern_match"
			){
				var src = fn_indent_write(dfn_indent(sequence)); src += "# ExclusiveGateway";  sources.push(src);
				dfn_detail_variable(sequence);
			}

		}
		
	};

	var dfn_txt_file_parsing = function(task){
		var v_keyword = {};
		
		var dfn1_comment = function(task){
			src = "";
			// indent
			var indent = dfn_indent(task);
			src += dfn_indent_write(indent);
			src += "# " + task["_name"];
			sources.push(src);
		};
	
		var dfn1_detail_variable = function(task){
			var indent = dfn_indent(task);
			
			var dfn2_make_pattern = function(task){
				if ( task.parent.keyword_use_expression == true){
						
					var detail_key  = _.find(task.eAnnotations.details,{"_key":"name"});
					if ( detail_key != null ){
						src = dfn_indent_write(indent); src += "v_pattern_str  += '(?P<" + detail_key._value +  ">'" ; sources.push(src);
					}
					var detail_regex  = _.find(task.eAnnotations.details,{"_key":"regex"});
					src = dfn_indent_write(indent); src += "v_pattern_str  += '" + detail_regex._value + "'" ;
					if ( detail_key != null )
						src += ")" ; 
					sources.push(src);				
				}
			};
	
			if( _.isArray(task.eAnnotations.details) ){
				dfn2_make_pattern(task);
			}
			
		};
	
		// to do make hierachy
		var dfn1_make_pattern = function(task){
			var fn_start_pattern = function(task){
	
			}
			
			var fn_task_pattern = function(task){
	
			}
	
		}
		
		var dfn1_make_pattern1 = function(task){					
			var indent = dfn_indent(task) ;
			if( _.isArray(task.eAnnotations.details) ){
				var v_use_expression = _.find(task.eAnnotations.details,{"_key":"keyword_use_expression"});
				if(v_use_expression != undefined && v_use_expression != null && v_use_expression._value == "true")
					task.keyword_use_expression = true;
			}
			if ( task.keyword_use_expression == true){
				src = dfn_indent_write(indent); src += "v_pattern_str  = ''" ; sources.push(src);
			}
		};
	
		var dfn1_make_pattern2 = function(task){					
			var indent = dfn_indent(task);
			if ( task.keyword_use_expression == true){
				src = dfn_indent_write(indent); src += "# " + task._name + " : pattern" ; sources.push(src);
				src = dfn_indent_write(indent); src += "v_pattern = re.compile(v_pattern_str)"; sources.push(src);
				src = dfn_indent_write(indent); src += "v_match = v_pattern.search(line)"; sources.push(src);
				src = dfn_indent_write(indent); src += "if match:"; sources.push(src);
				src = dfn_indent_write(indent + 1); src += "v_dic = v_match.groupdict()"; sources.push(src);
			}
			
		};
	
		var dfn1_start = function(process){
			var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
			var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
			var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
			dfn1_task(process,target_task);
		};
	
		var dfn1_task = function(process,task){
			dfn1_comment(task);
			
			// use expression
			dfn1_make_pattern1(task);
			dfn1_detail_variable(task);
			if(task.flowElements != undefined){
				dfn1_start(task);
			}
			dfn1_make_pattern2(task);
			var v_indent = dfn_indent(task) + 1;
			dfn_data_output(task, v_indent);
	
			// end Process
			if(task["_outgoing"] == undefined){
				return;
			}
	
			// --- next task ------- //
			// sequence
			// var sequence = _.find(process.flowElements,{"_xmi:id": task["_outgoing"]});
			// dfn_process_sequence(process, task, sequence);
			var sequences = _.filter(process.flowElements,function(el){
				if(task["_outgoing"].match(el["_xmi:id"]) != null )
					return true;
			});
			$.each(sequences,function(i,sequence){
				var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
				dfn1_task(process,target_task);
			});
			
		};
	
		if( _.isArray(task.eAnnotations.details)){
			var openFile = _.find(task.eAnnotations.details,{"_key":"keyword_open_file"});
			var ext = _.find(task.eAnnotations.details,{"_key":"keyword_file_ext"});
			if ( openFile != null && ext != null && ext._value == 'txt'){
				var indent = dfn_indent(task);
				var filePath = _.find(task.eAnnotations.details,{"_key":"keyword_file_path"});						
				src = dfn_indent_write(indent) + "f = open(" + fn_keyward_variable( task, filePath ) + ", 'r')" ; sources.push(src);
				src = dfn_indent_write(indent) + "for line in f:" ; sources.push(src);						
				if(task.flowElements != undefined){
					dfn1_start(task);
				}
				
	
			}
			
		}
	}
	
	var dfn_start = function(process){
		var start = _.find(process.flowElements,{"_xsi:type": "bpmn2:StartEvent"});
		var sequence = _.find(process.flowElements,{"_xmi:id": start["_outgoing"]});
		var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
		dfn_task(process,target_task);
	}
	var dfn_task = function(process,task){
		dfn_comment(task);
		dfn_detail_variable(task);
		dfn_split_string(task);
		dfn_txt_file_parsing(task);
		dfn_loop(task);
		
		if(task.flowElements != undefined){
			// task.parent = process;
			var keyword_subtask_skip = _.find(task.eAnnotations.details,{"_key":"keyword_subtask_skip"});
			if ( keyword_subtask_skip == undefined ||  keyword_subtask_skip == null || keyword_subtask_skip._value != "true" )
				dfn_start(task);
		}			

		dfn_data_output(task);

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
			dfn_process_sequence(process, task, sequence);
			var target_task = _.find(process.flowElements,{"_xmi:id": sequence["_targetRef"]});
			dfn_task(process,target_task);

		});
		

		
	}

	dfn_start(top_resource.process);
	
}

		