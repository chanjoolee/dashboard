package dashboard.relevant.service;

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
public class RelevantService {

    @Autowired
    private CommonDao dao;
    @Autowired
    private PmsDao pmsDao;
    
    @SuppressWarnings("rawtypes")
	public Map selectOne(String statement,Object parameter) {
        return (Map)dao.selectOne(statement, parameter);
    }
    
    
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> relevantList(Map<Object, Object> parameter) {
    	List list = (List)pmsDao.selectList("dashboard.relevant.relevantList", parameter);
		return list;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> schedule(Map<Object, Object> parameter) {
    	List list = (List)pmsDao.selectList("pms.schedule.datalist", parameter);
		return list;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> spec(Map<Object, Object> parameter) {
    	List list = (List)pmsDao.selectList("dashboard.relevant.spec", parameter);
		return list;
	}
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public List<?> holds(Map<Object, Object> parameter) {
    	List list = (List)pmsDao.selectList("dashboard.relevant.hols", parameter);
		return list;
	}
    
   
	
}
