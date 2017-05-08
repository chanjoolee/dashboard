package dashboard.jira.service;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;
import common.dao.PmsDao;
import common.service.CommonService;
import dashboard.controller.ProjectListByJsonController;

@Service
public class JiraService {

    @Autowired
    private CommonDao dao;
    
    @Autowired
    private PmsDao pmsDao;
    
    @Autowired
    private CommonService commonService;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectIssueFromResolution(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.jira.field.issuefrom.resolution.group", parameter);
		return list;
	}
    
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectRootCauseGroup(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.jira.field.cause.group", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectDiscoveredResolution(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.jira.discovered.resolution.group", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectRawList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.jira.field.raw.list", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectJiraProjectList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.jira.field.jiraprojectList", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> jiraAnalysisByDateIssueType(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.jira.analysis.date.issutype", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> usageList(Map<Object, Object> parameter) {
		List list = (List)pmsDao.selectList("dashboard.jira.usage.list", parameter);
		return list;
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String,Object> usageListPage(Map<Object, Object> parameter) {
		Map map = (Map)pmsDao.selectOne("dashboard.jira.usage.list.page", parameter);
		return map;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> confUsageList(Map<Object, Object> parameter) {
		List list = (List)pmsDao.selectList("dashboard.confluence.usage.list", parameter);
		return list;
	}	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String,Object> confUsageListPage(Map<Object, Object> parameter) {
		Map map = (Map)pmsDao.selectOne("dashboard.confluence.usage.list.page", parameter);
		return map;
	}
	
	
}
