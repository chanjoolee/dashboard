package dashboard.service;

import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.dao.CommonDao;
import dashboard.controller.ProjectListByJsonController;

@Service
public class ComplexService {

    @Autowired
    private CommonDao dao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
    /**
     * 시리즈데이타를 return한다.
     * @param statement
     * @param parameter
     * @return
     */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public String selectSeries(Object parameter) {
		
		List series = (List)dao.selectList("dashboard.series", parameter);
		for(int i=0;i<series.size();i++){
			Map s = (Map)series.get(i);
			
			String dataSql = "dashboard.series.data";
			List data = selectSeriesData(dataSql, s);
			s.put("data", data);
		}
		
		JSONArray jarray = JSONArray.fromObject(series);
		return jarray.toString();
    }	
	
	@SuppressWarnings("rawtypes")
    public List selectSeriesData(String statement,Object parameter) {
        return (List)dao.selectList(statement, parameter);
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectSeriesByJson(Object parameter) {
		
		List series = (List)dao.selectList("dashboard.series", parameter);
		for(int i=0;i<series.size();i++){
			Map s = (Map)series.get(i);
			
			String dataSql = "dashboard.series.data";
			List data = selectSeriesData(dataSql, s);
			s.put("data", data);
		}
		
		return series;
    }	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectCategoriesByJson(Object parameter) {
		List series = (List)dao.selectList("dashboard.series.data.categories", parameter);
		return series;
    }	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectProjectList(Map parameter) {
		List projectList = null;
		if(parameter.get("division") != null){
	   		 if(parameter.get("division").toString().equals("jira"))
	   			 projectList = (List)dao.selectList("dashboard.project.list.jira", parameter);
	   	}else{
	   		projectList = (List)dao.selectList("dashboard.project", parameter);
	   	}
		
		return projectList;
    }	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectProjectListSub(Map parameter) {
		List projectList = null;
		if(parameter.get("division") != null){
	   		 if(parameter.get("division").toString().equals("jira"))
	   			 projectList = (List)dao.selectList("dashboard.project.list.sub.jira", parameter);
	   	}else{
	   		projectList = (List)dao.selectList("dashboard.project.sub", parameter);
	   	}
		
		return projectList;
    }	
	
	/**
	 * codenoar projectCode Mapping 리스트
	 * @param parameter
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectProjectMappingList(Map parameter) {
		List projectList = null;
		projectList = (List)dao.selectList("dashboard.codesonar.mappiglist", parameter);
		
		return projectList;
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectProjectPCountData(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.project.pcount", parameter);
		return projectList;
    }	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectCodesonarPriorityCsvLink(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.codesonar.csvnum", parameter);
		return projectList;
    }	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List jiraPkeyLink(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.jira.pkey", parameter);
		return projectList;
    }	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectProjectMultiRaw(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.project.multi.raw", parameter);
		return projectList;
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectProjectMultiCount(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.project.multi.count", parameter);
		return projectList;
    }
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectProjectMultiPhase(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.project.multi.phase", parameter);
		return projectList;
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectProjectPhase(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.project.phase", parameter);
		return projectList;
    }
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectSummaryDashboard(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.summary.list", parameter);
		return projectList;
    }
	
	
	/**
	 * 
	 * @param parameter
	 * @return List
	 * 
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectCodeReview(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.codereview.list", parameter);
		return projectList;
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectDefectsTrends(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.defectsTrends.list", parameter);
		return projectList;
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectDefectsTrendsIssueType(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.defectsTrends.issuetype", parameter);
		return projectList;
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectDefectsTrendsPriority(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.defectsTrends.priority", parameter);
		return projectList;
    }
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectIssueUnresolved(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.defectsUnresolved", parameter);
		return projectList;
    }

	@SuppressWarnings({ "rawtypes", "unchecked" })
    public List selectIssueUnresolvedPie(Object parameter) {
		List projectList = (List)dao.selectList("dashboard.defectsUnresolved.pie", parameter);
		return projectList;
    }

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectPmsModel(Map<String, Object> parameter) {
		List list = (List)dao.selectList("dashboard.pms.model", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectPmsProject(Map<String, Object> parameter) {
		List list = (List)dao.selectList("dashboard.pms.project", parameter);
		return list;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> dashboardProjectList(Map<String, Object> parameter) {
		List list = (List)dao.selectList("dashboard.dashboard.project", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getJiraPjtCodeByPmsInterface(Map<Object, Object> parameter) {
		Map map = (Map)dao.selectOne("dashboard.pjtcode.byPmsInterface.jira", parameter);
		return map;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getCodesonarPjtCodeByPmsInterface(Map<Object, Object> parameter) {
		Map map = (Map)dao.selectOne("dashboard.pjtcode.byPmsInterface.codesonar", parameter);
		return map;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getJiraAverageTat(Map<Object, Object> parameter) {
		Map map = (Map)dao.selectOne("dashboard.jira.tat.average", parameter);
		return map;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getSavedSearchCondiion(Map<Object, Object> parameter) {
		Map map = (Map)dao.selectOne("dashboard.searchCondition.select", parameter);
		return map;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int saveSearchCondition(Map<Object, Object> parameter) {
		int update =dao.update("dashboard.searchCondition.save", parameter);
		return update;
	}
	
}
