package dashboard.regression.service;

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
public class RegressionTestService {

    @Autowired
    private CommonDao dao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
   
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectDataRegressionProject(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.project", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> regressionProjectList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.projectlist", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectDataRegressionRevision(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.revision", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectDataRegressionCategory(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.category", parameter);
		return list;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> selectDataRegressionCategoryList(Map<Object, Object> parameter) {
		List list = (List)dao.selectList("dashboard.regresson.category.list", parameter);
		return list;
	}
	
	
}
