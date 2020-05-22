function SqlGenerator(file_name, _generator, _jspInstance){
    var _this = this;
    this.generator = _generator;
    this.fileName = file_name;
    this.processes = this.generator.processes;
    this.jspInstance = _jspInstance;
    this.process = this.jspInstance.process;
    
    this.sqls = [];
    // [
    //     {
    //         id:'xxx',
    //         type:'select'
    //         contents: []
    //     }
    // ]
    this.sources = [];
}

SqlGenerator.prototype.fn_generate = function(){
    var _this = this;
    var src = '<?xml version="1.0" encoding="UTF-8"?>'; this.sources.push(src);
    src = '<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">'; this.sources.push(src);
    src = '<mapper namespace="">'; this.sources.push(src);
    $.each(_this.sqls, function(i,sql){
        if(sql.type == "select" ){
            if(sql.jsp_type == "grid"){
                var src = "";
                //////////////////// page list
                src = '<' + sql.type + ' id="'+ sql.id + '.page.list"' ;
                if ( sql.type =="select")  
                    src += ' resultType="hashmap" >';  
                _this.sources.push(src);
                // include head
                src = $("#pagelistHead").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                $.each(sql.contents, function(j,content){
                    src = "\t" + content ; _this.sources.push(src);
                });
                $.each(sql.wheres, function(j,where){
                    src = "\t" + where ; _this.sources.push(src);
                });
                // jstree
                src = $("#jstreeSearch").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                //  include foot
                src = $("#pagelistFooter").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                src = '</' + sql.type + '>'; _this.sources.push(src);
                
                
                /////////////////// page total
                src = '<' + sql.type + ' id="'+ sql.id + '.page.total"' ;
                if ( sql.type =="select")  
                    src += ' resultType="hashmap" >';  
                _this.sources.push(src);
                // include head
                src = $("#pageTotalHead").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                $.each(sql.contents, function(j,content){
                    src = "\t" + content ; _this.sources.push(src);
                });
                $.each(sql.wheres, function(j,where){
                    src = "\t" + where ; _this.sources.push(src);
                });
                //  include foot
                src = $("#pageTotalFooter").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                src = '</' + sql.type + '>'; _this.sources.push(src);

                

                ////////////////////// detail one select
                src = '<' + sql.type + ' id="'+ sql.id + '.one"' ;
                if ( sql.type =="select")  
                    src += ' resultType="hashmap" >';  
                _this.sources.push(src);
                // include head
                $.each(sql.contents, function(j,content){
                    src = "\t" + content ; _this.sources.push(src);
                });
                $.each(sql.wheres, function(j,where){
                    src = "\t" + where ; _this.sources.push(src);
                });
                //  include foot
                src = '</' + sql.type + '>'; _this.sources.push(src);


                ////////////////////// detail edit
            } else {
                src = '<' + sql.type + ' id="'+ sql.id + '" resultType="hashmap" >' ;
                _this.sources.push(src);
                $.each(sql.contents, function(j,content){
                    src = "\t" + content ; _this.sources.push(src);
                });
                $.each(sql.wheres, function(j,where){
                    src = "\t" + where ; _this.sources.push(src);
                });
                src = '</' + sql.type + '>'; _this.sources.push(src);
            }
        }else if (sql.type == 'insert'){
            src = '<update id="'+ sql.id + '" parameterType="hashmap" >' ;            
            _this.sources.push(src);
            $.each(sql.contents, function(j,content){
                src = "\t" + content ; _this.sources.push(src);
            });
            src = '</update>'; _this.sources.push(src);
        }else if (sql.type == 'update'){
            src = '<update id="'+ sql.id + '" parameterType="hashmap" >' ;
            
            _this.sources.push(src);
            $.each(sql.contents, function(j,content){
                src = "\t" + content ; _this.sources.push(src);
            });
            src = '</update>'; _this.sources.push(src);
        }
        
    });
    src = '</mapper>'; this.sources.push(src);

}


