package dashboard.backbone.service;

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
public class BacboneService {

    @Autowired
    private CommonDao dao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> dashboardProjectList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("backbone.projects", parameter);
		return list;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public void dashboardProjectUpdate(Map<Object, Object> parameter) {
		dao.update("backbone.project.update", parameter);
	}
    
	
	
	
}
