function gen_instance_list(_container , JpaFiles ){
    this.list = [];
    
    this.container = _container;
    // general 인경우 container를 초기화 한다.
    this.container.html(""); 
    this.jpaFiles = JpaFiles;

}


gen_instance_list.prototype.add_instance = function( _entityId, _type , _option){
    var _this = this;
    var newInstance = null;
    
    if( _type == 'general'){
        newInstance = new genInstance(_entityId, _type , _this ,_option);
    }else if ( _type == 'add'){
        newInstance = new genInstanceAdd(_entityId, _type , _this ,_option);
    }
    
    _this.list.push(newInstance);
}

