package dashboard.jiraIssue.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;
import common.dao.PmsDao;

@Service
public class JiraIssueService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private PmsDao pmsdao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectJiraIssueFunctionRootCause(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraIssue.FunctionRootCause", parameter);
		return list;
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectJiraIssuePhaseCauseList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraIssue.PhaseCauseList", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssueCauseMatrixListJson(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraIssue.CauseMatrixList", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssueCauseStatusListJson(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraIssue.CauseStatusList", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssueRootCauseTatJson(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraIssue.RootCauseTat", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssuePhaseTatJson(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraIssue.PhaseTat", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssueProjectDefectJson(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraIssue.ProjectDefect", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssueProjectDefectSubJson(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraIssue.ProjectDefectSub", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssueProjectDefectRawDataJson(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraIssue.ProjectDefect.rawdata", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssueHmsListForGraph(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraissue.hms.list.for.graph", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssueHmsListForGrid(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraissue.hms.list.for.grid", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraProjects(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraissue.hms.list.projects", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraProjectComponents(Map<Object, Object> parameter) {
		List list = (List)pmsdao.selectList("jiraissue.hms.component.list", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraProjectHmsListForGrid(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraissue.hms.list.for.grid", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraProjectHmsDetailListForGrid(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraissue.hms.list.for.grid.detail", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraProjectHmsListForGraph(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraissue.hms.list.for.graph", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraIssueType(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("jiraissue.hms.issuetype.list", parameter);
		return list;
	}
}
