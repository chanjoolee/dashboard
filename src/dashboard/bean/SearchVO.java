package dashboard.bean;

import java.util.List;
import java.util.Map;


public class SearchVO {
	
	private List<String> priority;
	private List<String> issuetype;
	private Map<String,Object> vo;
	
		
	public List<String> getPriority() {
		return priority;
	}
	public void setPriority(List<String> priority) {
		this.priority = priority;
	}
	public List<String> getIssuetype() {
		return issuetype;
	}
	public void setIssuetype(List<String> issuetype) {
		this.issuetype = issuetype;
	}
	public Map<String, Object> getVo() {
		return vo;
	}
	public void setVo(Map<String, Object> vo) {
		this.vo = vo;
	}
	
	
}