function SqlGeneratorAll( _fileObj ){
    var _this = this;    
    this.fileName = _.camelCase( _fileObj.fileName + '_Sql') + ".xml";
    if(_fileObj.entity_doc_obj.dbType != null){
        this.dbType = _fileObj.entity_doc_obj.dbType;
    }else{
        this.dbType = "oracle";
    }
    // middle stage
    this.sqls = [];   
    // [
    //     {
    //         id:'xxx',
    //         type:'select'
    //         contents: []
    //     }
    // ] 

    // final stage
    this.sources = [];        
}

SqlGeneratorAll.prototype.fn_generate = function(){
    var _this = this;
    var src = '<?xml version="1.0" encoding="UTF-8"?>'; this.sources.push(src);
    src = '<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">'; this.sources.push(src);
    src = '<mapper namespace="">'; this.sources.push(src);
    $.each(_this.sqls, function(i,sql){
        if(sql.type == "select" ){
            if(sql.jsp_type == "grid"){
                var src = "";
                //////////////////// page list
                src = '<' + sql.type + ' id="'+ sql.id + '.page.list"' ;
                if ( sql.type =="select")  
                    src += ' resultType="hashmap" >';  
                _this.sources.push(src);
                // include head
                
                src = $("#pagelistHead"+ _.capitalize(_this.dbType)).text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                $.each(sql.contents, function(j,content){
                    src = "\t" + content ; _this.sources.push(src);
                });
                $.each(sql.wheres, function(j,where){
                    src = "\t" + where ; _this.sources.push(src);
                });
                // jstree
                src = $("#jstreeSearch").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                //  include foot
                src = $("#pagelistFooter" + _.capitalize(_this.dbType)).text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                src = '</' + sql.type + '>'; _this.sources.push(src);
                
                
                /////////////////// page total
                src = '<' + sql.type + ' id="'+ sql.id + '.page.total"' ;
                if ( sql.type =="select")  
                    src += ' resultType="hashmap" >';  
                _this.sources.push(src);
                // include head
                src = $("#pageTotalHead").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                $.each(sql.contents, function(j,content){
                    src = "\t" + content ; _this.sources.push(src);
                });
                $.each(sql.wheres, function(j,where){
                    src = "\t" + where ; _this.sources.push(src);
                });
                // jstree
                src = $("#jstreeSearch").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                //  include foot
                src = $("#pageTotalFooter").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);
                
                src = '</' + sql.type + '>'; _this.sources.push(src);




                ////////////////////// detail one select
                src = '<' + sql.type + ' id="'+ sql.id + '.one"' ;
                if ( sql.type =="select")  
                    src += ' resultType="hashmap" >';  
                _this.sources.push(src);
                // include head
                $.each(sql.contents, function(j,content){
                    src = "\t" + content ; _this.sources.push(src);
                });
                $.each(sql.wheres, function(j,where){
                    src = "\t" + where ; _this.sources.push(src);
                });
                //  include foot
                src = $("#jstreeSearch").text().replace(/@{/g,"#{").replace(/!{/g,"${");   _this.sources.push(src);

                src = '</' + sql.type + '>'; _this.sources.push(src);


                ////////////////////// detail edit
            } else {
                src = '<' + sql.type + ' id="'+ sql.id + '" resultType="hashmap" >' ;
                _this.sources.push(src);
                $.each(sql.contents, function(j,content){
                    src = "\t" + content ; _this.sources.push(src);
                });
                $.each(sql.wheres, function(j,where){
                    src = "\t" + where ; _this.sources.push(src);
                });
                src = '</' + sql.type + '>'; _this.sources.push(src);
            }
        }else if (sql.type == 'insert'){
            src = '<update id="'+ sql.id + '" parameterType="hashmap" >' ;            
            _this.sources.push(src);
            $.each(sql.contents, function(j,content){
                src = "\t" + content ; _this.sources.push(src);
            });
            src = '</update>'; _this.sources.push(src);
        }else if (sql.type == 'update'){
            src = '<update id="'+ sql.id + '" parameterType="hashmap" >' ;
            
            _this.sources.push(src);
            $.each(sql.contents, function(j,content){
                src = "\t" + content ; _this.sources.push(src);
            });
            src = '</update>'; _this.sources.push(src);
        }
        
    });
    src = '</mapper>'; this.sources.push(src);

}