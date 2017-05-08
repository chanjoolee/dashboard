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
import common.dao.PmsDao;
import dashboard.controller.ProjectListByJsonController;

@Service
public class PmsService {

    @Autowired
    private PmsDao dao;
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pmstest(Map<String, Object> parameter) {
		List list = (List)dao.selectList("pms.test", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pmsResource(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.resource", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pmsResourceSubfunc(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.resource.subfunc", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pmsResourceProject(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.resource.project", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getPhaseList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.phase", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pmsResourcePlan(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.resource.plan", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pmsResourcePlanFcst(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.resource.plan.fcst", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pmsResourceModel(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.resource.model", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pmsResourceProjectAll(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.resource.projectall", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> pmsResourceSiteAll(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.resource.siteall", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectRscSearch(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.resource.searchList", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectTat(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("pms.tat.datalist", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectTatModel(Map<Object, Object> parameter) {
		//List list = (List)dao.selectList("pms.tat.datalist.model", parameter);
		List list = (List)dao.selectList("pms.tat.datalist", parameter);
		return list;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map getPjtInterfaceJiraFromPmsPjtId(Map<Object, Object> parameter) {
		Map map = (Map)dao.selectOne("pms.pjt.interface.jira", parameter);
		return map;
	}
	
	
}
