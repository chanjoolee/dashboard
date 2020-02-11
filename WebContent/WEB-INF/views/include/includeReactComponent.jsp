<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script type="text/babel">
	var Greeting = React.createClass({
	  render: function() {
	    return (
	      <p>Hello, Universe {this.props.name}</p>
	    )
	  }
	});

	
	
	window.fn_greeting=function(vLabel){
		ReactDOM.render(
		  <Greeting />,
		  document.getElementById('div1')
		);
	}
	
	class ContactInfo extends React.Component {
	    render() {
	        return(
	            <li>{this.props.name} {this.props.phone}</li>
	            );
	    }
	}
	
	class App extends React.Component {
	    render(){

	        return (
	                <Contacts/>
	        );
	    }
	}
	
	class Contacts extends React.Component {
	    constructor(props) {
	        super(props);
	        this.state = {
	            contactData: [
	                {name: "Abet", phone: "010-0000-0001"},
	                {name: "Betty", phone: "010-0000-0002"},
	                {name: "Charlie", phone: "010-0000-0003"},
	                {name: "David", phone: "010-0000-0004"}
	            ]
	        };
	    }
	    render(){
	        return(
	            <div>
	                <h1>Contacts</h1>
	                <ul>
	                    {this.state.contactData.map((contact, i) => {
	                        return (<ContactInfo name={contact.name}
	                                            phone={contact.phone}
	                                              key={i}/>);
	                    })}
	                </ul>
	            </div>
	        );
	    }
	}

	
	//ReactDOM.render(<App />, document.getElementById('div2'));
	
	window.fn_contacts=function(){
		ReactDOM.render(<App />, document.getElementById('div2'));
	}
	
	
	class Td extends React.Component {
		
		constructor(props) {
	        super(props);
	        // Configure default state
			this.state = this.props.options;
			//this.dblclick.bind(this);
			this.changeHandler = this.changeHandler.bind(this);
	    }
	    
	    dblclick(){
	    	//if(this.state.editable == true)
	    	//	this.setState({mode: "edit"});
	    }
	    
	    confirm(){
	    	this.props.options.fn_submit.call(this);
	    	this.setState({mode: "read"});
	    }
	    
	    cancel(){
	    	this.setState({value: this.props.options.value});
	    	this.setState({mode: "read"});
	    }
	    
	    changeHandler(e){
			// console.log(e.target);
			if( $(e.target).hasClass("search-str"))
				this.setState({search_str: e.target.value });
			else{
				this.setState({value: e.target.value });				
			}
			this.props.options.fn_change.call(this, e.target.value);
				
			
				    	
		}
		
		fn_pop_select(e){
			// alert("buttonClick");
	    	// this.setState({value: e.target.value });
			// this.props.options.fn_change.call(this, e.target.value);
			this.props.options.fn_pop_select.call(this, e);
				    	
	    }
	    
	    fn_manual_attach(e){
			// alert("buttonClick");
	    	// this.setState({value: e.target.value });
			// this.props.options.fn_change.call(this, e.target.value);
			this.props.options.fn_manual_attach.call(this, e);
				    	
	    }
	    
	    render(){
	    	
	    	if(this.props.options.editable == false || this.state.mode == "read"){
				if(this.props.options.edit_tag == "select"){
					return (
					<div style={{width:"100%",height:"100%"}} onDoubleClick={this.dblclick.bind(this)}>
						{this.props.options.selectOptions.map(opt => {
							if ( this.state.value == opt.value){
								return ( <div> {opt.label} </div> );
							}
							
						})}
					</div>
					);
				} else {
					return (
					<div style={{width:"100%",height:"100%"}} onDoubleClick={this.dblclick.bind(this)}>
						{this.state.value}
					</div>
	        		);
				} 
	    		
	    	}else if(this.state.mode == "edit") {	  
	    		if(this.state.edit_tag == "textarea"){
	    			return (
			    		<div>
							<textarea className="form-control" style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value }/>
						</div>
					);
	    		}else if(this.state.edit_tag == "select1") {
					return (
						<div>
							<select className="form-control" onChange={this.changeHandler.bind(this)} value={this.state.value } >
								<option value="grapefruit">Grapefruit</option>
								<option value="lime">Lime</option>
								<option value="coconut">Coconut</option>
								<option value="mango">Mango</option>
							</select>
						</div>

					);
				}else if(this.state.edit_tag == "select") {
					return (
						<div>
							<select  className="form-control" style={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value }>
								<option value="">SELECT</option>
								{this.props.options.selectOptions.map(opt => {
									return (
										<option key={opt.value} value={opt.value}>{opt.label}</option>
									);
								})}
							</select>
						</div>

					);
				}else if(this.state.edit_tag == "radio") {
					return (
						<div className="radio">
							{this.props.options.selectOptions.map(opt => {
								var v_checked = false;
								if ( opt.value === this.state.value)
									v_checked = true;
								
								
								return (
									<label className="radio-inline">
										<input 
										type="radio" 
										className="radio"
										name={this.state.name}
										value={opt.value}
										onChange={this.changeHandler.bind(this)}
										checked={v_checked}
										/>
										{opt.label}
									</label>
								);
							})}
						</div>

					);
				}else if(this.state.edit_tag == "pop_select"){
					return (
						<div custom-attribute="some-value">
							<input 
								type="text" 
								name={this.props.options.name} 
								onChange={this.changeHandler.bind(this)} 
								value={this.state.value}></input>
							<input 
								type="hidden" 
								name={this.props.options.name +"_search"} 
								onChange={this.changeHandler.bind(this)} 
								className="form-control search-str" 
								style={{width:'70%', display:'inline-block'}} 
								value={this.state.search_str}
							>
							</input>
							<button 
								type="button" 
								className="btn btn-warning btn-sm" 
								style={{marginBottom: '5px' , marginLeft: '3px'}} 
								onClick={this.fn_pop_select.bind(this)}
							>{this.state.btn_label}</button>
						</div>

					);
				}else if(this.state.edit_tag == "manual_attach"){
					return (
						<div custom-attribute="some-value">
							<button 
								type="button" 
								className="btn btn-warning btn-sm" 
								style={{marginBottom: '5px' , marginLeft: '3px'}} 
								onClick={this.fn_manual_attach.bind(this)}
							>{this.state.btn_label}</button>
						</div>

					);
				}else if(this.state.edit_tag == "hidden"){
					return (
						<div>
							<input type="hidden"  
								onChange={this.changeHandler.bind(this)} 
								value={this.state.value}
							>
							</input>
						</div>
					);
				}else if(this.state.edit_tag == "file"){
					return (
						<div>
							<input 
								name={this.props.options.name}
								type="file"  
								onChange={this.changeHandler.bind(this)} 
								value={this.state.value}
							>
							</input>
						</div>
					);
				}else{
	    			return (
			    		<div>
							<input className="form-control" styles={this.props.options.edit_style} onChange={this.changeHandler.bind(this)} value={this.state.value}></input>
						</div>
					);
	    		}		
	    		
				
	    	}
	        
	            
	    }
	}
	
	window.fn_td = function(cell, options){
		return ReactDOM.render(<Td options={options}/>, cell);
	}
	
</script>		
		