function genInstance(_entityId, _type,  _list_instance ){
    this.entityId = _entityId;
    this.type = _type;
    this.list_instance = _list_instance;
    this.jpaFile = _.find( this._list_instance.jpaFile , { entityId : this.entityId, editType: this.type });
    this.containerId = "div_" + this.entityId + "_"+ this.type ; 
    this.searchContainerId = this.containerId + "_search";
    this.gridCotainerId = this.containerId + "_grid";
    this.container = $("<div/>",{id:  this.containerId });
    this.list_instance.container.append(this.container);
    this.searchContainer = null;
    this.gridCContainer = null;
    
    
    // 어떤식으로 입력을 할 것인가?  
    // div에 소스를 생성하는 방식으로?
    // ==> 이것은 커스터마이징을 할 수 있도록 한다. 
    // schema를 바탕으로 자동으로 생성을 한다?
    // ==> 일단은 이것으로 한다.
    // 이것을 완성 한 다음 div 에 소스를 generating 하는 방식으로 한다.

    // containert 안에 그린다.
    // 01. search
    this.makeSearch();
    // 02. grid
    this.makeGrid();

}

genInstance.prototype.makeSearch = function(){
    var _this = this;
    var searchContainer = $("<div/>",{id: this.searchContainerId});
    this.container.append(searchContainer);
    var schema = this.jpaFile.schema.search.schema ;
    var makehtml = new makeHtmlBySchema( this.searchContainer , schema , this );
}

genInstance.prototype.makeGrid = function(){
    var _this = this;
    var searchContainer = $("<div/>",{id: this.searchContainerId});
    this.container.append(searchContainer);
    var schema = this.jpaFile.schema.contents.schema ;
    var makehtml = new makeHtmlBySchema( this.searchContainer , schema , this );
}