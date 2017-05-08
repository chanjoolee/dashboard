package dashboard.deliverable.service;

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
public class DeliverableService {

    @Autowired
    private PmsDao dao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> participateProjects(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("deliverable.participationProject", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getParticipateProjectData(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("deliverable.allproject.participation", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> getProjectFunction(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("deliverable.project.function", parameter);
		return list;
	}
	
	
}
